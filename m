Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C510EA9B3E8
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 18:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zNN-0000XM-4x; Thu, 24 Apr 2025 12:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7zNK-0000Wz-G6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7zNI-0000lS-2i
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745511868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZM/STMxL2WS/K9Z6CXYQ+vohEAjByS0/dY50BlCMnPE=;
 b=UJsMnPbxP2Ebfzh/T2FVs+7oTqlVJaU75nntE8e59gKY7NXgH4s9uLVP0JqWuqqcf48oke
 8VkqDdMR/5qIbvnZoFwQXvOCV6lVBOasu6z3GuOjaQ0lwCcuv5MEH3U+cFPhQn3rJ+wtKD
 vKZdU+UgLNjpu/HcA0h5UqJ4XAnOzKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-KXlM0f3INnGLBpWrFRO35A-1; Thu, 24 Apr 2025 12:24:27 -0400
X-MC-Unique: KXlM0f3INnGLBpWrFRO35A-1
X-Mimecast-MFC-AGG-ID: KXlM0f3INnGLBpWrFRO35A_1745511866
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so6680935e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 09:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745511865; x=1746116665;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZM/STMxL2WS/K9Z6CXYQ+vohEAjByS0/dY50BlCMnPE=;
 b=kaIe93Yqd6KRjuMRHhPmHTMDBuZqyOQA9LfjbkoG84NReBWB8cH2tLnw0k7vzC7rpa
 keU9rFO70600N7/QVRggf/weCUAVYGdkR9aGwXpvGWXHz2EfVHEd4KWsXbKz8qcCRTkU
 aI72bdPuCM1WNTfV6/LZfhBpxTy/62ioFj+r3/RxAN2AwhUnUbmVdYJ0EXuCvLtXGua+
 HZirYqk12MIo0vA9j6HBJcTK3c9Tuk/c5yiKNEAgAEpjGrMkxXvZzpyTZiFQ+ohQfC01
 6f21Uvtq0enOfRdMAWPzIPQRg77LAXVzKcQZt34jdJK7RLEMc6pwb+bf4SvzDifCS63P
 GWuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVzi0U//8s4s0AeOai+SlVkXmbEXzAQkHuTRmOVcASPbrgDif8b2zTK2A2Vd6t/Ha/ELs828J9H9ml@nongnu.org
X-Gm-Message-State: AOJu0YwtXfAc3AYJMq2r+KJjV2fhk6Xg6w0zIjiJWDqHnWKLq7QhFpGE
 FztVTC54JgB3u4RCvdNQnQ2afItlD3vvFLhJh1tyZrUN4B5C/8iH65gdhz9MpVyASFiPDaWRuNU
 pCJBxmvbYMtYZNSDexCS82Z0+Ac39FOFh/AQsrmWHLzw3yEEk/l7bVtK2O/tG
X-Gm-Gg: ASbGnctdBV/DpVZBzTXeagcLA7vmhG0hdWosT8Gu+UUd97wPTChHwkMna1Tan9UDYVq
 ca/p1a3Qa2Tme7h1yu4oUx9WF0rqz60cl7PxFwLphkGve5QOS9VWSY7P98hELusHfr5pbBOmb/0
 mFvYcng2y4f25DEn7dxSwfsuFMIIi2A2zwd/T6QhC2W2YihQqtvKVbNAGu/ZnBZ9biQZU6oY0R9
 1kizDuzRazr7O3OWLEMpXstWuyiFE7mzfw8FU8gCGlWlqo7R/LmlV7mNn4a9c/1BvJ+8MWuNb8b
 mCQ0JaDR0XvStCwV9KxKcXC8ELECbeQgX4oE9XqNiCoRE4Q=
X-Received: by 2002:a05:6000:2508:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3a06cfa2dcemr2623004f8f.39.1745511864997; 
 Thu, 24 Apr 2025 09:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyD1TBIRzl7YthoMNAowJ0BKIgSUrZBs7Oh3LdUGkZuxSYy/FscdxJ8/RoN4IWeRGpSF665g==
X-Received: by 2002:a05:6000:2508:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3a06cfa2dcemr2622980f8f.39.1745511864628; 
 Thu, 24 Apr 2025 09:24:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4c565esm2643239f8f.56.2025.04.24.09.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 09:24:24 -0700 (PDT)
Message-ID: <e58eb220-f371-423c-a3e3-c905be6752f8@redhat.com>
Date: Thu, 24 Apr 2025 18:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] vfio/container: pass listener_begin/commit callbacks
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-6-john.levon@nutanix.com>
 <5d87f16c-6e67-42f3-864c-e4e134816d70@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <5d87f16c-6e67-42f3-864c-e4e134816d70@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/23/25 15:45, Cédric Le Goater wrote:
> On 4/9/25 15:48, John Levon wrote:
>> The vfio-user container will later need to hook into these callbacks;
>> set up vfio to use them, and optionally pass them through to the
>> container.
>>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
>> ---
>>   hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-container-base.h |  2 ++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 285ca97a8c..9ffc2deb2d 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -412,6 +412,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
>>       return true;
>>   }
>> +static void vfio_listener_begin(MemoryListener *listener)
>> +{
>> +    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>> +                                                 listener);
>> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
>> +
>> +    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
>> +
>> +    if (listener_begin) {
>> +        listener_begin(bcontainer);
>> +    }
>> +}
>> +
>> +static void vfio_listener_commit(MemoryListener *listener)
>> +{
>> +    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>> +                                                 listener);
>> +    void (*listener_commit)(VFIOContainerBase *bcontainer);
>> +
>> +    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
>> +
>> +    if (listener_commit) {
>> +        listener_commit(bcontainer);
>> +    }
>> +}
>> +
>>   static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
>>   {
>>       /*
>> @@ -1166,6 +1192,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>>   static const MemoryListener vfio_memory_listener = {
>>       .name = "vfio",
>> +    .begin = vfio_listener_begin,
>> +    .commit = vfio_listener_commit,
>>       .region_add = vfio_listener_region_add,
>>       .region_del = vfio_listener_region_del,
>>       .log_global_start = vfio_listener_log_global_start,
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index a441932be7..67373e8db0 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -120,6 +120,8 @@ struct VFIOIOMMUClass {
>>       /* basic feature */
>>       bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
>> +    void (*listener_begin)(VFIOContainerBase *bcontainer);
>> +    void (*listener_commit)(VFIOContainerBase *bcontainer);
> 
> Please add documentation for the new callbacks.
and it is not used in this series yet. So we can keep it for later.

Thanks,

C.



