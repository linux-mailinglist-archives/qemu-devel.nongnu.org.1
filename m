Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E9375C9A9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMqvd-0001dO-1w; Fri, 21 Jul 2023 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMqvZ-0001d2-RG
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMqvW-00036L-FW
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689948972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RQVao7uzHl1lmn8108C5S0kYIBMcSw50IckzF/W1g0=;
 b=YhgKxn7dW1YO57lxsAl+SbqKPwjuz49k4RQJWtHfH2mle7r+p0prsSE5GG2OJgE3FhmlKc
 yR5GXaumZVUFMDxfceBpiYeq8F+ozNuX06fv25N8b0tLqjUQfTSnUpe9TxllGhUtz9eMRz
 p9Pkiwm+GlYgzIGsmGlTdJAbqnRHmHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-QHBrUddCPqeT_Ww1BXYrAw-1; Fri, 21 Jul 2023 10:16:10 -0400
X-MC-Unique: QHBrUddCPqeT_Ww1BXYrAw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-97542592eb9so125503866b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689948969; x=1690553769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RQVao7uzHl1lmn8108C5S0kYIBMcSw50IckzF/W1g0=;
 b=fVaEJYWEfY8VWW+/nXgpvahHUbSDHODRDYnifm97S9bHGp7qC9ko2pX5ljc8xkI/Kn
 8JVaTAjkRXEFNMdvmGKTz1WFgGKQE0gIDhTe800rTDnbSQp6HAVAmeoEaQzdF3wQbwYM
 yLQ8aGFFpWf220A/K29PY2S9LMilnWTpv0jAXDiBk9ESXhGvRIolJ5FAYngIhTT46dSa
 ri1DQYb5QTB0P13EyhasQ2hDJCLKq59IbYEbOThnzRDu+IHNZo32uXwMAeQkaY4sKmuV
 q6Yv4qsjiL6RvoWzNe+gRwOqDbTRp9Jj7xclPhuYYE4dvCjELR6QRl0jvMxKOoIsi/s+
 DE1w==
X-Gm-Message-State: ABy/qLYca7GeivtK8uw2ecibAIN51F3pdT6WcYlem40i/4hARwbCFB70
 4bZD0m0qkCNK8r2Iam5fXHQBEQ9ZSDrNCtXvNbYqQynPCiMKWLzICu/ScBxu1QP0Ta8HdynasVZ
 jymO3bWSCssbLGPM=
X-Received: by 2002:a17:906:5192:b0:993:f349:c98e with SMTP id
 y18-20020a170906519200b00993f349c98emr1821018ejk.2.1689948969459; 
 Fri, 21 Jul 2023 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmSXxRne/LJaXEVJTNFEYYKyswBbNFsv4uME4rsFKXUGRAKpmfS23FRqnF/zJFDWFs/2DTMg==
X-Received: by 2002:a17:906:5192:b0:993:f349:c98e with SMTP id
 y18-20020a170906519200b00993f349c98emr1821001ejk.2.1689948969117; 
 Fri, 21 Jul 2023 07:16:09 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a17090634c800b0099297c99314sm2239195ejb.113.2023.07.21.07.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 07:16:08 -0700 (PDT)
