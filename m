Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10139746B2D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:53:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaqP-0008BJ-9I; Tue, 04 Jul 2023 03:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaqC-0008BA-Bl
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qGaqA-0005nn-7I
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa4sQrjdPwP5U9xOPJ+wH7QAEqB42v42e+4+gjHcmTU=;
 b=Y+KsCLGnIFzL8dsahoVpJo1oM7QuriPYZqBAaZysXakjn5orxCm7n7l+pLJinWoc24SBix
 AlJyHsJhhDe9s1D9ArE46oT0FTCr+EEE1pvCLlFgPuPgT1ohccsXZCF4VO2IW2qT68zVxp
 EdhRQ05aAkhlNhfSwLX1j18u5XKVtPQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-58QFoYRNO225deV-0mLEOQ-1; Tue, 04 Jul 2023 03:52:48 -0400
X-MC-Unique: 58QFoYRNO225deV-0mLEOQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635e0028b24so44255526d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457167; x=1691049167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oa4sQrjdPwP5U9xOPJ+wH7QAEqB42v42e+4+gjHcmTU=;
 b=BjiHQnD3mh90XCmjTAmLQnX25LiNPJm7jl9UzvMaorJqYe++l4vEMLz76DkJ8msSzp
 jeRxQRN2iqF85wJHAUE0KEWGBY4ozji7DMwtZBewiNjJIJrNQqolToKLam5Ol/vhQ84w
 mFVmDqr3vI7VBNOGXbjwVina4grS+EW6Bv/wNIF4ErO3b4tgqoYXd2zKwI6qlHEd+lcQ
 O9Ec1FepDSjMJJpbkjTJw6a3sH9TgGCiYykV7YPCx/uOPqSu0VBojgR7Fw6Mmmh5qFQe
 nkJxdpX/vHMZRvMYdsKNtc5b+LRrl8GrjmPyQVJjFgskZXPIgt3OAownXNhfxddUi/YL
 EE5g==
X-Gm-Message-State: ABy/qLae2Ug65r8AzyzwQWU3H3OxLGKzC33lbKqnGgC7uPsTlevJ/Lax
 k6X+JcXiGyXTNJjMHXLN3Iku02r07aysyC48NizbyqZVvPIGHtsINCo6hX7XfWWiV+KZSpaRJ70
 ER4t6b0w0IHkZoMY=
X-Received: by 2002:a05:6214:e87:b0:636:2fce:b281 with SMTP id
 hf7-20020a0562140e8700b006362fceb281mr15087200qvb.65.1688457167731; 
 Tue, 04 Jul 2023 00:52:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpG14iQRLPl+IraOj6JJLNBNuVvsahmuYzq3yXAloNDZsfByJAn0jNRRieIS663pBw23Q0cg==
X-Received: by 2002:a05:6214:e87:b0:636:2fce:b281 with SMTP id
 hf7-20020a0562140e8700b006362fceb281mr15087186qvb.65.1688457167510; 
 Tue, 04 Jul 2023 00:52:47 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 q3-20020ad44023000000b00630164a9992sm12277811qvp.73.2023.07.04.00.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:52:47 -0700 (PDT)
Message-ID: <1b4b4b84-1502-9d9f-f366-432a0c741908@redhat.com>
Date: Tue, 4 Jul 2023 09:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/1] vhost-vdpa: mute unaligned memory error report
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eric.auger@redhat.com, Peter Xu <peterx@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, mst@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org
References: <20230704071931.575888-1-lvivier@redhat.com>
 <20230704071931.575888-2-lvivier@redhat.com>
 <e7413571-9807-0e1c-5580-989ce9fb4845@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <e7413571-9807-0e1c-5580-989ce9fb4845@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/4/23 09:25, David Hildenbrand wrote:
> On 04.07.23 09:19, Laurent Vivier wrote:
>> With TPM CRM device, vhost-vdpa reports an error when it tries
>> to register a listener for a non aligned memory region:
>>
>>    qemu-system-x86_64: vhost_vdpa_listener_region_add received unaligned region
>>    qemu-system-x86_64: vhost_vdpa_listener_region_del received unaligned region
>>
>> This error can be confusing for the user whereas we only need to skip
>> the region (as it's already done after the error_report())
>>
>> Rather than introducing a special case for TPM CRB memory section
>> to not display the message in this case, simply replace the
>> error_report() by a trace function (with more information, like the
>> memory region name).
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hw/virtio/trace-events | 2 ++
>>   hw/virtio/vhost-vdpa.c | 8 ++++++--
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 8f8d05cf9b01..9b0d643b9475 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -34,7 +34,9 @@ vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t 
>> asid, uint64_
>>   vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t 
>> iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" 
>> iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
>>   vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  
>> "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>>   vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p 
>> fd: %d msg_type: %"PRIu32" type: %"PRIu8
>> +vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, 
>> uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" 
>> offset_within_region %"PRIu64
>>   vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, 
>> bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
>> +vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, 
>> uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" 
>> offset_within_region %"PRIu64
>>   vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend) "vdpa: %p 
>> iova 0x%"PRIx64" llend 0x%"PRIx64
>>   vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
>>   vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3c575a9a6e9e..24d32f0d3728 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -323,7 +323,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>       if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>>                    (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> -        error_report("%s received unaligned region", __func__);
>> +        trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->name,
>> +                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
>> +                       section->offset_within_region & ~TARGET_PAGE_MASK);
>>           return;
>>       }
>> @@ -405,7 +407,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>       if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>>                    (section->offset_within_region & ~TARGET_PAGE_MASK))) {
>> -        error_report("%s received unaligned region", __func__);
>> +        trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->name,
>> +                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
>> +                       section->offset_within_region & ~TARGET_PAGE_MASK);
>>           return;
>>       }
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 
> Do we also want to touch the vfio side in vfio_listener_valid_section(), or why is that 
> one unaffected?
> 

I don't know if we can apply the same solution for VFIO.
I don't know if the error message is relevant or if we can keep only the trace and remove 
the error_report() for all the cases (in this case vfio_known_safe_misalignment() becomes 
useless).

Thanks,
Laurent


