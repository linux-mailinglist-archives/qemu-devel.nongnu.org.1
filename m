Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C1705F92
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 07:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzA01-000591-0A; Wed, 17 May 2023 01:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pz9zr-00054Q-2B
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pz9zp-0000je-4g
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684302403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLJvxUc8QYWDiE1yiMmwGLrslnhOylQKotD9gfXcAgM=;
 b=c16ZnjorU/nvNMB2MDM+PyZsvWs6Dj6YCh7Xv+ncEOleip+63P47LFfBpbjVwQmsiw9QHO
 l+eG4IGqib/LIW0dMI4Jghgs/8K3NWgdRHlUivOi9Kb/X3WgOYK4ve3Hpk/pYBXE7nsfE+
 InwUo4+MZV4GeJIWAEAqL6YrQsmGnfI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-FdUD14aNO-qHIcEofbOebA-1; Wed, 17 May 2023 01:46:41 -0400
X-MC-Unique: FdUD14aNO-qHIcEofbOebA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-560ee0df572so4386807b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 22:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684302401; x=1686894401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLJvxUc8QYWDiE1yiMmwGLrslnhOylQKotD9gfXcAgM=;
 b=H/oxDRjeHvfRfHDnNUCFoxsJxYy6rt1V5ET7RSHMnHo/phPl+yz560PKR4WKxFlPUk
 a2HaiKa+8XFuD7HH4PorDiZzCgkPgNJRgAGjdXUBQR29aA7iBqvGrHHqmE2NUnhZEMJA
 wGkYbKBCeEUTJuA8/Q+ttLmruBdevuk47DZtW51I1/LOrd/Q4EieUFVAEXRBb7EpDgVW
 gGg1tJ/YqUxFIs4g854FpzVTvW7+x/OWpwWtYNA4vQt05RZXkfEMS+AApoGoJQ6ZDELq
 /T+dqSTlJ6eHi8Qv1WPNPvZG+Uyh0fD5l8gfwD8GGkcBue6lftHAKJ3cxpSw3ed77QxQ
 WpzA==
X-Gm-Message-State: AC+VfDyfd03UtsXtH4vN42R+g9bifU1jqxOehmmExF2hXtA6GSX+ZI2H
 1MWb02m1hSHQcLTy3j6AOSMACbmeqPvSnNgGkZKJHTzE+W9h6hAAuwZsWhKeWiSz2dY87b+S/j0
 rHihYCKfclGmrVLox5RJ4ymdbB4x4AnI=
X-Received: by 2002:a81:a144:0:b0:561:baab:fd22 with SMTP id
 y65-20020a81a144000000b00561baabfd22mr1654554ywg.3.1684302401116; 
 Tue, 16 May 2023 22:46:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76P4YcyvKKcFwyZqMALuJ6F1XMVvAoVsBAQumO6oaTFkwmtp+2xaEOvDR/EUwgiTP4YsX5RvLYDj3fC69bSTw=
X-Received: by 2002:a81:a144:0:b0:561:baab:fd22 with SMTP id
 y65-20020a81a144000000b00561baabfd22mr1654540ywg.3.1684302400834; Tue, 16 May
 2023 22:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-3-eperezma@redhat.com>
 <CACGkMEufH7ZvJxKzbSXpv8G5RodKeh_WHj6iTe=YqG9pdp45nQ@mail.gmail.com>
In-Reply-To: <CACGkMEufH7ZvJxKzbSXpv8G5RodKeh_WHj6iTe=YqG9pdp45nQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 May 2023 07:46:04 +0200
Message-ID: <CAJaqyWebY4Ft9cTO8FpWeGiYRik60530HYONTgKy7RtZTDJ6-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] vdpa: add vhost_vdpa_reset_status_fd
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, longpeng2@huawei.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, alvaro.karsz@solid-run.com, 
 Liuxiangdong <liuxiangdong5@huawei.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 si-wei.liu@oracle.com, 
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 17, 2023 at 5:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This allows to reset a vhost-vdpa device from external subsystems like
> > vhost-net, since it does not have any struct vhost_dev by the time we
> > need to use it.
> >
> > It is used in subsequent patches to negotiate features
> > and probe for CVQ ASID isolation.
> >
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  include/hw/virtio/vhost-vdpa.h |  1 +
> >  hw/virtio/vhost-vdpa.c         | 58 +++++++++++++++++++++++-----------
> >  2 files changed, 41 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index c278a2a8de..28de7da91e 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -54,6 +54,7 @@ typedef struct vhost_vdpa {
> >      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
> >  } VhostVDPA;
> >
> > +void vhost_vdpa_reset_status_fd(int fd);
> >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *io=
va_range);
> >
> >  int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iov=
a,
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index bbabea18f3..7a2053b8d9 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -335,38 +335,45 @@ static const MemoryListener vhost_vdpa_memory_lis=
tener =3D {
> >      .region_del =3D vhost_vdpa_listener_region_del,
> >  };
> >
> > -static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int re=
quest,
> > -                             void *arg)
> > +static int vhost_vdpa_dev_fd(const struct vhost_dev *dev)
> >  {
> >      struct vhost_vdpa *v =3D dev->opaque;
> > -    int fd =3D v->device_fd;
> > -    int ret;
> >
> >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
> > +    return v->device_fd;
> > +}
>
> Nit: unless the vhost_dev structure is opaque to the upper layer, I
> don't see any advantage for having a dedicated indirect helper to get
> device_fd.
>

