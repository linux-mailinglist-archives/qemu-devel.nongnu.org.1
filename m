Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510247CF5C0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQb2-0004uH-E5; Thu, 19 Oct 2023 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtQaw-0004cU-EP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:49:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtQas-0007HR-1A
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:49:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40651a726acso68030115e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697712572; x=1698317372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PVB0hf0dgPONyyXai2FsjtWxXx5FUoKYORTKC7VUilw=;
 b=LZD+VETGlxccX5MDKKIllr0dsod4YhEZQLgvD+zaL8h9a98vZsjI4LMgxI1SoQhoj8
 EpmmSYnc+HJR9EiSZU1HGKnFJUVhR+KriAuo3YykByhJcFfhz07cQyXTEcNYOUeP/Gko
 WWxxPRBLJ2KgPpt9lyBjHPwVVK5aBh1MiosmM7vXkVI5xh0tSxuRU2wTiu3WY83PWKvy
 QTp/7cp1anwdW7ckexnO/4b+K12xKKGx+i8Z2qoU9PKnNPE7ACfXnLYpmgd04mKQ3XxM
 t1Mn7tcD8r+VdAXVWyoLgderbszSOEWx0+Ms5uD/NkAAKm9u54chkABtWDsiR6nxHVeH
 gjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712572; x=1698317372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVB0hf0dgPONyyXai2FsjtWxXx5FUoKYORTKC7VUilw=;
 b=gBP/LeDwWDhSBm5JuP4iV4/djjGwADOApfKH9AnF4k+///O6qenMvDYcnABYjJ32pa
 wZ+1/ow5P3ufHa61HJzMBnzF1BPWc56WtBVASDXFpQm2kUTcJBp1kzuAm0bRSbu4Yzar
 2pIQDUmL2bf2xB9vm/ddZHZxwfWFJgHzsPJ26b2XkcmijseNTTRe2Gypeon1YYGVzAMZ
 L5ArcP8lITgkG15yqosDm05SuCFiMRAEDsurfe79KqtWe0oczMBSHz8zuKrQoHsmB3R1
 E8QyNGVM34UqosujyOqs1GePGmFLBrHKM33pikunVyX/4+rIW1vrJOo40A0o9m6te3Oh
 bvCQ==
X-Gm-Message-State: AOJu0YzPw4aOahUqWI55F9PJkSrbzj6zMn6T2NbI/1EVFSxo0dwsYxNw
 aaocH+oHmOSlrcPovy0NzE8EtFzCLOMf7YT6XxsxPA==
X-Google-Smtp-Source: AGHT+IHA4Se1R7O8ru4f12yewLqT2guRTpSlW1ST8vwqqRrAnS0nyHoVeorMvzJ0SnCwAkKj3yCpig==
X-Received: by 2002:a5d:4a85:0:b0:32d:ad8b:29fc with SMTP id
 o5-20020a5d4a85000000b0032dad8b29fcmr1259599wrq.7.1697712572197; 
 Thu, 19 Oct 2023 03:49:32 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 q28-20020adfab1c000000b003248a490e3asm4228920wrc.39.2023.10.19.03.49.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 03:49:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/char/mcf_uart: Have mcf_uart_create() return DeviceState
Date: Thu, 19 Oct 2023 12:49:29 +0200
Message-ID: <20231019104929.16517-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

There is no point in having mcf_uart_init() demote the DeviceState
pointer and return a void one. Directly return the real typedef.

mcf_uart_init() do both init + realize: rename as mcf_uart_create().

Similarly, mcf_uart_mm_init() do init / realize / mmap: rename as
mcf_uart_create_mmap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/m68k/mcf.h |  4 ++--
 hw/char/mcf_uart.c    | 13 +++++++------
 hw/m68k/mcf5206.c     |  6 +++---
 hw/m68k/mcf5208.c     |  6 +++---
 4 files changed, 15 insertions(+), 14 deletions(-)

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
index 2ab1b4f059..673861574c 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -167,7 +167,7 @@ typedef struct {
     MemoryRegion iomem;
     qemu_irq *pic;
     m5206_timer_state *timer[2];
-    void *uart[2];
+    DeviceState *uart[2];
     uint8_t scr;
     uint8_t icr[14];
     uint16_t imr; /* 1 == interrupt is masked.  */
@@ -599,8 +599,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
     s->pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
     s->timer[0] = m5206_timer_init(s->pic[9]);
     s->timer[1] = m5206_timer_init(s->pic[10]);
-    s->uart[0] = mcf_uart_init(s->pic[12], serial_hd(0));
-    s->uart[1] = mcf_uart_init(s->pic[13], serial_hd(1));
+    s->uart[0] = mcf_uart_create(s->pic[12], serial_hd(0));
+    s->uart[1] = mcf_uart_create(s->pic[13], serial_hd(1));
     s->cpu = M68K_CPU(qemu_get_cpu(0));
 }
 
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
 
-- 
2.41.0


