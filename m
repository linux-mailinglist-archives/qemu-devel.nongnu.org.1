Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B27D7C9B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtOP-0007br-U5; Thu, 26 Oct 2023 01:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtOL-0007bh-8H
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:58:49 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtOJ-0003MG-3c
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:58:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so77218866b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698299925; x=1698904725; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5BLxc+uC/1SFREJE2CnCJWQZVhRWxlay+w7gDM0bdlA=;
 b=tUf9xNeMycU4vIIV9XVqhfb0zwJfY9qwykkEi2DxMJRFe+ZNgRINUW1hDBq1IfwVb6
 YAR4TGa+TK0wkp+Q1YGdT7ci8saTTl/b1BEzAz+WhJqLsngjElgkhzg83FmsE0k9akHI
 xy2pvZLyS0LzOqg5/cGMg1Z/aVFpnNBCA8SVYm87Sh+ainAlFV9PMnpzkIbV1US6gfZS
 TFcpL1FlCCNawTQP3NEzteeNBu5xlsnDPivYLTYAjohHQz/4EgZvMPtiUTkOUHfhN0Ox
 AyMMa73PUOPmt3JFUUcDMfoQWWQ1gvlvsDex0iRMqqgNkjy7dkw2j9hcJ3SA7QOEgut4
 0mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698299925; x=1698904725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5BLxc+uC/1SFREJE2CnCJWQZVhRWxlay+w7gDM0bdlA=;
 b=WMA7UPDEtrDfTIT5blW76l/SXlvlMeIvb31kTZRhAhvW4HrEQBF83oh2nhTWpkiP/f
 2L5x5nEUiNpexck2jib8cAE6Br1IytR1VoDP5RX/pUUqk5uvSZE0cg9roLor+zTLOjWa
 9cAMBxy0o1MpfG/1KxgQsFhSUisAFGe5N3n9e9GosVk/3Pn+6kgJYcI1BYH2ZIDVnmI2
 73rqJpSND9tl7BZMESAag1i9FiVoOoTzFoDP+oSKLqFmB8CfQKf/XxFbSqCeWYb8bZh8
 nLpch/BSLtRPvZcG1dUFAJ2eodnj7+4zz0rUFzJqIBQsE+Pt3T5nG221on/qw/53wj6F
 3nrA==
X-Gm-Message-State: AOJu0YzzYfJmOdPbFRg6SowveptTRg2Z5JgLrcya7FZM3GUsoQvfu4dr
 oAzM2tXw+rodZa2uGKKvFMYk6w==
X-Google-Smtp-Source: AGHT+IG2mTvG2xqxU67CFW8BzObG5Ki5b8InNytWj855p1RS28eh8d3oaLRrXCYlF9cKDeEgYhta3Q==
X-Received: by 2002:a17:907:318c:b0:9c3:97d7:2c5f with SMTP id
 xe12-20020a170907318c00b009c397d72c5fmr14260047ejb.44.1698299925085; 
 Wed, 25 Oct 2023 22:58:45 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a17090624d000b009c751e41ebasm11287082ejb.141.2023.10.25.22.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 22:58:44 -0700 (PDT)
Message-ID: <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
Date: Thu, 26 Oct 2023 07:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, bcain@quicinc.com, imp@bsdimp.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026053115.2066744-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/10/23 07:31, Markus Armbruster wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
> fail on polling error).
> 
> Enable -Wshadow=local to prevent such issues.  Possible thanks to
> recent cleanups.  Enabling -Wshadow would prevent more issues, but
> we're not yet ready for that.
> 
> As usual, the warning is only enabled when the compiler recognizes it.
> GCC does, Clang doesn't.
> 
> Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
> let's not wait for its cleanup.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..89220443b8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -462,6 +462,7 @@ warn_flags = [
>     '-Wno-tautological-type-limit-compare',
>     '-Wno-psabi',
>     '-Wno-gnu-variable-sized-type-not-at-end',
> +  '-Wshadow=local',
>   ]
>   
>   if targetos != 'darwin'

Using Clang on Darwin:

