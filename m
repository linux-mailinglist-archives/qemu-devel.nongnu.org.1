Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF57B6CD3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnh7u-0002Zq-GJ; Tue, 03 Oct 2023 11:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnh7s-0002Ze-U6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnh7q-0007LD-Jm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696346153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REt4ntG+SunVLfFcdUR6CEmY6SPtq/ldTC5vHRdX+Pw=;
 b=bYzT3l2RKoBQeGLQbIt4AJWPqZSBdhWUrUAOQQEYPiE+VogPPqtf0M358SWKMJrf6XwUxz
 s+FppuWhtMllDA8g33d2Lw4qafYmXT3jPWh4mVnGrEV1zxsSkhdGCwyTDK9NWPSu4PqSQW
 gnFCp4isDjN4GGItQrOmi1ZAEp5dC7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-iJA1RH5SO06NUXuEKwZlmg-1; Tue, 03 Oct 2023 11:15:50 -0400
X-MC-Unique: iJA1RH5SO06NUXuEKwZlmg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4150f8480c5so12808591cf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696346150; x=1696950950;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REt4ntG+SunVLfFcdUR6CEmY6SPtq/ldTC5vHRdX+Pw=;
 b=TUM+xzq8kb1NS16/vDrVRAkcVoRMWpvLM5ZiA6oKSOvUsP3xlt99zC5i7DfUsmU5lv
 7d3wNir6IgUrSpo/W7qWZe6xgCJ5K9asauOIXaDMx+r9PKV4MhfH0CcNsbILgkDQxgDo
 2kXZaeVB3Hme3tZaRo3BaPnSCW42uk7dQtjShV/EgjjBE7jN5vxB9fXlQGzAL7W8032h
 TOJJloJKclp5Utf4ezyBX7N+mxA83X1MM13gzSMCV9lk17oDkU8mLoXwb+3CT0zQ2qP8
 6VPPg2xPf6tLWvVhv+0ynMxkkzlfh45/pWNib1lEkQOQ+nWGJ886NXwE5pcTA+WsPoxh
 RHVQ==
X-Gm-Message-State: AOJu0YwfP2WtSyNG/PL8K0petw6wrj2OLUKJGTEbQSSgTGiAI0LHOkac
 KZ9YNhG97Ss+42lx62cUtt+NduDpIgKO312HW3Wwjp9TPAr8eUfZynTCtQqtnfOQMi6HnAZrVqv
 HqmiZvn9mvOAvv7g=
X-Received: by 2002:ac8:5bc8:0:b0:401:e0b4:a93f with SMTP id
 b8-20020ac85bc8000000b00401e0b4a93fmr17552859qtb.41.1696346150340; 
 Tue, 03 Oct 2023 08:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAvtQo9wpADsK1s+oZR1s0MEtkMETTN8SMJOwnS84GPa8o3HUpHrOxZoVuaB/b62VIpBGe7Q==
X-Received: by 2002:ac8:5bc8:0:b0:401:e0b4:a93f with SMTP id
 b8-20020ac85bc8000000b00401e0b4a93fmr17552831qtb.41.1696346150076; 
 Tue, 03 Oct 2023 08:15:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a05620a159400b00767b0c35c15sm534232qkk.91.2023.10.03.08.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:15:49 -0700 (PDT)
Message-ID: <f26e0b1e-5920-fb59-aea7-a59b26351d84@redhat.com>
Date: Tue, 3 Oct 2023 17:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 08/15] vfio/platform: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-9-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-9-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> Let the vfio-platform device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> Drop the trace event for vfio-platform as we have similar
> one in vfio_attach_device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/vfio/platform.c   | 43 +++----------------------------------------
>   hw/vfio/trace-events |  1 -
>   2 files changed, 3 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 5af73f9287..8e3d4ac458 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -529,12 +529,7 @@ static VFIODeviceOps vfio_platform_ops = {
>    */
>   static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>   {
> -    VFIOGroup *group;
> -    VFIODevice *vbasedev_iter;
> -    char *tmp, group_path[PATH_MAX], *group_name;
> -    ssize_t len;
>       struct stat st;
> -    int groupid;
>       int ret;
>   
>       /* @sysfsdev takes precedence over @host */
> @@ -557,47 +552,15 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>           return -errno;
>       }
>   
> -    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
> -    len = readlink(tmp, group_path, sizeof(group_path));
> -    g_free(tmp);
> -
> -    if (len < 0 || len >= sizeof(group_path)) {
> -        ret = len < 0 ? -errno : -ENAMETOOLONG;
> -        error_setg_errno(errp, -ret, "no iommu_group found");
> -        return ret;
> -    }
> -
> -    group_path[len] = 0;
> -
> -    group_name = basename(group_path);
> -    if (sscanf(group_name, "%d", &groupid) != 1) {
> -        error_setg_errno(errp, errno, "failed to read %s", group_path);
> -        return -errno;
> -    }
> -
> -    trace_vfio_platform_base_device_init(vbasedev->name, groupid);
> -
> -    group = vfio_get_group(groupid, &address_space_memory, errp);
> -    if (!group) {
> -        return -ENOENT;
> -    }
> -
> -    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
> -        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
> -            error_setg(errp, "device is already attached");
> -            vfio_put_group(group);
> -            return -EBUSY;
> -        }
> -    }
> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
> +                             &address_space_memory, errp);
>       if (ret) {
> -        vfio_put_group(group);
>           return ret;
>       }
>   
>       ret = vfio_populate_device(vbasedev, errp);
>       if (ret) {
> -        vfio_put_group(group);
> +        vfio_detach_device(vbasedev);
>       }
>   
>       return ret;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8ac13eb106..0eb2387cf2 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -121,7 +121,6 @@ vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # platform.c
> -vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
>   vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
>   vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
>   vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"


