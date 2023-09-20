Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883267A8E9D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4vR-0002fi-NR; Wed, 20 Sep 2023 17:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj4vP-0002cH-7R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qj4vN-00070t-Jb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695245996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWeKYqAZXzxf6jFEDqDNAw+oR+KESFV/DMldWwgcjW4=;
 b=b1yYtrJUOaXfZRI0brw9e1WC3wZc30Cbd/mAYUr5yY6t4XT9fGsckBSnbTAJRA0Ft2KlDv
 n3ZyOultRNEIQ3X0P/eUnI5Enh8gbDstDJqjUd3dIVl9F6uEQPuGzYwB6P4MVgasRStTZr
 lglmuOS2gR+jzc+3UDlg1qTvKFzD0Vk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-_HDLEEHrOWahCTjyquz17w-1; Wed, 20 Sep 2023 17:39:54 -0400
X-MC-Unique: _HDLEEHrOWahCTjyquz17w-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34fca40d0c7so1534825ab.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245994; x=1695850794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWeKYqAZXzxf6jFEDqDNAw+oR+KESFV/DMldWwgcjW4=;
 b=QVoMplaCbfWu7P7g/pfJbFk1FlOg9KwmabmwLqVgNgTk8yfKa3yIK9mJXMa4QDMQzL
 FRUf4iDgKpsr31wxK/J6t/OhGD34xYuBB8Xwg1kP0Ix6ad3MgNUelkbmXRF8rghrcopi
 J+mT+xEpHLdanDlOuno7AVilb4uVXfObFFJknsodZI7u3pEwAusLfZBGeSYHAoSD2T5X
 fzheoMkVDOtmexHDMHCyvF/fha8ug2+YMjrBl24EBH2tiSbmwEsM0+1V0l68rkR/AJkZ
 Mh3+tZY48apHRRPBtn8xtQr1RHS/ObG6vdp3bquWeRvo39Mb78Ohf2t+jIwuxJDe3C64
 SEbA==
X-Gm-Message-State: AOJu0Yw5znf9+avBdCULZXLK1tOfXSZfa3G/w1Firn+X8MUbJkD4qMWt
 DCVWY7mogMB9eGO8/BRLVbsZ6iwVRRCk4ChcTAJ4CCUpQb/znP0vtUApXseteixUcJTXuTtvBLe
 xMyw7bBzwgi3X7E8=
X-Received: by 2002:a05:6e02:1bcc:b0:34f:f373:ad7e with SMTP id
 x12-20020a056e021bcc00b0034ff373ad7emr4697878ilv.1.1695245994101; 
 Wed, 20 Sep 2023 14:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDi26MmEJku5YSqIiP2y8H8eyeJHSk7nxzxNK1PlkXC2npD0GpfDXmQBWjJeiB9E37vjFpQ==
X-Received: by 2002:a05:6e02:1bcc:b0:34f:f373:ad7e with SMTP id
 x12-20020a056e021bcc00b0034ff373ad7emr4697858ilv.1.1695245993798; 
 Wed, 20 Sep 2023 14:39:53 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 g25-20020a02b719000000b00439862fc2a7sm4040120jam.130.2023.09.20.14.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:39:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 15:39:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Message-ID: <20230920153951.2f2ebc1a.alex.williamson@redhat.com>
In-Reply-To: <20230830103754.36461-6-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Aug 2023 18:37:37 +0800
Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:

> ...which will be used by both legacy and iommufd backend.

+1 to Eric's comments regarding complete sentences in the commit log
and suggested description.

> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c              | 44 +++++++++++++++++++++++------------
>  include/hw/vfio/vfio-common.h |  3 +++
>  2 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 67150e4575..949ad6714a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1759,17 +1759,17 @@ void vfio_reset_handler(void *opaque)
>      }
>  }
>  
> -static void vfio_kvm_device_add_group(VFIOGroup *group)
> +int vfio_kvm_device_add_fd(int fd)

Returning int vs void looks gratuitous, nothing uses the return value
in this series.

>  {
>  #ifdef CONFIG_KVM
>      struct kvm_device_attr attr = {
> -        .group = KVM_DEV_VFIO_GROUP,
> -        .attr = KVM_DEV_VFIO_GROUP_ADD,
> -        .addr = (uint64_t)(unsigned long)&group->fd,
> +        .group = KVM_DEV_VFIO_FILE,
> +        .attr = KVM_DEV_VFIO_FILE_ADD,
> +        .addr = (uint64_t)(unsigned long)&fd,
>      };
>  
>      if (!kvm_enabled()) {
> -        return;
> +        return 0;
>      }
>  
>      if (vfio_kvm_device_fd < 0) {
> @@ -1779,37 +1779,51 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
>  
>          if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>              error_report("Failed to create KVM VFIO device: %m");
> -            return;
> +            return -ENODEV;
>          }
>  
>          vfio_kvm_device_fd = cd.fd;
>      }
>  
>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -        error_report("Failed to add group %d to KVM VFIO device: %m",
> -                     group->groupid);
> +        error_report("Failed to add fd %d to KVM VFIO device: %m",
> +                     fd);

It's not nearly as useful to report an fd# in the error log vs the
group#.  Thanks,

Alex

> +        return -errno;
>      }
>  #endif
> +    return 0;
>  }
>  
> -static void vfio_kvm_device_del_group(VFIOGroup *group)
> +static void vfio_kvm_device_add_group(VFIOGroup *group)
> +{
> +    vfio_kvm_device_add_fd(group->fd);
> +}
> +
> +int vfio_kvm_device_del_fd(int fd)
>  {
>  #ifdef CONFIG_KVM
>      struct kvm_device_attr attr = {
> -        .group = KVM_DEV_VFIO_GROUP,
> -        .attr = KVM_DEV_VFIO_GROUP_DEL,
> -        .addr = (uint64_t)(unsigned long)&group->fd,
> +        .group = KVM_DEV_VFIO_FILE,
> +        .attr = KVM_DEV_VFIO_FILE_DEL,
> +        .addr = (uint64_t)(unsigned long)&fd,
>      };
>  
>      if (vfio_kvm_device_fd < 0) {
> -        return;
> +        return -EINVAL;
>      }
>  
>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -        error_report("Failed to remove group %d from KVM VFIO device: %m",
> -                     group->groupid);
> +        error_report("Failed to remove fd %d from KVM VFIO device: %m",
> +                     fd);
> +        return -EBADF;
>      }
>  #endif
> +    return 0;
> +}
> +
> +static void vfio_kvm_device_del_group(VFIOGroup *group)
> +{
> +    vfio_kvm_device_del_fd(group->fd);
>  }
>  
>  static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5e376c436e..598c3ce079 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -220,6 +220,9 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp);
>  
> +int vfio_kvm_device_add_fd(int fd);
> +int vfio_kvm_device_del_fd(int fd);
> +
>  extern const MemoryRegionOps vfio_region_ops;
>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>  extern VFIOGroupList vfio_group_list;


