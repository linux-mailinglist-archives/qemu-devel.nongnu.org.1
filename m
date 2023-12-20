Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2732819FAC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSU-00082k-1w; Wed, 20 Dec 2023 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRy-0007rG-Jl
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRw-0002PC-56
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lXFMb7KhM9WRQ3q++nVdmfUoYoeUwX0EEcDeNQeZ9AA=; b=NqCYmEnXE7G2NLZW3fiH+yrksE
 E3GWaI7jE/TE6A1sI6x5SotNAO4NzpF2P6zJmM+3UhkvFscF0HjnpB5fgAHiYVIjxJqLYycRdsBFX
 EWbtEjCs7zmXbxHaK3yURgcfGUZlG5+2vTckqnWWy+Tj5tqF7x597xDi/8eV1Fsj8b38/coyFqEfo
 l2tRouqXGApiFAoIbrG49w60VX54P6vwiZPoVECPED1savK5kMKAHJu9yQE9vx0RqO67oh38RJnAH
 kOvECKJv3SBIeXkafQo0pmfsCQCdvfeA/te3IPwNC68x6lP+z/wamEliVjh/ji/zhoxmmaevqFkf3
 +oyP3ZoiRJKULjgvGeTd5astq1xFJ+CoGAIza6EQj6t8GivXTkvOPXS2cJ+sZLIIuXGP3iD7Oo2BV
 9tiqbmliJH/adDXCGMlj85jDB30ElPgQhkfhL6a2OKFDmISVnF4FaoN3o1qeLSPdrejPBUgETwTd6
 MfiaedR6qylNJk8yFpq0+/k7gfLtMSQtDRjnCvcaf9R2365oD/GyhwVaDNLdkhwmWbrddQ23jFo3q
 D3z1apApIz2pyE6c1ao7GBmM+g9LfTPPgJ2Sl74s2w8cnoj5KlEUP7ObDzsxn98solcbiRB9DB7uR
 Er9AnfmUk4mMRqjrWqVMk04WisQQkwaQOgb71d6bw=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRS-0001qt-TT; Wed, 20 Dec 2023 13:16:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:40 +0000
Message-Id: <20231220131641.592826-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/11] next-cube.c: remove val and size arguments from
 nextscr2_write()
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

These are now redundant with the scr2 and old_scr2 fields in NeXTPC. Rename
the function from nextscr2_write() to next_scr2_rtc_update() to better
reflect its purpose. At the same time replace the manual bit manipulation with
the extract32() and deposit32() functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index fd707b4b54..d9a1f234ec 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -136,18 +136,13 @@ static void next_scr2_led_update(NeXTPC *s)
     }
 }
 
-static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
+static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
     NextRtc *rtc = &s->rtc;
 
-    if (size == 4) {
-        scr2_2 = (val >> 8) & 0xFF;
-    } else {
-        scr2_2 = val & 0xFF;
-    }
-
-    old_scr2 = (s->old_scr2 >> 8) & 0xff;
+    old_scr2 = extract32(s->old_scr2, 8, 8);
+    scr2_2 = extract32(s->scr2, 8, 8);
 
     if (scr2_2 & 0x1) {
         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
@@ -255,8 +250,8 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         rtc->command = 0;
         rtc->value = 0;
     }
-    s->scr2 = val & 0xFFFF00FF;
-    s->scr2 |= scr2_2 << 8;
+
+    s->scr2 = deposit32(s->scr2, 8, 8, scr2_2);
 }
 
 static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -325,7 +320,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
                             size << 3, val);
         next_scr2_led_update(s);
-        nextscr2_write(s, val, size);
+        next_scr2_rtc_update(s);
         s->old_scr2 = s->scr2;
         break;
 
-- 
2.39.2


