Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFD711EAD
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 06:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2On0-0003Q8-9S; Fri, 26 May 2023 00:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2Omy-0003Q0-U2
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q2Omw-0000MP-Vf
 for qemu-devel@nongnu.org; Fri, 26 May 2023 00:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685074250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oww1rjUlyYBymHMh7LHhXePu3gtp5QBf+1mrFW7TEFU=;
 b=BMBBKJhSMa97r3rq9Nl/fbK5ererKDcGdKpXvP/Guz/A+Mjn1aTKtmd3TzyNwFPyydGhb4
 4ZCTFOlW+BmK4G4cd2gLNrvPCJFOmXfhjIgLczYbVPePCUlTvu20ccTjJLaPYh1V8bgJtU
 er/mq69mmoV1fmh0lPIi4twuXvIKAD8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-FyRq0C-SMgqHXNS0tSJLhg-1; Fri, 26 May 2023 00:10:47 -0400
X-MC-Unique: FyRq0C-SMgqHXNS0tSJLhg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af25b667d5so1228321fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 21:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685074246; x=1687666246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oww1rjUlyYBymHMh7LHhXePu3gtp5QBf+1mrFW7TEFU=;
 b=SD0frGAWL/BZdGK2c3EeqyCe4FaApxv1B27p3zvPgpCKz18EvihZ9OADT1eUfwH5cf
 LAnjwR1BhAHTwaMeAtX8RXw+vISfvjHX5o++nv9kFnFXioAX0cpf3BwJXPS63z0GQruM
 WLmcmAUN6/883cOhkHWYC7e8tl1gkhesAQ4DZJ/R6CEYNsQOs9C9BYbsF67g6fONxOU3
 DZZXD66mIe/mojcVHpZ1rW9aRUW1pbUR+i91v+b0UZX59k4ZwUIttE5VP4gemrhgkSOR
 IrikWji5ZyMSZEwefgffeahC3Ms79QkBT8e904r4bHfasqGBWrnKlD61qYFuvdMm3S7a
 LE2w==
X-Gm-Message-State: AC+VfDx2pEIKKg69twpquJAhCuG9mWRAYyMZG9PbSYX6aeJTcPgHEpkB
 igpEXkmWV54OQ8Gx1+VTe26ZgG/FqmZSpJuZHSWgJMDL3Zvl54UBrWjfcyrfX8eMbAqQ8aJ335m
 0HuV3iEDW6q6dCrhWsoPbALX04GKkDsk=
X-Received: by 2002:a2e:9510:0:b0:2af:2626:9f23 with SMTP id
 f16-20020a2e9510000000b002af26269f23mr233011ljh.12.1685074246434; 
 Thu, 25 May 2023 21:10:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CM6zH8yiQkDe6hj+Q9RyfHF1KMrCypztmt0YPwwGU1wSeuuHcKhFh04tWnbR8aUdSHrMjLsaJB0Q6KSIPbTM=
X-Received: by 2002:a2e:9510:0:b0:2af:2626:9f23 with SMTP id
 f16-20020a2e9510000000b002af26269f23mr232995ljh.12.1685074246106; Thu, 25 May
 2023 21:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-3-eperezma@redhat.com>
 <CACGkMEufH7ZvJxKzbSXpv8G5RodKeh_WHj6iTe=YqG9pdp45nQ@mail.gmail.com>
 <CAJaqyWebY4Ft9cTO8FpWeGiYRik60530HYONTgKy7RtZTDJ6-A@mail.gmail.com>
 <CACGkMEsC0dO-cO0o+-6nhqb=yLJTK6cB7um_JxvpGsAS1EBZUw@mail.gmail.com>
 <CAJaqyWeiRakgCJAn4cxEWBoz_jz7-A46C3bsvYMfUEBL47bpAg@mail.gmail.com>
In-Reply-To: <CAJaqyWeiRakgCJAn4cxEWBoz_jz7-A46C3bsvYMfUEBL47bpAg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 12:10:35 +0800
Message-ID: <CACGkMEuTf1ojSqjSpXNEFmy23YfeD_Ov1UqDg8omZmq5J=Ymig@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Thu, May 25, 2023 at 1:37=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, May 17, 2023 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, May 17, 2023 at 1:46=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, May 17, 2023 at 5:14=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Tue, May 9, 2023 at 11:44=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > This allows to reset a vhost-vdpa device from external subsystems=
 like
