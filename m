Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 655CA7A20C7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9iu-0002jP-QI; Fri, 15 Sep 2023 10:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9is-0002jB-LI
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:23:06 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9ir-0001JP-1W
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d+5AZ2+cRQ7cpQFOx6zcc/uyQPrEoRrBLqxLo+m+dhI=; b=sw1g2J2VhGRhwkJiMABUcvFqIm
 yMQE92JRm7wadQDmGIpgb0/y6e686psu5DaId4a7AqljuT9QiEW1/EcNq3sJUGnSWZPVoVtYWeUWo
 oJfahzxzhstRwT06pCIaLyoTAhrJlMWYBh0tyjByx/ntiDdVO3DH4cIWNIwV88hjcQv0=;
Date: Fri, 15 Sep 2023 16:22:46 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 08/11] accel/tcg: Rename target-specific 'internal.h' ->
 'internal-target.h'
Message-ID: <pn43tbxeoudy3bodooozlc6my2dyoav2dnos6pbuezzbcir7mc@6mhjyuoe4ted>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-9-philmd@linaro.org>
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
> accel/tcg/internal.h contains target specific declarations.
> Unit files including it become "target tainted": they can not
> be compiled as target agnostic. Rename using the '-target'
> suffix to make this explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/{internal.h => internal-target.h} | 6 +++---
>  accel/tcg/cpu-exec-common.c                 | 2 +-
>  accel/tcg/cpu-exec.c                        | 2 +-
>  accel/tcg/cputlb.c                          | 2 +-
>  accel/tcg/monitor.c                         | 2 +-
>  accel/tcg/tb-maint.c                        | 2 +-
>  accel/tcg/tcg-all.c                         | 2 +-
>  accel/tcg/translate-all.c                   | 2 +-
>  accel/tcg/translator.c                      | 2 +-
>  accel/tcg/user-exec.c                       | 2 +-
>  10 files changed, 12 insertions(+), 12 deletions(-)
>  rename accel/tcg/{internal.h => internal-target.h} (96%)
> 
> diff --git a/accel/tcg/internal.h b/accel/tcg/internal-target.h
> similarity index 96%
> rename from accel/tcg/internal.h
> rename to accel/tcg/internal-target.h
> index cd6b9eb7f0..4ce3b29056 100644
> --- a/accel/tcg/internal.h
> +++ b/accel/tcg/internal-target.h
> @@ -1,13 +1,13 @@
>  /*
> - * Internal execution defines for qemu
> + * Internal execution defines for qemu (target specific)
>   *
>   *  Copyright (c) 2003 Fabrice Bellard
>   *
>   * SPDX-License-Identifier: LGPL-2.1-or-later
>   */
>  
> -#ifndef ACCEL_TCG_INTERNAL_H
> -#define ACCEL_TCG_INTERNAL_H
> +#ifndef ACCEL_TCG_INTERNAL_TARGET_H
> +#define ACCEL_TCG_INTERNAL_TARGET_H
>  
>  #include "exec/exec-all.h"
>  #include "exec/translate-all.h"
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 8ac2af4d0c..55980417b4 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -22,7 +22,7 @@
>  #include "sysemu/tcg.h"
>  #include "exec/exec-all.h"
>  #include "qemu/plugin.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  bool tcg_allowed;
>  
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 0e7eeef001..f5625e047a 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -42,7 +42,7 @@
>  #include "tb-jmp-cache.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  /* -icount align implementation. */
>  
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 31e34700ea..a912d746a9 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -35,7 +35,7 @@
>  #include "exec/translate-all.h"
>  #include "trace.h"
>  #include "tb-hash.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  #ifdef CONFIG_PLUGIN
>  #include "qemu/plugin-memory.h"
>  #endif
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index d48de23999..30724fdb98 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -16,7 +16,7 @@
>  #include "sysemu/cpu-timers.h"
>  #include "sysemu/tcg.h"
>  #include "tcg/tcg.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  
>  static void dump_drift_info(GString *buf)
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 32ae8af61c..85cf51445d 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -29,7 +29,7 @@
>  #include "tcg/tcg.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  
>  /* List iterators for lists of tagged pointers in TranslationBlock. */
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 03dfd67e9e..b32e0b80ec 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -38,7 +38,7 @@
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/boards.h"
>  #endif
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  struct TCGState {
>      AccelState parent_obj;
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 83e07b830f..6c09b7f50d 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -61,7 +61,7 @@
>  #include "tb-jmp-cache.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  #include "perf.h"
>  #include "tcg/insn-start-words.h"
>  
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index d9fcb4cbe8..65219b52eb 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -14,7 +14,7 @@
>  #include "exec/translator.h"
>  #include "exec/plugin-gen.h"
>  #include "tcg/tcg-op-common.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  static void gen_io_start(void)
>  {
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 17f9aff0cf..f925dd0305 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -29,7 +29,7 @@
>  #include "qemu/atomic128.h"
>  #include "trace/trace-root.h"
>  #include "tcg/tcg-ldst.h"
> -#include "internal.h"
> +#include "internal-target.h"
>  
>  __thread uintptr_t helper_retaddr;
>  
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

