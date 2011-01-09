actions :install

attribute :name,    :kind_of => [ Array, String ], :required => true
attribute :ruby,    :kind_of => [ Array, String ], :required => true
attribute :version, :kind_of => String
attribute :source,  :kind_of => String
