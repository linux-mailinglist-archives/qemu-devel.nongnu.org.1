Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A083970AD94
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2Z-0000ed-NA; Sun, 21 May 2023 07:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2X-0000bb-Sk; Sun, 21 May 2023 07:15:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2W-0004l7-2F; Sun, 21 May 2023 07:15:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso8416434a12.0; 
 Sun, 21 May 2023 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667749; x=1687259749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKcA9Q9vCTMVD2ekonIMizpHtUeqWWMtxHhtpg96PAg=;
 b=Z04KrhWBChotZNqnqeE/6wcwQzB/NEFTPxRCgfKs11Q4qc0NmYaRg7VMp1PPFxtAPv
 89X9c1PFfeyK07YzOv1Z62evgZcq51H/n2UaPtvvhew7wKPhuotELwkfMSSwUzQOF+aD
 OiREEd5BckV4zTzneFLpbP1ZghSHwjEizv4e++655CGaUY23g6f/g/vAnu7ILpcoroZ/
 6P5OpjIPBdN592mIcpHcTCAPOyDHCxCQEhshSFr9SMVTGHinxCkActnmAoiTppdm/i5/
 EGQE+DUJ3x0mEoJMFVS7YnPFgnet3+b3YT1UZ43i0Yxhskm+19fUYQZUZJjKq6VqPYhJ
 Vx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667749; x=1687259749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKcA9Q9vCTMVD2ekonIMizpHtUeqWWMtxHhtpg96PAg=;
 b=fsDxOIj5PA0qE/8mFDmaaIiU/5Svo/RF5PEF1Ue0Kk5Fua5pZHQv4vvCjHtaWJuUZL
 VfvYbFIoQ8cGNcS7x5LI9GjnmEHb7eaiSmYObhTwGuM2a1NkGptFe/PG9dhV3K6duy+e
 alP1X79pOTAsZXWhZFUV/INAX5ShAbNN/19tddA6/fbV1o7OARl4jMF2lz6FnTm2EqIw
 z3PBFgXQzqYLFW3bxDw/LdWBX9x3qpe5zQT1+mLiFBFe4FF+c+2PhdvZp/SDi3K0Ps2N
 WADIpnqt9+6cYz9eHzY7dtqvPCYHfRybzMh8zPiEStn6xfSbF0FHV4OA0q6xi8PdxJNh
 G8rA==
X-Gm-Message-State: AC+VfDzXDqx9zGvfO4zuERaaSgKAivULNd6iFKQlu4g9ermcJPSWWcGV
 GDUM8WwCVLyNzxhTOA37wv38rgVj9NA=
X-Google-Smtp-Source: ACHHUZ4DSgIxc8SPd+jrvUmKM1dt+0uCuMoI2GnvReGrCKjoJ3rn3bcftH7r13i8fzkcEJkN2omN/g==
X-Received: by 2002:aa7:dd18:0:b0:510:82b4:844d with SMTP id
 i24-20020aa7dd18000000b0051082b4844dmr6400395edv.2.1684667749711; 
 Sun, 21 May 2023 04:15:49 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 6/6] hw/ide/piix: Move registration of VMStateDescription to
 DeviceClass
Date: Sun, 21 May 2023 13:15:34 +0200
Message-Id: <20230521111534.207973-7-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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


