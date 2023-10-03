Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0E7B6033
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnXbe-0001Yc-Tw; Tue, 03 Oct 2023 01:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnXbb-0001Vu-HA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnXbZ-0002E3-3J
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696309555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5dQT9qD5TTy1wP0hgHYhCfKSWP3aGRptseShfOb194=;
 b=Fp4K3ZbUEsOw+998ntr91KcTzfuY3Ey/sR0rip/8n1Ucso03RW+u5GfszGoePfgGuCaKfQ
 ztYS5z3RtNQAEtK1/HrtweV7tKilEAry13nNN/lHhA23Dl0+JZXFAAdIQyxJt2Je1GzYmA
 JRh20/lg/h/7SzM1Xr9lAmk6nGTCsTE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-yfy77zC6MwGysartY9IBwA-1; Tue, 03 Oct 2023 01:05:54 -0400
X-MC-Unique: yfy77zC6MwGysartY9IBwA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1c60dcc3d9eso5167165ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 22:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696309553; x=1696914353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c5dQT9qD5TTy1wP0hgHYhCfKSWP3aGRptseShfOb194=;
 b=cuY0+iqt21eqr7G87b18+S7bg5O1Cx1QwPUNmlkAHYgqz7Q3QoS8bV9wYVKny+NkqV
 u2w0LmTlO9A6QA1WuwK62yKOEKoP0A8ZDqyK7JlRY9bEew4HY1GsADOfwy+5o9+8N/Uc
 n+pFFWEQzxJifzIDGIOChSTusuIYLzPhzvxwAWLwFy7BHAglR6leFQzISwU7BQUmUxVx
 dzW1pgksKuzNgRuq+xMkvgS8qLcWzH0MbaM5E9ssyV1vY3OoNq2XiTlACNY3genrl/bK
 ULX0lEB6zoFkP1tS3ylo5BIR7Mvb6cdyoOu0a7CDhAA1aT3Kut6r32Eal9pQ/VySh0Nz
 oJlg==
X-Gm-Message-State: AOJu0YxTbynzLZwfmqOHpeIRSOC+NmPumfi4khnwoLJVERoreYkHa0b2
 hZb899RNTeER1u9IwMBZ+Lu70rAYdmWGuM2XTeCZiCjqRJw4x8ubXKclgRqBTV/wPiPW7MLpvzA
 aBMnfRjX07pl/0AY=
X-Received: by 2002:a17:903:1247:b0:1c4:3cd5:4298 with SMTP id
 u7-20020a170903124700b001c43cd54298mr16458326plh.18.1696309553129; 
 Mon, 02 Oct 2023 22:05:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfiIKcWt0ogbkcryIAW+rwt3OeKadjjOIjCwEkuXZH/PaWRHCy78WoTzWYOY9Zfcx5cdi8jg==
X-Received: by 2002:a17:903:1247:b0:1c4:3cd5:4298 with SMTP id
 u7-20020a170903124700b001c43cd54298mr16458297plh.18.1696309552739; 
 Mon, 02 Oct 2023 22:05:52 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a17090274c300b001c61acd5bd2sm399027plt.112.2023.10.02.22.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 22:05:52 -0700 (PDT)
Message-ID: <7bc21702-c5a0-cf91-235f-3d8d68536c93@redhat.com>
Date: Tue, 3 Oct 2023 15:05:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 01/37] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-2-salil.mehta@huawei.com>
 <6cd28639-2cfa-f233-c6d9-d5d2ec5b1c58@redhat.com>
 <1cb12b5dd9f344f5a7a303ddbc5f5dfd@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <1cb12b5dd9f344f5a7a303ddbc5f5dfd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 10/2/23 19:53, Salil Mehta wrote:
> Many thanks for taking pains to review this patch-set.
> 

No worries.

