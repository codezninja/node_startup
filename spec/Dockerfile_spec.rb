require 'spec_helper'

describe "Dockerfile" do
  before(:all) do
    image = Docker::Helpers.get_image(image_id: ENV['DOCKER_IMAGE'])

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.json['Id']
  end

  it "should be debian" do
    expect(release_info).to include("Debian")
  end

  describe "dependencies" do
    describe command('npm -v') do
      its(:stderr) { should be_empty }
      its(:stdout) { should match "2.15.11" }
      its(:exit_status) { should eq 0 }
    end

    describe command('node -v') do
      its(:stderr) { should be_empty }
      its(:stdout) { should match "4.8.3" }
      its(:exit_status) { should eq 0 }
    end
  end

  describe file('/usr/src/app') do
    it { should exist }
    it { should be_directory }
  end

  def release_info
    command("cat /etc/*-release").stdout
  end
end