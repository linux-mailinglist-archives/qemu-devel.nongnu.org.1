Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BF760D43
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:40:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODa8-0008Q1-8x; Tue, 25 Jul 2023 04:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qODa3-0008Pb-UL
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qODa1-0003o3-O0
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690274380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pjXwSKcalfc1Q4g8v4hZoiTnhdfC8lOIzc7KQAJICQ=;
 b=YSnNYupRG0/rgTAF8R+duhaCBppDBWI2VuVHnzranBMxswpkLh/yUIUsRmAgZVFdOsxNhf
 Nj65uGJBjKNatDhmvmNaQXgwKh7SQuypP/bgQngXxNs4UYZt/OZ+9CDws4WW9BwOwQjmMs
 Am0xYGDcDD+Nie3+GuI9zeHk5lPCT2M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-Bea1NVYYMzG8h0SiCSr4WA-1; Tue, 25 Jul 2023 04:39:39 -0400
X-MC-Unique: Bea1NVYYMzG8h0SiCSr4WA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b743113ecdso43720921fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 01:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690274378; x=1690879178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9pjXwSKcalfc1Q4g8v4hZoiTnhdfC8lOIzc7KQAJICQ=;
 b=F+rWsm+lbxDXv+k62sl0ip3B7y7bFDC5S9sTeHYALrIzawZAbS8UWxkq541i6DT501
 LLSL8eaZxj7MNV5NZBbw3MU8lUqA6ET/uIAfiaF6wIGiUJT5gyN0l9c56aRiCIWT/4Hj
 qwdPa2eeaBmJemITv0zA+XnUrEDNd+JSHSdknznJQChxRfUes+jzzvMC9PfwLfP9UG6r
 d7kjY0FWeljappn8rzvA/MVl4dviCy1Wyt8bnwIoQJLeBc8pvY6+o+3WrO1anrx1kMdo
 yjGC3fK/QOywPpZSWos9E9Ehj/zsCI1eolVIGBNRI3t7oBwRPYtMTV7rL8bllX2IPSCk
 8I0w==
X-Gm-Message-State: ABy/qLY5MalxkEzcaH2wJ7+6/aXSiNB/gHp1kN6xTTInd0ogKALQk9G2
 sDMA5HXKb1DVQ/2BAWyUga7w+e0jBOrFuOtnFLT7WVUfhrabP1mh3axL/2kSgND1OnkIS4u5PqX
 K/fjR28x/oTJDYZk=
X-Received: by 2002:a2e:9e95:0:b0:2b6:de52:34f with SMTP id
 f21-20020a2e9e95000000b002b6de52034fmr7129755ljk.24.1690274377761; 
 Tue, 25 Jul 2023 01:39:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJ3pdrMy1szpeVH/s06SSH9uaPFQrU4pCslREl/EMxrZkG6suQl3hg+ZrskBgRsx7dzWLrmQ==
X-Received: by 2002:a2e:9e95:0:b0:2b6:de52:34f with SMTP id
 f21-20020a2e9e95000000b002b6de52034fmr7129745ljk.24.1690274377378; 
 Tue, 25 Jul 2023 01:39:37 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adfd4ca000000b003140f47224csm15592283wrk.15.2023.07.25.01.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 01:39:36 -0700 (PDT)
Message-ID: <287e1a04-cd8b-ec03-cc86-8fb28d7f0edb@redhat.com>
Date: Tue, 25 Jul 2023 10:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-7-hreitz@redhat.com> <20230718151044.GG44841@fedora>
 <7ba1e055-e513-1735-5e60-eceb06fe877a@redhat.com>
 <0c8e2902-89a0-a9b6-744d-6ab737a0dbb0@redhat.com>
 <20230720160300.GG184015@fedora>
 <269831fe-e237-e28a-a74c-68a6d8fede7b@redhat.com>
 <20230724180401.GB222590@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724180401.GB222590@fedora>
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

