Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93DDA6E8B0
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 04:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twuw7-0001mg-8T; Mon, 24 Mar 2025 23:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twuw3-0001mR-Hm
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:26:39 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twuw0-0003E7-QY
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:26:39 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so8521150a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742873195; x=1743477995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGIOPgV99X8tgz5PpazRFl1LOTQcbmARhWmjosnD8s0=;
 b=PYGHWAJBX77+CeH735mXgO1adio2nQY9b3iYEmNF5ubnThPyrtf2ZbcCG/hY0/V/yX
 ON4mF6D9HQCy9zv6+885W1+3NXpLXKSiOJrJKr/VW2GSG49xSxwDD8vluLX9G+XmtG5t
 kPJCkArEDgguNNk7EAvGXhqmzY5Mq1mtCo6ZuCBraXEcsux3f5z6GoZeJIs6Jt+H8C8l
 NwDmA6G82ut3sudVDlncM/sztmeeAPGLAem+7gOKfaxs5ryqcN4480eq31e/45ucjxGk
 iu59GTgxPbYH17tUiLbQFZJHndMAODIl+jYlu0Vh7dWJ2xvZN29mdz87KPjHyZI26GmP
 NTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742873195; x=1743477995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGIOPgV99X8tgz5PpazRFl1LOTQcbmARhWmjosnD8s0=;
 b=VZXrG7Ce5ab3v00L4MlfrxbsYEgdyxq11eXh3jLWIMnHQXMpyxyPY3wwTgHbCY/3sk
 EqEXK5/Yjg83tI0bP+BJBmPRt43BHpXww94F8KaaL0Oj3OPFDOac2rvFR3NgHYN1MI5l
 bMbv7i4q7nx9TkGwIw8EfDd8ktyxoCg/c7erN8vR8rmY1KPIT4KB8SxmmIaW2SCJ8A8E
 3WaopuA9z1TzAJ8M93bfViy+1UnVN8cogW8ofJl2B8SGn/YeTiaf6O2+ZUwZ4H6kfhph
 Us0OMJxKnFjNWd0aXRFGCfDUSWS18LwuOZyFXJEk/YWdfav9BuyqLzc/WiQTJB7GvTMP
 tJ5Q==
X-Gm-Message-State: AOJu0YwuGJN9LTfqR8yERSgK4wQjCvGp1139d7LI1HttiAQuehNHcx8s
 LwwleL+Kz9WjkadGQrJpfhoYJFKiipVZ4AeQqx59+3fSIPb1fvDtkWSCv0lLJ6ivJYhYy6MGK6S
 QuHx/Bv7vMpWsHrWvi2pcIe01WJSJpoa7
X-Gm-Gg: ASbGncsxl1bAj3ox7IP/f9npC8gwmkOqHzW0eZTH37Go5XnJTB620k2o/VdQiEQggPi
 o8TyXG6T9ged5KylzC0l4xlOqwADsBkz2yiWifYyt7mZGWdu4nbOa2Hvqygx0plQLaCnk6LLO4E
 oDNtSgJ3bhHsoEN24XeU8wD0rabmQ=
X-Google-Smtp-Source: AGHT+IF9EaD6nwxIf0nT1qi58SNFD6VRJRbsv38joSqQHRRMKH8yF4H9MxD6ceCPIvgf+dBuuD4e+6aMHwiBIO87j+Y=
X-Received: by 2002:a05:6402:849:b0:5e5:3643:c8b5 with SMTP id
 4fb4d7f45d1cf-5ebcd51c823mr13264706a12.30.1742873194752; Mon, 24 Mar 2025
 20:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-2-yuq825@gmail.com>
 <CAMxuvawwGTN9Dh5tor-ADmNd_5AGnBEgwj7npiMSC59OWZJETg@mail.gmail.com>
 <CAKGbVbvKLhh0O+raaddhRRiZkC7cPur06FROM0miVP4oOWy7ZQ@mail.gmail.com>
 <CAJ+F1CJALHh4vUF1fm23Z8Pob7ob1aGkGKzig7PofkE-GfQFBw@mail.gmail.com>
