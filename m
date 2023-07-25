Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A07621CF
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONAV-0000hC-TD; Tue, 25 Jul 2023 14:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qONAR-0000gw-SF
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qONAP-0003O7-SP
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690311230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXTN6T3UGRnFKduFee1IyBG5e/0iq0YT5TnBYOAys1I=;
 b=ce8Xt74mDUZCXyssj3m4MGqFq1avmx1NYqihM36InSHSaZcEc4BJw6dfqsJGdVZna+0qNY
 yEvjeeamOPSCY8mA1jOqRDJzCuMt6LgmT0XUtmvrR/+/CfBHq1lJXAChvEiTvw8knjzAAa
 dWK/o2RDwHHNFCkuB7hrLsIpgc/2ETw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-AYMoi24vOpmhX4zDdXqLkw-1; Tue, 25 Jul 2023 14:53:47 -0400
X-MC-Unique: AYMoi24vOpmhX4zDdXqLkw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5843fed1e88so3677707b3.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690311226; x=1690916026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXTN6T3UGRnFKduFee1IyBG5e/0iq0YT5TnBYOAys1I=;
 b=GdiqiaiaGQ/F5b8lkD2QLOxVNmd6DurvfyGTnMCciIr+h6NLCbW8F9DEIisyGRjnrn
 DUdCkuyaJdYvZIuvvTuCYCocXryn5OuO3wQVs5dMEf5koTsxdFEXWmUTVkejPqnBhrLU
 M0XuaUQ3cP/O5WYOGwsYBjm6LKqDqwxz56t3XaSV14BAUhO4lgc6J11dZ0QI7o7xZUZy
 Fyk7EVAHCCMLfs2HnKvhY7FFu/svV/af1qrZZrvL/e/0nYm+5jJhIpKEPXsjBL+nynmD
 It8hz//cMpICDrFDbL6tTP8yUQ1mI5UZ6RwA2G8Mq5JrOPdG0xX84hkbwhpRBo8+PtWK
 AhAw==
X-Gm-Message-State: ABy/qLYQG+GFVjl/JWEc7rWixlZXzVHJZeo6lN73gQcyX92hwsT8T1Xp
 CKaXZGmH/tWwbbMGuoUPxidILTFtdwNEOZq0VLBLzw7ykXX6zx8+qZXFZjuWZVN+oxwyxOeDKEu
 IB2JdLpXK+i63wKcVX5GYFjPV/z35Vkk=
X-Received: by 2002:a81:d549:0:b0:579:e999:2b23 with SMTP id
 l9-20020a81d549000000b00579e9992b23mr53094ywj.12.1690311226504; 
 Tue, 25 Jul 2023 11:53:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeytqSdL7McW2zpzkX8Vop5T8usQWullKELjAQ3dUxlzF+5WH/i/Jbxe+etXMXVejiw9JpQeifQdUZePRo9CI=
X-Received: by 2002:a81:d549:0:b0:579:e999:2b23 with SMTP id
 l9-20020a81d549000000b00579e9992b23mr53075ywj.12.1690311226157; Tue, 25 Jul
 2023 11:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
 <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
 <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
 <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
 <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
