Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB857E1ABF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg6-0006Z5-LX; Mon, 06 Nov 2023 02:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd5-0000lM-C5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:44 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcs-00020s-Cu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:34 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28035cf6a30so3141767a91.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254141; x=1699858941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tzkT83r4dpa7D2vW92JXn9tw4cAIVw1QFBlJ5yPK5s=;
 b=sD1BQk6VXAUbZ4DUDEaltCCAWE7HpAIP8k+jxXkS/Z3NVA9DTnuOsT7JIsmeYGH+iR
 7oieiehm1S5Bq+D/8DW/DBHgecfPrQCe5zwwvQf8SxgC2h6OEw5OQvVXCCPeijv7qjA3
 5hxvqb/usrmJo0xgaSVFGU3m73kOBkVcMEBp63JDMf1TxRRBFcojKeAsV3dnn1IiWrLA
 chlJ8JB3js2GcTrh5+x/qx1r9SX4B0pkLVk/Hi476FliIO7MTA5LoKO1Epi0HDJDBCad
 1wX4eu/TMVdA1Owcc3M40jcsrV7vWyb+mI7fxWYZZ7NgyakVx4Al7EDRjes1QDjWm1zU
 tdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254141; x=1699858941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tzkT83r4dpa7D2vW92JXn9tw4cAIVw1QFBlJ5yPK5s=;
 b=Q63nmgML55ZTM/Tlrn1WxvqKJi04sZhKdNDGB1Gc5w+dQIlS9MPiLghPbe0k03IrNv
 LMf/kzn6YIYk4OpP2JC9lOxd39A+lBUFCPezXMQ2K00lelAkHf9Rr8CVRlAFWKlRUZmm
 rFiU2gLZ1rwDQmlzLRoi+9ddzngkpIFu7AlNFib3wsnxf7J8ktG1MIqsYMJMkxWRXiAF
 9x4yQxuvzw/4ghksylzykXPJ86zZayjqddtzv83g6nVSJDZAbCIumZiQJlmrv/tX83nQ
 La99fYizA4LLkdIv1gUR9QPNwq+P123ixi23ohTErMHtpvJRuCk1lx2O8yXvWXS81nJX
 QWnQ==
X-Gm-Message-State: AOJu0YxmxZAAKHILQabCwy6+ZJO6KvbsC3DAscaXuZLVaAxpVLfoC3wP
 COp/+oSm+0/9qLcovnsERsVzv9TGZDH6rphqpNA=
X-Google-Smtp-Source: AGHT+IEbPV3L8sqD+uTtxxjYhpVPwd7c+aF9ltLX5/HgfC6cYM7vRigTwxYO/2XzsqMqs2j4EskvbA==
X-Received: by 2002:a17:90b:3ecc:b0:281:8e9:7b86 with SMTP id
 rm12-20020a17090b3ecc00b0028108e97b86mr883359pjb.23.1699254140787; 
 Sun, 05 Nov 2023 23:02:20 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 60/71] hw/virtio: Constify VMState
