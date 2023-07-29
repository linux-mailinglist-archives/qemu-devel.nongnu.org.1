Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A8767D5C
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 10:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPfXa-0004sO-Gu; Sat, 29 Jul 2023 04:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qPfXX-0004sB-4k; Sat, 29 Jul 2023 04:43:07 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qPfXV-0003Cs-JT; Sat, 29 Jul 2023 04:43:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0883B21862;
 Sat, 29 Jul 2023 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690620182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRqAOyoBPevLFivc88TxFIyx3iUlTV1FpoGVp1GymYM=;
 b=qyi5jsFC9+4p3OqGv6OS5AT0QScvRWooOy6FQSiqNeo+UCcBEXX61DnbZmYZ5K5AMJV0Fz
 rQYvCzPKxL5c2HSphFPGzFgPeeS4KgZAXDvZoWmLItlc31Z4s4sEI/4EmhX1TBc6CiVi4i
 /fSQHuX/63NGauON+SoMtPS/DUzm1E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690620182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRqAOyoBPevLFivc88TxFIyx3iUlTV1FpoGVp1GymYM=;
 b=hfJ8zptV+1uQeK4ScY2fITjprGMxwy7dedA9WR9eiWshuK9Dw5GDawJbLEpP+tp+iuKM/g
 UEigZrel2f9T7jCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B954B13922;
 Sat, 29 Jul 2023 08:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wEf2KhXRxGSdNwAAMHmgww
 (envelope-from <cfontana@suse.de>); Sat, 29 Jul 2023 08:43:01 +0000
Message-ID: <8718b7b6-306a-b017-abf8-63371440118a@suse.de>
Date: Sat, 29 Jul 2023 10:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, david@redhat.com, qemu-s390x@nongnu.org
References: <20230728195538.488932-1-richard.henderson@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230728195538.488932-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/28/23 21:55, Richard Henderson wrote:
> This solves a problem in which the store to LowCore during tlb_fill
> triggers a clean-page TB invalidation for page0 during translation,
> which results in an assertion failure for locked pages.
> 
> By delaying the store until after the exception has been raised,
> we will have unwound the pages locked for translation and the
> problem does not arise.  There are plenty of other updates to
> LowCore while delivering an interrupt/exception; trans_exc_code
> does not need to be special.
> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Verified, fixes the TCG assertions I encountered with qemu-system-s390x on x86 host.

Tested-by: Claudio Fontana <cfontana@suse.de>

> ---
>  target/s390x/tcg/excp_helper.c | 42 +++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 3da337f7c7..b260bf7331 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -190,11 +190,6 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          return false;
>      }
>  
> -    if (excp != PGM_ADDRESSING) {
> -        stq_phys(env_cpu(env)->as,
> -                 env->psa + offsetof(LowCore, trans_exc_code), tec);
> -    }
> -
>      /*
>       * For data accesses, ILEN will be filled in from the unwind info,
>       * within cpu_loop_exit_restore.  For code accesses, retaddr == 0,
> @@ -211,20 +206,34 @@ static void do_program_interrupt(CPUS390XState *env)
>      uint64_t mask, addr;
>      LowCore *lowcore;
>      int ilen = env->int_pgm_ilen;
> +    bool set_trans_exc_code = false;
> +    bool advance = false;
>  
>      assert((env->int_pgm_code == PGM_SPECIFICATION && ilen == 0) ||
>             ilen == 2 || ilen == 4 || ilen == 6);
>  
>      switch (env->int_pgm_code) {
>      case PGM_PER:
> -        if (env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION) {
> -            break;
> -        }
> -        /* FALL THROUGH */
> +        advance = !(env->per_perc_atmid & PER_CODE_EVENT_NULLIFICATION);
> +        break;
> +    case PGM_ASCE_TYPE:
> +    case PGM_REG_FIRST_TRANS:
> +    case PGM_REG_SEC_TRANS:
> +    case PGM_REG_THIRD_TRANS:
> +    case PGM_SEGMENT_TRANS:
> +    case PGM_PAGE_TRANS:
> +        assert(env->int_pgm_code == env->tlb_fill_exc);
> +        set_trans_exc_code = true;
> +        break;
> +    case PGM_PROTECTION:
> +    case PGM_TRANS_SPEC:
> +        assert(env->int_pgm_code == env->tlb_fill_exc);
> +        set_trans_exc_code = true;
> +        advance = true;
> +        break;
>      case PGM_OPERATION:
>      case PGM_PRIVILEGED:
>      case PGM_EXECUTE:
> -    case PGM_PROTECTION:
>      case PGM_ADDRESSING:
>      case PGM_SPECIFICATION:
>      case PGM_DATA:
> @@ -236,18 +245,21 @@ static void do_program_interrupt(CPUS390XState *env)
>      case PGM_HFP_EXP_UNDERFLOW:
>      case PGM_HFP_SIGNIFICANCE:
>      case PGM_HFP_DIVIDE:
> -    case PGM_TRANS_SPEC:
>      case PGM_SPECIAL_OP:
>      case PGM_OPERAND:
>      case PGM_HFP_SQRT:
>      case PGM_PC_TRANS_SPEC:
>      case PGM_ALET_SPEC:
>      case PGM_MONITOR:
> -        /* advance the PSW if our exception is not nullifying */
> -        env->psw.addr += ilen;
> +        advance = true;
>          break;
>      }
>  
> +    /* advance the PSW if our exception is not nullifying */
> +    if (advance) {
> +        env->psw.addr += ilen;
> +    }
> +
>      qemu_log_mask(CPU_LOG_INT,
>                    "%s: code=0x%x ilen=%d psw: %" PRIx64 " %" PRIx64 "\n",
>                    __func__, env->int_pgm_code, ilen, env->psw.mask,
> @@ -263,6 +275,10 @@ static void do_program_interrupt(CPUS390XState *env)
>          env->per_perc_atmid = 0;
>      }
>  
> +    if (set_trans_exc_code) {
> +        lowcore->trans_exc_code = cpu_to_be64(env->tlb_fill_tec);
> +    }
> +
>      lowcore->pgm_ilen = cpu_to_be16(ilen);
>      lowcore->pgm_code = cpu_to_be16(env->int_pgm_code);
>      lowcore->program_old_psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(env));


