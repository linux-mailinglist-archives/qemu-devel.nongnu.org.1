Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C781AD5B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9eS-0006s1-Pr; Wed, 20 Dec 2023 22:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eR-0006qs-0p
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:11 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eP-0006kn-AA
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:10 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67ad5b37147so1785056d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128988; x=1703733788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V73BMfzgyXEUt2jqLmMUXNz57NIwYNMPMceTH2XummA=;
 b=JPtchPTvGZOeA0Unk2PQ3I7DB46rSm1dA8Le0q7g+DtKM2tQQGuvkhopdlcBGtrIQJ
 jcHAawpgyrwxDICPkiLZhXtMiMnSIcU/RdGpz/iiYVCLzLGG3P1s6Wuie+IdY+aKYiQb
 XX4s2pLL9GJbaadLJdavFTgMbJroooUSYLiUCbMdHErZtEhMdCsDjkG3bPfi8Gac8Htw
 RvQ/CXuQROSpzquv1h1H8ac089mLb9Wy0Tx8spO/c2KeKIjYQVFD114o0wgKKPrR7FNV
 i47sgTXgQKjW9ngZFa17o8H38lV5G+3xtBVaMQZXdDTBmc4T6qb4LrjbUS1T/XJGfgHi
 12aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128988; x=1703733788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V73BMfzgyXEUt2jqLmMUXNz57NIwYNMPMceTH2XummA=;
 b=N3YcHkoZNPDzyQXborvGqI8O7c/6aGRUM/cRocpn2QGx1TpFVF0OotkorryLKYS1eD
 SVmQu1Dhi1Qhd5tmkPkDhoAGTSTF5n9/NHoKrRwhCbuX2nKqzyDe9Qbdxj01/5O0vw3K
 224+odVXZnfruf/L5pIVnPX7OkHkq4TgNu+fRvitDPsVy43ClwYu10K2/z0GUsouY3Gw
 HvOHsrDs57d+3lWVjNphmTI6Ppv8WwQP9k6YzYjhN3OiIsSwaKBpQ2h6B3dreuAp3JBC
 5aLHbS/OZdiqdwqnPlLytccM02HWV6STMkm8x9Qx1Cy2bLKqZ9JRsvr5Mp2KtdfI3uhz
 UPYg==
X-Gm-Message-State: AOJu0YwtfUTLVQzRkbo1YeztRwb/WO2EbK375JS8lvj+0+7l6FBMWtwe
 JJi0bnggn5tvbEPYiTXz/5ybFwr4g5tO/GLXLHzbn9hT
X-Google-Smtp-Source: AGHT+IGZX0OuesUU9idklCKN9a8/jhvClpIHX+VtuqwXsTax9fZP3/Zef897OfRILkEmhveamhvX4g==
X-Received: by 2002:a05:6214:20ca:b0:67f:8273:978c with SMTP id
 10-20020a05621420ca00b0067f8273978cmr426357qve.10.1703128987726; 
 Wed, 20 Dec 2023 19:23:07 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 44/71] hw/pci: Constify VMState
Date: Thu, 21 Dec 2023 14:16:25 +1100
Message-Id: <20231221031652.119827-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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
 include/hw/pci/shpc.h | 2 +-
 hw/pci/msix.c         | 4 ++--
 hw/pci/pci.c          | 8 ++++----
 hw/pci/pci_host.c     | 2 +-
 hw/pci/pcie_aer.c     | 4 ++--
 hw/pci/shpc.c         | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index 89c7a3b7fa..a0789df153 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -52,7 +52,7 @@ void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
 
-extern VMStateInfo shpc_vmstate_info;
+extern const VMStateInfo shpc_vmstate_info;
 #define SHPC_VMSTATE(_field, _type,  _test) \
     VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _type, _test, 0, \
                                     shpc_vmstate_info, 0)
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index cd817f4ca8..487e49834e 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -685,7 +685,7 @@ static int get_msix_state(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-static VMStateInfo vmstate_info_msix = {
+static const VMStateInfo vmstate_info_msix = {
     .name = "msix state",
     .get  = get_msix_state,
     .put  = put_msix_state,
@@ -693,7 +693,7 @@ static VMStateInfo vmstate_info_msix = {
 
 const VMStateDescription vmstate_msix = {
     .name = "msix",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name         = "msix",
             .version_id   = 0,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c49417abb2..76080af580 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_pcibus = {
     .name = "PCIBUS",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_EQUAL(nirq, PCIBus, NULL),
         VMSTATE_VARRAY_INT32(irq_count, PCIBus,
                              nirq, 0, vmstate_info_int32,
@@ -673,7 +673,7 @@ static int put_pci_config_device(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-static VMStateInfo vmstate_info_pci_config = {
+static const VMStateInfo vmstate_info_pci_config = {
     .name = "pci config",
     .get  = get_pci_config_device,
     .put  = put_pci_config_device,
@@ -714,7 +714,7 @@ static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-static VMStateInfo vmstate_info_pci_irq_state = {
+static const VMStateInfo vmstate_info_pci_irq_state = {
     .name = "pci irq state",
     .get  = get_pci_irq_state,
     .put  = put_pci_irq_state,
@@ -734,7 +734,7 @@ const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
                                    migrate_is_not_pcie,
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index a18aa0a8d4..dfe6fe6184 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -234,7 +234,7 @@ const VMStateDescription vmstate_pcihost = {
     .needed = pci_host_needed,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(config_reg, PCIHostState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index b68c7ecb49..2c85a78fcd 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -797,7 +797,7 @@ static const VMStateDescription vmstate_pcie_aer_err = {
     .name = "PCIE_AER_ERROR",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(status, PCIEAERErr),
         VMSTATE_UINT16(source_id, PCIEAERErr),
         VMSTATE_UINT16(flags, PCIEAERErr),
@@ -818,7 +818,7 @@ const VMStateDescription vmstate_pcie_aer_log = {
     .name = "PCIE_AER_ERROR_LOG",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(log_num, PCIEAERLog),
         VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog, NULL),
         VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index df7f370111..d2a5eea69e 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -736,7 +736,7 @@ static int shpc_load(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-VMStateInfo shpc_vmstate_info = {
+const VMStateInfo shpc_vmstate_info = {
     .name = "shpc",
     .get  = shpc_load,
     .put  = shpc_save,
-- 
2.34.1


