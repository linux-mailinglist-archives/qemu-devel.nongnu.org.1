Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93980718B9F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T68-0006bU-0U; Wed, 31 May 2023 17:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T65-0006ap-Py; Wed, 31 May 2023 17:11:09 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T64-0001GR-1u; Wed, 31 May 2023 17:11:09 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2af316b4515so1670371fa.1; 
 Wed, 31 May 2023 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567461; x=1688159461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nwYNmsV4rDlYdUeQmy7CmqzD7Q9Vfrmw6KR+LAlXtA=;
 b=RXE+NoA190uI4iDI5qdlMpd3JB40VNOppJDnhhls/O4IKFGhNiSun50X6ygutfYxWP
 6qQuUxyVDoVHpjanI1TcbZPz5D0b6wZXlgq7cOMKwoQJq/Eg9UzOUrRV0W8x4j56dSup
 Bp8KzWM62empAJCu8ryrC2nxzelQpmNxAu9HFnxp8ZhuOTVGr0Jnyl8fyUgSIKk3esRL
 kKh6qHHoAxE3tDJ/pAym3TDhlauxI9mbI7PZjz4Em37WmobwC+XmMskdYea5eeKFMXz6
 Ot+jWRc3of9sQrhTNTuHP8ABctC1+6LW6RJ+JbjmnPW2fk5d6PuMpOM+nMEUvX5J86Xc
 7PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567461; x=1688159461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nwYNmsV4rDlYdUeQmy7CmqzD7Q9Vfrmw6KR+LAlXtA=;
 b=FqwU/kPpnmhn7r1bNHWJ6RPLBT3sn3VhHuYmSyoRPABwGiZvQ36kn/VPFNDyDHte3R
 EeCHneDV04BWFcJDLPfWY5EGCf5oUM6WAX/Wz3h3+TXXm70HSyy6PwCb+cfVzSAEgPc4
 TzI+tS2I2jR+381Ila4WqK+5kcmflTH0Oc9jOtt2swbhZTga2Ix6rNvhfYMwFYKXh8c1
 e52lNandCs5QJHGQtmZLX+09e1OL2KrX2kB6Jfnq2PpdQjZ65WIwQLWa4e+jS7KZiI+A
 1GoPhKk9GY9M8dQO/CLHER3llOfVXs6SUk359fmVCKNGc6fus/4DYqoC+wOf7enA9eir
 ooKw==
X-Gm-Message-State: AC+VfDwXN+cQ0iDYPKR6SymcGpnkTWKjwJhI+OxFNcrvU4iBlBKrmH3w
 YTQ1m+LImNyjNvEGb5nFd4Wm4nZtIdY=
X-Google-Smtp-Source: ACHHUZ7PV793bRSac8TlCFj9ZsfLOHedG/LF3cOakf9jDXeh/W+HXLf/xt3vifFX3NaPleNJnOeGQw==
X-Received: by 2002:a2e:924b:0:b0:2ac:8a05:b2c7 with SMTP id
 v11-20020a2e924b000000b002ac8a05b2c7mr3462833ljg.7.1685567460597; 
 Wed, 31 May 2023 14:11:00 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:11:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 7/7] hw/ide/piix: Move registration of VMStateDescription
 to DeviceClass
Date: Wed, 31 May 2023 23:10:43 +0200
Message-Id: <20230531211043.41724-8-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x231.google.com
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


