class SearchEngine
  def initialize(query)
    self.query = query
  end

  def search
    @search_results ||= engine.call(*query_params)
  end

  private

  attr_accessor :query

  def query_params
    [query]
  end

  def engine
    ->(*args) { Twitter.method(:search).call(*args).statuses }
  end

  def stub_engine
    ->(*) {
      [
        "@pbyrne @aca902 So... you're going to wash the one pair of sweatpants that Patrick will be wearing to work every day?",
        "@pbyrne indeed you will, sir",
        "@pbyrne made it today! Might toss it in with some tests next week.",
        "Goodbye forever to a great coworker, @pbyrne. It was great knowing you.",
        "@pbyrne Reminds me of this: http://t.co/lD4jm8eFMS Man…I loved that guy.",
        "It has been an astoundingly great pleasure to work with @pbyrne the last two years. “Performance is sexy. Right? Right.”",
        "@pbyrne @samuelfine @simplebits the only safari I know is the one about taking photos of the wildlife in Africa. ;)",
        "@pbyrne @simplebits True. I'm mostly concerned with changing my workflow. I've got a bazillion extensions, muscle memory, etc etc etc.",
        "@pbyrne Oh, you and @simplebits are going to get on swimmingly. He's one of you Safari weirdos, too. ^_^",
        "If we gave out the Hart Trophy... RT @aca902: Send your best to @pbyrne today. It’s his last day at @sportngin.",
        "@aca902 @pbyrne (I figured it out, only took me like 10 minutes. Because I'm REALLY smart.)",
        "@aca902 @pbyrne You will not believe how confused I was reading this tweet last night. \"Is \"___ wife\" some slang I'm too old to understand?\"",
        "Send your best to @pbyrne today. It’s his last day at @sportngin.",
        "@pbyrne right???",
      ].map { |s| OpenStruct.new(text: s) }
    }
  end
end
