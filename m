Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C19802D22
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA4K8-00083h-Am; Mon, 04 Dec 2023 03:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA4Js-00083Q-7j
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:28:49 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA4Jp-000537-Es
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701678525; x=1733214525;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZKx6aOAxCYxX3nIGvol2ORfDeTABYuzt1dyIIWAXVOE=;
 b=CQwlmL8glUxFLn4WrR1xNl5qZPNMTHxZIuKo/6A4Ih3eyypRcPG0S1U8
 W6Pmx3yXix7/JX6KdHB+VpPMZLMU/R6qq8Tn0xiEtF7vw3CQjPosgRzQ1
 TBef4kqZ1jG3QaTix9YVGwXJcRJBHnwdA4FQzlc9ZsNsL6RO/z07bJuuh
 BcKh+hPyxpqcPIBwGiF23inacYRJAIet37dvqDGt7plZhiCbKsGF0+aQH
 tMVYx3dnYxkUipOvKKiphzZvIx9lVAPsBXftTOXYzWaLNp1pZbx5LR/LW
 6zG9Zt6UHgMKTxseRnUb+m8zjgQBf3VsOAJXU5c5yNcNvknKxotqbsiRk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="743945"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="743945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 00:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017759073"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="1017759073"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 00:28:35 -0800
Message-ID: <489b0ea2-f698-4bce-9b80-1ff516407934@intel.com>
Date: Mon, 4 Dec 2023 16:28:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/70] i386/tdx: Initialize TDX before creating TD vcpus
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-27-xiaoyao.li@intel.com>
 <ZVSk_-m-AAK7dYZ1@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZVSk_-m-AAK7dYZ1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/15/2023 7:01 PM, Daniel P. Berrangé wrote:
> On Wed, Nov 15, 2023 at 02:14:35AM -0500, Xiaoyao Li wrote:
>> Invoke KVM_TDX_INIT in kvm_arch_pre_create_vcpu() that KVM_TDX_INIT
>> configures global TD configurations, e.g. the canonical CPUID config,
>> and must be executed prior to creating vCPUs.
>>
>> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
>>
>> Note, this doesn't address the fact that QEMU may change the CPUID
>> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
>> provide a stable CPUID config prior to kvm_arch_init().
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> Changes in v3:
>> - Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
>> ---
>>   accel/kvm/kvm-all.c        |  9 +++++++-
>>   target/i386/kvm/kvm.c      |  9 ++++++++
>>   target/i386/kvm/tdx-stub.c |  5 +++++
>>   target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h      |  4 ++++
>>   5 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 6b5f4d62f961..a92fff471b58 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -441,8 +441,15 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   
>>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>   
>> +    /*
>> +     * tdx_pre_create_vcpu() may call cpu_x86_cpuid(). It in turn may call
>> +     * kvm_vm_ioctl(). Set cpu->kvm_state in advance to avoid NULL pointer
>> +     * dereference.
>> +     */
>> +    cpu->kvm_state = s;
>>       ret = kvm_arch_pre_create_vcpu(cpu, errp);
>>       if (ret < 0) {
>> +        cpu->kvm_state = NULL;
>>           goto err;
>>       }
>>   
>> @@ -450,11 +457,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>       if (ret < 0) {
>>           error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
>>                            kvm_arch_vcpu_id(cpu));
>> +        cpu->kvm_state = NULL;
>>           goto err;
>>       }
>>   
>>       cpu->kvm_fd = ret;
>> -    cpu->kvm_state = s;
>>       cpu->vcpu_dirty = true;
>>       cpu->dirty_pages = 0;
>>       cpu->throttle_us_per_full = 0;
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index dafe4d262977..fc840653ceb6 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2268,6 +2268,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       return r;
>>   }
>>   
>> +int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    if (is_tdx_vm()) {
>> +        return tdx_pre_create_vcpu(cpu, errp);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int kvm_arch_destroy_vcpu(CPUState *cs)
>>   {
>>       X86CPU *cpu = X86_CPU(cs);
>> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
>> index 1d866d5496bf..3877d432a397 100644
>> --- a/target/i386/kvm/tdx-stub.c
>> +++ b/target/i386/kvm/tdx-stub.c
>> @@ -6,3 +6,8 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
>>   {
>>       return -EINVAL;
>>   }
>> +
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    return -EINVAL;
>> +}
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index 1f5d8117d1a9..122a37c93de3 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -467,6 +467,49 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
>>       return 0;
>>   }
>>   
>> +int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>> +{
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    X86CPU *x86cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86cpu->env;
>> +    struct kvm_tdx_init_vm *init_vm;
> 
> Mark this as auto-free to avoid the g_free() requirement
> 
>    g_autofree  struct kvm_tdx_init_vm *init_vm = NULL;
> 
>> +    int r = 0;
>> +
>> +    qemu_mutex_lock(&tdx_guest->lock);
> 
>     QEMU_LOCK_GUARD(&tdx_guest->lock);
> 
> to eliminate the mutex_unlock requirement, thus eliminating all
> 'goto' jumps and label targets, in favour of a plain 'return -1'
> everywhere.
> 

Learned!

thanks!


