Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC32831F21
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:35:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQXDg-0000Mp-8q; Thu, 18 Jan 2024 13:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rQXDc-0000Mb-DM
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:34:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rQXDa-0005gB-5X
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 13:34:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e80046246so6781175e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705602860; x=1706207660; darn=nongnu.org;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+6qKz04124CnrGAYWqcdw7YRmXweMm9elR+NAwchU0=;
 b=P0s3v6r3/lG7iMTzfNCoxRjpR3s9LMq0esKulni82ee8V8ohesZ10XmYcl5sLl9DSn
 +VYZoaF7XGxCov58y3SFY3SCGKy3w8Q0v7XHYv+Ac7djrZSH4K9gFkMqJOrXxbOeRcAE
 ZtvjvE1OWE0ODiZuZWBWd2y+fE5G69uQdlDLtCvmYKzyl93zM2A9WQEU3JrGyi1GZGmO
 Y87YtNPNjNT5edh94F7QslXmetsAJEqO3eWXArmn0HJn6wGsRUkTNC9umlri9aPu2ShR
 nrZa9c08EtCsGOCR1KyVNLJmXGqrcOtMwCS26q2+j4X5dgWzYe4LsHbWMaG5qsevretZ
 CLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705602860; x=1706207660;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+6qKz04124CnrGAYWqcdw7YRmXweMm9elR+NAwchU0=;
 b=CFAuYvf4yXWWcYaVNMRqWJ+AEotS8hKH23a4dvwrK2F5ou+KltfTjrkf95bQFS6U44
 eIHr1Dw3kTOkGi5MnVpP914i9HCQRMPjncgEVfoiO8VA48Ow2xuw4QNypFloUYgqmUxB
 zDQTxKB6HrecdU3Jd86Sq8wAuzPADYlV46NVi42R/5Ea+mILyqBNp0v3xNG0bH5QBE5R
 INu0ap5PlFG25fg428QHKzGGCtgMpCdVitRdPIb2zIUf3U82lQy3vsqpZj80pMjmL9E0
 A1177spHaPn0WGEzdjC7AAgTwpmvAnMZEgU0LJdbSDGdZ5MZBLvB0tfhLrdRcjXrgw1k
 2rig==
X-Gm-Message-State: AOJu0YzxNbtu17u4MDFLPGueshAR38PUmilC0+u/o3hCTjmW0wsD3LsP
 rVrvHg68IyGBoTGoWuwOMpjHV2TqDTTu8YIzUDEx+PHb4E7zQbXm
X-Google-Smtp-Source: AGHT+IGuq52b5SKglFtCa9mev0rqAMG52L8LYDxCckJNX+0HDd8a77eZyGdEodz3+HCp8DXvzPz5eg==
X-Received: by 2002:a05:600c:138a:b0:40e:43ba:cf3f with SMTP id
 u10-20020a05600c138a00b0040e43bacf3fmr1816904wmf.1.1705602859592; 
 Thu, 18 Jan 2024 10:34:19 -0800 (PST)
Received: from [192.168.1.131] ([87.68.195.83])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a5d4251000000b00337d84efaf7sm798376wrr.74.2024.01.18.10.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 10:34:19 -0800 (PST)
Message-ID: <10734892-d466-3075-998e-c85e1020d710@gmail.com>
Date: Thu, 18 Jan 2024 20:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2] Handle wrap around in limit calculation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
References: <20240109124333.224240-1-shlomop@pliops.com>
 <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
 <CAHzK-V2E8EQsh9V2tdqrEF651dPJchA9yLAzrFjFjun1tC8nKg@mail.gmail.com>
 <CAFEAcA-fFRSf2ndOwANjByUCyp0Z_rqjdQgoSHFKumz2041c8g@mail.gmail.com>
 <f20db31b-8f10-6a8d-bb2a-fdc269d6776a@gmail.com>
 <CAFEAcA_x4CyQ0wF7-x-4oq4OUYsuJcbL3xLrz3D0cmWYmfs75w@mail.gmail.com>
In-Reply-To: <CAFEAcA_x4CyQ0wF7-x-4oq4OUYsuJcbL3xLrz3D0cmWYmfs75w@mail.gmail.com>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.748, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

See Inline.

