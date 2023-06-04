Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFDB721753
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5na7-000517-73; Sun, 04 Jun 2023 09:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZz-0004yd-9T
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZw-0003EP-J8
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dDPci5a9L9240J5PYw+F0RRtRjaNYijeJosPZNQTXMU=; b=FOwgWD2PT6MzR+b1ihrJuxyZR5
 W1jz9WyfZkUusR7bGu2Pq/rtNOx+s+C79ddIQwHvxukOxBnn+SOVA9QwdwbPPSH30eVq1d9LTQV6n
 NQH7tg6Qkjy54tuODKfemQnG4HiqaYAhhsoekxc3r+9g/KEIj1XfrTSZ1Yf7OQTJBTCk/8/jHsRhk
 Z05BVOy6h3OSGJf+Ru++F3ZueOoGotiIbrU+ZsKP4ebSG5y45rFnMRslMxLVem83M5Z8ILfKPcV3X
 zLPdHVXydu2c4C6VPV9zT/izUm8u9pR8NG1Xbz5WmO2dlWmTYv0sg/KIge6e4lMg4TxV85E4W5+7f
 an5DKFYLl6B8MOEG8XmYAs8mkqM0pDPnHEyNL5iNshr1FJ0SnIvefCUP7l7VbkZCarDbAag+vV52H
 zDl0g8IjSFE1rXgWtbNLcsm6HoPxWfF/QIGz6p2ncwU+Jv6YusI7RIolzyFk3FOk9gOueWbYa9hdU
 nUiN7IcqnRQmbZkxxWb7ucIYmFu6y+JkA6l+P8UFZRbxZAdkjSJxxx+Nd3fdrQ4Whyv9EcH3pw2oJ
 UTNtuCsgUa7SUmF46iDTfrL/oD3Z14rBejxRdd5OhkpQ+yfbu5WwFh32LIH7HGFgTTnTFZujdfJSn
 CDrwc9iSw+QhBqcJnNnYSaLvxvapKpEEUs5yxW1gs=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZp-0005pb-DW; Sun, 04 Jun 2023 14:15:21 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:36 +0100
Message-Id: <20230604131450.428797-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 09/23] q800: introduce mac-io container memory region
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

Move all devices from the IO region to within the container in preparation
for updating the IO aliasing mechanism.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 6 ++++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 7aa391a322..6682c81ac8 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -177,6 +177,12 @@ static void q800_machine_init(MachineState *machine)
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
+    /*
+     * Create container for all IO devices
+     */
+    memory_region_init(&m->macio, OBJECT(machine), "mac-io", IO_SLICE);
+    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
+
     /*
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
      * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index fda42e0a1c..17067dfad7 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -39,6 +39,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MemoryRegion macio;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


