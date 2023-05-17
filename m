Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BD7705F96
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 07:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzA2k-00065O-1K; Wed, 17 May 2023 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzA2Z-000652-NR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzA2Y-0001AN-1d
 for qemu-devel@nongnu.org; Wed, 17 May 2023 01:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684302573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kML5OVoqN7RVVhs2YAmsKZ4TRZSdGMFB70lTjZk+cC0=;
 b=e5cgUiL4qsQmv3yDfKITOdc6X8PQXdBezb50HmdSh4Smap+HYShGa+VcR/gR8Fjl5xGB6o
 Vev2xPwsq56DfajRDmJPVLXn2g1ANsU7FTSdLtONNq5gYFNbSBl/4I4Q2pJ4nsaHgG62zv
 X93qHxhFQ9xi/nGWXAeuWmUTATRfywg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-1jB4y4D_MIuQAECqGO_GMg-1; Wed, 17 May 2023 01:49:31 -0400
X-MC-Unique: 1jB4y4D_MIuQAECqGO_GMg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4edd54a0eaeso300171e87.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 22:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684302570; x=1686894570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kML5OVoqN7RVVhs2YAmsKZ4TRZSdGMFB70lTjZk+cC0=;
 b=b3GjeVMAmCnysOFXw68MJ04HQ9tdoY2S5F2NJwkUmu9D7D9k3xnfLE2Ap8kjWDs8Ac
 Zgfol4UZ0GSI61dhuxDRH5HH2JXUZWPKxW1I+aH0WPdvm4KDVK1svYgtYGX5JKfa2tOW
 hqGFrvUJeawNG0TpLW+mYsuMOqsaR/WWwt3cFI5+9zjrkxnhZ7pFTUgf+TAR8tkvPzek
 xMqY0xYQdBEuGqqN2rwc/541eECGF3ckAySDgyuESJUI3KTkRUUS1YOq+X+nO8Ut8L7u
 j4IbYZ/3JAKDyu7hQUtcDJM4oJ8xvnGBE3gASgm10I5nxHaQYXiSQ23W351n57REFEhj
 WvZA==
X-Gm-Message-State: AC+VfDxqyyfi6be+R4OcgMOZKrrwqWP/cLLvGIOp/P6orOcBOHBNh0fE
 Dn5cCRQT0nKtuEW8E26hL9r0fHUBp3D1lX9MFr+1ZYypKc5dOLLwUinFaU3RgBdQRGHrFpK2Gu4
 zobpKM4orDoiSKzv7af9L4/UTCrJbDBM=
X-Received: by 2002:ac2:5d2d:0:b0:4e9:bf83:11a4 with SMTP id
 i13-20020ac25d2d000000b004e9bf8311a4mr7549289lfb.7.1684302570438; 
 Tue, 16 May 2023 22:49:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4F3v/2IkbC6sWssBJntJSDCjUCA8T+i23Ifwz6ecqMsqAJgnaVOJsfEKiBuwqaZIeZDjsUE6xZgcwOWqaaKNM=
X-Received: by 2002:ac2:5d2d:0:b0:4e9:bf83:11a4 with SMTP id
 i13-20020ac25d2d000000b004e9bf8311a4mr7549275lfb.7.1684302570093; Tue, 16 May
 2023 22:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-3-eperezma@redhat.com>
 <CACGkMEufH7ZvJxKzbSXpv8G5RodKeh_WHj6iTe=YqG9pdp45nQ@mail.gmail.com>
 <CAJaqyWebY4Ft9cTO8FpWeGiYRik60530HYONTgKy7RtZTDJ6-A@mail.gmail.com>
In-Reply-To: <CAJaqyWebY4Ft9cTO8FpWeGiYRik60530HYONTgKy7RtZTDJ6-A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 May 2023 13:49:19 +0800
Message-ID: <CACGkMEsC0dO-cO0o+-6nhqb=yLJTK6cB7um_JxvpGsAS1EBZUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] vdpa: add vhost_vdpa_reset_status_fd
To: Eugenio Perez Martin <eperezma@redhat.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 17, 2023 at 1:46=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, May 17, 2023 at 5:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > This allows to reset a vhost-vdpa device from external subsystems lik=
e
> > > vhost-net, since it does not have any struct vhost_dev by the time we
> > > need to use it.
> > >
> > > It is used in subsequent patches to negotiate features
> > > and probe for CVQ ASID isolation.
> > >
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  include/hw/virtio/vhost-vdpa.h |  1 +
> > >  hw/virtio/vhost-vdpa.c         | 58 +++++++++++++++++++++++---------=
--
> > >  2 files changed, 41 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost=
-vdpa.h
> > > index c278a2a8de..28de7da91e 100644
> > > --- a/include/hw/virtio/vhost-vdpa.h
> > > +++ b/include/hw/virtio/vhost-vdpa.h
> > > @@ -54,6 +54,7 @@ typedef struct vhost_vdpa {
> > >      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > >  } VhostVDPA;
> > >
> > > +void vhost_vdpa_reset_status_fd(int fd);
> > >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *=
iova_range);
> > >
> > >  int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr i=
ova,
> > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > index bbabea18f3..7a2053b8d9 100644
> > > --- a/hw/virtio/vhost-vdpa.c
> > > +++ b/hw/virtio/vhost-vdpa.c
> > > @@ -335,38 +335,45 @@ static const MemoryListener vhost_vdpa_memory_l=
istener =3D {
> > >      .region_del =3D vhost_vdpa_listener_region_del,
> > >  };
> > >
> > > -static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int =
request,
> > > -                             void *arg)
> > > +static int vhost_vdpa_dev_fd(const struct vhost_dev *dev)
> > >  {
> > >      struct vhost_vdpa *v =3D dev->opaque;
> > > -    int fd =3D v->device_fd;
> > > -    int ret;
> > >
> > >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VD=
PA);
> > > +    return v->device_fd;
> > > +}
> >
> > Nit: unless the vhost_dev structure is opaque to the upper layer, I
> > don't see any advantage for having a dedicated indirect helper to get
> > device_fd.
> >
>
> The purpose was to not duplicate the assert, but sure it's not mandatory.

