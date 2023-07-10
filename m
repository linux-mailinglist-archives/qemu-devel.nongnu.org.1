Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88474E12B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzOg-0005i2-9k; Mon, 10 Jul 2023 18:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOX-0005P9-5y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOU-0002S3-VF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fc03aa6e04so30160835e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028209; x=1691620209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Cp+d10dJMsCx7odnm1IN8BJal/+SMZmh3wzGdS75IY=;
 b=hEPjb8/CeLGyUKZlGSHWX5jprjvTOLtpLi1Rx/Fm7B7nmowdwglGrAjnds3GHSwGJB
 57LFuXMVNxE2UBSUSW+SrTKaSnxHjLhRfrza6BWXzSsxcU4KnWYwF9jJceVYGd1uunrU
 vbNV21XiCdY8i6bptyG/u4qAw4xX3lJQNf+XvR789NBeL5ZlGc4KOEFe0udM/9x/DYX6
 4uQeRDLtefcURQIvNP7ZKy1AkTfr28H2damXICgVyQujdS3B6cCw0bU5A0HU3BxMX4tu
 S7snt7e+Wy+W17RSk0y052HrA5RoeEWXsOR8r0dKhxwWojeZRpj+pAcrQ7ECPYVUMbBW
 opkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028209; x=1691620209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Cp+d10dJMsCx7odnm1IN8BJal/+SMZmh3wzGdS75IY=;
 b=duacImi+k/DWFKetvkfAyEWPhPRzdK3c7SnYXkqHOHP9Jt1AVfEj/K/jUMEHzFgo7i
 cZs43o64MO8Bl/McMnt941wA0KEJbAKeRNfSO6UZFZzD0QlpWxJKONSxHPW62htb2ft2
 tPkdGj2cWEI9p7dWz3OK7m1sjnFSu2MatsfmiiVhNGRW8CoJX0ZKyDcRRTIhdyYIkbLr
 T63Xub66ZPcXZABDJfvEFpJaqi67y1H8i9ueW2iNHzfRNAEZpLKY4qHVv1sJwOAw1pDs
 SZhrcnO14lBMHw22VBjMynSMyxhmcBH1S4cxLWrRBG6GF+LjRy9sV0RtgkCJjlIeysRX
 03dg==
X-Gm-Message-State: ABy/qLbipor7SmRbhe5zQap8RXvUhGXETRfTGSZYO69t6GZ0h8Pgq+Oa
 HCg6AJbvvDUG50F2x4Uat5OEYLu4p+hwNi3ksXzQNw==
X-Google-Smtp-Source: APBJJlF8/qPqqBv5hNrc9fODfdLLyMErzBG3xV/VqQ11eiJnNTcYn6+T8WqxXkiVkxhal+oSyAXXrw==
X-Received: by 2002:a1c:7910:0:b0:3fa:962e:e8f4 with SMTP id
 l16-20020a1c7910000000b003fa962ee8f4mr3827286wme.26.1689028209177; 
 Mon, 10 Jul 2023 15:30:09 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fbfc61d36asm929811wmr.5.2023.07.10.15.30.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:30:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 44/44] hw/ide/piix: Move registration of VMStateDescription to
 DeviceClass
Date: Tue, 11 Jul 2023 00:26:11 +0200
Message-Id: <20230710222611.50978-45-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The modern, declarative way to set up VM state handling is to assign to
DeviceClass::vmsd attribute.

There shouldn't be any change in behavior since dc->vmsd causes
vmstate_register_with_alias_id() to be called on the instance during
the instance init phase. vmstate_register() was also called during the
instance init phase which forwards to vmstate_register_with_alias_id()
internally. Checking the migration schema before and after this patch confirms:

before:
> qemu-system-x86_64 -S
> qemu > migrate -d exec:cat>before.mig

after:
> qemu-system-x86_64 -S
> qemu > migrate -d exec:cat>after.mig

> analyze-migration.py -d desc -f before.mig > before.json
> analyze-migration.py -d desc -f after.mig > after.json
> diff before.json after.json
-> empty

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230531211043.41724-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/piix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 47e0b474c3..151f206046 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -28,7 +28,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/ide/piix.h"
@@ -159,8 +158,6 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
 
-    vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
-
     for (unsigned i = 0; i < 2; i++) {
         if (!pci_piix_init_bus(d, i, errp)) {
             return;
@@ -186,6 +183,7 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     dc->reset = piix_ide_reset;
+    dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
     k->exit = pci_piix_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
@@ -208,6 +206,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     dc->reset = piix_ide_reset;
+    dc->vmsd = &vmstate_ide_pci;
     k->realize = pci_piix_ide_realize;
     k->exit = pci_piix_ide_exitfn;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
-- 
2.38.1


