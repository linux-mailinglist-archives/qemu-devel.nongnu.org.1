Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B24BECDD2
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 12:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA4aj-0000VE-3M; Sat, 18 Oct 2025 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA4ag-0000Pq-0c; Sat, 18 Oct 2025 06:55:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA4ac-00080K-Gq; Sat, 18 Oct 2025 06:55:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I3WWaY030272;
 Sat, 18 Oct 2025 10:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MFJndc
 a5cCA95JLyHFhgaZ3+dnYsIENhR/nw04aECME=; b=c7JYfmV+E/iZty2Y1kgUvT
 nCOxBHcCiJVF/u7FnG27Z5mpZaftE2b64lML6GTu7R8an24rbDQQhTHwKjLsWrX7
 NKZI8+LEsOg7LioNZ8dxT5Aof1xXVo+bD0Qn73tMp+8nup84rVGeCdjUAH+Kpfoq
 RWd7wb9JnsE8mwRdtvCYWX+NpJYEncnm5UaBOm36w7OTCBnZC7W/Vc7dTsCF9ihF
 XV/26xjkscEzpVLofo/XM8R8i7gG8LEoaDUUhXzY7eTDV+i3l7m5GyO0GuNKNWv1
 cw/C7JxKtdEeoZeM6qszJmEROWm+Kp37v+t0uc+ALYfbByGKWAC3g1O1RUOYT6Lw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h12at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 10:55:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59IAt6h1029826;
 Sat, 18 Oct 2025 10:55:06 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h12ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 10:55:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59I7KaXl015190;
 Sat, 18 Oct 2025 10:55:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jssx0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 10:55:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59IAt1mO7602582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 10:55:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FF0E20043;
 Sat, 18 Oct 2025 10:55:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7309120040;
 Sat, 18 Oct 2025 10:54:59 +0000 (GMT)
Received: from [9.39.28.54] (unknown [9.39.28.54])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 10:54:59 +0000 (GMT)
Message-ID: <6a6f9e93-c824-4c6a-a24f-9b6e5f0d9cee@linux.ibm.com>
Date: Sat, 18 Oct 2025 16:24:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] hw/ppc: Implement saving CPU state in Fadump
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-6-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-6-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/OQitjkZpieI
 e17s2BqFgKxnMnKdJnTDqfrNYHrIkx3/c8H6wyGTqnQdr3qpWEc6/PIWrw8G8PNLUV0G7qCl5e0
 4MDN8jTqgJNc2RgANWcZqn/UAMHqVn/2/KvSH1lnQkkOS17srwZ15r55HQefFR9jaqO1NmWIxri
 z60kmu9T7qiJM0IzVPWgk7CEeIXc6xHAuoYV+lqbfbSBS/L+OZ+hD9X5BwAEhQCmS1v/7svP2iL
 +W0iB53+C5JmDYz2KZrnBst0nXATgQ/ptuvi8HGye6MsJy6gqjUXazRXJQ7LX6SqbnV+v3YBtL1
 Trko7VEiNIs8/cVd/CAgJh4VQlUU4obbh1JcK1TJaP0YrjULUPJwT+7nRCa6ThLw5Kjabf+1FUT
 ZTNdMYMxJWT9UPQCiMSyQEw0zpmrbQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f3720a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=4eW5D8OtxJjTOOaoBxwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DvcthSO2UgKJukbdgBfz_Pr9L-Wc2S_k
