Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1E761036
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOEuh-000432-3U; Tue, 25 Jul 2023 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qOEub-00041j-FR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qOEuY-0003ED-0q
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690279496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5hD8cL06kAXkk7OGR9d8NOx9AhnIKHm3McBWbrpZkw=;
 b=Lo3H/nrZurGCgVIaqDNkc6NxGwYnHEJNs/oVJ1Hnyz5T4rX8vwclSCI9gkojDyLkX2+dI3
 ND/iL30O3R+90r3wHb/2Jc4UBmDnKcjF0/KLZs606JAgepUAgUWG7OVdLTHYwm7uDVgInA
 +8SbvGWkqgk3P/eblwmL4PnbxGRjwYU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-_E-ZNpJZOeW2QmvNDXfs-Q-1; Tue, 25 Jul 2023 06:04:54 -0400
X-MC-Unique: _E-ZNpJZOeW2QmvNDXfs-Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52256d84ab1so117973a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690279493; x=1690884293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5hD8cL06kAXkk7OGR9d8NOx9AhnIKHm3McBWbrpZkw=;
 b=NZHYV2CdFtEdmVUBiH60BKjEt5W+T+wsr6WuTcyDtI+QTKiPLRPPOAk3BNCKvHGnhi
 uHhTfV20FQclircz02fQ9VxVITHOrtWGIXfoaMI82MnTkHGa9+D32NCV5WSh7aqosZtT
 mK60rWsB4Z+XOFxt30c58+1fp6YA7ulyfTypG2M1zSgQ/DcOKw8SS9yYLpTmVe+oJ9xP
 64K7q5OjQ5EUmpG4eZuVHICLzUx0di5OnJjsZ6E69a5EFaQQs9cvbKoN5XVa2cFbPwLj
 lnuS3OV+M6WSiiCJNgZdmMlxE3seGqm+eVP0SZunYpeqjh9MHKufJn57i5XAGgtZldMg
 o8zw==
X-Gm-Message-State: ABy/qLbpbwZg9aCu39ig2a4V9p0H9vl1b4pOYqVkwScrQ+E3dfQxxZpQ
 48ekCkML9tUkjkefQjROYfsyIJp14ePzLItlm/hzacsG6UjbQotoTlItIBLm2j35bJrQnxmUqa3
 Zyyv7zVEEVhJfDrYR3hxbyCQZoX5PZgM=
X-Received: by 2002:a50:ec8d:0:b0:521:aeba:c6c0 with SMTP id
 e13-20020a50ec8d000000b00521aebac6c0mr10674903edr.36.1690279493624; 
 Tue, 25 Jul 2023 03:04:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExtKQNCuhI9zS8sfas2hv3WkIOCGwsFsBeZN2mZOsacQQ18Il3gFZ3G1/KlJLF+cCkE305BcPBuXF9e98EvOU=
X-Received: by 2002:a50:ec8d:0:b0:521:aeba:c6c0 with SMTP id
 e13-20020a50ec8d000000b00521aebac6c0mr10674892edr.36.1690279493256; Tue, 25
 Jul 2023 03:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
 <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
 <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
In-Reply-To: <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 25 Jul 2023 12:03:50 +0200
Message-ID: <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
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

On Tue, Jul 25, 2023 at 9:53=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 24.07.23 17:48, Eugenio Perez Martin wrote:
> > On Fri, Jul 21, 2023 at 6:07=E2=80=AFPM Hanna Czenczek <hreitz@redhat.c=
om> wrote:
> >> On 21.07.23 17:25, Eugenio Perez Martin wrote:
> >>> On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@redhat=
.com> wrote:
> >>>> Move the `suspended` field from vhost_vdpa into the global vhost_dev
> >>>> struct, so vhost_dev_stop() can check whether the back-end has been
> >>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
> >>>> there is no need to reset it; the reset is just a fall-back to stop
> >>>> device operations for back-ends that do not support suspend.
> >>>>
> >>>> Unfortunately, for vDPA specifically, RESUME is not yet implemented,=
 so
