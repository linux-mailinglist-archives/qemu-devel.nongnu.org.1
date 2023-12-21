Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61A81AD7C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9eV-0006w0-Dt; Wed, 20 Dec 2023 22:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eT-0006sO-DU
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:13 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eR-0006lO-Pj
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:13 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f848f38c4so302506d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128991; x=1703733791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b7C4/d8fDEdrKWlLr9VF5qAiWuBRzxgxj3sP1Qs1vds=;
 b=b5yEAEdIOdnL5vP/5DTUNPfm4q/edcZK2qUbYlqFJeTWiP0P3EdahIsPvwDkxb/WRb
 tkN+D8SBFO7bzAtoK7lMMxy/L4cfR6rZvx6Nvyvwl5Aj+eboJQHqQZ9vrH5m4PVdDEKj
 UOlMk/yzt+PWAYCgTdtlod7WNNTFCXr5CIciqJhW6wNLouaiKWDff2c99LANDnHe/oA+
 BBns+MLmSY9qzPkdGJJR9UR5sY0PqL23UQx3R6AvYGiV+kvM3hPn4hVnkgILep44Cfpn
 EMEgDu7Yo/qaIhqbktcvaXfCHWcgjD8IHuUoWKJIvnn5Ta7Xks8PFHogbSGhPsGqHULP
 98qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128991; x=1703733791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7C4/d8fDEdrKWlLr9VF5qAiWuBRzxgxj3sP1Qs1vds=;
 b=I40XUaq3DWVPWSne/YSWrLFJ6Qz7hA5z3/zinR2ldD/fuB9ug0VRA/rgK9GfmxxeFs
 sOjynANgWyH/6c9CFzLv4Jh2xM8I36hQvtvXEtApDevJ8w+BfYW33970+C7uScWcl6ci
 hue0Arsro7d3n+oyc0mDyVVD2kPqLcsVkJXofLHZCZoyK5b1MG/xhDFZs43mcev2wY+P
 t00Ls5uw9rCeVD8C+ARFoPJeLZTpbfJaJM92JpSzmXLib7M1HY00/2lc4t3TnzIVx49Q
 u5reop5Re3UpqDYsS7FiD03HjOcpr4wg1x6Wo0hACwFDp83zUO20CkvaIBxNf926oXGZ
 17NA==
X-Gm-Message-State: AOJu0YyNXSSsoabC2avtP0PRs2etQ2gkWSFfvyQdbd89dR3glzykR97W
 MNbgFPibGO4HHczRr2VVSgjVCkUXXNPPLxJQd97wta9w
X-Google-Smtp-Source: AGHT+IGy8WqDoEdkgtbFGr2SPWBEna7Y9Wij7D0a0NWKdHafzKzHRcxk3Uykp3kmcC0cf2zsOlWnEw==
X-Received: by 2002:ad4:4eef:0:b0:67f:8226:a793 with SMTP id
 dv15-20020ad44eef000000b0067f8226a793mr436154qvb.119.1703128990763; 
 Wed, 20 Dec 2023 19:23:10 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/71] hw/pci-bridge: Constify VMState
Date: Thu, 21 Dec 2023 14:16:26 +1100
Message-Id: <20231221031652.119827-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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
 hw/pci-bridge/gen_pcie_root_port.c | 2 +-
 hw/pci-bridge/i82801b11.c          | 2 +-
 hw/pci-bridge/ioh3420.c            | 2 +-
 hw/pci-bridge/pci_bridge_dev.c     | 2 +-
 hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 2 +-
 hw/pci-bridge/xio3130_upstream.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 1ce4e7beba..784507c826 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -117,7 +117,7 @@ static const VMStateDescription vmstate_rp_dev = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 0e83cd11b2..c140919cbc 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -81,7 +81,7 @@ err_bridge:
 static const VMStateDescription i82801b11_bridge_dev_vmstate = {
     .name = "i82801b11_bridge",
     .priority = MIG_PRI_PCI_BUS,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index f1e16135a3..be752a4bda 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -88,7 +88,7 @@ static const VMStateDescription vmstate_ioh3420 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 4b2696ea7f..089f91efed 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -199,7 +199,7 @@ static bool pci_device_shpc_present(void *opaque, int version_id)
 static const VMStateDescription pci_bridge_dev_vmstate = {
     .name = "pci_bridge",
     .priority = MIG_PRI_PCI_BUS,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         SHPC_VMSTATE(shpc, PCIDevice, pci_device_shpc_present),
         VMSTATE_END_OF_LIST()
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 2301b2ca0b..7646ac2397 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -132,7 +132,7 @@ static Property pcie_pci_bridge_dev_properties[] = {
 static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
         .name = TYPE_PCIE_PCI_BRIDGE_DEV,
         .priority = MIG_PRI_PCI_BUS,
-        .fields = (VMStateField[]) {
+        .fields = (const VMStateField[]) {
             VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
             SHPC_VMSTATE(shpc, PCIDevice, NULL),
             VMSTATE_END_OF_LIST()
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 38a2361fa2..907d5105b0 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -146,7 +146,7 @@ static const VMStateDescription vmstate_xio3130_downstream = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pcie_cap_slot_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index a48bfe3bc5..2a6cff6e03 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -115,7 +115,7 @@ static const VMStateDescription vmstate_xio3130_upstream = {
     .priority = MIG_PRI_PCI_BUS,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),
         VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,
                        vmstate_pcie_aer_log, PCIEAERLog),
-- 
2.34.1


