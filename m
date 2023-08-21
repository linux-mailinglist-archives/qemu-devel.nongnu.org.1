Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA3D782DD3
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7Om-0006dp-Ee; Mon, 21 Aug 2023 12:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qY7Oj-0006dZ-08
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qY7Og-0002du-GH
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692633889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCpTt5dH6yer94p6uLtt8gmsJ+utYOf+/4jsL0KvGjk=;
 b=ZrWBvg+LaSZ7wi/zYstl2G9aOJTAWy2fzgwfP745V033qLSogNmSn+hBV4YWy/WGHgwhFy
 v3sf8I30mLfb2n7HXEmxi1glmhOGDBZfMtYUdc/LeZIVtwJ9A+tNGs2CcOJf04UoUi7mdn
 pvD3dlWWBDfktg7l9CzIv+/wnxOSL/s=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-uamFyIHKP3edpzV_cHz9Ag-1; Mon, 21 Aug 2023 12:04:47 -0400
X-MC-Unique: uamFyIHKP3edpzV_cHz9Ag-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b9c09823e7so4007832a34.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692633886; x=1693238686;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCpTt5dH6yer94p6uLtt8gmsJ+utYOf+/4jsL0KvGjk=;
 b=ldjbb1DU9FC8BGNpIZyQznVYl+B9MLadN+pYLkKoQh2hGGj3nDn0l55ozh4xYtf+5y
 NBUJM31cmHcxtAzwnEUFcoRymT7FkeEIisizCa+cHUDglVIL6lp7Xd7NwzQb0InBUMlE
 dj81Ie87TSYVAtHmXDav3t58t6WCJ6VoRHuffLhslU+fDl/KdM8K2GCMUzbAkJHIO3nx
 9amH3pB/eDUXLqiqJVlOjsV2WJhMQ3GwO6QcUb9EyPq/Bi63Wm6dzqpYOqZEgCXjr0Zs
 V8MTW80ZsyFLFcx4AMeKP59hiCH42N/85IjN1X64wdZfy9TEWu0LkuTcTqnb2RCWZy3f
 0BLg==
X-Gm-Message-State: AOJu0YzrnwyDS3M5TMcg2YUfM2Xx3A+Q3XeSCY09nGcs6q9Ddu5ixHqE
 ZYinJUkQ9aOzx04mlaeiprizwhY/DLXOaqZApW7Mlke4zvLCrrv4Mbk58HfHowSPIOgYXiHDht5
 ESrIlFynQeff8wlk=
X-Received: by 2002:a05:6830:478e:b0:6b9:f1d3:160 with SMTP id
 df14-20020a056830478e00b006b9f1d30160mr8637592otb.11.1692633886454; 
 Mon, 21 Aug 2023 09:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1nc6oTGP/RpC66v9141OP1fez6LLQZOEhd04VxqXv2L/YZTOlUJ7M8qL1CQ8BSed3wjOoUA==
X-Received: by 2002:a05:6830:478e:b0:6b9:f1d3:160 with SMTP id
 df14-20020a056830478e00b006b9f1d30160mr8637530otb.11.1692633885751; 
 Mon, 21 Aug 2023 09:04:45 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 q19-20020a9d6653000000b006b9a9bc7773sm3539910otm.56.2023.08.21.09.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:04:45 -0700 (PDT)
Date: Mon, 21 Aug 2023 10:04:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>, qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Beraldo Leal
 <bleal@redhat.com>, richard.henderson@linaro.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [8.1 regression] Re: [PULL 05/19] virtio-gpu-udmabuf: correct
 naming of QemuDmaBuf size properties
Message-ID: <20230821100443.6034d0a4.alex.williamson@redhat.com>
In-Reply-To: <CAMxuvaxjHq=3oB74McSdHSMthtv0XLwk0k6tW92FjY1yyeoA_w@mail.gmail.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-6-marcandre.lureau@redhat.com>
 <20230816150810.15d90b34.alex.williamson@redhat.com>
 <20230816152549.09cfcece.alex.williamson@redhat.com>
 <CAMxuvaxjHq=3oB74McSdHSMthtv0XLwk0k6tW92FjY1yyeoA_w@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Mon, 21 Aug 2023 14:20:38 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi Alex
