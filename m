Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA8868D43
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Feb 2024 11:20:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuZ3-0005AK-Bj; Tue, 27 Feb 2024 05:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuZ1-0004wv-0a
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:19:55 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1reuYz-00036Z-BC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709029193; x=1740565193;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JmFuea6YEZYtRR9sXzEGMQAAFtD5BRLPf0ozY0WPMXk=;
 b=Dwroq3SA0eUN+Ume7lZ0t8sT4DISPKzPv8NnViaKEdk1TUcms31FX2CJ
 vrlbRE8lYN6fG5wXIqHQmh18eX71TJSObHzbmoPLGgiRd49K8+UYI8wuS
 jKpQoIz0YfrMFBaP737NJBp6XEYBI5X/F8Egf8q1C2qgBy4Z+qUfmN8uk
 JKDXKK3E5Z4rHT0xMXJSYOaWYrqSUnKw/bGKR42RKIQJhtm+mVNWBzp6t
 QPz7UPpzM2+GzyrveZu08SdwXaueaySlsIscD5qQ1bGn5HOrk7moW4I4L
 nuY5lLVvXQKO2pqx1dI2Vbae8jn3MhwRLQvGf2SLTD4LVUJ0dxew6IITE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6310351"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6310351"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 02:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6954903"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 27 Feb 2024 02:19:48 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v9 12/21] i386: Introduce module level cpu topology to
 CPUX86State
Date: Tue, 27 Feb 2024 18:32:22 +0800
Message-Id: <20240227103231.1556302-13-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Intel CPUs implement module level on hybrid client products (e.g.,
ADL-N, MTL, etc) and E-core server products.

A module contains a set of cores that share certain resources (in
current products, the resource usually includes L2 cache, as well as
module scoped features and MSRs).

Module level support is the prerequisite for L2 cache topology on
module level. With module level, we can implement the Guest's CPU
topology and future cache topology to be consistent with the Host's on
Intel hybrid client/E-core server platforms.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * Mapped x86 module to smp module instead of cluster.
 * Re-wrote the commit message to explain the reason why we needs module
   level.
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v1:
 * The background of the introduction of the "cluster" parameter and its
   exact meaning were revised according to Yanan's explanation. (Yanan)
---
 hw/i386/x86.c     | 5 +++++
 target/i386/cpu.c | 1 +
 target/i386/cpu.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 1e4ff7188f6a..4f91538aaf5d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -313,6 +313,11 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
+    if (ms->smp.modules > 1) {
+        env->nr_modules = ms->smp.modules;
+        /* TODO: Expose module level in CPUID[0x1F]. */
+    }
+
     if (ms->smp.dies > 1) {
         env->nr_dies = ms->smp.dies;
         set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0f171c6a465..d2b9298faf14 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7712,6 +7712,7 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
+    env->nr_modules = 1;
     env->nr_dies = 1;
 
     /* SMT, core and package levels are set by default. */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4a55fef1feea..375d63d05ed2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1899,6 +1899,9 @@ typedef struct CPUArchState {
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
 
+    /* Number of modules within one die. */
+    unsigned nr_modules;
+
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
 } CPUX86State;
-- 
2.34.1


