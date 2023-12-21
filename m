Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544781B066
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:37:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEXn-0004i8-AI; Thu, 21 Dec 2023 03:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGEXj-0004hS-Vg
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:36:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGEXe-0006T4-Iq
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703147789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7OIr6286rrBVBaqQY6RNlWh3imfx9fBS1hm5m7SVqI=;
 b=Dd7qlZbDpQYf8PdoG5D4NJ7XRd/VgnpIKm685VAsduzbnvuJMAtznRaFQb1Ba/ruSrefz4
 tTzlu+wxhdQNhuN57cggYYhny0a21WWxBKESw1WAVKC4BhdEDLmQ2UMeUr8IzSn//7ZjnH
 uuee6BBn9GRJusdfaET1DXcM/vdF7YQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-yB7_c9ncN5Kds83M1gvtGw-1; Thu, 21 Dec 2023 03:36:26 -0500
X-MC-Unique: yB7_c9ncN5Kds83M1gvtGw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-781216015bdso23768685a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703147786; x=1703752586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7OIr6286rrBVBaqQY6RNlWh3imfx9fBS1hm5m7SVqI=;
 b=veGtabrXRVttv7tboIiminEUF9WPP+NsZfSKDtIOu50XfcHC1pu0ivd8lQVnmkzpHI
 femxifUUo5EnSu2kQMR/7HBVgRT6HhOrEhWv9A360w6i9h30cnyf3dNW45KqJHl6/k53
 /Kop6kiFkT5soa/iFbM/KtbOYVXhCZGjIGpj7MXy6QCgYErmccoI2jSq2zhH9QZJsY6d
 kH9cCIX+h8dexUYsnraifgrKxm9TFAr+DgtiSVImNsCxWvGhdZYyBN0ZVzHABNyMzPNR
 IYOnDQp3JIE6aTEMEM+GuiF06nG6ZTLz3WdOkzwHPQdJNVF6Vz0Vol25c50/6h3ZwtIl
 TRFQ==
X-Gm-Message-State: AOJu0Yxy/KAhggMfhIuE1eGZlHS8OWJsWENh1+i9vDQjiYWbs0FkYI3G
 Z29AdOrr0YOkWSi4DMFbacacWAzW52V2hYSxZvFElIeN0FN3R3lgoimrhYjwNNf4LEe9xuxE4o3
 tHQDZoMwAsfny0HU=
X-Received: by 2002:a05:620a:815:b0:781:2125:e6c4 with SMTP id
 s21-20020a05620a081500b007812125e6c4mr301084qks.113.1703147786451; 
 Thu, 21 Dec 2023 00:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5vh4Yj1B8SygRUdKQp04/xUEcEr1YZGJDWxPRMj3GPj838dFjffYxB7rMoGnyHKRR+YL6Kg==
X-Received: by 2002:a05:620a:815:b0:781:2125:e6c4 with SMTP id
 s21-20020a05620a081500b007812125e6c4mr301079qks.113.1703147786206; 
 Thu, 21 Dec 2023 00:36:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a05620a249600b0077f3688b2c9sm508122qkn.9.2023.12.21.00.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 00:36:25 -0800 (PST)
Message-ID: <c146d0ab-19c4-4b5d-b989-cf7549d2f026@redhat.com>
Date: Thu, 21 Dec 2023 09:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Rename vfio_init_container to
 vfio_set_iommu
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20231221024517.254074-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231221024517.254074-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/21/23 03:45, Zhenzhong Duan wrote:
> vfio_container_init() and vfio_init_container() names are confusing
> especially when we see vfio_init_container() calls vfio_container_init().
> 
> vfio_container_init() operates on base container which is consistent
> with all routines handling 'VFIOContainerBase *' ops.
> 
> vfio_init_container() operates on legacy container and setup IOMMU
> context with ioctl(VFIO_SET_IOMMU).
> 
> So choose to rename vfio_init_container to vfio_set_iommu to avoid
> the confusion.
> 
> No functional change intended.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 8d334f52f2..bd25b9fbad 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -392,8 +392,8 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
>       return VFIO_IOMMU_CLASS(klass);
>   }
>   
> -static int vfio_init_container(VFIOContainer *container, int group_fd,
> -                               VFIOAddressSpace *space, Error **errp)
> +static int vfio_set_iommu(VFIOContainer *container, int group_fd,
> +                          VFIOAddressSpace *space, Error **errp)
>   {
>       int iommu_type, ret;
>       const VFIOIOMMUClass *vioc;
> @@ -616,7 +616,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->fd = fd;
>       bcontainer = &container->bcontainer;
>   
> -    ret = vfio_init_container(container, group->fd, space, errp);
> +    ret = vfio_set_iommu(container, group->fd, space, errp);
>       if (ret) {
>           goto free_container_exit;
>       }


