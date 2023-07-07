Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9874AFFD
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiJ-0005fB-3t; Fri, 07 Jul 2023 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiF-0005G8-Pq; Fri, 07 Jul 2023 07:33:23 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiE-0006u0-7w; Fri, 07 Jul 2023 07:33:23 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b71cdb47e1so1664876a34.2; 
 Fri, 07 Jul 2023 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729598; x=1691321598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=inYj1z4XvKpRgYQeWXDwRoR2Y8iBOO+qdVBrbFhhCdE=;
 b=Cike4Pon/+7O6HzRr8azo4LinDf4nt4mmvZ4RdNeegYkJFQmDmgJihrHoXDtrwD9AF
 DkzUSosxjwG8mSQXdvp06l96gSecjwNysb20Ds1QlYBF394xk5/aY4t64F4RMcmfzCR5
 aFZHbBt+RnyuegajJqcJEd3cGYSD6ndk7PPooEkR5bmA5qrm2juDrFkrDjeTbSe/QIaY
 2EL7xfr5DQrqpHTSLbvKJtfQQ2MwzgKRbOsXd//p/NS/Hly+hB+ozwFXfu5RwMS4nrZx
 Nfb4fARZDJg9ymA7EXj6QykR+NV28jgcpezueeCchQs27U96JQRnroAThdK5Qqt3YJDK
 Mkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729598; x=1691321598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=inYj1z4XvKpRgYQeWXDwRoR2Y8iBOO+qdVBrbFhhCdE=;
 b=hqIp/NEJy6nPROpf6z49pe9/DJeEUQUHbanT8GGvY2RU80+15SBpUxy6s6VUa5eXeu
 LjPant/quLRZBUbbD4DKjHvPJN+ppMPOo7+cGwVNT9cy1d1W5NGoMnaxGllRCWFPGIJq
 oZUffkorFpZekPhWhjOVGAatW8EI2NFNP2jgX4VaVA9WOCsuL4MYGyiaOUc5uWKBiBSL
 XE7QDszlasfROheN/I9MxMlp3mxvEj0Qhvk3WfL8GrEhuaSAjLqDpQoTBn1/QfyxtmgB
 niV4MgA7vfS0vgN8PQjI+K4quKbtYjEveQEd6N2QE8ri7AGvLpGjLyMgfV8lntO8SgUq
 LuJQ==
X-Gm-Message-State: ABy/qLZhbs/4LEO3z3zhHLdakE9vq74YtCxmhM1CUxkhA0cHPRgRAydJ
 hhZOsvJ7S7hf56oawfvAChaTXYeC6ls=
X-Google-Smtp-Source: APBJJlHCBpKn4G1SMtKKnoFXzHvJEiPM0AZtzL6a2oKOfZFuMqMqAlOggEIGI+giwzRcXDTSnWKnyg==
X-Received: by 2002:a05:6830:1d47:b0:6b2:ac44:bf88 with SMTP id
 p7-20020a0568301d4700b006b2ac44bf88mr5578782oth.10.1688729598496; 
 Fri, 07 Jul 2023 04:33:18 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:18 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 46/60] ppc4xx_pci: Rename QOM type name define
Date: Fri,  7 Jul 2023 08:30:54 -0300
Message-ID: <20230707113108.7145-47-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Rename the TYPE_PPC4xx_PCI_HOST_BRIDGE define and its string value to
match each other and other similar types and to avoid confusion with
"ppc4xx-host-bridge" type defined in same file.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <c59c28ef440633dbd1de0bda0a93b7862ef91104.1688641673.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_bamboo.c  | 3 +--
 hw/ppc/ppc4xx_pci.c     | 6 +++---
 include/hw/ppc/ppc4xx.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f061b8cf3b..45f409c838 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -205,8 +205,7 @@ static void bamboo_init(MachineState *machine)
     ppc4xx_sdram_ddr_enable(PPC4xx_SDRAM_DDR(dev));
 
     /* PCI */
-    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST_BRIDGE,
-                                PPC440EP_PCI_CONFIG,
+    dev = sysbus_create_varargs(TYPE_PPC4xx_PCI_HOST, PPC440EP_PCI_CONFIG,
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[0]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[1]),
                                 qdev_get_gpio_in(uicdev, pci_irq_nrs[2]),
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 1d4a50fa7c..fbdf8266d8 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -46,7 +46,7 @@ struct PCITargetMap {
     uint32_t la;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST_BRIDGE)
+OBJECT_DECLARE_SIMPLE_TYPE(PPC4xxPCIState, PPC4xx_PCI_HOST)
 
 #define PPC4xx_PCI_NR_PMMS 3
 #define PPC4xx_PCI_NR_PTMS 2
@@ -321,7 +321,7 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
     int i;
 
     h = PCI_HOST_BRIDGE(dev);
-    s = PPC4xx_PCI_HOST_BRIDGE(dev);
+    s = PPC4xx_PCI_HOST(dev);
 
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
@@ -386,7 +386,7 @@ static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ppc4xx_pcihost_info = {
-    .name          = TYPE_PPC4xx_PCI_HOST_BRIDGE,
+    .name          = TYPE_PPC4xx_PCI_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(PPC4xxPCIState),
     .class_init    = ppc4xx_pcihost_class_init,
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 39ca602442..e053b9751b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,7 +29,7 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
-#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
+#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
 #define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
 
 /*
-- 
2.41.0


