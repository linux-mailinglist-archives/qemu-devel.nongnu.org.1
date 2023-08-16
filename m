Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E877DBA4
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWBW9-0007QJ-7B; Wed, 16 Aug 2023 04:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBW1-0007PD-0W
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:29 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qWBVx-0008Lc-8r
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692173065; x=1723709065;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RWbz1aXqtIYyEx4ZdEZO0Tb6javbBNl0nJJq1PsRcSY=;
 b=ZU3PHhgowO0d9M5MYyWo5MP12GemvZiPPir45fsZFf8lzHfCMdAN2R6k
 szkUCtaFaNjp4OVhe0qksXAJ1cuT/TDDdcvLu/+GuTf6d9ZKfa8MhJHtv
 HaXDMGkawNUmX3jZP6WOIjL5585hgdteY1re5woXSo9yLVFwkCjrXldaG
 FUck1INYydYYJAGgVk04D48wai9hzdJpbUi49LSDgax7dgIdou13Lf/Wf
 TN2dSmIoahKDHGW/J96ph6rljAxx+kMvxQIRvd2Adrz/M6neutFwgI8YD
 XWit9HmRCrMryDqx9uYIDcQP6UE1SVCkSP93pFbtcxpOo6RipLIma+CGj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403450834"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="403450834"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 01:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711035457"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; d="scan'208";a="711035457"
Received: from pc.sh.intel.com ([10.238.200.75])
 by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 01:04:20 -0700
From: Qian Wen <qian.wen@intel.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, babu.moger@amd.com,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH v3 1/2] target/i386: Avoid cpu number overflow in legacy
 topology
Date: Wed, 16 Aug 2023 16:06:57 +0800
Message-Id: <20230816080658.3562730-2-qian.wen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816080658.3562730-1-qian.wen@intel.com>
References: <20230816080658.3562730-1-qian.wen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
apic_id, 2) bits [23:16] get truncated.

Specifically, if launching the VM with -smp 256, the value written to
EBX[23:16] is 0 because of data overflow. If the guest only supports
legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
the return of the kernel invoking cpu_smt_allowed() is false and APs
(application processors) will fail to bring up. Then only CPU 0 is online,
and others are offline.

For example, launch VM via:
qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
    -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
    -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
    -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic

The guest shows:
    CPU(s):               256
    On-line CPU(s) list:  0
    Off-line CPU(s) list: 1-255

To avoid this issue caused by overflow, limit the max value written to
EBX[23:16] to 255 as the HW does.

Signed-off-by: Qian Wen <qian.wen@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..5c008b9d7e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    uint32_t threads_per_socket;
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
@@ -6049,8 +6050,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
-        if (cs->nr_cores * cs->nr_threads > 1) {
-            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
+        threads_per_socket = cs->nr_cores * cs->nr_threads;
+        if (threads_per_socket > 1) {
+            *ebx |= MIN(threads_per_socket, 255) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.25.1


