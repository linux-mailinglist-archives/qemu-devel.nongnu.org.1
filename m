Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3E78C7C6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:40:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazsV-000750-Im; Tue, 29 Aug 2023 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazsL-00073n-CF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:39:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qazsI-0001jy-FK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:39:25 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso1377333a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319960; x=1693924760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QpepGGqSgl/CR37j9UuaeqGKMp5ps+QZ97hpG/Z0owM=;
 b=S+Xqj4e8GRWbyh04a7MXCzRdYQ6w0359VcQcqw6hOOGefsdXZY5EJ1vEh3+ODGKpvd
 WGl8PpwanF+LZshgr7U5BnbrnuU1effk4c1YGYs9iY+oDb5aU9W1LuMcgZrX1agqVmZ2
 /+5DGIvwyOYf/lNU1ZNkRVLsjb0C40TAsMOcPukcAsH3nKy6LbMo64ln3OMBCWdfk9cK
 rI7R0WCHz/e1qDGJqQY2VNmakFl5JeyApGJyYCzMeK/Q9p0R8LiRIYEaW1wG2HnHBp0q
 JiPl0XRPeCKuBX63s4pxESHTEAeOLe+ySYJF9wc54O094/3W8rUEY/kcD9c8lajZ2bSb
 btcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319960; x=1693924760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpepGGqSgl/CR37j9UuaeqGKMp5ps+QZ97hpG/Z0owM=;
 b=IxWx5eUo5ju1gVL0+N20Tqmj+EMidehJsaNkxwlquqOD9eHQ8dRAZ51rwEpCAbTXGt
 oRImrCByCONONWW6G2B3eKsK3AxapVeT6JKvJda0314iPbliQnRRUop1PG+iPCihi4In
 1LJk+tfuX0BzKlyLWNDsbf2HM0lBQALf9VtkhGk67UiNuzvUtaUk4TH0BW0l2fS8xUXv
 mvNp+gkv3zpemqJt+Zi1/oFO3TAhaTwcStUXgFUNSPbwd0AdN2biigQ3POk0WBPsV4H0
 7QRfFHVJzE4f7TFCNHL1pmQKKqEAtA3zK93XqirGnppwW6jedom6LaG8cWUtHYZttABD
 jqXQ==
X-Gm-Message-State: AOJu0YxsZvqEDnwHhHkfVhvKI1cKlVbDSPUQ4FTWXLh1or+NivsGWsRF
 mVypICTibk6CzOgeNzhbeKbPcFW2xseGJnWQfNghAg==
X-Google-Smtp-Source: AGHT+IG96TRyZC5rfP+ivX4BwPL9KNuaRnM0xkkHifAHSrJgSaopN6o1fG4JK2cqd1XtXwms6ubgrigcX0vgVkovw2A=
X-Received: by 2002:a05:6402:398:b0:525:7091:124c with SMTP id
 o24-20020a056402039800b005257091124cmr22339415edv.19.1693319960096; Tue, 29
 Aug 2023 07:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230822170209.1130173-1-richard.henderson@linaro.org>
 <20230822170209.1130173-3-richard.henderson@linaro.org>
In-Reply-To: <20230822170209.1130173-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 15:39:09 +0100
Message-ID: <CAFEAcA-T9FLFXr9XVc4a_9ddKmrXJY69YvU7MkcLO389QwDUoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user/aarch64: Fix normal SIGILL si_code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 22 Aug 2023 at 18:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most illegal instructions use ILL_ILLOPC.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/cpu_loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index 2e2f7cf218..22c9789326 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -110,7 +110,7 @@ void cpu_loop(CPUARMState *env)
>              /* just indicate that signals should be handled asap */
>              break;
>          case EXCP_UDEF:
> -            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
>              break;
>          case EXCP_PREFETCH_ABORT:
>          case EXCP_DATA_ABORT:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

