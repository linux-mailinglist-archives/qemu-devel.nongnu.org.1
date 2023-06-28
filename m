Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49F97415F0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWq-0002xV-Fn; Wed, 28 Jun 2023 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWX-0002sL-Is
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWU-0001sF-OI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:04 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso5645498f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967760; x=1690559760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MX8QOwqONfHUQLKS9Qunoa6fAfFNWAxptRihaW822Q=;
 b=X+RzFZp0AySxCWChiY0PdV10rt9JwY2WfS6kLEzpNhTs1SIYbv4hPHYas9MSTOLfNa
 dFVwV5m8aU0liGHatKXEE/DHvEw8DmGpLhjYizW8hbtw0Avn3eG4un/8Zs82F81+jAZw
 560cK9u1l0g4O2+HyRgOzy5uN5eZTKwC5gzcfksFjkIj/Lki3pTvuTo6qfj52f6+Z619
 l41lYRBrm5dV/Xe+/gbGcaxrI1IoSm9h+Mg8S41AeBfTZydZvRxoPX4+FshSb9gbl7MR
 8svmzBR7CFeX6Fu9TTDpQa1WY0RqqXGc/Z4T2Tvscno62DxbzzVqG1aPuhJ9Subopg5+
 RktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967760; x=1690559760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MX8QOwqONfHUQLKS9Qunoa6fAfFNWAxptRihaW822Q=;
 b=cNUhu9pG3PVtREm5o2k06l2UPVvYomqA4L9bcXAdSdnBoRJIxyy9lWW5ooV2e3Gghs
 pHJ6NPzgdwMiGZDpx0fi0AfRwwZSwrfaSua75I7gpn/vljK/HacB7x18tvvqagBm5Y8A
 NLX/ncGuvg8ipYFSbRLLPKraXLXMMz7s7CkvgA1y+PDEb15pYDIL6XSuybig0B+5s0Fm
 5ZN5DQyw5C+YQ3bXcthAvqP6ejb3nE4loLUKaIJIYpYpV4HV68zy+deikdg1D22P5TC9
 +KLo/ISE+iB+9iEk9IefgZGvkwz+BcKJWa1dPck5DnTKAGjDSijOp/dWIJoLcG64ggcz
 7X9w==
X-Gm-Message-State: AC+VfDzAWbpdUPAVhq0jAlLLyjJRShf502+lfJiS1Qi2MtzkvQopFLwK
 hsMZjjhjsfT7Kd/dTIaPwUAfkKcKlWZausahZ/g=
X-Google-Smtp-Source: ACHHUZ6exOlk7I8UEEDuQk8ub1i5b5Nu2FBjOKZJxI4cXZKCzNmZ9wdIiPLDApe1W3kcAj+wf6mzhw==
X-Received: by 2002:a05:6000:1d0:b0:313:f399:6cea with SMTP id
 t16-20020a05600001d000b00313f3996ceamr7563573wrx.4.1687967760443; 
 Wed, 28 Jun 2023 08:56:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a5d6dc1000000b00304adbeeabbsm13625219wrz.99.2023.06.28.08.55.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:56:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/30] exec/memory: Add symbolic value for memory listener
 priority for accel
Date: Wed, 28 Jun 2023 17:53:11 +0200
Message-Id: <20230628155313.71594-29-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add MEMORY_LISTNER_PRIORITY_ACCEL for the symbolic value for the memory
listener to replace the hard-coded value 10 for accel.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <feebe423becc6e2aa375f59f6abce9a85bc15abb.1687279702.git.isaku.yamahata@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h       | 2 ++
 accel/hvf/hvf-accel-ops.c   | 2 +-
 accel/kvm/kvm-all.c         | 2 +-
 hw/arm/xen_arm.c            | 2 +-
 hw/i386/xen/xen-hvm.c       | 2 +-
 hw/xen/xen-hvm-common.c     | 2 +-
 hw/xen/xen_pt.c             | 4 ++--
 target/i386/hax/hax-mem.c   | 2 +-
 target/i386/nvmm/nvmm-all.c | 2 +-
 target/i386/whpx/whpx-all.c | 2 +-
 10 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 47c2e0221c..6d95d59175 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -811,6 +811,8 @@ struct IOMMUMemoryRegion {
 #define IOMMU_NOTIFIER_FOREACH(n, mr) \
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
+#define MEMORY_LISTENER_PRIORITY_ACCEL          10
+
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
  *
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 7db9d3099e..a44cf1c144 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -304,7 +304,7 @@ static void hvf_region_del(MemoryListener *listener,
 
 static MemoryListener hvf_memory_listener = {
     .name = "hvf",
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
     .region_add = hvf_region_add,
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9aa898db14..964f61feee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1777,7 +1777,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
     kml->listener.commit = kvm_region_commit;
     kml->listener.log_start = kvm_log_start;
     kml->listener.log_stop = kvm_log_stop;
-    kml->listener.priority = 10;
+    kml->listener.priority = MEMORY_LISTENER_PRIORITY_ACCEL;
     kml->listener.name = name;
 
     if (s->kvm_dirty_ring_size) {
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 19b1cb81ad..044093fec7 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -45,7 +45,7 @@ static MemoryListener xen_memory_listener = {
     .log_sync = NULL,
     .log_global_start = NULL,
     .log_global_stop = NULL,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 struct XenArmState {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 5dc5e80535..3da5a2b23f 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -467,7 +467,7 @@ static MemoryListener xen_memory_listener = {
     .log_sync = xen_log_sync,
     .log_global_start = xen_log_global_start,
     .log_global_stop = xen_log_global_stop,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 42339c96bd..886c3ee944 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -155,7 +155,7 @@ MemoryListener xen_io_listener = {
     .name = "xen-io",
     .region_add = xen_io_add,
     .region_del = xen_io_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 DeviceListener xen_device_listener = {
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index a540149639..36e6f93c37 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -691,14 +691,14 @@ static const MemoryListener xen_pt_memory_listener = {
     .name = "xen-pt-mem",
     .region_add = xen_pt_region_add,
     .region_del = xen_pt_region_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static const MemoryListener xen_pt_io_listener = {
     .name = "xen-pt-io",
     .region_add = xen_pt_io_region_add,
     .region_del = xen_pt_io_region_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 /* destroy. */
diff --git a/target/i386/hax/hax-mem.c b/target/i386/hax/hax-mem.c
index 05dbe8cce3..bb5ffbc9ac 100644
--- a/target/i386/hax/hax-mem.c
+++ b/target/i386/hax/hax-mem.c
@@ -291,7 +291,7 @@ static MemoryListener hax_memory_listener = {
     .region_add = hax_region_add,
     .region_del = hax_region_del,
     .log_sync = hax_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 72a3a9e3ae..066a173d26 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1128,7 +1128,7 @@ static MemoryListener nvmm_memory_listener = {
     .region_add = nvmm_region_add,
     .region_del = nvmm_region_del,
     .log_sync = nvmm_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 57580ca383..3de0dc1d46 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2412,7 +2412,7 @@ static MemoryListener whpx_memory_listener = {
     .region_add = whpx_region_add,
     .region_del = whpx_region_del,
     .log_sync = whpx_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void whpx_memory_init(void)
-- 
2.38.1


