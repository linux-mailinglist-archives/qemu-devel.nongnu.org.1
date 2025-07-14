Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 704EFB03AFC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 11:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFcg-0006FG-Nf; Mon, 14 Jul 2025 05:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ubFcN-0005lT-P5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:37:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ubFcL-0004sD-3Y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:37:03 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxHHK4z3RosCYpAQ--.20158S3;
 Mon, 14 Jul 2025 17:36:56 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxT+a2z3Ro76MWAA--.58185S3;
 Mon, 14 Jul 2025 17:36:56 +0800 (CST)
Subject: Re: [PATCH v5 05/11] target/loongarch: add msg interrupt CSR registers
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250711085915.3042395-1-gaosong@loongson.cn>
 <20250711085915.3042395-6-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <dc73c6e3-40a7-e7a3-8e43-a8ec036c30c6@loongson.cn>
Date: Mon, 14 Jul 2025 17:35:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250711085915.3042395-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+a2z3Ro76MWAA--.58185S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1UtF1DZFyUtw45Cr4kAFc_yoWrJryUpr
 sxAFyUKFW8trWSv3WfJ345XFsxWr1xGw429a12kryxKFW5Gr40grykt39FvF1rJa4Fgr10
 9F18A34UCF47Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.992,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/7/11 下午4:59, Song Gao wrote:
> include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h |  3 +++
>   target/loongarch/cpu.h     | 10 ++++++++++
>   target/loongarch/machine.c | 27 +++++++++++++++++++++++++--
>   3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 0834e91f30..4792677086 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -186,6 +186,9 @@ FIELD(CSR_MERRCTL, ISMERR, 0, 1)
>   
>   #define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
>   
> +#define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
> +#define LOONGARCH_CSR_MSGIR               0xa4
> +
>   /* Direct map windows CSRs*/
>   #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
>   FIELD(CSR_DMW, PLV0, 0, 1)
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 56fc4a1459..208d3e0cd3 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -233,6 +233,12 @@ FIELD(TLB_MISC, ASID, 1, 10)
>   FIELD(TLB_MISC, VPPN, 13, 35)
>   FIELD(TLB_MISC, PS, 48, 6)
>   
> +/*Msg interrupt registers */
> +FIELD(CSR_MSGIS, IS, 0, 63)
> +FIELD(CSR_MSGIR, INTNUM, 0, 8)
> +FIELD(CSR_MSGIR, ACTIVE, 31, 1)
> +FIELD(CSR_MSGIE, PT, 0, 8)
> +
>   #define LSX_LEN    (128)
>   #define LASX_LEN   (256)
>   
> @@ -350,6 +356,10 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    /* Msg interrupt registers */
> +    uint64_t CSR_MSGIS[4];
It will better if there is macro replaced with 4.

> +    uint64_t CSR_MSGIR;
> +    uint64_t CSR_MSGIE;
>       struct {
>           uint64_t guest_addr;
>       } stealtime;
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4e70f5c879..9eddb9341a 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -10,6 +10,7 @@
>   #include "migration/cpu.h"
>   #include "system/tcg.h"
>   #include "vec.h"
> +#include "hw/loongarch/virt.h"
>   
>   static const VMStateDescription vmstate_fpu_reg = {
>       .name = "fpu_reg",
> @@ -45,6 +46,27 @@ static const VMStateDescription vmstate_fpu = {
>       },
>   };
>   
> +static bool msg_needed(void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> +
> +    return !!(lvms->misc_feature & BIT(IOCSRF_AVEC));
how about use virt_has_avecintc() like this?
    return virt_has_avecintc(lvms);

> +}
> +
> +static const VMStateDescription vmstate_msg = {
> +    .name = "cpu/msg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = msg_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, 4),
ditto, it will be better if there is macro replaced with 4.

Regards
Bibo Mao
> +        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
> +        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>   static const VMStateDescription vmstate_lsxh_reg = {
>       .name = "lsxh_reg",
>       .version_id = 1,
> @@ -168,8 +190,8 @@ static const VMStateDescription vmstate_tlb = {
>   /* LoongArch CPU state */
>   const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
> @@ -245,6 +267,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           &vmstate_tlb,
>   #endif
>           &vmstate_lbt,
> +        &vmstate_msg,
>           NULL
>       }
>   };
> 


