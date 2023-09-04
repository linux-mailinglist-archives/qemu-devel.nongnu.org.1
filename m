Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335EE791BAC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCX0-0002Vi-8K; Mon, 04 Sep 2023 12:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCWv-0002V6-G0
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:34:25 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCWt-0003dz-BJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:34:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso2215715a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693845262; x=1694450062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVf0ec9JUJet4Pqt/mpA4aToBYy39TdMPg+NqqnicEk=;
 b=Ph+ZQfJoK6dCCD1rg5cUuQYCCY2zjzPgsY0Qd3b6tHF0xJ51rkNdUKWO5J7nlQyYcb
 gr24WwOvXzW0rahHQBW2xxsi80TYktuisfa7pQRmdaaaLMtncP4Kw2r9/Uqc+dFQDJZ+
 QAnyD40x9w+Msehp23IHrMC9TTZkfvLF/o2EVT2av1shCIwOGaAlhdDX5rF190WgpLIo
 kGjmqdqgOzxmjcIdRqp7OzPXIaQgedZzKv0fnGzXakCWAjdKYu9sHlI9aAboiywHBeRV
 +OVdtYjApA+TNqXW47AwtDs/CnlO8Akxp+WB3A6KsM7Mcl2j0K3gEa0yhx8VkIokg40R
 RbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693845262; x=1694450062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVf0ec9JUJet4Pqt/mpA4aToBYy39TdMPg+NqqnicEk=;
 b=EYu966ggSfYFc54WaN8FambMLt0FfaGxEz0niqwlW4ZDKHRxwHkvCVta4SugDnESvr
 2obVTrAZYD3AjYBWQneXkD0Hj1P2MCq4PQEB6K8Ud8BSiAIHWZX23YtuGlLuZ/XVyFwu
 Th6anM0rl8GOTaRjPO37DsKavly51S8kB38QHW9vP8GItQzhN7umXEmyF0UDujfkfXjM
 z5eztKkdbRGlayhe7p0qZqfX+c7bYbz2uy2skbllNSPhYdZOCHtrnM4OFmvC6bs/2G64
 YmE6Js6fLNBqS7NdY6o6VWVIjaRzQGswlxNi1eNWnTiK9nLLh47YGHhFlYKQxC1+al5R
 Dk/w==
X-Gm-Message-State: AOJu0YxrGyGjOtk7U8G+j7vwAOfobsYSHQYvgMoOWwIksGiVCGGVf7Pw
 H9rvqmlKnBT3mmSN8Arlf9N00Fhh+uQ6U1Xf2KR1ew==
X-Google-Smtp-Source: AGHT+IHEbLLU/eC8fOIyWNp6EAoP3GehYZuroYuPs4sxN26ONgbVI5qCWw/uG45hEsAUiVdK1jBTCsKnKOnlB/IsblM=
X-Received: by 2002:aa7:cd11:0:b0:52a:1c3c:2ecf with SMTP id
 b17-20020aa7cd11000000b0052a1c3c2ecfmr8006828edw.28.1693845261963; Mon, 04
 Sep 2023 09:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162824.85385-1-philmd@linaro.org>
 <20230904162824.85385-4-philmd@linaro.org>
In-Reply-To: <20230904162824.85385-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2023 17:34:11 +0100
Message-ID: <CAFEAcA-LphZk_WHYS7ynE+SzZkYszu3fjKExLtPjJ=VW-hFCHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/qtest/pflash: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 4 Sept 2023 at 17:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Fix:
>
>   tests/qtest/pflash-cfi02-test.c: In function =E2=80=98test_geometry=E2=
=80=99:
>   tests/qtest/pflash-cfi02-test.c:409:22: warning: declaration of =E2=80=
=98byte_addr=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local=
]
>     409 |             uint64_t byte_addr =3D (uint64_t)i * c->sector_len[=
region];
>         |                      ^~~~~~~~~
>   tests/qtest/pflash-cfi02-test.c:342:14: note: shadowed declaration is h=
ere
>     342 |     uint64_t byte_addr =3D 0;
>         |              ^~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

