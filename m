Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36A7658CB
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3mF-0003Jc-Tu; Thu, 27 Jul 2023 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3mE-0003J8-Dd
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:23:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3mC-0007e2-R6
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:23:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso12871075e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690475023; x=1691079823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V36/DHcWI5oDYfiNaB4fBVaYDTTuSZ7njmDgF6uH6ZY=;
 b=S2slxnvTwXBHnvncqwDbsc7QtMvDuJYrGSM3uxbAwINLV8SvdsPar4hG5alc7EpejT
 zwEzTbNysDFgdSI9HnyWnZHlzsfWP4I4uoh7Bu2mXlXn2A5ATQN31kaBmCrizyWEoLxb
 Qnu14RAUerQObUMgnJmZFSuidJRWgIVwgQtwOPVZfXCPGH86C4l73mEUa+cPT2IbYaLh
 9wlf18coqllWVjZWjiItjXkN7k/seqXr+gHbF6GwigAw4em8SufnPrfsKslYtvsX3ysI
 bg/ggG3tZUbAggsdLkAtrjD9thC56rsAoBrvTn+fQ3bq7rkDzXBRZy1MluinjQYyU2nN
 GTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690475023; x=1691079823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V36/DHcWI5oDYfiNaB4fBVaYDTTuSZ7njmDgF6uH6ZY=;
 b=ihSk6TDbhWjLyJKCCQ74MzdqhuLzFMiZRdMEPFWCWvPVGR2aezK7qFGMBySpsykljR
 3nnARHh38brVvDtaBvwelz0YiD7pWGW3lie6Kjzdp1+zFmJz9CvTli742iPfYj6jjy58
 PtcbXHmRPWn4kdZAwoeClWjetN+IqcCcpj/E1CiZ0ecvbv6lhUC3QbeTb4kklcZCygFo
 gJa+H0J2w+/R31R0UX7/UZd6TWJc3ZfBvfgja9it1EMrw9T12m9hh+Xs8RtUeV5w/IPL
 tSvLyXUV1pCgRtkhgOPfMDhDlUrOzOekKy+oH4EYkO15OMez98rqPWL2BKhc53qDAzuy
 hQEA==
X-Gm-Message-State: ABy/qLbL9F4u4z5DhtimlxCxHqSKNUPMrfp+hmi9+vL0Y6OoCdf2RJwt
 MMjpVsSgcpgQUvnmI18nG82FwSCJ29TW8p8b+C8gKA==
X-Google-Smtp-Source: APBJJlHudoX4YxnrA3drqGxH8R8ovrAp5DzJvWwEq50NPISAkDAqBeIFQ0meSPJi/PguIQ32ho4bkxa90tlm3VYB6xs=
X-Received: by 2002:adf:d0c8:0:b0:314:1a09:6e71 with SMTP id
 z8-20020adfd0c8000000b003141a096e71mr2010900wrh.53.1690475023256; Thu, 27 Jul
 2023 09:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230726030450.757462-1-chris@laplante.io>
 <20230726030450.757462-4-chris@laplante.io>
In-Reply-To: <20230726030450.757462-4-chris@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:23:32 +0100
Message-ID: <CAFEAcA_K+Rzt8=0apiyO5tB3EwTRJMo8afKu3wkb2=jAsyLvmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] qtest: implement named interception of out-GPIO
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

On Wed, 26 Jul 2023 at 04:32, Chris Laplante <chris@laplante.io> wrote:
>
> Adds qtest_irq_intercept_out_named method, which utilizes a new optional
> name parameter to the irq_intercept_out qtest command.
>
> Signed-off-by: Chris Laplante <chris@laplante.io>
> ---
>  softmmu/qtest.c        | 24 ++++++++++++++++--------
>  tests/qtest/libqtest.c |  6 ++++++
>  tests/qtest/libqtest.h | 11 +++++++++++
>  3 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/softmmu/qtest.c b/softmmu/qtest.c
> index 1c92e5a6a3..7fd8546ed2 100644
> --- a/softmmu/qtest.c
> +++ b/softmmu/qtest.c
> @@ -397,8 +397,12 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          || strcmp(words[0], "irq_intercept_in") == 0) {
>          DeviceState *dev;
>          NamedGPIOList *ngl;
> +        bool is_named;
> +        bool is_outbound;
>
>          g_assert(words[1]);
> +        is_named = words[2] != NULL;
> +        is_outbound = words[0][14] == 'o';
>          dev = DEVICE(object_resolve_path(words[1], NULL));
>          if (!dev) {
>              qtest_send_prefix(chr);
> @@ -417,14 +421,18 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          }
>
>          QLIST_FOREACH(ngl, &dev->gpios, node) {
> -            /* We don't support intercept of named GPIOs yet */
> -            if (ngl->name) {
> -                continue;
> -            }
> -            if (words[0][14] == 'o') {
> -                int i;
> -                for (i = 0; i < ngl->num_out; ++i) {
> -                    qtest_install_gpio_out_intercept(dev, ngl->name, i);
> +            /* We don't support inbound interception of named GPIOs yet */
> +            if (is_outbound) {
> +                if (is_named) {
> +                    if (ngl->name && strcmp(ngl->name, words[2]) == 0) {
> +                        qtest_install_gpio_out_intercept(dev, ngl->name, 0);
> +                        break;
> +                    }

Named gpio-outs can have more than one line, the same as
unnamed ones (you create them with
qdev_init_gpio_out_named(dev, pins, name, n) -- there's an
argument for how many to create), so I think this is_named
branch also needs to install an intercept for each one, not
just for 0.

> +                } else if (!ngl->name) {
> +                    int i;
> +                    for (i = 0; i < ngl->num_out; ++i) {
> +                        qtest_install_gpio_out_intercept(dev, ngl->name, i);
> +                    }

...at which point the code looks pretty similar in both branches
of the if(), so I think you end up with something like

         if (is_outbound) {
             /* NULL is valid and matchable, for "unnamed GPIO" */
             if (g_strcmp0(ngl->name, words[2]) == 0) {
                 int i;
;                for (i = 0; i < ngl->num_out; ++i) {
                     qtest_install_gpio_out_intercept(dev, ngl->name, i);
                 }
             }
         } ...

(g_strcmp0() can handle the NULL case without having
to special case it -- this is how qdev_get_named_gpio_list()
finds entries in the ngl list.)

Apologies for not noticing that on the first round of review.

thanks
-- PMM

