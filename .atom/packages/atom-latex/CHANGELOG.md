## [0.7.4]  2017-03-27
### Changed
* [(#32)](https://github.com/James-Yu/Atom-LaTeX/pull/32) Save all files before build.
* [(#31)](https://github.com/James-Yu/Atom-LaTeX/issues/31) Find local config use current active editor directory first.
* [(#30)](https://github.com/James-Yu/Atom-LaTeX/pull/30) Formatted PDF viewer title.
* Slightly adjust SyncTeX accuracy.

## [0.7.3]  2017-03-23
### Added
* [(#22)](https://github.com/James-Yu/Atom-LaTeX/issues/22) Add tikz and knitr syntax highlighting.

### Changed
* [(#25)](https://github.com/James-Yu/Atom-LaTeX/issues/25) [(#26)](https://github.com/James-Yu/Atom-LaTeX/pull/26) Remove pdf page borders.
* Hide PDF Viewer menus when possible.

## [0.7.2]  2017-03-19
### Added
* [(#21)](https://github.com/James-Yu/Atom-LaTeX/issues/21) A setting item to auto-collapse log panel upon successful building process.
* [(#22)](https://github.com/James-Yu/Atom-LaTeX/issues/22) Support LaTeX files with non-`.tex` extension.

### Changed
* [(#21)](https://github.com/James-Yu/Atom-LaTeX/issues/21) Now raw log will be contained in a temp file to avoid the save file popup.

### Fixed
* [(#20)](https://github.com/James-Yu/Atom-LaTeX/issues/20) `\begin` environment wrongly uses two spaces instead of `\t`.

## [0.7.1]  2017-03-15
### Added
* A setting item controlling the PDF viewer focus behavior.

### Changed
* [(#16)](https://github.com/James-Yu/Atom-LaTeX/issues/16) Tweak the PDF viewer gain focus behavior.

## [0.7.0]  2017-03-12
### Added
* [(#18)](https://github.com/James-Yu/Atom-LaTeX/issues/18) Per-project toolchain setting in `.latexcfg` file.

### Changed
* [(#16)](https://github.com/James-Yu/Atom-LaTeX/issues/16) The viewer window is bring to front after building process or SyncTeX.

### Fixed
* [(#4)](https://github.com/James-Yu/Atom-LaTeX/issues/4) Atom-LaTeX complaining `arara` returning `null`.

## [0.6.3]  2017-03-06
### Added
* A delay-minimap-refresh feature to prevent keystroke stuttering in long LaTeX files.

## [0.6.2]  2017-02-28
### Fixed
* Build-after-save not working.

## [0.6.1]  2017-02-28
### Changed
* [(#9)](https://github.com/James-Yu/Atom-LaTeX/issues/9) Use glob matching for cleaning project.
* [(#11)](https://github.com/James-Yu/Atom-LaTeX/issues/11) Dollar sign matching pattern.
* [(#12)](https://github.com/James-Yu/Atom-LaTeX/issues/12) Focus editor window after reverse synctex.
* Click on home icon of control bar to manually set root file.

### Fixed
* Significantly reduce loading time with lazy load.

## [0.6.0]  2017-02-23
### Added
* Clean LaTeX project command and auto-clean after build.

### Changed
* Also consider current buffer when generating command auto-complete.

## [0.5.8]  2017-02-22
### Changed
* Now Atom-LaTeX prioritize `.latexcfg` file over magic comments.

### Fixed
* Root file cannot have spaces in file name.

## [0.5.7]  2017-02-21
### Fixed
* bibtex file cannot be located elsewhere than the root directory.

## [0.5.6]  2017-02-21
### Fixed
* [(#6)](https://github.com/James-Yu/Atom-LaTeX/issues/6) bibtex file cannot include file extension.

## [0.5.5]  2017-02-21
### Fixed
* [(#6)](https://github.com/James-Yu/Atom-LaTeX/issues/6) `\addbibresource` is not considered as bibtex file definition command.

## [0.5.4]  2017-02-20
### Fixed
* LaTeX error does not show in panel when latexmk toolchain is used.

## [0.5.3]  2017-02-20
### Changed
* Better latexmk log message parsing.

## [0.5.2]  2017-02-19
### Changed
* [(#5)](https://github.com/James-Yu/Atom-LaTeX/issues/5) Remove default stdout buffer size limit.

## [0.5.1]  2017-02-17
### Changed
* Atom-LaTeX log area is now resizable.

## [0.5.0]  2017-02-16
### Changed
* Redesign Atom-LaTeX control panel.
* Move screencasts to a new file to avoid lag while loading settings.

## [0.4.5]  2017-02-15
### Changed
* LaTeX command autocompletion now also sort by the number of appearances.

## [0.4.4]  2017-02-13
### Changed
* Way of showing error notification.

## [0.4.3]  2017-02-09
### Changed
* Default command autocompletion is to create a new line.
* All default key binds to avoid conflict

### Fixed
* Not including new references in unsaved buffer.
* Not parsing fatal error LaTeX log.
* Mispositioned environment autocompletion items.

## [0.4.2]  2017-02-08
### Fixed
* Keymap not properly binded.
* TabView Panel undefined preventing switching preview mode.

## [0.4.1]  2017-02-08
### Added
* Better logging for main file detection.
* Two new methods to set LaTeX main file.

## [0.4.0]  2017-02-07
### Added
* Add a preview-in-tab PDF viewer.

### Fixed
* Remove console messages.

## [0.3.3]  2017-02-06
### Added
* Auto-enable word wrap.
* Allow `ctrl`+`/` for auto comment.

### Fixed
* Wrong direct synctex position when word wrap is on

## [0.3.2]  2017-02-06
### Fixed
* Unnecessary `\begin{\w+}` syntax highlight leading to typing lag.
* Escaped curly brackets in citation title should not be removed.

## [0.3.1]  2017-02-05
### Changed
* Command autocomplete will guess the number of curly brackets needed.

## [0.3.0]  2017-02-05
### Added
* Direct and reverse SyncTeX support.

### Changed
* Status bar now alerts LaTeX building warninngs.

### Fixed
* Pre-mature activation of package leading to significant startup time.

## [0.2.6]  2017-02-03
### Added
* Use npm package `latex-symbols-list` to develop more autocomplete symbols.

## [0.2.5]  2017-02-03
### Added
* Autocomplete for commands and environments.
  * Commands are gathered from all LaTeX source files in the project, and some predefined ones.
  * Environments are predefined.

### Changed
* Now autocomplete will sort according to prefix and displayed text.

## [0.2.4] - 2017-02-03
### Added
* A new `Build LaTeX from Active Editor` command to set main LaTeX file to current active editor if it contains `\begin{document}`, and start building.

## [0.2.3] - 2017-02-03
### Changed
* Use cached results for autocomplete when already typed some characters to reduce I/O operations.

### Fixed
* Autocomplete prefix is not removed after confirming a suggestion.

## [0.2.2] - 2017-02-02
### Added
* Screencasts of some select features.

## [0.2.1] - 2017-02-02
### Added
* Auto-complete for cross-references.

### Changed
* Now Atom-LaTeX will search all tex files recursively from the main file with `\input{}` commands.

## [0.2.0] - 2017-02-01
### Added
* Auto-complete for citations.
  * Atom-LaTeX will search all bibTeX files referenced in the main LaTeX file to develop bibitem keys.

### Fixed
* Now alerts when no main LaTeX file can be detected.
  * It will try to check the current active editor first. If not, all root files are checked.

## [0.1.1] - 2017-02-01
### Changed
* Create new Atom window to display PDF viewer.

### Fixed
* Menu items not working.

## [0.1.0] - 2017-01-31
### Added
* Initial release.