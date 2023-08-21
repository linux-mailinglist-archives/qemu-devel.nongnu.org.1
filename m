Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C72EA7826F4
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 12:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY21q-00015B-JU; Mon, 21 Aug 2023 06:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qY21o-00014o-91
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qY21l-0006rZ-SP
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692613252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeIO5SRWiE/2DaosC+f2jXqbwTIz4r9wFRr5/y8tp2o=;
 b=My7DsMCvhCKDq341iAPIYUAfLlB+Lr2rG8QsMmMZMCQMZX8YkFSa6YAdjXCt615PCC9oMV
 zB/kVkerIzW6K5c3ugU3jUxCpVX1U4S5v1P7GMli0O8VUbnj19X+i28LGAofzYFEbacfLD
 ZnpQJh3eUjSnnnIDz12WFxKm9YWNJTo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-9UpWfewWPNijOVdK7ai4nA-1; Mon, 21 Aug 2023 06:20:50 -0400
X-MC-Unique: 9UpWfewWPNijOVdK7ai4nA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so2138774a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 03:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692613250; x=1693218050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeIO5SRWiE/2DaosC+f2jXqbwTIz4r9wFRr5/y8tp2o=;
 b=ZcqtYd7bQ6G7iq+6kmgVEArNROaat/hOcOwLeDoTakpPUpUNnS6yiOIjPFI3YKA6wX
 3pBrL+7IJPLwqAMFyC2yQ5IemZv4UsCFQdmqvTS1KIRhPt5uuuGFPH9s2DHQFmvdpi+J
 2fIgDnQ79ZdGGdDn15X5pMkv1gXaN+l0nhTaTUsDfOmQI8Esdy7xiYh2F2WYBMLYWFUb
 dEcwLtSFWtgaU05bvi032YiXeq1Ir/w6Ey/lHStV1hrVwMFDhro4mMlU2QmneJhXQYiX
 +qCIm1E8awpVtrF9P6DCQHHBwfHuAEdIwzZbY4bt+GXl+mgVogoOfdWlq1Z/5b2r0Hc5
 CXDQ==
X-Gm-Message-State: AOJu0YxXHtbeUkuLB6tN56j4YweX4f0IBxgWn60EegzhphPyR2sMyq0e
 js6dhWCiWCdx4jnfHngaVYMFCXQgRHE1oah5iG6zo1iZZuwSRjmdJfDcky7G3V+z7a68rOxONDb
 G9VFU/zPpXPBHHbNdoe/2dItWBSrjpIw=
X-Received: by 2002:aa7:d3d2:0:b0:523:d715:b7b3 with SMTP id
 o18-20020aa7d3d2000000b00523d715b7b3mr3739684edr.41.1692613249807; 
 Mon, 21 Aug 2023 03:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2RNBF4bl1QGHST31aQcAHqJ6oVI6ZsupAB/E/ylxZ2lFC8BF28ymIoOITZZg3DyFkueoh5LscQeTmjeEBJiQ=
X-Received: by 2002:aa7:d3d2:0:b0:523:d715:b7b3 with SMTP id
 o18-20020aa7d3d2000000b00523d715b7b3mr3739664edr.41.1692613249478; Mon, 21
 Aug 2023 03:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-6-marcandre.lureau@redhat.com>
 <20230816150810.15d90b34.alex.williamson@redhat.com>
 <20230816152549.09cfcece.alex.williamson@redhat.com>
In-Reply-To: <20230816152549.09cfcece.alex.williamson@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Aug 2023 14:20:38 +0400
Message-ID: <CAMxuvaxjHq=3oB74McSdHSMthtv0XLwk0k6tW92FjY1yyeoA_w@mail.gmail.com>
Subject: Re: [8.1 regression] Re: [PULL 05/19] virtio-gpu-udmabuf: correct
 naming of QemuDmaBuf size properties
To: Alex Williamson <alex.williamson@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Alex

