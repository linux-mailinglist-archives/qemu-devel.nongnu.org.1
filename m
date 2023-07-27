Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9B765A8D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3aR-0000BT-1D; Thu, 27 Jul 2023 12:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3aP-0000BE-00
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3aI-0003g9-TD
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso1221178f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690474285; x=1691079085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SqEb7fDLtdXCQ0FEVkKZ1JfH1sE3u+bGhNdu3epiPzs=;
 b=U0gykGZuXn2GSSOogo/sU45GBVa8ew5WcA3m1Yuqpga2Tjv0rguRV4wQxQxKFDf/4I
 iQx4217p4Ui0U+9XHu+M+sdzLgn6u2fWvtMa0QQE0L2fn8cSvUXqicppZhN1k8YBvrJ/
 IvyuuJj8SAMgC6/yMJwXSk3BV+Mxts/fWZ/vVLOn27V5akslOYFLz0i8KkQgXaGrRhtB
 hidg7ILlfcjR0kKn2p0PQMhSR0FJJQocxCfz/0msl4vaKwJePtmCRUXKsxAf/eeNViqL
 daNtWAbujqRG0K14iTDI3Hmtw9Q1pSJyCY31omUPi4J3h/eHyU7HwdvJrzs2L/yuT9qG
 L+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474285; x=1691079085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SqEb7fDLtdXCQ0FEVkKZ1JfH1sE3u+bGhNdu3epiPzs=;
 b=X64JNU46SEf0fxgJIxKccoFIcTmOeGAyHaahDtJ2NhiJlEQYTAPKedFNjkFcelqmP5
 F4vbckg53esOjpWrPRIekvwlwfkXHpnAk84ifgOJhcb8hhOSSD/pBL4QpKMMI4iOOs0y
 RJqZuYwLUtnSP+A43Th6Kuqp1vWDYrtnWBq8laJbWayCOF6pU5T+XUS8MWZx9t71NQcH
 O7OWe/Ztj8twhbuj63rbQWlrIK8jdBYFpf+MgwivM2dkktgmIHqEKg7r2kJDRiCXEkx2
 eQpBy5gLCoowPTo+bmYO44BTx++HesaR9likgpwQY4GlPx+nFhwZNR6g+breRga1ZIE/
 lJag==
X-Gm-Message-State: ABy/qLaNLvlC+p5vY8z9XbJlmlcL3jYa6XVgNYYaMCsc3CGeIR51nJ6b
 gPtcbTpB4xiQVXUNb4wFjdC+0szZCA0Hw4eNggGso1HwiLYhfNrx
X-Google-Smtp-Source: APBJJlH6tTS1otZl/XsfJ/n5RxO4bJE1aNQCd8P3QatVbiYI6wOhpRcGq4SywVS4xbGuMsrbDtil3xZ/9Moe0FMvfys=
X-Received: by 2002:a5d:4405:0:b0:317:70cb:4f58 with SMTP id
 z5-20020a5d4405000000b0031770cb4f58mr1917570wrq.63.1690474285235; Thu, 27 Jul
 2023 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230726030450.757462-1-chris@laplante.io>
 <20230726030450.757462-3-chris@laplante.io>
In-Reply-To: <20230726030450.757462-3-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:11:14 +0100
Message-ID: <CAFEAcA_Js28L0bLwexp9s1CCB5_CU3+cVymq64awriXjf3td2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] qtest: factor out qtest_install_gpio_out_intercept
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

On Wed, 26 Jul 2023 at 04:32, Chris Laplante <chris@laplante.io> wrote:
>
> Signed-off-by: Chris Laplante <chris@laplante.io>
> ---
>  softmmu/qtest.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/softmmu/qtest.c b/softmmu/qtest.c
> index f8d764b719..1c92e5a6a3 100644
> --- a/softmmu/qtest.c
> +++ b/softmmu/qtest.c
> @@ -365,6 +365,15 @@ void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
>      process_command_cb = pc_cb;
>  }
>
> +static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name, int n)
> +{
> +    qemu_irq *disconnected = g_new0(qemu_irq, 1);
> +    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
> +                                      disconnected, n);
> +
> +    *disconnected = qdev_intercept_gpio_out(dev, icpt,name, n);

Missing space after comma.
Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(If this is the only issue with the series I'll fix it
when I pick it up, no need for a respin.)

thanks
-- PMM

