Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E868201E6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQH-0000NO-2q; Fri, 29 Dec 2023 16:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPz-0008Qt-KC
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:25 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPu-0000O2-8v
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:21 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9bba6d773so3238145b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885354; x=1704490154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8bYRcHjoz0xLssPgIP2+lQxpAxmoUhsvUahD+2ZYGyY=;
 b=SNagU2gykkr6VE6+tm6U7OqoMaHcWwboylSJ6RBhrqmqKsEQEL21EiGr9nQppKF6ef
 In7uz1cNualFSW77Xs0wvQCBS5u8IaFRta5FVt01BmTGCYCiFLNpRl5gafOHIlQANyCo
 dIuPSeR4/ihkX2pXQNqhXgE/0D6APlvZe+zw5Xh3P77Z5oxy4+0SwmhSZknGVP9kb5pS
 /kvPNIlnDUoXD+HAxCKwKXOLf/Zwxt/htLoYNHAErXBY1ZZzh7swGkx763PzLJZMBG84
 808yfLOmNiu0ORqlwAhOmXquK4IvALjGHVidgjbjYnhy9rwEBsdtHbnMqnBpGr6MEdrg
 EKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885354; x=1704490154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bYRcHjoz0xLssPgIP2+lQxpAxmoUhsvUahD+2ZYGyY=;
 b=iJ85VCgUXX4+iE5HUGMRxTlJ3ejUqpqp/YMC0lRHOXyXjAu6+cD40N7HBmV0rUcL+m
 mPOH8jROMcUgxDU3NIn+RJaIeCH3yVCa8AmbjN3JLLvSn+nZAiCnbe2S60N2bGY45QWr
 sfc8gNWRqOu3fDI+++eDGwV/LAWlRp0okyMyvHpYTodAmdmECF/LLLgW7QF3RNKCYLEp
 ds2AzJVo/nlhunfy4OeZQbycpmG4cb1uJX4K2xhaBbvccr08BYjRTdj0BD2FDJZfyVFI
 zpVUwvDFWGXGOPQ7tuoCaBj9GlduQ+YS9sqRzpqXtUaKN9eCV79GCkR5eC/qG5VCfNDe
 0Ccg==
X-Gm-Message-State: AOJu0Yz8FX4m1kmJNdeGQo6KVNbjBj4pHpWiyn+K6vb9siXcK2NyTPtH
 3MTLuLtRQdYB8M8+1u5jwXdm6td3WRt47FORoatkgbMg/GHT4w==
X-Google-Smtp-Source: AGHT+IFuIspb9vcyyn+7bo0bFhfktSDBtl+A21CN8rJmGbDRxuKj6/RB/xcFZd7/YRJgK1VppeqmqQ==
X-Received: by 2002:a05:6a00:17a4:b0:6d9:ba6f:54ac with SMTP id
 s36-20020a056a0017a400b006d9ba6f54acmr10694547pfg.54.1703885354027; 
 Fri, 29 Dec 2023 13:29:14 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/71] hw/virtio: Constify VMState
