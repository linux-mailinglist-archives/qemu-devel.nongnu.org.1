Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C677654ED
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0RF-00065U-JT; Thu, 27 Jul 2023 08:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP0RD-00065C-4R
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qP0R9-0008SO-5T
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690462185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNuNljzvEuuhUIak/34sueZvPDLo9V9NYzjF2ywazE4=;
 b=aIQym4Zwf8tU6QQDLcyQCmJ/fxRi4Wnnp+vW9HIJoomFxeS/KLSM0EHJXjeS6yGYOr3RDL
 eUOdzxab00uiW6PtUR+8+tPGUkwNH20usDKmR7EL2Ac3FJcYd9Uxkh1d14j0zH4FFcEhTB
 XwrUaL2NMu/c6zbFtBf9olcn2FtpGr4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-N2CLoz23NCOwP_IjsbVLDQ-1; Thu, 27 Jul 2023 08:49:42 -0400
X-MC-Unique: N2CLoz23NCOwP_IjsbVLDQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-c8f360a07a2so835733276.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 05:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690462181; x=1691066981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNuNljzvEuuhUIak/34sueZvPDLo9V9NYzjF2ywazE4=;
 b=hBJCmgP4U79j5SjyYakZs0WgQpxYJ/Bls0P2AQ5Uj7IikEBKIzCWZ2HBDHysnW+Kuv
 S/cdzFIoOq0uaA1jEmDXlR7OlwUgBCZ7aHbxEgJzYwLxmDWppCRjgcW7JWf4yok8r6YD
 8fEcLuYtUdMLGV/pXz/0+Qb0nBn3It3Ww5jIyAx3N4Puuy5WRnP7/oLAc64ewdO0XCZg
 T75IqhdIAm7yZcrDeS9+wkfDeqh3N/VK94d7sFMspXW8BLHrScXbsBQxuYZqWMLnoF4v
 +meWiZaG9ClQ5AJrkwO9nifQTb3pYUyA413iikCFt+7xvujJt0oVD0p/IG8IoKte3rGw
 4Rvg==
X-Gm-Message-State: ABy/qLaLpC0L89wv94AV/kKWFZzLHvE7Vf5cgR8ijmOgs+wPiq34XUw4
 NJMi5y9QN2iZbPL6cqab+VWu5RFz9aRUSZe95LLSnv/tLismOmjO8ycgQvogj5xoxIH41LDMmYL
 lu6aPtAf7S3O62PNIzNOn7hbNgFE9a9g=
X-Received: by 2002:a25:8084:0:b0:d0a:8973:b1c with SMTP id
 n4-20020a258084000000b00d0a89730b1cmr4198874ybk.12.1690462181155; 
 Thu, 27 Jul 2023 05:49:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFHuo9FyfN716yZmY/hXNi8sbSMyvEO530W0CVNACoD4ZLWAjWe+riueU/20UsTVy/wscxoep4uGPfYp8fYpg=
X-Received: by 2002:a25:8084:0:b0:d0a:8973:b1c with SMTP id
 n4-20020a258084000000b00d0a89730b1cmr4198864ybk.12.1690462180724; Thu, 27 Jul
 2023 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
 <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
 <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
 <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
 <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
 <CAJaqyWd-bdA5CgdEvMoiAOWGUzUZV+Urvd4WW7+BFqSbhC0FqQ@mail.gmail.com>
 <bc1f4b18-8bf9-f8ac-fa47-babde355e340@redhat.com>
