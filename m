Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B6A79186
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 16:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzzT5-0000iK-EM; Wed, 02 Apr 2025 10:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzzSZ-0000dn-6b
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:53:00 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzzSV-0007Fv-PV
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743605572; x=1775141572;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K0o1JTiEWaixuWj9DI5lvZfg6bRSR7DGpeT+4zB3n88=;
 b=Nb0etvZIpcmR1gOZtLEjRdDvHJWqPRcHXAPJj8xTD1P2i0bR7Rp2i7MP
 gkaeEPTKpvtQmoPdRnfpNGB5DF6uP3XI+4l4lcfXM3QhCRYBP6AH1lOoX
 jiNqz8Yl3Vtm4MrF2ISTI50/+u4h7He442KY4Y6iSxsVXxsOSyNEGkJx2
 A5JaWSyumMbcMUaudzItg7fXIPQilQXvozgkeoGYUPhuyniJOa2q5GdIb
 i2NXxHH5DZCO82pi++CpNYZ50Ip+rdAWaWij+Q4hpwUXNeXYWKcXkK4Ep
 54Cgvx/NW47esGinBKAyCGd6KaL00OHocaAUacopnx8+sNli2S5LEKr3x A==;
X-CSE-ConnectionGUID: f0IRZhVRT4uSqmTO9/Lo2A==
X-CSE-MsgGUID: qrbVQ0SHRGOOVls394C5yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45148934"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="45148934"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 07:52:47 -0700
X-CSE-ConnectionGUID: 8MX3m+afSuC3EHt/CO1X0g==
X-CSE-MsgGUID: rTBbGihjRaCJq/xKNBKH6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="131593880"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 07:52:44 -0700
Message-ID: <b1586891-6446-474e-8950-8dbc9ac6e607@intel.com>
Date: Wed, 2 Apr 2025 22:52:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/55] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-6-xiaoyao.li@intel.com> <Z-0YzauBkAl8pyIP@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0YzauBkAl8pyIP@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/2/2025 7:00 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:15AM -0400, Xiaoyao Li wrote:
>> KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
>> IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
>> TDX context. It will be used to validate user's setting later.
>>
>> Since there is no interface reporting how many cpuid configs contains in
>> KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
>> and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
>>
>> Besides, introduce the interfaces to invoke TDX "ioctls" at VCPU scope
>> in preparation.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v7:
>> - refine and unifiy the error handling; (Daniel)
>>
>> Changes in v6:
>> - Pass CPUState * to tdx_vcpu_ioctl();
>> - update commit message to remove platform scope thing;
>> - dump hw_error when it's non-zero to help debug;
>>
>> Changes in v4:
>> - use {} to initialize struct kvm_tdx_cmd, to avoid memset();
>> - remove tdx_platform_ioctl() because no user;
>>
>> Changes in v3:
>> - rename __tdx_ioctl() to tdx_ioctl_internal()
>> - Pass errp in get_tdx_capabilities();
>>
>> changes in v2:
>>    - Make the error message more clear;
>>
>> changes in v1:
>>    - start from nr_cpuid_configs = 6 for the loop;
>>    - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
>> ---
>>   target/i386/kvm/kvm.c      |   2 -
>>   target/i386/kvm/kvm_i386.h |   2 +
>>   target/i386/kvm/tdx.c      | 107 ++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 108 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 1af4710556ad..b4fa35405fe1 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -1779,8 +1779,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>>   
>>   static Error *invtsc_mig_blocker;
>>   
>> -#define KVM_MAX_CPUID_ENTRIES  100
>> -
>>   static void kvm_init_xsave(CPUX86State *env)
>>   {
>>       if (has_xsave2) {
>> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
>> index 88565e8dbac1..ed1e61fb8ba9 100644
>> --- a/target/i386/kvm/kvm_i386.h
>> +++ b/target/i386/kvm/kvm_i386.h
>> @@ -13,6 +13,8 @@
>>   
>>   #include "system/kvm.h"
>>   
>> +#define KVM_MAX_CPUID_ENTRIES  100
>> +
>>   /* always false if !CONFIG_KVM */
>>   #define kvm_pit_in_kernel() \
>>       (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 4ff94860815d..c67be5e618e2 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -10,17 +10,122 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>>   
>>   #include "hw/i386/x86.h"
>>   #include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +static struct kvm_tdx_capabilities *tdx_caps;
>> +
>> +enum tdx_ioctl_level {
>> +    TDX_VM_IOCTL,
>> +    TDX_VCPU_IOCTL,
>> +};
>> +
>> +static int tdx_ioctl_internal(enum tdx_ioctl_level level, void *state,
>> +                              int cmd_id, __u32 flags, void *data,
>> +                              Error **errp)
>> +{
>> +    struct kvm_tdx_cmd tdx_cmd = {};
>> +    int r;
>> +
>> +    const char *tdx_ioctl_name[] = {
>> +        [KVM_TDX_CAPABILITIES] = "KVM_TDX_CAPABILITIES",
>> +        [KVM_TDX_INIT_VM] = "KVM_TDX_INIT_VM",
>> +        [KVM_TDX_INIT_VCPU] = "KVM_TDX_INIT_VCPU",
>> +        [KVM_TDX_INIT_MEM_REGION] = "KVM_TDX_INIT_MEM_REGION",
>> +        [KVM_TDX_FINALIZE_VM] = "KVM_TDX_FINALIZE_VM",
>> +        [KVM_TDX_GET_CPUID] = "KVM_TDX_GET_CPUID",
>> +    };
>> +
>> +    tdx_cmd.id = cmd_id;
>> +    tdx_cmd.flags = flags;
>> +    tdx_cmd.data = (__u64)(unsigned long)data;
>> +
>> +    switch (level) {
>> +    case TDX_VM_IOCTL:
>> +        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
>> +        break;
>> +    case TDX_VCPU_IOCTL:
>> +        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
>> +        break;
>> +    default:
>> +        error_setg(errp, "Invalid tdx_ioctl_level %d", level);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (r < 0) {
>> +        error_setg_errno(errp, -r, "TDX ioctl %s failed, hw_errors: 0x%llx",
>> +                         tdx_ioctl_name[cmd_id], tdx_cmd.hw_error);
>> +    }
>> +    return r;
>> +}
>> +
>> +static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data,
>> +                               Error **errp)
>> +{
>> +    return tdx_ioctl_internal(TDX_VM_IOCTL, NULL, cmd_id, flags, data, errp);
>> +}
>> +
>> +static inline int tdx_vcpu_ioctl(CPUState *cpu, int cmd_id, __u32 flags,
>> +                                 void *data, Error **errp)
>> +{
>> +    return  tdx_ioctl_internal(TDX_VCPU_IOCTL, cpu, cmd_id, flags, data, errp);
>> +}
>> +
>> +static int get_tdx_capabilities(Error **errp)
>> +{
>> +    struct kvm_tdx_capabilities *caps;
>> +    /* 1st generation of TDX reports 6 cpuid configs */
>> +    int nr_cpuid_configs = 6;
>> +    size_t size;
>> +    int r;
>> +
>> +    do {
>> +        Error *local_err = NULL;
>> +        size = sizeof(struct kvm_tdx_capabilities) +
>> +                      nr_cpuid_configs * sizeof(struct kvm_cpuid_entry2);
>> +        caps = g_malloc0(size);
>> +        caps->cpuid.nent = nr_cpuid_configs;
>> +
>> +        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps, &local_err);
>> +        if (r == -E2BIG) {
>> +            g_free(caps);
>> +            nr_cpuid_configs *= 2;
>> +            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
>> +                error_report("KVM TDX seems broken that number of CPUID entries"
>> +                             " in kvm_tdx_capabilities exceeds limit: %d",
>> +                             KVM_MAX_CPUID_ENTRIES);
>> +                error_propagate(errp, local_err);
>> +                return r;
>> +            }
>> +            error_free(local_err);
> 
> IIRC, you'll need  'local_err = NULL' here, otherwise next time around
> the loop 'local_err' will be pointing to a free'd error object which
> 'error_setg' will think is still valid & won't overwrite.

it's set to NULL at the beginning of the do loop.

(It looks I need to declare Error *local_err outside the do loop.)

>> +        } else if (r < 0) {
>> +            g_free(caps);
>> +            error_propagate(errp, local_err);
>> +            return r;
>> +        }
>> +    } while (r == -E2BIG);
>> +
>> +    tdx_caps = caps;
>> +
>> +    return 0;
>> +}
>> +
> 
> 
> With regards,
> Daniel


