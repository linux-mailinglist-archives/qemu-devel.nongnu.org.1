Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA677A2255
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAiJ-0004oy-21; Fri, 15 Sep 2023 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAiF-0004oB-O3; Fri, 15 Sep 2023 11:26:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qhAi9-0005CP-Li; Fri, 15 Sep 2023 11:26:31 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FFQ1fO009309; Fri, 15 Sep 2023 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/zH+vCIA/0iEMhYfJT6mCElazOiCpfv3UX6EXBab5eo=;
 b=cnDTvbEEOEvEPdvu/93Mq5IUypIH7dw8QeIg33vdQpYN5xHVb/Ox1gfJWKlPtKJp4qLd
 ZIpkwEgO+/2JqESOCvcmW03GZY0U2INmaGpSLRWlD863T1rSX6PbTc01mD+yzCvGmoch
 9LVQruWhsVWy0i5Ar8y1NmIWB9WNPD9eJjr06Ogri2fvCBqGtcsLn0LPCBIcQTP0AIXI
 WoNFQUEqy79DC91FUOSNPBOqVx6xHr+wNmGblKR2ooKeybPXwkN/FNf7zzKJOQ6Vkh3x
 Y9pz/kUN74Ys0GRRmE1ldxwNuX4ZkDaQwxJ59XgpHGQpVA6raRKTL3x4hfSJo/Q5ptj3 gA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4swhr00s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:26:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38FFQ0qY009253;
 Fri, 15 Sep 2023 15:26:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4swhr006-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:25:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FESjLG011971; Fri, 15 Sep 2023 15:25:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2mb90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Sep 2023 15:25:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38FFPwuQ7799490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 15:25:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B5D758054;
 Fri, 15 Sep 2023 15:25:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CD715803F;
 Fri, 15 Sep 2023 15:25:53 +0000 (GMT)
Received: from [9.195.40.219] (unknown [9.195.40.219])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Sep 2023 15:25:52 +0000 (GMT)
Message-ID: <ce35def0-318f-91ac-592f-517bb5bce09b@linux.ibm.com>
Date: Fri, 15 Sep 2023 20:55:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 3/4] accel/tcg: Guard tb_flush() with tcg_enabled()
 and remove the stub
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Anton Johansson <anjo@rev.ng>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20230914195229.78244-1-philmd@linaro.org>
 <20230914195229.78244-4-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230914195229.78244-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jKuNaX6O-2MUL0h9VQLvsSj_RS8khDEZ
X-Proofpoint-ORIG-GUID: PIO8bW2akO1pXJYAp_OONC7_wTA2zUzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/15/23 01:22, Philippe Mathieu-Daudé wrote:
> The check on tcg_enabled() make it clearer we want
> this call under TCG.
> 

tb_flush already has a check for tcg_enabled() in its definition.
Do we really need to check for same before calling it?

Thanks
Harsh

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/stubs/tcg-stub.c |  4 ----
>   cpu.c                  | 15 +++++++++------
>   gdbstub/softmmu.c      |  5 ++++-
>   hw/ppc/spapr_hcall.c   |  2 +-
>   4 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index dd890d6cf6..7d9846f7f2 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -14,10 +14,6 @@
>   #include "exec/tb-flush.h"
>   #include "exec/exec-all.h"
>   
> -void tb_flush(CPUState *cpu)
> -{
> -}
> -
>   int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool nonfault, void **phost, uintptr_t retaddr)
> diff --git a/cpu.c b/cpu.c
> index 0769b0b153..ce3b04f21f 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -57,12 +57,15 @@ static int cpu_common_post_load(void *opaque, int version_id)
>       cpu->interrupt_request &= ~0x01;
>       tlb_flush(cpu);
>   
> -    /* loadvm has just updated the content of RAM, bypassing the
> -     * usual mechanisms that ensure we flush TBs for writes to
> -     * memory we've translated code from. So we must flush all TBs,
> -     * which will now be stale.
> -     */
> -    tb_flush(cpu);
> +    if (tcg_enabled()) {
> +        /*
> +         * loadvm has just updated the content of RAM, bypassing the
> +         * usual mechanisms that ensure we flush TBs for writes to
> +         * memory we've translated code from. So we must flush all TBs,
> +         * which will now be stale.
> +         */
> +        tb_flush(cpu);
> +    }
>   
>       return 0;
>   }
> diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
> index 9f0b8b5497..edd13f047d 100644
> --- a/gdbstub/softmmu.c
> +++ b/gdbstub/softmmu.c
> @@ -21,6 +21,7 @@
>   #include "sysemu/cpus.h"
>   #include "sysemu/runstate.h"
>   #include "sysemu/replay.h"
> +#include "sysemu/tcg.h"
>   #include "hw/core/cpu.h"
>   #include "hw/cpu/cluster.h"
>   #include "hw/boards.h"
> @@ -170,7 +171,9 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>           } else {
>               trace_gdbstub_hit_break();
>           }
> -        tb_flush(cpu);
> +        if (tcg_enabled()) {
> +            tb_flush(cpu);
> +        }
>           ret = GDB_SIGNAL_TRAP;
>           break;
>       case RUN_STATE_PAUSED:
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index b7dc388f2f..306f8fdf55 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -296,7 +296,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       if (flags & (H_ICACHE_SYNCHRONIZE | H_ICACHE_INVALIDATE)) {
>           if (kvm_enabled()) {
>               kvmppc_icbi_range(cpu, pdst, len);
> -        } else {
> +        } else if (tcg_enabled()) {
>               tb_flush(CPU(cpu));
>           }
>       }

