Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D394C76B88B
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrFA-0008T2-8l; Tue, 01 Aug 2023 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrF8-0008Sj-4E
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:25:02 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrF6-0004wu-EV
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:25:01 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe3b86cec1so3264865e87.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690903498; x=1691508298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBIUPohxRvwRhYokclbKS9bgDTcqtvJe/8NdB9CWkEo=;
 b=RPRLiJH0Ej1Gn4HFbg/oB3Rg4Em2zw+1YNTpdK9g5j7Y9ZJbJjTQjhGOHP2uHuF2/Z
 /zsjWOBocV4uDocURHYQ8wpmuj2SAic8B+W1rjLJH+nAJlpRWxY78NP+i3Nz8TmgQ1cY
 PXriQ4wHLLral43AT3Q+C10MPE0XGkP6KkAF5oY8WsArCVatlDj/DhFX1Eb9pgIvg/kv
 A9BIUcLRv9VUx15Nf3gyKhuCHCBrZRiPZxCbA75t2ERy/Ks7lJBy5wgxHFZ1zMwAZ9kC
 oNYn1nE6P/Kufc2eDUvgELFbZcUCSdSbRqM/bXbk+A6lU/TOutNib5g4R/7kShT3VGhu
 ozrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690903498; x=1691508298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBIUPohxRvwRhYokclbKS9bgDTcqtvJe/8NdB9CWkEo=;
 b=RUWXEjDTjxLsvxJzjCfZM8xGJxEgkUt4F+Y3z57Hy2feqL458bBqZaj0f/pon2aW+p
 9Cx2GmeQeDnlv+D2quPukMeUsQnyJEAnVhGdfXir6vcrrYow1rMJF39bNBFfWZHx4oVc
 On1L2K577g5XJV9agNB5zGNPtDxPmY1GtjAJwVWbwl4yh3oSWArOV2PduqfaSi2CYybI
 xAHeVqF3BZ5VKjdMLy2ZT1qJw+3K5fMmsTeUnONRt/oenI0XixLiItD8Kq30dAuXgCbI
 sSvXMb26zqRRSA5SH13VR4y0i8zdn+zY0MSE0bGxOdLa4TxbC5/xAPFO6rNOVIbgiCCa
 8Fmw==
X-Gm-Message-State: ABy/qLZFg72ou/hzQDKUzLFxrNKCmNzgqCPxaZVhlMsZOCH6CRvwUr/v
 7oYguh/BaMlFBlL1dqxxAk6JIOCbN5+9yUv/EYoDLQ==
X-Google-Smtp-Source: APBJJlHXqnYFWc9Sp9iXQX03HN4lXAZjpCws9SaJvl15r/cR99c4tntKmTG4gvCVsufCOEfkQsNMCcC3/+eCiWCEWYs=
X-Received: by 2002:a05:6512:3d23:b0:4f8:6d99:f4f3 with SMTP id
 d35-20020a0565123d2300b004f86d99f4f3mr2963890lfv.52.1690903498273; Tue, 01
 Aug 2023 08:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230801152245.332749-1-keithp@keithp.com>
In-Reply-To: <20230801152245.332749-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 16:24:47 +0100
Message-ID: <CAFEAcA9uXbcX6V6H2z6zamnoODhGepWnFeE5W5=KZtW00NM=UQ@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 1 Aug 2023 at 16:23, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Instead of using R_ARG0 (the semihost function number), use R_ARG1
> (the provided exit status).
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/nios2/nios2-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> index 3738774976..f3b7aee4f1 100644
> --- a/target/nios2/nios2-semi.c
> +++ b/target/nios2/nios2-semi.c
> @@ -133,8 +133,8 @@ void do_nios2_semihosting(CPUNios2State *env)
>      args = env->regs[R_ARG1];
>      switch (nr) {
>      case HOSTED_EXIT:
> -        gdb_exit(env->regs[R_ARG0]);
> -        exit(env->regs[R_ARG0]);
> +        gdb_exit(env->regs[R_ARG1]);
> +        exit(env->regs[R_ARG1]);
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

