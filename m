Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305287D4B2E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:55:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvD9x-00083J-Rb; Tue, 24 Oct 2023 04:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvD9u-0007zr-GY
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:07 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvD9s-00066T-Gy
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698137585; x=1729673585;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YTf5UmbStsq95d/eUNI8819Ewa9ps5USHyTovvH5EKA=;
 b=JrrF/No6BoVWXzRBX6mWQDzuGH2w8bHX8NBiqHnaVCsXeLgCa2kFw/iU
 SOe/lELVMvO/iUsS4lud9U68fsEl7mW7ycHjilwO9KXbFCUG1HizQqTsk
 gXM65xPBtsy3tmNXtxvUH/6ZDXY8CUx0g08rE/RBKG4f1mjGULOde4cSd
 CXrcRymZbrgp3QdvhyEqjjHWHodkBfZdLeA+OL+Zww7Seij2WPncKJvM3
 fkssyRg6KIUNJ5c6cZPiNso09Ld4u7hJKxv6TLJ7Vm9AIEqxskwdN3tWw
 okoYEIY8HEAZ90GROUb+fJrDcG+FzSm2+nJIf6t/sOs3k0PQAPDTlNwOv w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5638473"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5638473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 01:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793418165"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="793418165"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 24 Oct 2023 01:52:52 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v5 10/20] i386: Introduce module-level cpu topology to
 CPUX86State
Date: Tue, 24 Oct 2023 17:03:13 +0800
Message-Id: <20231024090323.1859210-11-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

smp command has the "clusters" parameter but x86 hasn't supported that
level. "cluster" is a CPU topology level concept above cores, in which
the cores may share some resources (L2 cache or some others like L3
cache tags, depending on the Archs) [1][2]. For x86, the resource shared
by cores at the cluster level is mainly the L2 cache.

However, using cluster to define x86's L2 cache topology will cause the
compatibility problem:

Currently, x86 defaults that the L2 cache is shared in one core, which
actually implies a default setting "cores per L2 cache is 1" and
therefore implicitly defaults to having as many L2 caches as cores.

For example (i386 PC machine):
-smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)

Considering the topology of the L2 cache, this (*) implicitly means "1
core per L2 cache" and "2 L2 caches per die".

If we use cluster to configure L2 cache topology with the new default
setting "clusters per L2 cache is 1", the above semantics will change
to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
cores per L2 cache".

So the same command (*) will cause changes in the L2 cache topology,
further affecting the performance of the virtual machine.

Therefore, x86 should only treat cluster as a cpu topology level and
avoid using it to change L2 cache by default for compatibility.

"cluster" in smp is the CPU topology level which is between "core" and
die.

For x86, the "cluster" in smp is corresponding to the module level [2],
which is above the core level. So use the "module" other than "cluster"
in i386 code.

And please note that x86 already has a cpu topology level also named
"cluster" [3], this level is at the upper level of the package. Here,
the cluster in x86 cpu topology is completely different from the
"clusters" as the smp parameter. After the module level is introduced,
the cluster as the smp parameter will actually refer to the module level
of x86.

[1]: 864c3b5c32f0 ("hw/core/machine: Introduce CPU cluster topology support")
[2]: Yanan's comment about "cluster",
     https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg04051.html
[3]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.

Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v1:
 * The background of the introduction of the "cluster" parameter and its
   exact meaning were revised according to Yanan's explanation. (Yanan)
---
 hw/i386/x86.c     | 1 +
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889bba..24628c1d2f73 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -306,6 +306,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = ms->smp.dies;
+    env->nr_modules = ms->smp.clusters;
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1de18b98ca29..a33d2f83a6a8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7698,6 +7698,7 @@ static void x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
 
     env->nr_dies = 1;
+    env->nr_modules = 1;
 
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e21bb20405af..18577bc0bf6b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1904,6 +1904,11 @@ typedef struct CPUArchState {
 
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
+    /*
+     * Number of modules within this CPU package.
+     * Module level in x86 cpu topology is corresponding to smp.clusters.
+     */
+    unsigned nr_modules;
 } CPUX86State;
 
 struct kvm_msrs;
-- 
2.34.1