On 24.07.23 20:04, Stefan Hajnoczi wrote:
> On Fri, Jul 21, 2023 at 04:16:07PM +0200, Hanna Czenczek wrote:
>> On 20.07.23 18:03, Stefan Hajnoczi wrote:
>>> On Wed, Jul 19, 2023 at 04:27:58PM +0200, Hanna Czenczek wrote:
>>>> On 19.07.23 16:11, Hanna Czenczek wrote:
>>>>> On 18.07.23 17:10, Stefan Hajnoczi wrote:
>>>>>> On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
>>>>>>> The only user of vhost_user_reset_status() is vhost_dev_stop(), which
>>>>>>> only uses it as a fall-back to stop the back-end if it does not support
>>>>>>> SUSPEND.  However, vhost-user's implementation is a no-op unless the
>>>>>>> back-end supports SET_STATUS.
>>>>>>>
>>>>>>> vhost-vdpa's implementation instead just calls
>>>>>>> vhost_vdpa_reset_device(), implying that it's OK to fully reset the
>>>>>>> device if SET_STATUS is not supported.
>>>>>>>
>>>>>>> To be fair, vhost_vdpa_reset_device() does nothing but to set
>>>>>>> the status
>>>>>>> to zero.  However, that may well be because vhost-vdpa has no method
>>>>>>> besides this to reset a device.  In contrast, vhost-user has
>>>>>>> RESET_DEVICE and a RESET_OWNER, which can be used instead.
>>>>>>>
>>>>>>> While it is not entirely clear from documentation or git logs, from
>>>>>>> discussions and the order of vhost-user protocol features, it
>>>>>>> appears to
>>>>>>> me as if RESET_OWNER originally had no real meaning for vhost-user, and
>>>>>>> was thus used to signal a device reset to the back-end.  Then,
>>>>>>> RESET_DEVICE was introduced, to have a well-defined dedicated reset
>>>>>>> command.  Finally, vhost-user received full STATUS support, including
>>>>>>> SET_STATUS, so setting the device status to 0 is now the preferred way
>>>>>>> of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
>>>>>>> remain valid as fall-backs.
>>>>>>>
>>>>>>> Therefore, have vhost_user_reset_status() fall back to
>>>>>>> vhost_user_reset_device() if the back-end has no STATUS support.
>>>>>>>
>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>> ---
>>>>>>>     hw/virtio/vhost-user.c | 2 ++
>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>>>>> index 4507de5a92..53a881ec2a 100644
>>>>>>> --- a/hw/virtio/vhost-user.c
>>>>>>> +++ b/hw/virtio/vhost-user.c
>>>>>>> @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct
>>>>>>> vhost_dev *dev)
>>>>>>>         if (virtio_has_feature(dev->protocol_features,
>>>>>>>                                VHOST_USER_PROTOCOL_F_STATUS)) {
>>>>>>>             vhost_user_set_status(dev, 0);
>>>>>>> +    } else {
>>>>>>> +        vhost_user_reset_device(dev);
>>>>>>>         }
>>>>>>>     }
>>>>>> Did you check whether DPDK treats setting the status to 0 as equivalent
>>>>>> to RESET_DEVICE?
>>>>> If it doesn’t, what’s even the point of using reset_status?
>>>> Sorry, I’m being unclear, and I think this may be important because it ties
>>>> into the question from patch 1, what qemu is even trying to do by running
>>>> SET_STATUS(0) vhost_dev_stop(), so here’s what gave me the impression that
>>>> SET_STATUS(0) and RESET_DEVICE should be equivalent:
>>>>
>>>> vhost-vdpa.c runs SET_STATUS(0) in a function called
>>>> vhost_vdpa_reset_device().  This is one thing that gave me the impression
>>>> that this is about an actual full reset.
>>>>
>>>> Another is the whole discussion that we’ve had.  vhost_dev_stop() does not
>>>> call a `vhost_reset_device()` function, it calls `vhost_reset_status()`.
>>>> Still, we were always talking about resetting the device.
>>> There is some hacky stuff with struct vhost_dev's vq_index_end and
>>> multi-queue devices. I think it's because multi-queue vhost-net device
>>> consist of many vhost_devs and NetClientStates, so certain vhost
>>> operations are skipped unless this is the "first" or "last" vhost_dev
>>> from a large aggregate vhost-net device. That might be responsible for
>>> part of the weirdness.
>>>
>>>> It doesn’t make sense to me that vDPA would provide no function to fully
>>>> reset a device, while vhost-user does.  Being able to reset a device sounds
>>>> vital to me.  This also gave me the impression that SET_STATUS(0) on vDPA at
>>>> least is functionally equivalent to a full device reset.
>>>>
>>>>
>>>> Maybe SET_STATUS(0) does mean a full device reset on vDPA, but not on
>>>> vhost-user.  That would be a real shame, so I assumed this would not be the
>>>> case; that SET_STATUS(0) does the same thing on both protocols.
>>> Yes, exactly. It has the real VIRTIO spec meaning in vDPA. In vhost-user
>>> it's currently only used by DPDK as a hint for when device
>>> initialization is complete:
>>> https://github.com/DPDK/dpdk/commit/41d201804c4c44738168e2d247d3b1780845faa1
>> FWIW, now the code is a bit different.
>> https://github.com/DPDK/dpdk/commit/671cc679a5fcd26705bb20ddc13b93e665719054
>> has added a RESET interpretation for the status field, i.e. when it is 0.
>> It doesn’t do anything, but at least DPDK seems to agree that SET_STATUS(0)
>> is a reset.
> That patch adds diagnostics but does not perform any action for
> SET_STATUS 0. DPDK's vhost_user_reset_owner() is still the only place
> where the device is actually reset.

