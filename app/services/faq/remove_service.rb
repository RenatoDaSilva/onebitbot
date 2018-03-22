module FaqModule
  class RemoveService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      faq = Faq.find_by_id @id
      return "Questão inválida, verifique o Id" if faq == nil

      Faq.transaction do
        # Deleta as tags associadas que não estejam associadas a outros faqs
        faq.delete
        "Deletado com sucesso"
      end
    end
  end
end