>> From: Gavin Shan <gshan@redhat.com>
>> Sent: Wednesday, September 27, 2023 12:57 AM
>> To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> imammedo@redhat.com; andrew.jones@linux.dev; david@redhat.com;
>> philmd@linaro.org; eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
>> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
>> rafael@kernel.org; borntraeger@linux.ibm.com; alex.bennee@linaro.org;
>> linux@armlinux.org.uk; darren@os.amperecomputing.com;
>> ilkka@os.amperecomputing.com; vishnu@os.amperecomputing.com;
>> karl.heubaum@oracle.com; miguel.luis@oracle.com; salil.mehta@opnsrc.net;
>> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
>> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 01/37] arm/virt,target/arm: Add new ARMCPU
>> {socket,cluster,core,thread}-id property
>>
>> On 9/26/23 20:04, Salil Mehta wrote:
>>> This shall be used to store user specified topology{socket,cluster,core,thread}
>>> and shall be converted to a unique 'vcpu-id' which is used as slot-index during
>>> hot(un)plug of vCPU.
>>>
>>
>> Note that we don't have 'vcpu-id' property. It's actually the index to the array
>> ms->possible_cpus->cpus[] and cpu->cpu_index. Please improve the commit log if
>> it makes sense.
> 
> I can change but was it mentioned anywhere in the log that vcpu-id is
> a property?
> 

I was thinking it's a property when vcpu-id is quoted with ''. Besides,
"vcpu-id" is usually understood as vCPU's ID instead of vCPU index. I ment
to avoid 'vcpu-id' in the commit log because we're talking about vCPU index
instead vCPU ID. Otherwise, readers or reviewers will be confused because
of it.

> 
>>> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> ---
>>>    hw/arm/virt.c    | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>    target/arm/cpu.c |  4 +++
>>>    target/arm/cpu.h |  4 +++
>>>    3 files changed, 71 insertions(+)
>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 7d9dbc2663..57fe97c242 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -221,6 +221,11 @@ static const char *valid_cpus[] = {
>>>        ARM_CPU_TYPE_NAME("max"),
>>>    };
>>>
>>> +static int virt_get_socket_id(const MachineState *ms, int cpu_index);
>>> +static int virt_get_cluster_id(const MachineState *ms, int cpu_index);
>>> +static int virt_get_core_id(const MachineState *ms, int cpu_index);
>>> +static int virt_get_thread_id(const MachineState *ms, int cpu_index);
>>> +
>>>    static bool cpu_type_valid(const char *cpu)
>>>    {
>>>        int i;
>>> @@ -2168,6 +2173,14 @@ static void machvirt_init(MachineState *machine)
>>>                              &error_fatal);
>>>
>>>            aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
>>> +        object_property_set_int(cpuobj, "socket-id",
>>> +                                virt_get_socket_id(machine, n), NULL);
>>> +        object_property_set_int(cpuobj, "cluster-id",
>>> +                                virt_get_cluster_id(machine, n), NULL);
>>> +        object_property_set_int(cpuobj, "core-id",
>>> +                                virt_get_core_id(machine, n), NULL);
>>> +        object_property_set_int(cpuobj, "thread-id",
>>> +                                virt_get_thread_id(machine, n), NULL);
>>>
>>>            if (!vms->secure) {
>>>                object_property_set_bool(cpuobj, "has_el3", false, NULL);
>>> @@ -2652,10 +2665,59 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
>>>        return socket_id % ms->numa_state->num_nodes;
>>>    }
>>>
>>
>> It seems it's not unnecessary to keep virt_get_{socket, cluster, core, thread}_id()
>> because they're called for once. I would suggest to figure out the socket, cluster,
>> core and thread ID through @possible_cpus in machvirt_init(), like below.
> 
> It is always good to access properties through accessor functions. Beside the
> main purpose here was to keep the code neat. So I would stick with these.
> 
> But because these are something which are not specific to VirtMachine I can
> move them to some other place or a header file so that other architectures
> can also use them.
> 

No, these functions aren't property accessors at all. Actually, they're figuring
out the IDs, passed to object_property_set_int(). I don't see the benefits to
keep those functions who are called for once, and their logic is simple enough to
be integrated to the callers.

> 
>> Besides, we can't always expose property "cluster-id" since cluster in the CPU
>> topology isn't always supported, seeing MachineClass::smp_props. Some users may
>> want to hide cluster for unknown reasons. 'cluster-id' shouldn't be exposed in
>> this case. Otherwise, users may be confused by 'cluster-id' property while it
>> has been disabled. For example, a VM is started with the following command lines
>> and 'cluster-id' shouldn't be supported in vCPU hot-add.
> 
> True. All we are talking about is 4*integer space. This is to avoid complexity
> of checks everywhere in the code by having these variables always exists and
> with default values as 0. If the architecture does not defines property it will
> not use these variable. It is a little tradeoff of memory with respect to
> maintainability of code. I would prefer later.
> 
> We can definitely put some comments in the places of their declaration.
> 

