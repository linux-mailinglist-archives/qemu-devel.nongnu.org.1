Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C84AD82C834
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 01:07:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rORWv-0002Hm-Od; Fri, 12 Jan 2024 19:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rORWu-0002Hd-Ac
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:05:40 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rORWq-0003qU-GB
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:05:39 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbc755167fso6296319b6e.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 16:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705104335; x=1705709135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07+I2tLyTQDnkMkQ2kD9YoE9CBNuWcnai4Dbb1T/f+c=;
 b=GRhfamgp+fJa8Taa77QBfxhcLMe5XW622WPHq1mBDWbzyfTF4jZFPWMIFBPwIoB1gn
 0jKAEjuLcr9rPNNljKkzjcI+LBCqD6WN6/RKP7pdzQjQkwn32kPA0EUqO7fIthHLLnCj
 Wn1ltYFXlZNMW6zDm3iSFfqQpN3PbnviUXXYSo5h4bkLK9QPYmOWegwu3/apqgnxuuUF
 XoJG68VQyEV7iTlzHTJVvfPOroQ3J+SdeifOCmJ24DYKm0Qx5oUMbe9HB985mrJoVwVm
 C+DaM4gMxquCJOIz5PydAfuoJql8KOmid0D4hXI5RCh3Lr/8aMDQ07Qu1Vm1U7FNmXu6
 IvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705104335; x=1705709135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07+I2tLyTQDnkMkQ2kD9YoE9CBNuWcnai4Dbb1T/f+c=;
 b=Ia+UVYBPHhy4TNGkwEtN2nUSzKSUkDRt6Dr0ZxuY2ly2t3FvuTZMq3z33TtxykMoxF
 m/WzBBKJ6VVI5nFQc+96g0ctNi1CoTJ3R9yP3x9et9MD8HAQp+eiAGiHkGyZM8DDEhI8
 0wF5YZ6NVuF9BTF8qNL5jwN6XAXE7Y62TNduxcP+5m6AK0F+BPankvNMvwJHJhLYrXhc
 2e+HS2UzsZal7IV90n9Vvjnq46OvmuxzIl/qGfYeV602qaaBYxeMx7ljwZPJEr9CAsrR
 5bBKBbgxrZtTQOz86invKjrAuOb3Z8eVCIj3IxKO8L14aRs/NimXnSuNZ62OQYM8apy/
 rCNw==
X-Gm-Message-State: AOJu0YxbbwqIxAnE1j5NxO82JaH7ZqIWI/SasHHVc6jdrGhxbF295a7+
 4gfrvrOcZVwcZ6v4sawueU/kTbpUA+0Gnw==
X-Google-Smtp-Source: AGHT+IEqpq+wOfr4/I3v82ZttF7HvRU664zrgXysf1CSUhWIfQaNR3r2QrqZcbLeZQIRId5dxL0t4A==
X-Received: by 2002:a05:6808:3988:b0:3bb:c8ef:1c3d with SMTP id
 gq8-20020a056808398800b003bbc8ef1c3dmr2678669oib.5.1705104335005; 
 Fri, 12 Jan 2024 16:05:35 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 k19-20020aa790d3000000b006d99e005ea6sm3710280pfk.160.2024.01.12.16.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 16:05:34 -0800 (PST)
Message-ID: <db63ee9b-901a-48ab-beca-4275e12a88d0@linaro.org>
Date: Sat, 13 Jan 2024 11:05:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/21] linux-user/riscv: Add vdso
Content-Language: en-US
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Edwin Lu <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
 <20231030211727.165090-16-richard.henderson@linaro.org>
 <d5265d3a-7df7-4f93-93c4-a5d3a6251372@rivosinc.com>
 <119848b9-0cd7-4d33-bc43-385c86069388@linaro.org>
 <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b84e0809-669f-49c9-8163-847485cfe7e4@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/13/24 10:37, Vineet Gupta wrote:
> 
> 
> On 1/12/24 13:35, Richard Henderson wrote:
>> On 1/12/24 08:49, Vineet Gupta wrote:
>>> Hi Richard, Alistair
>>>
>>> On 10/30/23 14:17, Richard Henderson wrote:
>>>> diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
>>>> new file mode 100644
>>>> index 0000000000..2c257dbfda
>>>> --- /dev/null
>>>> +++ b/linux-user/riscv/Makefile.vdso
>>>> @@ -0,0 +1,15 @@
>>>> +include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
>>>> +
>>>> +SUBDIR = $(SRC_PATH)/linux-user/riscv
>>>> +VPATH += $(SUBDIR)
>>>> +
>>>> +all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
>>>> +
>>>> +LDFLAGS = -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
>>>> +	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
>>>> +
>>>> +$(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
>>>> +	$(CC) -o $@ $(LDFLAGS) -mabi=ilp32d -march=rv32g $<
>>>> +
>>>> +$(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
>>>> +	$(CC) -o $@ $(LDFLAGS) -mabi=lp64d -march=rv64g $<
>>> So by default qemu ships the vdso binary. How can one rebuild it ?
>>>
>>>   From skimming the build files it seems following ought to do it
>>>       make update-linux-vdso
>>>
>>> with a prior configure cmd like below with PATH pointing to the cross
>>> compiler.
>>> ../configure  --target-list=riscv64-linux-user
>>> --cross-cc-riscv64=riscv64-unknown-linux-gnu-gcc
>> Yes, that should do it.
>>
>>> But it doesn't, I'm sure we are missing something basis here.
>> Do you get an error message?
>> Did $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak get created properly?
> 
> It was indeed, but invoking make wasn't doing anything.

Odd.  It Just Works here...

What do you have in the "Cross compilers" section of the configure output?

I would expect '--cross-prefix-riscv64=...' to be a better option that just gcc.  And if 
you have it installed as "riscv64-linux-gnu-", I would not expect you to need to provide 
any configure option at all -- it should be auto-detected.



