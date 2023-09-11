Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9379AB94
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfohN-0004xS-By; Mon, 11 Sep 2023 17:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qfohJ-0004xD-Do
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:43:57 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qfohG-00039s-SF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:43:57 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5717f7b932aso3232815eaf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694468633; x=1695073433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7PxZSasxzaZK6ySt/EiZNnW6XSXUIuQNLZwWdVN8xzI=;
 b=OD0qJ/VARhxjuoUnO8LtM1sQEL6qokZKua7aVrc9PoCJInpBvm9bPHc8OPBHfS59K4
 OFoXf2sO6QQTgmyYgnngjb/sMseJcY8jnGqv6TxpoCJ1KYuaLMzlr6xJ1kSPp3ELdD0O
 fSH7YxmilW+FW+Yn2UDhTCE6ArPgujT9PjyNxyAJXkjtScWvgQ8yr6Rah4Psc06QrphR
 d4Th9Jf/P2cyBUbph+htqrt92qBMkpdtciEDoHxIUk6soM6XM9uPEYwzPeZuufB4ssa1
 nhHqEZVeIPJ+3cVZLd60JgMJjMhZ+/LhRcsEw7d3pZLa5/MM+hOj3oFQ4wiNjA/C4mlY
 4ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694468633; x=1695073433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7PxZSasxzaZK6ySt/EiZNnW6XSXUIuQNLZwWdVN8xzI=;
 b=FynJU9/gYnnM0uf5Y9RqqZ6oCLb0PUXYc9GIps2NeTOJxLr2TefCWGavfbKytwJtjV
 hEODh9voRhC94qmcnIT1V0sWL/cCpdBKGSXM/todcy4Q3CqvBDepVoKsDs8LBK19ab1Y
 Lt3/ldDdjIqicnOxkt3wLwJv8u6eZrrrmuJ1vvjjw6mM7rukBGS3jX527a2YnbfVUHnI
 q9uoGRzzpGRKCb7EAvTkJrxhjiweW0IGUYcH3kL76CKAkgqKfgn8LL8TAfTP1A1GRo+E
 fe2RjjRWBy3+msooGAo5i9WpPAf7IZqakMIbaSBD+DiYbbtmkf4KaSLIq3Tzd3qSvfax
 NBow==
X-Gm-Message-State: AOJu0YwzSu7RlZeOqhvZm/AupAYYVSI2btQX4AoTyBMNbgi14Q1wlXe7
 2wPK5vzuv0s5y0ZkgL5dp52/Pg==
X-Google-Smtp-Source: AGHT+IF6C3pfFOwLU2OLIVS9l2jUzf1dAZ2dNnaytFyNw6qNs3ontDrIwNuAI37gqyaZpxRA2xGO4w==
X-Received: by 2002:a4a:ea3a:0:b0:566:f8ee:fa67 with SMTP id
 y26-20020a4aea3a000000b00566f8eefa67mr10612845ood.0.1694468633300; 
 Mon, 11 Sep 2023 14:43:53 -0700 (PDT)
Received: from [192.168.68.107] ([177.9.182.82])
 by smtp.gmail.com with ESMTPSA id
 123-20020a4a1d81000000b00569c240e398sm3671110oog.30.2023.09.11.14.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 14:43:53 -0700 (PDT)
Message-ID: <aad03dca-e1d9-b5c5-22a9-6711841a3516@ventanamicro.com>
Date: Mon, 11 Sep 2023 18:43:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-39-alistair.francis@wdc.com>
 <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc33.google.com
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



On 9/11/23 16:54, Michael Tokarev wrote:
> 11.09.2023 09:43, Alistair Francis:
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> A build with --enable-debug and without KVM will fail as follows:
>>
>> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
>> ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
>>
>> This happens because the code block with "if virt_use_kvm_aia(s)" isn't
>> being ignored by the debug build, resulting in an undefined reference to
>> a KVM only function.
>>
>> Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
>> make the compiler crop the kvm_riscv_aia_create() call entirely from a
>> non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
>> virt_use_kvm_aia() won't fix the build because this function would need
>> to be inlined multiple times to make the compiler zero out the entire
>> block.
>>
>> While we're at it, use kvm_enabled() in all instances where
>> virt_use_kvm_aia() is checked to allow the compiler to elide these other
>> kvm-only instances as well.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")
> 
> This is probably commit 48c2c33c52, not dbdb99948e.
> 
> ..
>>       /* KVM AIA only has one APLIC instance */
>> -    if (virt_use_kvm_aia(s)) {
>> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>>           create_fdt_socket_aplic(s, memmap, 0,
> ...
> 
> As has been discovered earlier (see "target/i386: Restrict system-specific
> features from user emulation" threads), this is not enough, - compiler does
> not always eliminate if (0 && foo) { bar; } construct, it's too fragile and
> does not actually work.  Either some #ifdef'fery is needed here or some other,
> more explicit, way to eliminate such code, like introducing stub functions.
> 
> I know it's too late and this change is already in, but unfortunately that's
> when I noticed this.  While the "Fixes:" tag can't be changed anymore, a more
> proper fix for the actual problem (with the proper Fixes tag now) can still
> be applied on top of this fix.

This works fine on current master on my machine:

$ ../configure --cc=clang --target-list=riscv64-softmmu,riscv64-linux-user,riscv32-softmmu,riscv32-linux-user --enable-debug
$ make -j

So I'm not sure what do you mean by 'actual problem'. If you refer to the non-existence
of stub functions, earlier today we had a review by Phil in this patch here where I was
adding stubs for all KVM functions:

https://lore.kernel.org/qemu-riscv/f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org/

Phil mentioned that we don't need a function stub if the KVM only function is protected by
"kvm_enabled()". And this is fine, but then, from what you're saying, we can't rely on
(kvm_enabled() && foo) working all the time, so we're one conditional away from breaking
things it seems.

I think we need to make up our minds and standardize. Do we rely on the compiler to optimize
stuff out, or do we use stubs/ifdefs? I'm fine with both options, as long as we pick one and
stick with it.


Thanks,

Daniel

> 
> /mjt

