Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37882746A9D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaQE-0005ej-2i; Tue, 04 Jul 2023 03:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaPz-0005eP-PU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaPy-0000BF-1d
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688455544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wazLsigdnbAxRh0ZWsMpOIb61pDWO1lT+7JdpjaQEs=;
 b=UbbnuaNV6w4AHWM04q24fUlYoQySD/H3a3tiRQgEsva9qGYjs42jh3bUP2rq6/J/5qvDM8
 pBEXXCXoaVSUJkDqcCHB4Yp/fQCWHG3DW74bIfPolpiAwItuEHYT1gl+4+16vGZ3Dqt1Dg
 004TKOdmKvLV9H/VEx4RiltjSBqsEsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-BFMXCqx1N5i6Q7ec3qiGrA-1; Tue, 04 Jul 2023 03:25:43 -0400
X-MC-Unique: BFMXCqx1N5i6Q7ec3qiGrA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so31970035e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688455542; x=1691047542;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wazLsigdnbAxRh0ZWsMpOIb61pDWO1lT+7JdpjaQEs=;
 b=A/9RqsNHr0mnvsO6mPqHzPYMzopq5+AHMqKxazAfbV8nKaRdp7zSQ8Z8ijKbZOZWuj
 I+h87B2Om9MqXnIseARAqqrt33zCnrY2XE7kFhmpaHaT7IAMRK/G4TR967zB42p+2Ij5
 gYxPJA8rSF95GO3GeGr88evDr9louS0T1oxKSuhRPBYmG7J7uP+6Xk3WO/AocnzVxhEl
 +MJ8R3oQUFEyyO8TM7Ob9wOlKAm/fxiMiVwg2e6zGDQhRhmBGz9REXVF2a/GfiJxAg3H
 c9pl06bxtIO4pdG21GYFbFwcgOtn/LBx4XImdFeaELX8gNcHF6zKfrL0egH2jr/+fGHz
 l7dw==
X-Gm-Message-State: AC+VfDx2I8nggOnZkXUpMxag4f/IpuA/Z7qRmHnMZYPJg/92NyIwIzOG
 +BE5qMZRLu6wp3iOug/IfaPfroTtpT0ka5s9TowaqSJGpNQTgsHb+t8uhboaXQ2qaS2paWi/1e6
 esnV4HDR0tQnN4KQ=
X-Received: by 2002:a7b:c38f:0:b0:3fb:a46c:7eac with SMTP id
 s15-20020a7bc38f000000b003fba46c7eacmr11073383wmj.7.1688455542484; 
 Tue, 04 Jul 2023 00:25:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SY/LxCv3Ct0EhoAWXHUfKdaZDKZl3posLFzFDwdKW0iW+7Qp5ky4eeTJzhqoKPIlRchpb4w==
X-Received: by 2002:a7b:c38f:0:b0:3fb:a46c:7eac with SMTP id
 s15-20020a7bc38f000000b003fba46c7eacmr11073365wmj.7.1688455542151; 
 Tue, 04 Jul 2023 00:25:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a056000050b00b003110dc7f408sm27700004wrf.41.2023.07.04.00.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:25:41 -0700 (PDT)
Message-ID: <e7413571-9807-0e1c-5580-989ce9fb4845@redhat.com>
Date: Tue, 4 Jul 2023 09:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/1] vhost-vdpa: mute unaligned memory error report
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eric.auger@redhat.com, Peter Xu <peterx@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, mst@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 peter.maydell@linaro.org
References: <20230704071931.575888-1-lvivier@redhat.com>
 <20230704071931.575888-2-lvivier@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230704071931.575888-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 04.07.23 09:19, Laurent Vivier wrote:
> With TPM CRM device, vhost-vdpa reports an error when it tries
> to register a listener for a non aligned memory region:
> 
>    qemu-system-x86_64: vhost_vdpa_listener_region_add received unaligned region
>    qemu-system-x86_64: vhost_vdpa_listener_region_del received unaligned region
> 
> This error can be confusing for the user whereas we only need to skip
> the region (as it's already done after the error_report())
> 
> Rather than introducing a special case for TPM CRB memory section
> to not display the message in this case, simply replace the
> error_report() by a trace function (with more information, like the
> memory region name).
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/trace-events | 2 ++
>   hw/virtio/vhost-vdpa.c | 8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8f8d05cf9b01..9b0d643b9475 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -34,7 +34,9 @@ vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_
>   vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
>   vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>   vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> +vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
>   vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" vaddr: %p read-only: %d"
> +vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint64_t offset_as, uint64_t offset_page) "vdpa: %p region %s offset_within_address_space %"PRIu64" offset_within_region %"PRIu64
>   vhost_vdpa_listener_region_del(void *vdpa, uint64_t iova, uint64_t llend) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64
>   vhost_vdpa_add_status(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
>   vhost_vdpa_init(void *dev, void *vdpa) "dev: %p vdpa: %p"
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3c575a9a6e9e..24d32f0d3728 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -323,7 +323,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>   
>       if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>                    (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> -        error_report("%s received unaligned region", __func__);
> +        trace_vhost_vdpa_listener_region_add_unaligned(v, section->mr->name,
> +                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
> +                       section->offset_within_region & ~TARGET_PAGE_MASK);
>           return;
>       }
>   
> @@ -405,7 +407,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>   
>       if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
>                    (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> -        error_report("%s received unaligned region", __func__);
> +        trace_vhost_vdpa_listener_region_del_unaligned(v, section->mr->name,
> +                       section->offset_within_address_space & ~TARGET_PAGE_MASK,
> +                       section->offset_within_region & ~TARGET_PAGE_MASK);
>           return;
>       }
>   

Reviewed-by: David Hildenbrand <david@redhat.com>


Do we also want to touch the vfio side in vfio_listener_valid_section(), 
or why is that one unaffected?

-- 
Cheers,

David / dhildenb


