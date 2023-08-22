Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800B783AF3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:32:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLrs-0000nO-JW; Tue, 22 Aug 2023 03:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYLrq-0000ay-Fp
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:31:58 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYLrn-0007N8-Pa
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692689515; x=1724225515;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+WloJZkZ3iiiNoVdvttmlvVB5CrWPD6hJYMXzQ7yYVE=;
 b=F7brvbxiKCjy5Ac3+kg+GElV2cj/9SjX4YdEIhXvdbsnokjRDN/vE0ls
 UBR47N0DAWzzXWHfNK7wvV3zOgl0KhuVqWeRbkd88zMMCY9cRq6hFvWkE
 AgoxZJbyt45GpJOWjgfU/rsQE0xYdMRhAj4K4oIIFVSXEFroJNFeL9XUX
 Pl/sZbMZhI/mSznw/YHtpFqt7L4BiD0G1u4Bxv3AFE9x/BDTcHxCK83r7
 VOXxkuhBRhC+MIQHQD3UsVTGA+Fd4U4RkHtcPw6WTMRHAR5ft5VnihGZY
 0hAwgWuthCgP3yLhIkMf0mF89oBkWglCfqfh9ND0d5QS1C/Yf/Ex9ZnvA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371234256"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="371234256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="879832962"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:31:52 -0700
Message-ID: <226923bc-755c-f4db-a381-f00088c6614e@intel.com>
Date: Tue, 22 Aug 2023 15:31:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 06/58] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-7-xiaoyao.li@intel.com> <ZOMkYvm9vsQs8sas@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOMkYvm9vsQs8sas@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.374,
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

On 8/21/2023 4:46 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 18, 2023 at 05:49:49AM -0400, Xiaoyao Li wrote:
>> KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
>> IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
>> TDX context. It will be used to validate user's setting later.
>>
>> Since there is no interface reporting how many cpuid configs contains in
>> KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
>> and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
>>
>> Besides, introduce the interfaces to invoke TDX "ioctls" at different
>> scope (KVM, VM and VCPU) in preparation.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> changes from v1:
>>    - Make the error message more clear;
>>
>> changes from RFC v4:
>>    - start from nr_cpuid_configs = 6 for the loop;
>>    - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
>> ---
>>   target/i386/kvm/kvm.c      |  2 -
>>   target/i386/kvm/kvm_i386.h |  2 +
>>   target/i386/kvm/tdx.c      | 93 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 95 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index d6b988d6c2d1..ec5c07bffd38 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -1751,8 +1751,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>>   
>>   static Error *invtsc_mig_blocker;
>>   
>> -#define KVM_MAX_CPUID_ENTRIES  100
>> -
>>   static void kvm_init_xsave(CPUX86State *env)
>>   {
>>       if (has_xsave2) {
>> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
>> index ea3a5b174ac0..769eadbba56c 100644
>> --- a/target/i386/kvm/kvm_i386.h
>> +++ b/target/i386/kvm/kvm_i386.h
>> @@ -13,6 +13,8 @@
>>   
>>   #include "sysemu/kvm.h"
>>   
>> +#define KVM_MAX_CPUID_ENTRIES  100
>> +
>>   #define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
>>   
>>   #ifdef CONFIG_KVM
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 77e33ae01147..255c47a2a553 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -12,14 +12,107 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>> +#include "sysemu/kvm.h"
>>   
>>   #include "hw/i386/x86.h"
>> +#include "kvm_i386.h"
>>   #include "tdx.h"
>>   
>> +static struct kvm_tdx_capabilities *tdx_caps;
>> +
>> +enum tdx_ioctl_level{
>> +    TDX_PLATFORM_IOCTL,
>> +    TDX_VM_IOCTL,
>> +    TDX_VCPU_IOCTL,
>> +};
>> +
>> +static int __tdx_ioctl(void *state, enum tdx_ioctl_level level, int cmd_id,
>> +                        __u32 flags, void *data)
> 
> Names with an initial double underscore are reserved for us by the
> platform implementation, so shouldn't be used in userspace app
> code.

How about tdx_ioctl_internal() ?

>> +{
>> +    struct kvm_tdx_cmd tdx_cmd;
>> +    int r;
>> +
>> +    memset(&tdx_cmd, 0x0, sizeof(tdx_cmd));
>> +
>> +    tdx_cmd.id = cmd_id;
>> +    tdx_cmd.flags = flags;
>> +    tdx_cmd.data = (__u64)(unsigned long)data;
>> +
>> +    switch (level) {
>> +    case TDX_PLATFORM_IOCTL:
>> +        r = kvm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
>> +        break;
>> +    case TDX_VM_IOCTL:
>> +        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
>> +        break;
>> +    case TDX_VCPU_IOCTL:
>> +        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
>> +        break;
>> +    default:
>> +        error_report("Invalid tdx_ioctl_level %d", level);
>> +        exit(1);
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +static inline int tdx_platform_ioctl(int cmd_id, __u32 flags, void *data)
>> +{
>> +    return __tdx_ioctl(NULL, TDX_PLATFORM_IOCTL, cmd_id, flags, data);
>> +}
>> +
>> +static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data)
>> +{
>> +    return __tdx_ioctl(NULL, TDX_VM_IOCTL, cmd_id, flags, data);
>> +}
>> +
>> +static inline int tdx_vcpu_ioctl(void *vcpu_fd, int cmd_id, __u32 flags,
>> +                                 void *data)
>> +{
>> +    return  __tdx_ioctl(vcpu_fd, TDX_VCPU_IOCTL, cmd_id, flags, data);
>> +}
>> +
>> +static void get_tdx_capabilities(void)
> 
> Pass in 'Error **errp'

OK. Will do it and all the following.

Thanks!

>> +{
>> +    struct kvm_tdx_capabilities *caps;
>> +    /* 1st generation of TDX reports 6 cpuid configs */
>> +    int nr_cpuid_configs = 6;
>> +    int r, size;
> 
> It is preferrable to use  'size_t' for memory allocation sizes.
> 
>> +
>> +    do {
>> +        size = sizeof(struct kvm_tdx_capabilities) +
>> +               nr_cpuid_configs * sizeof(struct kvm_tdx_cpuid_config);
>> +        caps = g_malloc0(size);
>> +        caps->nr_cpuid_configs = nr_cpuid_configs;
>> +
>> +        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps);
>> +        if (r == -E2BIG) {
>> +            g_free(caps);
>> +            nr_cpuid_configs *= 2;
>> +            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
>> +                error_report("KVM TDX seems broken that number of CPUID entries in kvm_tdx_capabilities exceeds limit");
> 
> Include the limit in the error message, so if we ever need to change
> the limit, it'll be clear what limit the QEMU version was built with.
> 
> Also use error_setg(errp, ...);
> 
>> +                exit(1);
> 
> Return -1
> 
>> +            }
>> +        } else if (r < 0) {
>> +            g_free(caps);
>> +            error_report("KVM_TDX_CAPABILITIES failed: %s", strerror(-r));
> 
> Use error_setg_errno(errp, ...) instead of calling strerror yourself;
> 
>> +            exit(1);
> 
> Return -1
> 
>> +        }
>> +    }
>> +    while (r == -E2BIG);
>> +
>> +    tdx_caps = caps;
> 
> Return 0
> 
>> +}
>> +
>>   int tdx_kvm_init(MachineState *ms, Error **errp)
>>   {
>> +    if (!tdx_caps) {
>> +        get_tdx_capabilities();
> 
> Pass 'errp' into this method, and check return value for failure
> 
>> +    }
>> +
>>       return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


