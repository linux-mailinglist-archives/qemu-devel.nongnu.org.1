Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F67CC518
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:48:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskQB-0005mS-JO; Tue, 17 Oct 2023 09:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskQ8-0005mE-Nk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:47:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qskQ5-0005FZ-So
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:47:40 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso8873923a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697550456; x=1698155256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kT6tbBlWVaFEs6BExuSkBQhN71HDEFU/UCl0nf/kFuw=;
 b=GSDWUIETNJEIlXIn0G3PDf94BsVyo8S50k2cIGLRbnM/ixmQoji3pt2O9q8uAwl5j4
 7yNXAz6e3/0eXgQCrD3Da9a+As/mznAc30MlGVrH4ar90ut/lFyU8gHZyiDy/KWFNgMG
 fmz2KXR7/am9A2UUPPQMoIBlnpU+j0YNcui8Bv5lIeHA/iNioFGdwAgQvsD5lx9VFUrR
 wipo6QfZzoJljUtj2Nz1Dijvzo2v6DknYXfH5Eyt4q9pOOkJy4S3BwFihmUWK8Lc5W5q
 JjE+ehiGXpJGXta7+phuzQsL4efWjy+PVkuNPBJIETA3nIM5gTgmM0sUv+wMLBONZx9K
 qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550456; x=1698155256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kT6tbBlWVaFEs6BExuSkBQhN71HDEFU/UCl0nf/kFuw=;
 b=s7DkDBfLpH4pbQToF4R8i/hzuEo1SE8THRVd0dMYk8eawwjaiWIJmvsJRqypw0PcsQ
 IgUHJtB248+NjxjPEmnoXaYxxnwKO5oPnDWo5nyJR7gVjn+egF/zgnXh9XkwAVTdAI5g
 PhVrrtwEtZGJ3w/o86JGxiKZ3sawMgFu0164f1jjPol7px7xhy7x914xGBac7iuYq/8E
 5UUG+KuoJSwVafBAc8Qn+Rbh5yrQRmSo3vJkBkpm0jBnVusl1wTqVTNtuGTPRYCBJKhL
 2bSp9DuUw9HEu5EEyMGLs5zQWBsLKK+raC2rHFLU6/51EXoCe3ZjKOnLeJVuvV6IlVcs
 3p9g==
X-Gm-Message-State: AOJu0Yw5j4Kr56Mz8iqzeIylreQ1wWJznaFE/qDOAqy0uauA9JZkgjtw
 katTJGGizdtBaKht84eGyfiY/7epHh0wA0Sxp4aEmg==
X-Google-Smtp-Source: AGHT+IFW81zNVA91TlAcOOEGxWhdHH9O5JR5Hq8wGF9+jzWiWplM/LYNBSB8N25NTBtA2MTnPcU8HqaA+CLv9RyX2ak=
X-Received: by 2002:a05:6402:35c5:b0:53e:b8e2:1d58 with SMTP id
 z5-20020a05640235c500b0053eb8e21d58mr2055604edc.13.1697550456212; Tue, 17 Oct
 2023 06:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231004142746.350225-1-tong.ho@amd.com>
 <20231004142746.350225-4-tong.ho@amd.com>
In-Reply-To: <20231004142746.350225-4-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 14:47:25 +0100
Message-ID: <CAFEAcA-s61X-YAc6Fx27HWAdoGEWt3C9dRa-ncNUaMb5RPwxYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 4 Oct 2023 at 15:27, Tong Ho <tong.ho@amd.com> wrote:
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  tests/qtest/meson.build             |   2 +-
>  tests/qtest/xlnx-versal-trng-test.c | 490 ++++++++++++++++++++++++++++
>  2 files changed, 491 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xlnx-versal-trng-test.c
>



> +static void trng_test_autogen(void)
> +{
> +    const size_t cnt = 512 / 32;
> +    uint32_t rng[cnt], prng[cnt];
> +    size_t n;
> +
> +    trng_reset();
> +
> +    /* PRNG run #1 */
> +    trng_reseed(prng_seed);
> +    trng_generate(true);
> +
> +    n = trng_collect(prng, cnt);
> +    if (n != cnt) {
> +        FAILED("PRNG_1 Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    /* TRNG, should not match PRNG */
> +    trng_reseed(NULL);
> +    trng_generate(true);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n != cnt) {
> +        FAILED("TRNG Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    if (!memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("TRNG test failed: matching PRNG");
> +    }

Why can't the TRNG output ever match the PRNG output ?
It's random numbers, so you might get (un)lucky.
This sort of check results in flaky CI, because very very
occasionally the RNG will give you output that results in
a test failure.

> +
> +    /* PRNG #2: should matches run #1 */
> +    trng_reseed(prng_seed);
> +    trng_generate(true);
> +
> +    n = trng_collect(rng, cnt);
> +    if (n != cnt) {
> +        FAILED("PRNG_2 Auto-gen test failed: expected = %u, got = %u",
> +               (unsigned)cnt, (unsigned)n);
> +    }
> +
> +    if (memcmp(rng, prng, sizeof(rng))) {
> +        FAILED("PRNG_2 Auto-gen test failed: does not match PRNG_1");
> +    }
> +}
> +

thanks
-- PMM

