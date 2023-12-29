Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB68201D4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPb-0006BS-3S; Fri, 29 Dec 2023 16:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPQ-0005Gu-3m
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:49 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPH-0000KI-Jd
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:41 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9a79a1ad4so1725270b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885318; x=1704490118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CUHhbLfoN2d7ET2o9i2N09+Q0gqs/g1wftGgAlf1CKE=;
 b=bljjymqYnNO8iK9/Iq7ctY2yVNoBVBlVjKcTS7/3BTpYLZKhZqvXinfe4tMCb6TKIj
 5PrEjeNQSohtxoMtiGDPze0UaGi2tcBpm7TY/CzL6cY5iYAvcEYsBKf8VFvw0QxQjK2Q
 hmovYkYylKwB1VmDu+RtIr5pm4jTjgFPCJ0wQ//F+78ApUagvJslycxLilYAElzbzJcv
 KvaTOg22cw4Gq695AUTQvU9KY+JxYohCU5krQcwBGqwtCjzbmHeoHq/uu6EtCiBZliMF
 pVjoQmnYY7oxTyX9MsrmDDUiI5X0N8jUFKR5IqgQgcHlwtGIoso262Mi7knlJ4IqwF4L
 oYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885318; x=1704490118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUHhbLfoN2d7ET2o9i2N09+Q0gqs/g1wftGgAlf1CKE=;
 b=Zz4txlDWA6Epab1AIuZnOHcbyOZIPk+CQZLCLAE7um7yd4ASr2Ea8qbI+hzGmt5hKo
 AKZWWigIDZpxGtrqdBAkmm+Eq8MAhsuxat3dkh0wLlj0IaxaNkP1XYlk6ahQjQxwqkQn
 p2W7UssS6paZsXgjUhEMHX9jAe0rzm6lqT7FGpoBmZWxGANKG6GplhIhHKpz6FRFN2Bz
 xBNaOeAJnpanTAvQvD8wjgbEEqNwKK1+YAJ5Fwnggi9P1QxGZqfX9VuD4ZUyv451czpC
 FCU2ZgBB7QkV5opLejji3rLHmfnZkjzTMmiduHRtAdBDMGdB977Jm/qi30ME5zBS8ZS/
 VATA==
X-Gm-Message-State: AOJu0YzYhEwl6LnPiB/tx1FU7hJo6p2PFz8qZ/rasEwD+hi+ZtbOdFMT
 YCD71znD8AA+swUO+r5tyz4z+qAwRlRHpu2GQEpBSckowmUyKQ==
X-Google-Smtp-Source: AGHT+IEZvAm10DGFs5QLVYTZyFe+o23JsuOFvHRJz6pPh4XeFbEs5c61q0OZ+mplkfZDA0n2pPjUlQ==
X-Received: by 2002:a05:6a00:1404:b0:6d9:a9e9:28dd with SMTP id
 l4-20020a056a00140400b006d9a9e928ddmr5111526pfu.51.1703885318331; 
 Fri, 29 Dec 2023 13:28:38 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/71] hw/pci: Constify VMState
Date: Sat, 30 Dec 2023 08:23:19 +1100
Message-Id: <20231229212346.147149-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Message-Id: <20231221031652.119827-45-richard.henderson@linaro.org>
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


