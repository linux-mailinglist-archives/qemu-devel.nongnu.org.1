Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB6704817
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqJF-00026f-6d; Tue, 16 May 2023 04:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1pyqIt-000260-Je
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:45:08 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1pyqIp-0000If-Rx
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:45:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.56])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id C4B7220BFD;
 Tue, 16 May 2023 08:44:53 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 10:44:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0030a062745-1dc4-42f7-bc2a-3ad5cbe880ab,
 2678E99B74C30C5B30CC52F7B2AE97E44E35CB91) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5b7f36b4-99f5-cba5-9c16-fc03457137b5@kaod.org>
Date: Tue, 16 May 2023 10:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
CC: <qemu-devel@nongnu.org>, Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
References: <20230515160201.394587-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230515160201.394587-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: b3e3b827-18fb-4ba5-8f31-bf646a36887d
X-Ovh-Tracer-Id: 4793237379548482528
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuuddtteelgeejhfeikeegffekhfelvefgfeejveffjeeiveegfeehgfdtgfeitdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleelpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhhrghrshhhsehlihhnuhigrdhvnhgvthdrihgsmhdrtghomhdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/15/23 18:02, Nicholas Piggin wrote:
> POWER9 DD2.1 and earlier had significant limitations when running KVM,
> including lack of "mixed mode" MMU support (ability to run HPT and RPT
> mode on threads of the same core), and a translation prefetch issue
> which is worked around by disabling "AIL" mode for the guest.
> 
> These processors are not widely available, and it's difficult to deal
> with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> and make it the default POWER9 CPU.

I would remove power9_v1.0 and power9_v2.0 (not shipped AFAIK) and maybe
add power9_v2.3 since it has a little more features.

It can be done as a followup.

Thanks,

C.



> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
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


