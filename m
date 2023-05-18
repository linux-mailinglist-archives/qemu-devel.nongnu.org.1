Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8857081FF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdFj-0008PC-Ds; Thu, 18 May 2023 09:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzdFY-0008MD-DO
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzdFW-0001Fr-1A
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684414850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+Kp3vDrs09j+dhwv48A/96FKDGN4H3AHRyMtmZ6TAM=;
 b=VkQ8+fwUbrz1rhYxGfWGfpft9caQFXeSwBSP5jiHyVHMeN8TWKb8LlDz+al8LIDjaoB45O
 HbpHysEWg7S0aOcbXxT9ZJdca8pJM8TC+2/IbyMxtctPmhxdmVl+PJ8ksiqnU8O/3rCio9
 TMr4AhoqfW3f4ZZ75QbyZmCam9VW4MM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-cfuaUTZbPLSaUiDX5AG9Tw-1; Thu, 18 May 2023 09:00:48 -0400
X-MC-Unique: cfuaUTZbPLSaUiDX5AG9Tw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bcd245040so2620423a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414847; x=1687006847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+Kp3vDrs09j+dhwv48A/96FKDGN4H3AHRyMtmZ6TAM=;
 b=P278VQo9zxqsEZsDZBmUKYeeMOWJAQDvvWOlN+LEVYMPLqL6EZr4cP0rEAw5Tr2UkG
 lcJRlOpwH/tcZrTfl9oIFoc7u2RZ420FOS6slX5jh7Zyy5tpbbDbGeqFgENn8s6Q5IP/
 qYzKsTGOZFtk/VCo4gUmypc1waslwRh0WKaCtCzJxAO6me+p4GwWSMAp74MbhbL1gUvw
 wTFPMbFAFlPRr1PqBFG/dSwR6bUG7bxhf6uZKJ8GMc2Pit9IT0UzQVDb03d5tDxr2w9C
 atsjQ6R1QWtzlBB25XA+rZbsxbCCKYxqsdsGp6RvCFLVnoL5Zci21vPegUPbQfMxCXA2
 9iOA==
X-Gm-Message-State: AC+VfDwV87e9Bs7GfXGLfOZm4nVHY/8rIkhnMF2wxdwFfbHLKS3kLw/A
 0pxFZOsbIu1l2D63yCtN2yOZBZOjDCHx6j2ZVCfomG3co5gmrxhmcBN2iBe8agpZ5AvVi7egu96
 x4mQft1r97tXB1C4=
X-Received: by 2002:aa7:ccd3:0:b0:510:591d:3d03 with SMTP id
 y19-20020aa7ccd3000000b00510591d3d03mr5838690edt.10.1684414847129; 
 Thu, 18 May 2023 06:00:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rgpgx6F1x8aQjcl3RkhXQn74gd9hy2sd74Q+OTvRHUbSkyOMWl9JZahoglAjlQoL8FFXOFA==
X-Received: by 2002:aa7:ccd3:0:b0:510:591d:3d03 with SMTP id
 y19-20020aa7ccd3000000b00510591d3d03mr5838645edt.10.1684414846437; 
 Thu, 18 May 2023 06:00:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 m11-20020a50ef0b000000b005067d6b06efsm572309eds.17.2023.05.18.06.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:00:45 -0700 (PDT)
Message-ID: <f8f06172-29fd-08ae-182e-193d139a878b@redhat.com>
Date: Thu, 18 May 2023 15:00:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] meson: use subproject for keycodemapdb
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
References: <20230518124645.1011316-1-pbonzini@redhat.com>
 <20230518124645.1011316-3-pbonzini@redhat.com> <ZGYgNYaS5c4Yq8uh@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZGYgNYaS5c4Yq8uh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 5/18/23 14:55, Daniel P. Berrangé wrote:
