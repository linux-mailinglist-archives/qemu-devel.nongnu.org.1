Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69F82DE53
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:18:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQas-0007Yg-EA; Mon, 15 Jan 2024 12:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPQaq-0007Wk-0L; Mon, 15 Jan 2024 12:17:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPQan-0005EC-NT; Mon, 15 Jan 2024 12:17:47 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so43418655ad.0; 
 Mon, 15 Jan 2024 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705339063; x=1705943863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=By+KDuv+DTNH782I1f+FHohKLhnGVSKigmZJmhb2Kxs=;
 b=Pt7PuCsWBO46h6vjjQq3YqZ2FIgFkdQVbv8KV9l31JpJjOR18fa7vvSfxLfqtvfiRv
 qXCT3cS6krcl0sBpsbYmz4EwzwcWAQ3Clz7gYB9nlDMH4tCqE9JWnxr+OE43Q15NjFsy
 TPsa6q6NOHKVip1EkD7hYVOqe+Z5buKKm1aVPvvzQNwI92gyDKZ0c8Wb3X3W1/md6FzQ
 79jbjy8nXOyebC4ZfvtBGA4zy/JHhtrF5H4e8KW17OXIDH9W6J/BoUMPtgojS9iIgf3K
 CM1Oev1mPE7dvhCVv5zNLSf7rCzyDXCZYUEFZL7PlKiSeyFCqBuD5KKtRj9gfbXCI/iu
 Z7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705339063; x=1705943863;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=By+KDuv+DTNH782I1f+FHohKLhnGVSKigmZJmhb2Kxs=;
 b=v9N2yx1ttkLEFXGfMSIBvaas8MGnr/sw6JIL3iXHBe4PN5HHU5CLfSL1t5UAro1ULH
 +bb2JMDe466Q7efoHr1UsfBkyWL21Y4EqjUHk54awOygyOO2/Wk7KzIjtDKcWgXgzdec
 9ACUf8VTAnhTUMsH+oGkRCyeDt9qqIBYfdtS0j1MJIk9H45BYx8cy3eHZlKpa/TVlERz
 NYm26VUlp2otZygNQ9Nrvjfvrp5Xn/SWawsFiJ+liosv0Mp+nX0B9G357lulvE4uAmaG
 TlIHC9cYGxZq3uY7Foeri6NdvwnONFl2D4PJvWH+sj7lG7fvGd+EkeBNMdWVxGhR816l
 llfQ==
X-Gm-Message-State: AOJu0YxvQg0uEGnPaZhuI5u7Ei5OeLO9SYUZVgIKwksSL5wwduaTNIIu
 dWe/458vBvunr3RGWufFnGY=
X-Google-Smtp-Source: AGHT+IEdy0vaqGNmGHa3PNEWzs4URWNFl77vo6oLcva2e0hc5KwrhGKcmEgGjzfO11Yf0oRjQoPsyw==
X-Received: by 2002:a17:903:11cc:b0:1d4:2330:85a3 with SMTP id
 q12-20020a17090311cc00b001d4233085a3mr3536517plh.20.1705339063438; 
 Mon, 15 Jan 2024 09:17:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a170902758800b001d493ff1fcdsm7762088pll.120.2024.01.15.09.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 09:17:42 -0800 (PST)
Message-ID: <1c3e4723-bf24-4c5e-8329-db76fbcf0716@roeck-us.net>
Date: Mon, 15 Jan 2024 09:17:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/arm: Add EHCI/OHCI controllers to Allwinner R40
 and Bananapi board
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20240113191651.1313226-1-linux@roeck-us.net>
 <20240113191651.1313226-2-linux@roeck-us.net>
 <56f692d8-41b1-4126-96b9-80d274624984@linaro.org>
 <56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net>
 <bcfd42d5-1c48-4126-913a-a5251c3cc9c7@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <bcfd42d5-1c48-4126-913a-a5251c3cc9c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/15/24 08:30, Philippe Mathieu-Daudé wrote:
> On 15/1/24 17:12, Guenter Roeck wrote:
>> On 1/15/24 03:02, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 13/1/24 20:16, Guenter Roeck wrote:
>>>> Allwinner R40 supports two USB host ports shared between a USB 2.0 EHCI
>>>> host controller and a USB 1.1 OHCI host controller. Add support for both
>>>> of them.
>>>>
>>>> If machine USB support is not enabled, create unimplemented devices
>>>> for the USB memory ranges to avoid crashes when booting Linux.
>>>
>>> I never really understood the reason for machine_usb() and had on my
>>> TODO to do some archeology research to figure it out since quite some
>>> time. Having to map an UnimpDevice due to CLI options seems like an
>>> anti-pattern when the device is indeed implemented in the repository.
>>>
>>
>> Me not either. I copied the code from aw_a10_init(), trying to use the
>> same pattern. I am perfectly fine with making it unconditional, but then
>> I would argue that it should be unconditional for Allwinner A10 as well
>> (not that I really care much, just for consistency).
> 
> Certainly, but I'd rather have a global pattern cleanup, not just
> Allwinner based machines. Looking at the repository:
> 
> $ git grep -w machine_usb hw/
> hw/arm/allwinner-a10.c:82:    if (machine_usb(current_machine)) {
> hw/arm/allwinner-a10.c:168:    if (machine_usb(current_machine)) {
> hw/arm/nseries.c:1356:    if (machine_usb(machine)) {
> hw/arm/realview.c:288:        if (machine_usb(machine)) {
> hw/arm/realview.c-289-            pci_create_simple(pci_bus, -1, "pci-ohci");
> hw/arm/versatilepb.c:276:    if (machine_usb(machine)) {
> hw/arm/versatilepb.c-277-        pci_create_simple(pci_bus, -1, "pci-ohci");
> hw/core/machine.c:1175:bool machine_usb(MachineState *machine)
> hw/i386/acpi-microvm.c:88:    if (machine_usb(MACHINE(mms))) {
> hw/i386/acpi-microvm.c-89-        xhci_sysbus_build_aml(scope, MICROVM_XHCI_BASE, MICROVM_XHCI_IRQ);
> hw/i386/microvm.c:218:    if (x86_machine_is_acpi_enabled(x86ms) && machine_usb(MACHINE(mms))) {
> hw/i386/microvm.c-225-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MICROVM_XHCI_BASE);
> hw/i386/pc_piix.c:267: machine_usb(machine), &error_abort);
> hw/i386/pc_q35.c:321:    if (machine_usb(machine)) {
> hw/i386/pc_q35.c-323-        ehci_create_ich9_with_companions(host_bus, 0x1d);
> hw/ppc/mac_oldworld.c:300:    if (machine_usb(machine)) {
> hw/ppc/mac_oldworld.c-301-        pci_create_simple(pci_bus, -1, "pci-ohci");
> 
> I'd classify that as "USB controller over MMIO / over some bus (PCI)".
> 
> The "plug a PCI-to-USB card by default" seems a valid use case (except
> for Q35 which is a Frankenstein case, ICH9 chipset is like ARM SoC,
> USB bus is always there).
> 
> IMHO all the MMIO uses should be corrected.
> 
>> The "-usb" option says "enable on-board USB host controller (if not
>> enabled by default)". Unfortunately, that doesn't tell me much,
>> and most specifically it doesn't tell me how to enable it by default.
>> One option I can think of would be to enable it on the machine level,
>> i.e., from bananapi_m2u.c, but then, again, I don't see if/how
>> that is done for other boards. Any suggestions ?
>>
>> Of course, I could discuss this with the person who implemented this
>> code for A10, but it turns out that was me, for no good reason than
>> that I tried to follow the pattern I had seen elsewhere without really
>> understanding what I was doing.
>>
>> So should I drop the conditional from H40 and send a separate patch
>> to drop it from the A10 code as well, following your line of argument ?
>> Or drop it and leave A10 alone ?
> 
> Well your patch isn't invalid, so:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

I'll send v2 anyway, especially taking your other patch series into account.

Thanks,
Guenter


