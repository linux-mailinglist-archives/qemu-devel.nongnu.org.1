Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA87B64DA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbF8-0000O4-4k; Tue, 03 Oct 2023 04:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbF5-00009R-U8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:58:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qnbF4-0006Lc-2Z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:58:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DC3B1F893;
 Tue,  3 Oct 2023 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696323536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzeosV5o+VBicvMZZcvFgmf0xeDEQXO35zpf3Fl90nE=;
 b=wxZjcALKmtoMqn6hcvqLrnHSA7zwnj26Fgs1b3IXdN/6c4DMRy6jZv4ViLdQCfPent25d3
 cwsfaI77Vs4G6v0Un1q9QYZiGJp6Q2UDC/KzUQ9/MDkEVXI6V5hzYcH0eRM3CKvTz7K1JL
 oYT2tjto14fM15AbenC88Waf9KtDe7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696323536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzeosV5o+VBicvMZZcvFgmf0xeDEQXO35zpf3Fl90nE=;
 b=0t42XBH9cZyfQOjH7qNkgbFOo9pQYbohpFDvTy5CzW1hdRDzwGVwZc5rv26iOvXhHp2GQx
 xDUoeYH6K3ujsTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB7A8139F9;
 Tue,  3 Oct 2023 08:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ahS3J8/XG2UMQAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 08:58:55 +0000
Message-ID: <0049dc3b-df77-1c2f-b971-5a9d13382059@suse.de>
Date: Tue, 3 Oct 2023 10:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/5] accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-6-philmd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230915190009.68404-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/15/23 21:00, Philippe Mathieu-Daudé wrote:
> We don't need to expose these TCG-specific methods to the
> whole code base. Register them as AccelClass handlers, they
> will be called by the generic accel_cpu_[un]realize() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Claudio Fontana <cfontana@suse.de>

> ---
>  accel/tcg/internal.h   | 3 +++
>  include/exec/cpu-all.h | 2 --
>  accel/tcg/tcg-all.c    | 2 ++
>  cpu.c                  | 8 --------
>  4 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
> index e8cbbde581..57ab397df1 100644
> --- a/accel/tcg/internal.h
> +++ b/accel/tcg/internal.h
> @@ -80,6 +80,9 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
>  void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
>                                 uintptr_t host_pc);
>  
> +bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
> +void tcg_exec_unrealizefn(CPUState *cpu);
> +
>  /* Return the current PC from CPU, which may be cached in TB. */
>  static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
>  {
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 1e5c530ee1..230525ebf7 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -422,8 +422,6 @@ void dump_exec_info(GString *buf);
>  
>  /* accel/tcg/cpu-exec.c */
>  int cpu_exec(CPUState *cpu);
> -bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
> -void tcg_exec_unrealizefn(CPUState *cpu);
>  
>  /**
>   * cpu_set_cpustate_pointers(cpu)
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 03dfd67e9e..6942a9766a 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -227,6 +227,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "tcg";
>      ac->init_machine = tcg_init_machine;
> +    ac->realize_cpu = tcg_exec_realizefn;
> +    ac->unrealize_cpu = tcg_exec_unrealizefn;
>      ac->allowed = &tcg_allowed;
>      ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
>  
> diff --git a/cpu.c b/cpu.c
> index b928bbed50..1a8e730bed 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -140,11 +140,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>          return;
>      }
>  
> -    /* NB: errp parameter is unused currently */
> -    if (tcg_enabled()) {
> -        tcg_exec_realizefn(cpu, errp);
> -    }
> -
>      /* Wait until cpu initialization complete before exposing cpu. */
>      cpu_list_add(cpu);
>  
> @@ -190,9 +185,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
>       * accel_cpu_unrealize, which may free fields using call_rcu.
>       */
>      accel_cpu_unrealize(cpu);
> -    if (tcg_enabled()) {
> -        tcg_exec_unrealizefn(cpu);
> -    }
>  }
>  
>  /*


