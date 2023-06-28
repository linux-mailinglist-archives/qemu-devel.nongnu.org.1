Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA50741910
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDF-0004hP-DK; Wed, 28 Jun 2023 15:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD9-0004g8-N0
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:20 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD7-0005hx-DW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b69e6d324aso3657561fa.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981935; x=1690573935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCVk7jdt1nDqHH6A+S2BbR5/KvJS5BvxayG0t6p+t7Q=;
 b=g4Zm4T/cD6DYwp5JSBB0X0v+RiO5uDIPzzlYAGxoch8ZLRDrvu5YE02aGTtwUM1nqD
 LBMVfM204G/JnDsAw2Cg7DXNd7Kn2zabQRh1gIHko70K8wH4DCWF3kPZlWio/pa1RpRi
 nkwAKsRgOVQEGuW7ly6hAcipTOg1wTesK3o51cltzhlLExrZJb1TaKejupaWW4Qx4jw8
 bK/Vpfu6fcOTiojz25Wup3YAOP7ElYGYk5jlDUQMIyuXr5K1KDi3eVBfbLQ6EgggqU3B
 Wm/mO6zbVBxvfgHUmgoGt4zgVnJJbFX9f2TbaI/kNx9sC4fGk28Aw2KxqTuNKgrq6gmi
 fuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981935; x=1690573935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCVk7jdt1nDqHH6A+S2BbR5/KvJS5BvxayG0t6p+t7Q=;
 b=QiWj4M1uOKN6wA3BqrYFEn2P6N5ywKwZp3StFRWg4+E+rMi5QmPyTCAGxme3950FAD
 JN9Ymry4yQuBC2SGqE4mwpMKF0DVjcAq49W0y0BgWx4+aRhnrngYpmtmFDZxB3299Kcr
 3b195MqkLQMjJiJhQnO5E0SwAJ1DlRIZwyPYEF7ieAkJDTG7BPkJsgmAf3l37KwOsQPc
 ZgqSsR79SBifXV3XcrXPev1W1ou9CnBIgEkbg7/YRP7VgNugO/q5QDccD/3BEPn3Zq4F
 4fvbjDBsTagTWQvml2hA56TIHTzBNhir6+ZJ5UTRfo3j1kHK1buXJg7z3cM9Vey8fD6t
 m/0A==
X-Gm-Message-State: AC+VfDwfRQe89EDP6/Eoz190sZGFtyoIjAMJZLKBRNkB+pYaceXhXEO9
 RV9fd2el3g6SDMVJBUV0x1d3cwGB+J8=
X-Google-Smtp-Source: ACHHUZ4XzFUe54bMOk0YomRIYK7gIFOvGZJcs0BNUJms0iw+xNxthUc2DBXatPOLdbaSXUrEDjKwUQ==
X-Received: by 2002:a2e:9d4e:0:b0:2b4:67e0:4ce0 with SMTP id
 y14-20020a2e9d4e000000b002b467e04ce0mr18407294ljj.44.1687981935148; 
 Wed, 28 Jun 2023 12:52:15 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:14 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/16] hw/pci-host/q35: Initialize PCMachineState::bus in
 board code
Date: Wed, 28 Jun 2023 21:51:51 +0200
Message-ID: <20230628195204.1241-4-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x230.google.com
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c  | 4 +++-
 hw/pci-host/q35.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d9f3764184..4edc0b35f4 100644
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
index 84137b9ad9..0604464074 100644
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


