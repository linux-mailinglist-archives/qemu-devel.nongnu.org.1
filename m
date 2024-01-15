Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDB82DA8E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:52:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNNR-0001Sx-D4; Mon, 15 Jan 2024 08:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rPNNJ-0001S2-CW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:51:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rPNNF-0004O5-SY
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:51:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-336755f1688so7737457f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705326691; x=1705931491; darn=nongnu.org;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ahq7Z6DlU3IlMgdX5gYFVkeXDISghQAXLCrR96tGqZo=;
 b=QOa0b7eT2keOa52tESre8/CkU0FzIFEoc5ve9H8XcZgZNXNSc3K4iu7C/0r2W91AvN
 Q2IRrI7BefbEJKLDa4qmxQOntRe1AO3v2kkciPQwxH0LJnwcolk5BMgMV+7Igk/XzHS4
 oo45nCLP+GgfrFZiU4J7bCN6IeEIkWHv913IVG0eqnyPZ88Xdt3TFvb2Ze18/Y77M31m
 /J83tt8UCeAy8g11TxSRdhNQ0s4+vU9PtlyBZHpITQhc2KaDH0QAXPWU/c6RMsgq3Dci
 EEb2GuZkCHtkLL64ygiEVQMnBAt+5d+9oXCnLZzVB0L6mUH1ISeYTKPCIBVx4UaAZN8F
 3uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705326691; x=1705931491;
 h=content-transfer-encoding:from:in-reply-to:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ahq7Z6DlU3IlMgdX5gYFVkeXDISghQAXLCrR96tGqZo=;
 b=WXhDrEf0jDgFMZyfdI0XZvWrfhA57C4qkgeM+/ysUpWZBUGIrAHjaCHdYjSbzELygs
 ANKzcjm1FF6LmgmYKUNghyGh79PFyIHEHfibXXDTYkBM/E9nO3mFXDjA4HR2WNwRgYKV
 YpQx8Lw1EdZ1zrrw8RB9a7tkPu4k6GgkpCOr1va+MyIl4c4jg84Pldepz6r4iC2BxL2d
 5Ja6mEC1P20GNu8a+NpvOzmdcHdsWL8Be6X4UCyulm1y4WvO2XBN8f3+i3uyj0HzfxFZ
 oisXPHmp9+CTgAZwiFBDUAXDmUAgOiPjAVf9muxk/Kre35MOgrOimFeiHIel9bJeAThA
 G/Rw==
X-Gm-Message-State: AOJu0YxsDz7RsG8EtpDb5Xl5SH3rdPxHZhk5sAKo+Fl9znMPvQ19k8X3
 NHE76HPSJnBg5IC+gHDExzw=
X-Google-Smtp-Source: AGHT+IE72QmEqQt/BzAIWZBqSIkW6/CPnYwwSpXW9M5hd3xHlG/1RUWwuBGIW68bp+pROuPX0VdAUA==
X-Received: by 2002:a5d:4b8b:0:b0:336:779b:97a1 with SMTP id
 b11-20020a5d4b8b000000b00336779b97a1mr2673803wrt.74.1705326690991; 
 Mon, 15 Jan 2024 05:51:30 -0800 (PST)
Received: from [192.168.1.131] ([87.68.195.83])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a05600001c400b003377ba25e48sm11918111wrx.66.2024.01.15.05.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:51:30 -0800 (PST)
Message-ID: <f20db31b-8f10-6a8d-bb2a-fdc269d6776a@gmail.com>
Date: Mon, 15 Jan 2024 15:51:29 +0200
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
In-Reply-To: <CAFEAcA-fFRSf2ndOwANjByUCyp0Z_rqjdQgoSHFKumz2041c8g@mail.gmail.com>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shlomopongratz@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.884, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 15/01/2024 12:37, Peter Maydell wrote:

