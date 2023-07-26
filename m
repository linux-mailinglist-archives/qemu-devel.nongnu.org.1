Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7B763B69
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMn-0003vV-3P; Wed, 26 Jul 2023 10:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOfMk-0003uv-MA
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:50 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOfMe-0001Zg-FQ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:45 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bb14015560so4355056a34.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690381182; x=1690985982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkQDPlYhgeXhj3BN5pPezBjzhQoZzgPPxRD0O8li+Yk=;
 b=P2b6NiU5OSw5Z8xW3ug12Iii0thOL/2MedSVE1iwSeMpIYkrOCdVMbpUgx382FYNMp
 InmChy3N/SfGgDpcdCTPdJAfkNDIR1Bt3SyRzyvBszT1dkrusKNTW4ytn5DNTLZcpv0Z
 BuXsdMOgGz4sbkyXcwXF609L1WorecbCZCMXOo0pzTAe9FyQlC37YdEnN8oGlaC+Cxoy
 k7rwyD0GxVLbwvCLka7ZJbZTnoIdIbgi9pQTKCXEPYn21G3DK/PeW6aHPs2n1h63Se54
 k99cGOW8uCmvF3aEVykAe1VhUMbmxYwPdqfJ0idiMw2xTMO5NOQ5fuoI/PtNB/J6BMu9
 bUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690381182; x=1690985982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkQDPlYhgeXhj3BN5pPezBjzhQoZzgPPxRD0O8li+Yk=;
 b=hjUdyFqRK9bnPz15YokV1EFxPa67Y91MnEpm6X8g1Gid8YILJbR9R4OVQrWK5CyZ3G
 UiqRFgZPTaKT3vfG0yYRKmGsrc+tSZZF6uHg/SX0NlcudESkb9ZdCDyKp1ez58vPt6Ef
 jF6yDZ9uDra5yxpsZFdO/uzR7F2XjiWpAKOHtyrTXRsWeUXXnb9fomHj3h6cipBxLE5r
 LYplPJsaLgxvm1bb78QG11d3o0vkSy8sDWX74gj3acNwJtdTwom7iEbeFUab/7E1AyfC
 PGnL9MveG/MDhjVM8P/oI7bJsoPTyvhx3+y6MaAI9dpjIXFpSlBzE5euXqhrqN/WOthM
 XXeA==
X-Gm-Message-State: ABy/qLYls9WhWckPeUvE95Mev51gU+ePNxiR0k+LGzcjM92yurNhmOFx
 PMqTYERCig4upYALc6Vyl5Cx0mB/OSnY0fwr3r5ZSwOcuvM=
X-Google-Smtp-Source: APBJJlEILOlgYJIDw3gasoWXvPH2YmqhJjJgiaABTeslFghNXFjJopPh+wY417LlpPPbf7B+j0ghNQ/3bvq1aQNdpS4=
X-Received: by 2002:a05:6358:338c:b0:135:57d0:d170 with SMTP id
 i12-20020a056358338c00b0013557d0d170mr2240867rwd.11.1690381181661; Wed, 26
 Jul 2023 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-5-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Jul 2023 18:19:30 +0400
Message-ID: <CAJ+F1CK+_RvoyPw10WNckuV_DamGriQ5EA_qVn30bU9Kkj1Piw@mail.gmail.com>
Subject: Re: [PULL 04/19] virtio-gpu: replace the surface with null surface
 when resetting
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Dongwon

On Mon, Jul 17, 2023 at 4:46=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> The primary guest scanout shows the booting screen right after reboot
> but additional guest displays (i.e. max_ouptuts > 1) will keep displaying
> the old frames until the guest virtio gpu driver gets initialized, which
> could cause some confusion. A better way is to to replace the surface wit=
h
> a place holder that tells the display is not active during the reset of
> virtio-gpu device.
>
> And to immediately update the surface with the place holder image after
> the switch, displaychangelistener_gfx_switch needs to be called with
> 'update =3D=3D TRUE' in dpy_gfx_replace_surface when the new surface is N=
ULL.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20230627224451.11739-1-dongwon.kim@intel.com>
> ---
>  hw/display/virtio-gpu.c |  5 +++++
>  ui/console.c            | 11 ++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e937c4e348..e8603d78ca 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1397,6 +1397,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>      VirtIOGPU *g =3D VIRTIO_GPU(vdev);
>      struct virtio_gpu_simple_resource *res, *tmp;
>      struct virtio_gpu_ctrl_command *cmd;
> +    int i =3D 0;
>
>      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>          virtio_gpu_resource_destroy(g, res);
> @@ -1415,6 +1416,10 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>          g_free(cmd);
>      }
>
> +    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);

There is an issue with this change, it may end up calling GL functions
on non-main thread. This is not safe, and crashes at least on Windows,
because the GL contexts are differents (ANGLE with gl=3Des, OPENGL32 for
other threads), and in general I think we shouldn't use GL from
different threads. I am looking at fixing this somehow...

> +    }
> +
>      virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>  }
>
> diff --git a/ui/console.c b/ui/console.c
> index c1544e0fb8..8da2170a7e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1898,6 +1898,7 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>      static const char placeholder_msg[] =3D "Display output is not activ=
e.";
>      DisplayState *s =3D con->ds;
>      DisplaySurface *old_surface =3D con->surface;
> +    DisplaySurface *new_surface =3D surface;
>      DisplayChangeListener *dcl;
>      int width;
>      int height;
> @@ -1911,19 +1912,19 @@ void dpy_gfx_replace_surface(QemuConsole *con,
>              height =3D 480;
>          }
>
> -        surface =3D qemu_create_placeholder_surface(width, height, place=
holder_msg);
> +        new_surface =3D qemu_create_placeholder_surface(width, height, p=
laceholder_msg);
>      }
>
> -    assert(old_surface !=3D surface);
> +    assert(old_surface !=3D new_surface);
>
>      con->scanout.kind =3D SCANOUT_SURFACE;
> -    con->surface =3D surface;
> -    dpy_gfx_create_texture(con, surface);
> +    con->surface =3D new_surface;
> +    dpy_gfx_create_texture(con, new_surface);
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (con !=3D (dcl->con ? dcl->con : active_console)) {
>              continue;
>          }
> -        displaychangelistener_gfx_switch(dcl, surface, FALSE);
> +        displaychangelistener_gfx_switch(dcl, new_surface, surface ? FAL=
SE : TRUE);
>      }
>      dpy_gfx_destroy_texture(con, old_surface);
>      qemu_free_displaysurface(old_surface);
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

