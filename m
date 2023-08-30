Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218EF78D5A5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJhd-0002yj-0D; Wed, 30 Aug 2023 07:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbJhb-0002yF-0M
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qbJhY-0003d6-Fm
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693396175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGl9bR4kMZ00rZWOPp87vP0ijGfgEiUV8trD8w9/y10=;
 b=g4aXsaUGVG/id+Pnwml/hMy1vG6qcG8xRYU0Pw5/IL9wIFTtLFoCktzW+07ZCMptTg4b1V
 JjQaYP97ZdFpeXLbtMuVAdh86wLUB0db/PtngRMCurmzAV3IySSgS/QDGIzc5GWKvG4OG5
 AJM9V+BlNLBgynUQgR3OFZZEyIlhG7c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-2QklJ8t0OI2AyAFCJyre9Q-1; Wed, 30 Aug 2023 07:49:34 -0400
X-MC-Unique: 2QklJ8t0OI2AyAFCJyre9Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-52c05552645so359389a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 04:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693396173; x=1694000973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGl9bR4kMZ00rZWOPp87vP0ijGfgEiUV8trD8w9/y10=;
 b=Ud9N4tXT589F3ZkniZc6fwjZDKSki2Lv0bePVk5a1xIMCcqVgQ5rez99wJ4SEHFgFv
 F9pcpxUvVaKmOfdAz0THCFQ580U91vGJ5mbuVqkRftEWbTlodt2tf1hYG3S00IjkHjPd
 IQpaCnf3GOSP0PQNqVrV3AKwt80ruFdGDbCLkr5An4/4wSOhJ39J7apNQXoUTNDXnpLW
 Sbmmsx8gfiXFWsw5IJ4E+kcdYw4CxM2+r+2C/3t6KqKf5KPigfO2FAQr+0r/6/7mNWCd
 5tLXevBeYXv2WRjwdKOqpSBR+UVuQWBN5sB4nc7R5q5SJrbziNTcovc/JDgnOVPqwc52
 X+zA==
X-Gm-Message-State: AOJu0YwfWuv/Qz8fnBQGS112Um4OFh0MAYEuDdigJPNLPfJFcqm1scuY
 tu92LSFJwe7GiSWIstqt8F/ANXxiYQE6nSfdKoDpAhNe3j+gynZmyfziFhFZr4fEBVGH2QcKc43
 jgwiAbrFoLSTJzAsCPomEdguD7g1TEFw=
X-Received: by 2002:aa7:d7cf:0:b0:523:2df6:396a with SMTP id
 e15-20020aa7d7cf000000b005232df6396amr1808839eds.37.1693396172892; 
 Wed, 30 Aug 2023 04:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3BiKtM7mi3ToMtJTLsWIKQMA5VSo1PyN9zD0J+7Ugj4DdPe7bRfHuOFiDi6gr7hA0PtMn4A+n+pnw6w/2cHk=
X-Received: by 2002:aa7:d7cf:0:b0:523:2df6:396a with SMTP id
 e15-20020aa7d7cf000000b005232df6396amr1808826eds.37.1693396172492; Wed, 30
 Aug 2023 04:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
 <20230606115658.677673-18-marcandre.lureau@redhat.com>
 <7f446eba-52bb-187f-d098-ee70d4aff325@quicinc.com>
In-Reply-To: <7f446eba-52bb-187f-d098-ee70d4aff325@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 30 Aug 2023 15:49:20 +0400
Message-ID: <CAMxuvaz=oUDQORDFW5xw8n-2ryoq0-KZY1Z=P2efTuMmQtkwDA@mail.gmail.com>
Subject: Re: [PATCH 17/21] virtio-gpu-virgl: teach it to get the QEMU EGL
 display
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi Antonio

On Wed, Aug 30, 2023 at 3:14=E2=80=AFPM Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> I've been testing this, but I can't find where qemu_egl_display is set
> when using sdl.
>
> Whil ui/gtk.c sets that in gl_area_realize, from my understanding there
> is no equivalent call in ui/sdl2-gl.c
>
> Also, in which case SDL would use EGL, and is there a way to request
> that (e.g. as opposed to GLX)?

I am not sure, it's a tricky question. It seems SDL will use EGL when
requesting ES (-display sdl,gl=3Des), at least with x11 and wayland (and
win32 iirc). There is also SDL_VIDEO_X11_FORCE_EGL.

Yes, some code is missing in sdl2.c to set qemu_egl_display so virgl
can rely on it. Patches welcome!

>
> Kind regards,
> Antonio Caggiano
>
> On 06/06/2023 13:56, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virgl offers a few features that require to have access to the
> > underlying EGLDisplay. This is the case for the D3D texture sharing sup=
port.
> >
> > The API callback is merged for virgl 1.0:
> > https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/111=
3
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-virgl.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 1c47603d40..9831c482e5 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -18,9 +18,17 @@
> >   #include "hw/virtio/virtio.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >
> > +#include "ui/egl-helpers.h"
> > +
> >   #include <virglrenderer.h>
> >
> > -static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
> > +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
> > +static void *
> > +virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
> > +{
> > +    return qemu_egl_display;
> > +}
> > +#endif
> >
> >   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
> >                                            struct virtio_gpu_ctrl_comma=
nd *cmd)
> > @@ -608,6 +616,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >   {
> >       int ret;
> >
> > +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
> > +    if (qemu_egl_display) {
> > +        virtio_gpu_3d_cbs.version =3D 4;
> > +        virtio_gpu_3d_cbs.get_egl_display =3D virgl_get_egl_display;
> > +    }
> > +#endif
> > +
> >       ret =3D virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
> >       if (ret !=3D 0) {
> >           error_report("virgl could not be initialized: %d", ret);
>


