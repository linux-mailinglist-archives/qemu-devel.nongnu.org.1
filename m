Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1672C6F2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 16:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8iDY-0000pB-Ga; Mon, 12 Jun 2023 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q8iDU-0000oi-2N
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q8iDM-0001se-5P
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686578882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Am6Piia4ddquDrcUM0q2gzDese6/8p1T54ibAUbysHQ=;
 b=dUPLeN/YyQ7akrIFKVI2H3lx1M6iLQ44q5u/liwLNF/BD0a6Z/SnwfwVokHyC1D7Tmsl9e
 S25Swbo1uBJk+am+eMEmLc71w7Bf5MhUmuyPoWNjBUDgnBMvEBOfPjllP8Y5cB/WXH18hA
 1hB+sr1seGuyrpqux88Z1+XKgNbQjqc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-SHeY6egHPXGFnzpSrpLRWQ-1; Mon, 12 Jun 2023 10:07:49 -0400
X-MC-Unique: SHeY6egHPXGFnzpSrpLRWQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f93baa42aaso38578201cf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 07:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686578856; x=1689170856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Am6Piia4ddquDrcUM0q2gzDese6/8p1T54ibAUbysHQ=;
 b=ZCrvqHucLZfQ1TtO4VK7j9jYlSSYj4er7OzmhUJbHMhL4pyznR+BWW585zqvG/YIAm
 IN1lJNFisgcPSqJonx1k+O3tHmd2NgzAX2BLnLd8z+bn5VJJqHACFHuK/TnJl6ZctqIo
 PWR28rmRz4FUaV+HJ/ViBINWM7ilP7B7JNn4ycPD3svrdyrfBcdF9kQlbromfYDaEMMz
 lt29c4lSnYWaSHBIfqfiKn+YY688rjWBv95eZNtCGFTxN7CAmQqEnZxhHgbCJ+0zj1GC
 BIwKPFBa5UC67nWgKmOIOKyzYGA4KCNXhnRE4KJr97tAoZmKAC904Pbx5sCnYv3ejmbr
 j2aA==
X-Gm-Message-State: AC+VfDxrYyWideOJN+2jXWs/yWwdr7a4+UqXerSqxtjUkSH6rTkKHl32
 4o9pBOSj8KCS8FxGHofs47JCoUow/NUZg8NIodPOVtcMS4bamHpkoNk/zdDsnf+gsGtPo1BN8R5
 8n6qpQ6ZoJyV1oQI=
X-Received: by 2002:ac8:5c50:0:b0:3f6:c202:b00b with SMTP id
 j16-20020ac85c50000000b003f6c202b00bmr10328408qtj.24.1686578856045; 
 Mon, 12 Jun 2023 07:07:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KXQLcfWvfUe37Tp7PQu+uUccpTtuh+ZTOjvdKV8l+pQ6SbFlAUYjpZ43D0w0g2N4SXOvXtQ==
X-Received: by 2002:ac8:5c50:0:b0:3f6:c202:b00b with SMTP id
 j16-20020ac85c50000000b003f6c202b00bmr10328380qtj.24.1686578855628; 
 Mon, 12 Jun 2023 07:07:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a05622a009000b003ef2c959d1bsm3392061qtw.67.2023.06.12.07.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 07:07:35 -0700 (PDT)
Message-ID: <a44455cc-1eca-c50d-9394-8faab699c804@redhat.com>
Date: Mon, 12 Jun 2023 16:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] hw/vfio/pci-quirks: Support alternate offset for
 GPUDirect Cliques
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20230608174211.3227138-1-alex.williamson@redhat.com>
 <20230608180507.3229259-1-alex.williamson@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230608180507.3229259-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/23 20:05, Alex Williamson wrote:
> NVIDIA Turing and newer GPUs implement the MSI-X capability at the offset
> previously reserved for use by hypervisors to implement the GPUDirect
> Cliques capability.  A revised specification provides an alternate
> location.  Add a config space walk to the quirk to check for conflicts,
> allowing us to fall back to the new location or generate an error at the
> quirk setup rather than when the real conflicting capability is added
> should there be no available location.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f0147a050aaa..0ed2fcd53152 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
>    * +---------------------------------+---------------------------------+
>    *
>    * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
> + *
> + * Specification for Turning and later GPU architectures:

s/Turning/Turing/

I will fix that.

> + * https://lists.gnu.org/archive/html/qemu-devel/2023-06/pdf142OR4O4c2.pdf
>    */
>   static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>                                          const char *name, void *opaque,
> @@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
>   static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
> -    int ret, pos = 0xC8;
> +    int ret, pos;
> +    bool c8_conflict = false, d4_conflict = false;
> +    uint8_t tmp;
>   
>       if (vdev->nv_gpudirect_clique == 0xFF) {
>           return 0;
> @@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>           return -EINVAL;
>       }
>   
> +    /*
> +     * Per the updated specification above, it's recommended to use offset
> +     * D4h for Turing and later GPU architectures due to a conflict of the
> +     * MSI-X capability at C8h.  We don't know how to determine the GPU

There is a way :

   # nvidia-smi -q | grep Architecture
       Product Architecture                  : Turing

but it must be vendor specific and the proposed solution is as good.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> +     * architecture, instead we walk the capability chain to mark conflicts
> +     * and choose one or error based on the result.
> +     *
> +     * NB. Cap list head in pdev->config is already cleared, read from device.
> +     */
> +    ret = pread(vdev->vbasedev.fd, &tmp, 1,
> +                vdev->config_offset + PCI_CAPABILITY_LIST);
> +    if (ret != 1 || !tmp) {
> +        error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
> +        return -EINVAL;
> +    }
> +
> +    do {
> +        if (tmp == 0xC8) {
> +            c8_conflict = true;
> +        } else if (tmp == 0xD4) {
> +            d4_conflict = true;
> +        }
> +        tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
> +    } while (tmp);
> +
> +    if (!c8_conflict) {
> +        pos = 0xC8;
> +    } else if (!d4_conflict) {
> +        pos = 0xD4;
> +    } else {
> +        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
> +        return -EINVAL;
> +    }
> +
>       ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
>       if (ret < 0) {
>           error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");


