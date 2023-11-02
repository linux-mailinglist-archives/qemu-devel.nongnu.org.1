Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 789567DEF75
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaU-0001qY-AE; Thu, 02 Nov 2023 06:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaP-0001ol-Us
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:01 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaN-0003IM-9j
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:01 -0400
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-9d2c54482fbso113566666b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919558; x=1699524358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9wRpJQSdYBWKaTUTBDuByfEDItBoYOl7xYTvQ6DLvg=;
 b=mDBo5n7CRjVIceoZYM/Dc7p0tKtRAsj4jaBpUnYQS0SOUlzkaNbKALR2VvpwcBn5iQ
 0Dst488KgwNFvFTDNdKUoELdeHf5zd2QtG5pV2SIFtaw8/Kf/BVCkTXuWIgcOpcsCi0M
 JZWSf2suEN+x/Wh/CR+RDQPtFhV4zJypLaBCb/O73DdCitF990PEoXxRTiEcuw9NWSg6
 /YmecjGSE99xp/m92h7rEMlQp4HvYnJEiwNSDTT24eUxaegAQm8/iDJRSpvKQEcfvPFD
 NqYXE/IJwqqv9JsvJ4a6uMEvIdtAI9Wzdh0LCoaz5HaaBag/glxaDppCfOR+kbIhKlMM
 DplA==
X-Gm-Message-State: AOJu0YylFnw3IV1WSMqjDtmXgLm0UkBabkND8Od3g74+vdr02QQkd+SP
 D0nya+sXnh1Scan08obO57+McYkB64o=
X-Google-Smtp-Source: AGHT+IGkXXiAMuMJp7cejYC88vykT0GJBYxai244rMkASEkOSlSPxdy19tAkwGKtKwLFdQIndR7QNQ==
X-Received: by 2002:a17:907:36c5:b0:9d5:7c41:cd0a with SMTP id
 bj5-20020a17090736c500b009d57c41cd0amr4059888ejc.19.1698919557884; 
 Thu, 02 Nov 2023 03:05:57 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:57 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/10] hw/char/mcf_uart: Have mcf_uart_create() return
 DeviceState
Date: Thu,  2 Nov 2023 11:05:40 +0100
Message-ID: <20231102100543.4875-8-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.50; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f50.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

There is no point in having mcf_uart_init() demote the DeviceState
pointer and return a void one. Directly return the real typedef.

mcf_uart_init() do both init + realize: rename as mcf_uart_create().

Similarly, mcf_uart_mm_init() do init / realize / mmap: rename as
mcf_uart_create_mmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231019104929.16517-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/char/mcf_uart.c    | 13 +++++++------
 hw/m68k/mcf5206.c     |  6 +++---
 hw/m68k/mcf5208.c     |  6 +++---
 include/hw/m68k/mcf.h |  4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 6fa4ac502c..f9cbc9bdc4 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -342,25 +342,26 @@ static void mcf_uart_register(void)
 
 type_init(mcf_uart_register)
 
-void *mcf_uart_init(qemu_irq irq, Chardev *chrdrv)
+DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chrdrv)
 {
-    DeviceState  *dev;
+    DeviceState *dev;
 
     dev = qdev_new(TYPE_MCF_UART);
     if (chrdrv) {
         qdev_prop_set_chr(dev, "chardev", chrdrv);
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
     return dev;
 }
 
-void mcf_uart_mm_init(hwaddr base, qemu_irq irq, Chardev *chrdrv)
+DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chrdrv)
 {
-    DeviceState  *dev;
+    DeviceState *dev;
 
-    dev = mcf_uart_init(irq, chrdrv);
+    dev = mcf_uart_create(irq, chrdrv);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+
+    return dev;
 }
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index f920ca2ceb..a46a23538d 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -168,7 +168,7 @@ typedef struct {
     MemoryRegion iomem;
     qemu_irq *pic;
     m5206_timer_state *timer[2];
-    void *uart[2];
+    DeviceState *uart[2];
     uint8_t scr;
     uint8_t icr[14];
     uint16_t imr; /* 1 == interrupt is masked.  */
@@ -600,8 +600,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
     s->timer[0] = m5206_timer_init(s->pic[9]);
     s->timer[1] = m5206_timer_init(s->pic[10]);
-    s->uart[0] = mcf_uart_init(s->pic[12], serial_hd(0));
-    s->uart[1] = mcf_uart_init(s->pic[13], serial_hd(1));
+    s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
+    s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
 }
 
 static Property mcf5206_mbar_properties[] = {
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index be1033f84f..d22d8536db 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -261,9 +261,9 @@ static void mcf5208evb_init(MachineState *machine)
     /* Internal peripherals.  */
     pic = mcf_intc_init(address_space_mem, 0xfc048000, cpu);
 
-    mcf_uart_mm_init(0xfc060000, pic[26], serial_hd(0));
-    mcf_uart_mm_init(0xfc064000, pic[27], serial_hd(1));
-    mcf_uart_mm_init(0xfc068000, pic[28], serial_hd(2));
+    mcf_uart_create_mmap(0xfc060000, pic[26], serial_hd(0));
+    mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
+    mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
 
     mcf5208_sys_init(address_space_mem, pic);
 
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 8cbd587bbf..5d9f876ffe 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -10,8 +10,8 @@ uint64_t mcf_uart_read(void *opaque, hwaddr addr,
                        unsigned size);
 void mcf_uart_write(void *opaque, hwaddr addr,
                     uint64_t val, unsigned size);
-void *mcf_uart_init(qemu_irq irq, Chardev *chr);
-void mcf_uart_mm_init(hwaddr base, qemu_irq irq, Chardev *chr);
+DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chr);
+DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *chr);
 
 /* mcf_intc.c */
 qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
-- 
2.41.0


