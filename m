Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9637A2126
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9vB-0002Jr-SJ; Fri, 15 Sep 2023 10:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9v7-0002JL-9w
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:35:45 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9v5-0003nW-5A
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6S78FTq2nI+/SCipEYDsfA3csGnVDle1SYIv4IT9J0g=; b=MqxmLoW9Kghugipzw/nBRO204D
 9qSRtZHYlE98uEvOHdMNSXp8wdCi+yr0t88GK8/jQlaZJ8+X5fDgEkaVtNRrtapvvv7EEBGtHHmVr
 6+YlZUfsCZzv1fmd8r7f7gjkg66CVS66oPoQdQ3KLMG12LmEaFskSC0vAdiCiZjcjMmU=;
Date: Fri, 15 Sep 2023 16:35:26 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 11/11] accel/tcg: Make cpu-exec-common.c a target
 agnostic unit
Message-ID: <gnlsd62khdfuayikfmzurssfed7lohoe44ubn3etreolhimiqb@pbzq6lrkgstu>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-12-philmd@linaro.org>
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
> cpu_in_serial_context() is not target specific,
> move it declaration to "internal-common.h" (which
> we include in the 4 source files modified).
> 
> Remove the unused "exec/exec-all.h" header from
> cpu-exec-common.c.  There is no more target specific
> code in this file: make it target agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/internal-common.h | 11 +++++++++++
>  accel/tcg/internal-target.h |  9 ---------
>  accel/tcg/cpu-exec-common.c |  3 +--
>  accel/tcg/cputlb.c          |  1 +
>  accel/tcg/tb-maint.c        |  1 +
>  accel/tcg/user-exec.c       |  1 +
>  accel/tcg/meson.build       |  4 +++-
>  7 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index 5d5247442e..3b2277e6e9 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -9,9 +9,20 @@
>  #ifndef ACCEL_TCG_INTERNAL_COMMON_H
>  #define ACCEL_TCG_INTERNAL_COMMON_H
>  
> +#include "exec/translation-block.h"
> +
>  extern int64_t max_delay;
>  extern int64_t max_advance;
>  
>  void dump_exec_info(GString *buf);
>  
> +/*
> + * Return true if CS is not running in parallel with other cpus, either
> + * because there are no other cpus or we are within an exclusive context.
> + */
> +static inline bool cpu_in_serial_context(CPUState *cs)
> +{
> +    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
> +}
> +
>  #endif
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index f9eec1ce28..932bbe4b63 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -90,15 +90,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
>      }
>  }
>  
> -/*
> - * Return true if CS is not running in parallel with other cpus, either
> - * because there are no other cpus or we are within an exclusive context.
> - */
> -static inline bool cpu_in_serial_context(CPUState *cs)
> -{
> -    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
> -}
> -
>  extern bool one_insn_per_tb;
>  
>  /**
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 55980417b4..b6cc387482 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -20,9 +20,8 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/tcg.h"
> -#include "exec/exec-all.h"
>  #include "qemu/plugin.h"
> -#include "internal-target.h"
> +#include "internal-common.h"
>  
>  bool tcg_allowed;
>  
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a912d746a9..400d9ee0d0 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -35,6 +35,7 @@
>  #include "exec/translate-all.h"
>  #include "trace.h"
>  #include "tb-hash.h"
> +#include "internal-common.h"
>  #include "internal-target.h"
>  #ifdef CONFIG_PLUGIN
>  #include "qemu/plugin-memory.h"
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 85cf51445d..b194f8f065 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -29,6 +29,7 @@
>  #include "tcg/tcg.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> +#include "internal-common.h"
>  #include "internal-target.h"
>  
>  
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index f925dd0305..5bf2761bf4 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -29,6 +29,7 @@
>  #include "qemu/atomic128.h"
>  #include "trace/trace-root.h"
>  #include "tcg/tcg-ldst.h"
> +#include "internal-common.h"
>  #include "internal-target.h"
>  
>  __thread uintptr_t helper_retaddr;
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 4633a34d28..8783edd06e 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -1,7 +1,9 @@
>  tcg_ss = ss.source_set()
> +common_ss.add(when: 'CONFIG_TCG', if_true: files(
> +  'cpu-exec-common.c',
> +))
>  tcg_ss.add(files(
>    'tcg-all.c',
> -  'cpu-exec-common.c',
>    'cpu-exec.c',
>    'tb-maint.c',
>    'tcg-runtime-gvec.c',
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

