Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C8704728
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pypY7-0007Ax-UV; Tue, 16 May 2023 03:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1pypXz-00078e-Sg; Tue, 16 May 2023 03:56:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1pypXw-0005ql-Jq; Tue, 16 May 2023 03:56:38 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G7qqxO006140; Tue, 16 May 2023 07:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=z0kVYTXBmA66VZV2Ep9Y9Tpvy+Ey+0XKI6ArtN9qMao=;
 b=pBEMm2NyjYxDFnKucAZYoZjC9cPTN7j9UYSQAvGVzFJs5SgJI/yGOVSDV5mR4M3xodYm
 8AZiLXchMZ5n4JD2DuXVMglpWqJdDzqMSNaxODA9TBvrjmBSmMCStaliKGh1S8Juo0r8
 nSg9P/NkrBhjWv7KqOLI+B3HRNZb5Koes2YyfmLR8eBK5BqJuvz3VAKyxnCCfpp9HnTZ
 QMHsORvMqJEW1SfJCp5wb6TwBfCy0N22kJqsUDHcF/H2DkO4t6TsWZoZP4kVu9S4Ypcf
 0I1FAFJkCUijDF3lu86dUDuMfn18hBjh/ECaTm+HXk/VKqp0/vOL1mf9hNKqFiNmtm58 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm5u4g32u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 07:56:34 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G7r6nX007044;
 Tue, 16 May 2023 07:56:33 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm5u4g323-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 07:56:33 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G4SblD021227;
 Tue, 16 May 2023 07:56:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qj264s838-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 07:56:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34G7uTYk17891988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 07:56:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 822C820040;
 Tue, 16 May 2023 07:56:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35C4D20043;
 Tue, 16 May 2023 07:56:29 +0000 (GMT)
Received: from [9.171.79.241] (unknown [9.171.79.241])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 May 2023 07:56:29 +0000 (GMT)
Message-ID: <efda933a-7a14-7157-887d-28137c872895@linux.ibm.com>
Date: Tue, 16 May 2023 09:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
References: <20230515160201.394587-1-npiggin@gmail.com>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230515160201.394587-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ywdUQLHWEQE9qjwRQWb4CdAhDdO8WemN
X-Proofpoint-GUID: N0sB-rTcUjZkGemIahc9JTYOT5kfSTmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 15/05/2023 18:02, Nicholas Piggin wrote:
> POWER9 DD2.1 and earlier had significant limitations when running KVM,
> including lack of "mixed mode" MMU support (ability to run HPT and RPT
> mode on threads of the same core), and a translation prefetch issue
> which is worked around by disabling "AIL" mode for the guest.
> 
> These processors are not widely available, and it's difficult to deal
> with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> and make it the default POWER9 CPU.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

Which makes me wonder if the P9 DD1 and P10 DD1 cpu definitions are 
worth keeping, since we don't really try emulating the differences and 
we don't support them in firmware/skiboot. The only place where we seem 
to bother is in target/ppc/kvm.c and that's precisely what this patch is 
trying to avoid.

   Fred


