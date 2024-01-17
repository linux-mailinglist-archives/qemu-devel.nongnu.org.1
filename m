Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C3830C86
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:14:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQAQX-0004tC-5z; Wed, 17 Jan 2024 13:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQAQU-0004n7-Gf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:14:10 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQAQS-0004CX-UZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:14:10 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3606ef221dbso50829695ab.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705515247; x=1706120047; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pHddFOQisf+rkaTZj71z0AcWteQ/AFYEPHCuPI+RNU=;
 b=aEmPVpVreo5IoQLeJMueMqncGSwYdH+eDtER19182ZQoO9TfH5qNnatlAKJlUym508
 rehsicEAaxn72hf2xVgHyh0YKo+TEnOo+yKybL40rHqxMYPlghPhhAgCCrm/ioMqlkfW
 kv7tm4pxt1glIzA2SPiid6SEiCmkqmmDAvKDzgPisb3m3gbqbXZDSAvnaw6XYIk8fPti
 Oi/7E4MBg+LoVsLStZ+GwhJHQzObtYMu/h/HlUR8Ps8xmBpg3uiFcmxzLd+uUqyLQm5a
 yovedLdvVxf4XMPJP/blnUArtPV599Y1He5Vjc9NPMIHAecWiDKDgsS/UMULqm4puEzw
 tGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705515247; x=1706120047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pHddFOQisf+rkaTZj71z0AcWteQ/AFYEPHCuPI+RNU=;
 b=eKc/tVAFwbP++foH0TVL4BVQJmcnhEJImrLHlVh0xomgyb84Xiyp1UzQmi/a6o8uB9
 0rUdLGWUFauE8BaU1mRTJvqw/Av3ZwIWZl1FK2MUr8DOfYLiyK4O0ZVWypdt7Bcw+mZy
 yBYdlEY9jJIv2Rhj614obFTwZgJ05+XZu8yE50Rt0lmbPW4ntz9uyA9FzefWIxNkgPyF
 VonYDlvTCdrIxBTI3fMyuf00AkQI+SD7r9nVm7f0ZKI5n2nxjVRdkJY05NGrsYLP98/o
 HfKyNpxpyNbB02R2e1FbhwM/mmwfIbuQ4gp8QLSdFHf/kVLnpieWOoa7Ms5aN95jKBUX
 8DBw==
X-Gm-Message-State: AOJu0YzsVWnOChpL7ULntxp5oLODHIDP9Kl7etqwjlqAKGgOzQZQ/WF2
 KVPzPv0fn+xpIHsyxSsV50ruVjPUQlfVfSebFWM=
X-Google-Smtp-Source: AGHT+IEi1/RhlzIR4melL8GcmxSjXa71J8/gp7v9vTsAynvCxgfDza9NjbRsFKNN9K3mjT/TMgZY1n4kcT2jgBwR0Fc=
X-Received: by 2002:a05:6e02:156f:b0:360:d7ee:ccf6 with SMTP id
 k15-20020a056e02156f00b00360d7eeccf6mr8537066ilu.26.1705515247383; Wed, 17
 Jan 2024 10:14:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkDymmXdvFUAEpiBTbVuaRUHVfW8UTdyuSDhoG4Ro+yzA@mail.gmail.com>
 <CAFEAcA_oEMqmc-coCSYpZw8vN+NSLYRQBowaDAR0i8vevoM3zQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_oEMqmc-coCSYpZw8vN+NSLYRQBowaDAR0i8vevoM3zQ@mail.gmail.com>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 19:14:02 +0100
Message-ID: <CAHP40m=pB6aOdoUL36vC=_ku2ynNj6j6n0PC4DkwCgSd5D2OPQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Allow tests to be disabled
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I agree with you, I mentioned that this was the "minimal effort"
patchset to get qemu compilable.

On Wed, Jan 17, 2024 at 6:35=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
[...]
> should be guarded by a suitable check that means we don't
> try to build it on hosts that don't have the host-specific
> functions/whatever that it needs.

This is the best solution for this problem, any pointers on how to best do =
this?

Thanks

On Wed, Jan 17, 2024 at 6:35=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 17 Jan 2024 at 12:59, Manolo de Medici <manolodemedici@gmail.com>=
 wrote:
> >
> > tests/qtest/tpm-* compilation is not disabled by disable-tpm,
> > for this reason compilation fails on systems that doesn't
> > support the linux/bsd TPM api. Fix this by allowing tests
> > to be disabled.
>
> This isn't the right way to fix this. Either the tpm test
> code has portability issues that can be fixed, or else it
> should be guarded by a suitable check that means we don't
> try to build it on hosts that don't have the host-specific
> functions/whatever that it needs.
>
> thanks
> -- PMM

