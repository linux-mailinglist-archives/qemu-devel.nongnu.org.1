Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6970EF8C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1j2g-0003fE-Kp; Wed, 24 May 2023 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1q1j2d-0003ev-IF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1q1j2Z-0006ks-5C
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684913770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZHJKP0T5H1PQGTIOfRRL1+6GcDhPYKC1Y8jvnUnlIg=;
 b=Y2FBzPJnf4NRatRbWHpR5gzEb9FzPrVLRiKepeLsKtuzHbRe0DggcjKLk9UJmbjHIvWnNn
 uCojMw6JX30TFKn2+CmnDRenhT0o6vk9PDcp1eYqNFp0r7Eg+fBTR25Cf1ouyV18bhqQAT
 7mY1I0XPIziM0IO/JAEwCW2o5AFO8jw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-HYz_LZrtM3CBLipfhjQ_VQ-1; Wed, 24 May 2023 03:36:01 -0400
X-MC-Unique: HYz_LZrtM3CBLipfhjQ_VQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f608ea689cso3965345e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684913760; x=1687505760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZHJKP0T5H1PQGTIOfRRL1+6GcDhPYKC1Y8jvnUnlIg=;
 b=aBIRRDPPmSMHal7QhbUKAZQ4kiqGV11vBSy9Hm3uySQWIpUYZhiIpqQFS638Tr3/25
 bnqVWEljqI2u1osdUp/lOtk3f1z9H1eySGC87dpJZtJpBppwP6LPy4xxI5/LwYNL9oaN
 6NSEBYbCCZQ3YWAFTTnbRQfnZlf5ULGkV13jIYUJWfjVfV/ALRoGytMbJTurAGcvylId
 JreMZOG087C37F+qlVAkAq/dkmGUZIpBOnqiwGYpwX9blVNSoj9GPMKyei1jNItb4kXf
 fOsQ4dOniffMC8Awp51vRXRHw+kKVo1eGTqhnmxToN6Rp/1hFqMa5RMjNuybyS40/eBr
 837w==
X-Gm-Message-State: AC+VfDz1rohCVeqKw8BmrlwtFij11tkE9zhzatZMw/DLbpLPHQC40Q4n
 ktsJ96Ea8eI8iPV0MqXpZpXDEffK4tGKaXmlpw3rUN5X60S571IQs/2fP9J5efQUkWm4l1IocsH
 mllCQzud1nMvilvU=
X-Received: by 2002:a1c:7911:0:b0:3f6:76e:604b with SMTP id
 l17-20020a1c7911000000b003f6076e604bmr5569962wme.0.1684913760718; 
 Wed, 24 May 2023 00:36:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Y/OQ+yj5VYiFeMXC0JIn1zfw0bm5th/3PdPCrkGuj1axkMeNwVBvVHaAcHp55ABoyWnFkZQ==
X-Received: by 2002:a1c:7911:0:b0:3f6:76e:604b with SMTP id
 l17-20020a1c7911000000b003f6076e604bmr5569942wme.0.1684913760439; 
 Wed, 24 May 2023 00:36:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c021800b003f080b2f9f4sm1318660wmi.27.2023.05.24.00.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:35:59 -0700 (PDT)
Message-ID: <90ad19b6-2655-75ee-d238-001c1655127a@redhat.com>
Date: Wed, 24 May 2023 09:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/11] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-9-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230523163600.83391-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Philippe,

On 5/23/23 18:35, Philippe Mathieu-Daudé wrote:
> In order to have virtio-iommu.c become target-agnostic,
> we need to avoid using TARGET_PAGE_MASK. Get it with the
> qemu_target_page_mask() helper.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/virtio/virtio-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1cd258135d..85905a9e3d 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/iov.h"
> +#include "exec/target_page.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio.h"
>  #include "sysemu/kvm.h"
> @@ -1164,7 +1165,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>       * in vfio realize
>       */
>      s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = TARGET_PAGE_MASK;
> +    s->config.page_size_mask = qemu_target_page_mask();
>      s->config.input_range.end = UINT64_MAX;
>      s->config.domain_range.end = UINT32_MAX;
>      s->config.probe_size = VIOMMU_PROBE_SIZE;


