Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D750D7D7E1B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvQw-000326-NA; Thu, 26 Oct 2023 04:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvQp-00031j-99; Thu, 26 Oct 2023 04:09:31 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvQm-0008NB-8C; Thu, 26 Oct 2023 04:09:30 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d093265dfso4384876d6.3; 
 Thu, 26 Oct 2023 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698307765; x=1698912565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IC5m9AAqYvMhf7ADaR+bnPI2wZNYer2Z5KpTC/54nKA=;
 b=V2N87jF5FDTLcx7eWvKEE4aJUVnvgZZ2kfmUQCKO9QzyNKMaKhPwLOaZnUXOtRLL3r
 NIlNww1OTVGlbiKJiFbOVpkG0/DmLMHAn9O7jrAchb25F9P2SzqNSoBnKh0k7bqZumVh
 4nYCulZvjy4XtQ4bwFlnZleLHzQXRGz1ZWD72pmWlDpd9rafrkImczMEcp+8nHD+9Wnw
 71EPuMuqlJLW6XV14SKzHziHmi6dpcP2jfwu2xoMF35hZRLtQypHe6m0N/gXQXGxdZsP
 PJR8utk4uNUZx6GdGE5nLvwKv+7NgU+21eptHphlYzmIVXAyNdg9J9CpCNxkRsMS0M3P
 EQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698307765; x=1698912565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC5m9AAqYvMhf7ADaR+bnPI2wZNYer2Z5KpTC/54nKA=;
 b=lPnIULeahZ4TFAPFQP1HjyHsdwkHyvGAzxFKXIr/U4hdUo5ZkNwVFW+iJnoQw2JnXi
 RmPvHyjo/2HDtTt8AlgHPw90JamvY3iAFuMO9Bap1nlt0Yx8QUoXV8v2t745DsBy87RB
 I9Eknbg6opUJltcAQq3uMk0R7xhYDzE1MTY48Li02kSwEBnXXoBNdUZeq0PZSVBX4h89
 batvbHz84UPRANt+5OYxJ9UFXVIKp/svopKEadL16Oi2JWMIHV1fYTGMjb0rb7ZiGWDB
 WguEqVIxzhYyV39SIdZcUIwPOrIhOpoV/Qc/s+YltWFsnkx7SH8O2fTEyTDmz1f1u3G2
 c/ig==
X-Gm-Message-State: AOJu0YwSTBW9wxk3MCpZm/ohpT/4bXzVaKuRY6Wo9eABnpMIsIrZjoFI
 7Vtjo86LVbozGfCmZ2S4j0p9wmExp/RrLAst3jU=
X-Google-Smtp-Source: AGHT+IHf7jWjkAueVR5j0dXvrifZel28UfYQHoGWLaLeQ72lRWb72u/FFUSlQ7DrgFiDIbOu3EVkCn+K1rz6tgWZ4vk=
X-Received: by 2002:ad4:5aa3:0:b0:66d:6526:d605 with SMTP id
 u3-20020ad45aa3000000b0066d6526d605mr21732046qvg.63.1698307765425; Thu, 26
 Oct 2023 01:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-16-marcandre.lureau@redhat.com>
 <4b2a7827-b0a0-4cd5-81a4-d4129a53ac82@redhat.com>
In-Reply-To: <4b2a7827-b0a0-4cd5-81a4-d4129a53ac82@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2023 12:09:14 +0400
Message-ID: <CAJ+F1C+q1N0MWGHH=L82iyL-gCp__U+eELo9=y5fz0rexUFptQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/23] ui/gl: opengl doesn't require PIXMAN
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2d.google.com
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

On Thu, Oct 26, 2023 at 10:44=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 25/10/2023 21.08, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The QEMU fallback covers the requirements. We still need the flags of
> > header inclusion with CONFIG_PIXMAN.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   ui/meson.build | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 3085e10a72..7c99613950 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -60,8 +60,8 @@ endif
> >   system_ss.add(opengl)
> >   if opengl.found()
> >     opengl_ss =3D ss.source_set()
> > -  opengl_ss.add(gbm)
> > -  opengl_ss.add(when: [opengl, pixman],
> > +  opengl_ss.add(gbm, pixman)
>
> I don't quite get the above line (sorry, meson ignorant here) ... does
> "pixman" simply get ignored here if it has not been found?
>

Yes, when it is 'not_found", it's simply ignored. Essentially, this is
making pixman from required to optional to build the opengl source
set.


--=20
Marc-Andr=C3=A9 Lureau

