Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84D7D7CC1
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtcG-0003CQ-0P; Thu, 26 Oct 2023 02:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvtcE-0003Bo-9a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvtcB-0001TW-4O
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698300784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4JhWd4Lp1FbTPtXhQRoQ3/bBpPMKyyNLCWkI8QcupOs=;
 b=UbNe7ZZIpmh+sWyTG7aylff0s57rWSjzNCSqMocyme0EitZnrZQ/bPFjH/TqN4oXDPBEs2
 gwjDZQcmAeTzFFrW5rtKwCsD2j7KAG4slS8xaucdRdhDVbyi6AvjGIG8Ds0KcEbegRSRHk
 XMo2wnQ7FgjmKNk8yF4V7Vsb8WetfQs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-lz-fIKUUOBmnKZhhw9sZjA-1; Thu, 26 Oct 2023 02:13:02 -0400
X-MC-Unique: lz-fIKUUOBmnKZhhw9sZjA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9c6a4a60033so31628466b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698300781; x=1698905581;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JhWd4Lp1FbTPtXhQRoQ3/bBpPMKyyNLCWkI8QcupOs=;
 b=CxUeYqc8ttQlAZsTxj/oPPtdzdCMOzWr+5suAbNtRdHhkapvYtSuiR2h0e+TwbjD5M
 ST2Wl7dSI6x1AH/eH+gaEpeTlH+aoLrbevg1n3odOjS4w2mkYdIHNtr6MqBKtKEUR4hb
 tGrdAuYrWFqhOC10Qxt2SGFMIA0jzvlFXig+NZXLIdbO6npiwY6cy4dPytY5fgqpDbWS
 Fbn8w0zFlrE1NOFqT5zPltDA9JEErlzHM/pMWQWJnECstJYIpAG9u0PPZ2sUUCIYKtG4
 oqx3q2ODjsrBqAi5Z2VdeljJKr6cjYydKiWDinThoaE8+qaJ9ThGqM72bDQ43e51q5pR
 v2Tw==
X-Gm-Message-State: AOJu0Yz5FptyPLrnPkJBtrC0qYtIC4tnktN4Hdk89gfZIsbnrWU0ciRx
 7zv6pN3nwN8RU5Ov9nODVZyqO5r2eeKAMC+q8armzWInf58psvr33hAdT/TFaqanUlLJ//mvlzv
 cway7UkTb5Wa52ew=
X-Received: by 2002:a17:906:da82:b0:9ad:a4bd:dc67 with SMTP id
 xh2-20020a170906da8200b009ada4bddc67mr15507883ejb.50.1698300781263; 
 Wed, 25 Oct 2023 23:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdUnEDZxEaLUXTf4d3mYm9ThSSdZUJGwOEEMsJshYFXytAoE2AyxQpKZULTSDPSjDqARXdPA==
X-Received: by 2002:a17:906:da82:b0:9ad:a4bd:dc67 with SMTP id
 xh2-20020a170906da8200b009ada4bddc67mr15507873ejb.50.1698300780913; 
 Wed, 25 Oct 2023 23:13:00 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 q1-20020a1709060e4100b009b64987e1absm11016804eji.139.2023.10.25.23.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 23:13:00 -0700 (PDT)
Message-ID: <ad92f0db-7640-492d-a966-4cf883f46308@redhat.com>
Date: Thu, 26 Oct 2023 08:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 bcain@quicinc.com, imp@bsdimp.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
 <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/10/2023 07.58, Philippe Mathieu-Daudé wrote:
