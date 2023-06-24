Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8D73C51D
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 02:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCr19-0000xt-Gf; Fri, 23 Jun 2023 20:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qCr17-0000xW-Cy
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 20:20:41 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1qCr12-0007Rn-5C
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 20:20:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1013253a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687566034; x=1690158034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2k5k+vJC/BWSezT5h637w0Jb5V4aA6vPo+6MxisBmw=;
 b=ez5gJNN/xypD96aE3j5QdBvRwuOa9qvjGw0rvAOS49pUOR5gV4Dv1JNt8zcKR7oyci
 BqPABhFndUwyW1HtwJJxPmOeq/KUEwb98KcKJTEQDmm46BfQxrdNTEFlRHAmMWH1NRqg
 Wyx/ElNO2hOTMuP1UG4qbnEr6lAgK90aN4cml0a5XniQYAi5slZ/mJHsOYeYVHb2GHf4
 OpFQD701u8TQUJkzVE8e6s2f3jcmTDfXq2/5+28+lgudJHlJTsvTiBYbKC9FT5c63E6+
 Wy6V1jBXZooQnv7kIv6UF8cbdM+P+cqF5oFtaPa1QHbAMy9H8eCdzhcpBBX5uy+U7sv9
 Eytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687566034; x=1690158034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2k5k+vJC/BWSezT5h637w0Jb5V4aA6vPo+6MxisBmw=;
 b=ZyRt1rXjSvTEcoA6G4XZl/SEyTFEvizpFKDjIBPr1SMmJkLBJFTKBOA+azq6yHkxaH
 knZ1MbHDQtcTt6seiwlZhG1GqaiQCkUqkNbxVGBOls4L/HRvrOC3Rs5GJFnEuQJwbx42
 VUWsVrLZpkHeTD/FhObARzxJ0m0H/o7RtODin4iGfPSSTmpPazk0yvQK/+TicgepVQQw
 YD9hbV2kwdHNihZr4vJwDr2D3qFnmi3JP3hshgOBb0x6UtdVXnFrny/7D7eNNjScGLP6
 RUqZy9rNJNcGjTuSMDLZXmujPvtlqbNCq7ekMmjBqsN4cHz53Q8YM2/AuXZvdAK7szYT
 g/Cw==
X-Gm-Message-State: AC+VfDxA1OSfVtZyaVD1XkaV8U0KHtwha+Z6YhJQRlvFrWlFlhUUSTtX
 mrFHlJoUNFTBG6UKtT2vT4ru5jfFkqgdEeyIcy8=
X-Google-Smtp-Source: ACHHUZ4h4iAyfST5L6Zr+5MqqANha6hzt1vgfUXgFYrsOpAv2rzAyMFw+DEf28BOxduYSjEkQGF2Kr6Jd2wlJLIJdCc=
X-Received: by 2002:a17:90b:4c46:b0:250:132a:5d93 with SMTP id
 np6-20020a17090b4c4600b00250132a5d93mr18870740pjb.49.1687566034297; Fri, 23
 Jun 2023 17:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230623154135.1930261-1-peter.maydell@linaro.org>
In-Reply-To: <20230623154135.1930261-1-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 23 Jun 2023 17:20:22 -0700
Message-ID: <CAMo8Bf+poaCgeO+bveMcrZgdTM=HowpjQFVU=aXX92C0b7BoJQ@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Assert that interrupt level is within
 bounds
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

On Fri, Jun 23, 2023 at 8:41=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In handle_interrupt() we use level as an index into the interrupt_vector[=
]
> array. This is safe because we have checked it against env->config->nleve=
l,
> but Coverity can't see that (and it is only true because each CPU config
> sets its XCHAL_NUM_INTLEVELS to something less than MAX_NLEVELS), so it
> complains about a possible array overrun (CID 1507131)
>
> Add an assert() which will make Coverity happy and catch the unlikely
> case of a mis-set XCHAL_NUM_INTLEVELS in future.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> NB: only tested with 'make check-avocado'. You could argue that we
> should mark the coverity issue as false-positive instead if you like.
> ---
>  target/xtensa/exc_helper.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

