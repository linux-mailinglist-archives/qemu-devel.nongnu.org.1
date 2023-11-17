Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CB7EFA1E
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 22:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r46Eo-0004Pb-FH; Fri, 17 Nov 2023 16:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r46El-0004PD-Ep
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:18:51 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r46Eh-0004VB-JZ
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700255927; x=1731791927;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zMIPv8ix5WN4qvG0q4zW/+35uhcmtjjsIBen/HZxkmI=;
 b=EGkvPDsFEbxVE5Q4yoasu3Eh1YmNJW973lkgX8NUjGoakdnidtGEyscX
 VKA+Xhzx4jCkIySVC967PsEpLzzfZiu1j+yt6KBdFENrZk+INr+fwltML
 8xyI+xLmDiM/+0QuYx5IbMspuRtZq22kyNcISJ2g2eHNn0ijkX79NwJsF
 o7Hxr2Sk0Pa6EVnkNOcIAa1FG3tSgKcbE+8goECTTDSxCGPo1mssjLRjs
 YktwK0Sopkh7E0NJgXPphFF0vrQ/AvG/31K1ScJuL1H0OrIf8spEQlNdT
 rIq9hMKO10eaowwwr+uxaPmL6mYPT3YhhUh9BJv4SwwaIREjePQvqVkcS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="457871531"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="457871531"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="831720325"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="831720325"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:18:43 -0800
Date: Fri, 17 Nov 2023 13:18:43 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 18/70] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Message-ID: <20231117211843.GA1648821@ls.amr.corp.intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-19-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-19-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 15, 2023 at 02:14:27AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
> IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
> TDX context. It will be used to validate user's setting later.
> 
> Since there is no interface reporting how many cpuid configs contains in
> KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
> and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
> 
> Besides, introduce the interfaces to invoke TDX "ioctls" at different
> scope (KVM, VM and VCPU) in preparation.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v3:
> - rename __tdx_ioctl() to tdx_ioctl_internal()
> - Pass errp in get_tdx_capabilities();
> 
> changes in v2:
>   - Make the error message more clear;
> 
> changes in v1:
>   - start from nr_cpuid_configs = 6 for the loop;
>   - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
> ---
>  target/i386/kvm/kvm.c      |   2 -
>  target/i386/kvm/kvm_i386.h |   2 +
>  target/i386/kvm/tdx.c      | 102 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 7abcdebb1452..28e60c5ea4a7 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1687,8 +1687,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>  
>  static Error *invtsc_mig_blocker;
>  
> -#define KVM_MAX_CPUID_ENTRIES  100
> -
>  static void kvm_init_xsave(CPUX86State *env)
>  {
>      if (has_xsave2) {
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 55fb25fa8e2e..c3ef46a97a7b 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -13,6 +13,8 @@
>  
>  #include "sysemu/kvm.h"
>  
> +#define KVM_MAX_CPUID_ENTRIES  100
> +
>  #ifdef CONFIG_KVM
>  
>  #define kvm_pit_in_kernel() \
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 621a05beeb4e..cb0040187b27 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -12,17 +12,117 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qom/object_interfaces.h"
> +#include "sysemu/kvm.h"
>  
>  #include "hw/i386/x86.h"
> +#include "kvm_i386.h"
>  #include "tdx.h"
>  
> +static struct kvm_tdx_capabilities *tdx_caps;
> +
> +enum tdx_ioctl_level{
> +    TDX_PLATFORM_IOCTL,
> +    TDX_VM_IOCTL,
> +    TDX_VCPU_IOCTL,
> +};
> +
> +static int tdx_ioctl_internal(void *state, enum tdx_ioctl_level level, int cmd_id,
> +                        __u32 flags, void *data)
> +{
> +    struct kvm_tdx_cmd tdx_cmd;
> +    int r;
> +
> +    memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
> +
> +    tdx_cmd.id = cmd_id;
> +    tdx_cmd.flags = flags;
> +    tdx_cmd.data = (__u64)(unsigned long)data;
> +
> +    switch (level) {
> +    case TDX_PLATFORM_IOCTL:
> +        r = kvm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +        break;
> +    case TDX_VM_IOCTL:
> +        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +        break;
> +    case TDX_VCPU_IOCTL:
> +        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
> +        break;
> +    default:
> +        error_report("Invalid tdx_ioctl_level %d", level);
> +        exit(1);
> +    }
> +
> +    return r;
> +}
> +
> +static inline int tdx_platform_ioctl(int cmd_id, __u32 flags, void *data)
> +{
> +    return tdx_ioctl_internal(NULL, TDX_PLATFORM_IOCTL, cmd_id, flags, data);
> +}
> +
> +static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data)
> +{
> +    return tdx_ioctl_internal(NULL, TDX_VM_IOCTL, cmd_id, flags, data);
> +}
> +
> +static inline int tdx_vcpu_ioctl(void *vcpu_fd, int cmd_id, __u32 flags,
> +                                 void *data)
> +{
> +    return  tdx_ioctl_internal(vcpu_fd, TDX_VCPU_IOCTL, cmd_id, flags, data);
> +}

As all of ioctl variants aren't used yet, we can split out them. An independent
patch to define ioctl functions.


> +
> +static int get_tdx_capabilities(Error **errp)
> +{
> +    struct kvm_tdx_capabilities *caps;
> +    /* 1st generation of TDX reports 6 cpuid configs */
> +    int nr_cpuid_configs = 6;
> +    size_t size;
> +    int r;
> +
> +    do {
> +        size = sizeof(struct kvm_tdx_capabilities) +
> +               nr_cpuid_configs * sizeof(struct kvm_tdx_cpuid_config);
> +        caps = g_malloc0(size);
> +        caps->nr_cpuid_configs = nr_cpuid_configs;
> +
> +        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps);
> +        if (r == -E2BIG) {
> +            g_free(caps);
> +            nr_cpuid_configs *= 2;

g_realloc()?  Maybe a matter of preference.

Other than this, it looks good to me.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

