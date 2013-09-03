class Notifications < ActionMailer::Base
  default from: "from@example.com"

  def payment_receipt( payment, customer, user )
    @payment = payment
    @customer = customer
    @user = user

    mail(
      from: "#{user.email} <#{user.email}>",
      to: "#{customer.name}  <#{customer.email}>",
      subject: "Payment Receipt to #{user.email}",
      reply_to: user.email
    )
  end

  def sale_receipt( sale, customer, user )
    @sale = sale
    @customer = customer
    @user = user

    mail(
      from: "#{user.email} <#{user.email}>",
      to: "#{customer.name} <#{customer.email}>",
      subject: "Your recent purchase with #{user.email}",
      reply_to: user.email
    )
  end
end
