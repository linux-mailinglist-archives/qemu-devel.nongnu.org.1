Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AE177EB6E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNkb-0002dx-0A; Wed, 16 Aug 2023 17:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWNkY-0002cr-NS
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWNkW-0006so-7w
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692220095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DazAGzYaV4179lmSZxbn7P0S485MIo+K5VfWVwZh9Do=;
 b=dZ8UyqVEdDh81yGRXv+Aood8/b2y0/5NEWnyJt+XOKSth+QZHCikUiqeRzSeKDNlGJhiwL
 R8tTR36KrvTceg0Fe4odBiy590Ey1mzNEWOYr3Ww5SszbMmWAld2m0w0fHZqUp38qLXSEK
 bgys6wXWywF2+TC2QjITTUAgWDTffC8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-_Q3IQleaPua5Fqe_fo0P_g-1; Wed, 16 Aug 2023 17:08:13 -0400
X-MC-Unique: _Q3IQleaPua5Fqe_fo0P_g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1c4ba0afc65so6176704fac.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692220093; x=1692824893;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DazAGzYaV4179lmSZxbn7P0S485MIo+K5VfWVwZh9Do=;
 b=bmgpCZwMhlYAjfATYIn+iOh1TtHcTXENmPUEjg/GdrByppVuSfhJO1RaFwhUOuOnnd
 1jcklbGpicQI3YQAB0AROtMK4rzYznIM5zHfHumjZ1y7R8Ykbnch38yV6sf7SYePZXT+
 cYZluZUNWnmdhcU/MuipKeSyk8c2c+MsHBIoXDMVcsSQ3EhpQDsi4PwCVKTtU5fBfWqB
 8t94XRy3f4Pszse9bhOC5X/mcbChy4dR2Diy8+i+Cppq+A6a8g58okwEFzhG6qR98drL
 k3SQiilQ2T9RABd/4kTwvB6vIyw5LtPuFH9siAZCci2XQVHnPFf41YA/4iPiBwMhfbKz
 FOkQ==
X-Gm-Message-State: AOJu0YxOIgaHtrCtlAwKPgbv7mqMv8FL8ufmpXOJR13artWFakTP1GRd
 p8rjHYrBWVc2qSUKniEFmFu/3URSz1m36FWhXbMfZd68UO9bYn8rVS93qefx9QFPz77cVjiuE/s
 UbWVGmRpQ/X0t0dM=
X-Received: by 2002:a05:6870:9707:b0:1b0:60ff:b73f with SMTP id
 n7-20020a056870970700b001b060ffb73fmr3836738oaq.8.1692220093215; 
 Wed, 16 Aug 2023 14:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr1Sx8sbgyYFy9b4Qaf9KlIcHp3mTqpGnoFrsuCaFp4ofYUkxhEY0gV43G4i0AAMTjxn35XA==
X-Received: by 2002:a05:6870:9707:b0:1b0:60ff:b73f with SMTP id
 n7-20020a056870970700b001b060ffb73fmr3836721oaq.8.1692220092969; 
 Wed, 16 Aug 2023 14:08:12 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 y13-20020a02ce8d000000b0042bb394c249sm4304234jaq.38.2023.08.16.14.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 14:08:12 -0700 (PDT)
Date: Wed, 16 Aug 2023 15:08:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 richard.henderson@linaro.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>
Subject: [8.1 regression] Re: [PULL 05/19] virtio-gpu-udmabuf: correct
 naming of QemuDmaBuf size properties
Message-ID: <20230816150810.15d90b34.alex.williamson@redhat.com>
In-Reply-To: <20230717124545.177236-6-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-6-marcandre.lureau@redhat.com>
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

This commit introduces a regression when using GVT-g with the display
and ramfb options.  At the point where it appears the guest is switching
from ramfb to the vGPU display, the display goes black and QEMU reports:

qemu: eglCreateImageKHR failed

This message occurs repeatedly.

VM command line:

