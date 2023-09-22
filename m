Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D07AAE59
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjccQ-0005jo-66; Fri, 22 Sep 2023 05:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qjccO-0005j9-E0
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qjccM-0004RO-Ab
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWz9AMt7i79laTlJdoBDLJ7470F3AAtN+aWL3jQtA/Y=;
 b=c5pzq8SKqcofZK3YFiZxPKl6fTiwGdistsXkV0donPK9Lc0E/W0g4Wb2F5+bzeYIyrK0z9
 4cwRUIvbBBkVfAVIJM4/EKalvn4NPe21kHpst9DHutWKoNjG6ItdL0nijtHOnTN+Fz4D68
 yCFfvJwE/KeiyiazepCiTkcGUtXiuPQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-uSNc0tx9P_iaSVb6JnivqQ-1; Fri, 22 Sep 2023 05:38:31 -0400
X-MC-Unique: uSNc0tx9P_iaSVb6JnivqQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402cba95486so15039095e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375510; x=1695980310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWz9AMt7i79laTlJdoBDLJ7470F3AAtN+aWL3jQtA/Y=;
 b=Fo3oFmbSoW50NMhE3dLgA0/7lXHTplonZfNykAXQDmp3fSqPeEQVav8ngEKbhmfKYM
 am2ONhw7dI/Nv55Gf3G2vdAyZx5O7sYVlsP4wK8JhUjYW/yv3wTXmpZMQjBb/EtEfquu
 RRUE/gQpTqFl+VIFhf+JHB0PO7US4m4vfLkBMNesDNH8vUcNNiTuOrotuYXpyZVLgZU0
 5SXlZFCmQ/mXYSIpLB+scNK/W2TEMgIX4RF/+EKcQ95RycRg8eW/EaTOmQS8KP/20teu
 qkl8EXOD0kWLgLQkaTuDv21hMg05CVdVRxlaUGRTTLQeCaWojAuM1t0JPX8V/rNtejO1
 vQ4w==
X-Gm-Message-State: AOJu0YwsRofHXq5035j99381wsEYN6ZAhbphar/650QWTrgCU8BRDUjJ
 +PB198uDASlQelVxhoYCRIuc18JpyugBpLh2Umf7TOfqKZWPgI862ipGRb1Or/Kli7pSgBYR4Yz
 dqs6HLWdkL8zJG/A=
X-Received: by 2002:a5d:6592:0:b0:321:52cf:6f9f with SMTP id
 q18-20020a5d6592000000b0032152cf6f9fmr7646272wru.6.1695375510596; 
 Fri, 22 Sep 2023 02:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNc9NPoD2GQeKhjYojo+EPYJvE54zQ91BUM44qiP4V2OggruLKUatk+6yWXPpHjDm16wAdPQ==
X-Received: by 2002:a5d:6592:0:b0:321:52cf:6f9f with SMTP id
 q18-20020a5d6592000000b0032152cf6f9fmr7646255wru.6.1695375510173; 
 Fri, 22 Sep 2023 02:38:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a5d68c2000000b0031431fb40fasm3990614wrw.89.2023.09.22.02.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 02:38:29 -0700 (PDT)
Message-ID: <b138199a-ceaa-4bf9-4d91-50a05ccc3267@redhat.com>
Date: Fri, 22 Sep 2023 11:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] vfio/display: Fix missing update to set backing
 fields
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, kraxel@redhat.com
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230816215550.1723696-1-alex.williamson@redhat.com>
 <a3a6f8ec-ca61-4472-45b4-1077dd27bb52@linaro.org>
 <acddfb4a-fe42-ba8c-e920-edc7e9ff5268@intel.com>
 <CAJ+F1C+YiDgRuyWcGeUPhaNO4SdjOSFSHKBY1wBS3dJFLO-k2w@mail.gmail.com>
 <20230904081129.3908c083.alex.williamson@redhat.com>
 <CAJ+F1CJFiHCu4FTbSFfLgSANiHJHEowJg7Um3j+ZMiHb_S21aQ@mail.gmail.com>
 <20230905090907.2b70b6a0.alex.williamson@redhat.com>
 <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230913131827.3bfe7bcb.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/13/23 21:18, Alex Williamson wrote:
> 
> Hi Gerd,
> 
> Some consultation would be appreciated on this thread to get this patch
> out of limbo.  Is there a better solution that what I've proposed?

This does fix a regression reproducible on systems with an Intel Gen 8,
my T480 laptop for instance.

Tested-by: Cédric Le Goater <clg@redhat.com>

Also, queuing it in vfio-next.

Thanks,

C.