In-Reply-To: <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 25 Jul 2023 20:53:09 +0200
Message-ID: <CAJaqyWd-bdA5CgdEvMoiAOWGUzUZV+Urvd4WW7+BFqSbhC0FqQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 25, 2023 at 3:09=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 25.07.23 12:03, Eugenio Perez Martin wrote:
> > On Tue, Jul 25, 2023 at 9:53=E2=80=AFAM Hanna Czenczek <hreitz@redhat.c=
om> wrote:
> >> On 24.07.23 17:48, Eugenio Perez Martin wrote:
> >>> On Fri, Jul 21, 2023 at 6:07=E2=80=AFPM Hanna Czenczek <hreitz@redhat=
.com> wrote:
> >>>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
> >>>>> On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@redh=
at.com> wrote:
> >>>>>> Move the `suspended` field from vhost_vdpa into the global vhost_d=
ev
> >>>>>> struct, so vhost_dev_stop() can check whether the back-end has bee=
n
> >>>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has=
,
> >>>>>> there is no need to reset it; the reset is just a fall-back to sto=
p
> >>>>>> device operations for back-ends that do not support suspend.
> >>>>>>
> >>>>>> Unfortunately, for vDPA specifically, RESUME is not yet implemente=
d, so
> >>>>>> when the device is re-started, we still have to do the reset to ha=
ve it
> >>>>>> un-suspend.
> >>>>>>
> >>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >>>>>> ---
> >>>>>>     include/hw/virtio/vhost-vdpa.h |  2 --
> >>>>>>     include/hw/virtio/vhost.h      |  8 ++++++++
> >>>>>>     hw/virtio/vhost-vdpa.c         | 11 +++++++----
> >>>>>>     hw/virtio/vhost.c              |  8 +++++++-
> >>>>>>     4 files changed, 22 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vh=
ost-vdpa.h
> >>>>>> index e64bfc7f98..72c3686b7f 100644
> >>>>>> --- a/include/hw/virtio/vhost-vdpa.h
> >>>>>> +++ b/include/hw/virtio/vhost-vdpa.h
> >>>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
> >>>>>>         bool shadow_vqs_enabled;
> >>>>>>         /* Vdpa must send shadow addresses as IOTLB key for data q=
ueues, not GPA */
> >>>>>>         bool shadow_data;
> >>>>>> -    /* Device suspended successfully */
> >>>>>> -    bool suspended;
> >>>>>>         /* IOVA mapping used by the Shadow Virtqueue */
> >>>>>>         VhostIOVATree *iova_tree;
> >>>>>>         GPtrArray *shadow_vqs;
> >>>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >>>>>> index 6a173cb9fa..69bf59d630 100644
> >>>>>> --- a/include/hw/virtio/vhost.h
> >>>>>> +++ b/include/hw/virtio/vhost.h
> >>>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
> >>>>>>         uint64_t backend_cap;
> >>>>>>         /* @started: is the vhost device started? */
> >>>>>>         bool started;
> >>>>>> +    /**
> >>>>>> +     * @suspended: Whether the vhost device is currently suspende=
d.  Set
> >>>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...)=
, which
> >>>>>> +     * are supposed to automatically suspend/resume in their
> >>>>>> +     * vhost_dev_start handlers as required.  Must also be cleare=
d when
> >>>>>> +     * the device is reset.
> >>>>>> +     */
> >>>>>> +    bool suspended;
> >>>>>>         bool log_enabled;
> >>>>>>         uint64_t log_size;
> >>>>>>         Error *migration_blocker;
> >>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>>>> index 7b7dee468e..f7fd19a203 100644
> >>>>>> --- a/hw/virtio/vhost-vdpa.c
> >>>>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct v=
host_dev *dev,
> >>>>>>
> >>>>>>     static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> >>>>>>     {
> >>>>>> -    struct vhost_vdpa *v =3D dev->opaque;
> >>>>>>         int ret;
> >>>>>>         uint8_t status =3D 0;
> >>>>>>
> >>>>>>         ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &statu=
s);
> >>>>>>         trace_vhost_vdpa_reset_device(dev);
> >>>>>> -    v->suspended =3D false;
> >>>>>> +    dev->suspended =3D false;
> >>>>>>         return ret;
> >>>>>>     }
> >>>>>>
> >>>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_=
dev *dev)
> >>>>>>             if (unlikely(r)) {
> >>>>>>                 error_report("Cannot suspend: %s(%d)", g_strerror(=
errno), errno);
> >>>>>>             } else {
> >>>>>> -            v->suspended =3D true;
> >>>>>> +            dev->suspended =3D true;
> >>>>>>                 return;
> >>>>>>             }
> >>>>>>         }
> >>>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhos=
t_dev *dev, bool started)
> >>>>>>                 return -1;
> >>>>>>             }
> >>>>>>             vhost_vdpa_set_vring_ready(dev);
> >>>>>> +        if (dev->suspended) {
> >>>>>> +            /* TODO: When RESUME is available, use it instead of =
resetting */
> >>>>>> +            vhost_vdpa_reset_status(dev);
> >>>>> How is that we reset the status at each vhost_vdpa_dev_start? That
> >>>>> will clean all the vqs configured, features negotiated, etc. in the
> >>>>> vDPA device. Or am I missing something?
> >>>> What alternative do you propose?  We don=E2=80=99t have RESUME for v=
DPA in qemu,
> >>>> but we somehow need to lift the previous SUSPEND so the device will
> >>>> again respond to guest requests, do we not?
> >>>>
> >>> Reset also clears the suspend state in vDPA, and it should be called
> >>> at vhost_dev_stop. So the device should never be in suspended state
> >>> here. Does that solve your concerns?
> >> My intention with this patch was precisely not to reset in
> >> vhost_dev_stop when suspending is supported.  So now I=E2=80=99m more =
confused
> >> than before.
> >>
> > At this moment, I think that should be focused as an optimization and
> > not to be included in the main series.
>
> It is absolutely not an optimization but vital for my use case.
> virtiofsd does not currently implement resetting, but if it did (and we
> want this support in the future), resetting it during stop/cont would be
> catastrophic.  There must be a way to have qemu not issue a reset.  This
> patch is the reason why this series exists.
>

Sorry, I see I confused things with the first reply. Let me do a recap.

If I understand the problem correctly, your use case requires that
qemu does not reset the device before the device state is fetched with
virtio_save in the case of a migration. This is understandable and I
think we have a solution for that: to move the vhost_ops call to
virtio_reset and the end of virtio_save. To remove the reset call from
vhost_dev_stop is somehow mandatory, as it is called before
virtio_save.

But we cannot move to vhost_vdpa_dev_start, as proposed here. The reasons a=
re:
* All the features, vq parameters, etc are set before any
vhost_vdpa_dev_start call. To reset at any vhost_vdpa_dev_start would
wipe them.
* The device needs to hold all the resources until it is reset. Things
like descriptor status etc.

And, regarding the comment "When RESUME is available, use it instead
of resetting", we cannot use resume to replace reset in all cases.
This is because the semantics are different.

For example, vhost_dev_stop and vhost_dev_start are also called when
the guest reset by itself the device. You can check it rmmoding and
modprobing virtio-net driver, for example. In this case, the driver
expects to find all vqs to start with 0, but the resume must not reset
these indexes.

It can be applied as an optimizations sometimes, but not for the general ca=
se.

> >>>> But more generally, is this any different from what is done before t=
his
> >>>> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
> >>>> vhost_reset_status(), so the device is reset in every stop/start cyc=
le,
> >>>> that doesn=E2=80=99t change.  And we still won=E2=80=99t reset it on=
 the first
> >>>> vhost_dev_start(), because dev->suspended will be false then, only o=
n
> >>>> subsequent stop/start cycles, as before.  So the only difference is =
that
> >>>> now the device is reset on start, not on stop.
> >>>>
> >>> The difference is that vhost_vdpa_dev_start is called after features
> >>> ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
> >>> configuration (using vhost_virtqueue_start). A device reset forces th=
e
> >>> device to forget about all of that, and qemu cannot configure them
> >>> again until qemu acks the features again.
> >> Now I=E2=80=99m completely confused, because I don=E2=80=99t see the p=
oint of
> >> implementing suspend at all if we rely on a reset immediately afterwar=
ds
> >> anyway.
> > It's not immediate. From vhost_dev_stop, comments added only in this ma=
il:
> >
> > void vhost_virtqueue_stop(struct vhost_dev *dev,
> >                            struct VirtIODevice *vdev,
> >                            struct vhost_virtqueue *vq,
> >                            unsigned idx)
> > {
> >      ...
> >      // Get each vring indexes, trusting the destination device can
> > continue safely from there
> >      r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> >      if (r < 0) {
> >          VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx,=
 r);
> >          /* Connection to the backend is broken, so let's sync internal
> >           * last avail idx to the device used idx.
> >           */
> >          virtio_queue_restore_last_avail_idx(vdev, idx);
> >      } else {
> >          virtio_queue_set_last_avail_idx(vdev, idx, state.num);
> >      }
> >      ...
> > }
> >
> > void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vr=
ings)
> > {
> >      ...
> >      // Suspend the device, so we can trust in vring indexes / vq state
>
> I don=E2=80=99t understand this purpose.  GET_VRING_BASE stops the vring =
in
> question, so the vring index returned must be trustworthy, no?
>

That only happens in vhost-user, not in vhost-vdpa.

> >      if (hdev->vhost_ops->vhost_dev_start) {
> >          hdev->vhost_ops->vhost_dev_start(hdev, false);
> >      }
> >      if (vrings) {
> >          vhost_dev_set_vring_enable(hdev, false);
> >      }
> >
> >      // Fetch each vq index / state and store in vdev->vq[i]
> >      for (i =3D 0; i < hdev->nvqs; ++i) {
> >          vhost_virtqueue_stop(hdev,
> >                               vdev,
> >                               hdev->vqs + i,
> >                               hdev->vq_index + i);
> >      }
> >
> >      // Reset the device, as we don't need it anymore and it can
> > release the resources
> >      if (hdev->vhost_ops->vhost_reset_status) {
> >          hdev->vhost_ops->vhost_reset_status(hdev);
> >      }
> > }
> > ---
> >
> >>   It was my impression this whole time that suspending would
> >> remove the need to reset.  Well, at least until the device should be
> >> resumed again, i.e. in vhost_dev_start().
> >>
> > It cannot. vhost_dev_stop is also called when the guest reset the
> > device, so the guest trusts the device to be in a clean state.
> >
> > Also, the reset is the moment when the device frees the unused
> > resources. This would mandate the device to
>
> What resources are we talking about?  This function is called when the
> VM is paused (stop).  If a stateful device is reset to free =E2=80=9Cunus=
ed
> resources=E2=80=9D, this means dropping its internal state, which is abso=
lutely
> wrong in a stop/cont cycle.
>