The purpose was to not duplicate the assert, but sure it's not mandatory.

> > +
> > +static int vhost_vdpa_call_fd(int fd, unsigned long int request, void =
*arg)
> > +{
> > +    int ret =3D ioctl(fd, request, arg);
> >
> > -    ret =3D ioctl(fd, request, arg);
> >      return ret < 0 ? -errno : ret;
> >  }
> >
> > -static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status=
)
> > +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int re=
quest,
> > +                           void *arg)
> > +{
> > +    return vhost_vdpa_call_fd(vhost_vdpa_dev_fd(dev), request, arg);
> > +}
> > +
> > +static int vhost_vdpa_add_status_fd(int fd, uint8_t status)
> >  {
> >      uint8_t s;
> >      int ret;
> >
> > -    trace_vhost_vdpa_add_status(dev, status);
> > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> >      if (ret < 0) {
> >          return ret;
> >      }
> >
> >      s |=3D status;
> >
> > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &s);
> >      if (ret < 0) {
> >          return ret;
> >      }
> >
> > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> >      if (ret < 0) {
> >          return ret;
> >      }
> > @@ -378,6 +385,12 @@ static int vhost_vdpa_add_status(struct vhost_dev =
*dev, uint8_t status)
> >      return 0;
> >  }
> >
> > +static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status=
)
> > +{
> > +    trace_vhost_vdpa_add_status(dev, status);
> > +    return vhost_vdpa_add_status_fd(vhost_vdpa_dev_fd(dev), status);
> > +}
> > +
> >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *io=
va_range)
> >  {
> >      int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range);
> > @@ -709,16 +722,20 @@ static int vhost_vdpa_get_device_id(struct vhost_=
dev *dev,
> >      return ret;
> >  }
> >
> > +static int vhost_vdpa_reset_device_fd(int fd)
> > +{
> > +    uint8_t status =3D 0;
> > +
> > +    return vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &status);
> > +}
> > +
> >  static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> >  {
> >      struct vhost_vdpa *v =3D dev->opaque;
> > -    int ret;
> > -    uint8_t status =3D 0;
> >
> > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> > -    trace_vhost_vdpa_reset_device(dev);
> >      v->suspended =3D false;
> > -    return ret;
> > +    trace_vhost_vdpa_reset_device(dev);
> > +    return vhost_vdpa_reset_device_fd(vhost_vdpa_dev_fd(dev));
> >  }
> >
> >  static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> > @@ -1170,6 +1187,13 @@ static int vhost_vdpa_dev_start(struct vhost_dev=
 *dev, bool started)
> >      return 0;
> >  }
> >
> > +void vhost_vdpa_reset_status_fd(int fd)
> > +{
> > +    vhost_vdpa_reset_device_fd(fd);
> > +    vhost_vdpa_add_status_fd(fd, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > +                                 VIRTIO_CONFIG_S_DRIVER);
>
> I would like to rename this function since it does more than just reset.
>

vhost_vdpa_set_ready?

Thanks!

> Thanks
>
> > +}
> > +
> >  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
> >  {
> >      struct vhost_vdpa *v =3D dev->opaque;
> > @@ -1178,9 +1202,7 @@ static void vhost_vdpa_reset_status(struct vhost_=
dev *dev)
> >          return;
> >      }
> >
> > -    vhost_vdpa_reset_device(dev);
> > -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > -                               VIRTIO_CONFIG_S_DRIVER);
> > +    vhost_vdpa_reset_status_fd(vhost_vdpa_dev_fd(dev));
> >      memory_listener_unregister(&v->listener);
> >  }
> >
> > --
> > 2.31.1
> >
>


