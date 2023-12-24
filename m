Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33F81D8CF
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 12:13:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHMOI-0003Pk-9t; Sun, 24 Dec 2023 06:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHMOC-0003P9-FP; Sun, 24 Dec 2023 06:11:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHMOA-0007op-Ap; Sun, 24 Dec 2023 06:11:24 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB6C675A4C0;
 Sun, 24 Dec 2023 12:11:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id R7IR05kAwLSd; Sun, 24 Dec 2023 12:11:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 720AB75A4B7; Sun, 24 Dec 2023 12:11:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70586756078;
 Sun, 24 Dec 2023 12:11:16 +0100 (CET)
Date: Sun, 24 Dec 2023 12:11:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Shlomo Pongratz <shlomopongratz@gmail.com>
cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: PCIe with Designware RC.
In-Reply-To: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
Message-ID: <2bf508bc-ce4b-870c-1828-b349c96f8102@eik.bme.hu>
References: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 24 Dec 2023, Shlomo Pongratz wrote:
> Hi,
> I'm working on a AARCH64 project that uses the designeware
> (hw/pci-host/designware.c).
> I've copied the designware initialization from hw/arm/fsl-imx7.c and I
> hope I've updated the dtsi correctly.
> After fixing an issue with the iATU windows (see patch
> https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02643.html)
> I've tried to add virtualized NVMe controller.
> When I added the lines:
>        -device nvme,serial=deadbeef,drive=nvme0,bus=pcie \  (Or without bus=)
>        -drive file=/home/pliops/disk-1.img,if=none,id=nvme1 \

You define drive with if=none,id=nvme1 but have drive=nvme0 in your 
device. You should refer to the drive you want the device to use so I 
think it should either be -device nvme,drive=nvme1 or the if of drive 
should be nvme0. I don't know how this works for nvme but for CD drives 
for example adding a device would add it without disk and drive defines 
the disk to use. Not sure this makes sense for hard disks or nvme device 
but maybe the command line options don't consider that.

> I could see in QEMU monitor that the NVMe device was preset i.e.
> (qemu) info pci
>  Bus  0, device   0, function 0:
>    PCI bridge: PCI device 16c3:abcd
>      IRQ 0, pin A
>      BUS 0.
>      secondary bus 1.
>      subordinate bus 255.
>      IO range [0xf000, 0x0fff]
>      memory range [0xfff00000, 0x000fffff]
>      prefetchable memory range [0xfff00000, 0x000fffff]
>      id ""
>  Bus  0, device   1, function 0:
>    Class 0264: PCI device 1b36:0010
>      PCI subsystem 1af4:1100
>      IRQ 0, pin A
>      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
>      id ""
> However in lspci it was missing
> # lspci
> 00:00.0 Class 0604: 16c3:abcd
>
> If I used the following command
>        -drive file=/home/pliops/disk.img,if=none,id=nvme0 \
>        -device nvme,serial=deadbeef,drive=nvme0,bus=dw-pcie \

Here you correctly define both media and drive so it works as expected. 
There are some shortcuts for -drive with media=disk or media=cdrom and 
if=ide or scsi that don't need a separate drive option as if=none does but 
not sure if that supports nvme. You probably have to check documentation 
or code to find out.

> Then in the monitor I see:
> (qemu) info pci
>  Bus  0, device   0, function 0:
>    PCI bridge: PCI device 16c3:abcd
>      IRQ 0, pin A
>      BUS 0.
>      secondary bus 1.
>      subordinate bus 255.
>      IO range [0xf000, 0x0fff]
>      memory range [0x40000000, 0x401fffff]
>      prefetchable memory range [0xfff00000, 0x000fffff]
>      id ""
>  Bus  1, device   0, function 0:
>    Class 0264: PCI device 1b36:0010
>      PCI subsystem 1af4:1100
>      IRQ 1, pin A
>      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
>      id ""
> That is the NVMe is on BUS 1.
> And in lspci I can now see the device but on bus 1.
> # lspci
> 01:00.0 Class 0108: 1b36:0010
> 00:00.0 Class 0604: 16c3:abcd
>
> Is this expected?
>
> But the main problem is that during the initialization of the
> controller registers in BAR0 all the read and writes are actually done
> into the config space.

I don't know what this is but don't think it's related to the above.

Regards,
BALATON Zoltan

> Any ideas?
>
> Thank you
> Shlomo Pongratz.
>
>

