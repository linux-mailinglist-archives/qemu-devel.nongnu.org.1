Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67170709A9C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tf-0006ki-BT; Fri, 19 May 2023 10:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01TT-0006ZF-Eq
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:55 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q01TP-0003sK-7L
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-510ede0f20aso2573411a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684507969; x=1687099969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUHGT4mRjZTDBz215D3HBEX70neikChI3AFb2FALInw=;
 b=MIoV9sFXyDZjRmua8eXAoJMp24pfo2/GLYvv0Ss9e2ahHkc4NeL22jrSz9imeVVryw
 RdzP/XwWpsOXoSKa06b8jaeTw2vfKadV4Ll3YPZIFGzRPkU8xzoQ1MDuo6nWwymrIV/+
 tsIOgkjS+cqOvi3ihtBEUmgNfBlQ3AXcBG9E48kEawldxHDUJYUZpz/nxWWmfiM9u2Rm
 P60aljgAkmsygPoxPgmHmU+ULBfh3ITbXRmpcspBJd55y+gu6wk2Xqq5FqrmmSuoUHv3
 PeoNeYEbfkAI2BtGlPfIng/gWqWLxn1sByCMAmxRn5RXIF6XCHdz6Zvj54aFypcUj+Kl
 zEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507969; x=1687099969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUHGT4mRjZTDBz215D3HBEX70neikChI3AFb2FALInw=;
 b=N78rZL3NllidzhboOCrolLGf8IkPxEQUNjRafIIpmos0XUDvzWtqC1HrJqL67so1x6
 Bsx4KlegkrcmDUGbq906jxU2hYv7tdP2bMilI38pcknmwNKFx3nTu+79b/7TbzespzTM
 wBhZkoOjezNW6LC0Zijc+8SDuMTJ6Cpea4/sk0p8WHL/K9PFUneG1djiIYx+Qqsnr3bv
 GyzrgFvrSHuqmZDFxZxNclWsy8GG02aoqdgg0/n9cOZDg/3sSGUglkEhRvXT1xvd1oQ+
 u0kOjjFWXGnF0ZXlv5+uOu7y8A+T9Aof5FMy5Sliypfs6UCrXdqglWPTc3R0MGT1IPTV
 8BnQ==
X-Gm-Message-State: AC+VfDwOpE1JJ9puD5cvy32ggoqeHNgbTAuRxo6nngdjUgJYA8T5mvpj
 zt3+T0WC5q37ZFfJbH0MjHZGpu2K9M/ENzg9Wr04ZVYM6EdZf1V+
X-Google-Smtp-Source: ACHHUZ6scr/02k50LUStAIoRXpAVNnaysXcDZ1EPKKHurelCnHUzIxXwKmiNqltvmvsiEAkS+J+Zpo+MpR0lAucelXY=
X-Received: by 2002:a17:907:7f1f:b0:967:21:5887 with SMTP id
 qf31-20020a1709077f1f00b0096700215887mr2509793ejc.40.1684507969584; Fri, 19
 May 2023 07:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230518125107.146421-1-peter.maydell@linaro.org>
 <20230518125107.146421-5-peter.maydell@linaro.org> <878rdklbu2.fsf@linaro.org>
 <CAFEAcA_4ovPWkNw=KNVicD35SzJcQhi4Najt8cS3GSa-TLroKA@mail.gmail.com>
In-Reply-To: <CAFEAcA_4ovPWkNw=KNVicD35SzJcQhi4Najt8cS3GSa-TLroKA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 15:52:38 +0100
Message-ID: <CAFEAcA9QB4YY5wKBu4eyHvy7yb8PZdvAs+tZaXDEhU+RzY=yKg@mail.gmail.com>
Subject: Re: [PULL 04/29] arm/kvm: add support for MTE
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 19 May 2023 at 14:31, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 19 May 2023 at 13:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > From: Cornelia Huck <cohuck@redhat.com>
> > >
> > > Extend the 'mte' property for the virt machine to cover KVM as
> > > well. For KVM, we don't allocate tag memory, but instead enable the
> > > capability.
> > >
> > > If MTE has been enabled, we need to disable migration, as we do not
> > > yet have a way to migrate the tags as well. Therefore, MTE will stay
> > > off with KVM unless requested explicitly.
> > >
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > Message-id: 20230428095533.21747-2-cohuck@redhat.com
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I bisected to this commit which causes a segfault on one of my test
> > kernels (6.3.2 arm64):
> >
> >   =E2=9E=9C  ag MTE .config
> >   486:CONFIG_ARM64_AS_HAS_MTE=3Dy
> >   487:CONFIG_ARM64_MTE=3Dy
> >   2949:CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> >   3573:# CONFIG_I2C_SIMTEC is not set
> >   5278:# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
> >   9749:CONFIG_ARCH_USE_MEMTEST=3Dy
> >   9750:CONFIG_MEMTEST=3Dy
>
> Try this entirely untested patch?
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f6a88e52ac2..f350661a928 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1593,6 +1593,15 @@ static void arm_cpu_realizefn(DeviceState *dev,
> Error **errp)
>          }
>      }
>
> +    /*
> +     * For TCG, we can only present MTE to the guest if the board gave u=
s
> +     * tag RAM. Set has_mte appropriately so code below doesn't need to
> +     * care whether we're TCG or KVM when deciding if MTE is present.
> +     */
> +    if (tcg_enabled() || qtest_enabled()) {
> +        cpu->has_mte =3D cpu->tag_memory !=3D NULL;
> +    }
> +
>      if (!tcg_enabled() && !qtest_enabled()) {
>          /*
>           * We assume that no accelerator except TCG (and the "not really=
 an

Hmm, actually I don't think that's the only fix needed. It's OK for
TCG, but for KVM I can't see anywhere in the code that ever sets
has_mte to false. We default it to on in the cpu.c code, but
then the board code only sets it to true if MTE is enabled
(via kvm_arm_enable_mte()).

Let's just revert the patch while we figure out the right logic.
I'll send a revert patch in a moment.

thanks
-- PMM

