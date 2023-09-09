Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710079972C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 11:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeub8-00074y-S7; Sat, 09 Sep 2023 05:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeub6-00072Y-3I
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeub3-0005LH-Tl
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 05:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rVLhVC81FABNRKzcCDZD9c3OyRpcVv+q9I8Ijo5qkSk=; b=n5AFZE15d6EvNDg538jEGKPArf
 r/jj/q5mzrTvmch3nFLMIOvhBPhMU7jDH+IHc0CX47lqqEHdL9G7thekORSthW8EQuGi2aLhQE4TJ
 fmO9Fnij+SNf/YQP9VFjLBRjHontDOZRlKRkjDAw9ccG9T/qOZ1+iwaTrzyWaUmDajkJrtVk8AC2t
 9xIJKfLjj6IQBAl4N8op+JxRraH3BlYsWXGeMOIl3MSU6DnaD+CRfzvH5bVDHkbLhTt6yPP2dYzHT
 MEa+d1yCulo+PVQkb0Gfj+O6cC6GMVPr+/mB5I/8pH2IQGA1BaJFcMMBFHedur30eeHcgeD4YXqYv
 VYxDrnRPRLREQpFk2F9B9TbsSgEKCggwmZgakz6D85CHFcZaRseG7XWAcLAZrmuj9sS70Mv2IUn9O
 ITaIlHrfOFXv0gNUr9X61o+8XJ/QC2NMqDkwxoTgyMm58S7zTGdXpqRrn3AJZZKccqizs4NdkDr/e
 D/GbYpG+AGTMEZwd7cwzo1cF1QQkaxyrjcn6cyguPwBb80gAeA4oSjwpRyzIKrKWrftGnkxVCNOF1
 s8BurnzGqeLKdEUOXC+1JQ0nlNQcb175HJRJxtKTxgAD3T6QXVuWfIVSgD+HglytG3BYMVvGp7xeL
 1RMzX7hyubba9RrNQWEI/pL/2fFpD9b/4mm1ZcWms=;
Received: from [2a00:23c4:8baf:5f00:e007:7058:31bc:5be9]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeuan-0000uO-SC; Sat, 09 Sep 2023 10:49:33 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sat,  9 Sep 2023 10:48:25 +0100
Message-Id: <20230909094827.33871-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:e007:7058:31bc:5be9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/20] q800: add ESCC alias at 0xc000
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Tests on real Q800 hardware show that the ESCC is addressable at multiple locations
within the ESCC memory region - at least 0xc000, 0xc020 (as expected by the MacOS
toolbox ROM) and 0xc040.

All released NetBSD kernels before 10 use the 0xc000 address which causes a fatal
error when running the MacOS booter. Add a single memory region alias at 0xc000
to enable NetBSD kernels to start booting under QEMU.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 6 ++++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 5ae7c37760..b5b2cabc33 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -451,6 +451,12 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* Create alias for NetBSD */
+    memory_region_init_alias(&m->escc_alias, OBJECT(machine), "escc-alias",
+                             sysbus_mmio_get_region(sysbus, 0), 0, 0x8);
+    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE - 0x20,
+                                &m->escc_alias);
+
     /* SCSI */
 
     object_initialize_child(OBJECT(machine), "esp", &m->esp,
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fbaacd88bd..348eaf4703 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -67,6 +67,7 @@ struct Q800MachineState {
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
+    MemoryRegion escc_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.39.2


