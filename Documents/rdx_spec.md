Resource folder:
ui
fonts
master.rdm
patch.rdp
mod.rdp
load.json
(aes){
	[xz]{
		<tar>{
			assets{
				images{
					a.png{
						(checksum:sha256)
						(archive:tar)
						(compression:xz)
						(encryption:aes-256-gcm)
						[patch:xdelta3]{
							(source){
								<checksum:sha256>
							}
							(checksum:sha256)
							(encryption:aes-256-gcm)
							<patch-data>
						}
						[data]
					}
					b.png
					index.json
				}
				sfx{
					sound.wav{

				sounds{
					sfx.wav
					index.json
			index.json{
key{
	<checksum>
	<key_data>
}
source{
	(final_checksum:sha256)
	(key_checksum)
	(encrypted_compressed_archive_checksum)
	[encryption]{
		(compressed_archive_checksum)
		[compression]{
			(archive_checksum)
			[archive]{
				(data_checksum)
				<data>
			}
		}
	}
}
patch{
	(final_patch_checksum)
	(key_checksum)
	<source_id>
	(source_checksum)
	[encryption]{ //Apply the patch to the encrypted compressed archived data
		[compression]{ //Apply the patch to the compressed archived data
			[archived]{ //Apply the patch to the archived data
				(patch_data_checksum)
				<patch_data:xdelta3>
			}
		}
	}
}
load.json{
	"verify_checksums": true,
	"load": [
		"ui/*",
		"fonts/*",
		"master.rdm",
		"patch.rdp",
		"mod.rdp"
	}
}



