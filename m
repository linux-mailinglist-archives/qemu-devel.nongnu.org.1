Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4357A20BF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9h5-0001T6-BG; Fri, 15 Sep 2023 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9h3-0001Np-Ud
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:21:13 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9h2-0000tf-Dz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tMpX2IFiGssMQbYM/cfJeeGFBRQZbQfjivaQOVHsMDc=; b=kCCkcVpWBg/zmP1x25bEBbE0DD
 f2mKdM3Ti3AAVj0cZlzqmUzkP2RlmO18ao9Sjo/Yuo6RYlkjc4G1StUxWTvP4MPs5tzJ4/1h2xHDb
 nDcCSTGhLwNh97Jyyertf/pWK4/GRDnBI+FPl1JGyIHT07kPiyUNoGT5Xj6MfXpQN+yI=;
Date: Fri, 15 Sep 2023 16:20:58 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 07/11] exec: Rename target specific page-vary.c ->
 page-vary-target.c
Message-ID: <gqmt2j76pepd4fv4jtwjlgcll6leuhnwx5visq3tmkdmrqfcaj@jmrrvlst6zxe>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-8-philmd@linaro.org>
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
> This matches the target agnostic 'page-vary-common.c' counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                       | 2 +-
>  meson.build                       | 2 +-
>  page-vary.c => page-vary-target.c | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename page-vary.c => page-vary-target.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12261d8eaf..ff436dbf21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -141,7 +141,7 @@ F: softmmu/cpus.c
>  F: softmmu/watchpoint.c
>  F: cpu-common.c
>  F: cpu-target.c
> -F: page-vary.c
> +F: page-vary-target.c
>  F: page-vary-common.c
>  F: accel/tcg/
>  F: accel/stubs/tcg-stub.c
> diff --git a/meson.build b/meson.build
> index 3e86a6cebf..3282f888a3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3439,7 +3439,7 @@ if get_option('b_lto')
>    pagevary = declare_dependency(link_with: pagevary)
>  endif
>  common_ss.add(pagevary)
> -specific_ss.add(files('page-vary.c'))
> +specific_ss.add(files('page-vary-target.c'))
>  
>  subdir('backends')
>  subdir('disas')
> diff --git a/page-vary.c b/page-vary-target.c
> similarity index 100%
> rename from page-vary.c
> rename to page-vary-target.c
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

