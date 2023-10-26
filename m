Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C07D7F24
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwB7-0005jp-4q; Thu, 26 Oct 2023 04:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwB3-0005iR-8f
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAy-00061D-Tv
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SZgWH6ZZ6THa2UXGQszNhCElN4Fl20dWOSxRnkWzJ68=; b=0NsjpOOaHAYvLmxJFMbOO+VO0H
 ufvie4/24GGskug8o/hyZ1HOO5oZ1ZcTiXubo2AVRlivzEqzcsSSNxUUYuky2m9I+DgTVE5KH091w
 AdY1d3IXi5c3A7pLWuy2OMIgRGIKh+jN42M4zgUlOXIJbXxcKhlXAPPGXKtHlRrR8cMMuD8C0Gh6N
 LA5gJx+Jlsmy38xUrIgG+q1FOcNIsottVkafymQmYnV31hmo8Xq2GNj/PsNdgk3b/y/95T2YV/Dw3
 Hfp5f7/7I2blQw5TNVR0h21kIQte3VejxrNoabZB3lluM3VCszhW4K3cWaJPU84ImlklsqR6HdrqS
 RNk4mFuyUg12tR7Cy588xMWmjxVuP/lrgtQ+/c6QJbLKaX+VPAGtcvIBdvC1JlJisiW+Aq7Lu7gja
 CG/meZA++Nk3xcg7OxyfxMORzCEBv9KvBni/DnymdXUqqz8nFw0zY7bhFt+hxRL/qCthJver2TV8B
 Cs1jKo0ZIfInX9kOA08uTE4viQR8NK+NtXUEpigD/hwYJa2pmAbEod35E34uA3Up0Jv2V96vzFx97
 2YSUHCxJH4wYHRqpIkaXPLTsvcEfQgLN8uC08pVB2qmuNDBQVQ29hp+wg7ryYqjUE191lnG7DmsvR
 ACceiET/HykVhRTHH5RyUh7YIpI7d7PLKUq9j2NiE=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAi-0000md-W7; Thu, 26 Oct 2023 09:57:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu, 26 Oct 2023 09:56:48 +0100
Message-Id: <20231026085650.917663-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
References: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/4] macfb: rename DAFB_RESET to DAFB_LUT_INDEX
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

When A/UX uses the MacOS Device Manager Status (GetEntries) call to read the
contents of the CLUT, it is easy to see that the requested index is written to
the DAFB_RESET register. Update the palette_current index with the requested
value, and rename it to DAFB_LUT_INDEX to reflect its true purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/macfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 28db2e9f24..eb4ce6b824 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -36,7 +36,7 @@
 #define DAFB_INTR_MASK      0x104
 #define DAFB_INTR_STAT      0x108
 #define DAFB_INTR_CLEAR     0x10c
-#define DAFB_RESET          0x200
+#define DAFB_LUT_INDEX      0x200
 #define DAFB_LUT            0x213
 
 #define DAFB_INTR_VBL   0x4
@@ -583,8 +583,8 @@ static void macfb_ctrl_write(void *opaque,
         s->regs[DAFB_INTR_STAT >> 2] &= ~DAFB_INTR_VBL;
         macfb_update_irq(s);
         break;
-    case DAFB_RESET:
-        s->palette_current = 0;
+    case DAFB_LUT_INDEX:
+        s->palette_current = (val & 0xff) * 3;
         break;
     case DAFB_LUT:
         s->color_palette[s->palette_current] = val;
-- 
2.39.2


