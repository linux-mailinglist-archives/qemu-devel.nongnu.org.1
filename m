Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD808760C77
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 09:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOCra-0003qO-Cl; Tue, 25 Jul 2023 03:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOCrY-0003qG-K8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOCrW-0003SH-Lz
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 03:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690271620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUKtrZZfGlIace8zDkCUY9JlSY7MBeMTePrEJYbCsa0=;
 b=XBxX2hf2F17Jk6f0u3b5JVsLYo/fuM8jCbtAT96jMPaTZnqV9g2eoqnUjTSHX2rqOXEAtp
 PWZA9R6J8gtXMsv9ZxoqvWiNMJRYwN1S/bfd7LUzV8txEEhIymd+z5d1eDgjlbyDD9/sQ3
 kOS/qDF1sEBKnl9hr9vTD44m+CenSv4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-xrWhqwU2PeGWzdm3d-RGrw-1; Tue, 25 Jul 2023 03:53:38 -0400
X-MC-Unique: xrWhqwU2PeGWzdm3d-RGrw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b93faa81c9so42847511fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690271616; x=1690876416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUKtrZZfGlIace8zDkCUY9JlSY7MBeMTePrEJYbCsa0=;
 b=MjBpevZc0prof/L4aiyNW4WqIILfpvcJhHNPF0aZh9yY2dG/0xU+vOz4sdsat1GfQa
 9+3sYy67W4GwJCcSobupmd27Sh3XvsyvChaRqVY+tiqkt/hACrrEhalnbHY8SGGmsnx2
 8XQIylI14noFIF7xAGfLDpm2/LP0EN+rNV93rCwkC8mPo88A3IpyivUDa2BbINBRIVk/
 A4hLTwvZKVguLWER7FFNZLUJFi5/sj9UUNu/7YmzGdCkgtbiBgHzQWzLBOWD5zaHXTO7
 Qiniz5zMfUSDk1/YAvZjuTu4HrvisVImg7FUVLECYbO43eBCF9IloPTCgiUZEHhlLD6g
 NeRQ==
X-Gm-Message-State: ABy/qLZVy0EilMQrUbDZQs4Z2SX01yiE+dYm3+3URzMo/r6H4W0Opy1s
 nTHYXwnEStjXAg8ZaPgUdj62FsunSYoESWZg0VzJ+GWbyRA/Hoj9anTa/YD6gZFfJKbw6w6E9Kc
 at+gNvoz42qnY1HsrUWGOBzM=
X-Received: by 2002:a05:6512:3e11:b0:4f8:5635:2cd8 with SMTP id
 i17-20020a0565123e1100b004f856352cd8mr8689331lfv.32.1690271616224; 
 Tue, 25 Jul 2023 00:53:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVaJaK2RjhliGcjB15n5SQuO7tEAWTsopWM40yyu1940/AFpyz1rg3pzWYQ88AnNPjcZp8bQ==
X-Received: by 2002:a05:6512:3e11:b0:4f8:5635:2cd8 with SMTP id
 i17-20020a0565123e1100b004f856352cd8mr8689321lfv.32.1690271615849; 
 Tue, 25 Jul 2023 00:53:35 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a7bcb97000000b003fa96620b23sm15244891wmi.12.2023.07.25.00.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 00:53:35 -0700 (PDT)
Message-ID: <f27e3bf9-ef34-dae2-2f92-6f339f63a422@redhat.com>
Date: Tue, 25 Jul 2023 09:53:34 +0200
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
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
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

