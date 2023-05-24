Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970970EF3D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ilW-0007SG-NU; Wed, 24 May 2023 03:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ilP-0007RZ-7a
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ilM-0006KL-F3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684912703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMdtoctcsWO73vd4RtYmvxNPKdN3z3+rmprdLGh/5oY=;
 b=JPsLq4+7UxDdxaCokoDL7FocCjKtKvM43aUNOH5lVYm6dHA5hDhRCADIlqc+VtSe/ZL/8n
 hZPu9pnT2qt0qR2m3RHQFrS4FYQhWw1bn+8+dtADsibd2Mq7yQpTHne7Wi2GsmF4ewWqV3
 RcAeME5NbW6MMnIfxXMxPJvWUvch8/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ZQbhScg1N4OQAjaw16UEaw-1; Wed, 24 May 2023 03:18:21 -0400
X-MC-Unique: ZQbhScg1N4OQAjaw16UEaw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513f5318ff2so706395a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684912701; x=1687504701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMdtoctcsWO73vd4RtYmvxNPKdN3z3+rmprdLGh/5oY=;
 b=eQXJm+0ISDwiNlKdwZDBn1JAWHk4Ws8hwbSoI8q6JCPuD83oQ2Mt14pcTgKhSROcXT
 g5IaO/8OMKFzrI+d8blKGq0w2xOQJ2qM8IwXkaOUQOYm6L6uk+upagmiOf7TvpnprB3D
 evneHnpz1d81aJInQaowvzjR27KBQ3mKtf+RjCn2y/YXXVVfwY81faUFde5LcDd9tAaL
 xDdiZRXiMos1LBf3J/kJ4Uy81e4xJA5mD5cJVLDcg+59y07u3m9+rL3QswekmAbIME6E
 LxXBKim1j5j2dMWWrzWoHAvfGhLRxLVhuS+PSkT4ZwRC2Tm+Ff8sZlw5u8LEJ0p2ld+n
 CoQg==
X-Gm-Message-State: AC+VfDxqNoaRRjGRWb075NeSoZUuPrX75shciIkswZDTKvUQuB1CZyJq
 lcfNFCJH65ggP57ifN6YCd2QjwTf8J5DXowYWf8//eOgETSxAW7nlu0lTcvDYS21zMs2Rbg5L+G
 kNOJsE/6C8PqzaRE=
X-Received: by 2002:aa7:c3ca:0:b0:50d:f881:1afc with SMTP id
 l10-20020aa7c3ca000000b0050df8811afcmr1230346edr.23.1684912700806; 
 Wed, 24 May 2023 00:18:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7n4gA1+XgnTiC1K3FloWqxXRRliYnj0ctbf3ZAAC4WSPgizAumoFSxJ2m5UDp5bNd6TdLCDg==
X-Received: by 2002:aa7:c3ca:0:b0:50d:f881:1afc with SMTP id
 l10-20020aa7c3ca000000b0050df8811afcmr1230327edr.23.1684912700533; 
 Wed, 24 May 2023 00:18:20 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 y25-20020a056402135900b00510d6795eddsm4780232edw.48.2023.05.24.00.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:18:20 -0700 (PDT)
Message-ID: <0e3874e7-3751-904f-9780-2bad7711d656@redhat.com>
Date: Wed, 24 May 2023 09:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/11] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-9-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> In order to have virtio-iommu.c become target-agnostic,
> we need to avoid using TARGET_PAGE_MASK. Get it with the
> qemu_target_page_mask() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1cd258135d..85905a9e3d 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "qemu/iov.h"
> +#include "exec/target_page.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/virtio/virtio.h"
>   #include "sysemu/kvm.h"
> @@ -1164,7 +1165,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>        * in vfio realize
>        */
>       s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = TARGET_PAGE_MASK;
> +    s->config.page_size_mask = qemu_target_page_mask();
>       s->config.input_range.end = UINT64_MAX;
>       s->config.domain_range.end = UINT32_MAX;
>       s->config.probe_size = VIOMMU_PROBE_SIZE;

Reviewed-by: Thomas Huth <thuth@redhat.com>


