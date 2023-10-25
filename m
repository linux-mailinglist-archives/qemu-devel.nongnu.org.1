Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28937D7382
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 20:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvisB-00088j-9n; Wed, 25 Oct 2023 14:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvis9-00087Y-7c; Wed, 25 Oct 2023 14:44:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvis4-0001Vh-5s; Wed, 25 Oct 2023 14:44:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so14501866b.2; 
 Wed, 25 Oct 2023 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698259483; x=1698864283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8tcDalo98Jqvuxyk5/hMSLaaPuSGrJqcNmoOeLVX9Q=;
 b=gyajNDpUePvsJA77H/hNgF0G172CZA7kGm2+xkj0537lupXCOZTuWyCzQbMX9pl/+7
 VIW/bo5A/+q1Ackb0jvhEr+brWWmugwWKmGz3zH60teP4vWRW1FxmkBB+DUyuo5TpYxY
 cVmXMMYV4g2XyMSTPmCPvgyuA0ZtE0RiHlOS6TwNOZYc3M0xjz/RP9QhL7wOGSC45cwJ
 h3g9b3H4DjyMz/DOENyZ8n8GZk+mAeWG65sg71XKUlQZu7T/7TWHTR0CdfdakJp+z2J1
 uxH7FROc6ZjWElqwt7484FBgprY2GjhAi2tw55MKnenyLW9wb5inxcWR3gO6tUeqVygb
 RrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698259483; x=1698864283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8tcDalo98Jqvuxyk5/hMSLaaPuSGrJqcNmoOeLVX9Q=;
 b=NTE/jNRgQZUOTRgVx3Hu6jasgtn0vQQ4pZcy30lRIoVvUvZbhs/ib34sWi/UJlgTHs
 dGLtoIziozBN6VrJ2/oxyWRCjNBZROfkZQ48Q4soAVrtDxapab7KSIwlGjqYlYYVrc7w
 KtyuCKkCEUVdq09FK5hQpDFLNMjCrbUlcwgrZlR08Ex0cFQ1AXHU5EDO0JdViF3V3x9Z
 OpCydYNfeCC7qKFuDLogtO+anySoP36KYFpAad0z2qyQrXf4CE5TABXBme+NdlhSgewL
 ru5craM2Y5R9MO2X7NU7nqQgnrRfZxkH0HiHR239p+4ZwwlpNnQeiIBQnTM21G37RSwm
 vIyw==
X-Gm-Message-State: AOJu0YzF73dcH0u7poV2qvpCa0+GzcxHbkTp/dthNnPbIV+IQFVUPaK0
 vpSr7DFnBfbFDpkrw3d1GXiw8tND7v2J27s/2is=
X-Google-Smtp-Source: AGHT+IGXVpImlaASN1tqKZYBi6Vu/EsjovAAQ1kGCE1ib17rqCXeVaqCAQOtGkTwbH4x0QBox6u7e1oT7595jwi8uxQ=
X-Received: by 2002:a17:907:9618:b0:9a2:139:f45d with SMTP id
 gb24-20020a170907961800b009a20139f45dmr11764020ejc.43.1698259483133; Wed, 25
 Oct 2023 11:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-13-marcandre.lureau@redhat.com>
 <52338f56-cf2d-4eba-a6a4-5ca517f9fea6@redhat.com>
In-Reply-To: <52338f56-cf2d-4eba-a6a4-5ca517f9fea6@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Oct 2023 22:44:30 +0400
Message-ID: <CAJ+F1C+Z2dVskKx=xAAXScoBuwKdZ17F3p+ULwSxs_pnM58XPw@mail.gmail.com>
Subject: Re: [PATCH v5 12/19] ui/vnc: VNC requires PIXMAN
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 25, 2023 at 3:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 23/10/2023 13.30, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   meson.build    | 6 +++++-
> >   ui/meson.build | 4 ++--
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 395d7155f6..c4dd9e01ea 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1536,7 +1536,11 @@ endif
> >   vnc =3D not_found
> >   jpeg =3D not_found
> >   sasl =3D not_found
> > -if get_option('vnc').allowed() and have_system
> > +if get_option('vnc') \
> > +             .disable_auto_if(not have_system) \
> > +             .require(pixman.found(),
> > +                      error_message: 'cannot enable VNC if pixman is n=
ot available') \
> > +             .allowed()
> >     vnc =3D declare_dependency() # dummy dependency
> >     jpeg =3D dependency('libjpeg', required: get_option('vnc_jpeg'),
> >                       method: 'pkg-config')
> > diff --git a/ui/meson.build b/ui/meson.build
> > index 7c99613950..b3525ef064 100644
> > --- a/ui/meson.build
> > +++ b/ui/meson.build
> > @@ -46,8 +46,8 @@ vnc_ss.add(files(
> >   ))
> >   vnc_ss.add(zlib, jpeg, gnutls)
> >   vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
> > -system_ss.add_all(when: vnc, if_true: vnc_ss)
> > -system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
> > +system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
> > +system_ss.add(when: [vnc, pixman], if_false: files('vnc-stubs.c'))
>
> Is the change to ui/meson.build required at all? ... if I get the first h=
unk
> right, if "vnc" is enabled, that means that pixman has been found, too?

Well, this is a bit more explicit, to get the dependencies correct
(flags and such) without relying on other system_ss units
dependencies.. I'd keep it.


--=20
Marc-Andr=C3=A9 Lureau