On Thu, Aug 17, 2023 at 1:25=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 16 Aug 2023 15:08:10 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> > > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > > index 8f9fbf583e..3d19dbe382 100644
> > > --- a/ui/egl-helpers.c
> > > +++ b/ui/egl-helpers.c
> > > @@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf=
)
> > >      }
> > >
> > >      attrs[i++] =3D EGL_WIDTH;
> > > -    attrs[i++] =3D dmabuf->width;
> > > +    attrs[i++] =3D dmabuf->backing_width;
> > >      attrs[i++] =3D EGL_HEIGHT;
> > > -    attrs[i++] =3D dmabuf->height;
> > > +    attrs[i++] =3D dmabuf->backing_height;
> > >      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
> > >      attrs[i++] =3D dmabuf->fourcc;
> > >
> > > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> > > index 42db1bb6cf..eee821d73a 100644
> > > --- a/ui/gtk-egl.c
> > > +++ b/ui/gtk-egl.c
> > > @@ -262,9 +262,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener=
 *dcl,
> > >      }
> > >
> > >      gd_egl_scanout_texture(dcl, dmabuf->texture,
> > > -                           dmabuf->y0_top, dmabuf->width, dmabuf->he=
ight,
> > > -                           dmabuf->x, dmabuf->y, dmabuf->scanout_wid=
th,
> > > -                           dmabuf->scanout_height, NULL);
> > > +                           dmabuf->y0_top,
> > > +                           dmabuf->backing_width, dmabuf->backing_he=
ight,
> > > +                           dmabuf->x, dmabuf->y, dmabuf->width,
> > > +                           dmabuf->height, NULL);
> > >
> > >      if (dmabuf->allow_fences) {
> > >          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> > > @@ -284,7 +285,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *=
dcl,
> > >          if (!dmabuf->texture) {
> > >              return;
> > >          }
> > > -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmab=
uf->height,
> > > +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
> > > +                             dmabuf->backing_width, dmabuf->backing_=
height,
> > >                               dmabuf->texture, false);
> > >      } else {
> > >          egl_fb_destroy(&vc->gfx.cursor_fb);
> > > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > > index a9a7fdf50c..4513d3d059 100644
> > > --- a/ui/gtk-gl-area.c
> > > +++ b/ui/gtk-gl-area.c
> > > @@ -301,9 +301,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeList=
ener *dcl,
> > >      }
> > >
> > >      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> > > -                               dmabuf->y0_top, dmabuf->width, dmabuf=
->height,
> > > -                               dmabuf->x, dmabuf->y, dmabuf->scanout=
_width,
> > > -                               dmabuf->scanout_height, NULL);
> > > +                               dmabuf->y0_top,
> > > +                               dmabuf->backing_width, dmabuf->backin=
g_height,
> > > +                               dmabuf->x, dmabuf->y, dmabuf->width,
> > > +                               dmabuf->height, NULL);
> > >
> > >      if (dmabuf->allow_fences) {
> > >          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> >
>
> I suspect the issues is in these last few chunks where width and height
> are replaced with backing_width and backing height, but
> hw/vfio/display.c never sets backing_*.  It appears that the following
> resolves the issue:
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482f4..837d9e6a309e 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -243,6 +243,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDev=
ice *vdev,
>      dmabuf->dmabuf_id  =3D plane.dmabuf_id;
>      dmabuf->buf.width  =3D plane.width;
>      dmabuf->buf.height =3D plane.height;
> +    dmabuf->buf.backing_width =3D plane.width;
> +    dmabuf->buf.backing_height =3D plane.height;
>      dmabuf->buf.stride =3D plane.stride;
>      dmabuf->buf.fourcc =3D plane.drm_format;
>      dmabuf->buf.modifier =3D plane.drm_format_mod;
>
> I'll post that formally, but I really have no idea how dmabuf display
> works, so confirmation would be appreciated.  Thanks,

Looks correct to me. I wish Kim would chime in.

I am not familiar with vfio/display. Looking at the kernel side, it
seems it doesn't have a concept for scanout geometry that is different
from the backing dmabuf/texture dimension.

Should we make this a blocker for release? Are you sending the patch?


