// Fill out your copyright notice in the Description page of Project Settings.

using System.IO;
using UnrealBuildTool;
using System.Collections.Generic;
using System.Text;
using System;
using System.Diagnostics;
using System.Text.RegularExpressions;

public class gRPCForUE4 : ModuleRules
{
    public gRPCForUE4(ReadOnlyTargetRules Target) : base(Target)
    {
        Type = ModuleType.External;


        // port_def.inc
        PublicDefinitions.Add("GOOGLE_PROTOBUF_NO_RTTI");

        // port_platform.h
        PublicDefinitions.Add("GRPC_ALLOW_EXCEPTIONS=0");
        PublicDefinitions.Add("GPR_FORBID_UNREACHABLE_CODE=0");


        PublicIncludePaths.AddRange(
            new string[] {
                Path.Combine(ModuleDirectory, "gRPC", "Includes", "include"),
                Path.Combine(ModuleDirectory, "gRPC", "Includes", "third_party", "protobuf", "src"),
                Path.Combine(ModuleDirectory, "gRPC", "Includes", "third_party"),
            }
        );

        List<string> libs = FindFilesInDirectory(Path.Combine(ModuleDirectory, "gRPC", "Libraries"), "lib");
        PublicAdditionalLibraries.AddRange(libs);
        AddEngineThirdPartyPrivateStaticDependencies(Target, "zlib");
        AddEngineThirdPartyPrivateStaticDependencies(Target, "OpenSSL");
    }


    private List<string> FindFilesInDirectory(string dir, string suffix)
    {
        List<string> matches = new List<string>();
        if (Directory.Exists(dir))
        {
            string[] files = Directory.GetFiles(dir, "*" + suffix, SearchOption.AllDirectories);
            foreach (string file in files)
            {
                matches.Add(file);
            }
        }

        return matches;
    }
}
