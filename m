Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84E7A7B36
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiviI-0002YA-E0; Wed, 20 Sep 2023 07:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qivi1-0002UP-Gb
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qivhy-0007OE-P0
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695210562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7jayTL4GBmJdF3YpFhuIscnWAfBg48DHJ//bz0xIY8=;
 b=FhX/XmGxgM6MMQ8FIsKpqtarHe/96BPyeAJR5+Nahp8dQK/mWxCh7EIXnOlPe0/WxekEOU
 h276Lhn1bE7KPslju+Hf895FeLhce/HfLfPQmtDcOA5pTGgqAPoJ1B6oz1no/xhdlq96l1
 JGaGFmNu6J1A6IW6Poe6lq0lrP4X++8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-il_IIVs3N3qfCNrjabQmCw-1; Wed, 20 Sep 2023 07:49:18 -0400
X-MC-Unique: il_IIVs3N3qfCNrjabQmCw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31fd49d8f2aso4352117f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695210557; x=1695815357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z7jayTL4GBmJdF3YpFhuIscnWAfBg48DHJ//bz0xIY8=;
 b=g4RJ2fdKHmt/H/tKxwMMtOuRBid355wx5pfZs7doXPhPGMmOJzG9bPUMmV3yqpIh3D
 xLMx77fqMuvPepCHhOF5oou2IjtkUY2uFCHa5apGsVX9Hg5yEiV0ygUgVQbm+OpS0Vub
 +grPm6lo8fyz49iEf0LkoE64+UxS6/vGLTLJrz8qRmSiV2yFGUT7V8poYsz/gWG3uxEe
 ArSzO4DAfpfh2AzJuVBMJpt+bbVSHQkiHxvkW0rJxXKLrY0uNx+PMlT/oJ8HllfXd1lH
 eiP6ut4Nj0hc4AnTEhs1dTuiIt0vBlcEX6rv5x7YL6eaBWIa3GNIbs1aVmdpRMi6aXt/
 jhBg==
X-Gm-Message-State: AOJu0YxcBKJtVahgl+VWzvYsjaQqSssSkm13v/kNhgVPB+h6fVtkIcDD
 sUScaldhDlp7190thcRDk6erM0VmrRUNcYAY9Ho0IfkOPeaOEuX3fd0Uhc1oyVEmcyNtOqy3kep
 OASNHoVa29UlBb1Q=
X-Received: by 2002:a5d:494f:0:b0:31c:84e9:20fd with SMTP id
 r15-20020a5d494f000000b0031c84e920fdmr2489020wrs.13.1695210557722; 
 Wed, 20 Sep 2023 04:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1gEJHX6WNlgEhFdiWlCaEAHT2NJQgld0aXoxYuMiCDcIMwgvGOIFOvrP5AT1r1VsQPMG+Gw==
X-Received: by 2002:a5d:494f:0:b0:31c:84e9:20fd with SMTP id
 r15-20020a5d494f000000b0031c84e920fdmr2488993wrs.13.1695210557331; 
 Wed, 20 Sep 2023 04:49:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w7-20020adfec47000000b0031fba0a746bsm11196235wrn.9.2023.09.20.04.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 04:49:16 -0700 (PDT)
Message-ID: <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
Date: Wed, 20 Sep 2023 13:49:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230830103754.36461-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Zhenzhong,

On 8/30/23 12:37, Zhenzhong Duan wrote:
> ...which will be used by both legacy and iommufd backend.
I prefer genuine sentences in the commit msg. Also you explain what you
do but not why.

suggestion: Introduce two new helpers, vfio_kvm_device_[add/del]_fd
which take as input a file descriptor which can be either a group fd or
a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
which aliases to the legacy KVM_DEV_VFIO_GROUP.

vfio_kvm_device_add/del_group then call those new helpers.



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
can't you return -errno?
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
Since vfio_kvm_device_add_fd now returns an error value, it's a pity not
to use it and propagate it. Also you could fill an errp with the error
msg and use it in vfio_connect_container(). But this is a new error
handling there.
> +}
> +
> +int vfio_kvm_device_del_fd(int fd)
not sure we want this to return an error. But if we do, I think it would
be nicer to propagate the error up.
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
-errno?
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
Thanks

Eric


