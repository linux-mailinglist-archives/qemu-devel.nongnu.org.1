Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45BBA40AC7
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Feb 2025 18:53:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tltgC-0000ct-2s; Sat, 22 Feb 2025 12:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tltg2-0000aT-VJ; Sat, 22 Feb 2025 12:52:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tltg1-0008FL-BC; Sat, 22 Feb 2025 12:52:34 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 51E6C4E603D;
 Sat, 22 Feb 2025 18:52:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id AgLjVDT4CUU0; Sat, 22 Feb 2025 18:52:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0EF944E6001; Sat, 22 Feb 2025 18:52:27 +0100 (CET)
Message-Id: <cover.1740243918.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/4] ppc/amigaone patches
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Sat, 22 Feb 2025 18:52:27 +0100 (CET)
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

Hello,

This series adds NVRAM and support for -kernel, -initrd and -append
options to the amigaone machine. This makes it easier to boot AmigaOS
and avoids a crash in the guest when it tries to access NVRAM.

While the -kernel option emulates what U-Boot passes to the kernel,
old Linux kernels for amigaone may not work with it because of two
reasons: these come in legacy U-Boot Multi-File image format that QEMU
cannot read and even after unpacking that and creating a kernel uimage
it won't find PCI devices because it does not initialise them
correctly. This works when booted from U-Boot because U-Boot inits PCI
devices. So does my BBoot loader which can be used to load AmigaOS so
I don't intend to emulate that part of U-Boot.

I'd like this to be merged for the next release please. When merging
please update https://wiki.qemu.org/ChangeLog/10.0 with the following:

amigaone

Added support for NVRAM and -kernel, -initrd, -append command line
options. By default the NVRAM contents are not preserved between
sessions. To make it persistent create a backing file with 'qemu-image
create -f raw nvram.bin 4k' and add -drive
if=mtd,format=raw,file=nvram.bin to keep NVRAM contents in the backing
file so settings stored in it will be preserved between sessions.

To run AmigaOS with BBoot using the -kernel option at least BBoot
version 0.8 is needed. Older BBoot versions only work with -device
loader and cannot be used with -kernel on amigaone.

Regards,

BALATON Zoltan (4):
  ppc/amigaone: Simplify replacement dummy_fw
  ppc/amigaone: Implement NVRAM emulation
  ppc/amigaone: Add default environment
  ppc/amigaone: Add kernel and initrd support

 hw/ppc/amigaone.c | 269 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 8 deletions(-)

-- 
2.30.9


