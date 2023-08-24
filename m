Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6B786C1B
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ig-0002Bu-Gq; Thu, 24 Aug 2023 05:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6id-00025M-9E
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:33:35 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6ia-00065G-Vw
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:33:34 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso75200411fa.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869611; x=1693474411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lZ9VRbcZKdi+pLte8HQ0JxPEQoQ5z15ofgWNnDnWew=;
 b=p5a6OcwNVmy355Wzh7te3kx9s5FmoNg2HMEq8Acwja3xpR8cPAscagXnN3hjZdktOf
 WphLEq+86P05YI86RDj6ESW1+uSQ1TEk4JYnp5mcJhVk4HoitPW4+noEvWgVzw3QH9qB
 9vLoUw1QBDUxq15zjJNWpQ3K4/RXDONaLeJ6v6bs7RBZLTgi2BTWAGFseBqOKyEF7czF
 NX2472aY/TeSIoih1gnxhTtbhObsnQppIKuvjGutFxgPNLg1s7PP1u9rpvyRn9JEEIx+
 M/JUFU16dV/3z2pBQH0Q3oFb5IOfrewWEk7NweoS8jPhnO2MXbz2GR9qXVRidONGqJtU
 9VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869611; x=1693474411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lZ9VRbcZKdi+pLte8HQ0JxPEQoQ5z15ofgWNnDnWew=;
 b=Okn1iYfPd2+Bxj4qXqBRfuUib07KptWJiKHwQr2W/9JqdDWlI0EBlKA4WSiGpwZl3V
 vqUXxVdmcnPfOS7aZDTNZcZsVVZwFjoO/EN141i9KYtahAF6y0X1Msryi9+kWPsyx75j
 jM4F+C+i/m73rkTekvFkVlI6GDmVRXjFgCry3JlAZ7X40Al9SR+R9kkCkVNCs0vMBR9c
 ccvbkiGH9Doa63RICk1k6UHSI2GHDVKcWxa+7lKl/S96lVyem3bfMjbVLFVzJ+NaxOm2
 LovIXS4dBdbwJ6DttYJuVehT4wpRlFB8DCK9YzEvx0fdHH0g3TWfjD7Mg8N45HJ0SBjt
 9Zlw==
X-Gm-Message-State: AOJu0YzygcJf+1kZMkuUUjCwq9qIepd4AaTrq+6Cd311zACZEWiRVShX
 HqshM7pFXoKzUbMyaaxjhTvbNxAtENGQxE0/xxGAPg==
X-Google-Smtp-Source: AGHT+IG6wj2g7+HI7k6E43YXMLS0dVOzxeVspOa5rvnJBTFrC1m+65ybDvPfm3wX+jYJ+LOzEBJtLUS2i/dOGtR28zs=
X-Received: by 2002:a05:6512:ac4:b0:4ff:8d7a:cb20 with SMTP id
 n4-20020a0565120ac400b004ff8d7acb20mr13747233lfu.63.1692869611255; Thu, 24
 Aug 2023 02:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYM0N261g8zrDKq2jQo4mriHEhNXWo-oXZ0LCryL+BmUX-h6g@mail.gmail.com>
 <87jztlt27t.fsf@pond.sub.org>
In-Reply-To: <87jztlt27t.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 10:33:20 +0100
Message-ID: <CAFEAcA8QnXJF73C7c1Y=yVJbBQAK-uFm9DQDJZdugc24ybsk5g@mail.gmail.com>
Subject: Re: constructor vs. __constructor__
To: Markus Armbruster <armbru@redhat.com>
Cc: Liu Jaloo <liu.jaloo@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Thu, 24 Aug 2023 at 06:55, Markus Armbruster <armbru@redhat.com> wrote:
>
> Liu Jaloo <liu.jaloo@gmail.com> writes:
>
> > What's the difference between  "__attribute__((constructor))" and
> > "__attribute__((__constructor__))" in qemu source?
>
> Reading the fine manual helps:
>
>     You may optionally specify attribute names with =E2=80=98__=E2=80=99 =
preceding and
>     following the name.  This allows you to use them in header files
>     without being concerned about a possible macro of the same name. For
>     example, you may use the attribute name __noreturn__ instead of
>     noreturn.

As usual in the QEMU sources, we are not particularly consistent
about using one version compared to the other. However we
mostly use the "__attribute__((foo))" form rather than
"__attribute__((__foo__))" so if you're writing new code then
prefer the former.

We also have a handful of uses of "__attribute((foo))" and
"__attribute((__foo__))". Definitely don't add more of those :-)

thanks
-- PMM

