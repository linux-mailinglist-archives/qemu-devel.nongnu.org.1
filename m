Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A2A8251D9
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNc-0007kx-5z; Fri, 05 Jan 2024 05:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNZ-0007kG-IA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNX-0004LY-Vb
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so14411245e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450278; x=1705055078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Z1mHvdUHHHRFLRSfDR4ab/pkYOdLcf18m6kktBpYUo=;
 b=UZ3Zhg0ZP92wbt5LdIwlMaOQPOpwpLrt/S6bqGUVTzPLc6jB1rGbXxrDDDKCH0JenR
 kRlAlZqG25BP51JddA8q5kvIeEsQesHQB3uL9Du15YOfaD8ziw4gxCVg5+NFzQW10tg/
 j7RcoAiSIbg9leuDyNmBv1t0gICyGY1l9q/WIqK+VYR/IM9+hyxQNMobLJj8bdSd2ecv
 Y2flW7Au5RTMP1fT/OJ7n4G76tOaOxgQ1oVXHJayIGATMf0WCB4KXE5qwqsMXp57p1ft
 mnm/9z7Z+h0XxnMj7f8D8XXCT9zqrSoZvgDGkjAPb4pZZR3Fn8UzbR2XTxqN2pxsqw7T
 kM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450278; x=1705055078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Z1mHvdUHHHRFLRSfDR4ab/pkYOdLcf18m6kktBpYUo=;
 b=hBUM/sfS4LYrKTRQzzh0dain+ygMXrXM5hCMQo4zuAF0Wv6l6dBwBTxctuy6H7pI8u
 fbHZwvaKNoQ3oTJ/f+2LBJHdLtNGWKdMeSog55irYOgBHbKwx0HMHGedAhxKRTqjkEtH
 sdZIV3CbmuwikiIEuBE8t9Dj3FBPOn7L6abYYBhgX3+RzSiI57aph3GqDmN6Vmy353ej
 O+J7QPviFVfWE5ZvY8HrSCRYQpeNtbiJoq9hTdlGYTWw4tl3LlJkdn6bRlovzUnmkvfl
 8qO2FuP6rMY91liH9YG0uS9IX290qso70XTBQt8OSWN83rd7zrAt9b8wreb1jzI5S2S1
 3zyg==
X-Gm-Message-State: AOJu0YwVdzNe/si8SgI/xQ+KVEo5m6lbUUnWNhf/B4oC0Jm5n44bONUG
 nCJQGy7eExnDyh7s8qqtJjp5E2KfO/ZeS1VhWM+IMd9zZA==
X-Google-Smtp-Source: AGHT+IGxE6NmQr3liJqKP6vE0idxPeWQBeUxYrGoeD0PASG4YfPmZKSZ360cVZYIIpm4wwkbHPxKdQ==
X-Received: by 2002:a05:600c:3b87:b0:40d:39cb:6af6 with SMTP id
 n7-20020a05600c3b8700b0040d39cb6af6mr1159688wms.28.1704450278417; 
 Fri, 05 Jan 2024 02:24:38 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:37 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
Subject: [PATCH 3/9] intc/grlib_irqmp: implements the multiprocessor status
 register
Date: Fri,  5 Jan 2024 11:24:15 +0100
Message-Id: <20240105102421.163554-4-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105102421.163554-1-chigot@adacore.com>
References: <20240105102421.163554-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This implements the multiprocessor status register in grlib-irqmp and bind
it to a start signal, which will be later wired in leon3-generic to
start a cpu.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/intc/grlib_irqmp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 2bacc0ff56..be0e840181 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -63,6 +63,7 @@ struct IRQMP {
 
     unsigned int ncpus;
     IRQMPState *state;
+    qemu_irq start_signal[IRQMP_MAX_CPU];
     qemu_irq irq;
 };
 
@@ -70,6 +71,7 @@ struct IRQMPState {
     uint32_t level;
     uint32_t pending;
     uint32_t clear;
+    uint32_t mpstatus;
     uint32_t broadcast;
 
     uint32_t mask[IRQMP_MAX_CPU];
@@ -180,10 +182,12 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
         return state->force[0];
 
     case CLEAR_OFFSET:
-    case MP_STATUS_OFFSET:
         /* Always read as 0 */
         return 0;
 
+    case MP_STATUS_OFFSET:
+        return state->mpstatus;
+
     case BROADCAST_OFFSET:
         return state->broadcast;
 
@@ -222,8 +226,9 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
 static void grlib_irqmp_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
-    IRQMP      *irqmp = opaque;
+    IRQMP *irqmp = opaque;
     IRQMPState *state;
+    int i;
 
     assert(irqmp != NULL);
     state = irqmp->state;
@@ -256,7 +261,13 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
         return;
 
     case MP_STATUS_OFFSET:
-        /* Read Only (no SMP support) */
+        value &= 0xffff;
+        for (i = 0; i < irqmp->ncpus; i++) {
+            if ((value >> i) & 1) {
+                qemu_set_irq(irqmp->start_signal[i], 1);
+                state->mpstatus &= ~(1 << i);
+            }
+        }
         return;
 
     case BROADCAST_OFFSET:
@@ -323,6 +334,8 @@ static void grlib_irqmp_reset(DeviceState *d)
 
     memset(irqmp->state, 0, sizeof *irqmp->state);
     irqmp->state->parent = irqmp;
+    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << 28)
+        | ((1 << irqmp->ncpus) - 2);
 }
 
 static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
@@ -336,6 +349,9 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+    /* Transitionning from 0 to 1 starts the CPUs.  */
+    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
+                             IRQMP_MAX_CPU);
     qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
-- 
2.25.1


