Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260077EB129
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 14:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2tkO-0004NE-8c; Tue, 14 Nov 2023 08:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tkI-0004Mp-Fx
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2tkF-0005Et-Fe
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 08:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699969582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yoo0W78/Zq7vFY4MhjjyCfl52TgQPRX/eGQfsCH8wsc=;
 b=GHjR6T4sli653jV4lMuEPioqjebNluDZgkOST8ggVEbKgBzpaZdKjd0vFChyDsIGPK3VW7
 SvdrKP4v2rQUJUvKKA6m2rs8JxY2k+tqspeff9WcYbuC4pbKd+WnmbcbTWoTyA5xYatyGt
 anepnSfe4sQRaIrHWFmW0mESePYm9s8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-JPP5hku3MWauj_8L4Br_ww-1; Tue, 14 Nov 2023 08:46:21 -0500
X-MC-Unique: JPP5hku3MWauj_8L4Br_ww-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7ba23c69410so1297093241.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 05:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969580; x=1700574380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yoo0W78/Zq7vFY4MhjjyCfl52TgQPRX/eGQfsCH8wsc=;
 b=BLlaYiSianZwHhNpTn4WM03cTWdRGrCUJNRXMvEq7fSRlwFQesb191D9f+zdaPeyD/
 HAzFPn79lfVbiaqI235BPjwJAj/PP/85FvnbgeL8ip6VATuc7bvVYgp+4O3RvUEhs20F
 CVz9+QA9+V/30pGlhA4rjbchIEpShtA+2P+FIqYqD3Vx+oTgIFNPEa0+M9bmyPi3JhQ9
 1TplnIU4b/465qnIt8KaVTGF9//D48SJkNJVrt4ucXkN68MUOaIeDmyRKSzoikqbdlQx
 iY2LE4UXVhdYp80ML+1KLV8JzQjmHBSfd1T3ASsPoXrTBY23EirlKboUTTuzkXJD6UDX
 9yMw==
X-Gm-Message-State: AOJu0Yw1sseiyBUUoQpUrkM/sEhgMaCUTHmTCONWaKaH+PT7j0O6NPdz
 HIurYL0SOiLvTwlv0qhRWRV+LQYWyzK6Gb6S5B8BaiNMmpuPGRSl2Xk6Mb6F9AVbwmR6S5QO6sS
 A1AG30M5kkG7euAc=
X-Received: by 2002:a05:6102:4687:b0:45f:36ed:edce with SMTP id
 dw7-20020a056102468700b0045f36ededcemr4767413vsb.16.1699969580527; 
 Tue, 14 Nov 2023 05:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPo8MM8aGaLte4M5iQml0kCKheeGngxwT/YwwGDxmqBGoMZ6cY38T1HUGu02YUD9GntYvaqQ==
X-Received: by 2002:a05:6102:4687:b0:45f:36ed:edce with SMTP id
 dw7-20020a056102468700b0045f36ededcemr4767382vsb.16.1699969580216; 
 Tue, 14 Nov 2023 05:46:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a0cea4c000000b00655d711180dsm2932862qvp.17.2023.11.14.05.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 05:46:19 -0800 (PST)
Message-ID: <fa72e44b-e865-47c3-855f-b947a4e5c1e5@redhat.com>
Date: Tue, 14 Nov 2023 14:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/21] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-7-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231114100955.1961974-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/14/23 11:09, Zhenzhong Duan wrote:
> Some vIOMMU such as virtio-iommu use IOVA ranges from host side to
> setup reserved ranges for passthrough device, so that guest will not
> use an IOVA range beyond host support.
> 
> Use an uAPI of IOMMUFD to get IOVA ranges of host side and pass to
> vIOMMU just like the legacy backend, if this fails, fallback to
> 64bit IOVA range.
> 
> Also use out_iova_alignment returned from uAPI as pgsizes instead of
> qemu_real_host_page_size() as a fallback.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v6: propagate iommufd_cdev_get_info_iova_range err and print as warning
> 
>   hw/vfio/iommufd.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 06282d885c..e5bf528e89 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -267,6 +267,53 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
>       return ram_block_uncoordinated_discard_disable(state);
>   }
>   
> +static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                            uint32_t ioas_id, Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    struct iommu_ioas_iova_ranges *info;
> +    struct iommu_iova_range *iova_ranges;
> +    int ret, sz, fd = container->be->fd;
> +
> +    info = g_malloc0(sizeof(*info));
> +    info->size = sizeof(*info);
> +    info->ioas_id = ioas_id;
> +
> +    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
> +    if (ret && errno != EMSGSIZE) {
> +        goto error;
> +    }
> +
> +    sz = info->num_iovas * sizeof(struct iommu_iova_range);
> +    info = g_realloc(info, sizeof(*info) + sz);
> +    info->allowed_iovas = (uintptr_t)(info + 1);
> +
> +    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
> +    if (ret) {
> +        goto error;
> +    }
> +
> +    iova_ranges = (struct iommu_iova_range *)(uintptr_t)info->allowed_iovas;
> +
> +    for (int i = 0; i < info->num_iovas; i++) {
> +        Range *range = g_new(Range, 1);
> +
> +        range_set_bounds(range, iova_ranges[i].start, iova_ranges[i].last);
> +        bcontainer->iova_ranges =
> +            range_list_insert(bcontainer->iova_ranges, range);
> +    }
> +    bcontainer->pgsizes = info->out_iova_alignment;
> +
> +    g_free(info);
> +    return 0;
> +
> +error:
> +    ret = -errno;
> +    g_free(info);
> +    error_setg_errno(errp, errno, "Cannot get IOVA ranges");
> +    return ret;
> +}
> +
>   static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>                                  AddressSpace *as, Error **errp)
>   {
> @@ -341,7 +388,13 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_discard_disable;
>       }
>   
> -    bcontainer->pgsizes = qemu_real_host_page_size();
> +    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
> +    if (ret) {
> +        warn_report_err(err);
> +        err = NULL;
> +        error_printf("Fallback to default 64bit IOVA range and 4K page size\n");

This would be better :

         error_append_hint(&err,
                    "Fallback to default 64bit IOVA range and 4K page size\n");
         warn_report_err(err);

I will take care of it if you agree. With that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> +        bcontainer->pgsizes = qemu_real_host_page_size();
> +    }
>   
>       bcontainer->listener = vfio_memory_listener;
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);