Message-ID: <269831fe-e237-e28a-a74c-68a6d8fede7b@redhat.com>
Date: Fri, 21 Jul 2023 16:16:07 +0200
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
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230720160300.GG184015@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 20.07.23 18:03, Stefan Hajnoczi wrote:
> On Wed, Jul 19, 2023 at 04:27:58PM +0200, Hanna Czenczek wrote:
>> On 19.07.23 16:11, Hanna Czenczek wrote:
>>> On 18.07.23 17:10, Stefan Hajnoczi wrote:
>>>> On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
>>>>> The only user of vhost_user_reset_status() is vhost_dev_stop(), which
>>>>> only uses it as a fall-back to stop the back-end if it does not support
>>>>> SUSPEND.  However, vhost-user's implementation is a no-op unless the
>>>>> back-end supports SET_STATUS.
>>>>>
>>>>> vhost-vdpa's implementation instead just calls
>>>>> vhost_vdpa_reset_device(), implying that it's OK to fully reset the
>>>>> device if SET_STATUS is not supported.
>>>>>
>>>>> To be fair, vhost_vdpa_reset_device() does nothing but to set
>>>>> the status
>>>>> to zero.  However, that may well be because vhost-vdpa has no method
>>>>> besides this to reset a device.  In contrast, vhost-user has
>>>>> RESET_DEVICE and a RESET_OWNER, which can be used instead.
>>>>>
>>>>> While it is not entirely clear from documentation or git logs, from
>>>>> discussions and the order of vhost-user protocol features, it
>>>>> appears to
>>>>> me as if RESET_OWNER originally had no real meaning for vhost-user, and
>>>>> was thus used to signal a device reset to the back-end.  Then,
>>>>> RESET_DEVICE was introduced, to have a well-defined dedicated reset
>>>>> command.  Finally, vhost-user received full STATUS support, including
>>>>> SET_STATUS, so setting the device status to 0 is now the preferred way
>>>>> of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
>>>>> remain valid as fall-backs.
>>>>>
>>>>> Therefore, have vhost_user_reset_status() fall back to
>>>>> vhost_user_reset_device() if the back-end has no STATUS support.
>>>>>
>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>> ---
>>>>>    hw/virtio/vhost-user.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>>> index 4507de5a92..53a881ec2a 100644
>>>>> --- a/hw/virtio/vhost-user.c
>>>>> +++ b/hw/virtio/vhost-user.c
>>>>> @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct
>>>>> vhost_dev *dev)
>>>>>        if (virtio_has_feature(dev->protocol_features,
>>>>>                               VHOST_USER_PROTOCOL_F_STATUS)) {
>>>>>            vhost_user_set_status(dev, 0);
>>>>> +    } else {
>>>>> +        vhost_user_reset_device(dev);
>>>>>        }
>>>>>    }
>>>> Did you check whether DPDK treats setting the status to 0 as equivalent
>>>> to RESET_DEVICE?
>>> If it doesn’t, what’s even the point of using reset_status?
>> Sorry, I’m being unclear, and I think this may be important because it ties
>> into the question from patch 1, what qemu is even trying to do by running
>> SET_STATUS(0) vhost_dev_stop(), so here’s what gave me the impression that
>> SET_STATUS(0) and RESET_DEVICE should be equivalent:
>>
>> vhost-vdpa.c runs SET_STATUS(0) in a function called
>> vhost_vdpa_reset_device().  This is one thing that gave me the impression
>> that this is about an actual full reset.
>>
>> Another is the whole discussion that we’ve had.  vhost_dev_stop() does not
>> call a `vhost_reset_device()` function, it calls `vhost_reset_status()`.
>> Still, we were always talking about resetting the device.
> There is some hacky stuff with struct vhost_dev's vq_index_end and
> multi-queue devices. I think it's because multi-queue vhost-net device
> consist of many vhost_devs and NetClientStates, so certain vhost
> operations are skipped unless this is the "first" or "last" vhost_dev
> from a large aggregate vhost-net device. That might be responsible for
> part of the weirdness.
>
>> It doesn’t make sense to me that vDPA would provide no function to fully
>> reset a device, while vhost-user does.  Being able to reset a device sounds
>> vital to me.  This also gave me the impression that SET_STATUS(0) on vDPA at
>> least is functionally equivalent to a full device reset.
>>
>>
>> Maybe SET_STATUS(0) does mean a full device reset on vDPA, but not on
>> vhost-user.  That would be a real shame, so I assumed this would not be the
>> case; that SET_STATUS(0) does the same thing on both protocols.
> Yes, exactly. It has the real VIRTIO spec meaning in vDPA. In vhost-user
> it's currently only used by DPDK as a hint for when device
> initialization is complete:
> https://github.com/DPDK/dpdk/commit/41d201804c4c44738168e2d247d3b1780845faa1

FWIW, now the code is a bit different. 
https://github.com/DPDK/dpdk/commit/671cc679a5fcd26705bb20ddc13b93e665719054 
has added a RESET interpretation for the status field, i.e. when it is 
0.  It doesn’t do anything, but at least DPDK seems to agree that 
SET_STATUS(0) is a reset.

>> The virtio specification says “Writing 0 into this field resets the device.”
>> about the device_status field.
>>
>> This also makes sense, because the device_status field is basically used to
>> tell the device that a driver has taken control.  If reset, this indicates
>> the driver has given up control, and to me this is a point where a device
>> should fully reset itself.
>>
>> So all in all, I can’t see the rationale why any implementation that
>> supports SET_STATUS would decide to treat SET_STATUS(0) not as equivalent or
>> a superset of RESET_DEVICE.  I may be wrong, and this might explain a whole
>> deal about what kind of background operations we hope to stop with
>> SET_STATUS(0).
> I would like vhost-user devices to implement SET_STATUS according to the
> VIRTIO specification in the future and they can do that. But I think
> front-ends should continue sending RESET_DEVICE in order to support old
> devices.

Well, yes, exactly.  That is what I meant to address with this patch, 
vhost-user right now does not send RESET_DEVICE in its 
vhost_reset_status implementation, so the front-end will not fall back 
to RESET_DEVICE when it apparently does intend to reset the device[1].  
We do arguably have vhost_reset_device, too, but for vDPA that is just a 
SET_STATUS(0) (there is no RESET_DEVICE on vDPA), and it’s also only 
called by vhost-user-scsi.

So this also begs the question why we even do have vhost_reset_status 
and vhost_reset_device as two separate things. The commit introducing 
vhost_reset_status (c3716f260bf) doesn’t say.  Maybe the intention was 
that vhost_reset_device would leave the status at 0, while 
vhost_reset_status would return it to ACKNOWLEDGE | DRIVER, as done by 
the introducing commit, but that comes back to patch 5 in this series – 
we don’t need to have ACKNOWLEDGE | DRIVER set after vhost_dev_stop(), 
so we don’t need vhost_reset_status to set those flags.  They should be 
set in vhost_dev_start().

[1] This is assuming that SET_STATUS(0) is intended to reset the device, 
but it sounds like you agree on that.


