Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F77A20D0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9ll-0004Rr-IV; Fri, 15 Sep 2023 10:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9lb-0004Or-QA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:25:55 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9la-0001tb-B6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=07LRzKry2XMMNMjYbAXSW8tb1pw+n33WItGE5YP7sHs=; b=BUCTfd1LTOTw24EPIPjk4009qc
 KDsoUsj1NDizWNrySw0tSvjwtd+Me11VqEOKgHSBTIGgmhROxHNiQR0WvMl3loINI1WmoRMdWVAoz
 safQ5OSxzvOVo71MrVeOtYsqMTMnM7L0WAxAhn4eGWLMVsnINKc2PanTxOQWKvDS9kX0=;
Date: Fri, 15 Sep 2023 16:25:42 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 09/11] accel/tcg: Make monitor.c a target-agnostic unit
Message-ID: <r5nm6enkeo5vgrdqe6dvntlcg4qonqtzhz53frmmrnrh2wup7z@w3uvaalq3md5>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-10-philmd@linaro.org>
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
> Move target-agnostic declarations from "internal-target.h"
> to a new "internal-common.h" header.
> monitor.c now don't include target specific headers and can
> be compiled once in system_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/internal-common.h | 17 +++++++++++++++++
>  accel/tcg/internal-target.h |  5 -----
>  accel/tcg/cpu-exec.c        |  1 +
>  accel/tcg/monitor.c         |  2 +-
>  accel/tcg/translate-all.c   |  1 +
>  accel/tcg/meson.build       |  3 +++
>  6 files changed, 23 insertions(+), 6 deletions(-)
>  create mode 100644 accel/tcg/internal-common.h
> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> new file mode 100644
> index 0000000000..5d5247442e
> --- /dev/null
> +++ b/accel/tcg/internal-common.h
> @@ -0,0 +1,17 @@
> +/*
> + * Internal execution defines for qemu (target agnostic)
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef ACCEL_TCG_INTERNAL_COMMON_H
> +#define ACCEL_TCG_INTERNAL_COMMON_H
> +
> +extern int64_t max_delay;
> +extern int64_t max_advance;
> +
> +void dump_exec_info(GString *buf);
> +
> +#endif
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 4ce3b29056..f9eec1ce28 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -99,11 +99,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
>      return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
>  }
>  
> -extern int64_t max_delay;
> -extern int64_t max_advance;
> -
> -void dump_exec_info(GString *buf);
> -
>  extern bool one_insn_per_tb;
>  
>  /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index f5625e047a..95dd8a30cb 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -42,6 +42,7 @@
>  #include "tb-jmp-cache.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> +#include "internal-common.h"
>  #include "internal-target.h"
>  
>  /* -icount align implementation. */
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index 30724fdb98..caf1189e0b 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -16,7 +16,7 @@
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
>  #include "tcg/tcg.h"
> -#include "internal-target.h"
> +#include "internal-common.h"
>  
>  
>  static void dump_drift_info(GString *buf)
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 6c09b7f50d..8cb6ad3511 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -61,6 +61,7 @@
>  #include "tb-jmp-cache.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> +#include "internal-common.h"
>  #include "internal-target.h"
>  #include "perf.h"
>  #include "tcg/insn-start-words.h"
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 8ace783707..0fb03bd7d3 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -20,6 +20,9 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
>  
>  specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>    'cputlb.c',
> +))
> +
> +system_ss.add(when: ['CONFIG_TCG'], if_true: files(
>    'monitor.c',
>  ))
>  
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

