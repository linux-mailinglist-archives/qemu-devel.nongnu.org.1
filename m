Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48A8D459A
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 08:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZai-0006Zg-AD; Thu, 30 May 2024 02:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCZag-0006ZM-An; Thu, 30 May 2024 02:48:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCZae-0000eG-BS; Thu, 30 May 2024 02:48:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U5bpnf015999; Thu, 30 May 2024 06:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Mph1A20fMpwguKywTQRxA796gJfL9+EhHf6J8ynNPWg=;
 b=Epsv6GtiBpY6sj1TKBpSkX+74LDlwn4LXPwi/piBunrwt3Ldy8q3jTYM9zgrTAXZkGsg
 FaEHSzpVKgwu+k8Gd/s4Upc0rDPJoNN4mNMOR3wisIS0ebwTFdVqOOOH45peOC5fUrzO
 eF3cwOJmIGXeDl7Pj/ifmTi2uQIv1bqxpkJR+6ih+mIZweDxKOk6tD2sUT5AjeGX2IGn
 VDpHnxl8QAg+vYkhgcmv/cS0KAdm0g890wh+hRttGWn8+Ybb73cFSe8s7jd08LGrkBHN
 Q73SGnUqzYM1NVfinJasF0xNb2djWvczXf2EApuHOhOYQnUbZRfkA156PAPE4A3X3E38 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yekfkr5wu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:48:35 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U6mZds031738;
 Thu, 30 May 2024 06:48:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yekfkr5ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:48:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U4rdDl006891; Thu, 30 May 2024 06:48:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpebgeaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 06:48:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U6mSuE31588998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 06:48:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 581CA20040;
 Thu, 30 May 2024 06:48:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19E0B20043;
 Thu, 30 May 2024 06:48:26 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 May 2024 06:48:25 +0000 (GMT)
Date: Thu, 30 May 2024 12:18:23 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v4 01/11] ppc: Add Power11 DD2.0 processor
Message-ID: <wo6qqkz7l4bxp7ptfvpkesbh2aaczg34rc5yjqfqelhn7lytkk@zel2rh5avpwl>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-2-adityag@linux.ibm.com>
 <f222585b-dda9-4828-8f71-3aee3f2c6d7b@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f222585b-dda9-4828-8f71-3aee3f2c6d7b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cVjKn3fNtyLS0Dif2X9Vn3LcZ8gvBW4r
X-Proofpoint-GUID: p7UYlqkbcrs5LN5FlyB2osPlFHOJnDbJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_04,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Harsh,

