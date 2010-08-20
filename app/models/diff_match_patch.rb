class DiffMatchPatch

  def initialize
    @v8 = V8::Context.new
    @v8.load "lib/javascript/diff_match_patch_uncompressed.js"
    @v8.eval "dmp = new diff_match_patch()"

    @mutex = Mutex.new
  end

  def diff(old_text, new_text)
    @mutex.synchronize do
      @v8["old_text"] = old_text
      @v8["new_text"] = new_text

      @v8.eval "dmp.diff_main(old_text, new_text)"
    end
  end

  def merge(source_text, text1, text2)
    @mutex.synchronize do
      @v8["source0"] = source_text.to_s
      @v8["text1"]   = text1.to_s
      @v8["text2"]   = text2.to_s

      @v8.eval "diff1   = dmp.diff_main(source0, text1)"
      @v8.eval "patch1  = dmp.patch_make(source0, text1, diff1)"
      @v8.eval "source1 = dmp.patch_apply(patch1, source0)[0]"

      @v8.eval "diff2   = dmp.diff_main(source0, text2)"
      @v8.eval "patch2  = dmp.patch_make(source0, text2, diff2)"
      @v8.eval "source2 = dmp.patch_apply(patch2, source1)[0]"
    end
  end

end