On 15/01/2024 18:47, Peter Maydell wrote:
> On Mon, 15 Jan 2024 at 13:51, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>> On 15/01/2024 12:37, Peter Maydell wrote:
>>> For instance, the kernel code suggests that pre-460A
>>> there's a 32 bit limit register, and post-460A there
>>> is a 64-bit limit (with an "UPPER_LIMIT" register to
>>> access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
>>> flag bit. That suggests we might either:
>>>    (1) implement all that
>>>    (2) say we're implementing a pre-460A version with a
>>>        32 bit limit field
>>> Presumably we're aiming for (2) here, but I find the
>>> arithmetic you have in this patch completely confusing:
>>> it doesn't look like something hardware would be doing
>>> when it has a 64 bit base address register and a 32 bit limit
>>> address register. It's also weird as C code, because you
>>> add 0x100000000 when calculating tlimit, but this will
>>> have no effect because of the AND with 0xffffffff in
>>> the following line.
>>>
>>> My guess at what the hardware is doing is "the actual
>>> limit address takes its low 32 bits from the limit address
>>> register and the high 32 bits from the high 32 bits of
>>> the base address".
>> The original code which claims to be based on i.MX6 Applications Processor
>> actually fails for the example given there in page 4131 where the lower
>> is set to 0xd0000000
>> the upper to 0x8000000 and the limit to 0xd000ffff which gives us a size
>> of 0x8000000000010000,
>> which is a negative number. Therefore some fix need to be done.
> Ah, I hadn't realised that this PCI controller was documented
> in the i.MX6 applications processor reference manual. Looking
> at that I see that the "upper base address register" is documented
> as "Forms bits [63:32] of the start (and end) address of the address
> region to be translated". That "(and end)" part confirms my
> guess that the 64-bit limit address is supposed to be formed by
> putting together the upper-base-address with the limit value.
Actually this is one implementation of one pre-460A and we don't even 
knows which.
And QEMU version is 0 which I assume should be some ideal implementation.
So as I suspect there is an implied HW limitation that a region should 
never cross
4G boundary e.g. [0x80000000fffff000 0x800000010000efff] will be sent as
0x80000000fffff000 and 0xefff resulting in[0x80000000fffff000 
0x800000000000efff]
>> Your suggestion solve this issue and gives the correct address even if
>> the addresses are translated by for example by a multiple of 4G, e.g
>> 0x200000000,
>> but it won't work if the range is translated in a way that is cross 4G
>> boundary (e.g. translate by 0x2ffff000).
>>
>> After reviewing the mathematics I've found a solution which to my
>> humiliation is more simple and it is likely that the HW
>> is doing it, and this is just to ignore the high 32 bits of the
>> calculation's result. That is:
>> const uint64_t size = ((uint64_t)viewport->limit - base + 1) & 0xffffffff;
> That gives the wrong answer for the case where the limit register
> is set to 0xFFFF_FFFF (it will give you 0 rather than 0x1_0000_0000).
This was a typo
The + 1 should have been added after masking.
That is the calculation is done in 32 bit.

     uint32_t tbase;
     uint32_t tsize;
     uint64_t size;
     uint64_t tlimit;

     // Use 32 bit calculation
     tbase = base; // Truncate
     tsize = limit - tbase;
     // Return to 64 bit
     size = tsize;
     size++;

> I think my suggestion is:
>
>     uint64_t base = viewport->base;
>     uint64_t limit = viewport->limit;
>     uint64_t size;
>
>     /*
>      * Versions 460A and above of this PCI controller have a
>      * 64-bit limit register. We currently model the older type
>      * where the limit register is 32 bits, and the upper 32 bits
>      * of the end address are the same as the upper 32 bits of
>      * the start address.
>      */
>     limit = deposit64(limit, 32, 32, extract64(base, 32, 32));
>     size = limit - base + 1;
This will work the only thing is that it will not work if for example
The original range is [0x80000000fffff000 0x800000010000efff]
Stuffing 0x80000000fffff000 0x0efff to your solution yields
size 0xffffffff00010000 and as result a limit of 0x800000000000efff
Note that the 32bit calculation above gives the original values.
Full simulation of all algorithms over some ranges can be found in
my gist 
https://gist.github.com/shlomopongartz/f82466b6044f3a1653890b43b046c443

Anyway I assume that in your opinion we should keep the HW limitation 
and not try to fix the HW
> That's a fairly clear implementation of what the docs say the
> behaviour is, and it gives us a nice easy place to add 64-bit
> limit register support if we ever need to (by guarding the setting
> of 'limit' with an "if 64-bit limit registers not enabled" check).
I'll be glad to see post 460A implementation.
Since until then it will be impossible to use the same device tree in a 
project
where the HW are working in a post-A460 controller and there range 
crosses 4G boundary.
> thanks
> -- PMM


------------------------------------------------------------------------
*From:* Peter Maydell [mailto:peter.maydell@linaro.org]
*Sent:* Monday, January 15, 2024, 6:47 PM
*To:* Shlomo Pongratz
*Cc:* qemu-devel@nongnu.org, andrew.sminov@gmail.com, 
peter.maydell@linaro.com, shlomop@pliops.com
*Subject:* [PATCH V2] Handle wrap around in limit calculation

> On Mon, 15 Jan 2024 at 13:51, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>> On 15/01/2024 12:37, Peter Maydell wrote:
>>> For instance, the kernel code suggests that pre-460A
>>> there's a 32 bit limit register, and post-460A there
>>> is a 64-bit limit (with an "UPPER_LIMIT" register to
>>> access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
>>> flag bit. That suggests we might either:
>>>    (1) implement all that
>>>    (2) say we're implementing a pre-460A version with a
>>>        32 bit limit field
>>> Presumably we're aiming for (2) here, but I find the
>>> arithmetic you have in this patch completely confusing:
>>> it doesn't look like something hardware would be doing
>>> when it has a 64 bit base address register and a 32 bit limit
>>> address register. It's also weird as C code, because you
>>> add 0x100000000 when calculating tlimit, but this will
>>> have no effect because of the AND with 0xffffffff in
>>> the following line.
>>>
>>> My guess at what the hardware is doing is "the actual
>>> limit address takes its low 32 bits from the limit address
>>> register and the high 32 bits from the high 32 bits of
>>> the base address".
>> The original code which claims to be based on i.MX6 Applications Processor
>> actually fails for the example given there in page 4131 where the lower
>> is set to 0xd0000000
>> the upper to 0x8000000 and the limit to 0xd000ffff which gives us a size
>> of 0x8000000000010000,
>> which is a negative number. Therefore some fix need to be done.
> Ah, I hadn't realised that this PCI controller was documented
> in the i.MX6 applications processor reference manual. Looking
> at that I see that the "upper base address register" is documented
> as "Forms bits [63:32] of the start (and end) address of the address
> region to be translated". That "(and end)" part confirms my
> guess that the 64-bit limit address is supposed to be formed by
> putting together the upper-base-address with the limit value.
>
>> Your suggestion solve this issue and gives the correct address even if
>> the addresses are translated by for example by a multiple of 4G, e.g
>> 0x200000000,
>> but it won't work if the range is translated in a way that is cross 4G
>> boundary (e.g. translate by 0x2ffff000).
>>
>> After reviewing the mathematics I've found a solution which to my
>> humiliation is more simple and it is likely that the HW
>> is doing it, and this is just to ignore the high 32 bits of the
>> calculation's result. That is:
>> const uint64_t size = ((uint64_t)viewport->limit - base + 1) & 0xffffffff;
> That gives the wrong answer for the case where the limit register
> is set to 0xFFFF_FFFF (it will give you 0 rather than 0x1_0000_0000).
>
> I think my suggestion is:
>
>     uint64_t base = viewport->base;
>     uint64_t limit = viewport->limit;
>     uint64_t size;
>
>     /*
>      * Versions 460A and above of this PCI controller have a
>      * 64-bit limit register. We currently model the older type
>      * where the limit register is 32 bits, and the upper 32 bits
>      * of the end address are the same as the upper 32 bits of
>      * the start address.
>      */
>     limit = deposit64(limit, 32, 32, extract64(base, 32, 32));
>     size = limit - base + 1;
>
> That's a fairly clear implementation of what the docs say the
> behaviour is, and it gives us a nice easy place to add 64-bit
> limit register support if we ever need to (by guarding the setting
> of 'limit' with an "if 64-bit limit registers not enabled" check).
>
> thanks
> -- PMM

