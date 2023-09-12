Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D379CE9D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0rw-0000qq-TR; Tue, 12 Sep 2023 06:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg0rt-0000n2-Lz
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:43:41 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg0rr-0002Sk-1A
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:43:41 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bf2427b947so3494424a34.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694515417; x=1695120217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5fdGhGhadeWmhrqRUUlc3oSQYBE3Hhhs8jVzFDnokKU=;
 b=n9KTfhTBjEZfPUNF2jc8r8z7I2AbEy/yLpk/1VwvV2syATSpPrYchKa07F83DJh01p
 JvkLOTYiuvIT1GvRfSpHZF+BooPDdX7Ikit1D+aVzdlqhyoFFuukaj3GqUqO2j194D8T
 iR/BAG/+oIGhYiAIuYtMCzCl+EVyYWJ/dCGtjU7H2s3ZLgrjlcxqrDQIPoDbXb1cqAkl
 o9T7+P3MYttR/fygvkW1og9GdiQalcc+vHqKzLyPwdn+BqFO9mQrsj+s7EkDItLicBDg
 tkJ6vfhcMflkLV5ra7ddjWtHSaFqJJ/SIdsN3fEB6iHHFOq+N/RLdp+hG7Lo8QOjZJKM
 wHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694515417; x=1695120217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5fdGhGhadeWmhrqRUUlc3oSQYBE3Hhhs8jVzFDnokKU=;
 b=HmKeCPmGse1BISjwFt1SuW+pNAoRMKayAXFYh8ZxNPvTifhsb+MT9znKGSvNY+D0tb
 KnS3y5boIOuQDmp/7aaGwa4eO+ZVbkyPKs6DJjCWmJH7rs3Giks8BwD3y9ldf3leNTyS
 dfUeFbpP4r/61yS7gPNgJsk1dV6SdiSZ/xqZkmj0eqi6uTK0u5hJc4CFTcYwj4623k1T
 yHrf84sJuWqbu4KGyt+0oyIm3Leuy9sRfi4MzOEgI75F7Qqu597TURNAmN0G4Xt/RxTK
 R+EyYfOyMnUGIAuI5fXTYJxs8xvkGVQc9KLkCemRQR2thL86Gewszy13VKEviSDO5N0A
 aNNA==
X-Gm-Message-State: AOJu0Yz5spIf9eZY2B2TBO+Jpm0Eezgc2bC0JJs6OFhnFhUz6p4YPAmt
 OnuYP48qIaj3skUMBZ5eQfay3Q==
X-Google-Smtp-Source: AGHT+IF7E+Ov92jom4dc89IdY5VVuC6I8CdgPtiQhxeJuCKF7a73J+eiiO/DVBlHGsGpjnVMqtcS+A==
X-Received: by 2002:a05:6830:1612:b0:6c0:7bab:2433 with SMTP id
 g18-20020a056830161200b006c07bab2433mr11847146otr.36.1694515417631; 
 Tue, 12 Sep 2023 03:43:37 -0700 (PDT)
Received: from [192.168.68.107] ([177.9.182.82])
 by smtp.gmail.com with ESMTPSA id
 h67-20020a4a5e46000000b005712505dcffsm4215687oob.32.2023.09.12.03.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 03:43:37 -0700 (PDT)
Message-ID: <e624af2b-a860-a3b0-aa9b-16bf50dd0274@ventanamicro.com>
Date: Tue, 12 Sep 2023 07:43:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-39-alistair.francis@wdc.com>
 <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
 <aad03dca-e1d9-b5c5-22a9-6711841a3516@ventanamicro.com>
 <48e7e9bb-1fb5-5233-bdef-c958498b90c4@tls.msk.ru>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <48e7e9bb-1fb5-5233-bdef-c958498b90c4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x334.google.com
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



On 9/12/23 03:05, Michael Tokarev wrote:
> 12.09.2023 00:43, Daniel Henrique Barboza:
>> On 9/11/23 16:54, Michael Tokarev wrote:
> ...
>>>>       /* KVM AIA only has one APLIC instance */
>>>> -    if (virt_use_kvm_aia(s)) {
>>>> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>>>>           create_fdt_socket_aplic(s, memmap, 0,
>>> ...
>>>
>>> As has been discovered earlier (see "target/i386: Restrict system-specific
>>> features from user emulation" threads), this is not enough, - compiler does
>>> not always eliminate if (0 && foo) { bar; } construct, it's too fragile and
>>> does not actually work.  Either some #ifdef'fery is needed here or some other,
>>> more explicit, way to eliminate such code, like introducing stub functions.
>>>
>>> I know it's too late and this change is already in, but unfortunately that's
>>> when I noticed this.  While the "Fixes:" tag can't be changed anymore, a more
>>> proper fix for the actual problem (with the proper Fixes tag now) can still
>>> be applied on top of this fix.
>>
>> This works fine on current master on my machine:
>>
>> $ ../configure --cc=clang --target-list=riscv64-softmmu,riscv64-linux-user,riscv32-softmmu,riscv32-linux-user --enable-debug
>> $ make -j
>>
>> So I'm not sure what do you mean by 'actual problem'. If you refer to the non-existence
>> of stub functions, earlier today we had a review by Phil in this patch here where I was
>> adding stubs for all KVM functions:
>>
>> https://lore.kernel.org/qemu-riscv/f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org/
>>
>> Phil mentioned that we don't need a function stub if the KVM only function is protected by
>> "kvm_enabled()". And this is fine, but then, from what you're saying, we can't rely on
>> (kvm_enabled() && foo) working all the time, so we're one conditional away from breaking
>> things it seems.
> 
> Please see:
> 
> https://lore.kernel.org/qemu-devel/20230911211317.28773-1-philmd@linaro.org/T/#t  (fix v4)
> https://lore.kernel.org/qemu-devel/ZP9Cmqgy2H3ypDf3@redhat.com/T/#t (fix v3)
> https://lore.kernel.org/qemu-devel/28c832bc-2fbf-8caa-e141-51288fc0d544@linaro.org/T/#t (fix v2)
> https://lore.kernel.org/qemu-devel/ZP74b%2FByEaVW5bZO@redhat.com/T/#t (fix v1)
> 
> and the original issue at
> https://lore.kernel.org/qemu-devel/8ee6684b-cdc3-78cb-9b76-e5875743bdcf@tls.msk.ru/T/#m65801e9edf31688a45722271a97e628ec98a0c23
> (this is an i386 pullreq which removed stub functions in presence of (!kvm_enabled() && foo)).
> 
> It is exactly the same issue as this one, with exactly the same fix, which resulted in
> breakage.  I dunno why your build succeeded, but the whole thing is.. not easy.

If you take a look at this patch:

[PATCH v2 10/19] target/riscv: remove kvm-stub.c

We're adding stubs for all KVM functions like ARM does in kvm_arm.h.

IIUC this is enough to avoid this scenario where a certain compiler/toolchain might
behave in a way we didn't anticipate and break builds.

I'll add more context in its commit msg mentioning this thread and why adding
stubs is safer than relying on the compiler cropping code via kvm_enabled().


Thanks,

Daniel


> 
> /mjt