$ ../configure
The Meson build system
Version: 1.2.1
Build type: native build
Project name: qemu
Project version: 8.1.50
C compiler for the host machine: cc (clang 15.0.0 "Apple clang version 
15.0.0 (clang-1500.0.40.1)")
C linker for the host machine: cc ld64 1015.7
Host machine cpu family: aarch64
Host machine cpu: aarch64
Program sh found: YES (/bin/sh)
Objective-C compiler for the host machine: clang (clang 15.0.0)
Objective-C linker for the host machine: clang ld64 1015.7
Program bzip2 found: YES (/usr/bin/bzip2)
Program iasl found: YES (/opt/homebrew/bin/iasl)
Compiler for C supports arguments -fno-pie: YES
Compiler for C supports arguments -no-pie: NO
Compiler for C supports link arguments -Wl,-z,relro: NO
Compiler for C supports link arguments -Wl,-z,now: NO
Compiler for C supports link arguments -Wl,--warn-common: NO
Compiler for C supports arguments -Wundef: YES
Compiler for C supports arguments -Wwrite-strings: YES
Compiler for C supports arguments -Wmissing-prototypes: YES
Compiler for C supports arguments -Wstrict-prototypes: YES
Compiler for C supports arguments -Wredundant-decls: YES
Compiler for C supports arguments -Wold-style-declaration: NO
Compiler for C supports arguments -Wold-style-definition: YES
Compiler for C supports arguments -Wtype-limits: YES
Compiler for C supports arguments -Wformat-security: YES
Compiler for C supports arguments -Wformat-y2k: YES
Compiler for C supports arguments -Winit-self: YES
Compiler for C supports arguments -Wignored-qualifiers: YES
Compiler for C supports arguments -Wempty-body: YES
Compiler for C supports arguments -Wnested-externs: YES
Compiler for C supports arguments -Wendif-labels: YES
Compiler for C supports arguments -Wexpansion-to-defined: YES
Compiler for C supports arguments -Wimplicit-fallthrough=2: NO
Compiler for C supports arguments -Wmissing-format-attribute: YES
Compiler for C supports arguments -Wno-initializer-overrides: YES
Compiler for C supports arguments -Wno-missing-include-dirs: YES
Compiler for C supports arguments -Wno-shift-negative-value: YES
Compiler for C supports arguments -Wno-string-plus-int: YES
Compiler for C supports arguments -Wno-typedef-redefinition: YES
Compiler for C supports arguments -Wno-tautological-type-limit-compare: YES
Compiler for C supports arguments -Wno-psabi: YES
Compiler for C supports arguments 
-Wno-gnu-variable-sized-type-not-at-end: YES
Compiler for C supports arguments -Wshadow=local: NO
Compiler for Objective-C supports arguments -Wundef: YES
Compiler for Objective-C supports arguments -Wwrite-strings: YES
Compiler for Objective-C supports arguments -Wmissing-prototypes: YES
Compiler for Objective-C supports arguments -Wstrict-prototypes: YES
Compiler for Objective-C supports arguments -Wredundant-decls: YES
Compiler for Objective-C supports arguments -Wold-style-declaration: NO
Compiler for Objective-C supports arguments -Wold-style-definition: YES
Compiler for Objective-C supports arguments -Wtype-limits: YES
Compiler for Objective-C supports arguments -Wformat-security: YES
Compiler for Objective-C supports arguments -Wformat-y2k: YES
Compiler for Objective-C supports arguments -Winit-self: YES
Compiler for Objective-C supports arguments -Wignored-qualifiers: YES
Compiler for Objective-C supports arguments -Wempty-body: YES
Compiler for Objective-C supports arguments -Wnested-externs: YES
Compiler for Objective-C supports arguments -Wendif-labels: YES
Compiler for Objective-C supports arguments -Wexpansion-to-defined: YES
Compiler for Objective-C supports arguments -Wimplicit-fallthrough=2: NO
Compiler for Objective-C supports arguments -Wmissing-format-attribute: YES
Compiler for Objective-C supports arguments -Wno-initializer-overrides: YES
Compiler for Objective-C supports arguments -Wno-missing-include-dirs: YES
Compiler for Objective-C supports arguments -Wno-shift-negative-value: YES
Compiler for Objective-C supports arguments -Wno-string-plus-int: YES
Compiler for Objective-C supports arguments -Wno-typedef-redefinition: YES
Compiler for Objective-C supports arguments 
-Wno-tautological-type-limit-compare: YES
Compiler for Objective-C supports arguments -Wno-psabi: YES
Compiler for Objective-C supports arguments 
-Wno-gnu-variable-sized-type-not-at-end: YES
Compiler for Objective-C supports arguments -Wshadow=local: NO

So:

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Now don't blame me for posting patches with trigger shadow=local
warnings because I am not testing that locally.

I find it a bit unfair to force me rely on CI or other machines
rather than my host machine to check for warnings. I'd have
rather waited this option support lands first in Clang before
enabling this flag.

Regards,

Phil.

