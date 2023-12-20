Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FBC819FBA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSM-00082K-Dv; Wed, 20 Dec 2023 08:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRr-0007qo-8h
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRp-0002OS-8N
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hQ4xxkUoF0gRlwRP5BMMLG1h9NyuKv9JzvYoNlqaVng=; b=s8RMzvcvx/PA/JLUzx+ULKkKO6
 HHPQDlKWdA8dPSioyNjoXXZGSRpFxD+HBTH43BARFu2ug6CaOHNlj0oTe42cxILVa5vk3eEQ/lhPu
 CYGX/j/EZuBek/SIyI4EA12i8EjHpAEFe8LuYVsSxjxPCcvji5O5+urjHdOMlhKCzUEfHm3jRtNEg
 PuTfY8L5X0OmEDu98amHuKVKLeO1tTpbqn0lxlyoKYN17cyLQ6UC89yLKM1O5+b3fy2GPc7PdMXll
 70zljzBtxRdzp7MGt45oZroDWAYU/K9idiubMmKMgLIEnZItapE/aJz9CSjthhbYsDGWQ2wN/pH5z
 /bt8ahvcTcwVd3JiZQfedfmVemQDcJakG0s0t3HI/UFjkFwGmQxkm/ytFA7NMZtw2L6WTq4TR0I9v
 RKGOsPCFuBfuEM6Oa5eLHEOOVL8puDkhi5S7QrUsfunIaaf4mQlttMSTjA3MF8BT/WHHp0OLpgYQz
 jUU3GEuwgW4LRXNbQfAFQP0qRzJ8hIuc1fS2/Ubu7oy0G6s3DDH7qxJNQS+tZhYJUpONClmokWOkg
 Pmbw6wHGqlfj8vOFBt0HbnKEzx45miGYGi3rIDtfKfrG85jqhjTn/Dld1lSac8DnI3hZEEOPiFTVt
 BbwlF7rKopL9cFTwOnivFww25FnPxeW86QG8Bg/wQ=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRM-0001qt-Ov; Wed, 20 Dec 2023 13:16:52 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:38 +0000
Message-Id: <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 08/11] next-cube.c: move static old_scr2 variable to NeXTPC
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
index f2222554fa..d53f73fb8b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -91,6 +91,7 @@ struct NeXTPC {
 
     uint32_t scr1;
     uint32_t scr2;
+    uint32_t old_scr2;
     uint32_t int_mask;
     uint32_t int_status;
     uint32_t led;
@@ -125,8 +126,7 @@ static const uint8_t rtc_ram2[32] = {
 
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
-    static uint8_t old_scr2;
-    uint8_t scr2_2;
+    uint8_t old_scr2, scr2_2;
     NextRtc *rtc = &s->rtc;
 
     if (size == 4) {
@@ -144,6 +144,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         }
     }
 
+    old_scr2 = (s->old_scr2 >> 8) & 0xff;
+
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
         if (rtc->phase == -1) {
@@ -252,7 +254,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
     }
     s->scr2 = val & 0xFFFF00FF;
     s->scr2 |= scr2_2 << 8;
-    old_scr2 = scr2_2;
 }
 
 static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -318,7 +319,10 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         break;
 
     case 0xd000 ... 0xd003:
+        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+                            size << 3, val);
         nextscr2_write(s, val, size);
+        s->old_scr2 = s->scr2;
         break;
 
     default:
@@ -876,6 +880,7 @@ static void next_pc_reset(DeviceState *dev)
     /*     0x0000XX00 << vital bits */
     s->scr1 = 0x00011102;
     s->scr2 = 0x00ff0c80;
+    s->old_scr2 = s->scr2;
 
     s->rtc.status = 0x90;
 
@@ -932,6 +937,7 @@ static const VMStateDescription next_pc_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
+        VMSTATE_UINT32(old_scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
         VMSTATE_UINT32(int_status, NeXTPC),
         VMSTATE_UINT32(led, NeXTPC),
-- 
2.39.2


