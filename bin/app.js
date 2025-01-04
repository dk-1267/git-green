import fs from 'fs';
import { exec } from 'child_process';

fs.appendFile('filename.txt', ' Appending some data.', (err) => {
    if (err) throw err;
    console.log('Data appended successfully!');
});


function runCommand(command) {
    return new Promise((resolve, reject) => {
      exec(command, (error, stdout, stderr) => {
        if (error) {
          console.error(`Error: ${error.message}`);
          return reject(error);
        }
        if (stderr) {
          console.error(`Stderr: ${stderr}`);
          return reject(stderr);
        }
        console.log(`Output: ${stdout}`);
        resolve(stdout);
      });
    });
  }

(async () => {
    try {
        console.log("Starting Git auto-commit process...");
    
        await runCommand("git add .");
        console.log("Staged changes.");
    
        const commitMessage = `Auto-commit: ${new Date().toISOString()}`;
        await runCommand(`git commit -m "${commitMessage}"`);
        console.log("Committed changes.");
    
        await runCommand("git push -u origin main");
        console.log("Pushed changes to the repository.");
      } catch (error) {
        console.error("Failed to complete auto-commit:", error);
      } finally {
        console.log('All commands executed.');
    }
})();