On 24.07.23 17:48, Eugenio Perez Martin wrote:
> On Fri, Jul 21, 2023 at 6:07 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 21.07.23 17:25, Eugenio Perez Martin wrote:
>>> On Tue, Jul 11, 2023 at 5:52 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>>>> Move the `suspended` field from vhost_vdpa into the global vhost_dev
>>>> struct, so vhost_dev_stop() can check whether the back-end has been
>>>> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
>>>> there is no need to reset it; the reset is just a fall-back to stop
>>>> device operations for back-ends that do not support suspend.
>>>>
>>>> Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
>>>> when the device is re-started, we still have to do the reset to have it
>>>> un-suspend.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    include/hw/virtio/vhost-vdpa.h |  2 --
>>>>    include/hw/virtio/vhost.h      |  8 ++++++++
>>>>    hw/virtio/vhost-vdpa.c         | 11 +++++++----
>>>>    hw/virtio/vhost.c              |  8 +++++++-
>>>>    4 files changed, 22 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
>>>> index e64bfc7f98..72c3686b7f 100644
>>>> --- a/include/hw/virtio/vhost-vdpa.h
>>>> +++ b/include/hw/virtio/vhost-vdpa.h
>>>> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
>>>>        bool shadow_vqs_enabled;
>>>>        /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
>>>>        bool shadow_data;
>>>> -    /* Device suspended successfully */
>>>> -    bool suspended;
>>>>        /* IOVA mapping used by the Shadow Virtqueue */
>>>>        VhostIOVATree *iova_tree;
>>>>        GPtrArray *shadow_vqs;
>>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>>> index 6a173cb9fa..69bf59d630 100644
>>>> --- a/include/hw/virtio/vhost.h
>>>> +++ b/include/hw/virtio/vhost.h
>>>> @@ -120,6 +120,14 @@ struct vhost_dev {
>>>>        uint64_t backend_cap;
>>>>        /* @started: is the vhost device started? */
>>>>        bool started;
>>>> +    /**
>>>> +     * @suspended: Whether the vhost device is currently suspended.  Set
>>>> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
>>>> +     * are supposed to automatically suspend/resume in their
>>>> +     * vhost_dev_start handlers as required.  Must also be cleared when
>>>> +     * the device is reset.
>>>> +     */
>>>> +    bool suspended;
>>>>        bool log_enabled;
>>>>        uint64_t log_size;
>>>>        Error *migration_blocker;
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 7b7dee468e..f7fd19a203 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
>>>>
>>>>    static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>>>>    {
>>>> -    struct vhost_vdpa *v = dev->opaque;
>>>>        int ret;
>>>>        uint8_t status = 0;
>>>>
>>>>        ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>>>>        trace_vhost_vdpa_reset_device(dev);
>>>> -    v->suspended = false;
>>>> +    dev->suspended = false;
>>>>        return ret;
>>>>    }
>>>>
>>>> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
>>>>            if (unlikely(r)) {
>>>>                error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
>>>>            } else {
>>>> -            v->suspended = true;
>>>> +            dev->suspended = true;
>>>>                return;
>>>>            }
>>>>        }
>>>> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>>>>                return -1;
>>>>            }
>>>>            vhost_vdpa_set_vring_ready(dev);
>>>> +        if (dev->suspended) {
>>>> +            /* TODO: When RESUME is available, use it instead of resetting */
>>>> +            vhost_vdpa_reset_status(dev);
>>> How is that we reset the status at each vhost_vdpa_dev_start? That
>>> will clean all the vqs configured, features negotiated, etc. in the
>>> vDPA device. Or am I missing something?
>> What alternative do you propose?  We don’t have RESUME for vDPA in qemu,
>> but we somehow need to lift the previous SUSPEND so the device will
>> again respond to guest requests, do we not?
>>
> Reset also clears the suspend state in vDPA, and it should be called
> at vhost_dev_stop. So the device should never be in suspended state
> here. Does that solve your concerns?

My intention with this patch was precisely not to reset in 
vhost_dev_stop when suspending is supported.  So now I’m more confused 
than before.

>> But more generally, is this any different from what is done before this
>> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
>> vhost_reset_status(), so the device is reset in every stop/start cycle,
>> that doesn’t change.  And we still won’t reset it on the first
>> vhost_dev_start(), because dev->suspended will be false then, only on
>> subsequent stop/start cycles, as before.  So the only difference is that
>> now the device is reset on start, not on stop.
>>
> The difference is that vhost_vdpa_dev_start is called after features
> ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
> configuration (using vhost_virtqueue_start). A device reset forces the
> device to forget about all of that, and qemu cannot configure them
> again until qemu acks the features again.

Now I’m completely confused, because I don’t see the point of 
implementing suspend at all if we rely on a reset immediately afterwards 
anyway.  It was my impression this whole time that suspending would 
remove the need to reset.  Well, at least until the device should be 
resumed again, i.e. in vhost_dev_start().

In addition, I also don’t understand the magnitude of the problem with 
ordering.  If the order in vhost_dev_start() is wrong, can we not easily 
fix it?  E.g. add a full vhost_dev_resume callback to invoke right at 
the start of vhost_dev_start(); or check (in the same place) whether the 
back-end supports resuming, and if it doesn’t (and it is currently 
suspended), reset it there.

In any case, if we need to reset in vhost_dev_stop(), i.e. immediately 
after suspend, I don’t see the point of suspending, indicating to me 
that I still fail to understand its purpose.

Hanna


