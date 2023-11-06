Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919117E2AD7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:19:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03Fv-0000Hc-8R; Mon, 06 Nov 2023 12:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Fs-0000Gq-T6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r03Fr-0000eP-AB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699291154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rW/2fZ8VCxdzhbgYcLpo5/Wocbzi2HlmdX4p91zdNGQ=;
 b=dZ0E/lK5q9YcmO3FeQ3Rjb14LrbDCBjV6ezZ4IYJUVpdfRCk0LlGY7rj3x0n1ACbX6F9tE
 p/k0ATGuqFKYZcaAGAonlSlNHl1ONdKqAwPuTog5oegknQGizbP3HW5KQw/LfQtPxzZA1A
 c4/724fc/Xldlr60nek6u+As2tR5m9Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358--RypWwKvM1SZ5stl5QF07A-1; Mon, 06 Nov 2023 12:19:13 -0500
X-MC-Unique: -RypWwKvM1SZ5stl5QF07A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d03b02d16so87542116d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291153; x=1699895953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rW/2fZ8VCxdzhbgYcLpo5/Wocbzi2HlmdX4p91zdNGQ=;
 b=GB03ckYT9E1VtPaL+v/9LtfjTkwG8X8sKcYgYWJJA8qrjk65gKGzxXYlYK8wu5TFzx
 CZnWz9VqCSnURQeH7bb3QzoW96OiEe1XXvKELP0T5yJ9yqhYy7aggy5N1q1/Cz1xivkc
 kRPz+KmuHYO4AImkO8Ixx4q7Y6bk5Fw0SWUaU7c5x2n7LmWNlnSQ6H2+l8YpgMQN7zKk
 HdXzxgaGArLzNhCEncGWgpE32YNXVjBzwlIhiun+xTdyCMUFeHgWe81HaP5foEN0RAOQ
 GMoqs2qd7DCUh8NziQ7Q+Kd6uaWyhQbslOLitIzB+4BGnRsZgKd213lPf3+6y/BV+IPe
 OHHw==
X-Gm-Message-State: AOJu0YzLNDRco70gmuFKFOwVHMpKS1lqOXZLv6jg4MIwfQmM9T/Z9Cym
 4ET6HA3CTSwSvP6ypCMmmbhrecObDUUMLNCTWBH9ugcbUq+MEKHXDaYHL95eFGksgPMtDXAIS3g
 N1smEspKaNiikOQVNH22uzJw=
X-Received: by 2002:a05:622a:8e:b0:418:cec:5e64 with SMTP id
 o14-20020a05622a008e00b004180cec5e64mr199625qtw.19.1699291152764; 
 Mon, 06 Nov 2023 09:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dx97At3oXxUs5G5yI4nDZ4/26+FLIuZvBEL+s4//6bCAW3fhmUtsTL6yeeVu1l8kaWgUVA==
X-Received: by 2002:a05:622a:8e:b0:418:cec:5e64 with SMTP id
 o14-20020a05622a008e00b004180cec5e64mr199596qtw.19.1699291152516; 
 Mon, 06 Nov 2023 09:19:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05622a229200b004181c32dcc3sm3543189qtb.16.2023.11.06.09.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 09:19:12 -0800 (PST)
Message-ID: <3d2c2c02-2101-40f0-a60e-34b90a43969e@redhat.com>
Date: Mon, 6 Nov 2023 18:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/41] vfio/iommufd: Add support for iova_ranges
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-31-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-31-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> Some vIOMMU such as virtio-iommu use iova ranges from host side to
> setup reserved ranges for passthrough device, so that guest will not
> use an iova range beyond host support.
> 
> Use an uAPI of IOMMUFD to get iova ranges of host side and pass to
> vIOMMU just like the legacy backend.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: fix build error in 32bit fedora
> 
>   hw/vfio/iommufd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 1bb55ca2c4..22f02f92a9 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -341,6 +341,52 @@ static int iommufd_ram_block_discard_disable(bool state)
>       return ram_block_uncoordinated_discard_disable(state);
>   }
>   
> +static int vfio_get_info_iova_range(VFIOIOMMUFDContainer *container,
> +                                    uint32_t ioas_id)
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
> +    iova_ranges = (struct iommu_iova_range *)info->allowed_iovas;

iova_ranges = (struct iommu_iova_range *)(uintptr_t)info->allowed_iovas;

Thanks,

C.


> +
> +    for (int i = 0; i < info->num_iovas; i++) {
> +        Range *range = g_new(Range, 1);
> +
> +        range_set_bounds(range, iova_ranges[i].start, iova_ranges[i].last);
> +        bcontainer->iova_ranges =
> +            range_list_insert(bcontainer->iova_ranges, range);
> +    }
> +
> +    g_free(info);
> +    return 0;
> +
> +error:
> +    ret = -errno;
> +    g_free(info);
> +    error_report("vfio/iommufd: Cannot get iova ranges: %m");
> +    return ret;
> +}
> +
>   static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
>                                    AddressSpace *as, Error **errp)
>   {
> @@ -418,6 +464,7 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
>       }
>   
>       bcontainer->pgsizes = qemu_real_host_page_size();
> +    vfio_get_info_iova_range(container, ioas_id);
>   
>       bcontainer->listener = vfio_memory_listener;
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);


