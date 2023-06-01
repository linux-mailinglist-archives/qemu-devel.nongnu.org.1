Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D5B71979B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etj-00059O-Te; Thu, 01 Jun 2023 05:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etX-0004sQ-Dw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etQ-0004IU-QM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso574333f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612810; x=1688204810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytKJ4206h8h9MIhh3K2ca9hAIyIqwQjtRMy0/wxoB3g=;
 b=wg47OOV5b8F3NyTo4A43okoBT+ngjyaXy1BoODOnpRuXOZtaajxJvbn7NYLBxnQVFe
 E+C1LPP2ZezHhVFA9xFI2HwjPtDVaQBwwYKkt4CTCespHOjh4LDTGph8JrIbbbnorKDb
 UtOh6mdvIcayOJgu5HCgZYXIhqJRUSXq/LAvbvPWOx2govt+SLKn0WMd4mZ2oIF9s6FU
 YaFvqpla/jd3yGWRGCTiw3TH58bEWAkcqyhzrm+zhXWh0t2SnRXUtHSl+pOA6rs3j8Hp
 0v+kFVeTenKezV4fOo1285/Ovq8r7angbnzq7rS1FVf3F/RR33XiuZ6I+tyw0ExTbVb3
 eISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612810; x=1688204810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytKJ4206h8h9MIhh3K2ca9hAIyIqwQjtRMy0/wxoB3g=;
 b=ULTfdQM7zPxJ3yK5ozXsxHvWvRjpXTmNbzWnKPtIkg07bACZzweRpOKVvQ+xcnzA5E
 6poGwluFbYQPqE4yGEsKhs4fHBukNWJQd9TyOMZ3UCgoYcnOUH8xSySyPn+KZG/Aj25c
 xzeM0ohM+qa+wKKbfBHfPiSeHLercjY197l3GFLdGxIhirDX2wnpm+cx4UNQfQYBQs1b
 CdcZmyDaTkrkaD3150rEQkj2tihpCeiacWYdMo4oOJbY17pRvy+428ofAA3xFPIfiYMI
 sY0WA0kuzZ+P1882VBpeTTfyBYSEMUKd27l1gJy/YnVx51oJcpHi/3BeLxyoiLHjd15Q
 Vxpw==
X-Gm-Message-State: AC+VfDzXDqcBISgbDyoprHgztIH9OsiNdQ5sO9EFjBCRo/eIQxlFGTTX
 /n6uD3+8/iYWvNLSuZDvhn7Z78pDtjkytDdwpGU=
X-Google-Smtp-Source: ACHHUZ6RF0EEkq24xKBrxOG4dSAuFeWtLUfJrkBXPswHV90go2KG/P8AUXtxIOqRfW+VBo0uSBodwQ==
X-Received: by 2002:a5d:4249:0:b0:309:3bb5:7968 with SMTP id
 s9-20020a5d4249000000b003093bb57968mr1504958wrr.16.1685612810153; 
 Thu, 01 Jun 2023 02:46:50 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a5d474d000000b0030af54c5f33sm8276554wrs.113.2023.06.01.02.46.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:46:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/7] hw/usb/hcd-xhci: Use sysbus_init_irqs()
Date: Thu,  1 Jun 2023 11:46:22 +0200
Message-Id: <20230601094625.39569-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
the SysBus API. Use the recently introduced sysbus_init_irqs()
method to avoid using this internal definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/usb/hcd-xhci-sysbus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index faf57b4797..e512849b34 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -40,9 +40,6 @@ static void xhci_sysbus_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
         return;
     }
-    s->irq = g_new0(qemu_irq, s->xhci.numintrs);
-    qdev_init_gpio_out_named(dev, s->irq, SYSBUS_DEVICE_GPIO_IRQ,
-                             s->xhci.numintrs);
     if (s->xhci.dma_mr) {
         s->xhci.as =  g_malloc0(sizeof(AddressSpace));
         address_space_init(s->xhci.as, s->xhci.dma_mr, NULL);
@@ -50,6 +47,8 @@ static void xhci_sysbus_realize(DeviceState *dev, Error **errp)
         s->xhci.as = &address_space_memory;
     }
 
+    s->irq = g_new0(qemu_irq, s->xhci.numintrs);
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, s->xhci.numintrs);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->xhci.mem);
 }
 
-- 
2.38.1