In-Reply-To: <bc1f4b18-8bf9-f8ac-fa47-babde355e340@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Jul 2023 14:49:04 +0200
Message-ID: <CAJaqyWcqGU7iBEuSgDWuWQY_D8GcavBbjnywnf+xqqS+SpAq9Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jul 26, 2023 at 8:57=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 25.07.23 20:53, Eugenio Perez Martin wrote:
> > On Tue, Jul 25, 2023 at 3:09=E2=80=AFPM Hanna Czenczek <hreitz@redhat.c=
om> wrote:
> >> On 25.07.23 12:03, Eugenio Perez Martin wrote:
> >>> On Tue, Jul 25, 2023 at 9:53=E2=80=AFAM Hanna Czenczek <hreitz@redhat=
.com> wrote:
> >>>> On 24.07.23 17:48, Eugenio Perez Martin wrote:
> >>>>> On Fri, Jul 21, 2023 at 6:07=E2=80=AFPM Hanna Czenczek <hreitz@redh=
at.com> wrote:
> >>>>>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
> >>>>>>> On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@re=
dhat.com> wrote:
> >>>>>>>> Move the `suspended` field from vhost_vdpa into the global vhost=
_dev
> >>>>>>>> struct, so vhost_dev_stop() can check whether the back-end has b=
een
> >>>>>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it h=
as,
> >>>>>>>> there is no need to reset it; the reset is just a fall-back to s=
top
> >>>>>>>> device operations for back-ends that do not support suspend.
> >>>>>>>>
> >>>>>>>> Unfortunately, for vDPA specifically, RESUME is not yet implemen=
ted, so
> >>>>>>>> when the device is re-started, we still have to do the reset to =
have it
> >>>>>>>> un-suspend.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >>>>>>>> ---
> >>>>>>>>      include/hw/virtio/vhost-vdpa.h |  2 --
> >>>>>>>>      include/hw/virtio/vhost.h      |  8 ++++++++
> >>>>>>>>      hw/virtio/vhost-vdpa.c         | 11 +++++++----
> >>>>>>>>      hw/virtio/vhost.c              |  8 +++++++-
> >>>>>>>>      4 files changed, 22 insertions(+), 7 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/=
vhost-vdpa.h
> >>>>>>>> index e64bfc7f98..72c3686b7f 100644
> >>>>>>>> --- a/include/hw/virtio/vhost-vdpa.h
> >>>>>>>> +++ b/include/hw/virtio/vhost-vdpa.h
> >>>>>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
> >>>>>>>>          bool shadow_vqs_enabled;
> >>>>>>>>          /* Vdpa must send shadow addresses as IOTLB key for dat=
a queues, not GPA */
> >>>>>>>>          bool shadow_data;
> >>>>>>>> -    /* Device suspended successfully */
> >>>>>>>> -    bool suspended;
> >>>>>>>>          /* IOVA mapping used by the Shadow Virtqueue */
> >>>>>>>>          VhostIOVATree *iova_tree;
> >>>>>>>>          GPtrArray *shadow_vqs;
> >>>>>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost=
.h
> >>>>>>>> index 6a173cb9fa..69bf59d630 100644
> >>>>>>>> --- a/include/hw/virtio/vhost.h
> >>>>>>>> +++ b/include/hw/virtio/vhost.h
> >>>>>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
> >>>>>>>>          uint64_t backend_cap;
> >>>>>>>>          /* @started: is the vhost device started? */
> >>>>>>>>          bool started;
> >>>>>>>> +    /**
> >>>>>>>> +     * @suspended: Whether the vhost device is currently suspen=
ded.  Set
> >>>>>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ..=
.), which
> >>>>>>>> +     * are supposed to automatically suspend/resume in their
> >>>>>>>> +     * vhost_dev_start handlers as required.  Must also be clea=
red when
> >>>>>>>> +     * the device is reset.
> >>>>>>>> +     */
> >>>>>>>> +    bool suspended;
> >>>>>>>>          bool log_enabled;
> >>>>>>>>          uint64_t log_size;
> >>>>>>>>          Error *migration_blocker;
> >>>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>>>>>> index 7b7dee468e..f7fd19a203 100644
> >>>>>>>> --- a/hw/virtio/vhost-vdpa.c
> >>>>>>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>>>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct=
 vhost_dev *dev,
