Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C97E1ABE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:09:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdr-0002P6-Of; Mon, 06 Nov 2023 02:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cP-4o
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztch-0001zI-GC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:25 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2802d218242so4015451a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254130; x=1699858930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTfc4X0+Myi8VwONAnHbzo7jD2I4ophlWbNZWjt4wb0=;
 b=PEtGAymOWF6KPkdnN++ppaVgm7/KhpvBAxdm8HvL7O2rBjHyrkg7uuhm3yxg2CLvmd
 xz4qn9ftW+B71sC04p11B3nXwfBDaw77Beyv5dg5vsWAx7fLg4YG6MdfuVQ4mhEqX1PN
 5G56/vfQxtRFedj7oXJ447AgwdT2Xu37BcvuVaTQY/3R3lmAqzkiHNZeHuwx5IoWLqJv
 VOoJME/yMPpQv4DWMlYbesWR5niWZkjikpQhlAJm/eN2mDbK+jU52o15J/8rmSHLzyd0
 FS8U9w3eMfgW7/u3odDKucOtW2R1/kPtpkxPhjDdU/q2EuJEDqvMFLyuUT0yVjJDp26T
 stlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254130; x=1699858930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTfc4X0+Myi8VwONAnHbzo7jD2I4ophlWbNZWjt4wb0=;
 b=YhXJBIIPqinrWM85QU1tC7wBUKqzVFgBM6i6t2OIC40mXIp1tsl7257C7zCLZ2bwTI
 PUVlNG1jLsp5kMBS3xEQn/AmYNUZTmznmx51iTdFiFp6y4+JVZaeSAEf6b+8lty9+cU2
 ELu4M2WmF4Jus/pOepyxmNIbHSrb333AjBqymPWOQpaf6YHzC3c9t/fZd77443RKqZoY
 ATf9uib5/vN2EgRZpt4cf/IQGcp+i+RqRQLbr8UF2y9Ctvm+9JQyV+kYfEoHVcPQ96Pb
 FkvuB7VPPpTqzsj3huPV4yWZFQs1AhXs3sD4ysgW8qXnOgLVO42zJZI7gIk5N4yBVb/e
 MBvQ==
X-Gm-Message-State: AOJu0Yw+SWtM3hoU/6n1v0vxH4RiGe08xJZFbQNvtJMJONYmgAAJ+npX
 HUjxrXsnf0y5Pi1m19e1+GHU1XEDY+jTSs41Hds=
X-Google-Smtp-Source: AGHT+IH/95zPYoljcoRmBt8M8OBQDViPEpxpG7QVfFglY59tNZNevMZGK8gcucOZoU5cR8bJkOeJYA==
X-Received: by 2002:a17:90b:19d0:b0:268:ca76:64a with SMTP id
 nm16-20020a17090b19d000b00268ca76064amr23683453pjb.49.1699254129880; 
 Sun, 05 Nov 2023 23:02:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 46/71] hw/pci-host: Constify VMState