In-Reply-To: <CAJ+F1CJALHh4vUF1fm23Z8Pob7ob1aGkGKzig7PofkE-GfQFBw@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 25 Mar 2025 11:26:23 +0800
X-Gm-Features: AQ5f1JpWJtrJOMHfMqzwwaSnrCnYrSDnNDsmHqNHVGdJob7EcU0f5cWZT3V-Sw4
Message-ID: <CAKGbVbtLPcn2Zq11coEgXOJwLbMAi9LGVtpkGQ7arqxapzk+gg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ui/dmabuf: extend QemuDmaBuf to support multi-plane
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=yuq825@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Mar 24, 2025 at 10:06=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Mar 24, 2025 at 5:20=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > On Mon, Mar 24, 2025 at 6:04=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Hi
> > >
> > > On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
> > > >
> > > > From: Qiang Yu <yuq825@gmail.com>
> > > >
> > > > mesa/radeonsi is going to support explicit midifier which
> > > > may export a multi-plane texture. For example, texture with
> > > > DCC enabled (a compressed format) has two planes, one with
> > > > compressed data, the other with meta data for compression.
> > > >
> > > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > > ---
> > > >  hw/display/vhost-user-gpu.c     |  6 ++-
> > > >  hw/display/virtio-gpu-udmabuf.c |  6 ++-
> > > >  hw/vfio/display.c               |  7 ++--
> > > >  include/ui/dmabuf.h             | 20 ++++++----
> > > >  ui/dbus-listener.c              | 10 ++---
> > > >  ui/dmabuf.c                     | 67 +++++++++++++++++++++--------=
----
> > > >  ui/egl-helpers.c                |  4 +-
> > > >  ui/spice-display.c              |  4 +-
> > > >  8 files changed, 76 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gp=
u.c
> > > > index 2aed6243f6..a7949c7078 100644
> > > > --- a/hw/display/vhost-user-gpu.c
> > > > +++ b/hw/display/vhost-user-gpu.c
> > > > @@ -249,6 +249,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, =
VhostUserGpuMsg *msg)
> > > >      case VHOST_USER_GPU_DMABUF_SCANOUT: {
> > > >          VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scan=
out;
> > > >          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
> > > > +        uint32_t offset =3D 0;
> > > > +        uint32_t stride =3D m->fd_stride;
> > > >          uint64_t modifier =3D 0;
> > > >          QemuDmaBuf *dmabuf;
> > > >
> > > > @@ -282,10 +284,10 @@ vhost_user_gpu_handle_display(VhostUserGPU *g=
, VhostUserGpuMsg *msg)
> > > >          }
> > > >
> > > >          dmabuf =3D qemu_dmabuf_new(m->width, m->height,
> > > > -                                 m->fd_stride, 0, 0,
> > > > +                                 &offset, &stride, 0, 0,
> > > >                                   m->fd_width, m->fd_height,
> > > >                                   m->fd_drm_fourcc, modifier,
> > > > -                                 fd, false, m->fd_flags &
> > > > +                                 &fd, 1, false, m->fd_flags &
> > > >                                   VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP)=
;
> > > >
> > > >          dpy_gl_scanout_dmabuf(con, dmabuf);
> > > > diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gp=
u-udmabuf.c
> > > > index 85ca23cb32..34fbe05b7a 100644
> > > > --- a/hw/display/virtio-gpu-udmabuf.c
> > > > +++ b/hw/display/virtio-gpu-udmabuf.c
> > > > @@ -176,16 +176,18 @@ static VGPUDMABuf
> > > >                            struct virtio_gpu_rect *r)
> > > >  {
> > > >      VGPUDMABuf *dmabuf;
> > > > +    uint32_t offset =3D 0;
> > > >
> > > >      if (res->dmabuf_fd < 0) {
> > > >          return NULL;
> > > >      }
> > > >
> > > >      dmabuf =3D g_new0(VGPUDMABuf, 1);
> > > > -    dmabuf->buf =3D qemu_dmabuf_new(r->width, r->height, fb->strid=
e,
> > > > +    dmabuf->buf =3D qemu_dmabuf_new(r->width, r->height,
> > > > +                                  &offset, &fb->stride,
> > > >                                    r->x, r->y, fb->width, fb->heigh=
t,
> > > >                                    qemu_pixman_to_drm_format(fb->fo=
rmat),
> > > > -                                  0, res->dmabuf_fd, true, false);
> > > > +                                  0, &res->dmabuf_fd, 1, true, fal=
se);
> > > >      dmabuf->scanout_id =3D scanout_id;
> > > >      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
> > > >
> > > > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > > > index ea87830fe0..9d882235fb 100644
> > > > --- a/hw/vfio/display.c
> > > > +++ b/hw/vfio/display.c
> > > > @@ -214,6 +214,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIO=
PCIDevice *vdev,
> > > >      struct vfio_device_gfx_plane_info plane;
> > > >      VFIODMABuf *dmabuf;
> > > >      int fd, ret;
> > > > +    uint32_t offset =3D 0;
> > > >
> > > >      memset(&plane, 0, sizeof(plane));
> > > >      plane.argsz =3D sizeof(plane);
> > > > @@ -246,10 +247,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VF=
IOPCIDevice *vdev,
> > > >
> > > >      dmabuf =3D g_new0(VFIODMABuf, 1);
> > > >      dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> > > > -    dmabuf->buf =3D qemu_dmabuf_new(plane.width, plane.height,
> > > > -                                  plane.stride, 0, 0, plane.width,
> > > > +    dmabuf->buf =3D qemu_dmabuf_new(plane.width, plane.height, &of=
fset,
> > > > +                                  &plane.stride, 0, 0, plane.width=
,
> > > >                                    plane.height, plane.drm_format,
> > > > -                                  plane.drm_format_mod, fd, false,=
 false);
> > > > +                                  plane.drm_format_mod, &fd, 1, fa=
lse, false);
> > > >
> > > >      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> > > >          vfio_display_update_cursor(dmabuf, &plane);
> > > > diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> > > > index dc74ba895a..407fb2274e 100644
> > > > --- a/include/ui/dmabuf.h
> > > > +++ b/include/ui/dmabuf.h
> > > > @@ -10,24 +10,29 @@
> > > >  #ifndef DMABUF_H
> > > >  #define DMABUF_H
> > > >
> > > > +#define DMABUF_MAX_PLANES 4
> > > > +
> > > >  typedef struct QemuDmaBuf QemuDmaBuf;
> > > >
> > > >  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> > > > -                            uint32_t stride, uint32_t x,
> > > > -                            uint32_t y, uint32_t backing_width,
> > > > -                            uint32_t backing_height, uint32_t four=
cc,
> > > > -                            uint64_t modifier, int dmabuf_fd,
> > > > +                            const uint32_t *offset, const uint32_t=
 *stride,
> > > > +                            uint32_t x, uint32_t y,
> > > > +                            uint32_t backing_width, uint32_t backi=
ng_height,
> > > > +                            uint32_t fourcc, uint64_t modifier,
> > > > +                            const int32_t *dmabuf_fd, uint32_t num=
_planes,
> > > >                              bool allow_fences, bool y0_top);
> > > >  void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
> > > >
> > > >  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
> > > >
> > > > -int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> > > > -int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);
> > > > +const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> > >
> > > For clarity, I think the functions should be renamed to a plural form=
:
> > > get_fds, dup_fds, get_strides, get_offsets etc.. I would also have a
> > > size_t *n_fds to return the length of the returned array.
> > >
> > The returned array length is always 4. Valid fds are within num_planes
> > elements. There's no user for n_fds argument.
>
> I understand it is not strictly needed, but it's about being explicit
> for the API, and making it safer for future refactoring as well.
>
Then we have to maintain a record for valid fds just for "explicit for API"=
?
These APIs are all internal use, we can change them whenever needed.
We should not add an used arg which costs extra maintenance effort.