X-Proofpoint-ORIG-GUID: 0tk_pRqNthoyJKwFTLv20pdiJ7NSd3R0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 23/03/25 23:10, Aditya Gupta wrote:
> Kernel expects CPU states/register states in the format mentioned in
> "Register Save Area" in PAPR.
>
> The platform (in our case, QEMU) saves each CPU register in the form of
> an array of "register entries", the start and end of this array is
> signified by "CPUSTRT" and "CPUEND" register entries respectively.
>
> The CPUSTRT and CPUEND register entry also has 4-byte logical CPU ID,
> thus storing the CPU ID corresponding to the array of register entries.
>
> Each register, and CPUSTRT, CPUEND has a predefined identifier.
> Implement calculating identifier for a given register in
> 'fadump_str_to_u64', which has been taken from the linux kernel
>
> Similarly GPRs also have predefined identifiers, and a corresponding
> 64-bit resiter value (split into two 32-bit cells). Implement
> calculation of GPR identifiers with 'fadump_gpr_id_to_u64'
>
> PAPR has restrictions on particular order of few registers, and is
> free to be in any order for other registers.
> Some registers mentioned in PAPR have not been exported as they are not
> implemented in QEMU / don't make sense in QEMU.
>
> Implement saving of CPU state according to the PAPR document
>
> Note: As of this patch, the "kernel-dump" device tree entry is still not
> added for the second boot, so after crash, the second kernel will boot
> assuming fadump dump is "NOT" active, and try to register for fadump,
> but since we already have fadump registered in QEMU internal state, the
> register rtas call will fail with: "DUMP ACTIVE"
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr_fadump.c         | 336 +++++++++++++++++++++++++++++++++-
>   include/hw/ppc/spapr_fadump.h |  28 +++
>   2 files changed, 363 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index c105b8d21da5..fc764b46e726 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -8,6 +8,71 @@
>   #include "qemu/log.h"
>   #include "hw/ppc/spapr.h"
>   #include "system/cpus.h"
> +#include "system/hw_accel.h"
> +
> +/*
> + * Copy the ascii values for first 8 characters from a string into u64
> + * variable at their respective indexes.
> + * e.g.
> + *  The string "FADMPINF" will be converted into 0x4641444d50494e46
> + */
> +static uint64_t fadump_str_to_u64(const char *str)
> +{
> +    uint64_t val = 0;
> +    int i;
> +
> +    for (i = 0; i < sizeof(val); i++) {
> +        val = (*str) ? (val << 8) | *str++ : val << 8;
> +    }
> +    return val;
> +}
> +
> +/**
> + * Get the identifier id for register entries of GPRs
> + *
> + * It gives the same id as 'fadump_str_to_u64' when the complete string id
> + * of the GPR is given, ie.
> + *
> + *   fadump_str_to_u64("GPR05") == fadump_gpr_id_to_u64(5);
> + *   fadump_str_to_u64("GPR12") == fadump_gpr_id_to_u64(12);
> + *
> + * And so on. Hence this can be implemented by creating a dynamic
> + * string for each GPR, such as "GPR00", "GPR01", ... "GPR31"
> + * Instead of allocating a string, an observation from the math of
> + * 'fadump_str_to_u64' or from PAPR tells us that there's a pattern
> + * in the identifier IDs, such that the first 4 bytes are affected only by
> + * whether it is GPR0*, GPR1*, GPR2*, GPR3*.
> + * Upper half of 5th byte is always 0x3. Lower half (nibble) of 5th byte
> + * is the tens digit of the GPR id, ie. GPR ID / 10.
> + * Upper half of 6th byte is always 0x3. Lower half (nibble) of 5th byte
> + * is the ones digit of the GPR id, ie. GPR ID % 10
> + *
> + * For example, for GPR 29, the 5th and 6th byte will be 0x32 and 0x39
> + */
> +static uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
> +{
> +    uint64_t val = 0;
> +
> +    /* Valid range of GPR id is only GPR0 to GPR31 */
> +    assert(gpr_id < 32);
> +
> +    /* Below calculations set the 0th to 5th byte */
> +    if (gpr_id <= 9) {
> +        val = fadump_str_to_u64("GPR0");
> +    } else if (gpr_id <= 19) {
> +        val = fadump_str_to_u64("GPR1");
> +    } else if (gpr_id <= 29) {
> +        val = fadump_str_to_u64("GPR2");
> +    } else {
> +        val = fadump_str_to_u64("GPR3");
> +    }
> +
> +    /* Set the 6th byte */
> +    val |= 0x30000000;
> +    val |= ((gpr_id % 10) << 24);
> +
> +    return val;
> +}
>   
>   /*
>    * Handle the "FADUMP_CMD_REGISTER" command in 'ibm,configure-kernel-dump'
> @@ -221,14 +286,221 @@ static bool do_preserve_region(FadumpSection *region)
>       return true;
>   }
>   
> +/*
> + * Populate the passed CPUs register entries, in the buffer starting at
> + * the argument 'curr_reg_entry'
> + *
> + * The register entries is an array of pair of register id and register
> + * value, as described in Table 591/592 in section "H.1 Register Save Area"
> + * in PAPR v2.13
> + *
> + * Returns pointer just past this CPU's register entries, which can be used
> + * as the start address for next CPU's register entries
> + */
> +static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
> +        FadumpRegEntry *curr_reg_entry)
> +{
> +    CPUPPCState *env;
> +    PowerPCCPU *ppc_cpu;
> +    uint32_t num_regs_per_cpu = 0;
> +
> +    ppc_cpu = POWERPC_CPU(cpu);
> +    env = cpu_env(cpu);
> +    num_regs_per_cpu = 0;
> +
> +    curr_reg_entry->reg_id =
> +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> +    curr_reg_entry->reg_value = ppc_cpu->vcpu_id;

Aren't we suppose to store CPU ID in big endian?
As per PAPR the format CPUSTRT and CPUEND node is

8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical CPU 
ID (BE)

It feels like storing vcpu_id as little endian may not get the
reg entrie for CPUSTRT in above format, isn't it?

Ideally we should have two struct to mange two types of Reg Entries.
That way we can manage reserved bytes in CPUSTRT/CPUEND node
easily. I understand that it will bring unnecessary complexity in
populate_cpu_state_data function. So how about adding a note for
future reference?

> +    ++curr_reg_entry;
> +
> +#define REG_ENTRY(id, val)                             \
> +    do {                                               \
> +        curr_reg_entry->reg_id =                       \
> +            cpu_to_be64(fadump_str_to_u64(#id));       \
> +        curr_reg_entry->reg_value = cpu_to_be64(val);  \
> +        ++curr_reg_entry;                              \
> +        ++num_regs_per_cpu;                            \
> +    } while (0)
> +
> +    REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
> +    REG_ENTRY(AMR, env->spr[SPR_AMR]);
> +    REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
> +    REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
> +    REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
> +
> +    /* Save the condition register */
> +    REG_ENTRY(CR, ppc_get_cr(env));
> +
> +    REG_ENTRY(CTR, env->spr[SPR_CTR]);
> +    REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
> +    REG_ENTRY(DABR, env->spr[SPR_DABR]);
> +    REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
> +    REG_ENTRY(DAR, env->spr[SPR_DAR]);
> +    REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
> +    REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
> +    REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
> +    REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
> +    REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
> +    REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
> +    REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
> +    REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
> +    REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
> +
> +    REG_ENTRY(FPSCR, env->fpscr);
> +    REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
> +
> +    /* Save the GPRs */
> +    for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
> +        curr_reg_entry->reg_id =
> +            cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
> +        curr_reg_entry->reg_value =
> +            cpu_to_be64(env->gpr[gpr_id]);
> +        ++curr_reg_entry;
> +        ++num_regs_per_cpu;
> +    }
> +
> +    REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
> +    REG_ENTRY(IC, env->spr[SPR_IC]);
> +    REG_ENTRY(LR, env->spr[SPR_LR]);
> +
> +    REG_ENTRY(MSR, env->msr);
> +    REG_ENTRY(NIA, env->nip);   /* NIA */
> +    REG_ENTRY(PIR, env->spr[SPR_PIR]);
> +    REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
> +    REG_ENTRY(PVR, env->spr[SPR_PVR]);
> +    REG_ENTRY(RPR, env->spr[SPR_RPR]);
> +    REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
> +    REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
> +    REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
> +    REG_ENTRY(TAR, env->spr[SPR_TAR]);
> +    REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
> +    REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
> +    REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
> +    REG_ENTRY(TIR, env->spr[SPR_TIR]);
> +    REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
> +    REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
> +    REG_ENTRY(VSCR, env->vscr);
> +    REG_ENTRY(VTB, env->spr[SPR_VTB]);
> +    REG_ENTRY(WORT, env->spr[SPR_WORT]);
> +    REG_ENTRY(XER, env->spr[SPR_XER]);
> +
> +    /*
> +     * Ignoring transaction checkpoint and few other registers
> +     * mentioned in PAPR as not supported in QEMU
> +     */
> +#undef REG_ENTRY
> +
> +    /* End the registers for this CPU with "CPUEND" reg entry */
> +    curr_reg_entry->reg_id =
> +        cpu_to_be64(fadump_str_to_u64("CPUEND"));

CPU ID as value to CPUEND reg entry needed, right?

> +
> +    /*
> +     * Ensure the number of registers match (+2 for STRT & END)
> +     *
> +     * This will help catch an error if in future a new register entry
> +     * is added/removed while not modifying FADUMP_NUM_PER_CPU_REGS
> +     */
> +    assert(FADUMP_NUM_PER_CPU_REGS == num_regs_per_cpu + 2 /*CPUSTRT+CPUEND*/);
> +
> +    ++curr_reg_entry;
> +
> +    return curr_reg_entry;
> +}
> +
> +/*
> + * Populate the "Register Save Area"/CPU State as mentioned in section "H.1
> + * Register Save Area" in PAPR v2.13
> + *
> + * It allocates the buffer for this region, then populates the register
> + * entries
> + *
> + * Returns the pointer to the buffer (which should be deallocated by the
> + * callers), and sets the size of this buffer in the argument
> + * 'cpu_state_len'
> + */
> +static void *populate_cpu_state_data(uint64_t *cpu_state_len)
> +{
> +    FadumpRegSaveAreaHeader reg_save_hdr;
> +    FadumpRegEntry *reg_entries;
> +    FadumpRegEntry *curr_reg_entry;
> +    CPUState *cpu;
> +
> +    uint32_t num_reg_entries;
> +    uint32_t reg_entries_size;
> +    uint32_t num_cpus = 0;
> +
> +    void *cpu_state_buffer = NULL;
> +    uint64_t offset = 0;
> +
> +    CPU_FOREACH(cpu) {
> +        ++num_cpus;
> +    }
> +
> +    reg_save_hdr.version = cpu_to_be32(0);
> +    reg_save_hdr.magic_number =
> +        cpu_to_be64(fadump_str_to_u64("REGSAVE"));
> +
> +    /* Reg save area header is immediately followed by num cpus */
> +    reg_save_hdr.num_cpu_offset =
> +        cpu_to_be32(sizeof(FadumpRegSaveAreaHeader));
> +
> +    num_reg_entries = num_cpus * FADUMP_NUM_PER_CPU_REGS;
> +    reg_entries_size = num_reg_entries * sizeof(FadumpRegEntry);
> +
> +    reg_entries = g_new(FadumpRegEntry, num_reg_entries);
> +
> +    /* Pointer to current CPU's registers */
> +    curr_reg_entry = reg_entries;
> +
> +    /* Populate register entries for all CPUs */
> +    CPU_FOREACH(cpu) {
> +        cpu_synchronize_state(cpu);
> +        curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
> +    }
> +
> +    *cpu_state_len = 0;
> +    *cpu_state_len += sizeof(reg_save_hdr);     /* reg save header */
> +    *cpu_state_len += 0xc;                      /* padding as in PAPR */
> +    *cpu_state_len += sizeof(__be32);           /* num_cpus */
> +    *cpu_state_len += reg_entries_size;         /* reg entries */
> +
> +    cpu_state_buffer = g_malloc(*cpu_state_len);
> +
> +    memcpy(cpu_state_buffer + offset,
> +            &reg_save_hdr, sizeof(reg_save_hdr));
> +    offset += sizeof(reg_save_hdr);
> +
> +    /* Write num_cpus */
> +    num_cpus = cpu_to_be32(num_cpus);
> +    memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32));
> +    offset += sizeof(__be32);
> +
> +    /* Write the register entries */
> +    memcpy(cpu_state_buffer + offset, reg_entries, reg_entries_size);
> +    offset += reg_entries_size;
> +
> +    return cpu_state_buffer;
> +}
> +
>   /* Preserve the memory locations registered for fadump */
>   static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   {
>       FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    FadumpSection *cpu_state_region = NULL;
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
>       uint16_t dump_num_sections, data_type;
> +    uint64_t dest_addr;
> +    uint64_t cpu_state_addr, cpu_state_len = 0;
> +    g_autofree void *cpu_state_buffer = NULL;
>   
>       assert(spapr->fadump_registered);
>   
> +    /* Mark the memory transaction as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
>       /*
>        * Handle all sections
>        *
> @@ -241,6 +513,7 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
>       dump_num_sections = be16_to_cpu(fdm->header.dump_num_sections);
>       for (int i = 0; i < dump_num_sections; ++i) {
>           data_type = be16_to_cpu(fdm->rgn[i].source_data_type);
> +        dest_addr = be64_to_cpu(fdm->rgn[i].destination_address);
>   
>           /* Reset error_flags & bytes_dumped for now */
>           fdm->rgn[i].error_flags = 0;
> @@ -255,7 +528,15 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   
>           switch (data_type) {
>           case FADUMP_CPU_STATE_DATA:
> -            /* TODO: Add CPU state data */
> +            cpu_state_region = &fdm->rgn[i];
> +            cpu_state_addr    = dest_addr;
> +            cpu_state_buffer  = populate_cpu_state_data(&cpu_state_len);
> +
> +            /*
> +             * We will write the cpu state data later, as otherwise it
> +             * might get overwritten by other fadump regions

Isn't the destination address of cpu state data and RMR region are 
different?

I don't understand the above comment. Can you please give more details.

> +             */
> +
>               break;
>           case FADUMP_HPTE_REGION:
>               /* TODO: Add hpte state data */
> @@ -281,6 +562,59 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
>           }
>       }
>   
> +    /* CPU State Region has not been requested by kernel */
> +    if (!cpu_state_region) {
> +        return true;
> +    }
> +
> +    /*
> +     * Write the Register Save Area
> +     *
> +     * CPU State/Register Save Area should be written after dumping the
> +     * memory to prevent overwriting while saving other memory regions
> +     *
> +     * eg. If boot memory region is 1G, then both the first 1GB memory, and
> +     * the Register Save Area needs to be saved at 1GB.

Every region is copied to their destination address and as per below 
kernel function:
https://github.com/torvalds/linux/blob/f406055cb18c6e299c4a783fc1effeb16be41803/arch/powerpc/platforms/pseries/rtas-fadump.c#L98

the destination address shouldn't  be same for fadump region then how 
come there
is overwrite scenario? Am I missing something?

> +     * And as the CPU_STATE_DATA region comes first than the
> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
> +     * overwritten if saved before the 0GB - 1GB region is copied after
> +     * saving CPU state data
> +     */
> +    io_result = address_space_write(default_as, cpu_state_addr, attrs,
> +            cpu_state_buffer, cpu_state_len);

