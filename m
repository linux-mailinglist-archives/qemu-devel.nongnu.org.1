Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E57A6D08
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 23:41:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiiSW-0008Gd-IU; Tue, 19 Sep 2023 17:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qiiSS-0008Fr-Nt; Tue, 19 Sep 2023 17:40:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qiiSQ-0004xo-M0; Tue, 19 Sep 2023 17:40:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JLKXbW016349; Tue, 19 Sep 2023 21:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=p4w1hTKUfv7o3MOtpHyGFknZReImoO7pOoTGgMR0Leo=;
 b=Bb+pB5mnZDnsja/NLffee3X7DtqfOGlFbo3abglo5XcEJ90bg5Uxv0i0WAF+1HIQruen
 Hmsh3kC4cLFRGL6Ok9PbVGJ665hn+sLYnfCoDfN4sRZPtIpU/O+NiXNicgFRJPLxEb0+
 613PHqch9PhvV4k5Gcrjb0dHLUq8cCE57tF8fYJ2NohBfdQ5e7wQG7Zh/LjO9Y9Kp6cU
 heJ5ND4cY/ma4F++6SnolVGkimSu5LJlSoQdgh0xyXo/AZANAxakKlwQ7zXu04r93pul
 +XTWTTZB5mpQ7ibRrhjq05Zjrtm/7JSgrmcyX80lWH4hwWmamteqPwUxgYqO5R3HE+7y LA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7kfqrfnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:40:22 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JLKtG3018003;
 Tue, 19 Sep 2023 21:40:22 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7kfqrfn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:40:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JLTOlQ010018; Tue, 19 Sep 2023 21:40:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk7tx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 21:40:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JLeLR23932904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 21:40:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 663665805A;
 Tue, 19 Sep 2023 21:40:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ED1058051;
 Tue, 19 Sep 2023 21:40:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 21:40:21 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 19 Sep 2023 16:40:20 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 3/4] target/ppc: Add clrbhrb and mfbhrbe instructions
In-Reply-To: <CVJ3BU3MZKOR.1SBA8KVQYWOXL@wheely>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
 <20230912202447.3381835-1-milesg@linux.vnet.ibm.com>
 <CVJ3BU3MZKOR.1SBA8KVQYWOXL@wheely>
Message-ID: <0ee972fd96241de097d6fc15865b3bdf@linux.vnet.ibm.com>
X-Sender: milesg@linux.vnet.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uBLw2QkGOTrp5od8GxV74EXdEEVBCgw-
X-Proofpoint-ORIG-GUID: gwiodM4awW1PuDJXKEv6JR-7Hrti_dPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=533
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190183
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2023-09-14 20:13, Nicholas Piggin wrote:
> On Wed Sep 13, 2023 at 6:24 AM AEST, Glenn Miles wrote:
>> Add support for the clrbhrb and mfbhrbe instructions.
>> 
>> Since neither instruction is believed to be critical to
>> performance, both instructions were implemented using helper
>> functions.
>> 
>> Access to both instructions is controlled by bits in the
>> HFSCR (for privileged state) and MMCR0 (for problem state).
>> A new function, helper_mmcr0_facility_check, was added for
>> checking MMCR0[BHRBA] and raising a facility_unavailable exception
>> if required.
>> 
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> ---
>>  target/ppc/cpu.h         |  1 +
>>  target/ppc/helper.h      |  4 ++++
>>  target/ppc/misc_helper.c | 43 
>> ++++++++++++++++++++++++++++++++++++++++
>>  target/ppc/translate.c   | 13 ++++++++++++
>>  4 files changed, 61 insertions(+)
>> 
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index bda1afb700..ee81ede4ee 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -541,6 +541,7 @@ FIELD(MSR, LE, MSR_LE, 1)
>> 
>>  /* HFSCR bits */
>>  #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send 
>> Facilities */
>> +#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
>>  #define HFSCR_IC_MSGP  0xA
>> 
>>  #define DBCR0_ICMP (1 << 27)
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index 1a3d9a7e57..bbc32ff114 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -816,3 +816,7 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
>> 
>>  DEF_HELPER_1(tbegin, void, env)
>>  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
>> +
>> +DEF_HELPER_1(clrbhrb, void, env)
>> +DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
>> +
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index 692d058665..45abe04f66 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -139,6 +139,17 @@ void helper_fscr_facility_check(CPUPPCState *env, 
>> uint32_t bit,
>>  #endif
>>  }
>> 
>> +static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t 
>> bit,
>> +                                 uint32_t sprn, uint32_t cause)
>> +{
>> +#ifdef TARGET_PPC64
>> +    if (FIELD_EX64(env->msr, MSR, PR) &&
>> +        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
>> +        raise_fu_exception(env, bit, sprn, cause, GETPC());
>> +    }
>> +#endif
>> +}
>> +
>>  void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
>>                                 uint32_t sprn, uint32_t cause)
>>  {
>> @@ -351,3 +362,35 @@ void helper_fixup_thrm(CPUPPCState *env)
>>          env->spr[i] = v;
>>      }
>>  }
>> +
>> +void helper_clrbhrb(CPUPPCState *env)
>> +{
>> +    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", 
>> FSCR_IC_BHRB);
>> +
>> +    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);
> 
> Repeating the comment about MMCR0_BHRBA and PPC_BIT_NR discrepancy here
> for posterity.
> 

