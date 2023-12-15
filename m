Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA9815083
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMi-0005uK-Hh; Fri, 15 Dec 2023 15:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMb-0005ta-HH
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:55 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMZ-0002Xp-6c
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5r3bXy7P+uD1Y28KygA1yGEAJYquoAtLKY9+Xf/N9t8=; b=M1f7U6MCdjGJwEU9mtpoexhnf4
 u503/Q40GDk7VBAFlLL17OjTun1vuG7qHm9zW6A+EShlGMmgjDRoXiAdMUvC+o4a6yHimpLXMPx04
 dHFmvgkZdJltWzZ21CaC8MVi4jdLJVIUfbE/76aFigKhsviFaBMMhh4AXal+cDbODaHrzc5NgGOru
 fdNEnhdxDrIxT3cPvvla3ukVLpZx+1/pex4Z1UOk6ZcfwSfkPL69uCYRKDmAj6lkvwFon1gLZuTZX
 ZjRXzqaNG5YMYz0QAiH/De4iaWbVgUapkN4pa3mBIRlhOAhvnRab1sooDqhdPNW0S17t+G24VnTNs
 y2XizESK6CmWSY0yPFfXpzGRklVo4ef0TYPDdVkNDytEBSgqaxBoh3j2ClNle86/UGKz/9jBJNda2
 U5IR8GBFvB0iokp2nluHDnTkLwYF8Bz4xKcdCopKC3IqiYNdjcZNBj8eLypDFX2Fi2raUqWHcAWbq
 FnlvsLfo3bIcePVJ9N58jdoVUHZQ6iL2Ie0oyk2e8wIUTYvDlf0c5Knogoc+6x13r28vFDIM2d68X
 MKP7t4SatxJvEmqk2RDXxo2Ogadw6dGcaH8QTBgAMtOzaINE3MXhpEAANW0frxfDnp1YA4MFIxsot
 N7zTTmxoaz/1pqlZfbCW6mZdQ7GW7x9vvr9PLdC9A=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEM8-000AEs-F6; Fri, 15 Dec 2023 20:00:24 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:06 +0000
Message-Id: <20231215200009.346212-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 09/12] next-cube.c: move static old_scr2 variable to NeXTPC
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

Move the old_scr2 variable to NeXTPC so that the old SCR2 register state is
stored along with the current SCR2 state.

Since the SCR2 register is 32-bits wide, convert old_scr2 to uint32_t and
update the SCR2 register access code to allow unaligned writes.

Note that this is a migration break, but as nothing will currently boot then
we do not need to worry about this now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 7ffd1c412e..fd707b4b54 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -91,6 +91,7 @@ struct NeXTPC {
 
     uint32_t scr1;
     uint32_t scr2;
+    uint32_t old_scr2;
     uint32_t int_mask;
     uint32_t int_status;
     uint32_t led;
@@ -137,8 +138,7 @@ static void next_scr2_led_update(NeXTPC *s)
 
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
-    static uint8_t old_scr2;
-    uint8_t scr2_2;
+    uint8_t old_scr2, scr2_2;
     NextRtc *rtc = &s->rtc;
 
     if (size == 4) {
@@ -147,6 +147,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         scr2_2 = val & 0xFF;
     }
 
+    old_scr2 = (s->old_scr2 >> 8) & 0xff;
+
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
         if (rtc->phase == -1) {
@@ -255,7 +257,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
     }
     s->scr2 = val & 0xFFFF00FF;
     s->scr2 |= scr2_2 << 8;
-    old_scr2 = scr2_2;
 }
 
 static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -321,8 +322,11 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     case 0xd000 ... 0xd003:
+        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+                            size << 3, val);
         next_scr2_led_update(s);
         nextscr2_write(s, val, size);
+        s->old_scr2 = s->scr2;
         break;
 
     default:
@@ -880,6 +884,7 @@ static void next_pc_reset(DeviceState *dev)
     /*     0x0000XX00 << vital bits */
     s->scr1 = 0x00011102;
     s->scr2 = 0x00ff0c80;
+    s->old_scr2 = s->scr2;
 
     s->rtc.status = 0x90;
 
@@ -936,6 +941,7 @@ static const VMStateDescription next_pc_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
+        VMSTATE_UINT32(old_scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-- 
2.39.2