Date: Sun,  5 Nov 2023 22:58:16 -0800
Message-Id: <20231106065827.543129-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 hw/virtio/vdpa-dev.c       |  2 +-
 hw/virtio/vhost-vsock.c    |  2 +-
 hw/virtio/virtio-balloon.c | 10 +++++-----
 hw/virtio/virtio-crypto.c  |  2 +-
 hw/virtio/virtio-iommu.c   | 12 ++++++------
 hw/virtio/virtio-mem.c     |  8 ++++----
 hw/virtio/virtio-mmio.c    |  8 ++++----
 hw/virtio/virtio-pci.c     |  8 ++++----
 hw/virtio/virtio-rng.c     |  2 +-
 hw/virtio/virtio.c         | 28 ++++++++++++++--------------
 10 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index f22d5d5bc0..e405926de0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -341,7 +341,7 @@ static const VMStateDescription vmstate_vhost_vdpa_device = {
     .unmigratable = 1,
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
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
index be51635895..c887b2a708 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1272,7 +1272,7 @@ static void virtio_iommu_instance_init(Object *obj)
     .name = "interval",                                \
     .version_id = 1,                                   \
     .minimum_version_id = 1,                           \
-    .fields = (VMStateField[]) {                       \
+    .fields = (const VMStateField[]) {                 \
         VMSTATE_UINT64(low, VirtIOIOMMUInterval),      \
         VMSTATE_UINT64(high, VirtIOIOMMUInterval),     \
         VMSTATE_END_OF_LIST()                          \
@@ -1284,7 +1284,7 @@ static void virtio_iommu_instance_init(Object *obj)
     .name = "mapping",                                \
     .version_id = 1,                                  \
     .minimum_version_id = 1,                          \
-    .fields = (VMStateField[]) {                      \
+    .fields = (const VMStateField[]) {                \
         VMSTATE_UINT64(phys_addr, VirtIOIOMMUMapping),\
         VMSTATE_UINT32(flags, VirtIOIOMMUMapping),    \
         VMSTATE_END_OF_LIST()                         \
@@ -1309,7 +1309,7 @@ static const VMStateDescription vmstate_endpoint = {
     .name = "endpoint",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VirtIOIOMMUEndpoint),
         VMSTATE_END_OF_LIST()
     }
@@ -1320,7 +1320,7 @@ static const VMStateDescription vmstate_domain = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = domain_preload,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VirtIOIOMMUDomain),
         VMSTATE_GTREE_V(mappings, VirtIOIOMMUDomain, 1,
                         vmstate_interval_mapping,
@@ -1372,7 +1372,7 @@ static const VMStateDescription vmstate_virtio_iommu_device = {
     .minimum_version_id = 2,
     .version_id = 2,
     .post_load = iommu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
                                    &vmstate_domain, VirtIOIOMMUDomain),
         VMSTATE_UINT8_V(config.bypass, VirtIOIOMMU, 2),
@@ -1385,7 +1385,7 @@ static const VMStateDescription vmstate_virtio_iommu = {
     .minimum_version_id = 2,
     .priority = MIG_PRI_IOMMU,
     .version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a5ea3be414..7ba9aedc54 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1368,7 +1368,7 @@ static const VMStateDescription vmstate_virtio_mem_sanity_checks = {
     .name = "virtio-mem-device/sanity-checks",
     .pre_save = virtio_mem_mig_sanity_checks_pre_save,
     .post_load = virtio_mem_mig_sanity_checks_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(addr, VirtIOMEMMigSanityChecks),
         VMSTATE_UINT64(region_size, VirtIOMEMMigSanityChecks),
         VMSTATE_UINT64(block_size, VirtIOMEMMigSanityChecks),
@@ -1391,7 +1391,7 @@ static const VMStateDescription vmstate_virtio_mem_device = {
     .version_id = 1,
     .priority = MIG_PRI_VIRTIO_MEM,
     .post_load = virtio_mem_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP_TEST(VirtIOMEM, virtio_mem_vmstate_field_exists,
                               VirtIOMEMMigSanityChecks,
                               vmstate_virtio_mem_sanity_checks),
@@ -1421,7 +1421,7 @@ static const VMStateDescription vmstate_virtio_mem_device_early = {
     .version_id = 1,
     .early_setup = true,
     .post_load = virtio_mem_post_load_early,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(VirtIOMEM, VirtIOMEMMigSanityChecks,
                          vmstate_virtio_mem_sanity_checks),
         VMSTATE_UINT64(size, VirtIOMEM),
@@ -1434,7 +1434,7 @@ static const VMStateDescription vmstate_virtio_mem = {
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
index 205dbf24fb..d6eab690a3 100644
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
index e5105571cf..7b8c4912b1 100644
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