But is the expected result in the virtio reset cycle. We need to split
these paths.

> >> In addition, I also don=E2=80=99t understand the magnitude of the prob=
lem with
> >> ordering.  If the order in vhost_dev_start() is wrong, can we not easi=
ly
> >> fix it?
> > The order in vhost_dev_start follows the VirtIO standard.
>
> What does the VirtIO standard say about suspended vhost back-ends?
>

Suspend does not exist in the VirtIO standard. I meant the device
initialization order in "3.1 Device Initialization":

1. Reset the device.
...
5. Set the FEATURES_OK status bit. [...]
...
7. Perform device-specific setup, including discovery of virtqueues
for the device, optional per-bus setup, reading and possibly writing
the device=E2=80=99s virtio configuration space, and population of virtqueu=
es.
8.Set the DRIVER_OK status bit. At this point the device is =E2=80=9Clive=
=E2=80=9D.

Steps 4-8 are all done in vhost_dev_start, in that particular order.
To call vhost_vdpa_reset_status from vhost_vdpa_dev_start(true) would
reset the device back to step 1, but there is no more code to set all
configuration from 2-7 before 8 (DRIVER_OK).

> Hanna
>
> > The move of
> > the reset should be to remove it from vhost_dev_stop to something like
> > both virtio_reset and the end of virtio_save. I'm not sure if I'm
> > forgetting some other use cases.
> >
> >> E.g. add a full vhost_dev_resume callback to invoke right at
> >> the start of vhost_dev_start(); or check (in the same place) whether t=
he
> >> back-end supports resuming, and if it doesn=E2=80=99t (and it is curre=
ntly
> >> suspended), reset it there.
> >>
> >> In any case, if we need to reset in vhost_dev_stop(), i.e. immediately
> >> after suspend, I don=E2=80=99t see the point of suspending, indicating=
 to me
> >> that I still fail to understand its purpose.
> >>
> >> Hanna
> >>
>