/usr/local/bin/qemu-system-x86_64 \
-M pc \
-machine kernel_irqchip=3Don \
-accel kvm \
-cpu host \
-m 6G \
-smp 4,sockets=3D1,dies=3D1,cores=3D4,threads=3D1 \
-smbios 'type=3D0,vendor=3DHP,version=3DP02 Ver. 02.44,date=3D09/13/2022,re=
lease=3D2.44' \
-smbios 'type=3D1,manufacturer=3DHP,product=3DHP ProDesk 600 G3 MT,serial=
=3DMXL745130H,sku=3DY3E02AV,family=3D103C_53307F HP ProDesk' \
-smbios 'type=3D2,manufacturer=3DHP,product=3D829D,version=3DKBC Version 06=
.29,serial=3DPFYUT0FCY9731K' \
-smbios type=3D3,manufacturer=3DHP,serial=3DMXL745130H,asset=3DMXL745130H \
-acpitable sig=3DSLIC,file=3D/var/lib/libvirt/images/slic.bin \
-acpitable sig=3DMSDM,file=3D/var/lib/libvirt/images/msdm.bin \
-global PIIX4_PM.disable_s3=3D1 \
-global PIIX4_PM.disable_s4=3D1 \
-rtc base=3Dlocaltime,driftfix=3Dslew \
-global kvm-pit.lost_tick_policy=3Ddelay \
-no-user-config \
-nodefaults \
-monitor stdio \
-serial none \
-parallel none \
-no-hpet \
-net nic,macaddr=3D5c:25:8e:a6:34:6e,model=3Dvirtio \
-net user \
-usb \
-usbdevice tablet \
-vga none \
-display gtk,gl=3Don \
-hda /var/lib/libvirt/images/win10-gvtg.qcow2 \
-device vfio-pci-nohotplug,sysfsdev=3D/sys/bus/mdev/devices/b1338b2d-a709-4=
c23-b766-cc436c36cdf0,display=3Don,ramfb=3Don,x-igd-opregion=3Don \
-snapshot

Thanks,
Alex

