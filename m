Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 987297E725A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:31:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiV-0006f5-8T; Thu, 09 Nov 2023 14:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiJ-0005lZ-Px
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:17 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AiH-0005OE-CT
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:14 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5437269a661so4805900a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558150; x=1700162950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbCASInnNu6Q9uFgn8bNgw0dLduM6GSUn61bZ+goPO8=;
 b=aPz1kT8tU/br4Ec1wAGjYyD4QDrp3n3D6WhvdD2rWaRtqEU5d28fgvFtYu9jCQ1sg8
 sfgVeC6Jd8MYr/B+8yKOwnY9zSfUNSunRXY+SkX08lsXi1QPSBuCIxf5upybT3IjPOh3
 XV00CW8P7TLqzTNElYZwPdbSX9ZytJY4P9DinM30KfZugI9+0my51V4ayq3rjkjSuwdu
 muqZhj0z5FrDHUB+W8Url9kGmjyrUWNYRPUhIrb0/uTrJO3zQxb5BOvXGZ/siIyuKdtQ
 aAf45h+y2hDxj+yAdNVdaNYZUpth9bKi66xXcDfV37dxtpWg570UF+wo6z8LcvJbcXpF
 KWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558150; x=1700162950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbCASInnNu6Q9uFgn8bNgw0dLduM6GSUn61bZ+goPO8=;
 b=o2/Ua4JmBxj+1WARDmWYPBaurlk8f036joflcwZlE2doQ67tGhXABaw2NgcgfpyZpH
 akJfyGL+T/EpdkytFR3muuyZHBTMRkMat1CNbLdvaITpzyIMU21Ihw+uZ3Eg5x/qkHkU
 mTugOKP5asKVWNRTWSjKLDSR6I9f3CiheEo4ssybpSYT+Gk6MHfoIn7dWjAiyw2uBKu+
 ueCFkCw6YAeytwiYp/7QD3F5a/OlTLzT5j26OIatfG0MM8uQblIicleojvyjes2Q/CHy
 dLO+jCZZgy7Tr72EKqiZ52ujZAJrJ8Sk489W7d1NW0t7VQ74kHWtyO86nZxwy3o0JL0z
 d92g==
X-Gm-Message-State: AOJu0YytUcBVP4UrOP3lvmq/+EujbJFz9vSQxOGLDtbXlkq6ItpuN5Nb
 EhYDWh+B83CeVvCYt+pikh4ox2RKkJiQfdblEQpL9A==
X-Google-Smtp-Source: AGHT+IFZ9OQdhANq1bPsek6/gcE7FIRaEr3Po/5bXioUHPDEhyNKFqMYWYTc+1BMRXX3iJGYg1lXtg==
X-Received: by 2002:a17:906:bc85:b0:9b2:bdbb:f145 with SMTP id
 lv5-20020a170906bc8500b009b2bdbbf145mr190299ejb.34.1699558150739; 
 Thu, 09 Nov 2023 11:29:10 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 dv16-20020a170906b81000b009a1c05bd672sm2902807ejb.127.2023.11.09.11.29.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:29:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 v4 09/10] hw/char/pl011: Add transmit FIFO to
 PL011State
Date: Thu,  9 Nov 2023 20:28:13 +0100
Message-ID: <20231109192814.95977-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

In order to make the next commit easier to review,
introduce the transmit FIFO, but do not yet use it.

When migrating from new to old VM:
- if the fifo is empty, migration will still work because
   of the subsection.
- if the fifo is not empty, the subsection will be ignored,
  with the only consequence being that some characters will
  be dropped.

Uninline pl011_reset_tx_fifo().

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/pl011.h |  2 ++
 hw/char/pl011.c         | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index d853802132..20898f43a6 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -18,6 +18,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
+#include "qemu/fifo8.h"
 
 #define TYPE_PL011 "pl011"
 OBJECT_DECLARE_SIMPLE_TYPE(PL011State, PL011)
@@ -53,6 +54,7 @@ struct PL011State {
     Clock *clk;
     bool migrate_clk;
     const unsigned char *id;
+    Fifo8 xmit_fifo;
 };
 
 DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 727decd428..f474f56780 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -147,11 +147,13 @@ static inline void pl011_reset_rx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_RXFE;
 }
 
-static inline void pl011_reset_tx_fifo(PL011State *s)
+static void pl011_reset_tx_fifo(PL011State *s)
 {
     /* Reset FIFO flags */
     s->flags &= ~PL011_FLAG_TXFF;
     s->flags |= PL011_FLAG_TXFE;
+
+    fifo8_reset(&s->xmit_fifo);
 }
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
@@ -436,6 +438,24 @@ static const VMStateDescription vmstate_pl011_clock = {
     }
 };
 
+static bool pl011_xmit_fifo_state_needed(void *opaque)
+{
+    PL011State* s = opaque;
+
+    return !fifo8_is_empty(&s->xmit_fifo);
+}
+
+static const VMStateDescription vmstate_pl011_xmit_fifo = {
+    .name = "pl011/xmit_fifo",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl011_xmit_fifo_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_FIFO8(xmit_fifo, PL011State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int pl011_post_load(void *opaque, int version_id)
 {
     PL011State* s = opaque;
@@ -487,7 +507,11 @@ static const VMStateDescription vmstate_pl011 = {
     .subsections = (const VMStateDescription * []) {
         &vmstate_pl011_clock,
         NULL
-    }
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pl011_xmit_fifo,
+        NULL
+    },
 };
 
 static Property pl011_properties[] = {
@@ -502,6 +526,7 @@ static void pl011_init(Object *obj)
     PL011State *s = PL011(obj);
     int i;
 
+    fifo8_create(&s->xmit_fifo, PL011_FIFO_DEPTH);
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
@@ -514,6 +539,13 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static void pl011_finalize(Object *obj)
+{
+    PL011State *s = PL011(obj);
+
+    fifo8_destroy(&s->xmit_fifo);
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
@@ -557,6 +589,7 @@ static const TypeInfo pl011_arm_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PL011State),
     .instance_init = pl011_init,
+    .instance_finalize = pl011_finalize,
     .class_init    = pl011_class_init,
 };
 
-- 
2.41.0