Ok, but I think for new codes, we'd better avoid assert as much as possible=
.

>
> > > +
> > > +static int vhost_vdpa_call_fd(int fd, unsigned long int request, voi=
d *arg)
> > > +{
> > > +    int ret =3D ioctl(fd, request, arg);
> > >
> > > -    ret =3D ioctl(fd, request, arg);
> > >      return ret < 0 ? -errno : ret;
> > >  }
> > >
> > > -static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t stat=
us)
> > > +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int =
request,
> > > +                           void *arg)
> > > +{
> > > +    return vhost_vdpa_call_fd(vhost_vdpa_dev_fd(dev), request, arg);
> > > +}
> > > +
> > > +static int vhost_vdpa_add_status_fd(int fd, uint8_t status)
> > >  {
> > >      uint8_t s;
> > >      int ret;
> > >
> > > -    trace_vhost_vdpa_add_status(dev, status);
> > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> > >      if (ret < 0) {
> > >          return ret;
> > >      }
> > >
> > >      s |=3D status;
> > >
> > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &s);
> > >      if (ret < 0) {
> > >          return ret;
> > >      }
> > >
> > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> > >      if (ret < 0) {
> > >          return ret;
> > >      }
> > > @@ -378,6 +385,12 @@ static int vhost_vdpa_add_status(struct vhost_de=
v *dev, uint8_t status)
> > >      return 0;
> > >  }
> > >
> > > +static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t stat=
us)
> > > +{
> > > +    trace_vhost_vdpa_add_status(dev, status);
> > > +    return vhost_vdpa_add_status_fd(vhost_vdpa_dev_fd(dev), status);
> > > +}
> > > +
> > >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *=
iova_range)
> > >  {
> > >      int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range);
> > > @@ -709,16 +722,20 @@ static int vhost_vdpa_get_device_id(struct vhos=
t_dev *dev,
> > >      return ret;
> > >  }
> > >
> > > +static int vhost_vdpa_reset_device_fd(int fd)
> > > +{
> > > +    uint8_t status =3D 0;
> > > +
> > > +    return vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &status);
> > > +}
> > > +
> > >  static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> > >  {
> > >      struct vhost_vdpa *v =3D dev->opaque;
> > > -    int ret;
> > > -    uint8_t status =3D 0;
> > >
> > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> > > -    trace_vhost_vdpa_reset_device(dev);
> > >      v->suspended =3D false;
> > > -    return ret;
> > > +    trace_vhost_vdpa_reset_device(dev);
> > > +    return vhost_vdpa_reset_device_fd(vhost_vdpa_dev_fd(dev));
> > >  }
> > >
> > >  static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> > > @@ -1170,6 +1187,13 @@ static int vhost_vdpa_dev_start(struct vhost_d=
ev *dev, bool started)
> > >      return 0;
> > >  }
> > >
> > > +void vhost_vdpa_reset_status_fd(int fd)
> > > +{
> > > +    vhost_vdpa_reset_device_fd(fd);
> > > +    vhost_vdpa_add_status_fd(fd, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > +                                 VIRTIO_CONFIG_S_DRIVER);
> >
> > I would like to rename this function since it does more than just reset=
.
> >
>
> vhost_vdpa_set_ready?

But it doesn't set DRIVER_OK so it might be somehow misleading.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > > +}
> > > +
> > >  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
> > >  {
> > >      struct vhost_vdpa *v =3D dev->opaque;
> > > @@ -1178,9 +1202,7 @@ static void vhost_vdpa_reset_status(struct vhos=
t_dev *dev)
> > >          return;
> > >      }
> > >
> > > -    vhost_vdpa_reset_device(dev);
> > > -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > -                               VIRTIO_CONFIG_S_DRIVER);
> > > +    vhost_vdpa_reset_status_fd(vhost_vdpa_dev_fd(dev));
> > >      memory_listener_unregister(&v->listener);
> > >  }
> > >
> > > --
> > > 2.31.1
> > >
> >
>


