Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10F8B0E8E
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 17:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzefK-0004O8-QT; Wed, 24 Apr 2024 11:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzefG-0004NU-Px
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:36:06 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzefE-0005bD-Qo
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713972965; x=1745508965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8hKAub2DQTIg1zWSIgNLu+p4gDCrNuUGZ6NJQx9fNFw=;
 b=WLD79GKsGkRiQr2Ok/YN0RaRvM+8DHirurK6Ell5qtfbRr6pkzUnv0Up
 8TiraCxCN837NaBJjmMzjExJw/LLZYFHd5UAsGGLeEOQXFGeGxDL0Vtwy
 r0g7ijwxwFj9TrWD3sPy8QBfX8f1kdy0E59O0mpDixOOYe9OkFeJCZM78
 glwdhq6agvjEtRGffXHOCSkKR3TfdYmHbsQTGYfLuKcKHIZUMkBB9OmNq
 PXfhi0Au7nL4UK81uG6FXsa601s9EVtJMDrPAAzHek8Syk/V5myanX1XV
 G2ACCn+ntziCjRE/9m2WUtZwgejmFGA2YM3SQesJbIK2rMc9FzegghtSN A==;
X-CSE-ConnectionGUID: nfWopoL0RvGnor9GXrQV8Q==
X-CSE-MsgGUID: 4s+fYiOdT6KZuqRkHsJHoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12545563"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="12545563"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:36:03 -0700
X-CSE-ConnectionGUID: BaRgLiHvQsic+w5l/Cx44w==
X-CSE-MsgGUID: g3LAKQLVQpiJ8pww8yklHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="25363038"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2024 08:35:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v11 01/21] hw/core/machine: Introduce the module as a CPU
 topology level
Date: Wed, 24 Apr 2024 23:49:09 +0800
Message-Id: <20240424154929.1487382-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In x86, module is the topology level above core, which contains a set
of cores that share certain resources (in current products, the resource
usually includes L2 cache, as well as module scoped features and MSRs).

Though smp.clusters could also share the L2 cache resource [1], there
are following reasons that drive us to introduce the new smp.modules:

  * As the CPU topology abstraction in device tree [2], cluster supports
    nesting (though currently QEMU hasn't support that). In contrast,
    (x86) module does not support nesting.

  * Due to nesting, there is great flexibility in sharing resources
    on cluster, rather than narrowing cluster down to sharing L2 (and
    L3 tags) as the lowest topology level that contains cores.

  * Flexible nesting of cluster allows it to correspond to any level
    between the x86 package and core.

  * In Linux kernel, x86's cluster only represents the L2 cache domain
    but QEMU's smp.clusters is the CPU topology level. Linux kernel will
    also expose module level topology information in sysfs for x86. To
    avoid cluster ambiguity and keep a consistent CPU topology naming
    style with the Linux kernel, we introduce module level for x86.

The module is, in existing hardware practice, the lowest layer that
contains the core, while the cluster is able to have a higher
topological scope than the module due to its nesting.

Therefore, place the module between the cluster and the core:

    drawer/book/socket/die/cluster/module/core/thread

With the above topological hierarchy order, introduce module level
support in MachineState and MachineClass.

[1]: https://lore.kernel.org/qemu-devel/c3d68005-54e0-b8fe-8dc1-5989fe3c7e69@huawei.com/
[2]: https://www.kernel.org/doc/Documentation/devicetree/bindings/cpu/cpu-topology.txt

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
---
Changes since v8:
 * Add the reason of why a new module level is needed in commit message.
   (Markus).
 * Add the description about how Linux kernel supports x86 module level.
   (Daniel)

Changes since v7:
 * New commit to introduce module level in -smp.
---
 hw/core/machine-smp.c | 2 +-
 hw/core/machine.c     | 1 +
 include/hw/boards.h   | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 27864c950766..2e68fcfdfd79 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -266,7 +266,7 @@ void machine_parse_smp_config(MachineState *ms,
 
 unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
 {
-    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+    return ms->smp.cores * ms->smp.modules * ms->smp.clusters * ms->smp.dies;
 }
 
 unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 582c2df37aaf..996664115939 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1157,6 +1157,7 @@ static void machine_initfn(Object *obj)
     ms->smp.sockets = 1;
     ms->smp.dies = 1;
     ms->smp.clusters = 1;
+    ms->smp.modules = 1;
     ms->smp.cores = 1;
     ms->smp.threads = 1;
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 69c1ba45cf94..2fa800f11ae4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -144,6 +144,7 @@ typedef struct {
  *                 provided SMP configuration
  * @books_supported - whether books are supported by the machine
  * @drawers_supported - whether drawers are supported by the machine
+ * @modules_supported - whether modules are supported by the machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -152,6 +153,7 @@ typedef struct {
     bool has_clusters;
     bool books_supported;
     bool drawers_supported;
+    bool modules_supported;
 } SMPCompatProps;
 
 /**
@@ -339,6 +341,7 @@ typedef struct DeviceMemoryState {
  * @sockets: the number of sockets in one book
  * @dies: the number of dies in one socket
  * @clusters: the number of clusters in one die
+ * @modules: the number of modules in one cluster
  * @cores: the number of cores in one cluster
  * @threads: the number of threads in one core
  * @max_cpus: the maximum number of logical processors on the machine
@@ -350,6 +353,7 @@ typedef struct CpuTopology {
     unsigned int sockets;
     unsigned int dies;
     unsigned int clusters;
+    unsigned int modules;
     unsigned int cores;
     unsigned int threads;
     unsigned int max_cpus;
-- 
2.34.1


