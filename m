Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC807A6CE2
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 23:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qii87-0003PQ-4h; Tue, 19 Sep 2023 17:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qii84-0003P3-TE; Tue, 19 Sep 2023 17:19:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qii82-0000a6-JJ; Tue, 19 Sep 2023 17:19:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JL6XSf028687; Tue, 19 Sep 2023 21:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=8e5p+WbDyUNTbdLaewIujEEGFwWHhiBcCpY5H1L2xV8=;
 b=WSgAjezyFB+0ZXkxRUW2hi12POJ+J6Pq1YC2XZrJ8sd9sFVK6ek3hRTMhXQEWZSKYHfx
 W8sniLvnudn0cRVrfOBpqcKdeZVlP9UO4tTxl/Ni/8LPXkRzTcO109StgN9R6JviZWEl
 I9Zt4zl8bQFoKHdt4Az3SqyGcAOuGoWkCt2EYSVgK9V7OvvoamPmy/62U2hNs7zqwKTr
 dMCq073037CME9Pc2Wqdj51AAXUif7szYh7vdKXQrwIbvmB0jUMODpzhw+AnSML6HM7o
 pw4+yYMPd+GCjRxGHLpNfb6kZFFfsbPCl6MTxTF95XzFRoDjcY8a7EtrFVtKCcPa51XI Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7hrjad8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:19:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JL7Iiq002398;
 Tue, 19 Sep 2023 21:19:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7hrjad80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:19:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JJliFe005538; Tue, 19 Sep 2023 21:19:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2yrafe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:19:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JLJDF966060584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 21:19:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78AD35805B;
 Tue, 19 Sep 2023 21:19:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB18D58058;
 Tue, 19 Sep 2023 21:19:12 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 21:19:12 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 19 Sep 2023 16:19:12 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 1/4] target/ppc: Add new hflags to support BHRB
In-Reply-To: <CVJ2M9HZE734.1G62AT05YOJTP@wheely>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202347.3381298-1-milesg@linux.vnet.ibm.com>
 <CVJ2M9HZE734.1G62AT05YOJTP@wheely>
Message-ID: <61e8d5bb7aa50c3fc16caf29a8ff7dce@linux.vnet.ibm.com>
X-Sender: milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BuVNm2bmTihRzJLdx6TDp_WtFPPYOAnj
X-Proofpoint-ORIG-GUID: _1_POkQcyY_78wD7coYMuse_L7pC1Wc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_11,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=665 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190181
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023-09-14 19:39, Nicholas Piggin wrote:
> On Wed Sep 13, 2023 at 6:23 AM AEST, Glenn Miles wrote:
>> This commit is preparatory to the addition of Branch History
>> Rolling Buffer (BHRB) functionality, which is being provided
>> today starting with the P8 processor.
>> 
>> BHRB uses several SPR register fields to control whether or not
>> a branch instruction's address (and sometimes target address)
>> should be recorded.  Checking each of these fields with each
>> branch instruction using jitted code would lead to a significant
>> decrease in performance.
>> 
>> Therefore, it was decided that BHRB configuration bits that are
>> not expected to change frequently should have their state stored in
>> hflags so that the amount of checking done by jitted code can
>> be reduced.
>> 
>> This commit contains the changes for storing the state of the
>> following register fields as hflags:
>> 
>> 	MMCR0[FCP] - Determines if BHRB recording is frozen in the
>>                      problem state
>> 
>> 	MMCR0[FCPC] - A modifier for MMCR0[FCP]
>> 
>> 	MMCRA[BHRBRD] - Disables all BHRB recording for a thread
>> 
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> ---
>>  target/ppc/cpu.h                 |  9 +++++++++
>>  target/ppc/cpu_init.c            |  4 ++--
>>  target/ppc/helper.h              |  1 +
>>  target/ppc/helper_regs.c         | 12 ++++++++++++
>>  target/ppc/machine.c             |  2 +-
>>  target/ppc/power8-pmu-regs.c.inc |  5 +++++
>>  target/ppc/power8-pmu.c          | 15 +++++++++++----
>>  target/ppc/power8-pmu.h          |  4 ++--
>>  target/ppc/spr_common.h          |  1 +
>>  target/ppc/translate.c           |  6 ++++++
>>  10 files changed, 50 insertions(+), 9 deletions(-)
>> 
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 25fac9577a..20ae1466a5 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -439,6 +439,9 @@ FIELD(MSR, LE, MSR_LE, 1)
>>  #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 
>> bit */
>>  #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition 
>> Enabled */
>>  #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition 
>> Enabled */
>> +#define MMCR0_BHRBA  PPC_BIT_NR(42)      /* BHRB Available */
> 
> It's confusing to use NR for this. Either call it MMCR0_BHRBA_NR or 
> have
> the facility check in patch 3 take the bit value. I'd move it to patch 
> 3
> too.
> 

Ok, adding NR suffix.

>> +#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if 
>> PR=1 */
>> +#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
>>  /* MMCR0 userspace r/w mask */
>>  #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
>>  /* MMCR2 userspace r/w mask */
>> @@ -451,6 +454,9 @@ FIELD(MSR, LE, MSR_LE, 1)
>>  #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
>>                           MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
>> 
>> +#define MMCRA_BHRBRD    PPC_BIT(26)            /* BHRB Recording 
>> Disable */
>> +
>> +
>>  #define MMCR1_EVT_SIZE 8
>>  /* extract64() does a right shift before extracting */
>>  #define MMCR1_PMC1SEL_START 32
>> @@ -703,6 +709,9 @@ enum {
>>      HFLAGS_PMCJCE = 17, /* MMCR0 PMCjCE bit */
>>      HFLAGS_PMC_OTHER = 18, /* PMC other than PMC5-6 is enabled */
>>      HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
>> +    HFLAGS_FCPC = 20,   /* MMCR0 FCPC bit */
>> +    HFLAGS_FCP = 21,    /* MMCR0 FCP bit */
>> +    HFLAGS_BHRBRD = 22, /* MMCRA BHRBRD bit */
>>      HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
>>      HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
> 
> hflags are an interesting tradeoff. You can specialise some code but
> at the cost of duplicating your jit footprint, which is often the
> most costly thing. The ideal hflag is one where code is not shared
> between flag set/clear like PR and HV. Rarely used features is another
> good one, that BHRB falls into.
> 
> But, we do want flags that carry stronger or more direct semantics
> wrt code generation because you want to avoid redundant hflags values
> that result in the same code generation. I might have missed something
> but AFAIKS BHRB_ENABLED could be a combination of this logic (from
> later patch):
> 
> +    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
> +    if ((ctx->insns_flags2 & PPC2_ISA310) && (ctx->mmcra_bhrbrd || 
> !ctx->pr)) {
> +        return;
> +    }
> +
> +    /* Check for BHRB "frozen" conditions */
> +    if (ctx->mmcr0_fcpc) {
> +        if (ctx->mmcr0_fcp) {
> +            if ((ctx->hv) && (ctx->pr)) {
> +                return;
> +            }
> +        } else if (!(ctx->hv) && (ctx->pr)) {
> +            return;
> +        }
> +    } else if ((ctx->mmcr0_fcp) && (ctx->pr)) {
> +        return;
> +    }
> 

Ok, Combining above logic into a single hflag.

> Otherwise the patch looks good to me.
> 
> Thanks,
> Nick