Date: Sat, 30 Dec 2023 08:23:35 +1100
Message-Id: <20231229212346.147149-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
Message-Id: <20231221031652.119827-61-richard.henderson@linaro.org>
---
 hw/virtio/vdpa-dev.c       |  2 +-
 hw/virtio/vhost-user-fs.c  |  6 +++---
 hw/virtio/vhost-vsock.c    |  2 +-
 hw/virtio/virtio-balloon.c | 10 +++++-----
 hw/virtio/virtio-crypto.c  |  2 +-
 hw/virtio/virtio-iommu.c   | 12 ++++++------
 hw/virtio/virtio-mem.c     |  8 ++++----
 hw/virtio/virtio-mmio.c    |  8 ++++----
 hw/virtio/virtio-pci.c     |  8 ++++----
 hw/virtio/virtio-rng.c     |  2 +-
 hw/virtio/virtio.c         | 28 ++++++++++++++--------------
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 8774986571..eb9ecea83b 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -344,7 +344,7 @@ static const VMStateDescription vmstate_vhost_vdpa_device = {
     .unmigratable = 1,
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index eb91723855..cca2cd41be 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -373,11 +373,11 @@ static const VMStateDescription vuf_backend_vmstate;
 static const VMStateDescription vuf_vmstate = {
     .name = "vhost-user-fs",
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vuf_backend_vmstate,
         NULL,
     }
@@ -389,7 +389,7 @@ static const VMStateDescription vuf_backend_vmstate = {
     .needed = vuf_is_internal_migration,
     .pre_load = vuf_check_migration_support,
     .pre_save = vuf_check_migration_support,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name = "back-end",
             .info = &(const VMStateInfo) {
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index aa16d584ee..d5ca0b5a10 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -111,7 +111,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
     .version_id = VHOST_VSOCK_SAVEVM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d004cf29d2..486fe3da32 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -817,7 +817,7 @@ static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_balloon_free_page_support,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
         VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
@@ -829,7 +829,7 @@ static const VMStateDescription vmstate_virtio_balloon_page_poison = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_balloon_page_poison_support,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(poison_val, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     }
@@ -840,12 +840,12 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = virtio_balloon_post_load_device,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(num_pages, VirtIOBalloon),
         VMSTATE_UINT32(actual, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_balloon_free_page_hint,
         &vmstate_virtio_balloon_page_poison,
         NULL
@@ -996,7 +996,7 @@ static const VMStateDescription vmstate_virtio_balloon = {
     .name = "virtio-balloon",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 0e2cc8d5a8..fe1313f2ad 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1122,7 +1122,7 @@ static const VMStateDescription vmstate_virtio_crypto = {
     .unmigratable = 1,
     .minimum_version_id = VIRTIO_CRYPTO_VM_VERSION,
     .version_id = VIRTIO_CRYPTO_VM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 9d463efc52..8a4bd933c6 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1399,7 +1399,7 @@ static void virtio_iommu_instance_init(Object *obj)
     .name = "interval",                                \
     .version_id = 1,                                   \
     .minimum_version_id = 1,                           \
-    .fields = (VMStateField[]) {                       \
+    .fields = (const VMStateField[]) {                 \
         VMSTATE_UINT64(low, VirtIOIOMMUInterval),      \
         VMSTATE_UINT64(high, VirtIOIOMMUInterval),     \
         VMSTATE_END_OF_LIST()                          \
@@ -1411,7 +1411,7 @@ static void virtio_iommu_instance_init(Object *obj)
     .name = "mapping",                                \
     .version_id = 1,                                  \
     .minimum_version_id = 1,                          \
-    .fields = (VMStateField[]) {                      \
+    .fields = (const VMStateField[]) {                \
         VMSTATE_UINT64(phys_addr, VirtIOIOMMUMapping),\
         VMSTATE_UINT32(flags, VirtIOIOMMUMapping),    \
         VMSTATE_END_OF_LIST()                         \
@@ -1436,7 +1436,7 @@ static const VMStateDescription vmstate_endpoint = {
     .name = "endpoint",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VirtIOIOMMUEndpoint),
         VMSTATE_END_OF_LIST()
     }
@@ -1447,7 +1447,7 @@ static const VMStateDescription vmstate_domain = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = domain_preload,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VirtIOIOMMUDomain),
         VMSTATE_GTREE_V(mappings, VirtIOIOMMUDomain, 1,
                         vmstate_interval_mapping,
@@ -1499,7 +1499,7 @@ static const VMStateDescription vmstate_virtio_iommu_device = {
     .minimum_version_id = 2,
     .version_id = 2,
     .post_load = iommu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
                                    &vmstate_domain, VirtIOIOMMUDomain),
         VMSTATE_UINT8_V(config.bypass, VirtIOIOMMU, 2),
@@ -1512,7 +1512,7 @@ static const VMStateDescription vmstate_virtio_iommu = {
     .minimum_version_id = 2,
     .priority = MIG_PRI_IOMMU,
     .version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 75ee38aa46..dc4709790f 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1370,7 +1370,7 @@ static const VMStateDescription vmstate_virtio_mem_sanity_checks = {
     .name = "virtio-mem-device/sanity-checks",
     .pre_save = virtio_mem_mig_sanity_checks_pre_save,
     .post_load = virtio_mem_mig_sanity_checks_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(addr, VirtIOMEMMigSanityChecks),
         VMSTATE_UINT64(region_size, VirtIOMEMMigSanityChecks),
         VMSTATE_UINT64(block_size, VirtIOMEMMigSanityChecks),
@@ -1393,7 +1393,7 @@ static const VMStateDescription vmstate_virtio_mem_device = {
     .version_id = 1,
     .priority = MIG_PRI_VIRTIO_MEM,
     .post_load = virtio_mem_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP_TEST(VirtIOMEM, virtio_mem_vmstate_field_exists,
                               VirtIOMEMMigSanityChecks,
                               vmstate_virtio_mem_sanity_checks),
@@ -1423,7 +1423,7 @@ static const VMStateDescription vmstate_virtio_mem_device_early = {
     .version_id = 1,
     .early_setup = true,
     .post_load = virtio_mem_post_load_early,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(VirtIOMEM, VirtIOMEMMigSanityChecks,
                          vmstate_virtio_mem_sanity_checks),
         VMSTATE_UINT64(size, VirtIOMEM),
@@ -1436,7 +1436,7 @@ static const VMStateDescription vmstate_virtio_mem = {
     .name = "virtio-mem",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 22f15e1e02..22f9fbcf5a 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -565,7 +565,7 @@ static const VMStateDescription vmstate_virtio_mmio_queue_state = {
     .name = "virtio_mmio/queue_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(num, VirtIOMMIOQueue),
         VMSTATE_BOOL(enabled, VirtIOMMIOQueue),
         VMSTATE_UINT32_ARRAY(desc, VirtIOMMIOQueue, 2),
@@ -579,7 +579,7 @@ static const VMStateDescription vmstate_virtio_mmio_state_sub = {
     .name = "virtio_mmio/state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(guest_features, VirtIOMMIOProxy, 2),
         VMSTATE_STRUCT_ARRAY(vqs, VirtIOMMIOProxy, VIRTIO_QUEUE_MAX, 0,
                              vmstate_virtio_mmio_queue_state,
@@ -592,10 +592,10 @@ static const VMStateDescription vmstate_virtio_mmio = {
     .name = "virtio_mmio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_mmio_state_sub,
         NULL
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e433879542..1a7039fb0c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -97,7 +97,7 @@ static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
     .name = "virtio_pci/modern_queue_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(num, VirtIOPCIQueue),
         VMSTATE_UNUSED(1), /* enabled was stored as be16 */
         VMSTATE_BOOL(enabled, VirtIOPCIQueue),
@@ -120,7 +120,7 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_pci_modern_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
         VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
@@ -135,10 +135,10 @@ static const VMStateDescription vmstate_virtio_pci = {
     .name = "virtio_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_pci_modern_state_sub,
         NULL
     }
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 7e12fc03bf..f74efffef7 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -242,7 +242,7 @@ static const VMStateDescription vmstate_virtio_rng = {
     .name = "virtio-rng",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3a160f86ed..7549094154 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2594,7 +2594,7 @@ static const VMStateDescription vmstate_virtqueue = {
     .name = "virtqueue_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vring.avail, struct VirtQueue),
         VMSTATE_UINT64(vring.used, struct VirtQueue),
         VMSTATE_END_OF_LIST()
@@ -2605,7 +2605,7 @@ static const VMStateDescription vmstate_packed_virtqueue = {
     .name = "packed_virtqueue_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
         VMSTATE_BOOL(last_avail_wrap_counter, struct VirtQueue),
         VMSTATE_UINT16(used_idx, struct VirtQueue),
@@ -2620,7 +2620,7 @@ static const VMStateDescription vmstate_virtio_virtqueues = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_virtqueue_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
                       VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue),
         VMSTATE_END_OF_LIST()
@@ -2632,7 +2632,7 @@ static const VMStateDescription vmstate_virtio_packed_virtqueues = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_packed_virtqueue_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
                       VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQueue),
         VMSTATE_END_OF_LIST()
@@ -2643,7 +2643,7 @@ static const VMStateDescription vmstate_ringsize = {
     .name = "ringsize_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(vring.num_default, struct VirtQueue),
         VMSTATE_END_OF_LIST()
     }
@@ -2654,7 +2654,7 @@ static const VMStateDescription vmstate_virtio_ringsize = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_ringsize_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
                       VIRTIO_QUEUE_MAX, 0, vmstate_ringsize, VirtQueue),
         VMSTATE_END_OF_LIST()
@@ -2697,7 +2697,7 @@ static const VMStateDescription vmstate_virtio_extra_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_extra_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         {
             .name         = "extra_state",
             .version_id   = 0,
@@ -2716,7 +2716,7 @@ static const VMStateDescription vmstate_virtio_device_endian = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_device_endian_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(device_endian, VirtIODevice),
         VMSTATE_END_OF_LIST()
     }
@@ -2727,7 +2727,7 @@ static const VMStateDescription vmstate_virtio_64bit_features = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_64bit_features_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(guest_features, VirtIODevice),
         VMSTATE_END_OF_LIST()
     }
@@ -2738,7 +2738,7 @@ static const VMStateDescription vmstate_virtio_broken = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_broken_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(broken, VirtIODevice),
         VMSTATE_END_OF_LIST()
     }
@@ -2749,7 +2749,7 @@ static const VMStateDescription vmstate_virtio_started = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_started_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(started, VirtIODevice),
         VMSTATE_END_OF_LIST()
     }
@@ -2760,7 +2760,7 @@ static const VMStateDescription vmstate_virtio_disabled = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_disabled_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(disabled, VirtIODevice),
         VMSTATE_END_OF_LIST()
     }
@@ -2770,10 +2770,10 @@ static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_device_endian,
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
-- 
2.34.1


