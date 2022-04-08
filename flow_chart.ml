```mermaid
graph TD
    A[json config] -->|SCP| F
    B -->|SCP| F
    C -->|SCP| F   
    B[python code]
    C[Training Data]
    D[RunTime Folder] 
    E[Completed Folder]
    F[UploadResource.sh]-->|Config, Code, Data|G
    F[UploadResource.sh]-->|Copy Config|D
    G(GPU SERVER)
    H[run.sh]-->|Move Executed Config|E 
    H[run.sh]-->|Trigger Python Per Config File|G 
    D -->|SUB FOLDER| E
```
    
