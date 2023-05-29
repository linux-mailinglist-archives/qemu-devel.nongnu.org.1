Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C921B71495E
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bt9-0004o6-4v; Mon, 29 May 2023 08:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3bt0-0004dA-DF
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:06 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3bsy-0006RT-Fd
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685362924; x=1716898924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VAsKzB9xt+K4+lZNomhVmiZFWE3P0c7gY7Dn+zONAc8=;
 b=FVBRVMeTDZTbKReyZ2z4wP+JqdDFUBxr7piMNVP1HI7P+Bs/WUhBV2Gl
 01yfrH8suSUG1TzpN4HpLuhnV7PUV+pWE1MXyQ5WgNlc6snQmV//LN+ju
 hACsEcKcdqOqehXd/qJZY7yw5OiJAZprtxI2wIFrmjIlbkN4Ts+BdocU7
 0FLAB7+Hxwaqiww5tMLzCtPoJAzQXSzXT3jzYLeE9+eHFt60jp33nhUl7
 j46F/lOPvrduFWGzOtkqdZHD5l3JHaSv/dxOkmZE/yOiLisnKwGDY41m6
 36Lj5skSwbd8Lha/q5vr2a1gijy94JICb29puk28yTKa872kerBfXQMPg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344190176"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="344190176"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850388606"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="850388606"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2023 05:21:52 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v2 07/17] i386: Introduce module-level cpu topology to
 CPUX86State
Date: Mon, 29 May 2023 20:30:51 +0800
Message-Id: <20230529123101.411267-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index a88a126123be..4efc390905ff 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -309,6 +309,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = ms->smp.dies;
+    env->nr_modules = ms->smp.clusters;
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b069b43ff999..05a5afd42a81 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7332,6 +7332,7 @@ static void x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
 
     env->nr_dies = 1;
+    env->nr_modules = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 724ffd2b1fc9..fb8f7cb24902 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1872,6 +1872,11 @@ typedef struct CPUArchState {
 
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


