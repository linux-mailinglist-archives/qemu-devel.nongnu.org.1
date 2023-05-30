Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DB716FE1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4747-0007zK-W2; Tue, 30 May 2023 17:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4745-0007yr-Em
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:39:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4743-0000Ky-Te
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:39:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso2611915e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685482774; x=1688074774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Hpoh/6kqk9MX8kcDEdamIcIQZXedyDvRNPEBor0NGQ=;
 b=S9tkVKnJdpEggHqqy4B5ENOEywGYGeuNgbfU/FAisWTRfb9cpRnMF5NnWCkZc+ZYCV
 3X2jQbJgJQC8BVVb36zQwKpi/lskGrPdcq6ArRuSWYUGcqq25wh53HBsakfIicuzwrDY
 Iv3ZscQE4nlGFG2KeEQtR6V8GW+LkMALGxesZ107sZ4ut9dE6eiqngMVH5WAivNDyDGz
 +xXN1XkHoobu/Vid9NHBSoEHcBWMmm22Iq8OlurE1UKCTV5NXPQACyEoBgABcAc4+YH+
 fMFoQTWz3s9ePqXO0N6hOE2GdvQVNZ+hEN1znlqPDEAZFUwfkTrFZ4o7cyXZD5KXWD8u
 2Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685482774; x=1688074774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Hpoh/6kqk9MX8kcDEdamIcIQZXedyDvRNPEBor0NGQ=;
 b=bZpJNTSnRLY0f0u0sih6iczK5FkQLnGUVLsEdivTwRsMCMc8yHQfNbDB7vs7iT6ppB
 wc0CwGr/Opfg25+9iDyV8qErG4y2bWZ8lWIiXdDkCDhFYEqE3+I7GwVWZvpaf6nwKa1e
 7p41MrY7tfkCDSVe/2RCIy/oUNG9mvTlM90cxR49DXyTT6PKRexO9+zldBq7WCiOwTd4
 uQjk7uC5NKW6hWRTo3/npfdpAfFshYo5qh9lLStrCv7UyqFR8AwYMYHctW0zwo6574s3
 1tjslWQg4CRaHxTZohdTuKfzEMWLJeMIMxsppOjRyaJwtitjsUaVKvMdKjMwSdMOUmaw
 S44w==
X-Gm-Message-State: AC+VfDzUa2heOCnriQ034BRwE01kVol4oaGtLjc4WMCASmhLVicSRe8F
 DrhELKE+Y/qlR72Da1Efjrh6yg==
X-Google-Smtp-Source: ACHHUZ7d3cZLluIPR1d1+4UxmrbpN6fWFnROGHSdlB/PqVXY+mOYHmbwfY+F8aRNxIva7l7dUWhB6A==
X-Received: by 2002:a05:600c:257:b0:3f6:84:3df6 with SMTP id
 23-20020a05600c025700b003f600843df6mr3038919wmj.10.1685482774267; 
 Tue, 30 May 2023 14:39:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a1c7c0f000000b003f4266965fbsm22007918wmc.5.2023.05.30.14.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:39:33 -0700 (PDT)
Message-ID: <661455ce-b310-adbb-268c-3b0771d8bf7f@linaro.org>
Date: Tue, 30 May 2023 23:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/15] vfio/common: Relax vIOMMU detection when DMA
 translation is off
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
 <20230530175937.24202-9-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530175937.24202-9-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/5/23 19:59, Joao Martins wrote:
> Relax the vIOMMU migration blocker when the underlying IOMMU reports that
> DMA translation disabled. When it is disabled there will be no DMA mappings
> via the vIOMMU and the guest only uses it for Interrupt Remapping.
> 
> The latter is done via the vfio_viommu_preset() return value whereby in
> addition to validating that the address space is memory, we also check
> whether the IOMMU MR has DMA translation on.

> Assume it is enabled if
> there's no IOMMU MR or if no dma-translation property is supported.

This comment ^ ...

> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fa8fd949b1cf..060acccb3443 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -414,12 +414,32 @@ void vfio_unblock_multiple_devices_migration(void)
>       multiple_devices_migration_blocker = NULL;
>   }
>   
> +static bool vfio_viommu_dma_translation_enabled(VFIOAddressSpace *space)
> +{
> +    bool enabled = false;
> +    int ret;
> +
> +    if (!space->iommu_mr) {
> +        return true;
> +    }
> +
> +    ret = memory_region_iommu_get_attr(space->iommu_mr,
> +                                       IOMMU_ATTR_DMA_TRANSLATION,
> +                                       &enabled);
> +    if (ret || enabled) {

... could be helpful if duplicated here.

> +        return true;
> +    }
> +
> +    return false;
> +}


