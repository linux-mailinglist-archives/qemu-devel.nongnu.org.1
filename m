Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD49BFF31
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Nov 2024 08:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8x2j-0003mR-8q; Thu, 07 Nov 2024 02:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8x2g-0003lv-Dz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:34:58 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8x2c-0004eT-9n
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730964894; x=1762500894;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IOqD1V9wRLxHen71Wykek1sZduHKbJXXD+yIx0K/nkI=;
 b=X3c8rwNKGrmKyEQFZHy5nuvWEHB/nggN0UG8qx28Y/DnFdUMeD3Mqfum
 DlqllB8vXIFB50YclGSn2HYw2pkadqvnczZb3VctwJWnFtIFYnBPlTCwq
 EQ+rs+4A0DjBL0p1/c8edKeNZkTA0v520BM4L+eDSoz+sHX8tSLO/nUPz
 g5K+sTCNlKMjhuEa6MzlhK5uChc5KivJUdQQYSFfU0spXEb5grzlA38JF
 13S2wMdvEvSSZ4Lmuk0mVw015XNdtENHCMLmBTJ/e3tdmEwSQtCtiWvVg
 0fQSSGSr6ixyLO+K4bjsTasoXlkX6Yc8H/nSUg9kCJq7xr54el1AocskU Q==;
X-CSE-ConnectionGUID: JJXH9+VkRcGQdzwKVbmVCQ==
X-CSE-MsgGUID: 3M9o7PDJTzawwCKO4st1xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="48311563"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="48311563"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 23:34:50 -0800
X-CSE-ConnectionGUID: 5c+QaFilT+iM3PDdzWyeoA==
X-CSE-MsgGUID: TWqSbT6hS7qTLYATld285w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="85761361"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2024 23:34:46 -0800
Date: Thu, 7 Nov 2024 15:52:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru,
 dapeng1.mi@linux.intel.com, zide.chen@intel.com
Subject: Re: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
 KVM_PMU_CAP_DISABLE
Message-ID: <ZyxxygVaufOntpZJ@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-3-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104094119.4131-3-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

(+Dapang & Zide)

Hi Dongli,

On Mon, Nov 04, 2024 at 01:40:17AM -0800, Dongli Zhang wrote:
> Date: Mon,  4 Nov 2024 01:40:17 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH 2/7] target/i386/kvm: introduce 'pmu-cap-disabled' to set
>  KVM_PMU_CAP_DISABLE
> X-Mailer: git-send-email 2.43.5
> 
> The AMD PMU virtualization is not disabled when configuring
> "-cpu host,-pmu" in the QEMU command line on an AMD server. Neither
> "-cpu host,-pmu" nor "-cpu EPYC" effectively disables AMD PMU
> virtualization in such an environment.
> 
> As a result, VM logs typically show:
> 
> [    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> 
> whereas the expected logs should be:
> 
> [    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
> [    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled
> 
> This discrepancy occurs because AMD PMU does not use CPUID to determine
> whether PMU virtualization is supported.

Intel platform doesn't have this issue since Linux kernel fails to check
the CPU family & model when "-cpu *,-pmu" option clears PMU version.

The difference between Intel and AMD platforms, however, is that it seems
Intel hardly ever reaches the ��...due virtualization�� message, but
instead reports an error because it recognizes a mismatched family/model.

This may be a drawback of the PMU driver's print message, but the result
is the same, it prevents the PMU driver from enabling.

So, please mention that KVM_PMU_CAP_DISABLE doesn't change the PMU
behavior on Intel platform because current "pmu" property works as
expected.

> To address this, we introduce a new property, 'pmu-cap-disabled', for KVM
> acceleration. This property sets KVM_PMU_CAP_DISABLE if
> KVM_CAP_PMU_CAPABILITY is supported. Note that this feature currently
> supports only x86 hosts, as KVM_CAP_PMU_CAPABILITY is used exclusively for
> x86 systems.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Another previous solution to re-use '-cpu host,-pmu':
> https://lore.kernel.org/all/20221119122901.2469-1-dongli.zhang@oracle.com/

IMO, I prefer the previous version. This VM-level KVM property is
difficult to integrate with the existing CPU properties. Pls refer later
comments for reasons.

>  accel/kvm/kvm-all.c        |  1 +
>  include/sysemu/kvm_int.h   |  1 +
>  qemu-options.hx            |  9 ++++++-
>  target/i386/cpu.c          |  2 +-
>  target/i386/kvm/kvm.c      | 52 ++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/kvm_i386.h |  2 ++
>  6 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 801cff16a5..8b5ba45cf7 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3933,6 +3933,7 @@ static void kvm_accel_instance_init(Object *obj)
>      s->xen_evtchn_max_pirq = 256;
>      s->device = NULL;
>      s->msr_energy.enable = false;
> +    s->pmu_cap_disabled = false;
>  }

The CPU property "pmu" also defaults to "false"...but:

 * max CPU would override this and try to enable PMU by default in
   max_x86_cpu_initfn().

 * Other named CPU models keep the default setting to avoid affecting
   the migration.

The pmu_cap_disabled and ��pmu�� property look unbound and unassociated,
so this can cause the conflict when they are not synchronized. For
example,

-cpu host -accel kvm,pmu-cap-disabled=on

The above options will fail to launch a VM (on Intel platform).

Ideally, the ��pmu�� property and pmu-cap-disabled should be bound to each
other and be consistent. But it's not easy because:
 - There is no proper way to have pmu_cap_disabled set different default
   values (e.g., "false" for max CPU and "true" for named CPU models)
   based on different CPU models.
 - And, no proper place to check the consistency of pmu_cap_disabled and
   enable_pmu.

Therefore, I prefer your previous approach, to reuse current CPU "pmu"
property.

Further, considering that this is currently the only case that needs to
to set the VM level's capability in the CPU context, there is no need to
introduce a new kvm interface (in your previous patch), which can instead
be set in kvm_cpu_realizefn(), like:


diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 99d1941cf51c..05e9c9a1a0cf 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -42,6 +42,8 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
+    KVMState *s = kvm_state;
+    static bool first = true;
     bool ret;

     /*
@@ -63,6 +65,29 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *   check/update ucode_rev, phys_bits, guest_phys_bits, mwait
      *   cpu_common_realizefn() (via xcc->parent_realize)
      */
+
+    if (first) {
+        first = false;
+
+        /*
+         * Since Linux v5.18, KVM provides a VM-level capability to easily
+         * disable PMUs; however, QEMU has been providing PMU property per
+         * CPU since v1.6. In order to accommodate both, have to configure
+         * the VM-level capability here.
+         */
+        if (!cpu->enable_pmu &&
+            kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY)) {
+            int r = kvm_vm_enable_cap(s, KVM_CAP_PMU_CAPABILITY, 0,
+                                      KVM_PMU_CAP_DISABLE);
+
+            if (r < 0) {
+                error_setg(errp, "kvm: Failed to disable pmu cap: %s",
+                           strerror(-r));
+                return false;
+            }
+        }
+    }
+
     if (cpu->max_features) {
         if (enable_cpu_pm) {
             if (kvm_has_waitpkg()) {
---

In addition, if PMU is disabled, why not mask the perf related bits in
8000_0001_ECX? :)

Regards,
Zhao


