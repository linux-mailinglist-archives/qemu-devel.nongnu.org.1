Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DF981B5E5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 13:30:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGIBS-0003LH-Pe; Thu, 21 Dec 2023 07:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGIBQ-0003L5-IZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:29:48 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGIBO-0005w5-Bj
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:29:48 -0500
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a2345aaeb05so83553266b.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 04:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703161784; x=1703766584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FYSrW4e2R55swzzhQ6ZzsNRAz1EEA70o2YjF96y5UjE=;
 b=uyZTf4nctRM7pNQHGcrdcmoKXIsTSEgNYyIrzJsekqPI4ALiO7haCM3vpq6CpbZGmP
 zm0bODg1PQ9IQCY3STeZwsLkTiNQHXrrI17NCxQR66f+TOb9cg9P7c3qIsyKJGOiS+4J
 LCXOO0AIcnaOQjRiBhnjvjYyNacwHNLEhEIrS31ffZJ9Iznhx7g/8C6rqYsJV0/pXUFD
 sam/ed0cGKVdLKH3MnN01XiPdacrlNvOsvHEPa5iFYYjbuqRW5/Bgbo7vAW7Mp2TFY8X
 3JUgI+WORRN/D9GDUFpyvF/fXSnxdct/XL38AGTLZQHteNMnevbPrtn1Ug452CtsOw3n
 uIbA==
X-Gm-Message-State: AOJu0YySkyC/Vn1RJsGVTbLJccaTRUyExtZUnJD6ytoq5eqnKJp7zV0Z
 4fInsbjcG9hMGh5jFDyYwmntYZEVukc=
X-Google-Smtp-Source: AGHT+IHeXjajQjDHJHzpxMjX3Xt6rtHM86HRgForPSazb5NUz0IEmlZ7ZpUDIj7RsDtdNPWg8BSqYA==
X-Received: by 2002:a17:906:2083:b0:a26:86c1:14f9 with SMTP id
 3-20020a170906208300b00a2686c114f9mr1602841ejq.69.1703161784355; 
 Thu, 21 Dec 2023 04:29:44 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a170906481900b00a26ac253486sm276605ejq.134.2023.12.21.04.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 04:29:43 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] hw/m68k/mcf5206: Embed m5206_timer_state in m5206_mbar_state
Date: Thu, 21 Dec 2023 13:29:39 +0100
Message-ID: <20231221122939.11001-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.52; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f52.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

There's no need to explicitely allocate the memory here, we can
simply embed it into the m5206_mbar_state instead.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5206.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a46a23538d..183fd3cc08 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -148,15 +148,11 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
     m5206_timer_update(s);
 }
 
-static m5206_timer_state *m5206_timer_init(qemu_irq irq)
+static void m5206_timer_init(m5206_timer_state *s, qemu_irq irq)
 {
-    m5206_timer_state *s;
-
-    s = g_new0(m5206_timer_state, 1);
     s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_LEGACY);
     s->irq = irq;
     m5206_timer_reset(s);
-    return s;
 }
 
 /* System Integration Module.  */
@@ -167,7 +163,7 @@ typedef struct {
     M68kCPU *cpu;
     MemoryRegion iomem;
     qemu_irq *pic;
-    m5206_timer_state *timer[2];
+    m5206_timer_state timer[2];
     DeviceState *uart[2];
     uint8_t scr;
     uint8_t icr[14];
@@ -293,9 +289,9 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
                                 uint16_t offset, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
-        return m5206_timer_read(s->timer[0], offset - 0x100);
+        return m5206_timer_read(&s->timer[0], offset - 0x100);
     } else if (offset >= 0x120 && offset < 0x140) {
-        return m5206_timer_read(s->timer[1], offset - 0x120);
+        return m5206_timer_read(&s->timer[1], offset - 0x120);
     } else if (offset >= 0x140 && offset < 0x160) {
         return mcf_uart_read(s->uart[0], offset - 0x140, size);
     } else if (offset >= 0x180 && offset < 0x1a0) {
@@ -333,10 +329,10 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
                              uint64_t value, unsigned size)
 {
     if (offset >= 0x100 && offset < 0x120) {
-        m5206_timer_write(s->timer[0], offset - 0x100, value);
+        m5206_timer_write(&s->timer[0], offset - 0x100, value);
         return;
     } else if (offset >= 0x120 && offset < 0x140) {
-        m5206_timer_write(s->timer[1], offset - 0x120, value);
+        m5206_timer_write(&s->timer[1], offset - 0x120, value);
         return;
     } else if (offset >= 0x140 && offset < 0x160) {
         mcf_uart_write(s->uart[0], offset - 0x140, value, size);
@@ -598,8 +594,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
     s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
-    s->timer[0] = m5206_timer_init(s->pic[9]);
-    s->timer[1] = m5206_timer_init(s->pic[10]);
+    m5206_timer_init(&s->timer[0], s->pic[9]);
+    m5206_timer_init(&s->timer[1], s->pic[10]);
     s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
     s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
 }
-- 
2.43.0


