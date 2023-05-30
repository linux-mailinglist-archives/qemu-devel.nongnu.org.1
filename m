Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0937716FF0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q479e-0004ue-GR; Tue, 30 May 2023 17:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q479a-0004sU-DA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:45:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q479V-0001UK-3v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:45:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f68fc6b479so51873995e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685483110; x=1688075110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ziaz4Qyy+d38OPlxrvZQG+DkcEJ2osv8DoYadrNQVBk=;
 b=BRvvQos3FmrlhJE3eAu+neeqQlBwZqTgJ2rAQ0yzHKvznIWxphDC4wd1Uir5/2GjOQ
 1xhUqys0Dk0DeHN24PunGENgrCDen9P1o//xz/7OtPIIwoKjtfCf+8HoA56ZTgoFZOLt
 s+E0qae4RLk6LOV55/36V087xga9/7qI5DV+wgANem1OGweTbisjXz9wJl+EbRtVvehF
 RGSKX6XHsUt80wxoxA24qexRH/CzDw4WqBWia9MWGSRH+5xMsksFfL0j+M7LA+1bn96d
 HrK6qPfc26M0scqlmYk77nzH72dD2GGeUYrHNuRwzVTtEzXKd1wi9pnkMKVhlZPE+0Pu
 Citw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685483110; x=1688075110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ziaz4Qyy+d38OPlxrvZQG+DkcEJ2osv8DoYadrNQVBk=;
 b=NlV1zxuzRGcilc4FFlkhMSV8WmdPQOCNKYAvq3te63s3B1GmhQ4+G82sBc/MGCYtD1
 0b6w+hN8lIjiVId9wVw7Yp8x9xQ+wJBQvCf1Wtl84KBqi3WWDY1mW6MJydkme/cvjDNC
 uJGFeUOMicT4fqY/ec5y+mETW2ZRm3hsZVoxVeaSnFvgzuuichkZU2iRML38F/e79m51
 cGcBFSsvTDS3/gwKJ3C5HU109lVVeCHY0LltXNQk1/aB8h/Nc05TcEQFmnXauOFd0iwX
 hSmg5dgUomk3jfTxtzcnGDxe5gVpbvdWqRHW5SzFvYRHngoBZuNveGhVlr/f7XN65Jea
 X+vg==
X-Gm-Message-State: AC+VfDxU9PzSK7rv/L+f/9wnyRTWYFK3vhQLMVL2DEKqtAeZSoxJJRH1
 S5xjpR7zjLD4Orz8FeI6uBf+Ig==
X-Google-Smtp-Source: ACHHUZ6a8UirChj182sSguzO+6m5wwJojrToqLBrB7+mZvx+MMWYX7ojz/9G/8pAplOUwd3Vk7cjOw==
X-Received: by 2002:a1c:f318:0:b0:3f6:da2:bc86 with SMTP id
 q24-20020a1cf318000000b003f60da2bc86mr2849797wmq.7.1685483109846; 
 Tue, 30 May 2023 14:45:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003f60a9ccd34sm18583272wmo.37.2023.05.30.14.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:45:09 -0700 (PDT)
Message-ID: <20790526-6640-3fd0-920a-ef09e5b306c0@linaro.org>
Date: Tue, 30 May 2023 23:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-11-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530175937.24202-11-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/5/23 19:59, Joao Martins wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Implement get_attr() method and use the address width property to report
> the IOMMU_ATTR_MAX_IOVA attribute.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/i386/intel_iommu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1906f3a67960..829dd6eadc6c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>           *enabled = s->dma_translation;
>           break;
>       }
> +    case IOMMU_ATTR_MAX_IOVA:
> +    {
> +        hwaddr *max_iova = data;

Shouldn't we cast to uintptr_t to be safe?

> +        *max_iova = (1ULL << s->aw_bits) - 1;

Alternatively:

            *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);

> +        break;
> +    }
>       default:
>           ret = -EINVAL;
>           break;


