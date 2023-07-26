Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C229F762C30
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 08:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYSf-00032W-St; Wed, 26 Jul 2023 02:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOYSc-000323-Tr
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOYSa-0006g8-He
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 02:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690354643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiV3yTwPGPn0FZcPRxSANqsr9abyKeGZa3jiq1e2BW4=;
 b=Vr94cDE2yMYLSOrEpUBp3BmM+Qn43U0J53IieUZPJZw/zNIZap/oIAwUZsV+RpIpzEpCbG
 VfeRDfVUk3eCclfbVCuluR34fUoSKPT/aj6CU0hufh1SnQf+Nb1+WTV4fP8Mb1PGJst1xG
 G5QJP49/ifruzX7Lubr+jleAmFd/48g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mF9TH70OPS6zZXwXdXXUYA-1; Wed, 26 Jul 2023 02:57:21 -0400
X-MC-Unique: mF9TH70OPS6zZXwXdXXUYA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd2209bde4so24494365e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 23:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690354640; x=1690959440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RiV3yTwPGPn0FZcPRxSANqsr9abyKeGZa3jiq1e2BW4=;
 b=NsRbpJbKAKNEkqvGEP8b166mnslTgd9bWOXXHvjiaLs0PLHE3y75cMWeARvdjAHw2Q
 OIMLqIKwkVnPltZXl/SMp9xTOsaQN3pcpub+uiCqqEV9c9atIkp6/TUAStxNM5q4kHNs
 6iS11lGmZy9LntdKZiRB+o9gNaPujPOSUM8AxLUN6qGicmRsO9v/W95fDsd778vXdJ42
 eeTBMKVwlNlZP4rMTi2Wv4X02O500AW5FS1x077M2USRWrU189gVTMeU9Xc5knIyV6Gs
 3m5FNUSeAto58Jr0xHPB1Aewi1+YG/kI5dW2wcViJ9MYgEnsLipIMMYDahkcVNz1QtUL
 0G+w==
X-Gm-Message-State: ABy/qLYXmjqvuXsgMQ3++1oTzc5JLCsMB/NFQjUFGkdKwg5K/26WYcyZ
 YCjBhhWG3zkPMkJJzhhvYRBXTCocaFrjHklp3dIE2SztDlOqlIXuiILX2u7kMN87zyWvJZmI+wh
 jZnhzH9eGi6uzpZc=
X-Received: by 2002:a5d:558e:0:b0:313:e9f6:3378 with SMTP id
 i14-20020a5d558e000000b00313e9f63378mr617970wrv.4.1690354640182; 
 Tue, 25 Jul 2023 23:57:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIKAxx2XcZgE7sPJ6+7ilXvL9j1Rcj1+3v4lYlPoYdpK2lOoz5a0n41amWZIx44Ru2IavXPg==
X-Received: by 2002:a5d:558e:0:b0:313:e9f6:3378 with SMTP id
 i14-20020a5d558e000000b00313e9f63378mr617954wrv.4.1690354639727; 
 Tue, 25 Jul 2023 23:57:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a5d6b8c000000b003143c6e09ccsm18539254wrx.16.2023.07.25.23.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 23:57:19 -0700 (PDT)
Message-ID: <bc1f4b18-8bf9-f8ac-fa47-babde355e340@redhat.com>
Date: Wed, 26 Jul 2023 08:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
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
 <64443883-5e35-0088-561f-4f0e77c59037@redhat.com>
 <CAJaqyWd-bdA5CgdEvMoiAOWGUzUZV+Urvd4WW7+BFqSbhC0FqQ@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJaqyWd-bdA5CgdEvMoiAOWGUzUZV+Urvd4WW7+BFqSbhC0FqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