> >>>> when the device is re-started, we still have to do the reset to have=
 it
> >>>> un-suspend.
> >>>>
> >>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >>>> ---
> >>>>    include/hw/virtio/vhost-vdpa.h |  2 --
> >>>>    include/hw/virtio/vhost.h      |  8 ++++++++
> >>>>    hw/virtio/vhost-vdpa.c         | 11 +++++++----
> >>>>    hw/virtio/vhost.c              |  8 +++++++-
> >>>>    4 files changed, 22 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhos=
t-vdpa.h
> >>>> index e64bfc7f98..72c3686b7f 100644
> >>>> --- a/include/hw/virtio/vhost-vdpa.h
> >>>> +++ b/include/hw/virtio/vhost-vdpa.h
> >>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
> >>>>        bool shadow_vqs_enabled;
> >>>>        /* Vdpa must send shadow addresses as IOTLB key for data queu=
es, not GPA */
> >>>>        bool shadow_data;
> >>>> -    /* Device suspended successfully */
> >>>> -    bool suspended;
> >>>>        /* IOVA mapping used by the Shadow Virtqueue */
> >>>>        VhostIOVATree *iova_tree;
> >>>>        GPtrArray *shadow_vqs;
> >>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >>>> index 6a173cb9fa..69bf59d630 100644
> >>>> --- a/include/hw/virtio/vhost.h
> >>>> +++ b/include/hw/virtio/vhost.h
> >>>> @@ -120,6 +120,14 @@ struct vhost_dev {
> >>>>        uint64_t backend_cap;
> >>>>        /* @started: is the vhost device started? */
> >>>>        bool started;
> >>>> +    /**
> >>>> +     * @suspended: Whether the vhost device is currently suspended.=
  Set
> >>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), =
which
> >>>> +     * are supposed to automatically suspend/resume in their
> >>>> +     * vhost_dev_start handlers as required.  Must also be cleared =
when
> >>>> +     * the device is reset.
> >>>> +     */
> >>>> +    bool suspended;
> >>>>        bool log_enabled;
> >>>>        uint64_t log_size;
> >>>>        Error *migration_blocker;
> >>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>> index 7b7dee468e..f7fd19a203 100644
> >>>> --- a/hw/virtio/vhost-vdpa.c
> >>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vho=
st_dev *dev,
> >>>>
> >>>>    static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> >>>>    {
> >>>> -    struct vhost_vdpa *v =3D dev->opaque;
> >>>>        int ret;
> >>>>        uint8_t status =3D 0;
> >>>>
> >>>>        ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> >>>>        trace_vhost_vdpa_reset_device(dev);
> >>>> -    v->suspended =3D false;
> >>>> +    dev->suspended =3D false;
> >>>>        return ret;
> >>>>    }
> >>>>
> >>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_de=
v *dev)
> >>>>            if (unlikely(r)) {
> >>>>                error_report("Cannot suspend: %s(%d)", g_strerror(err=
no), errno);
> >>>>            } else {
> >>>> -            v->suspended =3D true;
> >>>> +            dev->suspended =3D true;
> >>>>                return;
> >>>>            }
> >>>>        }
> >>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_=
dev *dev, bool started)
> >>>>                return -1;
> >>>>            }
> >>>>            vhost_vdpa_set_vring_ready(dev);
> >>>> +        if (dev->suspended) {
> >>>> +            /* TODO: When RESUME is available, use it instead of re=
setting */
> >>>> +            vhost_vdpa_reset_status(dev);
> >>> How is that we reset the status at each vhost_vdpa_dev_start? That
> >>> will clean all the vqs configured, features negotiated, etc. in the
> >>> vDPA device. Or am I missing something?
> >> What alternative do you propose?  We don=E2=80=99t have RESUME for vDP=
A in qemu,
> >> but we somehow need to lift the previous SUSPEND so the device will
> >> again respond to guest requests, do we not?
> >>
> > Reset also clears the suspend state in vDPA, and it should be called
> > at vhost_dev_stop. So the device should never be in suspended state
> > here. Does that solve your concerns?
>
> My intention with this patch was precisely not to reset in
> vhost_dev_stop when suspending is supported.  So now I=E2=80=99m more con=
fused
> than before.
>

At this moment, I think that should be focused as an optimization and
not to be included in the main series.

> >> But more generally, is this any different from what is done before thi=
s
> >> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
> >> vhost_reset_status(), so the device is reset in every stop/start cycle=
,
> >> that doesn=E2=80=99t change.  And we still won=E2=80=99t reset it on t=
he first
> >> vhost_dev_start(), because dev->suspended will be false then, only on
> >> subsequent stop/start cycles, as before.  So the only difference is th=
at
> >> now the device is reset on start, not on stop.
> >>
> > The difference is that vhost_vdpa_dev_start is called after features
> > ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
> > configuration (using vhost_virtqueue_start). A device reset forces the
> > device to forget about all of that, and qemu cannot configure them
> > again until qemu acks the features again.
>
> Now I=E2=80=99m completely confused, because I don=E2=80=99t see the poin=
t of
> implementing suspend at all if we rely on a reset immediately afterwards
> anyway.

It's not immediate. From vhost_dev_stop, comments added only in this mail:

void vhost_virtqueue_stop(struct vhost_dev *dev,
                          struct VirtIODevice *vdev,
                          struct vhost_virtqueue *vq,
                          unsigned idx)
{
    ...
    // Get each vring indexes, trusting the destination device can
continue safely from there
    r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
    if (r < 0) {
        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
        /* Connection to the backend is broken, so let's sync internal
         * last avail idx to the device used idx.
         */
        virtio_queue_restore_last_avail_idx(vdev, idx);
    } else {
        virtio_queue_set_last_avail_idx(vdev, idx, state.num);
    }
    ...
}

void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings=
)
{
    ...
    // Suspend the device, so we can trust in vring indexes / vq state
    if (hdev->vhost_ops->vhost_dev_start) {
        hdev->vhost_ops->vhost_dev_start(hdev, false);
    }
    if (vrings) {
        vhost_dev_set_vring_enable(hdev, false);
    }

    // Fetch each vq index / state and store in vdev->vq[i]
    for (i =3D 0; i < hdev->nvqs; ++i) {
        vhost_virtqueue_stop(hdev,
                             vdev,
                             hdev->vqs + i,
                             hdev->vq_index + i);
    }

    // Reset the device, as we don't need it anymore and it can
release the resources
    if (hdev->vhost_ops->vhost_reset_status) {
        hdev->vhost_ops->vhost_reset_status(hdev);
    }
}
---

>  It was my impression this whole time that suspending would
> remove the need to reset.  Well, at least until the device should be
> resumed again, i.e. in vhost_dev_start().
>

It cannot. vhost_dev_stop is also called when the guest reset the
device, so the guest trusts the device to be in a clean state.

Also, the reset is the moment when the device frees the unused
resources. This would mandate the device to

> In addition, I also don=E2=80=99t understand the magnitude of the problem=
 with
> ordering.  If the order in vhost_dev_start() is wrong, can we not easily
> fix it?

The order in vhost_dev_start follows the VirtIO standard. The move of
the reset should be to remove it from vhost_dev_stop to something like
both virtio_reset and the end of virtio_save. I'm not sure if I'm
forgetting some other use cases.

> E.g. add a full vhost_dev_resume callback to invoke right at
> the start of vhost_dev_start(); or check (in the same place) whether the
> back-end supports resuming, and if it doesn=E2=80=99t (and it is currentl=
y
> suspended), reset it there.
>
> In any case, if we need to reset in vhost_dev_stop(), i.e. immediately
> after suspend, I don=E2=80=99t see the point of suspending, indicating to=
 me
> that I still fail to understand its purpose.
>
> Hanna
>


