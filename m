Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B657218AB
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qbf-0000tm-Cz; Sun, 04 Jun 2023 12:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qbc-0000tG-Mv
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:29:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qbY-0007rR-7E
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:29:22 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOzCW-1pgb0i3Xau-00PMQV; Sun, 04 Jun 2023 18:29:16 +0200
Message-ID: <4c50ac7d-aad9-8611-05a2-cf63279e7eca@vivier.eu>
Date: Sun, 4 Jun 2023 18:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ehxjBZsVvSK5S2nw4zFZ5uU+ETOFDx5qocceXhisSGscJRIBrpG
 5jZdbQ0lC9vQia+nTw26AzVRNIS/N9PWW1nXRn1dWEVuEWHy0pnTQ2yU7eoP8t4jZpp1/j+
 A24laMrPdQbwIZn22qp1l8uaA5qvNuAbG/IJS7V71tXehJ0bFwf0FZldRcSqT0WOmXbkRCf
 q5n68d+bMlSKtPv/nSPQw==
UI-OutboundReport: notjunk:1;M01:P0:G/1h3mVeAJ4=;gDl8DZGagu07vJXUyIPFTDfzJYY
 cLhURLVzTtSgyQF9MeyaCs7bQUIguaQwyXh68AIGAvfBRrfXdapqZhES2GLhQexWCFffXl0Yy
 hFNHt0oMM7Rv8/g76OGK4PvaZD+qdyfuOKWYE5DtOkM0ewsuz1qLOmONGyB+lo2S1Uh5Ikc1y
 hL4GHHaMuSGFDi9CjxiZURwVlbjCAftbYae9ulQBYI+Sd7HmHUVJeZM4qCwpScKpR/qiikVOT
 7AgDgEp/6aUIyRPhSorWqCsLxOkZEVMx/t4Z+uv+rtl+7miAvj9TU9FFR9AVG4zl8W99LzGhp
 yfcwH0LGy7UKxzbrDdyjlS81NvEGokCebPCr7m3yO71yDAZrjHpLlbpkc3Nbkui1HnV/TKpuL
 RouUBl/7sXyOuL6LgvgxUrhCJIeuUtNLaLuLAv5GDyMUlFxEkbk01SMijNMgoWimIB892KmqF
 u5SOdWGvS0b9N+MqmV5pfAxcNjYKqEfm7OgyzjlFQZn8kLsKsWMDucEjk1jVQowN0X8Bx9hV7
 9jdqV13KVtyCH6jwFx6OPie2RDqoCrkZIXbRZ7TBkc74Siv9g9Ded7bvGpSgBXNKaXjTe/0U0
 l5LRnPi7AZ0/JKvXuIVM0mS/EurjniwMUbuL9TgXOq/RBUZQe4NtlVt8vQCf0Xes7hWGm/jP6
 oh/Vat9srh2sCjUmzGAF/agecTDXPQSgWiROkILe2g==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 04/06/2023 à 15:14, Mark Cave-Ayland a écrit :
> Also change the instantiation of the mac-nubus-bridge device to use
> object_initialize_child() and map the Nubus address space using
> memory_region_add_subregion() instead of sysbus_mmio_map().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 21 ++++++++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index d6e19ff18c..14879310ca 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -415,14 +415,21 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* NuBus */
>   
> -    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
> -    qdev_prop_set_uint32(dev, "slot-available-mask",
> +    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
> +                            &m->mac_nubus_bridge,
> +                            TYPE_MAC_NUBUS_BRIDGE);
> +    sysbus = SYS_BUS_DEVICE(&m->mac_nubus_bridge);
> +    dev = DEVICE(&m->mac_nubus_bridge);
> +    qdev_prop_set_uint32(DEVICE(&m->mac_nubus_bridge), "slot-available-mask",
>                            Q800_NUBUS_SLOTS_AVAILABLE);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
> -                    MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
> -                    MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
> +    sysbus_realize(sysbus, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(),
> +                                MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE,
> +                                sysbus_mmio_get_region(sysbus, 0));
> +    memory_region_add_subregion(get_system_memory(),
> +                                NUBUS_SLOT_BASE +
> +                                MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE,
> +                                sysbus_mmio_get_region(sysbus, 1));

Why it's not done in PATCH 10?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

