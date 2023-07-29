Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B9768068
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 17:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPlvw-0003Kj-Fl; Sat, 29 Jul 2023 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPlvu-0003Jo-6M
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 11:32:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPlvr-000859-Kx
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 11:32:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso35682375e9.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690644758; x=1691249558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zFSEOV+/KCHbaF2/scRJkd3cPshqRAc2e7Z/Z+qxErM=;
 b=CpsJqyWGVqnC9Trucnn1BfQlbKPTY47CpaMPxOy8ea8Sg8IUMvfEVB/8KwvFEPoU7j
 XcPhGxKe7zVEehqdCEyWRE3B5OklymmLFIIoqkhobryMDx21goT1GvvyIvQITu2S9K6i
 Y/uH1hJHUJqRcTmDY7EN3ZJkdat2zQcz6TDZMf+U1H8ysQZJxeGz6GWKTRSHhEg7G2iu
 /VIaQOP9j5XXLYRBTCTTpRjyiuZN7emwoEnIDZTungtwGdFlsKk6tDyXDmpWL2SDWan4
 WhUoavLia0xg3A9j1jYT6e96X3XyDmJYvibMjYr/v8/2zbyJmSs9NZdsl5+do/yA0J0R
 sHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690644758; x=1691249558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFSEOV+/KCHbaF2/scRJkd3cPshqRAc2e7Z/Z+qxErM=;
 b=FlGaL3NeWdJd6yW5T9sOK784fKWLgiX1qmjjGSS77ApeLUdoNPx+YeBvMN9prmG8Wa
 yLIfj0G4fOtGw+BybEe1Ij/gA7Q+StHS9BvLM+WZZxnrT4UO5Vnop2YYbd18dw2iwenl
 4nfQBFSfgWouFLYHQH56IHfv65gyLY5Bb9Vk3u2GMwAG+X4h6PlmZBcBckEAEs91xieq
 HFhpZqCUhg90hmQ9f6g6OR6gQ9j8CppZ55gv/k1buMJ24loopj0sWVi20hMEHU0lPouB
 wRRgNATGOZL4Ijy2m/EhPho0EJ4XwB7GlPvXyd6A6tihUcCQEXYnsvuHdENlAxt8CqP3
 wIQw==
X-Gm-Message-State: ABy/qLYtf8WRrS0FGow2PNJ/qd+47ahVfn3GYVPIE3ySMheizFJPsZ5v
 PNmBRgwkcNCp64zRIO0r29txBvwiOgehTMM77ARK8g==
X-Google-Smtp-Source: APBJJlFSFS6fgkDPSs6V2VQIjDu1/itJ7No0ThVx4F6Zvby34TXMlErAPZgl8GyBiRBbxbOyvdJG0DYomQ+Rxc3buos=
X-Received: by 2002:a5d:458a:0:b0:313:e520:936f with SMTP id
 p10-20020a5d458a000000b00313e520936fmr4847388wrq.17.1690644757984; Sat, 29
 Jul 2023 08:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230728195646.168997-1-danielhb413@gmail.com>
 <20230728195646.168997-3-danielhb413@gmail.com>
In-Reply-To: <20230728195646.168997-3-danielhb413@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jul 2023 16:32:27 +0100
Message-ID: <CAFEAcA9vsv4BpSfFb6=W=MFjGdR283KEGFN13Sfy=TxtcjT4hA@mail.gmail.com>
Subject: Re: [PATCH for-8.2 2/2] target/ppc: use g_free() in
 test_opcode_table()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Jul 2023 at 21:47, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> Use g_free(table[i]) instead of free(table[i]) to comply with QEMU low
> level memory management guidelines.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e6a0709066..d90535266e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7129,7 +7129,7 @@ static int test_opcode_table(opc_handler_t **table, int len)
>                  tmp = test_opcode_table(ind_table(table[i]),
>                      PPC_CPU_INDIRECT_OPCODES_LEN);
>                  if (tmp == 0) {
> -                    free(table[i]);
> +                    g_free(table[i]);
>                      table[i] = &invalid_handler;
>                  } else {
>                      count++;

Where is the allocation that this memory is free()ing? I
think it is the g_new() in create_new_table(), but the code
is a little complicated for me to understand...

thanks
-- PMM

