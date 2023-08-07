Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39716772788
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT16N-0004GP-2K; Mon, 07 Aug 2023 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qT16K-0004G7-OM
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:20:52 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qT16H-0006mh-9E
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691418049; x=1722954049;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Bk2KTnbS2DoQbnl1i2e2DKph9vUA9RsJBz7/ovMUqZ8=;
 b=E2eMGW0FvvAAOm/9jahJAwsNwNyR1ZjtO05SIqvJdPJMPXmguiWkfSFp
 E0bThdvQ+VTWI/46/FUYOlTCCC/080xjRoHsFzwzofaWpQOopd0ne/ZRw
 9xqKx8Z4PmFYAMOBmj615cp6s4uUs2nfJN5fs68U9sdNkwaczDSYY1V+W
 Cf9oN3A0IH3KvdM9pBWVhxqps0tB5Isn88MtwsGdWijRsdKSfUzmyhEQ2
 2IqX7jsoKTByLdZdYwIdeVbZ9HJrETD1swpgfsPDJw73f9l4wGxMRwAqE
 Nr78j93CzlbcicLhqr3tcMfH3l5eUqOAFDF5StkEwIL5a6rM5fmLuhfTz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355495393"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; d="scan'208";a="355495393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 07:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="874326850"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 07:20:45 -0700
Message-ID: <bddb9f52-e07c-83bb-8af8-1e726616f42a@intel.com>
Date: Mon, 7 Aug 2023 22:20:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-4-zhao1.liu@linux.intel.com>
 <17d46d49-844c-60ed-56cc-0e671564948a@intel.com>
 <ZNCi6uNsVB1F39XD@liuzhao-OptiPlex-7080>
 <7d3d2630-4ac4-8875-8c6f-054000462755@intel.com>
 <ZNDAsj0N/FoBXG/b@liuzhao-OptiPlex-7080>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZNDAsj0N/FoBXG/b@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.809,
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

On 8/7/2023 6:00 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Mon, Aug 07, 2023 at 04:43:32PM +0800, Xiaoyao Li wrote:
>> Date: Mon, 7 Aug 2023 16:43:32 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
>>
>> On 8/7/2023 3:53 PM, Zhao Liu wrote:
>>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>>> index 97ad229d8ba3..50613cd04612 100644
>>>>> --- a/target/i386/cpu.c
>>>>> +++ b/target/i386/cpu.c
>>>>> @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>>>         X86CPUTopoInfo topo_info;
>>>>>         topo_info.dies_per_pkg = env->nr_dies;
>>>>> -    topo_info.cores_per_die = cs->nr_cores;
>>>>> +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
>>>> This and below things make me think that, it looks ugly that @nr_dies is
>>>> added separately in struct CPUArchState for i386 because CPUState only has
>>>> @nr_cores and nr_threads. Further, for i386, it defines a specific struct
>>>> X86CPUTopoInfo to contain topology info when setting up CPUID. To me, struct
>>>> X86CPUTopoInfo is redundant as struct CpuTopology.
>>>>
>>>> maybe we can carry a struct CpuTopology in CPUState, so that we can drop
>>>> @nr_threads, @nr_cores in CPUState for all ARCHes, and @nr_dies in struct
>>>> CPUArchState for i386. As well, topo_info can be dropped here.
>>> Yeah, I agree. We think the same way, as did in [1].
>>>
>>> About X86CPUTopoInfo, it's still necessary to keep to help encode
>>> APICID.
>>
>> typedef struct X86CPUTopoInfo {
>>      unsigned dies_per_pkg;
>>      unsigned cores_per_die;
>>      unsigned threads_per_core;
>> } X86CPUTopoInfo;
>>
>> /**
>>   * CpuTopology:
>>   * @cpus: the number of present logical processors on the machine
>>   * @sockets: the number of sockets on the machine
>>   * @dies: the number of dies in one socket
>>   * @clusters: the number of clusters in one die
>>   * @cores: the number of cores in one cluster
>>   * @threads: the number of threads in one core
>>   * @max_cpus: the maximum number of logical processors on the machine
>>   */
>> typedef struct CpuTopology {
>>      unsigned int cpus;
>>      unsigned int sockets;
>>      unsigned int dies;
>>      unsigned int clusters;
>>      unsigned int cores;
>>      unsigned int threads;
>>      unsigned int max_cpus;
>> } CpuTopology;
>>
>> I think 'struct X86CPUTopoInfo' is just a subset of 'struct CpuTopology'
> 
> For smp topology, it's correct.
> 
>>
>> IIUC, currently the value of X86CPUTopoInfo::dies_per_pkg should equal with
>> CpuTopology::dies, and the same for cores_per_die and threads_per_core.
>>
>> So it's OK to keep an copy of 'struct CpuTopology' in CPUState and drop
>> 'struct X86CPUTopoInfo'
>>
>>> For hybrid topology case, the APICID is likely discontinuous,
>>> and the width of each CPU level in APICID depends on the maximum number
>>> of elements in this level. So I also proposed to rename it to
>>> X86ApicidTopoInfo [2] and count the maximum number of elements in each
>>> CPU level.
>>
>> Do you mean, for example, for hybrid topology, X86CPUTopoInfo::dies_per_pkg
>> != CpuTopology::dies? Or after rename
>> X86CPUTopoInfo::max_dies != CpuTopology::dies?
> 
> I mean the latter.
> 
> A more typical example nowadays is thread level.
> 
> X86CPUTopoInfo::max_threads may not euqal to CpuTopology::threads,
> 
> since P core has 2 threads per core and E core doesn't support SMT.
> 
> The CpuTopology in CPUState should reflect the topology information for
> current CPU, so CpuTopology::threads is 2 for P core and
> CpuTopology::threads = 1 for E core.
> 
> But the width of the SMT level in APICID must be fixed, so that SMT width
> should be determined by X86CPUTopoInfo::max_threads. Current hybrid
> platforms implement it the same way.

I see.

Can we pull the patch into this series (define a common CPUTopoInfo in 
CPUState and drop env->nr_dies, cs->nr_cores and cs->nr_threads) and let 
the hybrid series later to rename it to X86ApicidTopoInfo?

> Thanks,
> Zhao
> 
>>
>>> [2]:https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03237.html
>>>
>>> Thanks,
>>> Zhao
>>>
>>


