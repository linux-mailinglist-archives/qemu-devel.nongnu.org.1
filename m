Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5104721D9E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 07:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q630m-00005Y-Vt; Mon, 05 Jun 2023 01:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q630f-00005O-RD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 01:44:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q630e-0002gS-4Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 01:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+W2kxFn/pmZDULhZm8DoZhtnbeqtzC3+zjivZul1pLQ=; b=Kf/rbJHDjvT5bY2x0rdQ1phkJw
 YDt3Fi2WlSfvR3fm+r8SgC16ZyaFSeD848WPCn9q+LWjjXFISDKJvxov76DMBtBaAAXe8fnwYq2qI
 emvQYgOlUn8AdKtyewexHd0KH45hx6mmc4/3g3x8v0w8h8XN4GrkNrEx4QfTyNhlTowiBW2QLw+lz
 dXLZQoHHBfNpE8hbAjNUXLH4GSdICMg+iXbtkBHPYo8Nip33/f53mOpUfhMWSLXTZEKGEnAPRVZ+Y
 DFH7vWWxKUR7vdlKrZq7/P7/20RAlQ7kN8GEnB8cSF8mO4abL69zvB05nZEHVeG7vUbO3nEMBCQpV
 5t0GUhxkHaHW4OCPERbCvX5Boaw1LaqJzyJknfIwEwN9Yzaz9JHNhHZxg6PAhIgJt+aZYObwz347w
 uvSgHS9dFKN3w+0CggBOYIuJpy0xEEiCr1AgLIAvhpIpdH+1yEspUHA9bS2STxchjG0L7FojpRFjs
 ktjGqfrZPbkS9+z8CouXYpN+P7g3LvwO2Urrqv+4r7o2uANAX2vjvxHG6pRElDHXS6uqClEATNgMN
 zXdtRgjqz5q5oJyPAq+tPDiS3iScPade5CIxInSO2QeZYqV2piRv20BPRRPvViybhisbC1bTc7Gpd
 ADgxk9EKK1ZeRXF/7hQC5FrOseLQxkS5KOynXj0A0=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q630V-00036e-Kj; Mon, 05 Jun 2023 06:43:59 +0100
Message-ID: <00f70f1d-ad54-bd70-270b-d0dfdf67940a@ilande.co.uk>
Date: Mon, 5 Jun 2023 06:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
 <4c50ac7d-aad9-8611-05a2-cf63279e7eca@vivier.eu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <4c50ac7d-aad9-8611-05a2-cf63279e7eca@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 04/06/2023 17:29, Laurent Vivier wrote:

> Le 04/06/2023 à 15:14, Mark Cave-Ayland a écrit :
>> Also change the instantiation of the mac-nubus-bridge device to use
>> object_initialize_child() and map the Nubus address space using
>> memory_region_add_subregion() instead of sysbus_mmio_map().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/q800.c         | 21 ++++++++++++++-------
>>   include/hw/m68k/q800.h |  2 ++
>>   2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index d6e19ff18c..14879310ca 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -415,14 +415,21 @@ static void q800_machine_init(MachineState *machine)
>>       /* NuBus */
>> -    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
>> -    qdev_prop_set_uint32(dev, "slot-available-mask",
>> +    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
>> +                            &m->mac_nubus_bridge,
>> +                            TYPE_MAC_NUBUS_BRIDGE);
>> +    sysbus = SYS_BUS_DEVICE(&m->mac_nubus_bridge);
>> +    dev = DEVICE(&m->mac_nubus_bridge);
>> +    qdev_prop_set_uint32(DEVICE(&m->mac_nubus_bridge), "slot-available-mask",
>>                            Q800_NUBUS_SLOTS_AVAILABLE);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
>> -                    MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
>> -                    MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
>> +    sysbus_realize(sysbus, &error_fatal);
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE,
>> +                                sysbus_mmio_get_region(sysbus, 0));
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                NUBUS_SLOT_BASE +
>> +                                MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE,
>> +                                sysbus_mmio_get_region(sysbus, 1));
> 
> Why it's not done in PATCH 10?

Patch 10 is concerned with devices mapped into the macio aliased memory space, 
whereas the mac-nubus-bridge device is mapped into the system memory address space 
(I'm not a fan of sysbus_mmio_map() because the "system memory space" isn't often 
well-defined: I much prefer to make the mapping explicit).

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks!


ATB,

Mark.


