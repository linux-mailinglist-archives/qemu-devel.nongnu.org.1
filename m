Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F8836DE7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:41:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyHd-0007c7-Vp; Mon, 22 Jan 2024 12:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyHW-0007bb-Uj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:40:23 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyHV-0004QU-54
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:40:22 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so3875889a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705945219; x=1706550019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B73if8oMiUchhXW0yXjMMFsaiUUB8eLj8kmuwBme5q0=;
 b=E8e4Y/Ij+m60Afh93mnwE+cwngCHAbYck/f2W8ZYhERGKdftB0bYCZXP6Eeq/YkHQa
 5koBEoOPTA/RUfhR+1aFGoRuwxaJ8Zu1l7vjpPINsdDMD9pEkfktbmm/dwBFuibI3VC3
 LMdW2cked2UrMIT573vn13W/ZRBdpARmdwqCTs6xtXPcohaMAt/J76HIG6CMkeeVoR9t
 kIexDKuzZuCo09dQHh3jBJi2RyMMVp0Mb2TqaGw9dD9hEW/T3z07Xvuc4eO7DnVjjbx+
 OJC/L9uT3oV47IKzxN4lalA6d24PxbE5IUhgBPsAYZCciSswUXVB003u9wkgVxV6UL+H
 6dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945219; x=1706550019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B73if8oMiUchhXW0yXjMMFsaiUUB8eLj8kmuwBme5q0=;
 b=qjt5mJF13rgtZ4/S2h6AvzALzMFWHdBY9Pi2surQZsUKzyanpl7LHK1iNZLMmu+GOn
 Tzys7CA/WEUMSg/IfWN2Z0tXQ4VDvgTlR1Gns7ltPFUQvGxQXGNeUcdiqKGe7pjAU1Vy
 RKWaofJHYjP2daxehpn1S89vpHEtErqI9mFd7cv1Cs9iuv69bRDd2RB1jVp/grSdECad
 FI6V+yrNvOJU9o+NRr/izGGw4qvxdonC/ph9yUzCsHZrzQGzAgnwX56jUpEhKwjOvAyh
 1/dM7dNGNEmtQTzrpYjUhp8D+PPuJHDfVDdrjGEXNxPdyja+4ONp3b5VfnGkUouNyhnR
 N/SQ==
X-Gm-Message-State: AOJu0YwUewzxGTyN3IAfAXR4u0QbvJL5z9/5av16+4XT259Erz3nT7Wi
 GzfxN/yUfuI8osDYv/oJfQnJbpYxmzzDDyMFOsyuDyumVeBmjL0lGR4pV3/VRva8LQthXTZKwDu
 z+qZ7RZsAjbfu+TFFpMzjbnDhYhLrpushyvYWYg==
X-Google-Smtp-Source: AGHT+IGlvsPxvKMqs+Xebpx1m1MZBEqENRUOGfDtclBpAelXrlErwAvK/OKRFmes0POID11GAwD2wdRSnGwq/W0l5pE=
X-Received: by 2002:a05:6402:3507:b0:559:6c9e:96fe with SMTP id
 b7-20020a056402350700b005596c9e96femr155023edd.37.1705945219290; Mon, 22 Jan
 2024 09:40:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
 <Za6lUaLwYm1Y4gvj@redhat.com>
In-Reply-To: <Za6lUaLwYm1Y4gvj@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:40:08 +0000
Message-ID: <CAFEAcA--TgOV0rQ0x6UHG2d-DO=c6jsbgmgYNXcNorh_EJ+qzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Include new arbitrary limits if not already defined
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org,
 bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 22 Jan 2024 at 17:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 18, 2024 at 05:02:23PM +0100, Manolo de Medici wrote:
> > qemu uses the PATH_MAX and IOV_MAX constants extensively
> > in the code. Define these constants to sensible values ourselves
> > if the system doesn't define them already.
>
> Please give details of what platform(s) lack these constants
> in the commit message.
>
> Presumably this is a platform that is outside of our normal
> support build target list, since we have at least build
> coverage for everything mainstream.

It's GNU Hurd. The patchset isn't threaded, but the cover
letter is
https://lore.kernel.org/qemu-devel/CAHP40m=3DUQ=3DF1-Vy4-wR18RjqzF9o+8UOjgp=
UsrTU8QXn=3D7eAeA@mail.gmail.com/

and you can pick up the other patches in it by searching the list.

> >
> > Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> > ---
> >  include/qemu/osdep.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 9a405bed89..9fb6ac5c64 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
> >  #define TIME_MAX TYPE_MAXIMUM(time_t)
> >  #endif
> >
> > +#ifndef PATH_MAX
> > +#define PATH_MAX 1024
> > +#endif
> > +
> > +#ifndef IOV_MAX
> > +#define IOV_MAX 1024
> > +#endif
>
> If we're going to add this, since we should be removing the
> later duplication:
>
>   #define IOV_MAX 1024
>
> in this same file

Mmm, I wondered about that, although in that case it's
"for when the host has no iov implementation at all
and we're rolling our own".

thanks
-- PMM

