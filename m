Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D958201B7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPY-0005jb-86; Fri, 29 Dec 2023 16:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPR-0005My-GA
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:49 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPP-0000Ka-PM
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:49 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-203fe0e3fefso3880165fac.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885320; x=1704490120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sb0kvKmYxUvHaaVG2ec6NYva65clnrsq/dPDXpOeYAM=;
 b=WbC4PJQAaiu1zifnjdFMeSOVrJxv4eNzUO3iccmeRuElgM2I+PaAROCJoM+LhtMOYI
 mCNYklWshXnrr8tOfXRu0X+CtV4werPmoO+mQsm3CmpBAd8jyYtVbdnjxjvnLFkqabYI
 iT/3s6VXl6M+DfIiBdrsEdvngDTnvkhRxsgKFncWNath1fEGVNmBSEos5jJ3LGRKaH3v
 pjeOrEPB/Wu4QNC8nvyy0MK3aOSpOXGwAbqKYD8IAyxWgYcJvQvy1wlVSW2UUzcpx9El
 qacGLlAA2xQ4IU8mklrnPDdxyWSJd2f8TRivJYkYpx8O3KPxosU4LMEw3J6yFrLAQiN6
 DEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885320; x=1704490120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sb0kvKmYxUvHaaVG2ec6NYva65clnrsq/dPDXpOeYAM=;
 b=e5huscZVNrXZONgYfQjWdWorOrctFjnymFtD5ItXlhT4YRIanlP25YpGjzuDGjinoA
 VJddSHVN0bWBjxbB07AIU4EFJzYXellUeR1yamwP+BcGrZfL2Z++LD3ekHhzQmeHSWD+
 lDGMOZz4PBNka4CFFUF6y9G65+647ohqf9vC1BPivmni9lKj9Asm+hgQ2fDtCkFBLSqw
 ed2FsILL7y4EC+TeKq5dbOvRsfqafjTel6WqAjWnpuIJdosumtJlTgE10OAhU7M09VnT
 TyjB3T0I1RTOOGTpvCQjG58LKxbBri/lbILeD3RD6IeVIJ94ZJthQ3PgFTglTjuuGsyO
 kLzQ==
X-Gm-Message-State: AOJu0YzJI1ehQZ8Gvr3NwD3+7q+oaHAE8CwIFYkIOERzV/xeuAEV7vzw
 A7eraZTqyOvqF/i/8HTzTaUF6ue2/jWmoMlm0RgEmbMPf4oemQ==
X-Google-Smtp-Source: AGHT+IGHMfbLPgHmkwsEDI9haGDdWqSqp6cpZ3klmkc2QUCcL9XvQA8WjEWh/4L96v63PXpmwmdz4Q==
X-Received: by 2002:a05:6870:c1cb:b0:203:4504:542d with SMTP id
 i11-20020a056870c1cb00b002034504542dmr10400384oad.58.1703885320602; 
 Fri, 29 Dec 2023 13:28:40 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/71] hw/pci-bridge: Constify VMState
Date: Sat, 30 Dec 2023 08:23:20 +1100
Message-Id: <20231229212346.147149-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
Message-Id: <20231221031652.119827-46-richard.henderson@linaro.org>
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