See inline.
> On Mon, 15 Jan 2024 at 05:58, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>> Thank you.
>> Please see comments inline.
>>
>> On Fri, Jan 12, 2024 at 7:03 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Tue, 9 Jan 2024 at 12:45, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>>>
>>> Hi; thanks for this patch.
>>>
>>>> Hanlde wrap around caused by the fact that perior to version 460A
>>> Is this "460A" version number a version of the hardware
>>> we're modelling ?
>>>
>>>> the limit was 32bit quantity.
>>>> See Linux kernel code in:
>>>> drivers/pci/controllers/dwc/pcie-designware.c
>>> "/controller/"
>>>
>>>> function: __dw_pcie_prog_outbound_atu
>>> There don't seem to be any comments in this kernel function
>>> that say anything about wrap-around:
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-designware.c#L468
>>>
>>> so I'm not sure what you're trying to explain by referring to it.
>> This is just to give some  context.
>> If you look at the original submission of the controller patch d64e5eabc4c7e20c
>> pci: Add support for Designware IP block by Andrey Smirnov it is written there
>> "Add code needed to get a functional PCI subsytem when using in
>>      conjunction with upstream Linux guest (4.13+)."
>>>> Now in a 64bit system the range can be above 4G but as long as
>>>> the limit itself is less then 4G the overflow is avoided
>>>>
>>>> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>>>>
>>>> ----
>>>>
>>>> Changes since v1:
>>>>   * Seperate subject and description
>>>> ---
>>>>   hw/pci-host/designware.c | 15 ++++++++++++++-
>>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>>>> index dd9e389c07..7ce4a6b64d 100644
>>>> --- a/hw/pci-host/designware.c
>>>> +++ b/hw/pci-host/designware.c
>>>> @@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>>>>   {
>>>>       const uint64_t target = viewport->target;
>>>>       const uint64_t base   = viewport->base;
>>>> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
>>>>       const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
>>>> +    uint64_t tbase, tlimit, size;
>>>>
>>>>       MemoryRegion *current, *other;
>>>>
>>>> +    /*
>>>> +     * Hanlde wrap around caused by the fact that perior to version 460A
>>>> +     * the limit was 32bit quantity.
>>>> +     * See Linux kernel code in:
>>>> +     * drivers/pci/controllers/dwc/pcie-designware.c
>>>> +     * function: __dw_pcie_prog_outbound_atu
>>>> +     * Now in a 64bit system the range can be above 4G but as long as
>>>> +     * the limit itself is less then 4G the overflow is avoided
>>>> +     */
>>>> +    tbase = base & 0xffffffff;
>>>> +    tlimit = 0x100000000 + (uint64_t)viewport->limit;
>>>> +    size = ((tlimit - tbase) & 0xffffffff) + 1;
>>>> +
>>> I find this patch a bit confusing, partly because the comment
>>> seems to be written from the perspective of what the kernel
>>> driver is doing, not from the perspective of the hardware
>>> behaviour.
>>>
>> Again I refer to the original patch comment.
>> The original patch was written to support Linux kernel 4.13+ and a
>> specific implementation i.MX6 Applications Processor.
>> I've looked at the i.MX6 reference manual and it was silent regarding
>> the wrap-around case.
>> There is no reference to the  relevant Synopsys' Designware's specification.
>> Note that the pci version of the QEMU is 0, therefore I assume that
>> the implementation was tailored
>> to a specific implementation.
>>> What is the behaviour of the actual hardware here, both before
>>> and after 460A ? Which version are we trying to model?
>> I don't have access to the pantora of Synopsys' Designware's root port.
>> I can only conclude from the Linux kernel code that although the base
>> address was always 64 bit quantity,
>> then before version 460A that the limit quantity was 32 bit quantity
>> and from version 460A it is 64 bit quantity.
>> And the document that the original patch was based on didn't say what
>> is the behavior in case of wrap around.
>> I don't want to model any specific version, I just want to work with
>> device tree definitions that has regions above 4G,
>> which are possible since the base address is 64 bit quantity as long
>> as the regions size are
>> less teh 4G.
> But we must model *something*, which is ideally "what the spec
> says" or possibly "what some specific version is". In this
> particular case, we need to be clear about whether we are
> modelling the pre-460A behaviour or the 460A-and-onward
> behaviour. "This change seems to be enough to make Linux
> work" is generally not sufficient to justify it.
>
> If all we have is the Linux driver code then the flow
> has to be:
>   * look at what the kernel does
>   * deduce what we think the hardware implementation must
>     be, based on that plus common sense about what is and
>     isn't typical and easy for hardware to do
>   * implement that, with comments about where we're making
>     guesses
>
> For instance, the kernel code suggests that pre-460A
> there's a 32 bit limit register, and post-460A there
> is a 64-bit limit (with an "UPPER_LIMIT" register to
> access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
> flag bit. That suggests we might either:
>   (1) implement all that
>   (2) say we're implementing a pre-460A version with a
>       32 bit limit field
> Presumably we're aiming for (2) here, but I find the
> arithmetic you have in this patch completely confusing:
> it doesn't look like something hardware would be doing
> when it has a 64 bit base address register and a 32 bit limit
> address register. It's also weird as C code, because you
> add 0x100000000 when calculating tlimit, but this will
> have no effect because of the AND with 0xffffffff in
> the following line.
>
> My guess at what the hardware is doing is "the actual
> limit address takes its low 32 bits from the limit address
> register and the high 32 bits from the high 32 bits of
> the base address".
The original code which claims to be based on i.MX6 Applications Processor
actually fails for the example given there in page 4131 where the lower 
is set to 0xd0000000
the upper to 0x8000000 and the limit to 0xd000ffff which gives us a size 
of 0x8000000000010000,
which is a negative number. Therefore some fix need to be done.

Your suggestion solve this issue and gives the correct address even if 
the addresses are translated by for example by a multiple of 4G, e.g 
0x200000000,
but it won't work if the range is translated in a way that is cross 4G 
boundary (e.g. translate by 0x2ffff000).

After reviewing the mathematics I've found a solution which to my 
humiliation is more simple and it is likely that the HW
is doing it, and this is just to ignore the high 32 bits of the 
calculation's result. That is:
const uint64_t size = ((uint64_t)viewport->limit - base + 1) & 0xffffffff;

So this brings the implementation to complies with the spec it claims 
that it is based upon.
Is this acceptable or you have a counter example.?

> thanks
> -- PMM

------------------------------------------------------------------------
*From:* Peter Maydell [mailto:peter.maydell@linaro.org]
*Sent:* Monday, January 15, 2024, 12:37 PM
*To:* Shlomo Pongratz
*Cc:* qemu-devel@nongnu.org, andrew.sminov@gmail.com, 
peter.maydell@linaro.com, shlomop@pliops.com
*Subject:* [PATCH V2] Handle wrap around in limit calculation

> On Mon, 15 Jan 2024 at 05:58, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>> Thank you.
>> Please see comments inline.
>>
>> On Fri, Jan 12, 2024 at 7:03 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Tue, 9 Jan 2024 at 12:45, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>>>
>>> Hi; thanks for this patch.
>>>
>>>> Hanlde wrap around caused by the fact that perior to version 460A
>>> Is this "460A" version number a version of the hardware
>>> we're modelling ?
>>>
>>>> the limit was 32bit quantity.
>>>> See Linux kernel code in:
>>>> drivers/pci/controllers/dwc/pcie-designware.c
>>> "/controller/"
>>>
>>>> function: __dw_pcie_prog_outbound_atu
>>> There don't seem to be any comments in this kernel function
>>> that say anything about wrap-around:
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-designware.c#L468
>>>
>>> so I'm not sure what you're trying to explain by referring to it.
>> This is just to give some  context.
>> If you look at the original submission of the controller patch d64e5eabc4c7e20c
>> pci: Add support for Designware IP block by Andrey Smirnov it is written there
>> "Add code needed to get a functional PCI subsytem when using in
>>      conjunction with upstream Linux guest (4.13+)."
>>>> Now in a 64bit system the range can be above 4G but as long as
>>>> the limit itself is less then 4G the overflow is avoided
>>>>
>>>> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>>>>
>>>> ----
>>>>
>>>> Changes since v1:
>>>>   * Seperate subject and description
>>>> ---
>>>>   hw/pci-host/designware.c | 15 ++++++++++++++-
>>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>>>> index dd9e389c07..7ce4a6b64d 100644
>>>> --- a/hw/pci-host/designware.c
>>>> +++ b/hw/pci-host/designware.c
>>>> @@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>>>>   {
>>>>       const uint64_t target = viewport->target;
>>>>       const uint64_t base   = viewport->base;
>>>> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
>>>>       const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
>>>> +    uint64_t tbase, tlimit, size;
>>>>
>>>>       MemoryRegion *current, *other;
>>>>
>>>> +    /*
>>>> +     * Hanlde wrap around caused by the fact that perior to version 460A
>>>> +     * the limit was 32bit quantity.
>>>> +     * See Linux kernel code in:
>>>> +     * drivers/pci/controllers/dwc/pcie-designware.c
>>>> +     * function: __dw_pcie_prog_outbound_atu
>>>> +     * Now in a 64bit system the range can be above 4G but as long as
>>>> +     * the limit itself is less then 4G the overflow is avoided
>>>> +     */
>>>> +    tbase = base & 0xffffffff;
>>>> +    tlimit = 0x100000000 + (uint64_t)viewport->limit;
>>>> +    size = ((tlimit - tbase) & 0xffffffff) + 1;
>>>> +
>>> I find this patch a bit confusing, partly because the comment
>>> seems to be written from the perspective of what the kernel
>>> driver is doing, not from the perspective of the hardware
>>> behaviour.
>>>
>> Again I refer to the original patch comment.
>> The original patch was written to support Linux kernel 4.13+ and a
>> specific implementation i.MX6 Applications Processor.
>> I've looked at the i.MX6 reference manual and it was silent regarding
>> the wrap-around case.
>> There is no reference to the  relevant Synopsys' Designware's specification.
>> Note that the pci version of the QEMU is 0, therefore I assume that
>> the implementation was tailored
>> to a specific implementation.
>>> What is the behaviour of the actual hardware here, both before
>>> and after 460A ? Which version are we trying to model?
>> I don't have access to the pantora of Synopsys' Designware's root port.
>> I can only conclude from the Linux kernel code that although the base
>> address was always 64 bit quantity,
>> then before version 460A that the limit quantity was 32 bit quantity
>> and from version 460A it is 64 bit quantity.
>> And the document that the original patch was based on didn't say what
>> is the behavior in case of wrap around.
>> I don't want to model any specific version, I just want to work with
>> device tree definitions that has regions above 4G,
>> which are possible since the base address is 64 bit quantity as long
>> as the regions size are
>> less teh 4G.
> But we must model *something*, which is ideally "what the spec
> says" or possibly "what some specific version is". In this
> particular case, we need to be clear about whether we are
> modelling the pre-460A behaviour or the 460A-and-onward
> behaviour. "This change seems to be enough to make Linux
> work" is generally not sufficient to justify it.
>
> If all we have is the Linux driver code then the flow
> has to be:
>   * look at what the kernel does
>   * deduce what we think the hardware implementation must
>     be, based on that plus common sense about what is and
>     isn't typical and easy for hardware to do
>   * implement that, with comments about where we're making
>     guesses
>
> For instance, the kernel code suggests that pre-460A
> there's a 32 bit limit register, and post-460A there
> is a 64-bit limit (with an "UPPER_LIMIT" register to
> access the top 32 bits), plus a PCIE_ATU_INCREASE_REGION_SIZE
> flag bit. That suggests we might either:
>   (1) implement all that
>   (2) say we're implementing a pre-460A version with a
>       32 bit limit field
> Presumably we're aiming for (2) here, but I find the
> arithmetic you have in this patch completely confusing:
> it doesn't look like something hardware would be doing
> when it has a 64 bit base address register and a 32 bit limit
> address register. It's also weird as C code, because you
> add 0x100000000 when calculating tlimit, but this will
> have no effect because of the AND with 0xffffffff in
> the following line.
>
> My guess at what the hardware is doing is "the actual
> limit address takes its low 32 bits from the limit address
> register and the high 32 bits from the high 32 bits of
> the base address".
>
> thanks
> -- PMM

