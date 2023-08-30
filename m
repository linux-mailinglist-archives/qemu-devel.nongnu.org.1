Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A378D1D0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 03:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAHi-0003jF-97; Tue, 29 Aug 2023 21:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAHg-0003j3-9L
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:46:16 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qbAHd-0002b7-1n
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 21:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693359973; x=1724895973;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=p4Wy6jh1XftvGcwrqSfMaq2NtDuPyWExhKlq09mPg7E=;
 b=ZbY4jKC0kXvw179EKo5YxqU1IAGnlgYc+YS02+/a0yeTZKy1V5ONMngr
 IlAeZYR4XafHswOZN9cVcrPhOfq47O7szLWvTPZLPOSlYEsPRuMKtpguO
 ySMTgMBbXhoUSJAvPd9BVyorQ0pL+j1Qc85hl+i6thU04x8QnqHdnUhta
 jqlxks0PZinYbCzcAbEtj2DZ/OcB1DNkrB6hpDMnEPwbBQkfZXTQ55f6a
 Nd45Sr4kjTf7Ccr63AW7DWR7nH6LS69eCSsBzi7uZCo1qg4ZxnZSdxabf
 dMPWKUZdW9bnx6SHKh5Um3hjW1eveB96vivxxE9lsY1mSUjrTJ8edkeJJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365727196"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="365727196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 18:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862443162"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="862443162"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 18:46:01 -0700
Message-ID: <6ea095cd-db21-c95a-b518-2d97b6098281@intel.com>
Date: Wed, 30 Aug 2023 09:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 13/58] kvm: Introduce kvm_arch_pre_create_vcpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-14-xiaoyao.li@intel.com>
 <5bfefa59-6e1e-dcfd-a2a6-e49a0b71fded@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <5bfefa59-6e1e-dcfd-a2a6-e49a0b71fded@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.242,
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

On 8/29/2023 10:40 PM, Philippe Mathieu-Daudé wrote:
> On 18/8/23 11:49, Xiaoyao Li wrote:
>> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
>> work prior to create any vcpu. This is for i386 TDX because it needs
>> call TDX_INIT_VM before creating any vcpu.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   accel/kvm/kvm-all.c  | 12 ++++++++++++
>>   include/sysemu/kvm.h |  1 +
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index c9f3aab5e587..5071af917ae0 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -422,6 +422,11 @@ static int kvm_get_vcpu(KVMState *s, unsigned 
>> long vcpu_id)
>>       return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>>   }
>> +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu)
>> +{
>> +    return 0;
>> +}
> 
> kvm_arch_init_vcpu() is implemented for each arch. Why not use the
> same approach here?

Because only x86 needs it currently, for TDX. Other arches don't require 
an implementation.

If don't provide the _weak_ function, it needs to implement the empty 
function (justing return 0) in all the other arches just as the 
placeholder. If QEMU community prefers this approach, I can change to it 
in next version.

>>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>   {
>>       KVMState *s = kvm_state;
>> @@ -430,6 +435,13 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>> +    ret = kvm_arch_pre_create_vcpu(cpu);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "%s: kvm_arch_pre_create_vcpu() 
>> failed",
>> +                        __func__);
>> +        goto err;
>> +    }
>> +
>>       ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>       if (ret < 0) {
>>           error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu 
>> failed (%lu)",
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 49c896d8a512..d89ec87072d7 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -371,6 +371,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level);
>>   int kvm_arch_init(MachineState *ms, KVMState *s);
>> +int kvm_arch_pre_create_vcpu(CPUState *cpu);
>>   int kvm_arch_init_vcpu(CPUState *cpu);
>>   int kvm_arch_destroy_vcpu(CPUState *cpu);
> 


