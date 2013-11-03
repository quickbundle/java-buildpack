# Encoding: utf-8
# Cloud Foundry Java Buildpack
# Copyright 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'java_buildpack/diagnostics/logger_factory'
require 'java_buildpack/framework'
require 'java_buildpack/framework/spring_auto_reconfiguration/web_xml_modifier'
require 'java_buildpack/repository/configured_item'
require 'java_buildpack/versioned_dependency_component'

module JavaBuildpack::Framework

  # Encapsulates the detect, compile, and release functionality for enabling cloud auto-reconfiguration in Spring
  # applications.
  class JavaWeb < JavaBuildpack::BaseComponent

    def initialize(context, &version_validator)
      super('Java Web', context)
    end

    def detect
      "javaweb"
    end
    
    def compile
    end

    def release
    end

    protected

    alias_method :super_download, :download

    # Downloads the versioned dependency, then yields the resultant file to the given block.
    #
    # @return [void]
    def download(description = @component_name, &block)
      super_download @version, @uri, description, &block
    end

    # Downloads a given JAR and copies it to a given destination.
    #
    # @param [String] jar_name the filename of the item
    # @param [String] target_directory the path of the directory into which to download the item. Defaults to
    #                                  +@lib_directory+
    # @param [String] description an optional description for the download.  Defaults to +@component_name+.
    def download_jar(jar_name, target_directory = @lib_directory, description = @component_name)
      download(description) { |file| system "cp #{file.path} #{File.join(target_directory, jar_name)}" }
    end

  end

end