I'm not sure if a comment will resolve the potential issue. It sounds weird that
'cluster-id' property exists even the level of CPU topology isn't supported at all.

> 
>>       -cpu host -smp=maxcpus=2,cpus=1,sockets=2,cores=1,threads=1
>>       (qemu) device_add host,id=cpu1,socket-id=1,cluster-id=0,core-id=0,thread-id=0
>>
>>       object_property_set_int(cpuobj, "socket-id",
>>                               possible_cpus->cpus[i].props.socket_id, NULL);
>>       if (mc->smp_props.cluster_supported && mc->smp_props.has_clusters) {
>>           object_property_set_int(cpuobj, "cluster-id",
>>                                   possible_cpus->cpus[i].props.cluster_id, NULL);
>>       }
> 
> Exactly, these types of checks can be avoided. They make code unnecessarily look
> complex and ugly.
> 

As explained above, the property 'cluster-id' shouldn't be existing if cluster
isn't supported in CPU topology.

>>       object_property_set_int(cpuobj, "core-id",
>>                               possible_cpus->cpus[i].props.core_id, NULL);
>>       object_property_set_int(cpuobj, "thread-id",
>>                               possible_cpus->cpus[i].props.thread_id, NULL);
>>
>>> +static int virt_get_socket_id(const MachineState *ms, int cpu_index)
>>> +{
>>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>>> +
>>> +    return ms->possible_cpus->cpus[cpu_index].props.socket_id;
>>> +}
>>> +
>>> +static int virt_get_cluster_id(const MachineState *ms, int cpu_index)
>>> +{
>>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>>> +
>>> +    return ms->possible_cpus->cpus[cpu_index].props.cluster_id;
>>> +}
>>> +
>>> +static int virt_get_core_id(const MachineState *ms, int cpu_index)
>>> +{
>>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>>> +
>>> +    return ms->possible_cpus->cpus[cpu_index].props.core_id;
>>> +}
>>> +
>>> +static int virt_get_thread_id(const MachineState *ms, int cpu_index)
>>> +{
>>> +    assert(cpu_index >= 0 && cpu_index < ms->possible_cpus->len);
>>> +
>>> +    return ms->possible_cpus->cpus[cpu_index].props.thread_id;
>>> +}
>>> +
>>> +static int
>>> +virt_get_cpu_id_from_cpu_topo(const MachineState *ms, DeviceState *dev)
>>> +{
>>> +    int cpu_id, sock_vcpu_num, clus_vcpu_num, core_vcpu_num;
>>> +    ARMCPU *cpu = ARM_CPU(dev);
>>> +
>>> +    /* calculate total logical cpus across socket/cluster/core */
>>> +    sock_vcpu_num = cpu->socket_id * (ms->smp.threads * ms->smp.cores *
>>> +                    ms->smp.clusters);
>>> +    clus_vcpu_num = cpu->cluster_id * (ms->smp.threads * ms->smp.cores);
>>> +    core_vcpu_num = cpu->core_id * ms->smp.threads;
>>> +
>>> +    /* get vcpu-id(logical cpu index) for this vcpu from this topology
>> */
>>> +    cpu_id = (sock_vcpu_num + clus_vcpu_num + core_vcpu_num) + cpu->thread_id;
>>> +
>>> +    assert(cpu_id >= 0 && cpu_id < ms->possible_cpus->len);
>>> +
>>> +    return cpu_id;
>>> +}
>>> +
>>
>> This function is called for once in PATCH[04/37]. I think it needs to be moved
>> around to PATCH[04/37].
> 
> 
> Yes, we can do that.
> 

Ok.

