Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 822537367B0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXdu-0004W0-6V; Tue, 20 Jun 2023 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qBXdo-0004Tx-Jv; Tue, 20 Jun 2023 05:27:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qBXdm-0003aq-LE; Tue, 20 Jun 2023 05:27:12 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35K9H41p024508; Tue, 20 Jun 2023 09:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CXbM65lmRAUaEVmfVOwWmsyUdf5pGJ9sI2rIFg/x2nI=;
 b=km8zL88npS/ZDrupsoax0Tw8Y9hJE80TYvTZSRLyPVWL8+r3DYdOKyvKQD+jN2wJVihN
 04uDn2M9vmtqDY8VRBlwqRkQV4S5gfkl1HAVRn6fj22czdDTqJdn051nwI3Trg0DPifX
 dGZHwXnnm+ZDbhT4opTAIYq7fNhfGjRBSThif1x1v9PBVTOBydl7WTtDtO4msqsVj7cK
 pvAtL4BSOZ5/pZEDORj1LPinBN3UIo/eqMm8xH3hC6297Sa41NQdgACm2DZWZhDKV6e7
 pFcB0zoEEmPx14cJ5aNWqrT38LiWKI3SvDopjOs6BiNrUJYYuJlZ6cObUgMsQMokZFN2 yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb9bc0adn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 09:27:07 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35K9HcF6028572;
 Tue, 20 Jun 2023 09:27:07 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rb9bc0ad6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 09:27:06 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35K9R2jE031912;
 Tue, 20 Jun 2023 09:27:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r94f66vvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 09:27:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35K9R4IY64094526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 09:27:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1915158056;
 Tue, 20 Jun 2023 09:27:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7BE58067;
 Tue, 20 Jun 2023 09:27:02 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jun 2023 09:27:01 +0000 (GMT)
Message-ID: <374c620b-abc2-a5a0-6cdf-cbc0294137f3@linux.ibm.com>
Date: Tue, 20 Jun 2023 14:57:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] spapr: Allow up to 8 threads SMT on POWER8 and newer
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230605112323.179259-1-npiggin@gmail.com>
 <20230605112323.179259-5-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230605112323.179259-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0RO1oDByIEAm6igFKKWh46HbsJCor6Em
X-Proofpoint-ORIG-GUID: VlJmjD7xvH7n5bb3VmLzjuzAgwsBNjOD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/5/23 16:53, Nicholas Piggin wrote:
> PPC TCG now supports multi-threaded CPU configuration for non-hypervisor
> state. This requires PIR and TIR be set, because that's how sibling thread
> matching is done.
> 
> spapr's nested-HV capability does not currently coexist with SMT. This
> is quite analogous to LPAR-per-core mode on real hardware which also
> does not support KVM.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c          | 16 ++++++++++++----
>   hw/ppc/spapr_caps.c     | 14 ++++++++++++++
>   hw/ppc/spapr_cpu_core.c |  7 +++++--
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dcb7f1c70a..deb8b507e3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2524,10 +2524,18 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>       int ret;
>       unsigned int smp_threads = ms->smp.threads;
>   
> -    if (!kvm_enabled() && (smp_threads > 1)) {
> -        error_setg(errp, "TCG cannot support more than 1 thread/core "
> -                   "on a pseries machine");
> -        return;
> +    if (!kvm_enabled()) {

Can we make it a check for tcg_enabled() which would be more appropriate 
or as Cedric suggested, may be include this one along with your series:

https://lore.kernel.org/qemu-devel/20230620074802.86898-1-philmd@linaro.org/

regards,
Harsh
> +        if (!ppc_type_check_compat(ms->cpu_type, CPU_POWERPC_LOGICAL_2_07, 0,
> +                                   spapr->max_compat_pvr)) {
> +            error_setg(errp, "TCG only supports SMT on POWER8 or newer CPUs");
> +            return;
> +        }
> +
> +        if (smp_threads > 8) {
> +            error_setg(errp, "TCG cannot support more than 8 threads/core "
> +                       "on a pseries machine");
> +            return;
> +        }
>       }
>       if (!is_power_of_2(smp_threads)) {
>           error_setg(errp, "Cannot support %d threads/core on a pseries "
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 3fd45a6dec..03f02b4af3 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -473,6 +473,20 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>                   error_append_hint(errp,
>                                     "Try appending -machine cap-nested-hv=off\n");
>           }
> +    } else {
> +        MachineState *ms = MACHINE(spapr);
> +        unsigned int smp_threads = ms->smp.threads;
> +
> +        /*
> +         * Nested-HV vCPU env state to L2, so SMT-shared SPR updates, for
> +         * example, do not necessarily update the correct SPR value on sibling
> +         * threads that are in a different guest/host context.
> +         */
> +        if (smp_threads > 1) {
> +            error_setg(errp, "TCG does not support nested-HV with SMT");
> +            error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
> +                                    "or use threads=1 with -smp\n");
> +        }
>       }
>   }
>   
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 9b88dd549a..a4e3c2fadd 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -255,7 +255,7 @@ static void spapr_cpu_core_unrealize(DeviceState *dev)
>   }
>   
>   static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
> -                               SpaprCpuCore *sc, Error **errp)
> +                               SpaprCpuCore *sc, int thread_index, Error **errp)
>   {
>       CPUPPCState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> @@ -267,6 +267,9 @@ static bool spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>       kvmppc_set_papr(cpu);
>   
> +    env->spr_cb[SPR_PIR].default_value = cs->cpu_index;
> +    env->spr_cb[SPR_TIR].default_value = thread_index;
> +
>       /* Set time-base frequency to 512 MHz. vhyp must be set first. */
>       cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
>   
> @@ -337,7 +340,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>       for (i = 0; i < cc->nr_threads; i++) {
>           sc->threads[i] = spapr_create_vcpu(sc, i, errp);
>           if (!sc->threads[i] ||
> -            !spapr_realize_vcpu(sc->threads[i], spapr, sc, errp)) {
> +            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
>               spapr_cpu_core_unrealize(dev);
>               return;
>           }