Added NR suffix.

>> +
>> +    memset(env->bhrb, 0, sizeof(env->bhrb));
>> +}
>> +
>> +uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
>> +{
>> +    unsigned int index;
>> +
>> +    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", 
>> FSCR_IC_BHRB);
>> +
>> +    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);
>> +
>> +    if ((bhrbe >= env->bhrb_num_entries) ||
>> +       (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
> 
> Nitpick, but multi line statment starts again inside the first
> parenthesis after a keyword like this.
> 

Fixed.

>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Note: bhrb_offset is the byte offset for writing the
>> +     * next entry (over the oldest entry), which is why we
>> +     * must offset bhrbe by 1 to get to the 0th entry.
>> +     */
>> +    index = ((env->bhrb_offset / sizeof(uint64_t)) - (bhrbe + 1)) %
>> +            env->bhrb_num_entries;
>> +    return env->bhrb[index];
>> +}
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 7824475f54..b330871793 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -6549,12 +6549,25 @@ static void gen_brh(DisasContext *ctx)
>>  }
>>  #endif
>> 
>> +static void gen_clrbhrb(DisasContext *ctx)
>> +{
>> +    gen_helper_clrbhrb(cpu_env);
>> +}
>> +
>> +static void gen_mfbhrbe(DisasContext *ctx)
>> +{
>> +    TCGv_i32 bhrbe = tcg_constant_i32(_SPR(ctx->opcode));
>> +    gen_helper_mfbhrbe(cpu_gpr[rD(ctx->opcode)], cpu_env, bhrbe);
>> +}
>> +
>>  static opcode_t opcodes[] = {
>>  #if defined(TARGET_PPC64)
>>  GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, 
>> PPC2_ISA310),
>>  GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, 
>> PPC2_ISA310),
>>  GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, 
>> PPC2_ISA310),
>>  #endif
>> +GEN_HANDLER_E(clrbhrb, 0x1F, 0x0E, 0x0D, 0x3FFF801, PPC_NONE, 
>> PPC2_ISA207S),
>> +GEN_HANDLER_E(mfbhrbe, 0x1F, 0x0E, 0x09, 0x0000001, PPC_NONE, 
>> PPC2_ISA207S),
> 
> How much of a pain would it be to add it as decodetree? If there is an
> addition a family of existing instrutions here it makes sense to add it
> here, for new family would be nice to use decodetree.
> 
> I think they're only supported in 64-bit ISA so it could be ifdef
> TARGET_PPC64.
> 

Ok, switched to using decodetree.

> Thanks,
> Nick
> 

Thanks for the review!

Glenn

>>  GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
>>  #if defined(TARGET_PPC64)
>>  GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, 
>> PPC2_ISA300),

