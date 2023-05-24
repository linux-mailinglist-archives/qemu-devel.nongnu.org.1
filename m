Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82870FFD7
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn6-0005Gd-U5; Wed, 24 May 2023 17:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn3-0004ul-8b
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vn0-0002H5-1u
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bto7ry5odXfABcKODlJmXnSA6aGzrCs70PRGGFISC1Q=; b=TJllyv8STvq9w6UJN8iipPyXwy
 ncTFfuMfnAEUWi9BIrpPkTaNHHPTpnjWvg7JNbthte2RVgeyZRj+8XlQo0P66Q9KVevbVbeU/dl+V
 /Sli8wuLBYo2ZU8e6+3VlLWMYpax4admdF5T3blFu46AxpF586CEyxMpcPV+Cjg9uhpkOc48DC4Jl
 CJNI43tmAisQDEaC4r4pRzkln+T5DMq5c04/kBcBHACesetbRj+gMi7i5yDwKqo/En8gCGUkIdnt3
 IdZDeLphZKzCMu0pAUs0NlFAIGz4oMYVGJx6aHCi8/Z24BVBwHyGVgFpyJsT9NjPdkyxVmEDyNu4j
 XwYR6QIROxu01gJQ0UyUZS0BpmjTGx33n+OS20l9LBRbZ2CB/zvLiVM57/hta6dRvTIcLZnxO81Ze
 GcqrjN3wjtnB2YxjiG2s12YBvP5x1465FN8NQQQO5bnSrEZ5i18mu9sRsLUJogpNRsj5hI/Wan85G
 njWfnp83+atmIQKh5Br98CEnBPd2OSrA2ggkgKMwwHWUQChzfdL8tVewo9ccJkOkTY+zeOKoIH3O7
 BJ3kkxHyLGYiJhiukwWH7WvOMrJMCE+SZlUqG+qf0LLluTAFYTq9kErGe+G8zdlt2voIKc1otMxOH
 s8WXOgqlcedFfuP4vkgCny9MempYLzSpthsge4ohI=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vml-0005XR-6U; Wed, 24 May 2023 22:12:43 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:11:01 +0100
Message-Id: <20230524211104.686087-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 27/30] q800: add ESCC alias at 0xc000
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
index 1af1a06f64..3acdb5dd8d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -682,6 +682,12 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
 
+    /* Create alias for NetBSD */
+    memory_region_init_alias(&m->escc_alias, NULL, "escc-alias",
+                             sysbus_mmio_get_region(sysbus, 0), 0, 0x8);
+    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE - 0x20,
+                                &m->escc_alias);
+
     /* SCSI */
 
     dev = qdev_new(TYPE_SYSBUS_ESP);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 0144be5e6e..3039b24d30 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -40,6 +40,7 @@ struct Q800MachineState {
     MemoryRegion macio;
     MemoryRegion macio_alias;
     MemoryRegion machine_id;
+    MemoryRegion escc_alias;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


