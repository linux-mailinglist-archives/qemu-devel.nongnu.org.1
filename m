Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F937475C8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiPR-0002lZ-Qh; Tue, 04 Jul 2023 11:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiPP-0002kc-Af
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:57:43 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiPN-0000yx-N9
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:57:43 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fbb281eec6so3671181e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688486260; x=1691078260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQ8LXiCqh/l23yZNrjpE9MSSiltordpEW1zSioWxsEI=;
 b=IHvaI6QUr/kc9KnPFRcKWkV0tLNbh/UjnLD0XOo9TeESrJrDv/rcSJKdePWsqsvhmU
 zOqapOVzuM0kKzndEdRlKvv0B8HBvf7W/wu1uyPN8iAq4iayndand1iHDdRQhZYYwMDL
 9/xKNcWLosbY7Waz/4uNNuauBaD3kjh3Xt+k8FWs89eWzUAgdEvi/ehyC2/GMe3Xt90M
 o3NV1TKnItNUl9Og1Bhp1Nz199bmBnEebUx1QY9hNQCwOjllb5gCg56lc4at6pm0ygeH
 3a6rkwbWTGtC/7D3Nj6ZINkcmRxkMuBg+UCDcZfY0yf69snrnKkhB0OgLR/Y+ba3nr2U
 zi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486260; x=1691078260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQ8LXiCqh/l23yZNrjpE9MSSiltordpEW1zSioWxsEI=;
 b=C93otGI1uEofZ1BK32dUwrdl36dnS3RZDxzzvjfIZJYWmLvw1RhWTbVq99W6K7JHT8
 8GH+OzzK/toIbVHxIrZxwRclQYdjgjH1xq2GB9pFFrHxCPk+J1+0SsFsXUNcnuHpVABT
 f06yraawZGxorqeKgurrlKEm4h8WfZBz8wjJonvPnr1Ax5b0KlleX9WUBEyejzg8g+Rx
 ld1obfwvFkxCFGZChw2FnMD3FgeH0C/QRYo3jPzEFIeipU10pqjqH31gpCMFQTKMe9yl
 /KXayFUp9eSauZzQHrHX7Jd8btJHBWel4TNFPPeadu/Wr1+OsRuyd2Tc2hz2QX2q1r+6
 SmXA==
X-Gm-Message-State: ABy/qLZEDA2cMh/nG4LyYyVMyKf33eSebMDVOxeCWtSHKrXC4d7jKvTF
 O6DmndB2ePH1xGtuR+JNfBrJQKZjCWKGb6UdQNSCbQ==
X-Google-Smtp-Source: APBJJlGGp2d67/grA2i5YMY3DZV2I9DFdoFA/0ylwdAr8TuaWmQgKb1KAMhZq52mLTupbNbvLj+GsKPd0GiD6OxBIpo=
X-Received: by 2002:ac2:5b5c:0:b0:4f8:5d94:2e46 with SMTP id
 i28-20020ac25b5c000000b004f85d942e46mr9754294lfp.48.1688486259959; Tue, 04
 Jul 2023 08:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
 <a96bffba-9653-95b3-4b7c-8787646f1f21@linaro.org>
In-Reply-To: <a96bffba-9653-95b3-4b7c-8787646f1f21@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 16:57:29 +0100
Message-ID: <CAFEAcA9rqf6QmG-WWebNmeUPEsmtUCAEtr7miHWaQkk1Bner1g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 4 Jul 2023 at 16:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 4/7/23 17:43, Peter Maydell wrote:
> > If you build QEMU with the clang sanitizer enabled, you can see it
> > fire when running the arm-cpu-features test:
> >
> > $ QTEST_QEMU_BINARY=3D./build/arm-clang/qemu-system-aarch64 ./build/arm=
-clang/tests/qtest/arm-cpu-features
> > [...]
> > ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is to=
o large for 64-bit type 'unsigned long long'
> > [...]
> >
> > This happens because the user can specify some incorrect SVE
> > properties that result in our calculating a max_vq of 0.  We catch
> > this and error out, but before we do that we calculate
> >
> >   vq_mask =3D MAKE_64BIT_MASK(0, max_vq);$
> >
> > and the MAKE_64BIT_MASK() call is only valid for lengths that are
> > greater than zero, so we hit the undefined behaviour.
>
> Can we fix it generically?
>
> -- >8 --
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -28,3 +28,3 @@
>   #define MAKE_64BIT_MASK(shift, length) \
> -    (((~0ULL) >> (64 - (length))) << (shift))
> +    ((length) ? (((~0ULL) >> (64 - (length))) << (shift)) : 0)
>
> ---

Only by introducing a conditional in the case where the length
isn't a compile time constant.
Like the extract and deposit functions, the assumption is that
you're operating on a field that actually exists and isn't
zero-width.

thanks
-- PMM

