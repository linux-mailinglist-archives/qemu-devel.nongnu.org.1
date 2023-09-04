Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC97917AB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd99X-0002nt-Df; Mon, 04 Sep 2023 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd99V-0002ja-3t
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:58:01 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd99S-0001dQ-RU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:58:00 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4121f006c30so8546221cf.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693832277; x=1694437077; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqhAXZ8PySzdu2B0CupEUh+6hM9vgFjs7Ny50o8g67w=;
 b=n/4Wmhncsp8EXEDv27waYY7rrQL2B0CtotLQKYK7GQDejC5ic+9+Mfgqzqs7i9DSOU
 LMFFFM6hBwW1oSjf/eGVis448cS4Tb2mA32M6eenMTowFdCbDnPUemAKgqSsFnYr9IT/
 +RIg5N6O4C2kYmB+mTQBpjJpLCgEVkchaN/93Gm1p0A1bxqk6Sqiesmss633DGcpwgdt
 edrXZ12mAY0fxdPui1imlyAwQN8vLjs/1JJUwl72IO8EI3XuKDW9AERjGiIdRuHq22V+
 QhxQXKRKodNS7+kXUm8qRQrQL2WM6+1S5OYJGhMikgbHP2OHupxyHjpdf/cZh+tDZamz
 6aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693832277; x=1694437077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqhAXZ8PySzdu2B0CupEUh+6hM9vgFjs7Ny50o8g67w=;
 b=Ybte0aAy3vrAEjDRiwPGHjITJJLXOmYwDW31iPAjOOpBPRJKT732cGIzsNc6fC8yP6
 P7aFkEhWewmSxLAU8vQd4iODrrmZFiW3XkOTHDoXPl/lgpxHYrzkjr91sjdTzAyZ0BqV
 AIC/G4c4PXY7WQeSpvhqOEJ+5Az2SH3AqaUpqiiZbrbuFOUaZCxUBBCSlLAiCxDd5g/w
 o9WRgC/Cu8DcIPB5yZUDdT+/OAttPLLpScDKiLMPesvFAsw4t88Mtxtpk49mwrwiO7k/
 xvXgcMmg+en+afeoeqepdNQBQ2CTMqjtZEqqhDK4p58gUuFanzbXRc2mkQsZqLVG0yPq
 SK9w==
X-Gm-Message-State: AOJu0YyYSQfdEiNnmzeh8RfmLPD+Kf7yadiuDOqaeEpa5J8Fzx93tkVh
 x1LKQmOSo56XrWxVIh79gA/qCJHEuGdEPIkkQbI=
X-Google-Smtp-Source: AGHT+IEB42yWeCANOWpCMgUlFYM6yQYrP+S3TIHRofN/P/biaXUnJ0H0yEaaqDGqrjHPVtsAK2Jz3fyLQRLne4PonZU=
X-Received: by 2002:ac8:5fc8:0:b0:413:6624:a3ba with SMTP id
 k8-20020ac85fc8000000b004136624a3bamr15121658qta.55.1693832277261; Mon, 04
 Sep 2023 05:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-50-marcandre.lureau@redhat.com>
 <ZPId9976tOP7o8XS@redhat.com>
In-Reply-To: <ZPId9976tOP7o8XS@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 16:57:45 +0400
Message-ID: <CAJ+F1C+mLdhOZgQs+v+7Me8m42re9i4D2LuVaqEimFXW+3X02w@mail.gmail.com>
Subject: Re: [PATCH 49/67] ui/vc: split off the VC part from console.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Fri, Sep 1, 2023 at 9:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:23PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Move common declarations to console-priv.h, and add a new unit
> > console-vc.c which will handle VC/chardev rendering, when pixman is
> > available.
> >
> > (if necessary, the move could be done chunk by chunks)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/console-priv.h |   43 ++
> >  ui/console-vc.c   | 1079 ++++++++++++++++++++++++++++++++++++++++++++
> >  ui/console.c      | 1096 +--------------------------------------------
> >  ui/meson.build    |    1 +
> >  4 files changed, 1126 insertions(+), 1093 deletions(-)
> >  create mode 100644 ui/console-priv.h
> >  create mode 100644 ui/console-vc.c
> >
> > diff --git a/ui/console-vc.c b/ui/console-vc.c
> > new file mode 100644
> > index 0000000000..656f099556
> > --- /dev/null
> > +++ b/ui/console-vc.c
> > @@ -0,0 +1,1079 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + * QEMU VC
>
> This code is moved out of console.c, which (surprisingly) appears
> to have an MIT license header.
>

updated

>
> The include/ui/console.h header meanwhile has no license, so is
> valid to assume it is GPL-2.0-or-later I guess.
>

Do you think I should split this patch in multiple patches? or can you
r-b it with the license change?

thanks

--=20
Marc-Andr=C3=A9 Lureau

