Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E35C8827B98
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMz3z-00072T-FP; Mon, 08 Jan 2024 18:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMz3w-00071m-JD
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rMz3u-0000mT-V9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704756580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pREj+q6mpTRI35+5UEChfn5Pho+5UNfleHRIJF1QV9w=;
 b=W9bHN32GsDgmOMrIcjEB+cu+yw888wIbchdED05tLxcp2DfsNuNRnVL3mR456mgGfLsfCH
 TrusCX9UalpKyzu4E3hFbysedaZLLdpTrz0Dj6xWy3Qo2kw106gnI6VyJTYi+FobFAOzLy
 LloWczI/Zf/BuDE6HOTEqkyPY5qVZQU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-_Vv1u-ylOyaMV5e0bK8Oug-1; Mon, 08 Jan 2024 18:29:39 -0500
X-MC-Unique: _Vv1u-ylOyaMV5e0bK8Oug-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bb9e12a1f3so3576760b6e.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704756578; x=1705361378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pREj+q6mpTRI35+5UEChfn5Pho+5UNfleHRIJF1QV9w=;
 b=YuFZLEwnVlY6zFT+QWoJI7YvvsavNq5XueoCbJyMsFtPmxJC1hwNaF5lojfAXnl6i7
 aDXIRLN3qjZUGXhir1+wnlzigQsWpfJQzXGsZFKTQ1rac1BOu1zJh7hiExVnp0H2ZZe8
 8BSN2I2GZXhBgl3eyO+yd41IRlpD5U94lwxCimIWbwMoooDdGV6pYNDitXyU2SG4aBfX
 nR+IqI7D2lvhxRAhIyNOekg7mM2kYJJyfYgFM0t8cLDp2SXf9ZPRNTC3rMqJxm1M02J0
 FLu4456b/933hP0JrdKEfe3NL/vXrldc9dzM6kFvmjwcC64lcXeYPMcz9TgmE4P0pxHD
 UVaw==
X-Gm-Message-State: AOJu0YwVAzIZoyhc27f/Y43nb9Eze1WYSkqN7VGpK3hLp6Nm8obJbXhZ
 90zUQhamYA964YPAxTsRGZcbUYTe5IJQ3hsA5+u4CQvBtA/q2F5R7xQ8q3uDCWbkqzgbiXpAI9X
 17xfXRP+XzpldCjx5/blJpuyZoGUyL4dI68tUuiE=
X-Received: by 2002:a05:6358:5242:b0:173:50b:26ed with SMTP id
 c2-20020a056358524200b00173050b26edmr5551975rwa.36.1704756578212; 
 Mon, 08 Jan 2024 15:29:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb2e70gWjxqSrUxOFWvFdF+wuagPzfDRKDrs1u0NNCH3RgE0UfhfTnMFNE5vkbBgQarm42lyw64zaEbgi7RgU=
X-Received: by 2002:a05:6358:5242:b0:173:50b:26ed with SMTP id
 c2-20020a056358524200b00173050b26edmr5551968rwa.36.1704756577775; Mon, 08 Jan
 2024 15:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20230812085957.408208-1-hpoussin@reactos.org>
 <10e3fd96-ede1-1e13-2441-779be98cf886@reactos.org>
In-Reply-To: <10e3fd96-ede1-1e13-2441-779be98cf886@reactos.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Jan 2024 18:29:26 -0500
Message-ID: <CAFn=p-Y0CbBbLs-HnEd=91C27Q9p0tQH1EYAr-+GfAbNSELT+w@mail.gmail.com>
Subject: Re: [PATCH] hw/block/fdc: do not set SEEK status bit in multi track
 commands
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 1, 2024 at 4:45=E2=80=AFPM Herv=C3=A9 Poussineau <hpoussin@reac=
tos.org> wrote:
>
> Ping.
>
> Le 12/08/2023 =C3=A0 10:59, Herv=C3=A9 Poussineau a =C3=A9crit :
> > I don't understand when SEEK must be set or not, but it seems to fix Mi=
nix...
> >
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1522
> > Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> > ---
> >   hw/block/fdc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> > index d7cc4d3ec19..f627bbaf951 100644
> > --- a/hw/block/fdc.c
> > +++ b/hw/block/fdc.c
> > @@ -1404,7 +1404,6 @@ static int fdctrl_seek_to_next_sect(FDCtrl *fdctr=
l, FDrive *cur_drv)
> >               } else {
> >                   new_head =3D 0;
> >                   new_track++;
> > -                fdctrl->status0 |=3D FD_SR0_SEEK;
> >                   if ((cur_drv->flags & FDISK_DBL_SIDES) =3D=3D 0) {
> >                       ret =3D 0;
> >                   }
>

I'll be honest, I don't have the time to audit this and I don't have
the test suite necessary to prove that it's safe enough. Do you have
any suggestions for how we can prove or test this beyond 'works for
me'?

I could read the spec sheet for this controller until I'm blue in the
face, but it doesn't seem to necessarily correlate to how the
controller behaves IRL or with what real operating systems actually do
with that controller. I also don't have access to a physical
controller anymore to even begin to try and write my own hardware
probe for it.

We need a robust test suite for FDC behavior, but it seems unlikely
that anyone will want to actually write one (I sure don't). Are there
any good shortcuts to victory here?


