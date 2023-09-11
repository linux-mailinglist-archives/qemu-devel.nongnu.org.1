Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741979A83C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfgmK-0004jI-28; Mon, 11 Sep 2023 09:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfgmG-0004j0-Ch
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:16:32 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfgmD-0003TH-N3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:16:32 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c136ee106so553132066b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694438187; x=1695042987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/qr8ZqIxkTb/NWVgB9FttOgrkE2LFvm9nGFJM1n4Sc=;
 b=t4dI7oXasZuQz6EQIwV39xMjvARI0wJ2kqE0EkfjGAdCPxH2iu+WgvM1dh+td46kmt
 mJwpblYv9Csd9C/kY+LNacl5PJ76PIOFz1lhVPHv4NfLLhAyb1m61uzMVg2XSYIFgWmx
 LVagjXLKkICgfxgnkDRp6EJF7JpzvtzWr+KaqlST1W6XtWqrvNbYUXPxdLo6HNTuaLTM
 iHbtm9hYSeSS+RZ9fGg/LOnVhNvX+RIbg/n89xGrLe7Ew5CWNCtrfXjczVXpTHz+qXzo
 X/U4W60Qg4QJPen7ddWjg6HsCXfOBNxfbE1S5K7DANjbULzg4+JITxYyAAawZhJf+ypw
 RJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694438187; x=1695042987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/qr8ZqIxkTb/NWVgB9FttOgrkE2LFvm9nGFJM1n4Sc=;
 b=sRpRx4K2GEH6MAjCtsSYNKg/XRkKr+AQ+3OlkUFBSWyV3mG7bgHS714LghGkpgdO+v
 eOJF7QdqJFifqPOMiD5LU7kQr/r4rbJjPtqLwXhAePJ89Y5q29STXTQg0uRBMBAsxMjR
 D2eE5bkn6xlJUQ2R7BXvTW1IFMp3t1woykliBsgzrg7m0yGHs8m5ankhk2bKMJTUQ3WK
 KLmg/KyZkHc6GxU63eRfIJkwj+cUxT+CfWANhs1p15kGCiEvyL/f/0sDsI1oVPD9M3P+
 QvJaPhCG9fxagUqNee2833RH+0NbeFU5dDCj8v1we0m9tFpsPk3rIKmCazSQqeaVlHAh
 QWRA==
X-Gm-Message-State: AOJu0YzQeelsBl4QZdjP8D423ioyZC5r9LuZXT7w2r9RSXILRzhfzMJ+
 nwoVv/gfIk2ERlRcLrcc0iaO4w==
X-Google-Smtp-Source: AGHT+IHhiEq+XYZSJeznSDREC20CgvswraPa7tPoayDxAcErlDuk9ftDwaxt5kA9sWAFSqmLdihcog==
X-Received: by 2002:a17:907:2cca:b0:9a1:f5b1:c85d with SMTP id
 hg10-20020a1709072cca00b009a1f5b1c85dmr7833573ejc.12.1694438187002; 
 Mon, 11 Sep 2023 06:16:27 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090668c900b0099bcdfff7cbsm5324243ejr.160.2023.09.11.06.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 06:16:26 -0700 (PDT)
Message-ID: <a27ca97f-a8fd-01f0-78d8-8ad7fb31b7d2@linaro.org>
Date: Mon, 11 Sep 2023 15:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org
References: <20230911103832.23596-1-philmd@linaro.org>
 <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
 <ZP8I9B3O4CTwTTie@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZP8I9B3O4CTwTTie@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/9/23 14:32, Kevin Wolf wrote:
> Am 11.09.2023 um 13:15 hat Stefan Hajnoczi geschrieben:
>> On Mon, 11 Sept 2023 at 06:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Since commits 3adce820cf..ef1cf6890f, When building on
>>> a x86 host configured as:
>>>
>>>    $ ./configure --cc=clang \
>>>      --target-list=x86_64-linux-user,x86_64-softmmu \
>>>      --enable-debug
>>>
>>> we get:
>>>
>>>    [71/71] Linking target qemu-x86_64
>>>    FAILED: qemu-x86_64
>>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>>>    cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cpuid'
>>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>>>    cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cpuid'
>>>    /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get_supported_cpuid'
>>>    /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get_supported_cpuid'
>>>    /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get_supported_cpuid'
>>>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' follow
>>>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
>>>    ninja: build stopped: subcommand failed.
>>>
>>> '--enable-debug' disables optimizations (CFLAGS=-O0).
>>>
>>> While at this (un)optimization level GCC eliminate the
>>> following dead code:
>>>
>>>    if (0 && foo()) {
>>>        ...
>>>    }
>>>
>>> Clang does not. Therefore restore a pair of stubs for
>>> unoptimized Clang builds.
>>>
>>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>>> Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
>>> Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---
>>>   1 file changed, 18 insertions(+), 3 deletions(-)


>>> +#elif defined(__clang__) && !defined(__OPTIMIZE__)
>>
>> Another approach is a static library with a .o file containing the
>> stubs so the linker only includes it in the executable if the compiler
>> emitted the symbols. That way there is no need for defined(__clang__)
>> && !defined(__OPTIMIZE__) and it will work with other
>> compilers/optimization levels. It's more work to set up though.
> 
> Isn't that exactly how it was before the stubs were removed? It would be
> a simple revert of that commit.
> 
> The approach with static inline functions defined only for a very
> specific configuration looks a lot more fragile to me. In fact, I'm
> surprised that it works because I think it requires that the header
> isn't used in any files that are shared between user space and system
> emulation - and naively cpu.c sounded like something that could be
> shared. Looks like this patch only works because the linux-user target
> uses a separate build of the same CPU emulation source file.
> 
> So I think reverting the commit that removed the stubs would be much
> more obvious.

Yes, v2 reverts:
https://lore.kernel.org/qemu-devel/20230911131507.24943-1-philmd@linaro.org/


