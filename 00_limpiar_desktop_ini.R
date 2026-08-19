# Limpiar archivos desktop.ini -------------------------------------------------
#
# Google Drive o el Explorador de Windows pueden crear `desktop.ini` dentro de
# las carpetas del proyecto. Si aparecen dentro de `.git/refs`, Git los confunde
# con referencias y GitHub Desktop deja de funcionar.
#
# Esta etapa elimina unicamente archivos cuyo nombre sea exactamente
# `desktop.ini` (sin importar mayusculas o minusculas). No elimina carpetas ni
# otros archivos `.ini`.

limpiar_desktop_ini <- function(ruta = ".") {
  raiz <- normalizePath(ruta, winslash = "/", mustWork = TRUE)

  archivos <- list.files(
    path = raiz,
    pattern = "^desktop\\.ini$",
    recursive = TRUE,
    full.names = TRUE,
    all.files = TRUE,
    ignore.case = TRUE,
    include.dirs = FALSE,
    no.. = TRUE
  )

  if (length(archivos) == 0L) {
    message("Limpieza desktop.ini: no se encontraron archivos.")
    return(invisible(character(0)))
  }

  eliminados <- archivos[file.remove(archivos)]
  no_eliminados <- setdiff(archivos, eliminados)

  message("Limpieza desktop.ini: ", length(eliminados), " archivo(s) eliminado(s).")

  if (length(no_eliminados) > 0L) {
    warning(
      "No se pudieron eliminar ", length(no_eliminados),
      " archivo(s) desktop.ini:\n",
      paste(no_eliminados, collapse = "\n")
    )
  }

  invisible(eliminados)
}

limpiar_desktop_ini(".")
