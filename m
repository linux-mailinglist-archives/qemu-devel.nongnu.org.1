Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB77DA888
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 20:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwnus-0004YJ-5w; Sat, 28 Oct 2023 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnuq-0004Y4-Hu; Sat, 28 Oct 2023 14:20:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwnuo-0007Vx-1S; Sat, 28 Oct 2023 14:20:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AD33D756078;
 Sat, 28 Oct 2023 20:20:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 62B377456A7; Sat, 28 Oct 2023 20:20:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5E032745681;
 Sat, 28 Oct 2023 20:20:02 +0200 (CEST)
Date: Sat, 28 Oct 2023 20:20:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <AB7A22F3-8EDF-4E46-965A-6194201EAC98@gmail.com>
Message-ID: <dafc407d-3749-e6f4-3a66-750fde8965f9@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <AB7A22F3-8EDF-4E46-965A-6194201EAC98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> Am 27. Oktober 2023 11:54:48 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> Changes in v7:
>> - Increase default memory size to 512m to match pegasos2 and sam460ex
>> and it's a better default for AmigaOS
>>
>> Changes in v6:
>> - Dropped patch 1, now it's
>>
>> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>>
>> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
>> - Added Tested-by from Rene
>>
>> Changes in v5:
>> - Fixed avocado test
>>
>> Changes in v4:
>> - Found typo in comment in patch 1 so ended up rewording it again
>> trying to make it more concise. Also take the idea of using
>> range_covers_byte from Mark's patch
>> - Added RFC patch for avocado test (untested, I don't have Avocado)
>>
>> Changes in v3:
>> - Update values, comment and commit message in patch 1 again
>>
>> Changes in v2:
>> - Update comment and commit message in patch 1 (Mark)
>> - Fix irq mapping in patch 2 (Volker)
>>
>> Regards,
>> BALATON Zoltan
>>
>> BALATON Zoltan (3):
>>  hw/pci-host: Add emulation of Mai Logic Articia S
>>  hw/ppc: Add emulation of AmigaOne XE board
>>  tests/avocado: Add test for amigaone board
>
> Hi Zoltan,
>
> Could you please provide some documentation on how to run Linux or some 
> other free (as in free beer) OS on this machine?

There are some Linux images here that should work on amigaone:

https://sourceforge.net/projects/amigaone-linux/files/debian-installer/

To boot it get the firmware as described in the comment in amigaone.c or 
in the avocado test then run:

qemu-system-ppc -M amigaone -bios u-boot-amigaone.bin \
-cdrom "A1 Linux Net Installer.iso" -serial stdio \
-device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin

Then from the firmware menu select Boot sequence, Amiga Multiboot Options 
and set Boot device 1 to VIA CDROM then escape back to top level and from 
the exit menu that appears with escape on the main screen select either 
save settings or use settings for current boot. It takes a long time at 
Loading kernel... but eventually boots and you should see the installer 
(or select rescue from the Linux boot menu then at language selection 
Tab to Back button then run shell to get a prompt).

> Can you provide an 
> Avocado test booting e.g. Linux as a quality gate for the VIA south 
> bridges?

I don't know how to automate the above with avocado which seems to run 
with -display none but the Linux iso has hard coded radeonfb so I could 
only do a basic test with the firmware.

> As you know I'm trying to bring these south bridges to the PC machine 
> and relying on hard to get proprietary blobs or OSes makes this very 
> difficult.

I know that the machines and guests I work with are a bit obscure but I 
can't change that. These machines also run Linux and some MorphOS too 
which can be a test case that's available, unfortunately amigaone is not 
supported by MorphOS so only Linux and AmigaOS is available there.

> Whenever the VIA south bridges are changed we end up having 
> endless discussions due to this situation. We need a solution that works 
> for everybody woking on these south bridges.

I afree with that and I think I wasn't the one who started endless 
discussions about every little change to the via model so I think we can 
find a solution that works for all. I'd just like to keep pegasos2 and 
amigaone working with AmigaOS which is my main goal and also keep the 
device model simple and managable.

Regards,
BALATON Zoltan

