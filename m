Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4947E29F2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02ao-0001M5-HF; Mon, 06 Nov 2023 11:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02aY-0001LR-HO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r02aX-0008MH-0M
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699288591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2R6Ns4ix4nWdhktJ/yqAJoJM0UNQZgqY4D2UjUyE/Ww=;
 b=FDNA+ntqXlarNKzrddxQdC8Pkb/946onYG5cnqHBKTicnHXTT0AZHrgdLQDxbTxSLT425O
 pyInuQNUfbOmwpN1fw2YLklhcx9sinONkH/vyXSc1cZgnOmRiqC37F9wbLk4aqCyGD6UFN
 WIrveCM7+QHlc65yugcnAwHw/WAW22g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-JhQUxDbOMueefwlkijviGQ-1; Mon, 06 Nov 2023 11:36:29 -0500
X-MC-Unique: JhQUxDbOMueefwlkijviGQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d20c7dad2so52176626d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288589; x=1699893389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2R6Ns4ix4nWdhktJ/yqAJoJM0UNQZgqY4D2UjUyE/Ww=;
 b=jtNtA4J+k4GVDfs6uMGpe5+9sj7RxBFvsJxG9XGfTJw3N99ZsZMvlMaYB48Lr7eAdK
 VxcnE2Hbn8D8pC6UGJsYa6BHEPN7EAyXdF8hqRqqHgMfGb09cp8r89c7k/ZBdFrJjokl
 mZ7VIcORUj11kyXUu/duWG29I4xlOVza/NkrpmHpZStKZC/7dJ07Y9LxFx61a+K9dgaV
 W3WlSlunyjt7dM/upZ5sXJ4f7QwMn9Ffr5KCvsjE8fzMDAv2DSoe5mjgpxZ9ceImqVOD
 5FnOHD9jITRL/KLz2xZ/drC9nA0qtLXo2IR71LdVb7ze9CvKtyG1A5bheoC0r6OU1cGu
 Rb5g==
X-Gm-Message-State: AOJu0Ywhyjx5GKL9aSEZg0jAb2gf3nvQqDQ+XyBWOmpI8/m9ohTe9Tun
 a+OBqYSU/5MyvZP/71LEwN8nimIQ9V1NQPoFZpNiHDs2s59X/eZYKNxx8DoB6niFAnqW79xD3mO
 BgfTtaE8mZZVJtTY=
X-Received: by 2002:a05:6214:2b08:b0:65a:fedd:3c69 with SMTP id
 jx8-20020a0562142b0800b0065afedd3c69mr36507910qvb.0.1699288589208; 
 Mon, 06 Nov 2023 08:36:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXMN1jfFXcFvs416Y0BED2ytr4q0924n0bQUEfaEHrFIcvFsmxZyA9+dOGrmFIuxBSIvJ1fQ==
X-Received: by 2002:a05:6214:2b08:b0:65a:fedd:3c69 with SMTP id
 jx8-20020a0562142b0800b0065afedd3c69mr36507886qvb.0.1699288588932; 
 Mon, 06 Nov 2023 08:36:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a05620a28c300b0076c96e571f3sm3426450qkp.26.2023.11.06.08.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:36:28 -0800 (PST)
Message-ID: <caf9c0e9-6099-4b5e-9573-190c7493ca6c@redhat.com>
Date: Mon, 6 Nov 2023 17:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/41] vfio/container: Introduce a empty VFIOIOMMUOps
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-8-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-8-zhenzhong.duan@intel.com>
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> This empty VFIOIOMMUOps named vfio_legacy_ops will hold all general
> IOMMU ops of legacy container.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/container.c           | 5 +++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 586d153c12..678161f207 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -255,7 +255,7 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIOGroupList vfio_group_list;
>   extern VFIODeviceList vfio_device_list;
> -
> +extern const VFIOIOMMUOps vfio_legacy_ops;
>   extern const MemoryListener vfio_memory_listener;
>   extern int vfio_kvm_device_fd;
>   
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 242010036a..4bc43ddfa4 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -472,6 +472,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
>       VFIOContainer *container;
> +    VFIOContainerBase *bcontainer;
>       int ret, fd;
>       VFIOAddressSpace *space;
>   
> @@ -552,6 +553,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       container->iova_ranges = NULL;
>       QLIST_INIT(&container->giommu_list);
>       QLIST_INIT(&container->vrdl_list);
> +    bcontainer = &container->bcontainer;
> +    bcontainer->ops = &vfio_legacy_ops;
>   
>       ret = vfio_init_container(container, group->fd, errp);
>       if (ret) {
> @@ -933,3 +936,5 @@ void vfio_detach_device(VFIODevice *vbasedev)
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);
>   }
> +
> +const VFIOIOMMUOps vfio_legacy_ops;


