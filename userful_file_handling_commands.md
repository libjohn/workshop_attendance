## useful file handling commands

### Environment variables

- getwd()
- setwd(dir)
- list.files()
- list.dir()
- normalizePath()

    - cat(normalizePath(c(R.home(), tempdir())), sep = "\n")
- tempdir()
- tempfile()

- Sys.getenv()

    - Sys.getenv("R_USER")
    - HOME         C:/Users/john/Documents
    - HOMEDRIVE    C:
    - HOMEPATH     \Users\john
- Sys.getenv("R_TEST")
- Sys.setenv
- Sys.unsetenv("R_TEST")  # may warn and not succeed
- Sys.getenv("R_TEST", unset = NA)
- EnvVar

## low-level file system info

- files2()
    - https://stat.ethz.ch/R-manual/R-devel/library/base/html/files2.html
- file.info(dir())
    - https://stat.ethz.ch/R-manual/R-devel/library/base/html/file.info.html

- files {base}	R Documentation File Manipulation
- Description:  functions provide a low-level interface to the computer's file system.
- Usage

    - file.create(..., showWarnings = TRUE)
    - file.exists(...)
    - file.remove(...)
    - file.rename(from, to)
    - file.append(file1, file2)
    - file.copy(from, to, overwrite = recursive, recursive = FALSE, copy.mode = TRUE, copy.date = FALSE)
    - file.symlink(from, to)
    - file.link(from, to)
    
- file.path {base}


    