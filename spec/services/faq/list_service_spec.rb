require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "with list command: With zero faqs, it returns nothing found message" do
      @listService = FaqModule::ListService.new({}, 'list')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "With two faqs, it finds questions and answers in responses" do
      @listService = FaqModule::ListService.new({}, 'list')

      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = @listService.call()

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end

    it "with search command: With empty query, it returns nothing found message" do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search command: With valid query, it finds question and answer in response" do
      faq = create(:faq, company: @company)

      @listService = FaqModule::ListService.new({'query' => faq.question.split(" ").sample}, 'search')

      response = @listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

    it "with search_by_hashtag command: With invalid hashtag, it returns nothing found message" do
      @listService = FaqModule::ListService.new({'query' => ''}, 'search_by_hashtag')

      response = @listService.call()
      expect(response).to match("Nada encontrado")
    end

    it "with search_by_hashtag command: With valid hashtag, it finds question and answer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      @listService = FaqModule::ListService.new({'query' => hashtag.name}, 'search_by_hashtag')

      response = @listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end
end