Hope cpu_state_buffer will be freed automatically...

> +    if ((io_result & MEMTX_DECODE_ERROR) ||
> +        (io_result & MEMTX_ACCESS_ERROR)) {
> +        /*
> +         * Invalid destination address is not an hardware error, instead
> +         * wrong parameter from the kernel.
> +         * Return true to let caller know to continue reading other
> +         * sections
> +         */
> +        cpu_state_region->error_flags = FADUMP_ERROR_INVALID_DEST_ADDR;
> +        cpu_state_region->bytes_dumped = 0;
> +        return true;
> +    } else if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Failed to write CPU state region\n");
> +        cpu_state_region->bytes_dumped = 0;
> +
> +        return false;
> +    }
> +
> +    /*
> +     * Set bytes_dumped in cpu state region, so kernel knows platform have
> +     * exported it
> +     */
> +    cpu_state_region->bytes_dumped = cpu_to_be64(cpu_state_len);
> +
> +    if (cpu_state_region->source_len != cpu_state_region->bytes_dumped) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "CPU State region's length passed by kernel (0x%lx) !="
> +                " CPU State region's length exported by QEMU (0x%lx)\n",
> +                be64_to_cpu(cpu_state_region->source_len),
> +                be64_to_cpu(cpu_state_region->bytes_dumped));
> +    }
> +
>       return true;
>   }
>   
> diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
> index d56ca1d6d651..13bdd39a9ec1 100644
> --- a/include/hw/ppc/spapr_fadump.h
> +++ b/include/hw/ppc/spapr_fadump.h
> @@ -48,9 +48,14 @@
>   #define FADUMP_MAX_SECTIONS            10
>   #define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
>   
> +/* Number of registers stored per cpu */
> +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)

