Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04707D6D1A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:28:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvduo-0006Eb-Vz; Wed, 25 Oct 2023 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvdum-0006Dr-Iw
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qvduk-0007Dv-Qk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698240432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pilNiS4pU0CfC0m1XhMSR+2CsdHHab2yVxcsy7Ctxt8=;
 b=U/wSamueOWQbyYSJXHQX9RkFpO9Upt65cGgnEx5u29M2tFny2SKOnE9i+AlPJLipVY6z54
 OM4Oo2I0xPVexmWPlgT4Y6nukAsG4R8mCkrQFBbA6ciszU+gYahJzzpf90CaiBwYHg8T3Y
 Qb7NlNd1LSmK3CgzVuQByhi/BcoTF+o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-wGnjIlwWO4eC6z1zBPOkAw-1; Wed, 25 Oct 2023 09:27:11 -0400
X-MC-Unique: wGnjIlwWO4eC6z1zBPOkAw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53e2acda9d6so3709240a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698240430; x=1698845230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pilNiS4pU0CfC0m1XhMSR+2CsdHHab2yVxcsy7Ctxt8=;
 b=hrIpvgSI3UTKF4tFBFBwoN3dZhLJxSua7ny6V/iUYCiu4F9FvsZcfD2fEbJaIxO5N0
 oA/MLosQ7dkIYYJctybm7jUfpVKUf2mYtFi755QkwivqYlxV2zphrKJQjTguHMPiMWpA
 /oObPgvSn3TsIFLA7zAtugQ89cfRfeuma1/EPTnTEunFWsb6RldGjwWEYHHSBbRkxXl8
 y+4AVn1YgUF5v8MSlZSVifQH4LU5wzXe7m5+GYeOB7b9F0sRMX8mm0IK95SouIKoSn2F
 W/MGWTYijj2g27QBAFXEGfZ6pyLy8UoxhhooKjq9WwCO12ag1SKx66ZQtsgeyeM1lXwH
 xrtg==
X-Gm-Message-State: AOJu0YxgJqNz5Xfmf4VAchgeuKk1HqDoT3AHvY5AzPDFu/NoC5Re77Rs
 /cfiEg7ts6aY4MPUWvotVZkDOEUvgYBHHznQT79BcLUrnQzRDxXk20bm2lA0Vw1dDl1Bro9hmVV
 PRJaRCcOdpfAojwIRddRMISe9ULeg7q4=
X-Received: by 2002:a50:cd59:0:b0:540:16d0:cd4 with SMTP id
 d25-20020a50cd59000000b0054016d00cd4mr7766617edj.41.1698240430418; 
 Wed, 25 Oct 2023 06:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlobVDoh9ZQ3TTg1Zt80/r0HW+vR3yEvY163zwt4/UgHJHgxNAX2t63EVel1wB/fkacKufqKqB9mhwiNhuck=
X-Received: by 2002:a50:cd59:0:b0:540:16d0:cd4 with SMTP id
 d25-20020a50cd59000000b0054016d00cd4mr7766608edj.41.1698240430149; Wed, 25
 Oct 2023 06:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-5-marcandre.lureau@redhat.com>
 <4af29498-c70f-4969-ba71-2b30ed281ea6@redhat.com>
In-Reply-To: <4af29498-c70f-4969-ba71-2b30ed281ea6@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Oct 2023 17:26:58 +0400
Message-ID: <CAMxuvayE4YQk2HsEVQxVNkVP+GFL1wrw683s7jDr5c_Moq=9Cw@mail.gmail.com>
Subject: Re: [PATCH v5 04/19] vl: move display early init before default
 devices
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 25, 2023 at 1:56=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 23/10/2023 13.30, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The next commit needs to have the display registered itself before
> > creating the default VCs.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   system/vl.c | 41 +++++++++++++++++++++++------------------
> >   1 file changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/system/vl.c b/system/vl.c
> > index 92d29bf521..2cecb3d884 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1349,6 +1349,28 @@ static void qemu_disable_default_devices(void)
> >       }
> >   }
> >
> > +static void qemu_early_display_init(void)
> > +{
> > +#if defined(CONFIG_VNC)
> > +    if (!QTAILQ_EMPTY(&(qemu_find_opts("vnc")->head))) {
> > +        display_remote++;
> > +    }
> > +#endif
> > +    if (dpy.type =3D=3D DISPLAY_TYPE_DEFAULT && !display_remote) {
> > +        if (!qemu_display_find_default(&dpy)) {
> > +            dpy.type =3D DISPLAY_TYPE_NONE;
> > +#if defined(CONFIG_VNC)
> > +            vnc_parse("localhost:0,to=3D99,id=3Ddefault");
> > +#endif
> > +        }
> > +    }
> > +    if (dpy.type =3D=3D DISPLAY_TYPE_DEFAULT) {
> > +        dpy.type =3D DISPLAY_TYPE_NONE;
> > +    }
> > +
> > +    qemu_display_early_init(&dpy);
> > +}
>
> So we now have qemu_early_display_init() and qemu_display_early_init() ..=
. ?
> That's very confusing, could you maybe come up with a different name for =
the
> new function?

Ok, what about qemu_setup_display() ? I'll also simplify a bit the logic th=
ere.


