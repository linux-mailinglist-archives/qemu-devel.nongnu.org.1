Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA40718E98
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOR-0003Mm-H2; Wed, 31 May 2023 18:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOO-0003Ae-RC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOM-00054j-Kn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so1845285e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572445; x=1688164445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5ueUgIQTlD0vpS7sELdcFGXSEew10rN9NLHJA/jJ1g=;
 b=jHMY5DoTxQ7YAUVMoM48yiG7puIlcKtdgWhlj2cFlzMDgEbz00rQ4sg1k1sZwi9FKO
 FgBsAKh2MXxTclcZn89RPydJOA9wNCyABqDCLCq7Ecfd3wx7XBY1oCzwNaFY/UW06hFj
 fUrRv9ApXiEVg2MWxfgFbNsnyyVefp/AHy0dl6WrmoAkxVKMjniJzY3ZCdG5rtemNPwD
 mU/ARzFyn/2cmcddYGAraxK/74rdNrtXDb2Xhd/xKDqTT6rvYqCi3/xowsn7/96ASkCy
 rXyKBPuV6uA2tYwHX34JNzCaUSJf6bcCT8Slxu5GDYufDWGecwY38YbNxVQ7fmJc6AFA
 VWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572445; x=1688164445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5ueUgIQTlD0vpS7sELdcFGXSEew10rN9NLHJA/jJ1g=;
 b=bybk8gfV2mACFzH7feqCOJnLPPasrKbpQdqyEPCNNcYf4ULhJ5WI5AgHI1uVRtmPmh
 hUbGSxFjU5s/8xybPuiTidUaBB7aglL7vYbHER33NXvzia+u35MDF6imX00C5oQYJD4g
 Y1YT7K2px3nLfZkoBImnoWFDLnhUUzupbgnBIRAUDQJ2oG5CqPNi/oqCEecIa5XNJn4f
 3m6WUuG98eSGq0fZPaCwuClK3fmD6MkWOg805IxP08Z6DUBNQ+6GtDxRE6oDZrexTqCu
 BSAwFsBOylZpu3pePEHzNnj6YJUXLwlOpe8aIc5SHgS9psYLrOrE4Fx4D8naEkiL3RcI
 l9hg==
X-Gm-Message-State: AC+VfDxl9//EZpoG0ng/S91RBe+qiZWcGGahDVuDnGF5yjLkNmu/jibr
 Ex+QEVkNtot6VKWQmB34e90kl9g44oMeT0T3kRM=
X-Google-Smtp-Source: ACHHUZ67nu2QLfu/wqLt/VlORD5mlqkW+LdcKRzena704TjAHhrnMu+wqgq48bniC2t1X3LAoetOLw==
X-Received: by 2002:a05:600c:3650:b0:3f6:2d8:4823 with SMTP id
 y16-20020a05600c365000b003f602d84823mr538248wmq.3.1685572445190; 
 Wed, 31 May 2023 15:34:05 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bc5d7000000b003f6041f5a6csm114610wmk.12.2023.05.31.15.34.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:34:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/usb/hcd-xhci: Use sysbus_init_irqs()
Date: Thu,  1 Jun 2023 00:33:38 +0200
Message-Id: <20230531223341.34827-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
the SysBus API. Use the recently introduced sysbus_init_irqs()
method to avoid using this internal definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


