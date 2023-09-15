Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E57A1FCF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8oO-0001Ng-3U; Fri, 15 Sep 2023 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh8oL-0001N6-Ly
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:24:41 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh8oI-0007Bl-NU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/NGkY8zJTrWEL+sJuLHiq1aNHJHoKJhztMse2f90STA=; b=u7W2Eu+wAsjgclXl7SLAgYTd4c
 J3OzG8xnRQH8WH26eMIfEKs09tJOCCEWArR07JMi9Lr3DDbAYSRqW6LPYSjqzyht+iEv0zYgxXCNj
 h726NUE04u24m9vBpaLwLT/jWZXiRzEsfIvXGeBzhxTRSkTT6+sSVEKTSmD8PSoGaaZc=;
Date: Fri, 15 Sep 2023 15:24:23 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 01/11] exec: Make EXCP_FOO definitions target agnostic
Message-ID: <ogmkqzdyyaidp62v227g7dq2fvhkzr4frpw7izrtxvkguw6zge@cso2fe5kklgl>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-2-philmd@linaro.org>
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
> The EXCP_* definitions don't need to be target specific,
> move them to "exec/cpu-common.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cpu-all.h    | 7 -------
>  include/exec/cpu-common.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 3b1cec390b..71efc2d404 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -26,13 +26,6 @@
>  #include "hw/core/cpu.h"
>  #include "qemu/rcu.h"
>  
> -#define EXCP_INTERRUPT  0x10000 /* async interruption */
> -#define EXCP_HLT        0x10001 /* hlt instruction reached */
> -#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
> -#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
> -#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
> -#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
> -
>  /* some important defines:
>   *
>   * HOST_BIG_ENDIAN : whether the host cpu is big endian and
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41788c0bdd..360b8298a4 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -7,6 +7,13 @@
>  #include "exec/hwaddr.h"
>  #endif
>  
> +#define EXCP_INTERRUPT  0x10000 /* async interruption */
> +#define EXCP_HLT        0x10001 /* hlt instruction reached */
> +#define EXCP_DEBUG      0x10002 /* cpu stopped after a breakpoint or singlestep */
> +#define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
> +#define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
> +#define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
> +
>  /**
>   * vaddr:
>   * Type wide enough to contain any #target_ulong virtual address.
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

