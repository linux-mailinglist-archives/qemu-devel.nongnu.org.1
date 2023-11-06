Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716637E1AB2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:06:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfB-00045t-NQ; Mon, 06 Nov 2023 02:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000c4-PS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcg-0001zE-LN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:19 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-280165bba25so2975171a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254129; x=1699858929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C4/d8fDEdrKWlLr9VF5qAiWuBRzxgxj3sP1Qs1vds=;
 b=o/XLQ8BmyPESVtL/hGweOIgOJQNOMqCNoOtJYAE80xolCIHNSOESMm/yrQ7EUkmVtr
 RQrOCdO7Z4eK9fVVSw1GE7gH8qWjM+2OmcuW9hyqoPV9BXHjGMKHeHEwCIDA+uk6tXCb
 +p1wZCibQtKHTDuLhnKXDh4r+ULwsc/YcuE7drdyv/3WS5dXUUYF4+dtCgU3VItNoecl
 kwJr5kFGK4HEf77sd0ezNpnHNf/r3yoyfxmjykykMPc0Ie/FmE3oJ6oRpqaTf9+ifSou
 88kuO97M2XiG1UWxjnEL2OCpyCNtugz6IvnLMLYmMmiAKLaG7mEqr61UvM23Vy5pipmn
 oM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254129; x=1699858929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7C4/d8fDEdrKWlLr9VF5qAiWuBRzxgxj3sP1Qs1vds=;
 b=nrsOt0SjT7eYONNLmwCs04i1ee1NV2YL4BeJTWdGHfGt5ipCrsKXhRp5Aq2XZXVhqo
 Nb8rd5M8YpQbtXbFADdomHq2Vwr+Kj9/9yD8G+p5PS/9S/MrHTm6gvlPy/vkwII9Y/hC
 cDcKCHRIwr8SjqwAiYQ0/XL2k0N5H4UHsoT5PPOM5RbyhveP2yWa49H1DP6kFL5q6+UM
 jkkjdv9Iat54MCNScmcXZLslq3DKSgFwjGR279MvFDUpll2zo8GUNyHGBMgzVp/JKOcD
 xorteAIElfRT9BSKXZo+GNB8nlzl/HqwaDRzeNk0aSJJHJGrBWltutePmZPnuMAz5CgA
 uvWw==
X-Gm-Message-State: AOJu0YxHi3fdZUUusNausEoluP2iTuuHAq4NQbh4XPx7w/EfPgFNVXjt
 f7zZ/dBPjryYDIkmNtxpz7qbwdgiqBupOLWthnY=
X-Google-Smtp-Source: AGHT+IF0MPtpS+X8aY44Ix3ApbAnWViDbOQ2eADuCVJX85J/XSGq40Yx0nwjRxi0ymm0JEyrogkDSQ==
X-Received: by 2002:a17:90b:111:b0:27d:1339:9176 with SMTP id
 p17-20020a17090b011100b0027d13399176mr23281278pjz.25.1699254129070; 
 Sun, 05 Nov 2023 23:02:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 45/71] hw/pci-bridge: Constify VMState
Date: Sun,  5 Nov 2023 22:58:01 -0800
Message-Id: <20231106065827.543129-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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


