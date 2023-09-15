Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A07A204A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9Ix-00077E-1Z; Fri, 15 Sep 2023 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9Is-00076r-Lz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:56:15 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9Iq-0004UM-6L
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=29ZFRgjzL91uz0et6ub4oGM37ULm7y8dZtLkXfc+KnQ=; b=vg6Chcn+JKTYvt9nYCtj0l7rz0
 vflMQFuwlcTOozQOBPSh3nJDuyzzFr9iR/Rqm+paJLAfS17ORSIFGFR8QEVruSIsK8dYv76ixN1K+
 ZjUdI0WrI4MlBNcPypl6d1hddBZEs0kMsW7EW/sv9ZwvtU52LEBTVLeHaOOp4VGWXAqk=;
Date: Fri, 15 Sep 2023 15:56:01 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 03/11] accel/tcg: Restrict dump_exec_info() declaration
Message-ID: <xdbgvwejhucu7bvepjxm7pzh27ydrfqyvmg2kpojcpk5seq3bd@ep4idscf4b7c>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-4-philmd@linaro.org>
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
> In commit 00c9a5c2c3 ("accel/tcg: Restrict 'qapi-commands-machine.h'
> to system emulation") we moved the definition to accel/tcg/ which is
> where this function is called. No need to expose it outside.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/internal.h   | 2 ++
>  include/exec/cpu-all.h | 5 -----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
> index e8cbbde581..cd6b9eb7f0 100644
> --- a/accel/tcg/internal.h
> +++ b/accel/tcg/internal.h
> @@ -102,6 +102,8 @@ static inline bool cpu_in_serial_context(CPUState *cs)
>  extern int64_t max_delay;
>  extern int64_t max_advance;
>  
> +void dump_exec_info(GString *buf);
> +
>  extern bool one_insn_per_tb;
>  
>  /**
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 71efc2d404..221ada2b6d 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -406,11 +406,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
>      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
>  }
>  
> -#ifdef CONFIG_TCG
> -/* accel/tcg/translate-all.c */
> -void dump_exec_info(GString *buf);
> -#endif /* CONFIG_TCG */
> -
>  #endif /* !CONFIG_USER_ONLY */
>  
>  /* accel/tcg/cpu-exec.c */
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

