Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52375FBBB
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyGM-0008N4-HN; Mon, 24 Jul 2023 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyGI-0008MI-8G
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:18:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNyGF-00079M-Tr
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:18:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5221b90f763so3482771a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690215493; x=1690820293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=utcIOUQy29pwxPWMk61rnbuXNjGfPHdb1RUnlocbdis=;
 b=H6ucUkFS7/76c3HgnTud1AyBJP8QynY+zt3BgOnEu+EjUrXNQ/fR5rSO740fevAtuR
 aB/+6ZBVFzg0lvB2ZHeulu4ZRH7qQSnW3Rxg21BhgYZ3OawywXvKgPB1m6KFmWQZp2Jt
 2xju2dtAObQQfnWQGYhbHCOkFgPZ7YNTkxbp3La5FdAlxG0ycVnFGZumCl8lv2OyBDPU
 NimtaORWADt/SXfdqB2kSh1bAVNjLyid74L6F2Htd/GSl98wwvOgb+jK41QUDADZcJ1Q
 8TNtxpmH0Bta7hlhphcUhgvP/+Tf4+0v7hx5TemjeZ8YpR4RcmA3qJBIl7iC9NDJSlJs
 6fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690215493; x=1690820293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utcIOUQy29pwxPWMk61rnbuXNjGfPHdb1RUnlocbdis=;
 b=jL+FwwrmIYUYCXtc/BBfB6dKppXboak0A+GXT7j9z9XnRu9LJcQCatEkuJ3TE3micj
 Cpz4Sw0tQKEqxeo7SQegOIbyr4Ox0ruCl6E8t10ykG4wTjACcIafDXZCAHeQPSFDvloy
 MGeDlRHHqfFXkCTvUTp89oJD1NkIUBkAOBa9+KbWWMtGNid+Xu/hiHOij4qIvkA3pShN
 OJqDTjhiHn9S9J4YO8Z/hY3l2VkEHorgwEHTNHOUZEy4gphVlxMHqadnfzROJDnVNTfT
 TC0krt3dW9YGrGwboCn5qNQuxxDdYn0vwzREY+b7YfubKRUP2EeemPVFDxlGyaHi+77A
 ik3Q==
X-Gm-Message-State: ABy/qLZaVuCwa9KoRKEQQTDMO8Fv7wmU+0JwIrLbf6n3vDJyNK8lxTOC
 suPmSaf6gDGCWFSHFXEym1Rc6UFFsJnSUexlXyJWAN9hclzS1GLm
X-Google-Smtp-Source: APBJJlFeUBdpNvdTMzK2GQtGafdbm4ThDWEAiRNwOdJu37Olwoy4zVT9MuAvZeC+te+UYS+apXB0pD7Kj3vuGHjteWA=
X-Received: by 2002:aa7:d707:0:b0:522:3149:1596 with SMTP id
 t7-20020aa7d707000000b0052231491596mr2315996edq.13.1690215493523; Mon, 24 Jul
 2023 09:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230714232659.76434-1-chris@laplante.io>
 <20230714232659.76434-5-chris@laplante.io>
In-Reply-To: <20230714232659.76434-5-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 17:18:02 +0100
Message-ID: <CAFEAcA_dxxi5SpnKiid4GZ+BbshT4xchx+ew=F1oiw6s4ZtX7Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] qtest: factor out qtest_install_gpio_out_intercepts
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 15 Jul 2023 at 00:27, Chris Laplante <chris@laplante.io> wrote:
>
> Simplify the code a bit.
>
> Signed-off-by: Chris Laplante <chris@laplante.io>
> ---
>  softmmu/qtest.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/softmmu/qtest.c b/softmmu/qtest.c
> index 74482ce3cd..051bbf4177 100644
> --- a/softmmu/qtest.c
> +++ b/softmmu/qtest.c
> @@ -365,6 +365,15 @@ void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
>      process_command_cb = pc_cb;
>  }
>
> +static void qtest_install_gpio_out_intercepts(DeviceState *dev, const char *name, int n)
> +{
> +    qemu_irq *disconnected = g_new0(qemu_irq, 1);
> +    qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
> +                                      disconnected, n);
> +
> +    *disconnected = qdev_intercept_gpio_out(dev, icpt,name, n);
> +}
> +
>  static void qtest_process_command(CharBackend *chr, gchar **words)
>  {
>      const gchar *command;
> @@ -421,23 +430,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>              if (is_outbound) {
>                  if (is_named) {
>                      if (ngl->name && strcmp(ngl->name, words[2]) == 0) {
> -                        qemu_irq *disconnected = g_new0(qemu_irq, 1);
> -                        qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
> -                                                          disconnected, 0);
> -
> -                        *disconnected = qdev_intercept_gpio_out(dev, icpt,
> -                                                                ngl->name, 0);
> +                        qtest_install_gpio_out_intercepts(dev, ngl->name, 0);
>                          break;
>                      }
>                  } else if (!ngl->name) {
>                      int i;
>                      for (i = 0; i < ngl->num_out; ++i) {
> -                        qemu_irq *disconnected = g_new0(qemu_irq, 1);
> -                        qemu_irq icpt = qemu_allocate_irq(qtest_irq_handler,
> -                                                          disconnected, i);
> -
> -                        *disconnected = qdev_intercept_gpio_out(dev, icpt,
> -                                                                ngl->name, i);
> +                        qtest_install_gpio_out_intercepts(dev, ngl->name, i);
>                      }

I think you should put this patch before patch 2 -- create the
new function first, and then you can directly use it,
rather than first creating the duplicate code and then
getting rid of it.

thanks
-- PMM

