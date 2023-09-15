Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786A7A2107
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9rM-0008Dc-U0; Fri, 15 Sep 2023 10:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9rF-0008CG-BC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:31:45 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9rA-0002sl-Pj
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2UwKFVJ1axZ5vpK1/bxbmKsL5lVWPxXTo9X5TnuR/OU=; b=AaNv5yjzTLNc9KuSQHeC/SKpa+
 y0hF6W2WGUMX1ABVpS28a8luDw2q5SWcZDXOtB5zgeNUZA7YPZn1JjduRenLFug/La9+KurfKaxpW
 E1k8s47Od40ZA3irROQBHO76l7c6Nqm+D8nZ4vO3yg0fu1+vlF+EjE956Jc+EdHxGQ9M=;
Date: Fri, 15 Sep 2023 16:31:28 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 10/11] accel/tcg: Make icount.o a target agnostic unit
Message-ID: <d5zts77uzfyow6uelyq3zux736yjakwnu5rytjyczvvwc3zty3@ubcout4dobll>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-11-philmd@linaro.org>
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
> Remove the unused "exec/exec-all.h" header. There is
> no more target specific code in it: make it target
> agnostic (rename using the '-common' suffix). Since
> it is TCG specific, move it to accel/tcg, updating
> MAINTAINERS.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                                   | 1 -
>  softmmu/icount.c => accel/tcg/icount-common.c | 3 +--
>  accel/tcg/meson.build                         | 1 +
>  softmmu/meson.build                           | 4 ----
>  4 files changed, 2 insertions(+), 7 deletions(-)
>  rename softmmu/icount.c => accel/tcg/icount-common.c (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff436dbf21..047d143b9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2912,7 +2912,6 @@ F: softmmu/main.c
>  F: softmmu/cpus.c
>  F: softmmu/cpu-throttle.c
>  F: softmmu/cpu-timers.c
> -F: softmmu/icount.c
Would also be a maintainer switch

Otherwise,
Reviewed-by: Anton Johansson <anjo@rev.ng>