> On Thu, May 18, 2023 at 02:46:45PM +0200, Paolo Bonzini wrote:
>> By using a subproject, our own meson.build can use variables from
>> the subproject instead of hard-coded paths.  In the future, it may
>> also be possible to use wrap to download the submodule.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   .gitmodules                      | 4 ++--
>>   configure                        | 4 ++--
>>   scripts/archive-source.sh        | 2 +-
>>   {ui => subprojects}/keycodemapdb | 0
>>   ui/meson.build                   | 6 ++++--
>>   5 files changed, 9 insertions(+), 7 deletions(-)
>>   rename {ui => subprojects}/keycodemapdb (100%)
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index 3ed5d073d630..f8b2ddf3877c 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -25,8 +25,8 @@
>>   [submodule "roms/QemuMacDrivers"]
>>   	path = roms/QemuMacDrivers
>>   	url = https://gitlab.com/qemu-project/QemuMacDrivers.git
>> -[submodule "ui/keycodemapdb"]
>> -	path = ui/keycodemapdb
>> +[submodule "subprojects/keycodemapdb"]
>> +	path = subprojects/keycodemapdb
>>   	url = https://gitlab.com/qemu-project/keycodemapdb.git
>>   [submodule "roms/seabios-hppa"]
>>   	path = roms/seabios-hppa
>> diff --git a/configure b/configure
>> index 5bbca83d9a31..2b6995e16756 100755
>> --- a/configure
>> +++ b/configure
>> @@ -254,7 +254,7 @@ else
>>       git_submodules_action="ignore"
>>   fi
>>   
>> -git_submodules="ui/keycodemapdb"
>> +git_submodules="subprojects/keycodemapdb"
>>   git="git"
>>   debug_tcg="no"
>>   docs="auto"
>> @@ -806,7 +806,7 @@ case $git_submodules_action in
>>           fi
>>       ;;
>>       ignore)
>> -        if ! test -f "$source_path/ui/keycodemapdb/README"
>> +        if ! test -f "$source_path/subprojects/keycodemapdb/README"
>>           then
>>               echo
>>               echo "ERROR: missing GIT submodules"
>> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
>> index b15f6fe6b8fe..a0a3153faa99 100755
>> --- a/scripts/archive-source.sh
>> +++ b/scripts/archive-source.sh
>> @@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
>>   # independent of what the developer currently has initialized
>>   # in their checkout, because the build environment is completely
>>   # different to the host OS.
>> -submodules="subprojects/dtc meson ui/keycodemapdb"
>> +submodules="subprojects/dtc meson subprojects/keycodemapdb"
>>   submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
>>   sub_deinit=""
>>   
>> diff --git a/ui/keycodemapdb b/subprojects/keycodemapdb
>> similarity index 100%
>> rename from ui/keycodemapdb
>> rename to subprojects/keycodemapdb
>> diff --git a/ui/meson.build b/ui/meson.build
>> index 330369707dd7..e24d52b89941 100644
>> --- a/ui/meson.build
>> +++ b/ui/meson.build
>> @@ -162,13 +162,15 @@ keymaps = [
>>   ]
>>   
>>   if have_system or xkbcommon.found()
>> +  keycodemapdb_proj = subproject('keycodemapdb', required: true)
>> +  keymap_gen = find_program('keymap-gen', required: true)
> 
> This variable isn't used, is it ?

Hmm, no it isn't.  Do you prefer the code below and removing the 
assignment, or

     command: [python, keymap_gen.full_path(),

?  find_program is nicer, but you have to peek with 
keycodemap_proj.get_variable() anyway to reach the CSV file, so...

Paolo

>>     foreach e : keymaps
>>       output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
>>       genh += custom_target(output,
>>                     output: output,
>>                     capture: true,
>> -                  input: files('keycodemapdb/data/keymaps.csv'),
>> -                  command: [python, files('keycodemapdb/tools/keymap-gen'),
>> +                  input: keycodemapdb_proj.get_variable('keymaps_csv'),
>> +                  command: [python, keycodemapdb_proj.get_variable('keymap_gen'),
>>                               'code-map',
>>                               '--lang', 'glib2',
>>                               '--varname', 'qemu_input_map_@0@_to_@1@'.format(e[0], e[1]),
> 
> 
> With regards,
> Daniel


