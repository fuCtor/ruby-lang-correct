#encoding: UTF-8
require "rspec"
require '../lang_correct.rb'


describe LangCorrect do

  before do
    @lc = LangCorrect.new
  end

  context 'en->ru' do
    it "parse(:similar_chars)" do
      @lc.parse("ghbвет")[0].should == 'привет'
      @lc.parse("приdtn")[0].should == 'привет'
      @lc.parse("ghbdtn")[0].should_not == 'привет'
    end

    it "parse(:keyboard_layout)" do
      @lc.parse("ghbdtn", :keyboard_layout)[0].should == 'привет'
      @lc.parse("Ghbdtn", :keyboard_layout)[0].should == 'Привет'
      @lc.parse("ghbDtn", :keyboard_layout)[0].should == 'приВет'
    end

    it 'parse' do
      m = [:keyboard_layout, :similar_chars]
      @lc.parse("ghbdtn", m)[0].should == 'привет'
      @lc.parse("Ghbdtn", m)[0].should == 'Привет'
      @lc.parse("ghbDtn", m)[0].should == 'приВет'
      @lc.parse("ghbвет", m)[0].should == 'привет'
      @lc.parse("приdtn", m)[0].should == 'привет'
    end

    it 'parse name' do
      @lc.parse("A.M.Некрасов")[0].should == 'А.М.Некрасов'
      @lc.parse("A.M.Ytкрасов")[0].should == 'А.М.Некрасов'
    end

  end

  context 'ru->en' do
    it "parse(:similar_chars)" do
      @lc.parse("привет")[0].should == 'привет'
      @lc.parse("фсtor")[0].should == 'actor'
      @lc.parse("Вщсtor")[0].should == 'Doctor'
      @lc.parse("webьфыеук")[0].should == 'webmaster'
      @lc.parse("цццюмуыеш.ru")[0].should == 'www.vesti.ru'
    end

    it "parse(:keyboard_layout)" do
      @lc.parse("вщсещк", :keyboard_layout)[0].should == 'doctor'
    end

    it 'parse' do
      m = [:keyboard_layout, :similar_chars]
      @lc.parse("привет", m)[0].should == 'привет'
      @lc.parse("фсtor", m)[0].should == 'actor'
      @lc.parse("Вщсtor", m)[0].should == 'Doctor'
      @lc.parse("webьфыеук", m)[0].should == 'webmaster'
      @lc.parse("цццюмуыеш.ru", m)[0].should == 'www.vesti.ru'
      @lc.parse("вщсещк", m)[0].should == 'doctor'
    end

    it 'parse name' do
          end

  end

end