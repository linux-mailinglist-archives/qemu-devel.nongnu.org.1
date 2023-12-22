Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04581CAE1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr7-0000Ja-5C; Fri, 22 Dec 2023 08:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqo-0007el-VU
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:09 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqm-0004Kk-8V
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:05 -0500
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-40d4103aed7so16807105e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252763; x=1703857563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DImRAhb7fyTOM88QYEBxxHs5oJ54cNod8wGhVtDwck=;
 b=tlJFrh6ZiG/9ULRRJMdSU+NjiAMRF7zWbrysigjHyC7CEj4+rCg3Zoj00AYMsLpnP3
 txVTiPkNOi5G7YvSf6mmInwLUyZNYgW7zSnZIpKyFaIAjjKzB9joFvZS8TnDbRWbELnI
 SPD8udUg1TT2jDJo7CRslbmhuIgeFYaaGqzMuSwk3CkB8/vrV1VO8cqFaxhlJYdMOtpQ
 Ef8W1P64m/D/p1L4PJRgmvYp6rcYEuUs801C8ofhi6gUXpJTtgLn0TB7TCiNqCkpsAcn
 +UxEt9wnyrNLtJmReoI4t3IyfHoqDT5LFvoT/z9I4Y41xh5/Qzjc+qnSMLm8SxUVoaVZ
 2SyQ==
X-Gm-Message-State: AOJu0YzBiCceZR7YOBE815crixyPcuazCjPr/JYKXvfg5JygG/pRl1ro
 wYIdPp0KOcbIDXxSVxEbDTVie6RSC0M=
X-Google-Smtp-Source: AGHT+IHy/+kQlJUVQyhBQGuXKtMTqpujfzMXz8Is0kjry4nK9M5GcE2kJRIslll67dXnN8lMu1xfUQ==
X-Received: by 2002:a1c:7c0a:0:b0:40c:29a7:643f with SMTP id
 x10-20020a1c7c0a000000b0040c29a7643fmr865906wmc.131.1703252762742; 
 Fri, 22 Dec 2023 05:46:02 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:46:02 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 10/11] next-cube.c: remove val and size arguments from
 nextscr2_write()
Date: Fri, 22 Dec 2023 14:45:26 +0100
Message-ID: <20231222134527.15705-11-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.49; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f49.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These are now redundant with the scr2 and old_scr2 fields in NeXTPC. Rename
the function from nextscr2_write() to next_scr2_rtc_update() to better
reflect its purpose. At the same time replace the manual bit manipulation with
the extract32() and deposit32() functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


