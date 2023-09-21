Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BB7A9462
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjIzi-0005qo-Mo; Thu, 21 Sep 2023 08:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjIz6-00056q-1H
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjIyp-0008Eh-AI
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695300001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YI/TFRSQUeTMHk6S+cDjjGaptn3sAcd8KyKM8ZamRc=;
 b=MwukaZzB+imUbKbbpHKOC9qzJ3tprkVNT0c5/7fV/7ZSIfzK+sDLjbj8HPGP+JHE/bh0Oy
 0sQHxbQaLngaAJZjtq5uuaDAxPSdKMgqO1/Ss1qLQ5kYA1MHf/IWu90/2S529Tcit9oPvc
 89sph7SRx7k1BUUeHzAOG2BPo1gIJzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-8dgHD4F8Of6KXGZ3kSiTlA-1; Thu, 21 Sep 2023 08:18:01 -0400
X-MC-Unique: 8dgHD4F8Of6KXGZ3kSiTlA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3eaa5c5eso573779f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695298680; x=1695903480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YI/TFRSQUeTMHk6S+cDjjGaptn3sAcd8KyKM8ZamRc=;
 b=sRQAlW8nVHirTzq/uJM4R+cWe6uLRlEFpgxxe7D0JvB0o4mMhR7wwIvKmZr2c8YDME
 XemLuSeEPiCPmPIdthGsCJid1DTGwmqkYPsmRGCuzN/aTci60f15Njggr9gZY6ec6AGm
 trPZuTQD052hDam51LVDXWucOM/0zdSInzUOPD/Zd/e3ggp36mVd1KKeVaDPE3eQw10e
 Qmv5Q4U39+vWd0G3OJ4MLHIiMl8hMM7KJqWXgSibHJ7sGwzjYC2wG7TsqDCoQWZtzJW8
 b+W/4kI28JxJ7j2UriBBbPNWASjMqEUJpqiH9mnTQdJudSQy50MCoYunGfnUf6jrQniV
 iefQ==
X-Gm-Message-State: AOJu0YwYOk0NHkqb3qxAjtdfh/1Bgzedho3Cy69PowBx1sAuUaIT66Ib
 NQtoLCwwckNupglYKz00dl03s/DAgrchMccQCZ0zXObw8PpnNrGARTDckgOAYOJxmvlejA2pfey
 RUvi+z42obdiYw/s=
X-Received: by 2002:a5d:4e92:0:b0:321:4790:bb5e with SMTP id
 e18-20020a5d4e92000000b003214790bb5emr4520232wru.38.1695298680019; 
 Thu, 21 Sep 2023 05:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx4mM/d6cJQ0CuDo5MNIPjQFKKVLvqPRNbvKSL+CcT63iKz7KMWSNPzMy8iGrqC2k/z4DxMw==
X-Received: by 2002:a5d:4e92:0:b0:321:4790:bb5e with SMTP id
 e18-20020a5d4e92000000b003214790bb5emr4520204wru.38.1695298679598; 
 Thu, 21 Sep 2023 05:17:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a5d4d81000000b003140f47224csm1625565wru.15.2023.09.21.05.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 05:17:59 -0700 (PDT)
Message-ID: <389ab74e-580b-a63d-e81b-c8291342f29a@redhat.com>
Date: Thu, 21 Sep 2023 14:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 10/22] vfio/platform: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-11-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Let the vfio-platform device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/platform.c   | 43 ++++---------------------------------------
>   hw/vfio/trace-events |  2 +-
>   2 files changed, 5 insertions(+), 40 deletions(-)

Nice cleanup. As said earlier, the realize trace events could be kept.

Thanks,

C.


> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 5af73f9287..5c08c39315 100644
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
> @@ -557,47 +552,17 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>           return -errno;
>       }
>   
> -    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
> -    len = readlink(tmp, group_path, sizeof(group_path));
> -    g_free(tmp);
> +    trace_vfio_platform_base_device_init(vbasedev->name);
>   
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
> index 8016d9f0d2..bd32970854 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -124,7 +124,7 @@ vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size
>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # platform.c
> -vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
> +vfio_platform_base_device_init(char *name) "%s"
>   vfio_platform_realize(char *name, char *compat) "vfio device %s, compat = %s"
>   vfio_platform_eoi(int pin, int fd) "EOI IRQ pin %d (fd=%d)"
>   vfio_platform_intp_mmap_enable(int pin) "IRQ #%d still active, stay in slow path"