> > > > > vhost-net, since it does not have any struct vhost_dev by the tim=
e we
> > > > > need to use it.
> > > > >
> > > > > It is used in subsequent patches to negotiate features
> > > > > and probe for CVQ ASID isolation.
> > > > >
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  include/hw/virtio/vhost-vdpa.h |  1 +
> > > > >  hw/virtio/vhost-vdpa.c         | 58 +++++++++++++++++++++++-----=
------
> > > > >  2 files changed, 41 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/v=
host-vdpa.h
> > > > > index c278a2a8de..28de7da91e 100644
> > > > > --- a/include/hw/virtio/vhost-vdpa.h
> > > > > +++ b/include/hw/virtio/vhost-vdpa.h
> > > > > @@ -54,6 +54,7 @@ typedef struct vhost_vdpa {
> > > > >      VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
> > > > >  } VhostVDPA;
> > > > >
> > > > > +void vhost_vdpa_reset_status_fd(int fd);
> > > > >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_ran=
ge *iova_range);
> > > > >
> > > > >  int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwad=
dr iova,
> > > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > > > index bbabea18f3..7a2053b8d9 100644
> > > > > --- a/hw/virtio/vhost-vdpa.c
> > > > > +++ b/hw/virtio/vhost-vdpa.c
> > > > > @@ -335,38 +335,45 @@ static const MemoryListener vhost_vdpa_memo=
ry_listener =3D {
> > > > >      .region_del =3D vhost_vdpa_listener_region_del,
> > > > >  };
> > > > >
> > > > > -static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long =
int request,
> > > > > -                             void *arg)
> > > > > +static int vhost_vdpa_dev_fd(const struct vhost_dev *dev)
> > > > >  {
> > > > >      struct vhost_vdpa *v =3D dev->opaque;
> > > > > -    int fd =3D v->device_fd;
> > > > > -    int ret;
> > > > >
> > > > >      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYP=
E_VDPA);
> > > > > +    return v->device_fd;
> > > > > +}
> > > >
> > > > Nit: unless the vhost_dev structure is opaque to the upper layer, I
> > > > don't see any advantage for having a dedicated indirect helper to g=
et
> > > > device_fd.
> > > >
> > >
> > > The purpose was to not duplicate the assert, but sure it's not mandat=
ory.
> >
> > Ok, but I think for new codes, we'd better avoid assert as much as poss=
ible.
> >
>
> I'll remove it, thanks!
>
> > >
> > > > > +
> > > > > +static int vhost_vdpa_call_fd(int fd, unsigned long int request,=
 void *arg)
