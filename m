Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE357E1AC6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzteL-0003AT-LU; Mon, 06 Nov 2023 02:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd0-0000c5-PS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcf-0001z6-Ot
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:19 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc2f17ab26so27943575ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254128; x=1699858928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bLVib7AchSPhZdPJ4Zn3sc1FEbSCAAat+DX2zUVl9E=;
 b=K6rd5qlM7PkRrS91kbc0C6qY2W1R/b9Ui242Qw0IOs+M921FrEotwOSfuqy0wVVQVt
 FlhCtyjt61BaxFsgg5i+KPshzZD6BQs4VFBLNoOIzmALZZ0T3b2z1YuDgESmxKc7A+A2
 QOckyoXK8d1BZmQPGTMaZ3yvHVgpmucrl0I40C7rGB2+xmzEIWwdG1IaZoTxrPoXigk3
 1UoUdIS7F0d+5JloCuwqPjvX7pdKTHUmxHDZh0syOWEzYS1keV+G44Ir7dt/06AC4knN
 UCyBsEDl+qnW6SLXdnb43juBCJjUL/NUaAkNzrTEkNob6/NZO9tmVssgaCpPeCxmxvBs
 2YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254128; x=1699858928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bLVib7AchSPhZdPJ4Zn3sc1FEbSCAAat+DX2zUVl9E=;
 b=riI6Mkbp7nEsgJH1DVlxCLHWx1pl2GEkXTekODAW44EaavMa3hZo2kEaCoE5w6Ubek
 GGhw5hZE6SvhsMbKZS8rl0gwvXRKam+gQMIi2EIEo1iyxnAqC9uAEBdTx2L2VWSIrlPD
 IfMSL4992zBLbpHgyLJI2mD1yV1bj2ISoPk8dVbY6nHnP7OahYD+f86usm0sdvdqFs9A
 9KGH9SMt2zSU2NIlrz43tr+4SFdruMCvrViDwu5Ht2ZoKDeL6KDNcuHfB487wlbn8s0o
 a/W595bBZ0h1TLrhhHTc1zjECfKu1lSZVLjVJa5YMm7XBJaxedlSGDVWdd/Px70qkIgg
 CQow==
X-Gm-Message-State: AOJu0Yw40Loyqmk6a5pqTiu7qreuEsLm/7m2iD5JLMdgvQU03u33+eCq
 xKoEsuRsByuGJWzUEbCMoAeuoav43JkXqLeTXuE=
X-Google-Smtp-Source: AGHT+IEOPfsCVkao3PIlzf0JtabhTbsT7nk5MekZEweDCEYFvi1bpviNNN1p7Ho/grJxA+Yp4JrxJA==
X-Received: by 2002:a17:90a:9bc9:b0:280:31a8:191d with SMTP id
 b9-20020a17090a9bc900b0028031a8191dmr17269049pjw.39.1699254128217; 
 Sun, 05 Nov 2023 23:02:08 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 44/71] hw/pci: Constify VMState
Date: Sun,  5 Nov 2023 22:58:00 -0800
Message-Id: <20231106065827.543129-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index ab8869d9d0..6ea2eba6da 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -684,7 +684,7 @@ static int get_msix_state(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-static VMStateInfo vmstate_info_msix = {
+static const VMStateInfo vmstate_info_msix = {
     .name = "msix state",
     .get  = get_msix_state,
     .put  = put_msix_state,
@@ -692,7 +692,7 @@ static VMStateInfo vmstate_info_msix = {
 
 const VMStateDescription vmstate_msix = {
     .name = "msix",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name         = "msix",
             .version_id   = 0,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 885c04b6f5..8145d732d2 100644
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