On Mon, 17 Jul 2023 16:45:30 +0400
marcandre.lureau@redhat.com wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>=20
> Replace 'width' and 'height' in QemuDmaBuf with 'backing_widht'
> and 'backing_height' as these commonly indicate the size of the
> whole surface (e.g. guest's Xorg extended display). Then use
> 'width' and 'height' for sub region in there (e.g. guest's
> scanouts).
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20230713040444.32267-1-dongwon.kim@intel.com>
> ---
>  include/ui/console.h            |  4 ++--
>  hw/display/virtio-gpu-udmabuf.c | 12 ++++++------
>  ui/dbus-listener.c              |  8 ++++----
>  ui/egl-helpers.c                |  8 ++++----
>  ui/gtk-egl.c                    | 10 ++++++----
>  ui/gtk-gl-area.c                |  7 ++++---
>  6 files changed, 26 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index f27b2aad4f..3e8b22d6c6 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -201,8 +201,8 @@ typedef struct QemuDmaBuf {
>      uint32_t  texture;
>      uint32_t  x;
>      uint32_t  y;
> -    uint32_t  scanout_width;
> -    uint32_t  scanout_height;
> +    uint32_t  backing_width;
> +    uint32_t  backing_height;
>      bool      y0_top;
>      void      *sync;
>      int       fence_fd;
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index ef1a740de5..d51184d658 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -181,13 +181,13 @@ static VGPUDMABuf
>      }
> =20
>      dmabuf =3D g_new0(VGPUDMABuf, 1);
> -    dmabuf->buf.width =3D fb->width;
> -    dmabuf->buf.height =3D fb->height;
> +    dmabuf->buf.width =3D r->width;
> +    dmabuf->buf.height =3D r->height;
>      dmabuf->buf.stride =3D fb->stride;
>      dmabuf->buf.x =3D r->x;
>      dmabuf->buf.y =3D r->y;
> -    dmabuf->buf.scanout_width =3D r->width;
> -    dmabuf->buf.scanout_height =3D r->height;
> +    dmabuf->buf.backing_width =3D fb->width;
> +    dmabuf->buf.backing_height =3D fb->height;
>      dmabuf->buf.fourcc =3D qemu_pixman_to_drm_format(fb->format);
>      dmabuf->buf.fd =3D res->dmabuf_fd;
>      dmabuf->buf.allow_fences =3D true;
> @@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
> =20
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con,
> -                        new_primary->buf.scanout_width,
> -                        new_primary->buf.scanout_height);
> +                        new_primary->buf.width,
> +                        new_primary->buf.height);
>      dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
> =20
>      if (old_primary) {
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 0240c39510..68ff343799 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -415,13 +415,13 @@ static void dbus_scanout_texture(DisplayChangeListe=
ner *dcl,
>                                 backing_width, backing_height, x, y, w, h=
);
>  #ifdef CONFIG_GBM
>      QemuDmaBuf dmabuf =3D {
> -        .width =3D backing_width,
> -        .height =3D backing_height,
> +        .width =3D w,
> +        .height =3D h,
>          .y0_top =3D backing_y_0_top,
>          .x =3D x,
>          .y =3D y,
> -        .scanout_width =3D w,
> -        .scanout_height =3D h,
> +        .backing_width =3D backing_width,
> +        .backing_height =3D backing_height,
>      };
> =20
>      assert(tex_id);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 8f9fbf583e..3d19dbe382 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
>      if (src->dmabuf) {
>          x1 =3D src->dmabuf->x;
>          y1 =3D src->dmabuf->y;
> -        w =3D src->dmabuf->scanout_width;
> -        h =3D src->dmabuf->scanout_height;
> +        w =3D src->dmabuf->width;
> +        h =3D src->dmabuf->height;
>      }
> =20
>      w =3D (x1 + w) > src->width ? src->width - x1 : w;
> @@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      }
> =20
>      attrs[i++] =3D EGL_WIDTH;
> -    attrs[i++] =3D dmabuf->width;
> +    attrs[i++] =3D dmabuf->backing_width;
>      attrs[i++] =3D EGL_HEIGHT;
> -    attrs[i++] =3D dmabuf->height;
> +    attrs[i++] =3D dmabuf->backing_height;
>      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
>      attrs[i++] =3D dmabuf->fourcc;
> =20
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 42db1bb6cf..eee821d73a 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -262,9 +262,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dc=
l,
>      }
> =20
>      gd_egl_scanout_texture(dcl, dmabuf->texture,
> -                           dmabuf->y0_top, dmabuf->width, dmabuf->height,
> -                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> -                           dmabuf->scanout_height, NULL);
> +                           dmabuf->y0_top,
> +                           dmabuf->backing_width, dmabuf->backing_height,
> +                           dmabuf->x, dmabuf->y, dmabuf->width,
> +                           dmabuf->height, NULL);
> =20
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
> @@ -284,7 +285,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
>          if (!dmabuf->texture) {
>              return;
>          }
> -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->=
height,
> +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
> +                             dmabuf->backing_width, dmabuf->backing_heig=
ht,
>                               dmabuf->texture, false);
>      } else {
>          egl_fb_destroy(&vc->gfx.cursor_fb);
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index a9a7fdf50c..4513d3d059 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -301,9 +301,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener=
 *dcl,
>      }
> =20
>      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> -                               dmabuf->y0_top, dmabuf->width, dmabuf->he=
ight,
> -                               dmabuf->x, dmabuf->y, dmabuf->scanout_wid=
th,
> -                               dmabuf->scanout_height, NULL);
> +                               dmabuf->y0_top,
> +                               dmabuf->backing_width, dmabuf->backing_he=
ight,
> +                               dmabuf->x, dmabuf->y, dmabuf->width,
> +                               dmabuf->height, NULL);
> =20
>      if (dmabuf->allow_fences) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;


