Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5F81CADD
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqx-0007wN-Gi; Fri, 22 Dec 2023 08:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqk-0007ZD-BD
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:05 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqh-0004KE-NJ
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:02 -0500
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-40d4a222818so2067475e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252758; x=1703857558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/k4vTka8vOGaLfMbVVtJD465XlzXbm/gLCbN1S82LaQ=;
 b=cH2agZNE9DAGBahSZ2/LRujWP2LxsAlq4fwTj2sKcJKGxrRbvoqTLzRCV0egYCZyqS
 netkZYXrUJuMOOjY52YzUKC5ZoFwjnvUckkvQu8uK7LVnLc+S+N+2uEATQPLzcRhxuvk
 95plq++q+oafbl0NSkddLSaHh9eF91x3EMzCKqE/kJvC44X2GwiLnl6bgh96QJRgnisg
 Z9Q6Cy3mv7Lsd6bXfqSVbzxXF47BIHNnRpu7292OhGLh0KBeTUf9A9/NknOA2DchQCs1
 9iI1/qN/ZysZbWlWWB/EDMDznZXaLGz0/ovP1BrLGxb6j1O3J5SPU1gWqFpTHwU7mXIb
 logA==
X-Gm-Message-State: AOJu0YyUP0wSKRGzPCF+ZmxUFiVGxz8lw/4V0sDPKB83NEEZoPU27hS/
 jNogvMMvZnSXyX3VJIdw2qz/VQXiK1I=
X-Google-Smtp-Source: AGHT+IESE0LNVv0caa5D19lF/UqWCx/DCusIcAEqudVyUiD3fmZ3foacAVwLuNRYs0YBKpSFmSkU7Q==
X-Received: by 2002:a05:600c:474c:b0:40d:41d9:adaf with SMTP id
 w12-20020a05600c474c00b0040d41d9adafmr710935wmo.44.1703252758100; 
 Fri, 22 Dec 2023 05:45:58 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:55 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 08/11] next-cube.c: move static old_scr2 variable to NeXTPC
Date: Fri, 22 Dec 2023 14:45:24 +0100
Message-ID: <20231222134527.15705-9-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.50; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f50.google.com
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

Move the old_scr2 variable to NeXTPC so that the old SCR2 register state is
stored along with the current SCR2 state.

Since the SCR2 register is 32-bits wide, convert old_scr2 to uint32_t and
update the SCR2 register access code to allow unaligned writes.

Note that this is a migration break, but as nothing will currently boot then
we do not need to worry about this now.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


