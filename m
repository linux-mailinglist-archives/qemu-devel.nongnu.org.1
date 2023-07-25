Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175276196C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHnT-0007sH-55; Tue, 25 Jul 2023 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOHnO-0007oO-CX
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOHnL-0001tS-NN
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690290582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/12UrCH7x0C3lwE6V26FGwR1IQRYODnJtj4jnL5vG/Q=;
 b=WPunJp7wrVvy05aHjE9WBV5Iv13+kk+1b2r5umzBPTcUHNZu4YxNVi54SnA9oYPoz1vpRn
 acqHhZT/5xCuGkeM1N9seQQAimW6IS5r3CkfMG6ChvfO8+bMBRmViZKglO1F/uvGrXKXrR
 fWWTTcu59y9NcFMgqw82UZBb8hERy6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-69hkF4u9Mvi4GKlub3r7Bg-1; Tue, 25 Jul 2023 09:09:39 -0400
X-MC-Unique: 69hkF4u9Mvi4GKlub3r7Bg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so3295614f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 06:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690290578; x=1690895378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/12UrCH7x0C3lwE6V26FGwR1IQRYODnJtj4jnL5vG/Q=;
 b=fUFkGYxhusRtvtGFJfkCWz6cxv9rtdE627YIgpZWDz44rKjJLSDq4EVRNO/fM1f3/Q
 D8mLH/M1gOKEpDwc30w95AlZtDt/skUKfi0+dr9okVVzIPBhN/bfukwBOPSxuDomEheX
 R7WLynha4CMJuPWLUtXltGdrk39tlLjjatrG/9vwhUpcAC4BD1jH7E09bnyeKQQ9iq4O
 8jQeio8jF5Ve0cwLnC38TiEtBXddSdUDhJ3IDDCH4II0oi+0YgDgupI9YvRM/pSsweVP
 iq0A4wNcRxF+HSTZ97NWlJhY3IVnTn6V6J4PAkpQyiYBkfgxf3a39v9ZHnrW8lpMrPZL
 4eLw==
X-Gm-Message-State: ABy/qLa5SfxXzcd24u1nhavut2KmHfOFH7h9Wt4DclEh/aCqmIQJ7Xe/
 70az+6QGKi2GepZ6l3lGBoe0l0QV52o5MloxD+8CD2FwxBz/ZAsgDl3MMaZYctrIjClbRyKLRaf
 4eZZLnXFT6vVvU2Q=
X-Received: by 2002:a5d:4e07:0:b0:317:5a99:4549 with SMTP id
 p7-20020a5d4e07000000b003175a994549mr5524119wrt.0.1690290578186; 
 Tue, 25 Jul 2023 06:09:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7NBoNrkAXzY/GUVurfIiZzK9YH9OzJzoMRzRymYa9MNQh7d/Kc5RcfULkyWwJFO43jR8HMA==
X-Received: by 2002:a5d:4e07:0:b0:317:5a99:4549 with SMTP id
 p7-20020a5d4e07000000b003175a994549mr5524102wrt.0.1690290577792; 
 Tue, 25 Jul 2023 06:09:37 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5492000000b003142e438e8csm16333006wrv.26.2023.07.25.06.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 06:09:37 -0700 (PDT)
Message-ID: <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
Date: Tue, 25 Jul 2023 15:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
 <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
 <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
 <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJaqyWet7vjS+4qy5TWBWm9j7jyf8Cm4rv_0t-eYB-PMDrKjpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 25.07.23 12:03, Eugenio Perez Martin wrote:
> On Tue, Jul 25, 2023 at 9:53 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 24.07.23 17:48, Eugenio Perez Martin wrote:
>>> On Fri, Jul 21, 2023 at 6:07 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
>>>>> On Tue, Jul 11, 2023 at 5:52 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>>>> Move the `suspended` field from vhost_vdpa into the global vhost_dev
>>>>>> struct, so vhost_dev_stop() can check whether the back-end has been
>>>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
>>>>>> there is no need to reset it; the reset is just a fall-back to stop
>>>>>> device operations for back-ends that do not support suspend.
>>>>>>
>>>>>> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
>>>>>> when the device is re-started, we still have to do the reset to have it
>>>>>> un-suspend.
>>>>>>
>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>> ---
>>>>>>     include/hw/virtio/vhost-vdpa.h |  2 --
>>>>>>     include/hw/virtio/vhost.h      |  8 ++++++++
>>>>>>     hw/virtio/vhost-vdpa.c         | 11 +++++++----
>>>>>>     hw/virtio/vhost.c              |  8 +++++++-
>>>>>>     4 files changed, 22 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
>>>>>> index e64bfc7f98..72c3686b7f 100644
>>>>>> --- a/include/hw/virtio/vhost-vdpa.h
>>>>>> +++ b/include/hw/virtio/vhost-vdpa.h
>>>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
>>>>>>         bool shadow_vqs_enabled;
>>>>>>         /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
>>>>>>         bool shadow_data;
>>>>>> -    /* Device suspended successfully */
>>>>>> -    bool suspended;
>>>>>>         /* IOVA mapping used by the Shadow Virtqueue */
>>>>>>         VhostIOVATree *iova_tree;
>>>>>>         GPtrArray *shadow_vqs;
>>>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>>>>> index 6a173cb9fa..69bf59d630 100644
>>>>>> --- a/include/hw/virtio/vhost.h
>>>>>> +++ b/include/hw/virtio/vhost.h
>>>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
>>>>>>         uint64_t backend_cap;
>>>>>>         /* @started: is the vhost device started? */
>>>>>>         bool started;
>>>>>> +    /**
>>>>>> +     * @suspended: Whether the vhost device is currently suspended.  Set
>>>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
>>>>>> +     * are supposed to automatically suspend/resume in their
>>>>>> +     * vhost_dev_start handlers as required.  Must also be cleared when
>>>>>> +     * the device is reset.
>>>>>> +     */
>>>>>> +    bool suspended;
>>>>>>         bool log_enabled;
>>>>>>         uint64_t log_size;
>>>>>>         Error *migration_blocker;
>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>>> index 7b7dee468e..f7fd19a203 100644
>>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
>>>>>>
>>>>>>     static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>>>>>>     {
>>>>>> -    struct vhost_vdpa *v = dev->opaque;
>>>>>>         int ret;
>>>>>>         uint8_t status = 0;
>>>>>>
>>>>>>         ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>>>>>         trace_vhost_vdpa_reset_device(dev);
>>>>>> -    v->suspended = false;
>>>>>> +    dev->suspended = false;
>>>>>>         return ret;
>>>>>>     }
>>>>>>
>>>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
>>>>>>             if (unlikely(r)) {
>>>>>>                 error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
>>>>>>             } else {
>>>>>> -            v->suspended = true;
>>>>>> +            dev->suspended = true;
>>>>>>                 return;
>>>>>>             }
>>>>>>         }
>>>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>>>>>                 return -1;
>>>>>>             }
>>>>>>             vhost_vdpa_set_vring_ready(dev);
>>>>>> +        if (dev->suspended) {
>>>>>> +            /* TODO: When RESUME is available, use it instead of resetting */
>>>>>> +            vhost_vdpa_reset_status(dev);
>>>>> How is that we reset the status at each vhost_vdpa_dev_start? That
>>>>> will clean all the vqs configured, features negotiated, etc. in the
>>>>> vDPA device. Or am I missing something?
>>>> What alternative do you propose?  We don’t have RESUME for vDPA in qemu,
>>>> but we somehow need to lift the previous SUSPEND so the device will
>>>> again respond to guest requests, do we not?
>>>>
>>> Reset also clears the suspend state in vDPA, and it should be called
>>> at vhost_dev_stop. So the device should never be in suspended state
>>> here. Does that solve your concerns?
>> My intention with this patch was precisely not to reset in
>> vhost_dev_stop when suspending is supported.  So now I’m more confused
>> than before.
>>
> At this moment, I think that should be focused as an optimization and
> not to be included in the main series.

It is absolutely not an optimization but vital for my use case. 
virtiofsd does not currently implement resetting, but if it did (and we 
want this support in the future), resetting it during stop/cont would be 
catastrophic.  There must be a way to have qemu not issue a reset.  This 
patch is the reason why this series exists.

>>>> But more generally, is this any different from what is done before this
>>>> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
>>>> vhost_reset_status(), so the device is reset in every stop/start cycle,
>>>> that doesn’t change.  And we still won’t reset it on the first
>>>> vhost_dev_start(), because dev->suspended will be false then, only on
>>>> subsequent stop/start cycles, as before.  So the only difference is that
>>>> now the device is reset on start, not on stop.
>>>>
>>> The difference is that vhost_vdpa_dev_start is called after features
>>> ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
>>> configuration (using vhost_virtqueue_start). A device reset forces the
>>> device to forget about all of that, and qemu cannot configure them
>>> again until qemu acks the features again.
>> Now I’m completely confused, because I don’t see the point of
>> implementing suspend at all if we rely on a reset immediately afterwards
>> anyway.
> It's not immediate. From vhost_dev_stop, comments added only in this mail:
>
> void vhost_virtqueue_stop(struct vhost_dev *dev,
>                            struct VirtIODevice *vdev,
>                            struct vhost_virtqueue *vq,
>                            unsigned idx)
> {
>      ...
>      // Get each vring indexes, trusting the destination device can
> continue safely from there
>      r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
>          VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
>          virtio_queue_restore_last_avail_idx(vdev, idx);
>      } else {
>          virtio_queue_set_last_avail_idx(vdev, idx, state.num);
>      }
>      ...
> }
>
> void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
> {
>      ...
>      // Suspend the device, so we can trust in vring indexes / vq state

I don’t understand this purpose.  GET_VRING_BASE stops the vring in 
question, so the vring index returned must be trustworthy, no?

>      if (hdev->vhost_ops->vhost_dev_start) {
>          hdev->vhost_ops->vhost_dev_start(hdev, false);
>      }
>      if (vrings) {
>          vhost_dev_set_vring_enable(hdev, false);
>      }
>
>      // Fetch each vq index / state and store in vdev->vq[i]
>      for (i = 0; i < hdev->nvqs; ++i) {
>          vhost_virtqueue_stop(hdev,
>                               vdev,
>                               hdev->vqs + i,
>                               hdev->vq_index + i);
>      }
>
>      // Reset the device, as we don't need it anymore and it can
> release the resources
>      if (hdev->vhost_ops->vhost_reset_status) {
>          hdev->vhost_ops->vhost_reset_status(hdev);
>      }
> }
> ---
>
>>   It was my impression this whole time that suspending would
>> remove the need to reset.  Well, at least until the device should be
>> resumed again, i.e. in vhost_dev_start().
>>
> It cannot. vhost_dev_stop is also called when the guest reset the
> device, so the guest trusts the device to be in a clean state.
>
> Also, the reset is the moment when the device frees the unused
> resources. This would mandate the device to

What resources are we talking about?  This function is called when the 
VM is paused (stop).  If a stateful device is reset to free “unused 
resources”, this means dropping its internal state, which is absolutely 
wrong in a stop/cont cycle.

>> In addition, I also don’t understand the magnitude of the problem with
>> ordering.  If the order in vhost_dev_start() is wrong, can we not easily
>> fix it?
> The order in vhost_dev_start follows the VirtIO standard.

What does the VirtIO standard say about suspended vhost back-ends?

Hanna

> The move of
> the reset should be to remove it from vhost_dev_stop to something like
> both virtio_reset and the end of virtio_save. I'm not sure if I'm
> forgetting some other use cases.
>
>> E.g. add a full vhost_dev_resume callback to invoke right at
>> the start of vhost_dev_start(); or check (in the same place) whether the
>> back-end supports resuming, and if it doesn’t (and it is currently
>> suspended), reset it there.
>>
>> In any case, if we need to reset in vhost_dev_stop(), i.e. immediately
>> after suspend, I don’t see the point of suspending, indicating to me
>> that I still fail to understand its purpose.
>>
>> Hanna
>>