> > > > > +{
> > > > > +    int ret =3D ioctl(fd, request, arg);
> > > > >
> > > > > -    ret =3D ioctl(fd, request, arg);
> > > > >      return ret < 0 ? -errno : ret;
> > > > >  }
> > > > >
> > > > > -static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t =
status)
> > > > > +static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long =
int request,
> > > > > +                           void *arg)
> > > > > +{
> > > > > +    return vhost_vdpa_call_fd(vhost_vdpa_dev_fd(dev), request, a=
rg);
> > > > > +}
> > > > > +
> > > > > +static int vhost_vdpa_add_status_fd(int fd, uint8_t status)
> > > > >  {
> > > > >      uint8_t s;
> > > > >      int ret;
> > > > >
> > > > > -    trace_vhost_vdpa_add_status(dev, status);
> > > > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > > > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> > > > >      if (ret < 0) {
> > > > >          return ret;
> > > > >      }
> > > > >
> > > > >      s |=3D status;
> > > > >
> > > > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
> > > > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &s);
> > > > >      if (ret < 0) {
> > > > >          return ret;
> > > > >      }
> > > > >
> > > > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s);
> > > > > +    ret =3D vhost_vdpa_call_fd(fd, VHOST_VDPA_GET_STATUS, &s);
> > > > >      if (ret < 0) {
> > > > >          return ret;
> > > > >      }
> > > > > @@ -378,6 +385,12 @@ static int vhost_vdpa_add_status(struct vhos=
t_dev *dev, uint8_t status)
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t =
status)
> > > > > +{
> > > > > +    trace_vhost_vdpa_add_status(dev, status);
> > > > > +    return vhost_vdpa_add_status_fd(vhost_vdpa_dev_fd(dev), stat=
us);
> > > > > +}
> > > > > +
> > > > >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_ran=
ge *iova_range)
> > > > >  {
> > > > >      int ret =3D ioctl(fd, VHOST_VDPA_GET_IOVA_RANGE, iova_range)=
;
> > > > > @@ -709,16 +722,20 @@ static int vhost_vdpa_get_device_id(struct =
vhost_dev *dev,
> > > > >      return ret;
> > > > >  }
> > > > >
> > > > > +static int vhost_vdpa_reset_device_fd(int fd)
> > > > > +{
> > > > > +    uint8_t status =3D 0;
> > > > > +
> > > > > +    return vhost_vdpa_call_fd(fd, VHOST_VDPA_SET_STATUS, &status=
);
> > > > > +}
> > > > > +
> > > > >  static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> > > > >  {
> > > > >      struct vhost_vdpa *v =3D dev->opaque;
> > > > > -    int ret;
> > > > > -    uint8_t status =3D 0;
> > > > >
> > > > > -    ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status)=
;
> > > > > -    trace_vhost_vdpa_reset_device(dev);
> > > > >      v->suspended =3D false;
> > > > > -    return ret;
> > > > > +    trace_vhost_vdpa_reset_device(dev);
> > > > > +    return vhost_vdpa_reset_device_fd(vhost_vdpa_dev_fd(dev));
> > > > >  }
> > > > >
> > > > >  static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int id=
x)
> > > > > @@ -1170,6 +1187,13 @@ static int vhost_vdpa_dev_start(struct vho=
st_dev *dev, bool started)
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +void vhost_vdpa_reset_status_fd(int fd)
> > > > > +{
> > > > > +    vhost_vdpa_reset_device_fd(fd);
> > > > > +    vhost_vdpa_add_status_fd(fd, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > > > +                                 VIRTIO_CONFIG_S_DRIVER);
> > > >
> > > > I would like to rename this function since it does more than just r=
eset.
> > > >
> > >
> > > vhost_vdpa_set_ready?
> >
> > But it doesn't set DRIVER_OK so it might be somehow misleading.
> >
>
> I'm still thinking about this. I don't like the original name either
> (vhost_vdpa_reset_status), but that one was already in the code before
> this patch. To rename it makes this patch scope bigger.
>
> The main idea of this function is to stop duplicating code between
> net/vhost-vdpa and hw/virtio/vdpa. One possibility is to not export
> vhost_vdpa_reset_status_fd but export vhost_vdpa_reset_device_fd and
> vhost_vdpa_add_status_fd individually. Does that seem better?

Probably not, the reason is that at uAPI level, we don't differ reset
from other status actually:

#define VHOST_VDPA_SET_STATUS           _IOW(VHOST_VIRTIO, 0x72, __u8)

>
> The other end is not to offer anything and call raw ioctl as previous
> code of net/vhost-vdpa. There is a middle ground, like only exporting
> one of them for sure.

This might be better.

Thanks

>
> What do you think?
>
> Thanks!
>
> > Thanks
> >
> > >
> > > Thanks!
> > >
> > > > Thanks
> > > >
> > > > > +}
> > > > > +
> > > > >  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
> > > > >  {
> > > > >      struct vhost_vdpa *v =3D dev->opaque;
> > > > > @@ -1178,9 +1202,7 @@ static void vhost_vdpa_reset_status(struct =
vhost_dev *dev)
> > > > >          return;
> > > > >      }
> > > > >
> > > > > -    vhost_vdpa_reset_device(dev);
> > > > > -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> > > > > -                               VIRTIO_CONFIG_S_DRIVER);
> > > > > +    vhost_vdpa_reset_status_fd(vhost_vdpa_dev_fd(dev));
> > > > >      memory_listener_unregister(&v->listener);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> > > >
> > >
> >
>


