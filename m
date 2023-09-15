Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079A7A2047
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9H6-0006Ge-62; Fri, 15 Sep 2023 09:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9H3-0006GO-GG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:54:21 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9Gx-0003QX-VQ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tdh0Wi/c7IL2rPqjRoOV30UgkfpHSsCdb7sT8jUr5es=; b=QlnOKdKWciGl0oV5ddDMOUlQPG
 GS0FPenno4xkup6mZcKeHmEOLHqbXwIbknICtMrYFbsd7S2l5Srzz1M/6l4ksFt5H23L/8d9S5hwy
 XqiUjrW5ghhhACY1BkQrvm7HrU+G8aVKmXeDCLjDmgKW5PTVyVhPi7JQQCn4XhFc8e44=;
Date: Fri, 15 Sep 2023 15:54:01 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 02/11] exec: Move cpu_loop_foo() target agnostic
 functions to 'cpu-common.h'
Message-ID: <wokmorg2uor6buclmnviwhuewycazrm4capr255h7ujg22xly7@wxantn4baxes>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-3-philmd@linaro.org>
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 14/09/23, Philippe Mathieu-Daudé wrote:
> While these functions are not TCG specific, they are not target
> specific. Move them to "exec/cpu-common.h" so their callers don't
> have to be tainted as target specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cpu-common.h | 32 ++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h   | 30 ------------------------------
>  2 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 360b8298a4..605b160a7e 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -173,4 +173,36 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>  /* vl.c */
>  void list_cpus(void);
>  
> +#ifdef CONFIG_TCG
> +/**
> + * cpu_unwind_state_data:
> + * @cpu: the cpu context
> + * @host_pc: the host pc within the translation
> + * @data: output data
> + *
> + * Attempt to load the the unwind state for a host pc occurring in
> + * translated code.  If @host_pc is not in translated code, the
> + * function returns false; otherwise @data is loaded.
> + * This is the same unwind info as given to restore_state_to_opc.
> + */
> +bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
> +
> +/**
> + * cpu_restore_state:
> + * @cpu: the cpu context
> + * @host_pc: the host pc within the translation
> + * @return: true if state was restored, false otherwise
> + *
> + * Attempt to restore the state for a fault occurring in translated
> + * code. If @host_pc is not in translated code no state is
> + * restored and the function returns false.
> + */
> +bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
> +
> +G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
> +G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
> +#endif /* CONFIG_TCG */
> +G_NORETURN void cpu_loop_exit(CPUState *cpu);
> +G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
> +
>  #endif /* CPU_COMMON_H */
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 2e4d337805..ee90ef122b 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -27,36 +27,6 @@
>  #include "exec/translation-block.h"
>  #include "qemu/clang-tsa.h"
>  
> -/**
> - * cpu_unwind_state_data:
> - * @cpu: the cpu context
> - * @host_pc: the host pc within the translation
> - * @data: output data
> - *
> - * Attempt to load the the unwind state for a host pc occurring in
> - * translated code.  If @host_pc is not in translated code, the
> - * function returns false; otherwise @data is loaded.
> - * This is the same unwind info as given to restore_state_to_opc.
> - */
> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
> -
> -/**
> - * cpu_restore_state:
> - * @cpu: the cpu context
> - * @host_pc: the host pc within the translation
> - * @return: true if state was restored, false otherwise
> - *
> - * Attempt to restore the state for a fault occurring in translated
> - * code. If @host_pc is not in translated code no state is
> - * restored and the function returns false.
> - */
> -bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
> -
> -G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
> -G_NORETURN void cpu_loop_exit(CPUState *cpu);
> -G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
> -G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
> -
>  /**
>   * cpu_loop_exit_requested:
>   * @cpu: The CPU state to be tested
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

