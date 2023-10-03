Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010F7B6DBB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhoO-0006EX-OO; Tue, 03 Oct 2023 11:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhoL-00069M-J7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhoK-0006iI-0v
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696348787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yA/+2zBnBc7gEuOsYApwOzEBq9EniVrFWaLi9p9UIU=;
 b=NKbIieuVMGS/qJNQB2n0H5Ks5iLJ+nPvm6I8vq++eurszvSxY4LQYBgKwJZE6Y1cnA54PF
 xueZ6LxDT7faN9DPQc9IP7F0Na5U9VE0+Sbt+/Pw29ZAphquLGe6zHKccE5JLtJac3YhvR
 kMfoat/mypffezYr4fPiifksF4HgOgs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-UGHoqItpMFevMfngzLT2sA-1; Tue, 03 Oct 2023 11:59:45 -0400
X-MC-Unique: UGHoqItpMFevMfngzLT2sA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d8191a1d5acso1238898276.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696348785; x=1696953585;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+yA/+2zBnBc7gEuOsYApwOzEBq9EniVrFWaLi9p9UIU=;
 b=C3Rgq8O2XlTbAzrt9+3y2TNlVywVuRLrFIxBo7zcXHdl5fHNlqe2cvnFhyL4CFVzue
 zxNr4FC7n1SUxD0nmaWUViOvYmk8rLQisFjF6Ni6B4EPN+P/7SM4KrG8EwKJfGTPldhW
 2GUyMTvvHDSKk4MTK9mEHvxxoCbwfPCuX53ebXBZb157qCVsNYnFRb5Xwqm6zM+vRZLU
 lWP0eJLsPlQMDhgNaZW32gXcmjYYOQa74XfJfsFswGFJf5QmZ5rcTKLvBA/lZ3/L/oaD
 9VrsYV5HIx4Mhs7WNF2btjiVZfcz3V0CMCm52kCY194sUBaB23DOxyb8yPNDZHfZUWei
 4EZQ==
X-Gm-Message-State: AOJu0YyNanrShY4goOJKf99627DYrikKPyrK9UiLzIYDij7Ktqto1YzI
 roc0sijmPF1N2bKzvq5iPsQtI0XV4ojjcngcxoSg+non7yQprm/v7b3MXN9aakez2JA00RXDdty
 yZUonItIvmMklQ6w=
X-Received: by 2002:a5b:14e:0:b0:d7a:ba02:eaa1 with SMTP id
 c14-20020a5b014e000000b00d7aba02eaa1mr13058825ybp.64.1696348785182; 
 Tue, 03 Oct 2023 08:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCczO83Z2IF5Qu70p0b5OKYP6mXyeYtDZK2ohaDxwDc4Y/eVCCYtAF/j4GstyIVPb8LYBbQg==
X-Received: by 2002:a5b:14e:0:b0:d7a:ba02:eaa1 with SMTP id
 c14-20020a5b014e000000b00d7aba02eaa1mr13058809ybp.64.1696348784837; 
 Tue, 03 Oct 2023 08:59:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a0ce20d000000b0065d0b9bf316sm574764qvl.79.2023.10.03.08.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:59:44 -0700 (PDT)
Message-ID: <79fb6650-783c-f9d7-4294-668bebe23fe0@redhat.com>
Date: Tue, 3 Oct 2023 17:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/15] vfio/common: Store the parent container in
 VFIODevice
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-14-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-14-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/3/23 12:14, Eric Auger wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> let's store the parent contaienr within the VFIODevice.
> This simplifies the logic in vfio_viommu_preset() and
> brings the benefice to hide the group specificity which
> is useful for IOMMUFD migration.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h | 1 +
>   hw/vfio/common.c              | 8 +++++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
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
> index ef9dc7c747..55f8a113ea 100644
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
> @@ -2664,7 +2665,12 @@ void vfio_detach_device(VFIODevice *vbasedev)
>   {
>       VFIOGroup *group = vbasedev->group;
>   
> +    if (!vbasedev->container) {
> +        return;
> +    }

Can this happen ? Should it be an assert ?

Thanks,

C.


> +
>       QLIST_REMOVE(vbasedev, container_next);
> +    vbasedev->container = NULL;
>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>       vfio_put_base_device(vbasedev);
>       vfio_put_group(group);