> >
> > > > +void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd);
> > >
> > > That function should take an n_fds arguments as well (fd being rename=
d
> > > to fds as well)
> > >
> > We just dup all fds in dmabuf, so no need for n_fds argument. And there=
's
> > no use for this arg either.
> >
> > > thanks
> > >
> > > >  void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
> > > >  uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
> > > >  uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> > > > -uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> > > > +const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf);
> > > > +const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> > > > +uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf);
> > > >  uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
> > > >  uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
> > > >  uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> > > > @@ -44,6 +49,5 @@ void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, =
uint32_t texture);
> > > >  void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd=
);
> > > >  void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
> > > >  void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_=
submitted);
> > > > -void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
> > > >
> > > >  #endif
> > > > diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> > > > index 51244c9240..3b39a23846 100644
> > > > --- a/ui/dbus-listener.c
> > > > +++ b/ui/dbus-listener.c
> > > > @@ -299,7 +299,7 @@ static void dbus_scanout_dmabuf(DisplayChangeLi=
stener *dcl,
> > > >      uint64_t modifier;
> > > >      bool y0_top;
> > > >
> > > > -    fd =3D qemu_dmabuf_get_fd(dmabuf);
> > > > +    fd =3D qemu_dmabuf_get_fd(dmabuf)[0];
> > > >      fd_list =3D g_unix_fd_list_new();
> > > >      if (g_unix_fd_list_append(fd_list, fd, &err) !=3D 0) {
> > > >          error_report("Failed to setup dmabuf fdlist: %s", err->mes=
sage);
> > > > @@ -310,7 +310,7 @@ static void dbus_scanout_dmabuf(DisplayChangeLi=
stener *dcl,
> > > >
> > > >      width =3D qemu_dmabuf_get_width(dmabuf);
> > > >      height =3D qemu_dmabuf_get_height(dmabuf);
> > > > -    stride =3D qemu_dmabuf_get_stride(dmabuf);
> > > > +    stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > >      fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> > > >      modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> > > >      y0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > > > @@ -505,7 +505,7 @@ static void dbus_scanout_texture(DisplayChangeL=
istener *dcl,
> > > >  #ifdef CONFIG_GBM
> > > >      g_autoptr(QemuDmaBuf) dmabuf =3D NULL;
> > > >      int fd;
> > > > -    uint32_t stride, fourcc;
> > > > +    uint32_t offset =3D 0, stride, fourcc;
> > > >      uint64_t modifier;
> > > >
> > > >      assert(tex_id);
> > > > @@ -515,8 +515,8 @@ static void dbus_scanout_texture(DisplayChangeL=
istener *dcl,
> > > >          error_report("%s: failed to get fd for texture", __func__)=
;
> > > >          return;
> > > >      }
> > > > -    dmabuf =3D qemu_dmabuf_new(w, h, stride, x, y, backing_width,
> > > > -                             backing_height, fourcc, modifier, fd,
> > > > +    dmabuf =3D qemu_dmabuf_new(w, h, &offset, &stride, x, y, backi=
ng_width,
> > > > +                             backing_height, fourcc, modifier, &fd=
, 1,
> > > >                               false, backing_y_0_top);
> > > >
> > > >      dbus_scanout_dmabuf(dcl, dmabuf);
> > > > diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> > > > index df7a09703f..c4eb307042 100644
> > > > --- a/ui/dmabuf.c
> > > > +++ b/ui/dmabuf.c
> > > > @@ -11,10 +11,12 @@
> > > >  #include "ui/dmabuf.h"
> > > >
> > > >  struct QemuDmaBuf {
> > > > -    int       fd;
> > > > +    int       fd[DMABUF_MAX_PLANES];
> > > >      uint32_t  width;
> > > >      uint32_t  height;
> > > > -    uint32_t  stride;
> > > > +    uint32_t  offset[DMABUF_MAX_PLANES];
> > > > +    uint32_t  stride[DMABUF_MAX_PLANES];
> > > > +    uint32_t  num_planes;
> > > >      uint32_t  fourcc;
> > > >      uint64_t  modifier;
> > > >      uint32_t  texture;
> > > > @@ -30,28 +32,33 @@ struct QemuDmaBuf {
> > > >  };
> > > >
> > > >  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> > > > -                            uint32_t stride, uint32_t x,
> > > > -                            uint32_t y, uint32_t backing_width,
> > > > -                            uint32_t backing_height, uint32_t four=
cc,
> > > > -                            uint64_t modifier, int32_t dmabuf_fd,
> > > > +                            const uint32_t *offset, const uint32_t=
 *stride,
> > > > +                            uint32_t x, uint32_t y,
> > > > +                            uint32_t backing_width, uint32_t backi=
ng_height,
> > > > +                            uint32_t fourcc, uint64_t modifier,
> > > > +                            const int32_t *dmabuf_fd, uint32_t num=
_planes,
> > > >                              bool allow_fences, bool y0_top) {
> > > >      QemuDmaBuf *dmabuf;
> > > >
> > > > +    assert(num_planes > 0 && num_planes <=3D DMABUF_MAX_PLANES);
> > > > +
> > > >      dmabuf =3D g_new0(QemuDmaBuf, 1);
> > > >
> > > >      dmabuf->width =3D width;
> > > >      dmabuf->height =3D height;
> > > > -    dmabuf->stride =3D stride;
> > > > +    memcpy(dmabuf->offset, offset, num_planes * sizeof(*offset));
> > > > +    memcpy(dmabuf->stride, stride, num_planes * sizeof(*stride));
> > > >      dmabuf->x =3D x;
> > > >      dmabuf->y =3D y;
> > > >      dmabuf->backing_width =3D backing_width;
> > > >      dmabuf->backing_height =3D backing_height;
> > > >      dmabuf->fourcc =3D fourcc;
> > > >      dmabuf->modifier =3D modifier;
> > > > -    dmabuf->fd =3D dmabuf_fd;
> > > > +    memcpy(dmabuf->fd, dmabuf_fd, num_planes * sizeof(*dmabuf_fd))=
;
> > > >      dmabuf->allow_fences =3D allow_fences;
> > > >      dmabuf->y0_top =3D y0_top;
> > > >      dmabuf->fence_fd =3D -1;
> > > > +    dmabuf->num_planes =3D num_planes;
> > > >
> > > >      return dmabuf;
> > > >  }
> > > > @@ -65,31 +72,35 @@ void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
> > > >      g_free(dmabuf);
> > > >  }
> > > >
> > > > -int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> > > > +const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> > > >  {
> > > >      assert(dmabuf !=3D NULL);
> > > >
> > > >      return dmabuf->fd;
> > > >  }
> > > >
> > > > -int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
> > > > +void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd)
> > > >  {
> > > > +    int i;
> > > > +
> > > >      assert(dmabuf !=3D NULL);
> > > >
> > > > -    if (dmabuf->fd >=3D 0) {
> > > > -        return dup(dmabuf->fd);
> > > > -    } else {
> > > > -        return -1;
> > > > +    for (i =3D 0; i < dmabuf->num_planes; i++) {
> > > > +        fd[i] =3D dmabuf->fd[i] >=3D 0 ? dup(dmabuf->fd[i]) : -1;
> > > >      }
> > > >  }
> > > >
> > > >  void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
> > > >  {
> > > > +    int i;
> > > > +
> > > >      assert(dmabuf !=3D NULL);
> > > >
> > > > -    if (dmabuf->fd >=3D 0) {
> > > > -        close(dmabuf->fd);
> > > > -        dmabuf->fd =3D -1;
> > > > +    for (i =3D 0; i < dmabuf->num_planes; i++) {
> > > > +        if (dmabuf->fd[i] >=3D 0) {
> > > > +            close(dmabuf->fd[i]);
> > > > +            dmabuf->fd[i] =3D -1;
> > > > +        }
> > > >      }
> > > >  }
> > > >
> > > > @@ -107,13 +118,27 @@ uint32_t qemu_dmabuf_get_height(QemuDmaBuf *d=
mabuf)
> > > >      return dmabuf->height;
> > > >  }
> > > >
> > > > -uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
> > > > +const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf)
> > > > +{
> > > > +    assert(dmabuf !=3D NULL);
> > > > +
> > > > +    return dmabuf->offset;
> > > > +}
> > > > +
> > > > +const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
> > > >  {
> > > >      assert(dmabuf !=3D NULL);
> > > >
> > > >      return dmabuf->stride;
> > > >  }
> > > >
> > > > +uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf)
> > > > +{
> > > > +    assert(dmabuf !=3D NULL);
> > > > +
> > > > +    return dmabuf->num_planes;
> > > > +}
> > > > +
> > > >  uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
> > > >  {
> > > >      assert(dmabuf !=3D NULL);
> > > > @@ -221,9 +246,3 @@ void qemu_dmabuf_set_draw_submitted(QemuDmaBuf =
*dmabuf, bool draw_submitted)
> > > >      assert(dmabuf !=3D NULL);
> > > >      dmabuf->draw_submitted =3D draw_submitted;
> > > >  }
> > > > -
> > > > -void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
> > > > -{
> > > > -    assert(dmabuf !=3D NULL);
> > > > -    dmabuf->fd =3D fd;
> > > > -}
> > > > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > > > index d591159480..72a1405782 100644
> > > > --- a/ui/egl-helpers.c
> > > > +++ b/ui/egl-helpers.c
> > > > @@ -323,9 +323,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmab=
uf)
> > > >      attrs[i++] =3D qemu_dmabuf_get_fourcc(dmabuf);
> > > >
> > > >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_FD_EXT;
> > > > -    attrs[i++] =3D qemu_dmabuf_get_fd(dmabuf);
> > > > +    attrs[i++] =3D qemu_dmabuf_get_fd(dmabuf)[0];
> > > >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_PITCH_EXT;
> > > > -    attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf);
> > > > +    attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> > > >      attrs[i++] =3D 0;
> > > >  #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> > > > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > > > index c794ae0649..82598fe9e8 100644
> > > > --- a/ui/spice-display.c
> > > > +++ b/ui/spice-display.c
> > > > @@ -1075,10 +1075,10 @@ static void qemu_spice_gl_update(DisplayCha=
ngeListener *dcl,
> > > >                                       stride, fourcc, false);
> > > >              }
> > > >          } else {
> > > > -            stride =3D qemu_dmabuf_get_stride(dmabuf);
> > > > +            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > >              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> > > >              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > > > -            fd =3D qemu_dmabuf_dup_fd(dmabuf);
> > > > +            qemu_dmabuf_dup_fd(dmabuf, &fd);
> > > >
> > > >              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width,=
 height);
> > > >              /* note: spice server will close the fd, so hand over =
a dup */
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

