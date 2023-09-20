Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFB7A8AB6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 19:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj19J-0004eN-2f; Wed, 20 Sep 2023 13:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qj19H-0004eE-BN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qj19F-0001rz-FU
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695231479;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xz+jdb0q3rJXT03TxCoaPJGJV77+g+YqAuP5CtDNRmg=;
 b=Fy/44vuMQDHnUJWayMe6FZa8Fe+3hUNFoo4bSqzV1Wy3hU6/yWA+AZozy2fkPUjs/lw8c1
 1LIHGE6OUBByBzo/RAQyrcx5kgyTF6J2+tSeJHEnwe4Gh36H9f2M3o9KI1X62Gd8V0Te1q
 mwRDrdpzSpvmzR39kfwth6+nr0C+rBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-b_HBtdr3M2W30YvYmDYpDg-1; Wed, 20 Sep 2023 13:37:58 -0400
X-MC-Unique: b_HBtdr3M2W30YvYmDYpDg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-403ca0e2112so737795e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 10:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695231477; x=1695836277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xz+jdb0q3rJXT03TxCoaPJGJV77+g+YqAuP5CtDNRmg=;
 b=fQlsuJXOzsftxJyFcL9Wk5QNzBE7o34SfHBfMxYlwo/14G6AAvWKfDI2fkqGE1/m+v
 98dGXqzlerTKtZp22OihEcb86+KwVyYFzKeGoGLQKYvkddEdg4/JfJzLR/FMixA0fJyR
 zigBmdr9l+1RkmieDZ/I3woK7dGrwID1WPy/tqlKSRHJqSriZuUVBrlg3Ul5XRLFoCW0
 UqxO8yZZCieULHsYQ5rghpFNd8n3bhwsvIPYpZLFGj/dOXh9DPINNKVUjPoY8eaQFDa2
 yFWHvjGJDf6moggoZStnIli0NMxkdsbyOG1/Dkc1fwye4NapqBoL32Slyt9aYcjtR4lQ
 IXWw==
X-Gm-Message-State: AOJu0YyhWqH/S561RB6GzBdUYNzvX09Uf5aB0Rs4EV3ZXl89W8I2V13w
 MV+BT1ifH/ZrNVBjOUDStrcp0flOd1Zx5R1Nz96n04Ms0Z68+ZgQWNjqtZ7r8f9zqfGK9Ebo1jd
 SkQcVa7PHahmbzgk=
X-Received: by 2002:a7b:cd9a:0:b0:3f7:cb42:fa28 with SMTP id
 y26-20020a7bcd9a000000b003f7cb42fa28mr2701660wmj.28.1695231476831; 
 Wed, 20 Sep 2023 10:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWC89XjZrfLrAm+GsYcPPIOIIJKSp3A32HiCt0cEd9AuqyiYlkU6ur4uuzm2VLcmr2Usxflw==
X-Received: by 2002:a7b:cd9a:0:b0:3f7:cb42:fa28 with SMTP id
 y26-20020a7bcd9a000000b003f7cb42fa28mr2701642wmj.28.1695231476527; 
 Wed, 20 Sep 2023 10:37:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b0031ae8d86af4sm19074797wrx.103.2023.09.20.10.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 10:37:55 -0700 (PDT)
Message-ID: <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
Date: Wed, 20 Sep 2023 19:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
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
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/20/23 15:02, Cédric Le Goater wrote:
> On 9/20/23 14:51, Jason Gunthorpe wrote:
>> On Wed, Sep 20, 2023 at 02:19:42PM +0200, Cédric Le Goater wrote:
>>> On 9/20/23 05:42, Duan, Zhenzhong wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>> Sent: Wednesday, September 20, 2023 1:08 AM
>>>>> Subject: Re: [PATCH v1 15/22] Add iommufd configure option
>>>>>
>>>>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>>>>> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
>>>>>> iommufd support, enabled by default.
>>>>>
>>>>> Why would someone want to disable support at compile time ? It might
>>>>
>>>> For those users who only want to support legacy container feature?
>>>> Let me know if you still prefer to drop this patch, I'm fine with
>>>> that.
>>>
>>> I think it is too early.
>>>
>>>>> have been useful for dev but now QEMU should self-adjust at runtime
>>>>> depending only on the host capabilities AFAIUI. Am I missing
>>>>> something ?
>>>>
>>>> IOMMUFD doesn't support all features of legacy container, so QEMU
>>>> doesn't self-adjust at runtime by checking if host supports IOMMUFD.
>>>> We need to specify it explicitly to use IOMMUFD as below:
>>>>
>>>>       -object iommufd,id=iommufd0
>>>>       -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
>>>
>>> OK. I am not sure this is the correct interface yet. At first glance,
>>> I wouldn't introduce a new object for a simple backend depending on a
>>> kernel interface. I would tend to prefer a "iommu-something" property
>>> of the vfio-pci device with string values: "legacy", "iommufd",
>>> "default"
>>> and define the various interfaces (the ops you proposed) for each
>>> depending on the user preference and the capabilities of the host and
>>> possibly the device.
>>
>> I think the idea came from Alex? The major point is to be able to have
>> libvirt open /dev/iommufd and FD pass it into qemu 
>
> ok.
>
>> and then share that single FD across all VFIOs. 
>
> I will ask Alex to help me catch up on the topic.
>
>> qemu will typically not be able to
>> self-open /dev/iommufd as it is root-only.
>
> I don't understand, we open multiple fds to KVM devices. This is the
> same.
Actually qemu opens the /dev/iommu in case no fd is passed along with
the iommufd object. This is done in
[PATCH v1 16/22] backends/iommufd: Introduce the iommufd object, in

iommufd_backend_connect(). I don't understand either.

Thanks

Eric

>
>>
>> So the object is not exactly for the backend, the object is for the
>> file descriptor.
> got it.
>
>>
>> Adding a legacy/iommufd option to the vfio-pci device string doesn't
>> address these needs.
>
> I agree.
>
> Thanks,
>
> C.
>
>> Jason
>>
>


