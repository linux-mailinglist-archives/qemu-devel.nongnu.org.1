Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46DA815087
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMX-0005qg-QH; Fri, 15 Dec 2023 15:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEME-0005pt-I4
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:27 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMB-0002Ok-Pf
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S9LX+lcO3GcXLQav+7INnMvB206DQdZcO5rgeXVevyE=; b=Ezl8hFWUIQylVTj1agB24kbtN6
 JdU4rZz/9CZFBLm5soz2CA2ZXgcXd8CfGjA1YPbYGIC+F8+ZErsocnsG2doEIg/chkQAfR3Vms2Uo
 3x8V6rrlioOKvAdWMxOrTHq1+xqzaw3OoqZqzrV7n+GTnSsMKCVixtnTSsjNOqAiG0XWJBHF0G6bb
 Hmkp18LvFR2EppWNFPRFhgflVLrntQJCvWHccS55wx0NYog7zoOZhs6vcPUFA1/6woIRRCloredTM
 zd/q5XBNNUhNNNnN1GeOs7DseMaj4c//qUzlzDIGu6w6Q5zb8NXA//+wx5eqNG1gOAlSE2wCE0Y5a
 NFH4+LplYFoevkkgJJfgCORxmuLEHiSSyrH9s3kwJgU3QMl75F/Cf7QQokt/0QQw4p+rHQQksxwpy
 WpvZmR/l27jWQB7VJqjs+IzYqGNrBywnYlxOhLHDNJs6pykoJPBKN7E7mpEist+QeTmv/xNxsR1bj
 JcMsFh350w6gtvG4JymhCuh3S9aCXtfS55ypZLnrCou1rr9UX3+87jgArhhV4pNfT9Gs0ocFQLy23
 nfU6dfKabQGPgRBJhrir3qbhgUBzAVL9IxnNaZ+v0/xi60gTSSmVQPlxbrxj4m7/tD9f11dW4AGjb
 rI+XaADD9An5jBLqqRcPSmfCoL9u6/57eMTK/gUYs=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEELg-000AEs-28; Fri, 15 Dec 2023 19:59:56 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 19:59:57 +0000
Message-Id: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/12] next-cube: various tidy-ups and improvements
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


Mark Cave-Ayland (12):
  next-cube.c: add dummy Ethernet register to allow diagnostic to
    timeout
  next-cube.c: don't pulse SCSI DMA IRQ upon reception of FLUSH command
  next-cube.c: update mmio_ops to properly use modern memory API
  next-cube.c: update scr_ops to properly use modern memory API
  next-cube.c: update and improve dma_ops
  next-cube.c: move static led variable to NeXTPC
  next-cube.c: move static phase variable to NextRtc
  next-cube.c: move LED logic to new next_scr2_led_update() function
  next-cube.c: move static old_scr2 variable to NeXTPC
  next-cube.c: remove val and size arguments from nextscr2_write()
  next-cube.c: replace sysmem with get_system_memory() in
    next_cube_init()
  next-cube.c: move machine MemoryRegions into NeXTState

 hw/m68k/next-cube.c | 531 +++++++++++++++++++-------------------------
 1 file changed, 231 insertions(+), 300 deletions(-)

-- 
2.39.2


