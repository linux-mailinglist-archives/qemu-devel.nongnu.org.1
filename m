Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26C7180AA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLy-0007UF-GY; Wed, 31 May 2023 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLp-0007G3-PP
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLo-0006oR-6z
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ODJ/kno/6QYjZEa/ptLFF5r0Qh1T/UZPOItOZTLhqhs=; b=SrzQMjxICVHjfuahhX1S0qyf0p
 u2XN8Ry+Djgos53uwC54UrovMM0QBI91Dx4/mE+3jT/TuihbmKRHlpQ6WKTvPO6qXdqnopAqCYeTV
 XT0juZTPJZ0LSUew0n1j/fCtwe4I3ZOLTbApO29QWSm308gaUNkPAsM5lp1QhJHFr+5XRoVXPw+D3
 V96AUmfktQ24D4NY4k2Mr9vpTdfZWbprChIUcnsFvfRbEvwRazcgy9Sf1ZwJnxsT5q8VcpgXZ656/
 UalMJGejD90UAcTL6FdsI5N7QuuXay36G4Rt49NWvxxkkE4kFp7IJPyogSlfnlXjoF/97purq2xO7
 gbfxWezzG9wT7pR49hcjG/2W1CRcJgNdxTxn0SXD8ETQU8fixgFYy2UMdounn/m7Lo2cCcNy1nUx1
 Gu9k7rO2ao+6L8fFIvI5TlfAC0uoY4Tm0xdtyspNaZDiRJhV0G/19Yl+RlBdk5PuZAS4Nhi+HtsO7
 w77jO4eAG+TCotWlzJXsSKMUwNLeDkerCOeTrD3uhaJQVPfLNWpvcA1BGcf/wiMRn1EZ1W0iGSM+1
 /MeIHiCQpp3nOQRrNh9+H16zaHAjLYgl8faF8FzRZlnKW1ec/EMvnQThk1qFn0MzWT5w/O6/O4jf4
 lEehDVfLHjinzO9fLBAookLIeKoqUk9JdGynh2liE=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLi-0008vd-CR; Wed, 31 May 2023 13:54:46 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:46 +0100
Message-Id: <20230531125400.288917-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/23] q800: introduce mac-io container memory region
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
---
 hw/m68k/q800.c         | 6 ++++++
 include/hw/m68k/q800.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 7bd8e795d2..2394d14c97 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -178,6 +178,12 @@ static void q800_machine_init(MachineState *machine)
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
index 8e1bb0735d..b9de8e36cd 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -35,6 +35,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MemoryRegion macio;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


