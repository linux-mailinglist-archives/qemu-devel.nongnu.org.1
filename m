Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671F8201A4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKME-0001Tt-Tk; Fri, 29 Dec 2023 16:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM4-0001OC-Az
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:20 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM2-0007rx-8b
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:19 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35fcea0ac1aso35509955ab.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885117; x=1704489917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UmojhtqB/2kgYwvLaiczALHqxM8c341rP1GYhTqnzXY=;
 b=aYhSWXxHou54bDtk4eJPGUKhMRdfsePrb9TJCRVQZJmzuozI8c5X14v062TMKDqkpF
 aBA3HWQVUl2cjjdov+n05ftkrd77blCgKfjNobduTC0DRNIJYi3JgBsdSWZAWLoCMhb+
 urCBm/W5aKiKQe5dWy6yhKaYou5+U5xFHeKoVXhK+sF8dhUpa7f+VWE5SPHTziXOF0uN
 Z5ZnvPFomqADqyLDch1fdfaEnLjoibJIlBwKo5LMcG9+4YPAv6qiBHX/GvNYvvyyTGTC
 CqlNufNk+M2wZ9H0cFIyk/K0K5UM46G/PCARP/M+4zknJ3JVFjSljE/VFnNseprlH2Q1
 HyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885117; x=1704489917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmojhtqB/2kgYwvLaiczALHqxM8c341rP1GYhTqnzXY=;
 b=xARZkUtwF8nYYl7F2igqB4h1euKidGthJXLyRiQN/O4FMpP1IMgVexIA/eDCD8pt0o
 xdPthIe0luz69ActFSKNzKHIp5xA4Ia0pQjmiu7SOVGZRcXcvGA8cLZ0fNV3uOyw4pxz
 9Cg8WflQCA7+CzuKf2cpTwUxUv3eTwfqRxLNhg2Gj//lHQf6e4jtL5uDRSwH2Kr/KEKs
 Lc0ZNU2VmPbiozuBho9FBPHmDT5Ju3mYK2tT8FdZbQ4yTNUQJjLliywhqPe4dcqYDYpJ
 teZnePX4Lcst7Cim74w/7agdquVHHXc+0WQshV3xg6Aap5ax3NKmWlycpvZvLgGH1wQ4
 jCcA==
X-Gm-Message-State: AOJu0YymKjQBtTNOnuQc9HPeXu0VOkCvmA9rWyhTEuEGoyjonDrFBjZa
 Z1/bOoCXRvxoqLqZzhwgHqZrIIRsiiHUp/CUxlJwrRa9UikKoA==
X-Google-Smtp-Source: AGHT+IF5StNFtAm9kiQp4GCEbecoU1/L7ChZbkcpq3oy9itbSP8uTVL6K7oSXahlYdTSeNkv6IXNxw==
X-Received: by 2002:a05:6e02:1caf:b0:360:d98:5387 with SMTP id
 x15-20020a056e021caf00b003600d985387mr6830555ill.122.1703885117296; 
 Fri, 29 Dec 2023 13:25:17 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/71] hw/ipmi: Constify VMState
Date: Sat, 30 Dec 2023 08:23:11 +1100
Message-Id: <20231229212346.147149-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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
Message-Id: <20231221031652.119827-37-richard.henderson@linaro.org>
---
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/ipmi_bmc_sim.c    | 2 +-
 hw/ipmi/ipmi_bt.c         | 2 +-
 hw/ipmi/ipmi_kcs.c        | 2 +-
 hw/ipmi/isa_ipmi_bt.c     | 2 +-
 hw/ipmi/isa_ipmi_kcs.c    | 2 +-
 hw/ipmi/pci_ipmi_bt.c     | 2 +-
 hw/ipmi/pci_ipmi_kcs.c    | 2 +-
 hw/ipmi/smbus_ipmi.c      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 2117dad35a..29c5af3cc3 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -479,7 +479,7 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ipmi_bmc_extern_post_migrate,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(send_reset, IPMIBmcExtern),
         VMSTATE_BOOL(waiting_rsp, IPMIBmcExtern),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 905e091094..33c839c65a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2103,7 +2103,7 @@ static const VMStateDescription vmstate_ipmi_sim = {
     .name = TYPE_IPMI_BMC_SIMULATOR,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),
         VMSTATE_UINT8(msg_flags, IPMIBmcSim),
         VMSTATE_BOOL(watchdog_initialized, IPMIBmcSim),
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 22f94fb98d..583fc64730 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -396,7 +396,7 @@ const VMStateDescription vmstate_IPMIBT = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ipmi_bt_vmstate_post_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(obf_irq_set, IPMIBT),
         VMSTATE_BOOL(atn_irq_set, IPMIBT),
         VMSTATE_BOOL(irqs_enabled, IPMIBT),
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index a77612946a..c15977cab4 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -379,7 +379,7 @@ const VMStateDescription vmstate_IPMIKCS = {
     .version_id = 2,
     .minimum_version_id = 1,
     .post_load = ipmi_kcs_vmstate_post_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(obf_irq_set, IPMIKCS),
         VMSTATE_BOOL(atn_irq_set, IPMIKCS),
         VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index aec064d3cd..7b36d51494 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -77,7 +77,7 @@ static const VMStateDescription vmstate_ISAIPMIBTDevice = {
      * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
      * the buffer length, so random things would happen.
      */
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index b5dcb64616..f52b32e590 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -76,7 +76,7 @@ static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
                              0, vmstate_IPMIKCS, IPMIKCS, 1),
         VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index 633931b825..afeea6f303 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_PCIIPMIBTDevice = {
     .name = TYPE_IPMI_INTERFACE_PREFIX "pci-bt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIIPMIBTDevice),
         VMSTATE_STRUCT(bt, PCIIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index 1a581413c2..05ba97ec58 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_PCIIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE_PREFIX "pci-kcs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIIPMIKCSDevice),
         VMSTATE_STRUCT(kcs, PCIIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
         VMSTATE_END_OF_LIST()
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index d0991ab7f9..56865df7db 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -299,7 +299,7 @@ static const VMStateDescription vmstate_smbus_ipmi = {
     .name = TYPE_SMBUS_IPMI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SMBUS_DEVICE(parent, SMBusIPMIDevice),
         VMSTATE_UINT8(waiting_rsp, SMBusIPMIDevice),
         VMSTATE_UINT32(outlen, SMBusIPMIDevice),
-- 
2.34.1


