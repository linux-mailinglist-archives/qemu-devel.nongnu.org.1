Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1570363E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybfJ-00033l-Nu; Mon, 15 May 2023 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybfH-00033K-MY
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:07:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybfG-0007be-AN
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:07:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-50be0d835aaso23117412a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684170431; x=1686762431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcEJdkZfKI6/8JKgsBtqTZRTx19UDPfr04WSktSYAXc=;
 b=sJxo6uhyhExSo+njdMguN1l0oGpPcy83gFeNGpT26KRjENmiqfOkHy+NtkMBnZB4fW
 YA2hqe+c6qM0op2pQPV8a6ZHPU281SYT+UMMtUeJyGLswuvrCjeItklj/i98Q38Kwy46
 EJgJaGSKgZfWAwWIN+QnmP8Y7mpxUZ+1Zx+TDaiupP7PEgc/Y0+6g8Uv7eZkTKX1NQHa
 MsBJz560OuHP7exgGSXLNGFmCLUzEpR+qyx2JcCkT5+CshLq/hd+vbcmR0UXAQOczkCt
 3iF/mDdz8qr60asunM4NlrYwQWt8PDiRAwL7dyvS+jUp2fFV3ACIHQrekRfLWDeVGS4Q
 T5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684170431; x=1686762431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcEJdkZfKI6/8JKgsBtqTZRTx19UDPfr04WSktSYAXc=;
 b=XZsAApzWBk58RUe984E4NJD9NjN8sSLvCi3cDeKaN4N+syuC2RIjMIosPWzYGU5fUj
 OSQNIIcPkYvt2n5ztfuSm9PCpX09v5przE6n8lwL7ICfvrLDhpxdoQOsMmZ+YthGKJ8y
 pPfEr+YuOIAQs4rISbG0EsigdBoJFXGwkS9PLSLz33wM2wzbWoay7Ibqd2aVmCUKrnhH
 xZx3f80yE1JFB4P/5LJbYH+QTCfa0fQeYWFaaB3HwRRW01xJmPmjXJF5/Idoegtj1h8j
 KkNESez98R0Ctc25NYGvRLviqyJLed5tzWUNjZyFmAw9JJxqeum8JsFy+wef8qef3q7m
 gqXA==
X-Gm-Message-State: AC+VfDyYgUrP9p7ou+Qij/i+hEmUM+WXyCvH7Ej6lEvQJLFbUdK0F9Sd
 jw74/Hj/QwUnme7t0qD40VAZ5aDkaxR7OG6EKRry6w==
X-Google-Smtp-Source: ACHHUZ7ztDHpHIeUn1+YsVezUjcAk3fLptxwlhU+8gQpihsNAJW/+/I1BJavtA0+FcL9sh6WwFaIT948/eN9ZJkll+Q=
X-Received: by 2002:a17:906:dac8:b0:969:f54c:dee8 with SMTP id
 xi8-20020a170906dac800b00969f54cdee8mr20431833ejb.35.1684170431251; Mon, 15
 May 2023 10:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-26-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 18:07:00 +0100
Message-ID: <CAFEAcA9dwVJ8bTXezcCZZB0zLQaxUJxOLZ8kyfBjkRshHkSwAA@mail.gmail.com>
Subject: Re: [PATCH v5 25/54] tcg/sparc64: Rename tcg_out_movi_imm13 to
 tcg_out_movi_s13
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 15 May 2023 at 15:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Emphasize that the constant is signed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

