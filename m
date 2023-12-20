Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA55819FBC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:21:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwRl-0007pU-Qr; Wed, 20 Dec 2023 08:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRa-0007nG-CN
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRW-0002Hs-5N
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GdQzFgUng5NCtMBt95d3bcQ5ob2ptfcvdVnMkAvdw5s=; b=HWvZrwfutYsw8yBtVKCp3RvjvI
 PRDo1+VStoGQ2brznr6dCF7lBmtpxfk2I4YqUZNae9UZtke5pMdbNlugmvTI8gZHf8G9cGKHqdYYS
 OwjGmCq/mjXL/8j+YRplE70J8qA/QifrpFHFZxLmgPgdfzi2e8bDF7IsvdHEbMRsFZk6pnNvhupAh
 wHoNgTCMaSmoIFugJlQSXnq602pfkkI3HY75/Gve31Dh7B7ZSeJgJHaOjqh5gs5xBRzjSCCX/A4rH
 MVh5qezi7R33enPCFDCLkRw1HdkPex8kTn/JKty9s/bKafsAofwbCH4SUq9Tp9tQRTpxVZpbMMFUO
 zj/FrLVC0bVrU6fJ7i0wiHsnkMK1O9wtkp8GLoQaJnMS1q+XM8IZ1dza1jB/iReO78k2lKdZZe0iR
 5xYlGikYmY56GLhEpktvObDkOL5RWEY+vChIfHxcD3dhSybh5KEhdgabypPyosSJiYgqEEU8WSnos
 cEH1THbIaYhW+nqM3/9jBK+DIjgDrra0Psz328fpidRKgMjTD7X6WAI76qJHGzoEkZ90EDMv1P6Mx
 w48ZD46+PLT125NPlB3uW4ttqvgZYFkIreNBKgrND+QXo6zZyd3lw4cRb2zBIHlN2RLZrHEUp4Bbn
 idWZKCDw2gOVyBSSj0h56hAxBpVX2g6MeAUDwfwv0=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwQv-0001qt-Jx; Wed, 20 Dec 2023 13:16:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:30 +0000
Message-Id: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/11] next-cube: various tidy-ups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series contains some tidy-ups/improvements for the next-cube machine with
the aim of bringing the code up-to-date with our latest coding guidelines.

The main aim of the series is to bring the memory accessors up-to-date with
the memory API and improve some of basic machine modelling. There are still
some future improvements that can be made: for example switching from DPRINTF
macros to trace events and proper modelling of the DMA controller, however
I've left these for now since they allow for easier comparison with Bryce's
original GSoC branch.

This series can be used in conjunction with my upcoming ESP rework series
which fixes up the ESP emulation enough to allow the next-cube machine to
load a kernel from disk and start executing it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[Patches missing R-B: 1, 8, 9, 10]

v2:
- Add R-B and T-B tags from Thomas
- Swap patches 8 and 9 ("next-cube.c: move LED logic to new
  next_scr2_led_update() function") and ("next-cube.c: move static old_scr2
  variable to NeXTPC") to maintain bisectibility
- Drop patch 11 ("next-cube.c: replace sysmem with get_system_memory() in
  next_cube_init()")


Mark Cave-Ayland (11):
  next-cube.c: add dummy Ethernet register to allow diagnostic to
    timeout
  next-cube.c: don't pulse SCSI DMA IRQ upon reception of FLUSH command
  next-cube.c: update mmio_ops to properly use modern memory API
  next-cube.c: update scr_ops to properly use modern memory API
  next-cube.c: update and improve dma_ops
  next-cube.c: move static led variable to NeXTPC
  next-cube.c: move static phase variable to NextRtc
  next-cube.c: move static old_scr2 variable to NeXTPC
  next-cube.c: move LED logic to new next_scr2_led_update() function
  next-cube.c: remove val and size arguments from nextscr2_write()
  next-cube.c: move machine MemoryRegions into NeXTState

 hw/m68k/next-cube.c | 525 +++++++++++++++++++-------------------------
 1 file changed, 227 insertions(+), 298 deletions(-)

-- 
2.39.2


