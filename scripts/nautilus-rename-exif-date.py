import EXIF
import mimetypes
import nautilus
import os
import urllib


FORMATS = ["image/jpeg", "image/tiff"]


def process(dir_name, supported):
    """If it's a supported file, add its path to the list.If it's a directory,
    add recursively all its supported files."""
    content = os.listdir(dir_name)
    for file_name in content:
        path = os.path.join(dir_name, file_name)
        if mimetypes.guess_type(path)[0] in FORMATS:
            supported.append(path)
        elif os.path.isdir(path):
            supported = process(path, supported)

    return supported


class RenameExifDateExtension(nautilus.MenuProvider):
    def __init__(self):
        self.file_names = []


    def menu_activate_cb(self, menu, names):
        """Called when the user selects the menu. Rename the selected files."""
        for path in names:
            img_file = open(path, "rb")
            tags = EXIF.process_file(img_file)
            date = str(tags["EXIF DateTimeOriginal"]).replace(":", "-", 2)
            date = date.replace(":", "h", 1)
            date = date.replace(":", "m", 1)
            date = date.replace(":", "s", 1)

            dir_name = os.path.split(path)[0]
            file_name = os.path.split(path)[1]
            parts = file_name.split(".")
            if len(parts) == 1:
                extension = ""
            else:
                extension = "." + parts[-1]
            os.rename(path, dir_name + "/" + date + extension)


    def get_file_items(self, window, files):
        """Called when the user selects a file in Nautilus. We want to check
        whether those are supported files or directories with supported files."""
        supported = []
        for f in files:
            if f.get_mime_type() in FORMATS:
                name = urllib.unquote(f.get_uri()[7:])
                supported.append(name)
            elif f.is_directory():
                supported = process(urllib.unquote(f.get_uri()[7:]), supported)

        if not supported:
            return

        have_exif = False
        for path in supported:
            img_file = open(path, "rb")
            tags = EXIF.process_file(img_file)
            if tags.has_key("EXIF DateTimeOriginal"):
                have_exif = True
                break

        if not have_exif:
            return


        item = nautilus.MenuItem("NautilusPython::rename_exif_date_item",
                                 "Rename to EXIF date" ,
                                 "Rename to EXIF date",
                                 "nautilus-rename-exif-date")
        item.connect("activate", self.menu_activate_cb, supported)
        return item,