#nit-pick
How about FADUMP_PER_CPU_REG_ENTRY ?


> +
>   typedef struct FadumpSection FadumpSection;
>   typedef struct FadumpSectionHeader FadumpSectionHeader;
>   typedef struct FadumpMemStruct FadumpMemStruct;
> +typedef struct FadumpRegSaveAreaHeader FadumpRegSaveAreaHeader;
> +typedef struct FadumpRegEntry FadumpRegEntry;
>   
>   struct SpaprMachineState;
>   
> @@ -88,6 +93,29 @@ struct FadumpMemStruct {
>       FadumpSection       rgn[FADUMP_MAX_SECTIONS];
>   };
>   
> +/*
> + * The firmware-assisted dump format.
> + *
> + * The register save area is an area in the partition's memory used to preserve
> + * the register contents (CPU state data) for the active CPUs during a firmware
> + * assisted dump. The dump format contains register save area header followed
> + * by register entries. Each list of registers for a CPU starts with "CPUSTRT"
> + * and ends with "CPUEND".
> + */
> +
> +/* Register save area header. */
> +struct FadumpRegSaveAreaHeader {
> +    __be64    magic_number;
> +    __be32    version;
> +    __be32    num_cpu_offset;
> +};
> +
> +/* Register entry. */
> +struct FadumpRegEntry {
> +    __be64    reg_id;
> +    __be64    reg_value;
> +};
> +
>   uint32_t do_fadump_register(struct SpaprMachineState *, target_ulong);
>   void     trigger_fadump_boot(struct SpaprMachineState *, target_ulong);
>   #endif /* PPC_SPAPR_FADUMP_H */