On Thu, May 30, 2024 at 10:57:31AM GMT, Harsh Prateek Bora wrote:
> Hi Aditya,
> 
> On 5/28/24 12:35, Aditya Gupta wrote:
> > Add CPU target code to add support for new Power11 Processor.
> > 
> > Power11 core is same as Power10, hence reuse functions defined for
> > Power10.
> > 
> > Cc: C�dric Le Goater <clg@kaod.org>
> > Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
> > Cc: Fr�d�ric Barrat <fbarrat@linux.ibm.com>
> > Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   target/ppc/compat.c     |   7 +++
> >   target/ppc/cpu-models.c |   3 ++
> >   target/ppc/cpu-models.h |   3 ++
> >   target/ppc/cpu_init.c   | 102 ++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 115 insertions(+)
> > 
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index ebef2cccecf3..12dd8ae290ca 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
> >           .pcr_level = PCR_COMPAT_3_10,
> >           .max_vthreads = 8,
> >       },
> > +    { /* POWER11, ISA3.10 */
> > +        .name = "power11",
> > +        .pvr = CPU_POWERPC_LOGICAL_3_10_PLUS,
> > +        .pcr = PCR_COMPAT_3_10,
> > +        .pcr_level = PCR_COMPAT_3_10,
> > +        .max_vthreads = 8,
> > +    },
> >   };
> >   static const CompatInfo *compat_by_pvr(uint32_t pvr)
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index f2301b43f78b..ece348178188 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -734,6 +734,8 @@
> >                   "POWER9 v2.2")
> >       POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
> >                   "POWER10 v2.0")
> > +    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POWER11,
> > +                "POWER11_v2.0")
> >   #endif /* defined (TARGET_PPC64) */
> >   /***************************************************************************/
> > @@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
> >       { "power8nvl", "power8nvl_v1.0" },
> >       { "power9", "power9_v2.2" },
> >       { "power10", "power10_v2.0" },
> > +    { "power11", "power11_v2.0" },
> >   #endif
> >       /* Generic PowerPCs */
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index 0229ef3a9a5c..ef74e387b047 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -354,6 +354,8 @@ enum {
> >       CPU_POWERPC_POWER10_BASE       = 0x00800000,
> >       CPU_POWERPC_POWER10_DD1        = 0x00801100,
> >       CPU_POWERPC_POWER10_DD20       = 0x00801200,
> > +    CPU_POWERPC_POWER11_BASE       = 0x00820000,
> > +    CPU_POWERPC_POWER11_DD20       = 0x00821200,
> >       CPU_POWERPC_970_v22            = 0x00390202,
> >       CPU_POWERPC_970FX_v10          = 0x00391100,
> >       CPU_POWERPC_970FX_v20          = 0x003C0200,
> > @@ -391,6 +393,7 @@ enum {
> >       CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
> >       CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
> >       CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
> > +    CPU_POWERPC_LOGICAL_3_10_PLUS  = 0x0F000007,
> >   };
> >   /* System version register (used on MPC 8xxx)                                */
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 01e358a4a5ac..82d700382cdd 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6763,6 +6763,108 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
> >       pcc->l1_icache_size = 0x8000;
> >   }
> > +static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
> > +{
> > +    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
> > +    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
> > +
> > +    if (!best && (base == CPU_POWERPC_POWER11_BASE)) {
> > +        return true;
> > +    }
> > +
> > +    if (base != pcc_base) {
> > +        return false;
> > +    }
> > +
> > +    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > +    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> > +
> > +    dc->fw_name = "PowerPC,POWER11";
> > +    dc->desc = "POWER11";
> > +    pcc->pvr_match = ppc_pvr_match_power11;
> > +    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
> > +                    PCR_COMPAT_3_00;
> > +    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
> > +                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> > +    pcc->init_proc = init_proc_POWER10;
> > +    pcc->check_pow = check_pow_nocheck;
> > +    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
> > +                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
> > +                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> > +                       PPC_FLOAT_FRSQRTES |
> > +                       PPC_FLOAT_STFIWX |
> > +                       PPC_FLOAT_EXT |
> > +                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
> > +                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
> > +                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
> > +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
> > +                       PPC_SEGMENT_64B | PPC_SLBI |
> > +                       PPC_POPCNTB | PPC_POPCNTWD |
> > +                       PPC_CILDST;
> > +    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
> > +                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
> > +                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> > +                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> > +                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> > +                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> > +                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
> > +                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
> > +    pcc->msr_mask = (1ull << MSR_SF) |
> > +                    (1ull << MSR_HV) |
> > +                    (1ull << MSR_TM) |
> > +                    (1ull << MSR_VR) |
> > +                    (1ull << MSR_VSX) |
> > +                    (1ull << MSR_EE) |
> > +                    (1ull << MSR_PR) |
> > +                    (1ull << MSR_FP) |
> > +                    (1ull << MSR_ME) |
> > +                    (1ull << MSR_FE0) |
> > +                    (1ull << MSR_SE) |
> > +                    (1ull << MSR_DE) |
> > +                    (1ull << MSR_FE1) |
> > +                    (1ull << MSR_IR) |
> > +                    (1ull << MSR_DR) |
> > +                    (1ull << MSR_PMM) |
> > +                    (1ull << MSR_RI) |
> > +                    (1ull << MSR_LE);
> > +    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
> > +        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
> > +        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
> > +        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
> > +                             LPCR_DEE | LPCR_OEE))
> > +        | LPCR_MER | LPCR_GTSE | LPCR_TC |
> > +        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
> > +    /* DD2 adds an extra HAIL bit */
> > +    pcc->lpcr_mask |= LPCR_HAIL;
> > +
> 
> I had posted a patch to get rid of this growing code duplication here:
> https://lore.kernel.org/qemu-devel/20240523051412.226970-8-harshpb@linux.ibm.com/
> 
> Would you mind considering the relevant patches to rebase your changes?

I will check it out. Thanks Harsh.

- Aditya Gupta

> 
> regards,
> Harsh
> 
> > +    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
> > +    pcc->mmu_model = POWERPC_MMU_3_00;
> > +#if !defined(CONFIG_USER_ONLY)
> > +    /* segment page size remain the same */
> > +    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
> > +    pcc->radix_page_info = &POWER10_radix_page_info;
> > +    pcc->lrg_decr_bits = 56;
> > +#endif
> > +    pcc->excp_model = POWERPC_EXCP_POWER10;
> > +    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
> > +    pcc->bfd_mach = bfd_mach_ppc64;
> > +    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
> > +                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
> > +                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> > +                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
> > +    pcc->l1_dcache_size = 0x8000;
> > +    pcc->l1_icache_size = 0x8000;
> > +}
> > +
> >   #if !defined(CONFIG_USER_ONLY)
> >   void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
> >   {