>=20
> On Thu, Aug 17, 2023 at 1:25=E2=80=AFAM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Wed, 16 Aug 2023 15:08:10 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote: =20
> > > > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > > > index 8f9fbf583e..3d19dbe382 100644
> > > > --- a/ui/egl-helpers.c
> > > > +++ b/ui/egl-helpers.c
> > > > @@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmab=
uf)
> > > >      }
> > > >
> > > >      attrs[i++] =3D EGL_WIDTH;
> > > > -    attrs[i++] =3D dmabuf->width;
> > > > +    attrs[i++] =3D dmabuf->backing_width;
> > > >      attrs[i++] =3D EGL_HEIGHT;
> > > > -    attrs[i++] =3D dmabuf->height;
> > > > +    attrs[i++] =3D dmabuf->backing_height;
> > > >      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
> > > >      attrs[i++] =3D dmabuf->fourcc;
> > > >
> > > > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> > > > index 42db1bb6cf..eee821d73a 100644
> > > > --- a/ui/gtk-egl.c
> > > > +++ b/ui/gtk-egl.c
> > > > @@ -262,9 +262,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListen=
er *dcl,
> > > >      }
> > > >
> > > >      gd_egl_scanout_texture(dcl, dmabuf->texture,
> > > > -                           dmabuf->y0_top, dmabuf->width, dmabuf->=
height,
> > > > -                           dmabuf->x, dmabuf->y, dmabuf->scanout_w=
idth,
> > > > -                           dmabuf->scanout_height, NULL);
> > > > +                           dmabuf->y0_top,
> > > > +                           dmabuf->backing_width, dmabuf->backing_=
height,
> > > > +                           dmabuf->x, dmabuf->y, dmabuf->width,
> > > > +                           dmabuf->height, NULL);
> > > >
> > > >      if (dmabuf->allow_fences) {
> > > >          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> > > > @@ -284,7 +285,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener=
 *dcl,
> > > >          if (!dmabuf->texture) {
> > > >              return;
> > > >          }
> > > > -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dm=
abuf->height,
> > > > +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
> > > > +                             dmabuf->backing_width, dmabuf->backin=
g_height,
> > > >                               dmabuf->texture, false);
> > > >      } else {
> > > >          egl_fb_destroy(&vc->gfx.cursor_fb);
> > > > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > > > index a9a7fdf50c..4513d3d059 100644
> > > > --- a/ui/gtk-gl-area.c
> > > > +++ b/ui/gtk-gl-area.c
> > > > @@ -301,9 +301,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeLi=
stener *dcl,
> > > >      }
> > > >
> > > >      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> > > > -                               dmabuf->y0_top, dmabuf->width, dmab=
uf->height,
> > > > -                               dmabuf->x, dmabuf->y, dmabuf->scano=
ut_width,
> > > > -                               dmabuf->scanout_height, NULL);
> > > > +                               dmabuf->y0_top,
> > > > +                               dmabuf->backing_width, dmabuf->back=
ing_height,
> > > > +                               dmabuf->x, dmabuf->y, dmabuf->width,
> > > > +                               dmabuf->height, NULL);
> > > >
> > > >      if (dmabuf->allow_fences) {
> > > >          vc->gfx.guest_fb.dmabuf =3D dmabuf; =20
> > > =20
> >
> > I suspect the issues is in these last few chunks where width and height
> > are replaced with backing_width and backing height, but
> > hw/vfio/display.c never sets backing_*.  It appears that the following
> > resolves the issue:
> >
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index bec864f482f4..837d9e6a309e 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -243,6 +243,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCID=
evice *vdev,
> >      dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> >      dmabuf->buf.width  =3D plane.width;
> >      dmabuf->buf.height =3D plane.height;
> > +    dmabuf->buf.backing_width =3D plane.width;
> > +    dmabuf->buf.backing_height =3D plane.height;
> >      dmabuf->buf.stride =3D plane.stride;
> >      dmabuf->buf.fourcc =3D plane.drm_format;
> >      dmabuf->buf.modifier =3D plane.drm_format_mod;
> >
> > I'll post that formally, but I really have no idea how dmabuf display
> > works, so confirmation would be appreciated.  Thanks, =20
>=20
> Looks correct to me. I wish Kim would chime in.
>=20
> I am not familiar with vfio/display. Looking at the kernel side, it
> seems it doesn't have a concept for scanout geometry that is different
> from the backing dmabuf/texture dimension.
>=20
> Should we make this a blocker for release? Are you sending the patch?

I did send a patch, Kim commented there:

https://lore.kernel.org/all/20230816215550.1723696-1-alex.williamson@redhat=
.com/

Follow-up suggest vhost-user-gpu is also affected.  Empirically the
patch I sent works, I think it's correct, but Gerd is probably most
qualified to respond to the comments.  I don't know how a "scanout"
relates to what we provide in vfio_device_gfx_plane_info.  Thanks,

Alex


