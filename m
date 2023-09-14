Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAE7A01AB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:28:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjaS-0001xl-I0; Thu, 14 Sep 2023 06:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjaL-0001xP-OD
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:28:35 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjaI-0003U6-Di
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xam6hF4irrnMOZzdVpp2Jq0TLVALPfEsBjpKJx0YUKo=; b=q116RUM4wwfi3HSXC1cEVFqvQ3
 OO44LHPQx91UI0HstUBMxMwpdVjYblE1iQcvAjeELMSzqSIamzeDykixcvgs5S9aRrbXb+IiJEaD9
 mHzhKuAyATGxDv18Z4uaN00ee3V3DlBQlnFXtUZXmm3x971yXQFRiGG6bYVcimBoiJzA=;
Message-ID: <35998b4c-68d4-4c1e-854d-62f2b912f606@rev.ng>
Date: Thu, 14 Sep 2023 12:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] accel/tcg: Remove CPUState.icount_decr_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-10-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> We can now access icount_decr directly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   include/hw/core/cpu.h  | 2 --
>   hw/core/cpu-common.c   | 4 ++--
>   3 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index c3c78ed8ab..3b01e4ee25 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -434,7 +434,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
>   static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
>   {
>       cpu->parent_obj.env_ptr = &cpu->env;
> -    cpu->parent_obj.icount_decr_ptr = &cpu->parent_obj.neg.icount_decr;
>   }
>   
>   /* Validate correct placement of CPUArchState. */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1f289136ec..44955af3bc 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -440,7 +440,6 @@ struct qemu_work_item;
>    * @as: Pointer to the first AddressSpace, for the convenience of targets which
>    *      only have a single AddressSpace
>    * @env_ptr: Pointer to subclass-specific CPUArchState field.
> - * @icount_decr_ptr: Pointer to IcountDecr field within subclass.
>    * @gdb_regs: Additional GDB registers.
>    * @gdb_num_regs: Number of total registers accessible to GDB.
>    * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
> @@ -512,7 +511,6 @@ struct CPUState {
>       MemoryRegion *memory;
>   
>       CPUArchState *env_ptr;
> -    IcountDecr *icount_decr_ptr;
>   
>       CPUJumpCache *tb_jmp_cache;
>   
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index ced66c2b34..08d5bbc873 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -86,7 +86,7 @@ void cpu_exit(CPUState *cpu)
>       qatomic_set(&cpu->exit_request, 1);
>       /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>       smp_wmb();
> -    qatomic_set(&cpu->icount_decr_ptr->u16.high, -1);
> +    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
>   }
>   
>   static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
> @@ -130,7 +130,7 @@ static void cpu_common_reset_hold(Object *obj)
>       cpu->halted = cpu->start_powered_off;
>       cpu->mem_io_pc = 0;
>       cpu->icount_extra = 0;
> -    qatomic_set(&cpu->icount_decr_ptr->u32, 0);
> +    qatomic_set(&cpu->neg.icount_decr.u32, 0);
>       cpu->can_do_io = 1;
>       cpu->exception_index = -1;
>       cpu->crash_occurred = false;
Reviewed-by: Anton Johansson <anjo@rev.ng>

