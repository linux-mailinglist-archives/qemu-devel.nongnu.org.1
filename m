Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BC74554B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGCii-00080a-IV; Mon, 03 Jul 2023 02:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGCib-0007zl-3I
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGCiY-0006l5-PK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688364441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5d16N22TnuSiljQRkN78YE3j3rF2frxsbSVFZkXmrSY=;
 b=aHDJ9DHqBkMk86BhdzR4PPycRO2pAUtF8I727hWIASQWvflCiQI6DOxOMt7oJfCL+4fklt
 OGRYqvULOPlwRK+L8jPzCoIcmAcES55aLNFN8hkzSxvfclvadK88Vh30af9wWMDtcM6yfo
 nVvbfEgWzLi0fY9LrpRq4bkTpES1x34=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-HGkN7ZcYPZWSUTjY5MHmhw-1; Mon, 03 Jul 2023 02:07:20 -0400
X-MC-Unique: HGkN7ZcYPZWSUTjY5MHmhw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7656a0f8565so208300185a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688364439; x=1690956439;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5d16N22TnuSiljQRkN78YE3j3rF2frxsbSVFZkXmrSY=;
 b=NXpWr0fEjPt9/UWHgO5iZdTbxSeeMm2KLHkYufUPijfH3/ISggpdSaNnGvu486fQyN
 njA44rA5y0Y+u5LJWbVEAMx01PxKiKKyeaulVffpmxdqMa4b4yePpDldwJqaZoK4+zdQ
 TKaLmpdDKhblZksfzX1MvxoPCwWcgwL0Q3u2OckOE7c8h9H0x56SZ7rzr0S5qdM0fkit
 NabVOFRJna62Zn2LNdcE6aNCBJfMDQyJv8ekT6fastFSXzZ6EiNZQcK4XuUfZ2JCC80Q
 dva21CcBALPcP7YhRzjkL5QAPn0UBoeQd6Y+WQEBeTJUwBaRX4lr9GV79e1mEJoVAFz1
 lOEw==
X-Gm-Message-State: AC+VfDxuqPqxvTQJEkxl/Mrs+BOnv//dBSNxH9jlpOgfCGNlgyV8DqIW
 BXgbckAfDOtcm4QR1n8w7duszHAflTJukY0IDyTmBD/nwCx02bTf2ijPx3rL+5DM5RYJ+13kazn
 40jSC9DCquJsyJhY5qeaehmk=
X-Received: by 2002:ad4:5aa8:0:b0:62d:edb1:89e6 with SMTP id
 u8-20020ad45aa8000000b0062dedb189e6mr18126787qvg.31.1688364439599; 
 Sun, 02 Jul 2023 23:07:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AhYTOg+FJ/uQDzQw7Y8DLQamrpF8S9BJju4bnlBfngHAWzIPlH2G9CAztQ4sodsSB5ZRMpQ==
X-Received: by 2002:ad4:5aa8:0:b0:62d:edb1:89e6 with SMTP id
 u8-20020ad45aa8000000b0062dedb189e6mr18126782qvg.31.1688364439383; 
 Sun, 02 Jul 2023 23:07:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 y11-20020ad457cb000000b00631eb444e6esm10983239qvx.51.2023.07.02.23.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 23:07:19 -0700 (PDT)
Message-ID: <a09bb627-ba8e-a7e4-3969-9933a89e30cc@redhat.com>
Date: Mon, 3 Jul 2023 08:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/vfio/pci-quirks: Sanitize capability pointer
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20230630223608.650555-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230630223608.650555-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/1/23 00:36, Alex Williamson wrote:
> Coverity reports a tained scalar when traversing the capabilities
> chain (CID 1516589).  In practice I've never seen a device with a
> chain so broken as to cause an issue, but it's also pretty easy to
> sanitize.
> 
> Fixes: f6b30c1984f7 ("hw/vfio/pci-quirks: Support alternate offset for GPUDirect Cliques")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Nice. I was just looking at the coverity report ! You beat me at it.

is_valid_std_cap_offset() could be reused in other places where QEMU
scans the PCI capabilities I think.

Thanks,

C.

> ---
>   hw/vfio/pci-quirks.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 0ed2fcd53152..f4ff83680572 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1530,6 +1530,12 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
>       .set = set_nv_gpudirect_clique_id,
>   };
>   
> +static bool is_valid_std_cap_offset(uint8_t pos)
> +{
> +    return (pos >= PCI_STD_HEADER_SIZEOF &&
> +            pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
> +}
> +
>   static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = &vdev->pdev;
> @@ -1563,7 +1569,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>        */
>       ret = pread(vdev->vbasedev.fd, &tmp, 1,
>                   vdev->config_offset + PCI_CAPABILITY_LIST);
> -    if (ret != 1 || !tmp) {
> +    if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
>           error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
>           return -EINVAL;
>       }
> @@ -1575,7 +1581,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>               d4_conflict = true;
>           }
>           tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
> -    } while (tmp);
> +    } while (is_valid_std_cap_offset(tmp));
>   
>       if (!c8_conflict) {
>           pos = 0xC8;


