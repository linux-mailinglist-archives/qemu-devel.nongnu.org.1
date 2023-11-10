Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A527E7AF9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NwF-0008VX-7V; Fri, 10 Nov 2023 04:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1NwC-0008Ts-SZ
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r1NwB-0006Cs-9V
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699608984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUbur2CoegP+Xr9Bjo4zFhRSED2cV+Wf+fNGKE5cJrA=;
 b=G05am2nvCTJP1NQpRkd6dTwIgVFkV56GYWSHHj9jFUUy00FXUvkjCBjobkf7CTFKbnXZsL
 6NABA613966kjUS6brSopz0Wgi9a60rSAFLfVd4FuGcgfQA8qiTtzQMprbPpMuyeC1lnsj
 5aGEMsYQfDtZICOHCboGVnW3i0bG6b8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-wcnzzMc1MNerK7lCV2nQXg-1; Fri, 10 Nov 2023 04:36:23 -0500
X-MC-Unique: wcnzzMc1MNerK7lCV2nQXg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-da0cb98f66cso2254446276.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699608983; x=1700213783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUbur2CoegP+Xr9Bjo4zFhRSED2cV+Wf+fNGKE5cJrA=;
 b=gHWw2SiU3dI6dcnvZvAROOHwu2Tlvmih4sIwFMMeemJdPt7dQ/sF8l9zdLr0Fl3FlR
 nUoHYkezhHYtITewKjyYnfnKie3m7HB43NmPl7XWTBSsdVBNMFQB18K+7QQ9G4uthsqX
 HduOJ+zRPjLJsNoQqKt8BkjbjRGbxSUFBn/8uPTVI/SKkEoSglF18Wh8QTenzrM4EN0T
 crb10/armxgqbFKhRR1LJMhS8u/rZQTkybQ39NI72VDPhwAMUZeMS66oezQBYLkguNXT
 Q5ex0v4pChyF0gF22OycSXNcF3lzu1zn38TH+qV+wRzyWUkIp8f299jTmbJATsTJs+m4
 S4VQ==
X-Gm-Message-State: AOJu0YzI7/h3suO0Z59YAfT6NRa3Qu3QpnIkrZHK19Rd+emAQ9HYuOiq
 oMCbbnGUGuAVejLOdyYLO2psskB/wcjgC9J+7W201khFC0vLqiQM7dYB9uTInIkgvySM4gRE9IE
 blnpXnSJU36TWFQU=
X-Received: by 2002:a25:361e:0:b0:d9a:5666:7ab5 with SMTP id
 d30-20020a25361e000000b00d9a56667ab5mr7408544yba.10.1699608982872; 
 Fri, 10 Nov 2023 01:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzntl0fTdDGPY0P2JmNDxFA2ktYLqRmFmoeEBn4AwIiklVPf8W2yIT64Xq7LxjbmodIWjMPQ==
X-Received: by 2002:a25:361e:0:b0:d9a:5666:7ab5 with SMTP id
 d30-20020a25361e000000b00d9a56667ab5mr7408532yba.10.1699608982602; 
 Fri, 10 Nov 2023 01:36:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a0ce78e000000b0065afbb39b2dsm2784013qvn.47.2023.11.10.01.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 01:36:22 -0800 (PST)
Message-ID: <a83922bb-8c53-47d8-b15a-8a7052f02053@redhat.com>
Date: Fri, 10 Nov 2023 10:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/20] vfio/iommufd: Add support for iova_ranges and
 pgsizes
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231109114529.1904193-6-zhenzhong.duan@intel.com>
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

On 11/9/23 12:45, Zhenzhong Duan wrote:
> Some vIOMMU such as virtio-iommu use iova ranges from host side to
> setup reserved ranges for passthrough device, so that guest will not
> use an iova range beyond host support.
> 
> Use an uAPI of IOMMUFD to get iova ranges of host side and pass to
> vIOMMU just like the legacy backend.
> 
> Also use out_iova_alignment returned from uAPI as pgsizes instead of
> qemu_real_host_page_size() as a fallback.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v5: Add missed pgsizes initialization in vfio_get_info_iova_range
> 
>   hw/vfio/iommufd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ea4e23f4ec..958c3e794f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -267,6 +267,53 @@ static int iommufd_ram_block_discard_disable(bool state)
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
> +    error_report("vfio/iommufd: Cannot get iova ranges: %m");

Can we propagate the error ?

Thanks,

C.


> +    return ret;
> +}
> +
>   static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
>                                    AddressSpace *as, Error **errp)
>   {
> @@ -343,6 +390,7 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
>       }
>   
>       bcontainer->pgsizes = qemu_real_host_page_size();
> +    vfio_get_info_iova_range(container, ioas_id);
>   
>       bcontainer->listener = vfio_memory_listener;
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);