That’s what I said, it doesn’t do anything, but the diagnostics agree 
that it is a RESET.

> QEMU cannot switch to just
> SET_STATUS 0, it still needs to send RESET_DEVICE/RESET_OWNER.

That is what I questioned below: We currently *do not* call 
RESET_DEVICE/RESET_OWNER.  This patch is not about switching to 
SET_STATUS(0), it is about having RESET_DEVICE/RESET_OWNER be fallbacks 
for it.

>>>> The virtio specification says “Writing 0 into this field resets the device.”
>>>> about the device_status field.
>>>>
>>>> This also makes sense, because the device_status field is basically used to
>>>> tell the device that a driver has taken control.  If reset, this indicates
>>>> the driver has given up control, and to me this is a point where a device
>>>> should fully reset itself.
>>>>
>>>> So all in all, I can’t see the rationale why any implementation that
>>>> supports SET_STATUS would decide to treat SET_STATUS(0) not as equivalent or
>>>> a superset of RESET_DEVICE.  I may be wrong, and this might explain a whole
>>>> deal about what kind of background operations we hope to stop with
>>>> SET_STATUS(0).
>>> I would like vhost-user devices to implement SET_STATUS according to the
>>> VIRTIO specification in the future and they can do that. But I think
>>> front-ends should continue sending RESET_DEVICE in order to support old
>>> devices.
>> Well, yes, exactly.  That is what I meant to address with this patch,
>> vhost-user right now does not send RESET_DEVICE in its vhost_reset_status
>> implementation, so the front-end will not fall back to RESET_DEVICE when it
>> apparently does intend to reset the device[1].  We do arguably have
>> vhost_reset_device, too, but for vDPA that is just a SET_STATUS(0) (there is
>> no RESET_DEVICE on vDPA), and it’s also only called by vhost-user-scsi.
>>
>> So this also begs the question why we even do have vhost_reset_status and
>> vhost_reset_device as two separate things. The commit introducing
>> vhost_reset_status (c3716f260bf) doesn’t say.  Maybe the intention was that
>> vhost_reset_device would leave the status at 0, while vhost_reset_status
>> would return it to ACKNOWLEDGE | DRIVER, as done by the introducing commit,
>> but that comes back to patch 5 in this series – we don’t need to have
>> ACKNOWLEDGE | DRIVER set after vhost_dev_stop(), so we don’t need
>> vhost_reset_status to set those flags.  They should be set in
>> vhost_dev_start().
>>
>> [1] This is assuming that SET_STATUS(0) is intended to reset the device, but
>> it sounds like you agree on that.
> I don't know the answers, but I think it's safe to go ahead with a
> SET_STATUS sequence that follows the VIRTIO spec, plus a
> VHOST_USER_RESET_DEVICE/VHOST_USER_RESET_OWNER.

So what you’re saying is that RESET_DEVICE/RESET_OWNER should not be 
fallbacks, but be invoked in addition to SET_STATUS(0)?

If so, that would be silly.  I see your point that DPDK resets only in 
response to RESET_DEVICE/RESET_OWNER, but the diagnostics agree that 
SET_STATUS(0) is a reset, which is why I find this so silly. It sounds 
to me as if any properly behaving implementation would fully reset the 
back-end on SET_STATUS(0), so unconditionally invoking 
RESET_DEVICE/RESET_OWNER afterwards is just doing a double-reset.

Notably, invoking RESET_DEVICE/RESET_OWNER in addition to SET_STATUS(0) 
(instead of as a fallback) would be a change in behavior, because we do 
not call RESET_DEVICE/RESET_OWNER outside of vhost-user-scsi today.

Hanna


