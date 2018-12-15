def run(self):
        op = 1

        self.createSocketUDP()

        while op != 0:
            op = self.getService()

            print("Serviços disponíveis")

            for i in range(len(self.serviceList)):
                print(i+1, "- ", self.serviceList[i])

            print("0 - Sair")

            op = int(input("Selecione o serviço: "))

            while op < 0 or op > len(self.serviceList):
                op = int(input("Serviço invalido, digite novamente: "))

            self.selectService(op)