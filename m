Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6D474F714
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH4A-0004qy-LZ; Tue, 11 Jul 2023 13:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJH48-0004qp-Vg
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:22:21 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJH47-0006LI-5c
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5ftt1rkpXhSeGuteAErFbv0590QUtdhF5/k4UCnwdxA=; b=IthWhAN4S0BlSNKfBl649uPkQV
 Qq0m+LZPvlUbR6jdnVWrZ0EESvm715KpYTanCV6PtkPZbt3qjj7CupLw7447lLUWyfUA8LcuilwMn
 8mcYS9OUTrGuqF6HoYUqOp40mWL7SWhC7oKtkFLcRus2YX6Qjs/mhsfJlKeGkx3At0Yg=;
Message-ID: <30724fbb-8a15-8d0a-cab1-d75bfa4bfbb2@rev.ng>
Date: Tue, 11 Jul 2023 19:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.1] accel/tcg: Zero-pad PC in TCG CPU exec trace lines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20230711165434.4123674-1-peter.maydell@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <20230711165434.4123674-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

> In commit f0a08b0913befbd we changed the type of the PC from
> target_ulong to vaddr.  In doing so we inadvertently dropped the
> zero-padding on the PC in trace lines (the second item inside the []
> in these lines).  They used to look like this on AArch64, for
> instance:
>
> Trace 0: 0x7f2260000100 [00000000/0000000040000000/00000061/ff200000]
>
> and now they look like this:
> Trace 0: 0x7f4f50000100 [00000000/40000000/00000061/ff200000]
>
> and if the PC happens to be somewhere low like 0x5000
> then the field is shown as /5000/.
>
> This is because TARGET_FMT_lx is a "%08x" or "%016x" specifier,
> depending on TARGET_LONG_SIZE, whereas VADDR_PRIx is just PRIx64
> with no width specifier.
>
> Restore the zero-padding by adding an 016 width specifier to
> this tracing and a couple of others that were similarly recently
> changed to use VADDR_PRIx without a width specifier.
>
> We can't unfortunately restore the "32-bit guests are padded to
> 8 hex digits and 64-bit guests to 16 hex digits" behaviour so
> easily.
>
> Fixes: f0a08b0913befbd ("accel/tcg/cpu-exec.c: Widen pc to vaddr")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have a workflow that parses log files to get the executed
> PC values; I don't suppose I'm the only one doing that...
> ---
>   accel/tcg/cpu-exec.c      | 4 ++--
>   accel/tcg/translate-all.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ba1890a373d..db1e82811fa 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -298,7 +298,7 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
>       if (qemu_log_in_addr_range(pc)) {
>           qemu_log_mask(CPU_LOG_EXEC,
>                         "Trace %d: %p [%08" PRIx64
> -                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
> +                      "/%016" VADDR_PRIx "/%08x/%08x] %s\n",
>                         cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
>                         tb->flags, tb->cflags, lookup_symbol(pc));
>   
> @@ -487,7 +487,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
>           if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>               vaddr pc = log_pc(cpu, last_tb);
>               if (qemu_log_in_addr_range(pc)) {
> -                qemu_log("Stopped execution of TB chain before %p [%"
> +                qemu_log("Stopped execution of TB chain before %p [%016"
>                            VADDR_PRIx "] %s\n",
>                            last_tb->tc.ptr, pc, lookup_symbol(pc));
>               }
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d3d4fbc1a41..bb225afa04f 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -604,7 +604,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
>       if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>           vaddr pc = log_pc(cpu, tb);
>           if (qemu_log_in_addr_range(pc)) {
> -            qemu_log("cpu_io_recompile: rewound execution of TB to %"
> +            qemu_log("cpu_io_recompile: rewound execution of TB to %016"
>                        VADDR_PRIx "\n", pc);
>           }
>       }
This was definitely a mistake on my part, thanks for the quick fix!

Reviewed-by: Anton Johansson <anjo@rev.ng>

