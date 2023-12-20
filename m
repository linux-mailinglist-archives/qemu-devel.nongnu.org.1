Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FFE819E6B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 12:48:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFv2q-00008D-9I; Wed, 20 Dec 2023 06:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ah@immunant.com>) id 1rFqMs-00009V-Jk
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 01:47:47 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ah@immunant.com>) id 1rFqMn-00026L-60
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 01:47:45 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1f03d9ad89fso3650494fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=immunant-com.20230601.gappssmtp.com; s=20230601; t=1703054859; x=1703659659;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MAIYRTB8Rqd8m9xruK/seC6pxzmjTJLImtUPc7KNg+0=;
 b=ZMaXEcf9kVKGjdflA6J38IN+yeVdfi5nPFAkwguDFy0sGfvQvmNWlf4tM89zX6fjF4
 f/dvqJXsuZxTLFICYbw9KoRh8nWTXGZgGJRkuGx8riI3b+KicP4mZ1IX1HUvVq6jGjHV
 T0jdOZKrxsbc6egBmgtbTqo+e8wN7bqkwmt00KmkqswsrxaMoT7WXlVZqBKkC+6aG3b7
 6t4u2KzZUFDZEEkWFOjNExsNYjt5qZVaw9CFaEimsOP+dnH4RFkwhxwctUU9YJHE4LT2
 h7HLE8+XDHAgn7uW3yt3NZIL3hpM9kSM1jVQNTZ5PhmqvlIQgqvApyrA/Hqz14RHENRk
 Gi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703054859; x=1703659659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAIYRTB8Rqd8m9xruK/seC6pxzmjTJLImtUPc7KNg+0=;
 b=BfPdvjenjEzXWEUoLSc+26/mqhIifzuyDJcYtJVcOkstSXCjbX+2NIazk+y7CXCRAy
 i29RComhs5OJlpMa8IgCclL6desKsYTnza4aZWn2J0mhYGEcgf55VFY7vtfnGPjWfuu6
 3Blb7RbyMxTD3kcKqhkWAw9K1bW8qhDKsegTou7qdc5ozwWwii5+DkRnF1zNubCWeeCJ
 WaUAR1XSNxJEkzZBi1ZtBHRKMvQ8R6+h1WN7UmqMuWC/ncYwXS0D4uHPetgThdG9yufU
 WgPDZ202A0etbINxXHEca7V6m5VaHESTNdx7Zp5yN6flRQVb29OxgexeoBNUiVoKdrw5
 /KCQ==
X-Gm-Message-State: AOJu0Yxx4incvAJaUSuISxIUk1XvfK9MQYQrrcS+vyPEapZ9hK1gY9dD
 VDsuWSxVQwvYF1MZ9vfE8ZvKvCcbGIGVszwA3KZKbg==
X-Google-Smtp-Source: AGHT+IG6C0x7ya3UB/u8yjJBp8pmC3gZZtwAjLUbIC4oQ4zTtp1EbSnBG4hUBEl6RccJ2VGXwUAE/g==
X-Received: by 2002:a05:6870:2327:b0:1fb:75a:6d31 with SMTP id
 w39-20020a056870232700b001fb075a6d31mr22289403oao.88.1703054859110; 
 Tue, 19 Dec 2023 22:47:39 -0800 (PST)
Received: from clara.immunant.com ([205.209.28.226])
 by smtp.gmail.com with ESMTPSA id
 3-20020a630c43000000b005bdbe9a597fsm20262222pgm.57.2023.12.19.22.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 22:47:38 -0800 (PST)
From: Andrei Homescu <ah@immunant.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, armellel@google.com,
 jansene@google.com,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Matthew Maurer <mmaurer@google.com>, Andrei Homescu <ah@immunant.com>
Subject: [PATCH] arm_gic: Implement GICC_AIAR, GICC_AEOIR and GICC_AHPPIR
Date: Tue, 19 Dec 2023 22:47:35 -0800
Message-ID: <20231220064735.387346-1-ah@immunant.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=ah@immunant.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Dec 2023 06:47:14 -0500
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

From: Arve Hjønnevåg <arve@android.com>

Implement aliased registers so group 1 interrupts can be used in secure
mode.

GICC_AEOIR is only implemented as a direct alias to GICC_EOIR for now as
gic_complete_irq does not currently check if the cpu is in secure mode.

Upstreamed from https://r.android.com/705890 and
https://r.android.com/859189.

Signed-off-by: Arve Hjønnevåg <arve@android.com>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Andrei Homescu <ah@immunant.com>
---
 hw/intc/arm_gic.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 074cf50af2..d0e267a4b2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -854,7 +854,8 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
     gic_clear_active(s, irq, cpu);
 }
 
-static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
+static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs,
+                             bool ns_irq)
 {
     int cm = 1 << cpu;
     int group;
@@ -922,7 +923,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 
     group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
 
-    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
+    if (ns_irq && !group) {
         DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
         return;
     }
@@ -1647,6 +1648,22 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
             *data = s->abpr[cpu];
         }
         break;
+    case 0x20: /* Aliased Interrupt Acknowledge */
+        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+            *data = 0;
+        } else {
+            attrs.secure = false;
+            *data = gic_acknowledge_irq(s, cpu, attrs);
+        }
+        break;
+    case 0x28: /* Aliased Highest Priority Pending Interrupt */
+        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+            *data = 0;
+        } else {
+            attrs.secure = false;
+            *data = gic_get_current_pending_irq(s, cpu, attrs);
+        }
+        break;
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
     {
         int regno = (offset - 0xd0) / 4;
@@ -1724,7 +1741,15 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         }
         break;
     case 0x10: /* End Of Interrupt */
-        gic_complete_irq(s, cpu, value & 0x3ff, attrs);
+        gic_complete_irq(s, cpu, value & 0x3ff, attrs,
+                         gic_cpu_ns_access(s, cpu, attrs));
+        return MEMTX_OK;
+    case 0x24: /* Aliased End Of Interrupt */
+        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
+            /* unimplemented, or NS access: RAZ/WI */
+        } else {
+            gic_complete_irq(s, cpu, value & 0x3ff, attrs, true);
+        }
         return MEMTX_OK;
     case 0x1c: /* Aliased Binary Point */
         if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
-- 
2.42.1


