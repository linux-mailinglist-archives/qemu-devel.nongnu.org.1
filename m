Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EE771C83
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvq7-0006aC-FM; Mon, 07 Aug 2023 04:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSvq5-0006Vu-OD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:43:45 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSvq2-0006U6-M5
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691397822; x=1722933822;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Vo7MZ5pJHUUmxghQ2yTjCli6Xe7FMaDCESOufDE1kWg=;
 b=g8uJQYMW1GzLgu9B0EXBHdKv7kE70GeqvuS+ePGa0dsAPIRnmxkaisI0
 FIIymoLPWggiloJ+d7s0bhA9muje3WREICBNPOvNSGX62OynUfys55Tf3
 krVIDABYSYxv2qsI1crC7lD2hfsqzS+kjF2VD5Pcw3oWcUiPbbDpEH02M
 UALpRYDaofobmPBYC/wyKntOJOFJy5tCa/tEBzoIOGCbkgPuvd+v6hcgV
 aQJEU3NJJu6MMC8Hv0MalqePM2Tt+DSIAa3T4AKoKiJX3RLA1aYG04mso
 PAbZbSzub5+P4XI29UxhCfQl28cyUH1TMTal+uS2bDTuB9fI7pWbKPSbY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="436824232"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="436824232"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 01:43:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="800869141"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="800869141"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 01:43:35 -0700
Message-ID: <7d3d2630-4ac4-8875-8c6f-054000462755@intel.com>
Date: Mon, 7 Aug 2023 16:43:32 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZNCi6uNsVB1F39XD@liuzhao-OptiPlex-7080>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-4.139,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 8/7/2023 3:53 PM, Zhao Liu wrote:
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 97ad229d8ba3..50613cd04612 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>        X86CPUTopoInfo topo_info;
>>>        topo_info.dies_per_pkg = env->nr_dies;
>>> -    topo_info.cores_per_die = cs->nr_cores;
>>> +    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
>> This and below things make me think that, it looks ugly that @nr_dies is
>> added separately in struct CPUArchState for i386 because CPUState only has
>> @nr_cores and nr_threads. Further, for i386, it defines a specific struct
>> X86CPUTopoInfo to contain topology info when setting up CPUID. To me, struct
>> X86CPUTopoInfo is redundant as struct CpuTopology.
>>
>> maybe we can carry a struct CpuTopology in CPUState, so that we can drop
>> @nr_threads, @nr_cores in CPUState for all ARCHes, and @nr_dies in struct
>> CPUArchState for i386. As well, topo_info can be dropped here.
> Yeah, I agree. We think the same way, as did in [1].
> 
> About X86CPUTopoInfo, it's still necessary to keep to help encode
> APICID. 

typedef struct X86CPUTopoInfo {
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
} X86CPUTopoInfo;

/**
  * CpuTopology:
  * @cpus: the number of present logical processors on the machine
  * @sockets: the number of sockets on the machine
  * @dies: the number of dies in one socket
  * @clusters: the number of clusters in one die
  * @cores: the number of cores in one cluster
  * @threads: the number of threads in one core
  * @max_cpus: the maximum number of logical processors on the machine
  */
typedef struct CpuTopology {
     unsigned int cpus;
     unsigned int sockets;
     unsigned int dies;
     unsigned int clusters;
     unsigned int cores;
     unsigned int threads;
     unsigned int max_cpus;
} CpuTopology;

I think 'struct X86CPUTopoInfo' is just a subset of 'struct CpuTopology'

IIUC, currently the value of X86CPUTopoInfo::dies_per_pkg should equal 
with CpuTopology::dies, and the same for cores_per_die and threads_per_core.

So it's OK to keep an copy of 'struct CpuTopology' in CPUState and drop 
'struct X86CPUTopoInfo'

> For hybrid topology case, the APICID is likely discontinuous,
> and the width of each CPU level in APICID depends on the maximum number
> of elements in this level. So I also proposed to rename it to
> X86ApicidTopoInfo [2] and count the maximum number of elements in each
> CPU level.

Do you mean, for example, for hybrid topology, 
X86CPUTopoInfo::dies_per_pkg != CpuTopology::dies? Or after rename
X86CPUTopoInfo::max_dies != CpuTopology::dies?

> [2]:https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03237.html
> 
> Thanks,
> Zhao
> 