> >>>>>>>>
> >>>>>>>>      static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> >>>>>>>>      {
> >>>>>>>> -    struct vhost_vdpa *v =3D dev->opaque;
> >>>>>>>>          int ret;
> >>>>>>>>          uint8_t status =3D 0;
> >>>>>>>>
> >>>>>>>>          ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &st=
atus);
> >>>>>>>>          trace_vhost_vdpa_reset_device(dev);
> >>>>>>>> -    v->suspended =3D false;
> >>>>>>>> +    dev->suspended =3D false;
> >>>>>>>>          return ret;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhos=
t_dev *dev)
> >>>>>>>>              if (unlikely(r)) {
> >>>>>>>>                  error_report("Cannot suspend: %s(%d)", g_strerr=
or(errno), errno);
> >>>>>>>>              } else {
> >>>>>>>> -            v->suspended =3D true;
> >>>>>>>> +            dev->suspended =3D true;
> >>>>>>>>                  return;
> >>>>>>>>              }
> >>>>>>>>          }
> >>>>>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vh=
ost_dev *dev, bool started)
> >>>>>>>>                  return -1;
> >>>>>>>>              }
> >>>>>>>>              vhost_vdpa_set_vring_ready(dev);
> >>>>>>>> +        if (dev->suspended) {
> >>>>>>>> +            /* TODO: When RESUME is available, use it instead o=
f resetting */
> >>>>>>>> +            vhost_vdpa_reset_status(dev);
> >>>>>>> How is that we reset the status at each vhost_vdpa_dev_start? Tha=
t
> >>>>>>> will clean all the vqs configured, features negotiated, etc. in t=
he
> >>>>>>> vDPA device. Or am I missing something?
> >>>>>> What alternative do you propose?  We don=E2=80=99t have RESUME for=
 vDPA in qemu,
> >>>>>> but we somehow need to lift the previous SUSPEND so the device wil=
l
> >>>>>> again respond to guest requests, do we not?
> >>>>>>
> >>>>> Reset also clears the suspend state in vDPA, and it should be calle=
d
> >>>>> at vhost_dev_stop. So the device should never be in suspended state
> >>>>> here. Does that solve your concerns?
> >>>> My intention with this patch was precisely not to reset in
> >>>> vhost_dev_stop when suspending is supported.  So now I=E2=80=99m mor=
e confused
> >>>> than before.
> >>>>
> >>> At this moment, I think that should be focused as an optimization and
> >>> not to be included in the main series.
> >> It is absolutely not an optimization but vital for my use case.
> >> virtiofsd does not currently implement resetting, but if it did (and w=
e
> >> want this support in the future), resetting it during stop/cont would =
be
> >> catastrophic.  There must be a way to have qemu not issue a reset.  Th=
is
> >> patch is the reason why this series exists.
> >>
> > Sorry, I see I confused things with the first reply. Let me do a recap.
> >
> > If I understand the problem correctly, your use case requires that
> > qemu does not reset the device before the device state is fetched with
> > virtio_save in the case of a migration.
>
> That is only part of the problem, the bigger picture has nothing to do
> with migration at all.  The problem is that when the VM is paused
> (stop), we invoke vhost_dev_stop(), and when it is resumed (cont), we
> invoke vhost_dev_start().  To me, it therefore sounds absolutely wrong
> to reset the back-end in either of these functions.  For stateless
> devices, it was determined to not be an issue (I still find it extremely
> strange), and as far as I=E2=80=99ve understood, we=E2=80=99ve come to th=
e agreement
> that it=E2=80=99s basically a fallback for when there is no other way to =
stop
> the back-end.  But stateful devices like virtio-fs would be completely
> broken by resetting them there.
>
> Therefore, if virtiofsd did implement reset through SET_STATUS,
> stop/cont would break it today.  Maybe other vhost-user devices, too,
> which just implement RESET_OWNER/RESET_DEVICE, which aren=E2=80=99t even =
called
> when the device is supposed to be reset in vhost_dev_stop() (patch 6).
>
> So not just because of migration, but in general, there must be a way
> for back-ends to force qemu not to reset them in vhost_dev_start()/stop()=
.
>
> Or we stop using vhost_dev_start()/stop() when the VM is paused/resumed
> (stop/cont).
>

Yes, that comes back to the thread [1].

As a third alternative, you can keep vhost_dev_start and let the
function check the current state and initialize the device only if
needed. But you can keep symmetrical functions and call one or another
at the device's code, of course. Not sure what is cleaner or requires
less changes.

> > This is understandable and I
> > think we have a solution for that: to move the vhost_ops call to
> > virtio_reset and the end of virtio_save.
>
> Why would we reset the device in virtio_save()?
>

If the VM continues in the source because of whatever reason,
vhost_dev_start would expect the device to be clean. You can test it
with the command "cont" after the LM.

> > To remove the reset call from
> > vhost_dev_stop is somehow mandatory, as it is called before
> > virtio_save.
> >
> > But we cannot move to vhost_vdpa_dev_start, as proposed here. The reaso=
ns are:
> > * All the features, vq parameters, etc are set before any
> > vhost_vdpa_dev_start call. To reset at any vhost_vdpa_dev_start would
> > wipe them.
> > * The device needs to hold all the resources until it is reset. Things
> > like descriptor status etc.
> >
> > And, regarding the comment "When RESUME is available, use it instead
> > of resetting", we cannot use resume to replace reset in all cases.
> > This is because the semantics are different.
> >
> > For example, vhost_dev_stop and vhost_dev_start are also called when
> > the guest reset by itself the device. You can check it rmmoding and
> > modprobing virtio-net driver, for example. In this case, the driver
> > expects to find all vqs to start with 0, but the resume must not reset
> > these indexes.
>
> This isn=E2=80=99t quite clear to me.  I understand this to mean that the=
re must
> be a reset somewhere in vhost_dev_stop() and/or vhost_dev_start().  But
> above, you proposed moving the reset from vhost_dev_stop() into
> virtio_reset().  Is virtio_reset() called in addition to
> vhost_dev_stop() and vhost_dev_start() when the guest driver is changed?
>

Right. Maybe another option is virtio_set_status?

The point is that other parts of qemu / guest trust the device to be
reset after (current version of) vhost_dev_stop, so if we are going to
move the reset it must be added to the callers at least. To trace
these callers is needed, so maybe it is easy to add another function
(vhost_dev_suspend?), your first alternative.

> Because we can=E2=80=99t have an always-present reset in vhost_dev_stop()=
 or
> vhost_dev_start().  It just doesn=E2=80=99t work with stop/cont.  At the =
same
> time, I understand that you say we must have it because
> vhost_dev_{stop,start}() are also used when the guest driver changes.
> Consequently, it sounds clear to me that using the exact same functions
> in stop/cont and when the guest driver is unloaded/loaded is and has
> always been wrong.  Because in stop/cont, the guest driver never
> changes, so we shouldn=E2=80=99t tell the back-end that it did (by sendin=
g
> SET_STATUS(0)).
>

Talking just about vhost_net here, the device dumps all the state
(like vqs) to qemu in vhost_dev_stop. That is what allows to have, for
example, an unified code in migrating: qemu only needs to know how to
migrate its emulated device, and vhost code just writes or read at
suspend / continue or live migrating. To suspend and continue is the
same operation actually for vhost_net.

> > It can be applied as an optimizations sometimes, but not for the genera=
l case.
> >
> >>>>>> But more generally, is this any different from what is done before=
 this
> >>>>>> patch?  Before this patch, vhost_dev_stop() unconditionally invoke=
s
> >>>>>> vhost_reset_status(), so the device is reset in every stop/start c=
ycle,
> >>>>>> that doesn=E2=80=99t change.  And we still won=E2=80=99t reset it =
on the first
> >>>>>> vhost_dev_start(), because dev->suspended will be false then, only=
 on
> >>>>>> subsequent stop/start cycles, as before.  So the only difference i=
s that
> >>>>>> now the device is reset on start, not on stop.
> >>>>>>
> >>>>> The difference is that vhost_vdpa_dev_start is called after feature=
s
> >>>>> ack (via vhost_dev_start, through vhost_dev_set_features call) and =
vq
> >>>>> configuration (using vhost_virtqueue_start). A device reset forces =
the
> >>>>> device to forget about all of that, and qemu cannot configure them
> >>>>> again until qemu acks the features again.
> >>>> Now I=E2=80=99m completely confused, because I don=E2=80=99t see the=
 point of
> >>>> implementing suspend at all if we rely on a reset immediately afterw=
ards
> >>>> anyway.
> >>> It's not immediate. From vhost_dev_stop, comments added only in this =
mail:
> >>>
> >>> void vhost_virtqueue_stop(struct vhost_dev *dev,
> >>>                             struct VirtIODevice *vdev,
> >>>                             struct vhost_virtqueue *vq,
> >>>                             unsigned idx)
> >>> {
> >>>       ...
> >>>       // Get each vring indexes, trusting the destination device can
> >>> continue safely from there
> >>>       r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> >>>       if (r < 0) {
> >>>           VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", i=
dx, r);
> >>>           /* Connection to the backend is broken, so let's sync inter=
nal
> >>>            * last avail idx to the device used idx.
> >>>            */
> >>>           virtio_queue_restore_last_avail_idx(vdev, idx);
> >>>       } else {
> >>>           virtio_queue_set_last_avail_idx(vdev, idx, state.num);
> >>>       }
> >>>       ...
> >>> }
> >>>
> >>> void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
vrings)
> >>> {
> >>>       ...
> >>>       // Suspend the device, so we can trust in vring indexes / vq st=
ate
> >> I don=E2=80=99t understand this purpose.  GET_VRING_BASE stops the vri=
ng in
> >> question, so the vring index returned must be trustworthy, no?
> >>
> > That only happens in vhost-user, not in vhost-vdpa.
>
> OK, so that begs the question: Was SUSPEND ever intended to do anything
> but stop all vrings?  Because this series is about to make its meaning a
> whole lot broader than that in vhost-user.
>

That was the big part, yes. The device must also stop modifying
config, like in the case of link status changes. Other actions like
fetch vq state are performed later (at vhost_virtqueue_stop).

VHOST_VDPA_SUSPEND requires the device to preserve all the needed
state to be recovered or continued:

Suspend a device so it does not process virtqueue requests anymore

After the return of ioctl the device must preserve all the necessary state
(the virtqueue vring base plus the possible device specific states) that is
required for restoring in the future. The device must not change its
configuration after that point.
---

> >>>       if (hdev->vhost_ops->vhost_dev_start) {
> >>>           hdev->vhost_ops->vhost_dev_start(hdev, false);
> >>>       }
> >>>       if (vrings) {
> >>>           vhost_dev_set_vring_enable(hdev, false);
> >>>       }
> >>>
> >>>       // Fetch each vq index / state and store in vdev->vq[i]
> >>>       for (i =3D 0; i < hdev->nvqs; ++i) {
> >>>           vhost_virtqueue_stop(hdev,
> >>>                                vdev,
> >>>                                hdev->vqs + i,
> >>>                                hdev->vq_index + i);
> >>>       }
> >>>
> >>>       // Reset the device, as we don't need it anymore and it can
> >>> release the resources
> >>>       if (hdev->vhost_ops->vhost_reset_status) {
> >>>           hdev->vhost_ops->vhost_reset_status(hdev);
> >>>       }
> >>> }
> >>> ---
> >>>
> >>>>    It was my impression this whole time that suspending would
> >>>> remove the need to reset.  Well, at least until the device should be
> >>>> resumed again, i.e. in vhost_dev_start().
> >>>>
> >>> It cannot. vhost_dev_stop is also called when the guest reset the
> >>> device, so the guest trusts the device to be in a clean state.
> >>>
> >>> Also, the reset is the moment when the device frees the unused
> >>> resources. This would mandate the device to
> >> What resources are we talking about?  This function is called when the
> >> VM is paused (stop).  If a stateful device is reset to free =E2=80=9Cu=
nused
> >> resources=E2=80=9D, this means dropping its internal state, which is a=
bsolutely
> >> wrong in a stop/cont cycle.
> >>
> > But is the expected result in the virtio reset cycle. We need to split
> > these paths.
> >
> >>>> In addition, I also don=E2=80=99t understand the magnitude of the pr=
oblem with
> >>>> ordering.  If the order in vhost_dev_start() is wrong, can we not ea=
sily
> >>>> fix it?
> >>> The order in vhost_dev_start follows the VirtIO standard.
> >> What does the VirtIO standard say about suspended vhost back-ends?
> >>
> > Suspend does not exist in the VirtIO standard. I meant the device
> > initialization order in "3.1 Device Initialization":
> >
> > 1. Reset the device.
> > ...
> > 5. Set the FEATURES_OK status bit. [...]
> > ...
> > 7. Perform device-specific setup, including discovery of virtqueues
> > for the device, optional per-bus setup, reading and possibly writing
> > the device=E2=80=99s virtio configuration space, and population of virt=
queues.
> > 8.Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cli=
ve=E2=80=9D.
> >
> > Steps 4-8 are all done in vhost_dev_start, in that particular order.
> > To call vhost_vdpa_reset_status from vhost_vdpa_dev_start(true) would
> > reset the device back to step 1, but there is no more code to set all
> > configuration from 2-7 before 8 (DRIVER_OK).
>
> That=E2=80=99s why I=E2=80=99ve proposed doing the reset at the start of
> vhost_dev_start() (quoted below still).  To me, that sounds in line with
> the virtio specification.
>
> Still, if you insist there must a reset somewhere in
> vhost_dev_start()/stop() because it may be guest-initiated, then there
> is no solution that can work for both.  We must be able to distinguish
> between a paused VM and a change in the guest driver.
>

Right.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg954916.html

> >> Hanna
> >>
> >>> The move of
> >>> the reset should be to remove it from vhost_dev_stop to something lik=
e
> >>> both virtio_reset and the end of virtio_save. I'm not sure if I'm
> >>> forgetting some other use cases.
> >>>
> >>>> E.g. add a full vhost_dev_resume callback to invoke right at
> >>>> the start of vhost_dev_start(); or check (in the same place) whether=
 the
> >>>> back-end supports resuming, and if it doesn=E2=80=99t (and it is cur=
rently
> >>>> suspended), reset it there.
>
>