> On 26/10/23 07:31, Markus Armbruster wrote:
>> Local variables shadowing other local variables or parameters make the
>> code needlessly hard to understand.  Bugs love to hide in such code.
>> Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
>> fail on polling error).
>>
>> Enable -Wshadow=local to prevent such issues.  Possible thanks to
>> recent cleanups.  Enabling -Wshadow would prevent more issues, but
>> we're not yet ready for that.
>>
>> As usual, the warning is only enabled when the compiler recognizes it.
>> GCC does, Clang doesn't.
>>
>> Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
>> let's not wait for its cleanup.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meson.build b/meson.build
>> index dcef8b1e79..89220443b8 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -462,6 +462,7 @@ warn_flags = [
>>     '-Wno-tautological-type-limit-compare',
>>     '-Wno-psabi',
>>     '-Wno-gnu-variable-sized-type-not-at-end',
>> +  '-Wshadow=local',
>>   ]
>>   if targetos != 'darwin'
> 
> Using Clang on Darwin:
> 
> $ ../configure
> The Meson build system
> Version: 1.2.1
> Build type: native build
> Project name: qemu
> Project version: 8.1.50
> C compiler for the host machine: cc (clang 15.0.0 "Apple clang version 
> 15.0.0 (clang-1500.0.40.1)")
> C linker for the host machine: cc ld64 1015.7
> Host machine cpu family: aarch64
> Host machine cpu: aarch64
> Program sh found: YES (/bin/sh)
> Objective-C compiler for the host machine: clang (clang 15.0.0)
> Objective-C linker for the host machine: clang ld64 1015.7
> Program bzip2 found: YES (/usr/bin/bzip2)
> Program iasl found: YES (/opt/homebrew/bin/iasl)
> Compiler for C supports arguments -fno-pie: YES
> Compiler for C supports arguments -no-pie: NO
> Compiler for C supports link arguments -Wl,-z,relro: NO
> Compiler for C supports link arguments -Wl,-z,now: NO
> Compiler for C supports link arguments -Wl,--warn-common: NO
> Compiler for C supports arguments -Wundef: YES
> Compiler for C supports arguments -Wwrite-strings: YES
> Compiler for C supports arguments -Wmissing-prototypes: YES
> Compiler for C supports arguments -Wstrict-prototypes: YES
> Compiler for C supports arguments -Wredundant-decls: YES
> Compiler for C supports arguments -Wold-style-declaration: NO
> Compiler for C supports arguments -Wold-style-definition: YES
> Compiler for C supports arguments -Wtype-limits: YES
> Compiler for C supports arguments -Wformat-security: YES
> Compiler for C supports arguments -Wformat-y2k: YES
> Compiler for C supports arguments -Winit-self: YES
> Compiler for C supports arguments -Wignored-qualifiers: YES
> Compiler for C supports arguments -Wempty-body: YES
> Compiler for C supports arguments -Wnested-externs: YES
> Compiler for C supports arguments -Wendif-labels: YES
> Compiler for C supports arguments -Wexpansion-to-defined: YES
> Compiler for C supports arguments -Wimplicit-fallthrough=2: NO
> Compiler for C supports arguments -Wmissing-format-attribute: YES
> Compiler for C supports arguments -Wno-initializer-overrides: YES
> Compiler for C supports arguments -Wno-missing-include-dirs: YES
> Compiler for C supports arguments -Wno-shift-negative-value: YES
> Compiler for C supports arguments -Wno-string-plus-int: YES
> Compiler for C supports arguments -Wno-typedef-redefinition: YES
> Compiler for C supports arguments -Wno-tautological-type-limit-compare: YES
> Compiler for C supports arguments -Wno-psabi: YES
> Compiler for C supports arguments -Wno-gnu-variable-sized-type-not-at-end: YES
> Compiler for C supports arguments -Wshadow=local: NO
> Compiler for Objective-C supports arguments -Wundef: YES
> Compiler for Objective-C supports arguments -Wwrite-strings: YES
> Compiler for Objective-C supports arguments -Wmissing-prototypes: YES
> Compiler for Objective-C supports arguments -Wstrict-prototypes: YES
> Compiler for Objective-C supports arguments -Wredundant-decls: YES
> Compiler for Objective-C supports arguments -Wold-style-declaration: NO
> Compiler for Objective-C supports arguments -Wold-style-definition: YES
> Compiler for Objective-C supports arguments -Wtype-limits: YES
> Compiler for Objective-C supports arguments -Wformat-security: YES
> Compiler for Objective-C supports arguments -Wformat-y2k: YES
> Compiler for Objective-C supports arguments -Winit-self: YES
> Compiler for Objective-C supports arguments -Wignored-qualifiers: YES
> Compiler for Objective-C supports arguments -Wempty-body: YES
> Compiler for Objective-C supports arguments -Wnested-externs: YES
> Compiler for Objective-C supports arguments -Wendif-labels: YES
> Compiler for Objective-C supports arguments -Wexpansion-to-defined: YES
> Compiler for Objective-C supports arguments -Wimplicit-fallthrough=2: NO
> Compiler for Objective-C supports arguments -Wmissing-format-attribute: YES
> Compiler for Objective-C supports arguments -Wno-initializer-overrides: YES
> Compiler for Objective-C supports arguments -Wno-missing-include-dirs: YES
> Compiler for Objective-C supports arguments -Wno-shift-negative-value: YES
> Compiler for Objective-C supports arguments -Wno-string-plus-int: YES
> Compiler for Objective-C supports arguments -Wno-typedef-redefinition: YES
> Compiler for Objective-C supports arguments 
> -Wno-tautological-type-limit-compare: YES
> Compiler for Objective-C supports arguments -Wno-psabi: YES
> Compiler for Objective-C supports arguments 
> -Wno-gnu-variable-sized-type-not-at-end: YES
> Compiler for Objective-C supports arguments -Wshadow=local: NO
> 
> So:
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Now don't blame me for posting patches with trigger shadow=local
> warnings because I am not testing that locally.
> 
> I find it a bit unfair to force me rely on CI or other machines
> rather than my host machine to check for warnings. I'd have
> rather waited this option support lands first in Clang before
> enabling this flag.

Huh, that situation is already pre-existing, e.g. with 
-Wimplicit-fallthrough=2 ... and if you're too afraid, you can always 
install gcc via homebrew to check.

  Thomas



