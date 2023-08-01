Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E87D76B45C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQo7L-0002cn-Eo; Tue, 01 Aug 2023 08:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQo7J-0002ca-6i
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:04:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQo7H-0007Id-JT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:04:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso7692017a12.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690891481; x=1691496281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yCwyXE92t+XDk4VD6EBf1IEFmMbzDNICXJwv43NVcsQ=;
 b=GaPvHjJbR85PrRf5WmwauPWzAy9KrThE6+elFqiV2SDwcSLb3eMT7MMiIcfYNUdk1g
 itqZVv3Z3oE0Bhnx0uzc5XJ5rkoSjOF+qJDgoqaO8yCoKpMsZ7ai/wzlV4mE7aXkY6EJ
 ToW0Wru1sNxV4pVwvQ0EO0SLB+x4JvPvMPUo4rVZaNYspq07l8Tw4q7tHw8x24oYgts2
 D8DY4NzKkCP6nNt0zW5WAelX/o8Q72WOXeIcN6feg+ygygveEXJ0PYhmfV3pNoFfz/Ny
 IBPm6foCjaaV6OQWCkSN9cNrE4MuV5vVgFwKkdsPZHHfTlV1Fnj5TfmFKBolxAFDrEZ9
 2zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690891481; x=1691496281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yCwyXE92t+XDk4VD6EBf1IEFmMbzDNICXJwv43NVcsQ=;
 b=c1DmCfjfXbY3CkKR+vti+ouimdwmEe+STT43g4rx58jfYgpP8Y3cj5uiwOv/3u4iD9
 sta+xvSV8UH4ptGq8FXpzlOkBF2jsqih/g3CE2ENJrSU99dC6LgojeXhO9z6T/ecScQ0
 tgD9NU/muokxP6unC52m6NG2/ilaxH6n0epCK0zvBH/QKI8SFMKHUZLK8IQXPfQvDiv+
 IskLPC4TKj6l7lkMSa+y9EN0Xaa7koz23YW5Hy2wsxQ9sDVyV9EgweCLFdZ6K3m/Swkq
 yS9lvQZ1sPrI9dojWCMl650XBQq3eubkZ9luP1pH5OmUnWTfC67zmFPQU2rC/DSBv7+U
 qogQ==
X-Gm-Message-State: ABy/qLbWhwzBrCEwyqPr4o5F3BMqEiiEB0322LfzInM6VDWhYkXw+110
 XaNOIuOAlPrnwYKCDE2C9hIECKGxy0W7HNefjlA2Jg==
X-Google-Smtp-Source: APBJJlHQcqwiRr+Ls2jZAg1bn/jsCjMycQ5T6IueH8HBZeT3e73tQ+Vr8xpgyzao39xU/PsxHWGM809DYoaNBvWg29s=
X-Received: by 2002:aa7:dd15:0:b0:51d:95f2:ee76 with SMTP id
 i21-20020aa7dd15000000b0051d95f2ee76mr2183589edv.27.1690891481557; Tue, 01
 Aug 2023 05:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230731224106.292845-1-keithp@keithp.com>
In-Reply-To: <20230731224106.292845-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 13:04:30 +0100
Message-ID: <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
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

On Mon, 31 Jul 2023 at 23:42, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Instead of using the function number (which is always zero), fetch the
> application-provided exit code argument and pass that to the two exit
> functions.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/nios2/nios2-semi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> index 3738774976..ffd1f095f6 100644
> --- a/target/nios2/nios2-semi.c
> +++ b/target/nios2/nios2-semi.c
> @@ -133,8 +133,9 @@ void do_nios2_semihosting(CPUNios2State *env)
>      args = env->regs[R_ARG1];
>      switch (nr) {
>      case HOSTED_EXIT:
> -        gdb_exit(env->regs[R_ARG0]);
> -        exit(env->regs[R_ARG0]);
> +        GET_ARG(0);
> +        gdb_exit(arg0);
> +        exit(arg0);

The spec
https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;a=blob;f=libgloss/nios2/nios2-semi.txt;hb=HEAD

says that for HOSTED_EXIT the exit code is in r5,
not in a parameter block pointed to by r5. That
would imply that the correct change is to use
R_ARG1 rather than R_ARG0 here.

thanks
-- PMM

