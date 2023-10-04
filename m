Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C67B8619
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5JW-0000Cc-H8; Wed, 04 Oct 2023 13:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo5JV-0000CT-2x
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo5JT-0007Rp-H8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRZ3UZARu1wa3n+KiuKNDu2+h486azt0cIpjj4bTfkY=;
 b=I7nxQmOkQWSFI24xt9vEAT/Rv6+MHvA06UIvrhOXV9flO6H/uW33sQ8E0gXsAKrcGztCCD
 7tAc8/uYuDHPGsY0sa7ACIR3FT1x/HEzZtZCpYBxWFHAm2IyheI26LU0gl/VYR2q6vYhjC
 osYHwlxGdNAxZ1tMHPbHB9gQzSvlx8M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-wuV-ga_dMX-2TpXIIErIjw-1; Wed, 04 Oct 2023 13:05:28 -0400
X-MC-Unique: wuV-ga_dMX-2TpXIIErIjw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65afd7597baso25212376d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439128; x=1697043928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRZ3UZARu1wa3n+KiuKNDu2+h486azt0cIpjj4bTfkY=;
 b=bPZ/BPRDLuWj9E97ndDFKubcsNM14y3GEpZfnTcjRGT+Qu+fgK/p8eVHY39rwhULfG
 1UxMd3eqUdVRTsQyY14l0L/2sjBlU8VR2MuJUGK6HJrXzOx5f6GL55BDNtagEtzFKbd6
 Sr7u0y99icEMNvKrIn03LaAf/+Drw0iVw1SWwCfHMkgqzRlKL8/i8Dmd+N807WvwuvHV
 iDXRIAtFLGkfENyi+2NVpUu4ZcTj1+awOFNJEOS1/FDlp4HLsewJaRtV0ZN8nAJnmpBY
 YnNeJUnZbzaYoXjwEZ+p4x5BOcerp9AT26iOzK5PoCgn9WQlI+7gbIqajp8wIGz9PJBv
 /uHA==
X-Gm-Message-State: AOJu0YyE/h1aVGX5H3BBLGUOgvt9N2M9SfyrPrCQHSQsVUcJ+CUSTNDw
 zgoYO42MjXWlm70DsQfjNQ9U89B0M3uFZ0TV45eIEB1qDjMSv+NzDcPSTSj4ZkKUKgJlrJ4N5UY
 HgF1cJYarUr+MByI7aI/mhZs=
X-Received: by 2002:a0c:dd87:0:b0:656:5199:77a9 with SMTP id
 v7-20020a0cdd87000000b00656519977a9mr2781464qvk.28.1696439127896; 
 Wed, 04 Oct 2023 10:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcVUg4geeTNPYPJ2ViYtVnm6kCEnQNJcZOA47NhZfdcRz+8qTt1150t9GK9gzy1G2c1HcjDg==
X-Received: by 2002:a0c:dd87:0:b0:656:5199:77a9 with SMTP id
 v7-20020a0cdd87000000b00656519977a9mr2781445qvk.28.1696439127648; 
 Wed, 04 Oct 2023 10:05:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05620a070d00b007756f60bcacsm1392789qkc.79.2023.10.04.10.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:05:27 -0700 (PDT)
Message-ID: <9bf175c1-8932-7ad1-32fb-8011750c3f10@redhat.com>
Date: Wed, 4 Oct 2023 19:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 13/15] vfio/common: Store the parent container in
 VFIODevice
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-14-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231004154518.334760-14-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/4/23 17:44, Eric Auger wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> let's store the parent contaienr within the VFIODevice.
> This simplifies the logic in vfio_viommu_preset() and
> brings the benefice to hide the group specificity which
> is useful for IOMMUFD migration.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

with the re-added check on !vbasedev->container,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> 
> v3 -> v4:
> - Dropped check on !vbasedev->container
> ---
>   include/hw/vfio/vfio-common.h | 1 +
>   hw/vfio/common.c              | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8ca70dd821..bf12e40667 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -132,6 +132,7 @@ typedef struct VFIODevice {
>       QLIST_ENTRY(VFIODevice) next;
>       QLIST_ENTRY(VFIODevice) container_next;
>       struct VFIOGroup *group;
> +    VFIOContainer *container;
>       char *sysfsdev;
>       char *name;
>       DeviceState *dev;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ef9dc7c747..b14f04c9b0 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -184,7 +184,7 @@ void vfio_unblock_multiple_devices_migration(void)
>   
>   bool vfio_viommu_preset(VFIODevice *vbasedev)
>   {
> -    return vbasedev->group->container->space->as != &address_space_memory;
> +    return vbasedev->container->space->as != &address_space_memory;
>   }
>   
>   static void vfio_set_migration_error(int err)
> @@ -2655,6 +2655,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>       }
>   
>       container = group->container;
> +    vbasedev->container = container;
>       QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
>   
>       return ret;
> @@ -2665,6 +2666,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
>       VFIOGroup *group = vbasedev->group;
>   
>       QLIST_REMOVE(vbasedev, container_next);
> +    vbasedev->container = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);


