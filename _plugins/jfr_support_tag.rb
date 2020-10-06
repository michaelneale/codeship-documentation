module Jekyll
	class NoteTag < Liquid::Block
		def initialize(tag_name, type, tokens)
			super
			@type = type.strip.downcase unless type.empty?
		end

		def render(context)
			content = super
			css_classes = "note-#{@type}" if @type

			out = <<~EOF
				<div class="note #{css_classes}">
                    This page documents the <b>experimental</b> Jenkins support in CloudBees CodeShip Pro.
                    This feature is currently under active development,
                    and it may evolve rapidly and change in incompatible ways.
                    Any feedback from users is appreciated.

                    #{content}
				</div>
			EOF
			out
		end
	end
end

Liquid::Template.register_tag('jenkinssupportnote', Jekyll::NoteTag)
