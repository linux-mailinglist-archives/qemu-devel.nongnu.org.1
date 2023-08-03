Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A2976E53E
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 12:08:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRVFT-0006tu-0b; Thu, 03 Aug 2023 06:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVFR-0006rh-9A
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:08:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVFP-0001Oo-BI
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:08:01 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso935948a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691057275; x=1691662075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j6Zt6dN7WJWyJZYFJYo7kxdI/caHk1ItpdryInktWnI=;
 b=aaoWNCxrHQWfy+kGE0AihJ666mMgkXCipKd0W7haZjtuajeRFssItGmPoYH97LewDR
 LYLWc7bzbQpOF5xdn755WQHV8zq72lMSrtOcQBn+ci1qaJ0/user0elouzQISbv+ShwC
 fse9aJfvUkMLfZQmKZLN5906d0R3GUe0oetAK68iS/c//xLgsxM4G8QYRTGvoxoAs7Zv
 LOY/OhP+etdALneJBVx1Plev0yPxP+EJ1sU+1njRW+peGTVGu5LXIjUol46ZtHibCXXo
 0ZoJTQKDVAQrYmIuI37TbirUlvGIP1r9PLNKsMTcldZx8TLncIrRcuOVvEGbUNXKmTCg
 8/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691057275; x=1691662075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6Zt6dN7WJWyJZYFJYo7kxdI/caHk1ItpdryInktWnI=;
 b=RU+3FQq2NTcPmfIxV2dDgnSEzdZhko0aTF98uYiFTydbkh1f0PbX6dze1No+w/0Ytr
 rciTMzArcUSKPzg/zxFSI35LrjJK66L+lHzmAeUqVpHxhhiEZMfo1z3GEk5R3wnR7B5L
 gAcjPcX3STigF5aqrbvhMBHj6pm39O2GUxen8y+IsIlyNtw7Se1+uJHgXvBSaj9gm9jH
 XHqBsbFlLQ61C0o2ZqZj2/j7fZejNRHM46o/PWrmcF41oEorrNxuhPNi60Ld2YMTF5rq
 7mMByucgOfo0A7z1H+bRt5BQRCl16FvKRQJbKn0GuklNs50mjHwX17Fl5Wd7solcHl5O
 97wA==
X-Gm-Message-State: ABy/qLZXcl3HrjRO+yCyStsfzlqBzLteKgqYbRhJKxit23pHh5+rjTHZ
 R5ThESGF5+CuzLhU2ivakhKNTE2KAka+4DN+YvyQ52jSe4XuNBQS
X-Google-Smtp-Source: APBJJlHVPmkwIdDW+EvLBYxlwwbWFkHRMzYlAcvruxyT6ShxV0soGGJrWtiHwiwMM/73sdNYL/qkTsnwCF9TD3Vu44s=
X-Received: by 2002:aa7:d507:0:b0:522:3d36:ff26 with SMTP id
 y7-20020aa7d507000000b005223d36ff26mr7329492edq.38.1691057275625; Thu, 03 Aug
 2023 03:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230802161914.395443-1-keithp@keithp.com>
 <20230802161914.395443-2-keithp@keithp.com>
In-Reply-To: <20230802161914.395443-2-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 11:07:44 +0100
Message-ID: <CAFEAcA_LEOOLQ0C1Pj0aw0Tt_0hSyhdirg51TUxYvWugMoRKVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/m68k: Pass semihosting arg to exit
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2 Aug 2023 at 17:20, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Instead of using d0 (the semihost function number), use d1 (the
> provide exit status).
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/m68k/m68k-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 88ad9ba814..12235759c7 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -130,8 +130,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
>      args = env->dregs[1];
>      switch (nr) {
>      case HOSTED_EXIT:
> -        gdb_exit(env->dregs[0]);
> -        exit(env->dregs[0]);
> +        gdb_exit(env->dregs[1]);
> +        exit(env->dregs[1]);

I looked at this code but didn't spot the bug, because I
got confused by the 'args = env->dregs[1]' line above somehow.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

