Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9F719794
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etR-0004lx-C3; Thu, 01 Jun 2023 05:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etM-0004l9-VK
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etK-0004F3-7e
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so14560315e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612804; x=1688204804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Fxf+SZnw4PIJBwyheZ5LFEtj2ykqgNetOmC+XmhM6A=;
 b=YlBTXBwnaD/PIPk9893Cv4vi/8MuzsGTK0l1d4NvZS5Gtdp/Zt8GhJHNAo82MwtVZJ
 BGNxauwXMiPzWYds4g/HuWfJTb8+pwugxMCv/FrKMi34u8J2KtucLxiNols5fOUcRFrs
 jUEBChfTzNXbeDbQQ84evcqg//XLqIL223TzqsoZH8JrNikyp3VjjyBgV23dfN45bZWI
 qX+1As9DM2Vu7HtCWqb2v/altGVauCsV3Yg/mmLep8iMMPzubFKjjjaHZkiWgQVdHYBh
 2slE0xeYpa/QalGpUZYdOYw7pH66f+BYdaOyy/SLTc6tdxL8HTK5bABCXxM4c5Pho6Nv
 j3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612804; x=1688204804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Fxf+SZnw4PIJBwyheZ5LFEtj2ykqgNetOmC+XmhM6A=;
 b=PlGvlVe0Uw3Tdo094qM2eesZcVhPYnIQJ6I4K860mFl+VLOIl65XuSz3MEknHstylB
 wPCLwcjB78IdU2CiyxS7hIfMPGoc/CMAmg46xFuY68F7eqwR5Cyn/mNvBPW+6DeJRA24
 QdzD2gAnULZJxP3g+6enb5X0i9Ff+BV9+KyqGU01u8B0cNGVkFGVFua5JUu07P6i+pgU
 0BLgJxaCYNKleX0TIkMc8RPiH5rZ8vw81dc7oQzrQygU9QYekahKEilpmR2zqhGe0d6n
 +XQKDomB861OwZKAYAjc4xwfzIYYJlP4XL4FCOfZ2dm8HDOW9/av6FmOnAX6Akw6dMx6
 Ee3g==
X-Gm-Message-State: AC+VfDysl4WpMJ9DjoiG/HjLv4LactCyccGp4Kvy30vt0ED0mATSy2La
 G65K5TDfiHk4lq7W5BQrzHHCJ2KsJKsF9qLgJCk=
X-Google-Smtp-Source: ACHHUZ7vJBrDm/ptRA9YJv0z53cB3TjquRasE6fW+JftzFlULkNcmfvhBWTPH8ZT6SFbzgby5Lt0PA==
X-Received: by 2002:a05:600c:15d4:b0:3f6:117c:b8a1 with SMTP id
 v20-20020a05600c15d400b003f6117cb8a1mr1149973wmf.6.1685612804581; 
 Thu, 01 Jun 2023 02:46:44 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a7bc00f000000b003f4fffccd73sm1724741wmb.9.2023.06.01.02.46.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:46:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/7] hw/sysbus: Introduce sysbus_init_irqs()
Date: Thu,  1 Jun 2023 11:46:21 +0200
Message-Id: <20230601094625.39569-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The SysBus API currently only provides a method to initialize
a single IRQ: sysbus_init_irq(). When we want to initialize
multiple SysBus IRQs, we have to call this function multiple
times. In order to allow further simplifications, introduce
the sysbus_init_irqs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/sysbus.h | 1 +
 hw/core/sysbus.c    | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 3564b7b6a2..bc174b2dc3 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -70,6 +70,7 @@ typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
 MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
+void sysbus_init_irqs(SysBusDevice *dev, qemu_irq *p, unsigned count);
 void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 35f902b582..a1b4c362c9 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -175,10 +175,15 @@ void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
     sysbus_mmio_map_common(dev, n, addr, true, priority);
 }
 
+void sysbus_init_irqs(SysBusDevice *dev, qemu_irq *p, unsigned count)
+{
+    qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, count);
+}
+
 /* Request an IRQ source.  The actual IRQ object may be populated later.  */
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p)
 {
-    qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, 1);
+    sysbus_init_irqs(dev, p, 1);
 }
 
 /* Pass IRQs from a target device.  */
-- 
2.38.1