On 25.07.23 20:53, Eugenio Perez Martin wrote:
> On Tue, Jul 25, 2023 at 3:09 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 25.07.23 12:03, Eugenio Perez Martin wrote:
>>> On Tue, Jul 25, 2023 at 9:53 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>> On 24.07.23 17:48, Eugenio Perez Martin wrote:
>>>>> On Fri, Jul 21, 2023 at 6:07 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>>>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
>>>>>>> On Tue, Jul 11, 2023 at 5:52 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>>>>>> Move the `suspended` field from vhost_vdpa into the global vhost_dev
>>>>>>>> struct, so vhost_dev_stop() can check whether the back-end has been
>>>>>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
>>>>>>>> there is no need to reset it; the reset is just a fall-back to stop
>>>>>>>> device operations for back-ends that do not support suspend.
>>>>>>>>
>>>>>>>> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
>>>>>>>> when the device is re-started, we still have to do the reset to have it
>>>>>>>> un-suspend.
>>>>>>>>
>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>> ---
>>>>>>>>      include/hw/virtio/vhost-vdpa.h |  2 --
>>>>>>>>      include/hw/virtio/vhost.h      |  8 ++++++++
>>>>>>>>      hw/virtio/vhost-vdpa.c         | 11 +++++++----
>>>>>>>>      hw/virtio/vhost.c              |  8 +++++++-
>>>>>>>>      4 files changed, 22 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
>>>>>>>> index e64bfc7f98..72c3686b7f 100644
>>>>>>>> --- a/include/hw/virtio/vhost-vdpa.h
>>>>>>>> +++ b/include/hw/virtio/vhost-vdpa.h
>>>>>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
>>>>>>>>          bool shadow_vqs_enabled;
>>>>>>>>          /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
>>>>>>>>          bool shadow_data;
>>>>>>>> -    /* Device suspended successfully */
>>>>>>>> -    bool suspended;
>>>>>>>>          /* IOVA mapping used by the Shadow Virtqueue */
>>>>>>>>          VhostIOVATree *iova_tree;
>>>>>>>>          GPtrArray *shadow_vqs;
>>>>>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>>>>>>> index 6a173cb9fa..69bf59d630 100644
>>>>>>>> --- a/include/hw/virtio/vhost.h
>>>>>>>> +++ b/include/hw/virtio/vhost.h
>>>>>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
>>>>>>>>          uint64_t backend_cap;
>>>>>>>>          /* @started: is the vhost device started? */
>>>>>>>>          bool started;
>>>>>>>> +    /**
>>>>>>>> +     * @suspended: Whether the vhost device is currently suspended.  Set
>>>>>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
>>>>>>>> +     * are supposed to automatically suspend/resume in their
>>>>>>>> +     * vhost_dev_start handlers as required.  Must also be cleared when
>>>>>>>> +     * the device is reset.
>>>>>>>> +     */
>>>>>>>> +    bool suspended;
>>>>>>>>          bool log_enabled;
>>>>>>>>          uint64_t log_size;
>>>>>>>>          Error *migration_blocker;
>>>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>>>>> index 7b7dee468e..f7fd19a203 100644
>>>>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
>>>>>>>>
>>>>>>>>      static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>>>>>>>>      {
>>>>>>>> -    struct vhost_vdpa *v = dev->opaque;
>>>>>>>>          int ret;
>>>>>>>>          uint8_t status = 0;
>>>>>>>>
>>>>>>>>          ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>>>>>>>          trace_vhost_vdpa_reset_device(dev);
>>>>>>>> -    v->suspended = false;
>>>>>>>> +    dev->suspended = false;
>>>>>>>>          return ret;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
>>>>>>>>              if (unlikely(r)) {
>>>>>>>>                  error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
>>>>>>>>              } else {
>>>>>>>> -            v->suspended = true;
>>>>>>>> +            dev->suspended = true;
>>>>>>>>                  return;
>>>>>>>>              }
>>>>>>>>          }
>>>>>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>>>>>>>                  return -1;
>>>>>>>>              }
>>>>>>>>              vhost_vdpa_set_vring_ready(dev);
>>>>>>>> +        if (dev->suspended) {
>>>>>>>> +            /* TODO: When RESUME is available, use it instead of resetting */
>>>>>>>> +            vhost_vdpa_reset_status(dev);
>>>>>>> How is that we reset the status at each vhost_vdpa_dev_start? That
>>>>>>> will clean all the vqs configured, features negotiated, etc. in the
>>>>>>> vDPA device. Or am I missing something?
>>>>>> What alternative do you propose?  We don’t have RESUME for vDPA in qemu,
>>>>>> but we somehow need to lift the previous SUSPEND so the device will
>>>>>> again respond to guest requests, do we not?
>>>>>>
>>>>> Reset also clears the suspend state in vDPA, and it should be called
>>>>> at vhost_dev_stop. So the device should never be in suspended state
>>>>> here. Does that solve your concerns?
>>>> My intention with this patch was precisely not to reset in
>>>> vhost_dev_stop when suspending is supported.  So now I’m more confused
>>>> than before.
>>>>
>>> At this moment, I think that should be focused as an optimization and
>>> not to be included in the main series.
>> It is absolutely not an optimization but vital for my use case.
>> virtiofsd does not currently implement resetting, but if it did (and we
>> want this support in the future), resetting it during stop/cont would be
>> catastrophic.  There must be a way to have qemu not issue a reset.  This
>> patch is the reason why this series exists.
>>
> Sorry, I see I confused things with the first reply. Let me do a recap.
>
> If I understand the problem correctly, your use case requires that
> qemu does not reset the device before the device state is fetched with
> virtio_save in the case of a migration.

That is only part of the problem, the bigger picture has nothing to do 
with migration at all.  The problem is that when the VM is paused 
(stop), we invoke vhost_dev_stop(), and when it is resumed (cont), we 
invoke vhost_dev_start().  To me, it therefore sounds absolutely wrong 
to reset the back-end in either of these functions.  For stateless 
devices, it was determined to not be an issue (I still find it extremely 
strange), and as far as I’ve understood, we’ve come to the agreement 
that it’s basically a fallback for when there is no other way to stop 
the back-end.  But stateful devices like virtio-fs would be completely 
broken by resetting them there.

Therefore, if virtiofsd did implement reset through SET_STATUS, 
stop/cont would break it today.  Maybe other vhost-user devices, too, 
which just implement RESET_OWNER/RESET_DEVICE, which aren’t even called 
when the device is supposed to be reset in vhost_dev_stop() (patch 6).

So not just because of migration, but in general, there must be a way 
for back-ends to force qemu not to reset them in vhost_dev_start()/stop().

Or we stop using vhost_dev_start()/stop() when the VM is paused/resumed 
(stop/cont).

> This is understandable and I
> think we have a solution for that: to move the vhost_ops call to
> virtio_reset and the end of virtio_save.

Why would we reset the device in virtio_save()?

> To remove the reset call from
> vhost_dev_stop is somehow mandatory, as it is called before
> virtio_save.
>
> But we cannot move to vhost_vdpa_dev_start, as proposed here. The reasons are:
> * All the features, vq parameters, etc are set before any
> vhost_vdpa_dev_start call. To reset at any vhost_vdpa_dev_start would
> wipe them.
> * The device needs to hold all the resources until it is reset. Things
> like descriptor status etc.
>
> And, regarding the comment "When RESUME is available, use it instead
> of resetting", we cannot use resume to replace reset in all cases.
> This is because the semantics are different.
>
> For example, vhost_dev_stop and vhost_dev_start are also called when
> the guest reset by itself the device. You can check it rmmoding and
> modprobing virtio-net driver, for example. In this case, the driver
> expects to find all vqs to start with 0, but the resume must not reset
> these indexes.

This isn’t quite clear to me.  I understand this to mean that there must 
be a reset somewhere in vhost_dev_stop() and/or vhost_dev_start().  But 
above, you proposed moving the reset from vhost_dev_stop() into 
virtio_reset().  Is virtio_reset() called in addition to 
vhost_dev_stop() and vhost_dev_start() when the guest driver is changed?

Because we can’t have an always-present reset in vhost_dev_stop() or 
vhost_dev_start().  It just doesn’t work with stop/cont.  At the same 
time, I understand that you say we must have it because 
vhost_dev_{stop,start}() are also used when the guest driver changes.  
Consequently, it sounds clear to me that using the exact same functions 
in stop/cont and when the guest driver is unloaded/loaded is and has 
always been wrong.  Because in stop/cont, the guest driver never 
changes, so we shouldn’t tell the back-end that it did (by sending 
SET_STATUS(0)).

> It can be applied as an optimizations sometimes, but not for the general case.
>
>>>>>> But more generally, is this any different from what is done before this
>>>>>> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
>>>>>> vhost_reset_status(), so the device is reset in every stop/start cycle,
>>>>>> that doesn’t change.  And we still won’t reset it on the first
>>>>>> vhost_dev_start(), because dev->suspended will be false then, only on
>>>>>> subsequent stop/start cycles, as before.  So the only difference is that
>>>>>> now the device is reset on start, not on stop.
>>>>>>
>>>>> The difference is that vhost_vdpa_dev_start is called after features
>>>>> ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
>>>>> configuration (using vhost_virtqueue_start). A device reset forces the
>>>>> device to forget about all of that, and qemu cannot configure them
>>>>> again until qemu acks the features again.
>>>> Now I’m completely confused, because I don’t see the point of
>>>> implementing suspend at all if we rely on a reset immediately afterwards
>>>> anyway.
>>> It's not immediate. From vhost_dev_stop, comments added only in this mail:
>>>
>>> void vhost_virtqueue_stop(struct vhost_dev *dev,
>>>                             struct VirtIODevice *vdev,
>>>                             struct vhost_virtqueue *vq,
>>>                             unsigned idx)
>>> {
>>>       ...
>>>       // Get each vring indexes, trusting the destination device can
>>> continue safely from there
>>>       r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>>       if (r < 0) {
>>>           VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>>>           /* Connection to the backend is broken, so let's sync internal
>>>            * last avail idx to the device used idx.
>>>            */
>>>           virtio_queue_restore_last_avail_idx(vdev, idx);
>>>       } else {
>>>           virtio_queue_set_last_avail_idx(vdev, idx, state.num);
>>>       }
>>>       ...
>>> }
>>>
>>> void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>>> {
>>>       ...
>>>       // Suspend the device, so we can trust in vring indexes / vq state
>> I don’t understand this purpose.  GET_VRING_BASE stops the vring in
>> question, so the vring index returned must be trustworthy, no?
>>
> That only happens in vhost-user, not in vhost-vdpa.

OK, so that begs the question: Was SUSPEND ever intended to do anything 
but stop all vrings?  Because this series is about to make its meaning a 
whole lot broader than that in vhost-user.

>>>       if (hdev->vhost_ops->vhost_dev_start) {
>>>           hdev->vhost_ops->vhost_dev_start(hdev, false);
>>>       }
>>>       if (vrings) {
>>>           vhost_dev_set_vring_enable(hdev, false);
>>>       }
>>>
>>>       // Fetch each vq index / state and store in vdev->vq[i]
>>>       for (i = 0; i < hdev->nvqs; ++i) {
>>>           vhost_virtqueue_stop(hdev,
>>>                                vdev,
>>>                                hdev->vqs + i,
>>>                                hdev->vq_index + i);
>>>       }
>>>
>>>       // Reset the device, as we don't need it anymore and it can
>>> release the resources
>>>       if (hdev->vhost_ops->vhost_reset_status) {
>>>           hdev->vhost_ops->vhost_reset_status(hdev);
>>>       }
>>> }
>>> ---
>>>
>>>>    It was my impression this whole time that suspending would
>>>> remove the need to reset.  Well, at least until the device should be
>>>> resumed again, i.e. in vhost_dev_start().
>>>>
>>> It cannot. vhost_dev_stop is also called when the guest reset the
>>> device, so the guest trusts the device to be in a clean state.
>>>
>>> Also, the reset is the moment when the device frees the unused
>>> resources. This would mandate the device to
>> What resources are we talking about?  This function is called when the
>> VM is paused (stop).  If a stateful device is reset to free “unused
>> resources”, this means dropping its internal state, which is absolutely
>> wrong in a stop/cont cycle.
>>
> But is the expected result in the virtio reset cycle. We need to split
> these paths.
>
>>>> In addition, I also don’t understand the magnitude of the problem with
>>>> ordering.  If the order in vhost_dev_start() is wrong, can we not easily
>>>> fix it?
>>> The order in vhost_dev_start follows the VirtIO standard.
>> What does the VirtIO standard say about suspended vhost back-ends?
>>
> Suspend does not exist in the VirtIO standard. I meant the device
> initialization order in "3.1 Device Initialization":
>
> 1. Reset the device.
> ...
> 5. Set the FEATURES_OK status bit. [...]
> ...
> 7. Perform device-specific setup, including discovery of virtqueues
> for the device, optional per-bus setup, reading and possibly writing
> the device’s virtio configuration space, and population of virtqueues.
> 8.Set the DRIVER_OK status bit. At this point the device is “live”.
>
> Steps 4-8 are all done in vhost_dev_start, in that particular order.
> To call vhost_vdpa_reset_status from vhost_vdpa_dev_start(true) would
> reset the device back to step 1, but there is no more code to set all
> configuration from 2-7 before 8 (DRIVER_OK).

That’s why I’ve proposed doing the reset at the start of 
vhost_dev_start() (quoted below still).  To me, that sounds in line with 
the virtio specification.

Still, if you insist there must a reset somewhere in 
vhost_dev_start()/stop() because it may be guest-initiated, then there 
is no solution that can work for both.  We must be able to distinguish 
between a paused VM and a change in the guest driver.

>> Hanna
>>
>>> The move of
>>> the reset should be to remove it from vhost_dev_stop to something like
>>> both virtio_reset and the end of virtio_save. I'm not sure if I'm
>>> forgetting some other use cases.
>>>
>>>> E.g. add a full vhost_dev_resume callback to invoke right at
>>>> the start of vhost_dev_start(); or check (in the same place) whether the
>>>> back-end supports resuming, and if it doesn’t (and it is currently
>>>> suspended), reset it there.



