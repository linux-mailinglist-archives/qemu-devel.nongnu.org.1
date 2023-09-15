Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21A7A20BA
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9gC-0008Dg-C1; Fri, 15 Sep 2023 10:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9g6-00085D-SS
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:20:14 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh9g2-0000RT-US
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7is5vz1d7yl7xR68c+Nai98dqps8e6G4qREabhz8WBg=; b=ivbbY+ruqLBR9WqoNfU4IpV9JQ
 hiD/1k0NSwMYRTZkn9WmZioCO9gtaKkkxI3UPX/LUOyTKxpUUmdeedqmCfq0aYCNeUZoEJ0tqq5Ti
 CyCGEMABCHPH3fUbx+QtSf4j+cdSru9KnBnOE/8TBUI6lyNU8mvRgV2tUEuk8PONJO84=;
Date: Fri, 15 Sep 2023 16:19:57 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 06/11] exec: Rename cpu.c -> cpu-target.c
Message-ID: <fzzskmx5koxw7xzzwwv6jejnntnjdw7psfjgnwkulxaq2sw7qf@2ro4ydtvieyg>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-7-philmd@linaro.org>
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
> We have exec/cpu code split in 2 files for target agnostic
> ("common") and specific. Rename 'cpu.c' which is target
> specific using the '-target' suffix. Update MAINTAINERS.
> Remove the 's from 'cpus-common.c' to match the API cpu_foo()
> functions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  MAINTAINERS                   | 4 ++--
>  meson.build                   | 4 ++--
>  cpus-common.c => cpu-common.c | 0
>  cpu.c => cpu-target.c         | 0
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename cpus-common.c => cpu-common.c (100%)
>  rename cpu.c => cpu-target.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..12261d8eaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -139,7 +139,8 @@ R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: softmmu/cpus.c
>  F: softmmu/watchpoint.c
> -F: cpus-common.c
> +F: cpu-common.c
> +F: cpu-target.c
>  F: page-vary.c
>  F: page-vary-common.c
>  F: accel/tcg/
> @@ -1772,7 +1773,6 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>  R: Philippe Mathieu-Daudé <philmd@linaro.org>
>  R: Yanan Wang <wangyanan55@huawei.com>
>  S: Supported
> -F: cpu.c
Was the maintainer switch intentional?

Either way,
Reviewed-by: Anton Johansson <anjo@rev.ng>

