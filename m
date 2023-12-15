Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42D815084
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 21:01:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEEMj-0005uP-GG; Fri, 15 Dec 2023 15:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMV-0005rA-MA
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEEMP-0002VL-AV
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 15:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4KCaL7IEuP9C4M/fHRAGHkzRci9LD/1ciJtTr/M8EvQ=; b=zaNB9jxdj8hug+JoheOC0CMHjy
 efE5O4NGVWz7zNtvrfF/vxXGsetjdp0VR+LBRpPimMRr/CPTUA1hTTcQkh9aOb1GQTqW9dPkdRdeR
 p/idyQpIJGEHEse/HH8hNrfXexR0T5mOVGXp0y4HNwQacV6MbXFCh4Z9GfNfbzVcNsU8rj4oFgS5Y
 HuDtOZdSya8IowvVPyeCDZPghrw+cRpxvnDU/FFWZcQ6B5rMC6eupQaks0cuRD5jmJfhM6511TDcV
 g26Xtmu+v2mpd2vyH6NNsFQECl5r7DWwoubRieVF+bHWnbwDpcYEz5ZF0YB97cMUoxXzm9TDhrWo0
 xfpBLcg7X9GJyXYT5GLR1dQXrFaoJdyMSHfti25yNXiB/HiGnt5L57NHxt+FIjOsxiQrYgv1jvbJO
 tN6Q5qHaVckqXnDqVh7RaFWaBZ5RnWF5uAGursCF2up+A3+qWg7jtcswoa3imq8gyTKMOMBsRddOy
 S1r6jI654Zhw0ufljLUiJbAW3/TDoYPnnb8XGz9DP+5aSnU8K9VSElIGPzC8QKb9c57nUo0Sfcxjx
 PPuuTWaaTdiiqcgr1X5p6oNiyWxZMWW0y/8NqFSXtFeT6Bi4KwHQO/2ZzXK12mPJOwVngrYfI8lNO
 6ycVpGbaBwO9m+rqzdic2lrqh/x1jVjJMl5aff4aI=;
Received: from [2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rEELz-000AEs-Oi; Fri, 15 Dec 2023 20:00:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Fri, 15 Dec 2023 20:00:03 +0000
Message-Id: <20231215200009.346212-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:f100:5e2c:460f:a6a7:b066
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/12] next-cube.c: move static led variable to NeXTPC
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