Date: Sun,  5 Nov 2023 22:58:02 -0800
Message-Id: <20231106065827.543129-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci-host/astro.c      |  4 ++--
 hw/pci-host/bonito.c     |  2 +-
 hw/pci-host/designware.c | 10 +++++-----
 hw/pci-host/dino.c       |  2 +-
 hw/pci-host/gpex.c       |  2 +-
 hw/pci-host/gt64120.c    |  2 +-
 hw/pci-host/i440fx.c     |  2 +-
 hw/pci-host/ppce500.c    |  6 +++---
 hw/pci-host/q35.c        |  2 +-
 hw/pci-host/raven.c      |  2 +-
 hw/pci-host/versatile.c  |  2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 4b2d7caf2d..36639a010c 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -462,7 +462,7 @@ static const VMStateDescription vmstate_elroy = {
     .name = "Elroy",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(hpa, ElroyState),
         VMSTATE_UINT32(pci_bus_num, ElroyState),
         VMSTATE_UINT64(config_address, ElroyState),
@@ -694,7 +694,7 @@ static const VMStateDescription vmstate_astro = {
     .name = "Astro",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ioc_ctrl, AstroState),
         VMSTATE_UINT64(ioc_status_ctrl, AstroState),
         VMSTATE_UINT64_ARRAY(ioc_ranges, AstroState, (0x03d8 - 0x300) / 8),
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index bab661f3ce..1f0c435348 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -619,7 +619,7 @@ static const VMStateDescription vmstate_bonito = {
     .name = "Bonito",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIBonitoState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 6f5442f108..6c191d1e55 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -529,7 +529,7 @@ static const VMStateDescription vmstate_designware_pcie_msi_bank = {
     .name = "designware-pcie-msi-bank",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(enable, DesignwarePCIEMSIBank),
         VMSTATE_UINT32(mask, DesignwarePCIEMSIBank),
         VMSTATE_UINT32(status, DesignwarePCIEMSIBank),
@@ -541,7 +541,7 @@ static const VMStateDescription vmstate_designware_pcie_msi = {
     .name = "designware-pcie-msi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEMSI),
         VMSTATE_STRUCT_ARRAY(intr,
                              DesignwarePCIEMSI,
@@ -557,7 +557,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
     .name = "designware-pcie-viewport",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEViewport),
         VMSTATE_UINT64(target, DesignwarePCIEViewport),
         VMSTATE_UINT32(limit, DesignwarePCIEViewport),
@@ -570,7 +570,7 @@ static const VMStateDescription vmstate_designware_pcie_root = {
     .name = "designware-pcie-root",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         VMSTATE_UINT32(atu_viewport, DesignwarePCIERoot),
         VMSTATE_STRUCT_2DARRAY(viewports,
@@ -714,7 +714,7 @@ static const VMStateDescription vmstate_designware_pcie_host = {
     .name = "designware-pcie-host",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(root,
                        DesignwarePCIEHost,
                        1,
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 82503229fa..1f84ab6147 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -287,7 +287,7 @@ static const VMStateDescription vmstate_dino = {
     .name = "Dino",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(iar0, DinoState),
         VMSTATE_UINT32(iar1, DinoState),
         VMSTATE_UINT32(imr, DinoState),
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index a6752fac5e..e117e47fa7 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -195,7 +195,7 @@ static const VMStateDescription vmstate_gpex_root = {
     .name = "gpex_root",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, GPEXRootState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 143bf053d7..e02efc9e2e 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -431,7 +431,7 @@ static const VMStateDescription vmstate_gt64120 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = gt64120_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, GT64120State, GT_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 653cc3f149..4f0a0438d7 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -125,7 +125,7 @@ static const VMStateDescription vmstate_i440fx = {
     .version_id = 3,
     .minimum_version_id = 3,
     .post_load = i440fx_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
         /* Used to be smm_enabled, which was basically always zero because
          * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 38814247f2..6aeba5e651 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -379,7 +379,7 @@ static const VMStateDescription vmstate_pci_outbound = {
     .name = "pci_outbound",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(potar, struct pci_outbound),
         VMSTATE_UINT32(potear, struct pci_outbound),
         VMSTATE_UINT32(powbar, struct pci_outbound),
@@ -392,7 +392,7 @@ static const VMStateDescription vmstate_pci_inbound = {
     .name = "pci_inbound",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pitar, struct pci_inbound),
         VMSTATE_UINT32(piwbar, struct pci_inbound),
         VMSTATE_UINT32(piwbear, struct pci_inbound),
@@ -405,7 +405,7 @@ static const VMStateDescription vmstate_ppce500_pci = {
     .name = "ppce500_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(pob, PPCE500PCIState, PPCE500_PCI_NR_POBS, 1,
                              vmstate_pci_outbound, struct pci_outbound),
         VMSTATE_STRUCT_ARRAY(pib, PPCE500PCIState, PPCE500_PCI_NR_PIBS, 1,
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 08534bc7cc..0d7d4e3f08 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -520,7 +520,7 @@ static const VMStateDescription vmstate_mch = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = mch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
         /* Used to be smm_enabled, which was basically always zero because
          * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 9a11ac4b2b..b51c0ef901 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -379,7 +379,7 @@ static const VMStateDescription vmstate_raven = {
     .name = "raven",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, RavenPCIState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 60d4e7cd92..0e65deb3f9 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -147,7 +147,7 @@ static const VMStateDescription pci_vpb_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pci_vpb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(imap, PCIVPBState, 3),
         VMSTATE_UINT32_ARRAY(smap, PCIVPBState, 3),
         VMSTATE_UINT32(selfid, PCIVPBState),
-- 
2.34.1