>> [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time change common
>> to vCPU {cold|hot}-plug
>>
>> The function name can be shortened because I don't see the suffix "_from_cpu_topo"
>> is too much helpful. I think virt_get_cpu_index() would be good enough since it's
>> called for once to return the index in array MachineState::possible_cpus::cpus[]
>> and the return value is stored to CPUState::cpu_index
> 
> This is not an accessor function. This function derives the unique vcpu-id
> from topology. Hence, naming is correct. Though, I can shorten the name
> to something like below if you wish,
> 
> virt_get_cpu_id_from_cpu_topo() -> virt_cpu_id_from_topology()
> 
> 
> The name virt_get_cpu_index() suggests as if function is something like below
> and which it is not:
> 
> virt_get_cpu_index()
> {
>     return cs->cpu_index
> }
> 

Well, the point was to indicate 'CPU index' instead of 'CPU ID' returned
from this function, as clarified in the commit log. Please don't mix
'CPU index' and 'CPU ID' even they're same in some situations on aarch64.
So how about renaming it to virt_cpu_index_from_topology()?

> 
> 
>> static int virt_get_cpu_index(const MachineState *ms, ARMCPU *cpu)
>> {
>>       int index, cpus_in_socket, cpus_in_cluster, cpus_in_core;
>>
>>       /*
>>        * It's fine to take cluster into account even it's not supported. In this
>>        * case, ms->smp.clusters is always one.
>>        */
>> }
>>
>>>    static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState
>> *ms)
>>>    {
>>>        int n;
>>>        unsigned int max_cpus = ms->smp.max_cpus;
>>> +    unsigned int smp_threads = ms->smp.threads;
>>>        VirtMachineState *vms = VIRT_MACHINE(ms);
>>>        MachineClass *mc = MACHINE_GET_CLASS(vms);
>>>
>>> @@ -2669,6 +2731,7 @@ static const CPUArchIdList
>> *virt_possible_cpu_arch_ids(MachineState *ms)
>>>        ms->possible_cpus->len = max_cpus;
>>>        for (n = 0; n < ms->possible_cpus->len; n++) {
>>>            ms->possible_cpus->cpus[n].type = ms->cpu_type;
>>> +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
>>>            ms->possible_cpus->cpus[n].arch_id =
>>>                virt_cpu_mp_affinity(vms, n);
>>>
>>
>> This initialization seems to accomodate HMP command "info hotpluggable-
>> cpus".
>> It would be nice if it can be mentioned in the commit log.
>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 93c28d50e5..1376350416 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -2277,6 +2277,10 @@ static Property arm_cpu_properties[] = {
>>>        DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>>>                            mp_affinity, ARM64_AFFINITY_INVALID),
>>>        DEFINE_PROP_INT32("node-id", ARMCPU, node_id,
>> CPU_UNSET_NUMA_NODE_ID),
>>> +    DEFINE_PROP_INT32("socket-id", ARMCPU, socket_id, 0),
>>> +    DEFINE_PROP_INT32("cluster-id", ARMCPU, cluster_id, 0),
>>> +    DEFINE_PROP_INT32("core-id", ARMCPU, core_id, 0),
>>> +    DEFINE_PROP_INT32("thread-id", ARMCPU, thread_id, 0),
>>>        DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
>>>        DEFINE_PROP_END_OF_LIST()
>>>    };
>>
>> All those 4 properties are used for vCPU hot-add, meaning they're not needed
>> when vCPU hotplug isn't supported on the specific board. Even for hw/virt board,
>> cluster isn't always supported and 'cluster-id' shouldn't always be exposed,
>> as explained above. How about to register the properties dynamically only when
>> they're needed by vCPU hotplug?
> 
> 
> Yes, these are part of arch specific files so it is upto the arch whether to define
> them or not to define them at all?
> 
> Yes, and as mentioned earlier, there is extra bit of memory(4*integer) which is
> being used. I would tradeoff this vis-à-vis maintainability.
> 

Right, making sense to me.

>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 88e5accda6..d51d39f621 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -1094,6 +1094,10 @@ struct ArchCPU {
>>>        QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
>>>
>>>        int32_t node_id; /* NUMA node this CPU belongs to */
>>> +    int32_t socket_id;
>>> +    int32_t cluster_id;
>>> +    int32_t core_id;
>>> +    int32_t thread_id;
>>
>> It would be fine to keep those fields even the corresponding properties are
>> dynamically registered, but a little bit memory overhead incurred :)
> 
> You are contradicting yourself here ;)
> 

Correct. I was wandering if we need the properties, even vCPU hotplug
isn't supported. As you explained above, I agree with you that it's fine
to keep these properties even vCPU hotplug is unsupported.

Thanks,
Gavin


