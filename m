Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0481133A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:46:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPYa-0003wN-0v; Wed, 13 Dec 2023 08:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDPYL-0003t1-PX; Wed, 13 Dec 2023 08:45:35 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rDPXt-0006eH-Vg; Wed, 13 Dec 2023 08:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y/BeS/uWhohIgo2Q1Syl0ONa3+qSPBdT0sc++7O39OY=; b=qL1OvgA/y6zXkDHDdjO1FIECXA
 h4NDPd4SBuw+FXzuQfvmAg7jRwpeU42oZxFdAREVoivbTFO35pHosBfW+jIg7JHx8pGv6gdRPoeMy
 6iuG+kgAOfLpZCffn9l9jcA6qAT+WzioW76ZRdyEDdNpjZYeF6ivF8iKTJEZkYLAleqg=;
Date: Wed, 13 Dec 2023 14:44:53 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>, 
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Brian Cain <bcain@quicinc.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH v2 14/23] exec/cpu-all: Remove unused tswapls() definitions
Message-ID: <vxb6ts4qlgf2krobzz2rosemk2f546wkuegfh5p5tzgwxih5ly@lv2hzdfirn5z>
References: <20231212123401.37493-1-philmd@linaro.org>
 <20231212123401.37493-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212123401.37493-15-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/12/23, Philippe Mathieu-Daudé wrote:
> Last use of tswapls() was removed 2 years ago in commit
> aee14c77f4 ("linux-user: Rewrite do_getdents, do_getdents64").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cpu-all.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 5b5379b94c..b042d94892 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -38,11 +38,9 @@
>  
>  #if TARGET_LONG_SIZE == 4
>  #define tswapl(s) tswap32(s)
> -#define tswapls(s) tswap32s((uint32_t *)(s))
>  #define bswaptls(s) bswap32s(s)
>  #else
>  #define tswapl(s) tswap64(s)
> -#define tswapls(s) tswap64s((uint64_t *)(s))
>  #define bswaptls(s) bswap64s(s)
>  #endif
>  
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

