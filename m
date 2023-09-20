Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F207A8292
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwr1-0005Cs-PD; Wed, 20 Sep 2023 09:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwqz-00055E-Lg
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qiwqw-0007H2-4X
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695214968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p8fjeCRtrttk26v3CVFPuWj/fOzUuo8vYI/PYKK+Q8=;
 b=OgN7Eq/4ozhmVyIXAAMhxN4NQtD0EDJQw49Wq7jm9ZU2srvq2JGDvaWjXuGI3I9Pnrl0NK
 zywCVuEeF3zQjV3gEfI6hSyHzca/iIn73tA8t9boQLj8CgEWJizF5aOgTvuVW9FhVQdDrk
 SJWv9xaERxzP0BV8kZrHdmMB98BCQnU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-sJBHrytmMK6a-LjKI1FtZg-1; Wed, 20 Sep 2023 09:02:47 -0400
X-MC-Unique: sJBHrytmMK6a-LjKI1FtZg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6557c921df1so65153476d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 06:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695214967; x=1695819767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+p8fjeCRtrttk26v3CVFPuWj/fOzUuo8vYI/PYKK+Q8=;
 b=BPpA0x1aNf/l9g5yFLYwt/eaEUnYk9L0nk8v5PYtMNlZhoLXzyxgiawV9VIF2hhPES
 67SDR18tnuvUAeFyJOFlIZk1lrpSwatJ9Ndz+WlX7qJe+4We1/3gJHnT4N16byR0u/QG
 o0ASCI8T3Lv1T6HgiuoHMGCiBOCVf4YgdYYVBI2RvUDLGdpkHFYE6gUVP25NQhFvBC+6
 nuqujg5tFnglyj13ykjZ5qoI6RnyWDLbeaigpZUf3GNn5j+7SJrJp1vs9nMDaX/nQUB5
 juampn8dvPslI/QgjNyTIePDui0sVX8Qgl5hz1qz1gcXAnWgCEzNF4EwooC8X78/V5SD
 gZPA==
X-Gm-Message-State: AOJu0Yx1+cXiFA0zPsn+RePEtXgMWw7JgQ5kZ9irNhWBZGYTKCPj7tvV
 pOLT5Ox07ZOJVNXEiydDCIoT+5kldJVsMnOKS86qQ+bVR++U8jH4aWM0Rd3oxpDUV9u2FNEzkpr
 /lwI8fC+hBhT1b0A=
X-Received: by 2002:a0c:db07:0:b0:651:94b2:8d87 with SMTP id
 d7-20020a0cdb07000000b0065194b28d87mr2071583qvk.6.1695214966691; 
 Wed, 20 Sep 2023 06:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomW/MFAhzox8t6DJXMZmbf7eSjNA9alHu4UHOef//z5b9iBn/YWn4nUb8+YU8SNcEFSS+NA==
X-Received: by 2002:a0c:db07:0:b0:651:94b2:8d87 with SMTP id
 d7-20020a0cdb07000000b0065194b28d87mr2071553qvk.6.1695214966356; 
 Wed, 20 Sep 2023 06:02:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a0cab48000000b006365b23b5dfsm5235185qvb.23.2023.09.20.06.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 06:02:45 -0700 (PDT)
Message-ID: <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
Date: Wed, 20 Sep 2023 15:02:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230920125103.GS13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 9/20/23 14:51, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 02:19:42PM +0200, Cédric Le Goater wrote:
>> On 9/20/23 05:42, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Sent: Wednesday, September 20, 2023 1:08 AM
>>>> Subject: Re: [PATCH v1 15/22] Add iommufd configure option
>>>>
>>>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>>>> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
>>>>> iommufd support, enabled by default.
>>>>
>>>> Why would someone want to disable support at compile time ? It might
>>>
>>> For those users who only want to support legacy container feature?
>>> Let me know if you still prefer to drop this patch, I'm fine with that.
>>
>> I think it is too early.
>>
>>>> have been useful for dev but now QEMU should self-adjust at runtime
>>>> depending only on the host capabilities AFAIUI. Am I missing something ?
>>>
>>> IOMMUFD doesn't support all features of legacy container, so QEMU
>>> doesn't self-adjust at runtime by checking if host supports IOMMUFD.
>>> We need to specify it explicitly to use IOMMUFD as below:
>>>
>>>       -object iommufd,id=iommufd0
>>>       -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
>>
>> OK. I am not sure this is the correct interface yet. At first glance,
>> I wouldn't introduce a new object for a simple backend depending on a
>> kernel interface. I would tend to prefer a "iommu-something" property
>> of the vfio-pci device with string values: "legacy", "iommufd", "default"
>> and define the various interfaces (the ops you proposed) for each
>> depending on the user preference and the capabilities of the host and
>> possibly the device.
> 
> I think the idea came from Alex? The major point is to be able to have
> libvirt open /dev/iommufd and FD pass it into qemu 

ok.

> and then share that single FD across all VFIOs. 

I will ask Alex to help me catch up on the topic.

> qemu will typically not be able to
> self-open /dev/iommufd as it is root-only.

I don't understand, we open multiple fds to KVM devices. This is the same.

> 
> So the object is not exactly for the backend, the object is for the
> file descriptor.
got it.

> 
> Adding a legacy/iommufd option to the vfio-pci device string doesn't
> address these needs.

I agree.

Thanks,

C.

> Jason
> 


