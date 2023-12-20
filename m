Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA89819FB9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:20:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSL-00081W-46; Wed, 20 Dec 2023 08:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRi-0007oK-Sb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRg-0002MV-Lq
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4A4QyHjkJ8Y0ULs6Y8xB+bgBMLSTXL1d2MA6cjcQ3xk=; b=VVcCRE0U29F2LsBo4rCJ/tvSKA
 fjPo6rekyA04rwdMP9Dmxhj18CnkhYrNql8th3p9M9KvhyMSb7//XOS6qafTCO/sAL2jbhItALXoI
 iiSaaWVorqRrvj1ydEjLRHTDhn4LM6A5Xov+O/OuSFl/MTUkgh6+x7Yyun15vGT9yUorFwsTRaa8L
 HZtSRk+SKGWj1D/X4TDNfSUeH/Zxuc7gVHeVBv3iLpOe7n4K4bRJiFGCCjr6oFyIyyhMV8kildCaD
 JKvRRMRYfdPid+DD8y1QIYYbd/HpBGUGvqk6LXUXAj/Z4QEpH6fZ31tjj18cTfQ0kmjhU/mA4P+JL
 Zt9gIkk9v6V1+YfeIwww7BELEbSufeWmKn0Dvh0In7DKmRT2yYZSABY90MzGg2Sh6CdwBqc1MCLeq
 CMRUoZeAE5l62sY7nWdbc2nyRCplHQx1dS3W2EQh7wNaoxhfg58t++GdY1fByDmx7zAwpedU5IIVz
 Lj0W3ksQiWa41zl4Rg2hMNAMTi2/kmh6spComW91DPMK8yj0T+zqid2EwHx11N5yCYyF+6hi71C3S
 NDC6IHtutb0pwiOLCEBPMbaT1YMrHoTiZgbkQuBfZd+fcWarX2eUWJEVfBZmNtaSsumYQ3tbg6/Wz
 5lY+ZiQ9wJFOJIRRJ7qH47CnirMaiZAP2FfLhpWZE=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRH-0001qt-T1; Wed, 20 Dec 2023 13:16:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:36 +0000
Message-Id: <20231220131641.592826-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 06/11] next-cube.c: move static led variable to NeXTPC
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

The state of the led is stored in the SCR2 register which is part of the NeXTPC
device.

Note that this is a migration break for the NeXTPC device, but as nothing will
currently boot then we simply bump the migration version for now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index be4091ffd7..bcc7650cd9 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -92,6 +92,7 @@ struct NeXTPC {
     uint32_t scr2;
     uint32_t int_mask;
     uint32_t int_status;
+    uint32_t led;
     uint8_t scsi_csr_1;
     uint8_t scsi_csr_2;
 
@@ -123,7 +124,6 @@ static const uint8_t rtc_ram2[32] = {
 
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
-    static int led;
     static int phase;
     static uint8_t old_scr2;
     uint8_t scr2_2;
@@ -137,10 +137,10 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 
     if (val & 0x1) {
         DPRINTF("fault!\n");
-        led++;
-        if (led == 10) {
+        s->led++;
+        if (s->led == 10) {
             DPRINTF("LED flashing, possible fault!\n");
-            led = 0;
+            s->led = 0;
         }
     }
 
@@ -926,13 +926,14 @@ static const VMStateDescription next_rtc_vmstate = {
 
 static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
+        VMSTATE_UINT32(led, NeXTPC),
         VMSTATE_UINT8(scsi_csr_1, NeXTPC),
         VMSTATE_UINT8(scsi_csr_2, NeXTPC),
         VMSTATE_STRUCT(rtc, NeXTPC, 0, next_rtc_vmstate, NextRtc),
-- 
2.39.2


