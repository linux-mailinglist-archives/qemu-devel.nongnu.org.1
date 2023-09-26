Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E367AEB0C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5uI-0002wi-Vp; Tue, 26 Sep 2023 07:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5uD-0002uy-Qn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:07:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5uC-0008B2-73
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:07:05 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533f193fc8dso5382039a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695726422; x=1696331222; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+RpF60g+zF15X8BZcG5Wj6sP7OMSjKXfIR+38yCTAE=;
 b=VdgmXTCGqOJnRhZRMctJ3tj++EDZHaKDQTeqZo0IheRyLzE1JF4aRJBekM5YSXkGDS
 xglDfQI6gNDtmSEQuG5uNqNv/CxjR8gJtH9/Y1AdtbiLEjPO3xA3k/XY/EMPFxLDWYKV
 rw4OpMW3AT20NNYFrzlEbU/U6T+wdtHYoKyPR/g9uxhSsDWtkA0v9MXd2yQmUpXQyUnA
 mx2ShMuF9P3a/XQcFPHrVMbNJfU2uOeblDFYXrzpSKWzZjgAaUE92uyOVe2XOqgi67wk
 704NB5RbrRmtySKQTfWP3OZnUAXMfVQUr1c64n9MimzvhEmuTk1q55uCKNRbQWpON5fF
 YuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726422; x=1696331222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+RpF60g+zF15X8BZcG5Wj6sP7OMSjKXfIR+38yCTAE=;
 b=Acf5IWW8wATVZTdgSIxDxTNYLr9daMX+SvS7EP4CCKqt1l++WS9adIt0TJeWRcXdj2
 XmZG2q9EYmWTWIjqZTASN//cRKoZTZaESawnqKHSmnNN/kI8bOjOe7aWKw32RJ5/da/N
 sPR0XfYHkCoK2gzFqbq534rQ2RmxfyAX6l92M3NYJI1c/3XO5Re/3Bto03okQBPvCbbs
 gyrGgD94xFXMIMWEHj9L2XU6E/IIJTSu5kAfJDid9I53ZqgsRpYRESRH9vQjfGqVoXB2
 h/OqJptcD3/k4/xY7WbLeVhl0DX2Sh3euu/Z3EEgC1/GETEbtKCsS7+x/TZhth5wfn0W
 RNGw==
X-Gm-Message-State: AOJu0Yy8GC8aGljF0fah0n+wFUICABkr+gMumCpcHQz9TC2uP+EVdiVt
 H/Ebdc4kIY9wMayTPTE7Sm3v15UptIxpT21rNpfRew==
X-Google-Smtp-Source: AGHT+IGtwkNIpWFh+mI1r0E8wmGZGjNJtez9F70CUYQ/h+K5mV6EQlYimom6N4jfHe5S7dGoTxsxp9rsHJmbldBP8EE=
X-Received: by 2002:a50:ec84:0:b0:527:ab3f:4350 with SMTP id
 e4-20020a50ec84000000b00527ab3f4350mr8447022edr.38.1695726422553; Tue, 26 Sep
 2023 04:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-11-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-11-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 12:06:44 +0100
Message-ID: <CAFEAcA9smnXCG_3WtmXeRHhwmioaaAqJmCOfju=XGRT5rC6mkA@mail.gmail.com>
Subject: Re: [PATCH 10/12] hw/core/loader: gunzip(): initialize z_stream
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
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

On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity signals that variable as being used uninitialized. And really,
> when work with external APIs that's better to zero out the structure,
> where we set some fields by hand.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4b67543046..aa02b27089 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -573,7 +573,7 @@ static void zfree(void *x, void *addr)
>
>  ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen)
>  {
> -    z_stream s;
> +    z_stream s = {0};
>      ssize_t dstbytes;
>      int r, i, flags;

Same remark about using "= {}".

thanks
-- PMM

