Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67B81CAD8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:46:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqy-00084P-EX; Fri, 22 Dec 2023 08:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfql-0007ce-Ri
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:07 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqk-0004KM-93
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:03 -0500
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so18263315e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252761; x=1703857561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ydGnKeJ6gz419b+L3M6h0isZCkk0OEetzy5L5nKLXs=;
 b=kOQXDpcGqO0DjN0oHNb8Ehyi4cLdlmGeflbCl+lcwYQTWWIgagzFJxPNd07duniwdJ
 lCJmIDKQsXYAl6biaxp0dTh9YEezq3wT/HEopJ9OtvRXx7KKcQuLAnqwswh1KITxvgzQ
 N+PcKCUi6MRgFBvMGOkwoBIiZv1hH/LuFhqnD2tRYwdmL0Ybcir9nY3o2Ds6bJNJvCK2
 XDNekd5E94rzr6rKvdNcYNWbJM3/2ZWIDRCzXFKRF8diVdWUycSaEL7IV3LuRczXWQ0I
 7Lg2RNyyzNUMIrkDa9+srOBh2Nx9FZUUaFyYdjJhIdZTn5CdhFRRz+wSUpVUILzLhcDE
 FeZg==
X-Gm-Message-State: AOJu0Yyq/luo/BA984XsNTmKL2PRKvk/XhRN1i7ZauT/APC1M3LAQ0MU
 dwkG1JLn1TsKt39olSdfUuDPESwG8Nk=
X-Google-Smtp-Source: AGHT+IFwFBL2TG+hz7KyESRWIJtLfZRy2tOP2nSYzFoQIzmADDC1tWlspp9EclqN9O8ruByiFBE90w==
X-Received: by 2002:a05:600c:2201:b0:40b:5e21:e26f with SMTP id
 z1-20020a05600c220100b0040b5e21e26fmr702565wml.92.1703252761018; 
 Fri, 22 Dec 2023 05:46:01 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:46:00 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 09/11] next-cube.c: move LED logic to new
 next_scr2_led_update() function
Date: Fri, 22 Dec 2023 14:45:25 +0100
Message-ID: <20231222134527.15705-10-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.41; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f41.google.com
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

Ensure that the LED status is updated by calling next_scr2_led_update() whenever
the SC2 register is written.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d53f73fb8b..fd707b4b54 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -124,6 +124,18 @@ static const uint8_t rtc_ram2[32] = {
 #define SCR2_RTDATA 0x4
 #define SCR2_TOBCD(x) (((x / 10) << 4) + (x % 10))
 
+static void next_scr2_led_update(NeXTPC *s)
+{
+    if (s->scr2 & 0x1) {
+        DPRINTF("fault!\n");
+        s->led++;
+        if (s->led == 10) {
+            DPRINTF("LED flashing, possible fault!\n");
+            s->led = 0;
+        }
+    }
+}
+
 static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
 {
     uint8_t old_scr2, scr2_2;
@@ -135,15 +147,6 @@ static void nextscr2_write(NeXTPC *s, uint32_t val, int size)
         scr2_2 = val & 0xFF;
     }
 
-    if (val & 0x1) {
-        DPRINTF("fault!\n");
-        s->led++;
-        if (s->led == 10) {
-            DPRINTF("LED flashing, possible fault!\n");
-            s->led = 0;
-        }
-    }
-
     old_scr2 = (s->old_scr2 >> 8) & 0xff;
 
     if (scr2_2 & 0x1) {
@@ -321,6 +324,7 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case 0xd000 ... 0xd003:
         s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
                             size << 3, val);
+        next_scr2_led_update(s);
         nextscr2_write(s, val, size);
         s->old_scr2 = s->scr2;
         break;
-- 
2.43.0