> AFAICT, we don't have position fields to indicate the dmabuf plane is
> relative to some scanout, so I think it represents the entire display.
> Thanks,
> 
> Alex
> 
> On Tue, 5 Sep 2023 09:09:07 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Mon, 4 Sep 2023 21:00:53 +0400
>> Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
>>
>>> Hi
>>>
>>> On Mon, Sep 4, 2023 at 6:11 PM Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>>>
>>>> On Mon, 4 Sep 2023 15:06:21 +0400
>>>> Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
>>>>     
>>>>> Hi
>>>>>
>>>>> On Thu, Aug 17, 2023 at 8:29 PM Kim, Dongwon <dongwon.kim@intel.com> wrote:
>>>>>>
>>>>>> Ok, this regression happened not just because of renaming. Originally
>>>>>> width and height were representing the size of whole surface that guest
>>>>>> shares while scanout width and height are for the each scanout. We
>>>>>> realized backing_width/height are more commonly used to specify the size
>>>>>> of the whole guest surface so put them in the place of width/height then
>>>>>> replaced scanout_width/height as well with normal width/height.
>>>>>>
>>>>>> On 8/16/2023 3:31 PM, Philippe Mathieu-Daudé wrote:
>>>>>>> On 16/8/23 23:55, Alex Williamson wrote:
>>>>>>>> The below referenced commit renames scanout_width/height to
>>>>>>>> backing_width/height, but also promotes these fields in various portions
>>>>>>>> of the egl interface.  Meanwhile vfio dmabuf support has never used the
>>>>>>>> previous scanout fields and is therefore missed in the update. This
>>>>>>>> results in a black screen when transitioning from ramfb to dmabuf
>>>>>>>> display
>>>>>>>> when using Intel vGPU with these features.
>>>>>>>
>>>>>>> Referenced commit isn't trivial. Maybe because it is too late here.
>>>>>>> I'd have tried to split it. Anyhow, too late (again).
>>>>>>>
>>>>>>> Is vhost-user-gpu also affected? (see VHOST_USER_GPU_DMABUF_SCANOUT
>>>>>>> in vhost_user_gpu_handle_display()).
>>>>>>
>>>>>> Yeah, backing_width/height should be programmed with plane.width/height
>>>>>> as well in vhost_user_gpu_handle_display().
>>>>>>
>>>>>> Link: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg02726.html
>>>>>>>> Fixes: 9ac06df8b684 ("virtio-gpu-udmabuf: correct naming of
>>>>>>>> QemuDmaBuf size properties")
>>>>>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> This fixes a regression in dmabuf/EGL support for Intel GVT-g and
>>>>>>>> potentially the mbochs mdev driver as well.  Once validated by those
>>>>>>>> that understand dmabuf/EGL integration, I'd welcome QEMU maintainers to
>>>>>>>> take this directly for v8.1 or queue it as soon as possible for v8.1.1.
>>>>>>>>
>>>>>>>>    hw/vfio/display.c | 2 ++
>>>>>>>>    1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>>>>>>>> index bec864f482f4..837d9e6a309e 100644
>>>>>>>> --- a/hw/vfio/display.c
>>>>>>>> +++ b/hw/vfio/display.c
>>>>>>>> @@ -243,6 +243,8 @@ static VFIODMABuf
>>>>>>>> *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
>>>>>>>>        dmabuf->dmabuf_id  = plane.dmabuf_id;
>>>>>>>>        dmabuf->buf.width  = plane.width;
>>>>>>>>        dmabuf->buf.height = plane.height;
>>>>>>
>>>>>> One thing to note here is the normal width and height in the QemuDmaBuf
>>>>>> are of a scanout, which could be just a partial area of the guest plane
>>>>>> here. So we should not use those as normal width and height of the
>>>>>> QemuDmaBuf unless it is guaranteed the given guest surface (plane in
>>>>>> this case) is always of single display's.
>>>>>>
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2021-09/msg04737.html
>>>>>>     
>>>>>>>> +    dmabuf->buf.backing_width = plane.width;
>>>>>>>> +    dmabuf->buf.backing_height = plane.height;
>>>>>>>>        dmabuf->buf.stride = plane.stride;
>>>>>>>>        dmabuf->buf.fourcc = plane.drm_format;
>>>>>>>>        dmabuf->buf.modifier = plane.drm_format_mod;
>>>>>>>     
>>>>>>     
>>>>>
>>>>> I agree with what Kim said. Alex, are you sending a new patch?
>>>>
>>>> What would be different?
>>>>
>>>> struct vfio_device_gfx_plane_info {
>>>>          __u32 argsz;
>>>>          __u32 flags;
>>>> #define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
>>>> #define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
>>>> #define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
>>>>          /* in */
>>>>          __u32 drm_plane_type;   /* type of plane: DRM_PLANE_TYPE_* */
>>>>          /* out */
>>>>          __u32 drm_format;       /* drm format of plane */
>>>>          __u64 drm_format_mod;   /* tiled mode */
>>>>          __u32 width;    /* width of plane */
>>>>          __u32 height;   /* height of plane */
>>>>          __u32 stride;   /* stride of plane */
>>>>          __u32 size;     /* size of plane in bytes, align on page*/
>>>>          __u32 x_pos;    /* horizontal position of cursor plane */
>>>>          __u32 y_pos;    /* vertical position of cursor plane*/
>>>>          __u32 x_hot;    /* horizontal position of cursor hotspot */
>>>>          __u32 y_hot;    /* vertical position of cursor hotspot */
>>>>          union {
>>>>                  __u32 region_index;     /* region index */
>>>>                  __u32 dmabuf_id;        /* dma-buf id */
>>>>          };
>>>> };
>>>>     
>>>
>>> Perhaps VFIO is missing extra infos to set the actual x/y/w/h
>>> region(s) of the visible monitor(s). This could be an extra message. I
>>> am not familiar with the kernel/driver side for this, perhaps it is
>>> always guaranteed to be the whole plane (+0+0+w*h). In which case, we
>>> simply to set the QemuDmabuf fields accordingly.
>>
>> Isn't that what the proposed patch does?  Gerd is likely going to need
>> to chime in for any sort of authoritative answer.  Gerd?  Thanks,
>>
>> Alex
> 
> 


