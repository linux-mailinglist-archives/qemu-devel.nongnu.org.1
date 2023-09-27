Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4327AFF8B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQZM-0002sr-9W; Wed, 27 Sep 2023 05:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQZJ-0002sj-CV
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQZH-0006pX-Mv
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695805850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FEc9tu44wr+kO4Y7p6VCimXRxM5Q8JJAq0FImguaUY=;
 b=ZKD2DCfhnys0JP4/Mmr4gTD2DntHDKNWv4boU0ZQt3mRrgtv5w1COKxGkKaQALcXnOF04Y
 0bK2OA6KGLoI0CymGiYUpD1xO0CyUJiUeSE4I7O6vozpSflOy7ZFhtMP/1u0IQuY6l4W4k
 x9tVowbAGJwcA292iKWCFfsSO0DdJao=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ycNb7q88PHC6Jx999QpQVA-1; Wed, 27 Sep 2023 05:10:48 -0400
X-MC-Unique: ycNb7q88PHC6Jx999QpQVA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-774086da4dbso1973210985a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 02:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695805848; x=1696410648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FEc9tu44wr+kO4Y7p6VCimXRxM5Q8JJAq0FImguaUY=;
 b=VU1xEDniFRLkdkv/O486dv94dncA0BVaW2Ho5kgJyAw8eQA/OQHe4WbLAKPkSwOlyJ
 LJl9OPtfBEh1zOJb5bfEarPrx0JXlMAyjxnPz8u8KKq3MqL0lM8TYPbARVDMWDInyjGC
 GXllSbrA/L9PsFn8kE+5bGwoN/Madn5B1nh9cwyQw/43H0udjUsXn98mQ2XuIezuYwhp
 CkGgJ6pMGTno/JyvHRWbOnulDfx2zW8xB0x9Od+Oip73QsDnfv2Aklcb+iGZM4sh7wEv
 qaqsArCc2tDqBg/ObkIVFPeI7uH+Xhx+fZ/OpkvO8J9ZJwUo5Ci7Trr5/VobJlwyxT4J
 ddvA==
X-Gm-Message-State: AOJu0YxV6anu/DrD2ApZ2RkOD7eWS0YIftg17HsxvuNd4DlE2lTu9bgc
 q0GsnSeKkEAdPqurc/mQv1f75VD3XsB5sbjUcJMz+ceG6FjHTomUZoYxYN8et+N7BD3ze2Ffwjv
 Bxr/W9+1z8IZHMG0=
X-Received: by 2002:a0c:e284:0:b0:656:1eed:5e4a with SMTP id
 r4-20020a0ce284000000b006561eed5e4amr1444700qvl.46.1695805847614; 
 Wed, 27 Sep 2023 02:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbv670c+vRTv2AYcJmDlVePCkdntX7kz2IWrrKi3cIkOAWPBnquV8x4mJwXUMuYSAHiqgo8A==
X-Received: by 2002:a0c:e284:0:b0:656:1eed:5e4a with SMTP id
 r4-20020a0ce284000000b006561eed5e4amr1444687qvl.46.1695805847289; 
 Wed, 27 Sep 2023 02:10:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a0cf3c5000000b0065cfec43097sm271191qvm.39.2023.09.27.02.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 02:10:46 -0700 (PDT)
Message-ID: <228e1e52-03e2-892b-2b18-8640ec65130f@redhat.com>
Date: Wed, 27 Sep 2023 11:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/12] vfio/platform: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-8-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

On 9/26/23 13:32, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
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
> ---
>  hw/vfio/platform.c   | 43 +++----------------------------------------
>  hw/vfio/trace-events |  1 -
>  2 files changed, 3 insertions(+), 41 deletions(-)
>
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 5af73f9287..8e3d4ac458 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -529,12 +529,7 @@ static VFIODeviceOps vfio_platform_ops = {
>   */
>  static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>  {
> -    VFIOGroup *group;
> -    VFIODevice *vbasedev_iter;
> -    char *tmp, group_path[PATH_MAX], *group_name;
> -    ssize_t len;
>      struct stat st;
> -    int groupid;
>      int ret;
>  
>      /* @sysfsdev takes precedence over @host */
> @@ -557,47 +552,15 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>          return -errno;
>      }
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
Here also on error path we are leaking both vbasedev->name and
vbasedev->sysfsdev. This is independent on this patch
care must be taken because vdev->vbasedev.name is used in the caller
(vfio_platform_realize) to output the error msg
deallocation could happen there?

Eric
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
>      if (ret) {
> -        vfio_put_group(group);
>          return ret;
>      }
>  
>      ret = vfio_populate_device(vbasedev, errp);
>      if (ret) {
> -        vfio_put_group(group);
> +        vfio_detach_device(vbasedev);
>      }
>  
>      return ret;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e710026a73..3ac914854b 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,7 +120,6 @@ vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size
>  vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>  
>  # platform.c
> -vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
>  vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
>  vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
>  vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"


