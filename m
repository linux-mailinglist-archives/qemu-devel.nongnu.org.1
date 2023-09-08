Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45770798703
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaca-0000VU-Kj; Fri, 08 Sep 2023 08:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeacT-0000Tt-R5
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:29:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeacP-0008Gn-5m
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:29:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a250aa012so2727136a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694176187; x=1694780987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsBjSf/Oqr6JNO/88tdhEJwHCQogVJruaAB/1SqX/+Y=;
 b=xa0BwLVMMFoKWULwYxEP5zXJHaJi2SjOf37CaU5oFCwShVHVW3Vo9F85UxpICty4nh
 vUne+scJCYlorX99rvq/7mP40zm4eJVFZsIRVyoseEMXaCx3AUeW91c1TM9FC8/lA1YM
 11rPBNyzpU+TaEO7CSR0Ft6As5XG3XXHEsuOqJmOl5eJwZOLEuMchOXcSnxaOnnaKZ8+
 NClZHem/DiExqkVZs1SuYY5b0AUzpTwdKhpdz9T/bX4rCQ5cQNdQ3z5wOwTapeJFaNs7
 OSAhOM3x9YEMUGgxcwWtnoABuyURT4htKYxiO61TvyGt8gCOU5oLDkfKnO6eCYjm0IGW
 rUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694176187; x=1694780987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsBjSf/Oqr6JNO/88tdhEJwHCQogVJruaAB/1SqX/+Y=;
 b=OHI/jVpVk9FqPKWbsT4sqWmurKZROtwK0uupCRMY5J0bl+SE51EMcu2MpMX5w6G35n
 6iBbjrbVa4FOLESXqZ1wAt4QJ4AM1tkUvMRbNBFbab5IZ/DpC16UjvlSQHM7p6QqysqB
 Ol+a7KhJ9wmqLu7AVezBy8lLnQipR1UyY0crqYY1DogqN1yWzOj78iYUhntmUpoMoWQt
 ky2XkuSJw8muX5TXCByTgi3c6QTKvMhcNKRzmU0MQzCi/PscloUB9odk2hNeBonvU9+J
 vCoXAshwocynmuFBKGhc1LVLrM4TVgEKuxshn+QWZJrI0pKKJy0ViHjkT/BYYGB0X0Pe
 vGfA==
X-Gm-Message-State: AOJu0YxZlHv+iIjIZF0911dqHRoFb3P2aYrenkt6cuJ03ZkNQz4i0XdU
 iNXqBSbzmYRrhrCm4RXYd6UtIz4RhrbH8QD/ZUSULQ==
X-Google-Smtp-Source: AGHT+IGqLf/3vxdrh+R9urnka4e+AjgUzTDGJSl1FKhfaV/G8OdXbyg+hnsi7+uym1SBfhX5kdOPfbo/sjQjl6C34bk=
X-Received: by 2002:aa7:d793:0:b0:525:5a65:6dfa with SMTP id
 s19-20020aa7d793000000b005255a656dfamr1841382edq.14.1694176187594; Fri, 08
 Sep 2023 05:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-8-philmd@linaro.org>
In-Reply-To: <20230904161235.84651-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:29:36 +0100
Message-ID: <CAFEAcA9HSw4LJMeRk2N6iNRLSF=1JaY8eUoS8SQnMUuxLkdwiA@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] hw/arm/armv7m: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 4 Sept 2023 at 17:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   hw/arm/armv7m.c: In function =E2=80=98armv7m_realize=E2=80=99:
>   hw/arm/armv7m.c:520:27: warning: declaration of =E2=80=98sbd=E2=80=99 s=
hadows a previous local [-Wshadow=3Dcompatible-local]
>     520 |             SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->bitband[i]=
);
>         |                           ^~~
>   hw/arm/armv7m.c:278:19: note: shadowed declaration is here
>     278 |     SysBusDevice *sbd;
>         |                   ^~~
>        ---
>
>   hw/arm/armsse.c: In function =E2=80=98armsse_realize=E2=80=99:
>   hw/arm/armsse.c:1471:27: warning: declaration of =E2=80=98mr=E2=80=99 s=
hadows a previous local [-Wshadow=3Dcompatible-local]
>    1471 |             MemoryRegion *mr;
>         |                           ^~
>   hw/arm/armsse.c:917:19: note: shadowed declaration is here
>     917 |     MemoryRegion *mr;
>         |                   ^~
>        ---
>
>   hw/arm/armsse.c:1608:22: warning: declaration of =E2=80=98dev_splitter=
=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>    1608 |         DeviceState *dev_splitter =3D DEVICE(splitter);
>         |                      ^~~~~~~~~~~~
>   hw/arm/armsse.c:923:18: note: shadowed declaration is here
>     923 |     DeviceState *dev_splitter;
>         |                  ^~~~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

