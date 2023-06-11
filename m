Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4E72B16F
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 12:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IOy-0006R6-8s; Sun, 11 Jun 2023 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOw-0006Q0-Fa
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8IOu-0008Hq-VC
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 06:34:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-977e83d536fso478815566b.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686479663; x=1689071663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgXS/lSSrzIc4Mus6gPdK+VCh3dqtgaw7zM15A7rEs4=;
 b=TPe7iu9ENmGSuSvqNrBuwHvaYnr8a5wRb1thAo4MlGKTsBkJ3iVcBObkKPwIXc8M2O
 xxLAoiUDFQrxgMHYBGiqoc6aTY3NhVFetnonzihIyC3sGvD8MxmqSDCDBFLQytIl7FfX
 OIOOSWd+n/HrhUZ0pfD3NrKzrf07fzcMFihY8HuYp+EdsxrPLgNGFWlvhZAGY+Cs4Z6C
 Blc2w16OvhJLRDBo62/ReLlWcNl+pb/hgT1hx2SmIEMi+lkdo+eXP2ia3ebjmoQfCuOs
 RS/Ih+HwndEOaOaBQvxwhgVLbVkgTgm5Ifi5Z8z4ruj8D7sShKHfa/stPm6mfHztviFa
 b+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686479663; x=1689071663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgXS/lSSrzIc4Mus6gPdK+VCh3dqtgaw7zM15A7rEs4=;
 b=WHMgwYbIBc44Rtc3e2KP4Mx2ARExiLiuMx2v2ZXjAcb9EIJ0bkwaX+MvVCfuxtpZzK
 FdcXXffjkoqBuhh//y0PWp0FwG/IIovhV+lNN4lWxWj/eRdRwGgW6Hjj9ULWz3Ah30mD
 IJAg7cXMoNn15/8vJLDPwNeppMeKcFz4SCNYAtmqxfolmvkw2gsoI9I1uGHaxBziA86z
 0zdgGkThIEr2lSVaYgchSu5i+ARV7AdYCHDmqC3fczKi25r40soiuHzCW/k2xa7FewjO
 K8RBNgFkTYrSWSMFdah6swSXRTzdZw58JCX5pW59i0mdmdF46h97Gd/Iz17QLsKJGzMl
 hVKw==
X-Gm-Message-State: AC+VfDwk0LHm4D0SJWQQXKPbCs/bEnwnlKu1PSEnDlaVX+iJ3X3RIYxD
 niJalAQc1GgR/GEWDyf8fxfw21LJ5UE=
X-Google-Smtp-Source: ACHHUZ41UXsSD6Yrt5v9qbtbtu+xNpUwUTS6xerch11d8ObHVos875gPa+Pe1Erz6ik9e1xQIKebag==
X-Received: by 2002:a17:907:6e1a:b0:974:5d6e:7941 with SMTP id
 sd26-20020a1709076e1a00b009745d6e7941mr6253233ejc.6.1686479662835; 
 Sun, 11 Jun 2023 03:34:22 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402050800b005149cb5ee2dsm3794314edv.82.2023.06.11.03.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 03:34:22 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/15] hw/pci-host/q35: Initialize PCMachineState::bus in
 board code
Date: Sun, 11 Jun 2023 12:34:00 +0200
Message-ID: <20230611103412.12109-4-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611103412.12109-1-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

The Q35 PCI host currently sets the PC machine's PCI bus attribute
through global state, thereby assuming the machine to be a PC machine.
The Q35 machine code already holds on to Q35's pci bus attribute, so can
easily set its own property while preserving encapsulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_q35.c  | 4 +++-
 hw/pci-host/q35.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 62c5d652b7..29b46d3e1c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,10 +230,12 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
+    pcms->bus = host_bus;
+
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 859c197f25..23b689dba3 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,7 +66,6 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    PC_MACHINE(qdev_get_machine())->bus = pci->bus;
     pci->bypass_iommu =
         PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
-- 
2.41.0


