Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42AACAE17
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Jun 2025 14:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4HM-0003zv-J7; Mon, 02 Jun 2025 08:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uM4Gc-0003j4-LR; Mon, 02 Jun 2025 08:27:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uM4Ga-0005FM-Ai; Mon, 02 Jun 2025 08:27:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A91F55CA5A;
 Mon, 02 Jun 2025 14:27:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id jmn--_Kf96R9; Mon,  2 Jun 2025 14:27:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C80255C0CD; Mon, 02 Jun 2025 14:27:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A4E2745683;
 Mon, 02 Jun 2025 14:27:44 +0200 (CEST)
Date: Mon, 2 Jun 2025 14:27:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/13] Pegasos2 clean up and pegasos1 emulation
In-Reply-To: <d4f3967e-24cc-a723-6d19-30b389bdacfd@eik.bme.hu>
Message-ID: <6a47e71e-916c-d0aa-ac3b-a1c1c2eaaf52@eik.bme.hu>
References: <cover.1746139668.git.balaton@eik.bme.hu>
 <d4f3967e-24cc-a723-6d19-30b389bdacfd@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 23 May 2025, BALATON Zoltan wrote:
> On Fri, 2 May 2025, BALATON Zoltan wrote:
>> This series changes how the fdt for VOF is generated in pegasos2 by
>> moving the static parts to a dtb and only generate the changing parts
>> such as memory size and PCI devices programmatically. This simplifies
>> the code and allows simply adding emulation of Pegasos I which has a
>> different north bridge and slightly different memory map but otherwise
>> very similar and can be emulated by reusing parts from the amigaone
>> machine.
>> 
>> The first patch adds an extended DEFINE_MACHINE macro that is later
>> used for more easily define the abstract machine type and hide most of
>> the QOM boiler plate.
>> 
>> The second patch (submitted separetely before, v3 is included here)
>> fixes handling the name property in VOF that cannot be represented in
>> a dts as that always takes the path as the name and cannot accept an
>> explicit name property but we need that to appear when guest queries
>> properties which previously was worked around by adding it to every
>> node.
>
> Ping?

Ping^2

>> Regards,
>> BALATON Zoltan
>> 
>> BALATON Zoltan (13):
>>  hw/boards: Extend DEFINE_MACHINE macro to cover more use cases
>>  ppc/vof: Make nextprop behave more like Open Firmware
>>  hw/ppc/pegasos2: Remove explicit name properties from device tree
>>  hw/ppc/pegasos2: Change device tree generation
>>  hw/ppc/pegasos2: Remove fdt pointer from machine state
>>  hw/ppc/pegasos2: Rename mv field in machine state
>>  hw/ppc/pegasos2: Add south bridge pointer in the machine state
>>  hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
>>  hw/ppc/pegasos2: Move hardware specific parts out of machine reset
>>  hw/ppc/pegasos2: Introduce abstract superclass
>>  hw/ppc/pegasos2: Add bus frequency to machine state
>>  hw/ppc/pegasos2: Add Pegasos I emulation
>>  hw/ppc/pegasos2: Add VOF support for pegasos1
>> 
>> MAINTAINERS              |   1 +
>> hw/ppc/pegasos2.c        | 770 +++++++++++++++++++--------------------
>> hw/ppc/vof.c             |  50 ++-
>> include/hw/boards.h      |  16 +-
>> pc-bios/dtb/meson.build  |   2 +
>> pc-bios/dtb/pegasos1.dtb | Bin 0 -> 857 bytes
>> pc-bios/dtb/pegasos1.dts | 125 +++++++
>> pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>> pc-bios/dtb/pegasos2.dts | 167 +++++++++
>> 9 files changed, 718 insertions(+), 413 deletions(-)
>> create mode 100644 pc-bios/dtb/pegasos1.dtb
>> create mode 100644 pc-bios/dtb/pegasos1.dts
>> create mode 100644 pc-bios/dtb/pegasos2.dtb
>> create mode 100644 pc-bios/dtb/pegasos2.dts
>> 
>> 
>
>

