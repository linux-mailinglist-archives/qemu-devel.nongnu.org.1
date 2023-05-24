Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB170FFE1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vls-0001MO-7k; Wed, 24 May 2023 17:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlq-0001M4-I9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vln-000217-Do
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=irRG+bHrvmlstOvyXSCZUdMjneFA2b0o7w8rGrdcOTw=; b=QEkwIWEXbSnuDlPJn9RYRqoYEe
 z/7iWJX0p6Fl7fl2G9JBXrrDIrQ0nNQwWJLBwshZRRox+o0NCMYH239ehpMer9q8dUzu1j/FmjxB5
 bbwY2kYJ0xZXncl8EVAdcFLZvID/+vAoYuTtIymVlVU9T/xKuL1yW/is20egdXJFibaxscPLgs5aP
 ltduGIMz5pd15I8xgMhmfjx/gD/cK3r7uhPYz580k2G832eG3VawjkmViBQVblqBC+4yKZjRtBcOu
 Jcd7FfNkGyt52eZEr+Uu7ug2KPc+gDwGERgWuc6LwStoLTV+H1NcGIMJOBGe4hdewcIrBHINAarll
 hQBC8hAag3tnrqbljl1ovupBylGpvCog16K6jujdw6HsZ0YiAWRzYiKhz9gtFQM31cEQBApootb/n
 1ddwKKy/S5XN5kJk3milVFi47t4NzlPM6dcZ7ojSgOjalr8njsIfyZuDJPkdevVylyqR5VAYEx747
 ZNrpAglkOZblkUmE7M/8paXV065yJ1tcKjw8VDGsyw0vUzy+yjETGNzNneSXowj+LfzIo/IaCHzup
 kxrAq28Aba02VdDpzhfhQjVrX0RS8dJXYZNLxfKssVbM2dptB2tkytjTfqBcOclDEJU596KgFVxlK
 xjEIBu77LPW0viLgWTTScdLwUa5hDh63cwB1iOJDs=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlf-0005XR-Qi; Wed, 24 May 2023 22:11:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:41 +0100
Message-Id: <20230524211104.686087-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/30] q800: introduce mac-io container memory region
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
index c22a98d616..6399631ed0 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -410,6 +410,12 @@ static void q800_machine_init(MachineState *machine)
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
+    /*
+     * Create container for all IO devices
+     */
+    memory_region_init(&m->macio, NULL, "mac-io", IO_SLICE);
+    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
+
     /*
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
      * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index de02af53be..156872a124 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,6 +33,7 @@ struct Q800MachineState {
     M68kCPU *cpu;
     MemoryRegion rom;
     DeviceState *glue;
+    MemoryRegion macio;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