> This is unchanged since v3, just reposting.
> 
> Thanks,
> Nick
> 
>   hw/ppc/pnv.c                   |  2 +-
>   hw/ppc/pnv_core.c              |  2 +-
>   hw/ppc/spapr.c                 |  2 +-
>   hw/ppc/spapr_cpu_core.c        |  1 +
>   include/hw/ppc/pnv.h           |  2 +-
>   target/ppc/cpu-models.c        |  4 +++-
>   target/ppc/cpu-models.h        |  1 +
>   target/ppc/cpu_init.c          | 21 +++++++++++++++++++--
>   tests/qtest/device-plug-test.c |  4 ++--
>   9 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 11cb48af2f..590fc64b32 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2171,7 +2171,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>       };
>   
>       mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
>       xfc->match_nvt = pnv_match_nvt;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 410f31bdf8..0bc3ad41c8 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -348,7 +348,7 @@ static const TypeInfo pnv_core_infos[] = {
>       DEFINE_PNV_CORE_TYPE(power8, "power8e_v2.1"),
>       DEFINE_PNV_CORE_TYPE(power8, "power8_v2.0"),
>       DEFINE_PNV_CORE_TYPE(power8, "power8nvl_v1.0"),
> -    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.0"),
> +    DEFINE_PNV_CORE_TYPE(power9, "power9_v2.2"),
>       DEFINE_PNV_CORE_TYPE(power10, "power10_v2.0"),
>   };
>   
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ddc9c7b1a1..b58e69afd7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4631,7 +4631,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>   
>       smc->dr_lmb_enabled = true;
>       smc->update_dt_enabled = true;
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>       mc->has_hotpluggable_cpus = true;
>       mc->nvdimm_supported = true;
>       smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8a4861f45a..9b88dd549a 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -390,6 +390,7 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>       DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v1.0"),
>       DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
>   #ifdef CONFIG_KVM
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 409f3bf763..7e5fef7c43 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -48,7 +48,7 @@ DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8,
>   DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER8NVL,
>                            TYPE_PNV_CHIP_POWER8NVL)
>   
> -#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.0")
> +#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v2.2")
>   DECLARE_INSTANCE_CHECKER(PnvChip, PNV_CHIP_POWER9,
>                            TYPE_PNV_CHIP_POWER9)
>   
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 912b037c63..7dbb47de64 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -732,6 +732,8 @@
>                   "POWER9 v1.0")
>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")
> +    POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
> +                "POWER9 v2.2")
>       POWERPC_DEF("power10_v1.0",  CPU_POWERPC_POWER10_DD1,            POWER10,
>                   "POWER10 v1.0")
>       POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
> @@ -907,7 +909,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
>       { "power8e", "power8e_v2.1" },
>       { "power8", "power8_v2.0" },
>       { "power8nvl", "power8nvl_v1.0" },
> -    { "power9", "power9_v2.0" },
> +    { "power9", "power9_v2.2" },
>       { "power10", "power10_v2.0" },
>   #endif
>   
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index a77e036b3a..572b5e553a 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -350,6 +350,7 @@ enum {
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
>       CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
> +    CPU_POWERPC_POWER9_DD22        = 0x004E1202,
>       CPU_POWERPC_POWER10_BASE       = 0x00800000,
>       CPU_POWERPC_POWER10_DD1        = 0x00801100,
>       CPU_POWERPC_POWER10_DD20       = 0x00801200,
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 0ce2e3c91d..6775828dfc 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6284,9 +6284,26 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>           return false;
>       }
>   
> -    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
> -        /* Major DD version matches to power9_v1.0 and power9_v2.0 */
> +    if ((pvr & 0x0f00) != (pcc->pvr & 0x0f00)) {
> +        /* Major DD version does not match */
> +        return false;
> +    }
> +
> +    if ((pvr & 0x0f00) == 0x100) {
> +        /* DD1.x always matches power9_v1.0 */
>           return true;
> +    } else if ((pvr & 0x0f00) == 0x200) {
> +        if ((pvr & 0xf) < 2) {
> +            /* DD2.0, DD2.1 match power9_v2.0 */
> +            if ((pcc->pvr & 0xf) == 0) {
> +                return true;
> +            }
> +        } else {
> +            /* DD2.2, DD2.3 match power9_v2.2 */
> +            if ((pcc->pvr & 0xf) == 2) {
> +                return true;
> +            }
> +        }
>       }
>   
>       return false;
> diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
> index 01cecd6e20..165ca13f8c 100644
> --- a/tests/qtest/device-plug-test.c
> +++ b/tests/qtest/device-plug-test.c
> @@ -168,8 +168,8 @@ static void test_spapr_cpu_unplug_request(void)
>   {
>       QTestState *qtest;
>   
> -    qtest = qtest_initf("-cpu power9_v2.0 -smp 1,maxcpus=2 "
> -                        "-device power9_v2.0-spapr-cpu-core,core-id=1,id=dev0");
> +    qtest = qtest_initf("-cpu power9_v2.2 -smp 1,maxcpus=2 "
> +                        "-device power9_v2.2-spapr-cpu-core,core-id=1,id=dev0");
>   
>       /* similar to test_pci_unplug_request */
>       process_device_remove(qtest, "dev0");

