require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:prestation) { create(:prestation) }

    context 'with valid parameters' do
      it 'creates a new booking' do
        expect {
          post :create, params: { booking: { prestation_id: prestation.id, address_of_prestation: '5 rue Mouffetard, Paris', lat: 123, lng: 456 } }
        }.to change(Booking, :count).by(1)
      end

      it 'redirects to confirmation path' do
        post :create, params: { booking: { prestation_id: prestation.id, address_of_prestation: '123 Main St', lat: 123, lng: 456 } }
        expect(response).to redirect_to(confirmation_path)
      end
    end

    context 'with invalid parameters' do
      it 'renders the index template with alert' do
        post :create, params: { booking: { prestation_id: nil, address_of_prestation: '123 Main St', lat: 123, lng: 456 } }
        expect(response).to render_template('home/index')
        expect(flash[:alert]).to be_present
      end
    end
  end
end
