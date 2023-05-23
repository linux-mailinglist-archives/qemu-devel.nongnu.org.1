Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0070E604
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Y13-00015M-PZ; Tue, 23 May 2023 15:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y11-00012v-Eh; Tue, 23 May 2023 15:49:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q1Y0z-00048k-Md; Tue, 23 May 2023 15:49:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-510e419d701so501469a12.1; 
 Tue, 23 May 2023 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871386; x=1687463386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nwYNmsV4rDlYdUeQmy7CmqzD7Q9Vfrmw6KR+LAlXtA=;
 b=cA3F974mhJeeuFCFFrOt5Q62z6rowHi77vJCtrz+Nuau4mvM+AO1J0FG9EU6k+Dxuy
 g+Kc5bJOUMgAGxeWXPAU76jhUZzqlpzb5eg4h42SyjKdfriVvPdFZHDCChclp5uR97OM
 bXeY0qgdTKuQoiGL04hWzYTuehjh0jD4BfsL7olj6SZazUUCk8N346r3q3rQXFvX6kwq
 c+yQP2viCAGI8cm8+d3BiA3Ftj9BWUuvLjjIDLOAhtNRTUimvKVIkcCM5s3La3Fnt9i2
 e4i5zqA7oVVTwMqlUiktsohoUqd07PDubC2/V/Hap//cwlByHo4b+WGaHNBpE+SyX1np
 9T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871386; x=1687463386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nwYNmsV4rDlYdUeQmy7CmqzD7Q9Vfrmw6KR+LAlXtA=;
 b=Yu5DCIWjX8ewQC5qpQWrhF8QdrTLm5UPF5yFHg/nk6kbTEDm7k6D6UOj4xlQDgfcf/
 ueO0EWQXAsaUGWg+uBOm+9BXJM1WPX/R1+8wJL2znyOpnjT7piPzYjfs0+TgVPeizA/4
 k7TKyCl5+lBQiP0WiF+Q7i7rUmb9jr2BpdXCee5xXHcPZOhTWJUZlSqvgl2sV4ghTBbX
 DtnrQxDSyOWEJSn43oQMY+XGCtt0im2yepX++/W+CwgBZBEDNe+OmRKhmBx8Yt28mhKT
 98M29AJU4d5BVy4qmsK50qgagBhcaMDC3jf6WWTvOptPhn2P/EH4iQ+wIvNPaBuFuJD+
 9PDQ==
X-Gm-Message-State: AC+VfDx0B9LgZHLO0aZajL9poDRpKG2XxGTHH8uvG6O8bYCoxXhbcsPR
 7K7XUQJltFzdNAaaXS5P4Y0TKIAhOKk=
X-Google-Smtp-Source: ACHHUZ4LveUIWLjAIXLg8e632UZ7J9sR9glQrVNa5KHT87t1fTzuQNKC7FBGox7x01qzcCivyOzA+w==
X-Received: by 2002:a17:907:3f16:b0:96f:48ad:73be with SMTP id
 hq22-20020a1709073f1600b0096f48ad73bemr19737191ejc.44.1684871385845; 
 Tue, 23 May 2023 12:49:45 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-183-025-113.77.183.pool.telefonica.de. [77.183.25.113])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a1709063e1100b0096f641a4c01sm4800593eji.179.2023.05.23.12.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 12:49:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, John Snow <jsnow@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 6/6] hw/ide/piix: Move registration of VMStateDescription
 to DeviceClass
Date: Tue, 23 May 2023 21:49:30 +0200
Message-Id: <20230523194930.124352-7-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523194930.124352-1-shentey@gmail.com>
References: <20230523194930.124352-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
2.40.1


