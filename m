Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEFE7AFBB1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 09:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOfD-0007vm-BQ; Wed, 27 Sep 2023 03:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlOf4-0007s0-Kf
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlOf2-0001x9-Uq
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695798520;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE+CA76T8nIttMH7fBe27SOuLABpEAgsI8JSbczGin8=;
 b=Fh9nrHEH8Woq/W21ACt4JfJT0xyfnarwv/C5JhuXz8S2Nj/PJ5svZUy1gDrKqMIR+5N8wI
 7RbxsH1YMdmgL1DeiI7Oe563XpW+N/dH7MLhJaZOlZ4tv7T4ZblkMrjtbCY3DdD/KOLmRg
 iaGRBNHuqm0juoAHtnphNAL+8uDkeRw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-doqRhxiQPfWj_kBQ0Fekbw-1; Wed, 27 Sep 2023 03:08:38 -0400
X-MC-Unique: doqRhxiQPfWj_kBQ0Fekbw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b107812f0so99687486d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 00:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695798518; x=1696403318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aE+CA76T8nIttMH7fBe27SOuLABpEAgsI8JSbczGin8=;
 b=m2N3ZexrIsMDk1VC+CRwZQ8Oe/nUmaOJkahhi8QTqM6b/jUBaZLrmY4Y4xuKiLOOJ5
 ZFX2n56LbdnERMOfHaj9HJ5KqV2gt6s9Ka0IWq+1WZOdVK18KXXLVsjIEsMS0OA5Ou9m
 N8yz4Zzz5kq3GIuaT0nB6H6zFVPyDlFh97VTR1+N/Xk6RZQelpNMpZgbJLPQzFNHmzJe
 YAZJU1UOvzFEDw+w8LKtJ+E/fG9sbGDr6zxAzRJRh59MI8PSJzi4zUJCnkHjE+O0oLhx
 LAuzw/KG6IDLF7iV0G5wTLWW1K4jc/hJIypSrajcfnTs7LSWhczbxXAZ+VuMrBOaShbv
 T/Ng==
X-Gm-Message-State: AOJu0YzX5i2ng2mRyWFGgIaUkoar0y+N3a7gDdXjyI7tCq6js+0gNAHN
 GAueNuCSP03yZsP2j4k2xbOGlU+qMs3R4SkpAnBlpMIwcVSXqSVB7uc4voiWYk0xVcrHEIdSP+H
 WhBGlnjEEeKI33Y8=
X-Received: by 2002:a0c:df88:0:b0:658:4cae:b43a with SMTP id
 w8-20020a0cdf88000000b006584caeb43amr1117784qvl.4.1695798517918; 
 Wed, 27 Sep 2023 00:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMCs0bo6px3pAvbgSRUBDcBFRMutsmnMD/coDcM+TYa0bJUYCjecIft8YUnKvh5tyUquPWGA==
X-Received: by 2002:a0c:df88:0:b0:658:4cae:b43a with SMTP id
 w8-20020a0cdf88000000b006584caeb43amr1117769qvl.4.1695798517593; 
 Wed, 27 Sep 2023 00:08:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a0ce3ce000000b0065b0771f2edsm2863010qvl.136.2023.09.27.00.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 00:08:36 -0700 (PDT)
Message-ID: <a5f714a2-8310-6049-9ced-f2291390a4be@redhat.com>
Date: Wed, 27 Sep 2023 09:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/12] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-6-zhenzhong.duan@intel.com>
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

On 9/26/23 13:32, Zhenzhong Duan wrote:
> Introduce two new helpers, vfio_kvm_device_[add/del]_fd
> which take as input a file descriptor which can be either a group fd or
> a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
> which aliases to the legacy KVM_DEV_VFIO_GROUP.
>
> vfio_kvm_device_[add/del]_group then call those new helpers.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h |  3 ++
>  hw/vfio/common.c              | 55 +++++++++++++++++++++++++----------
>  2 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index e0483893d1..c4e7c3b4a7 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -226,6 +226,9 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp);
>  
> +int vfio_kvm_device_add_fd(int fd, Error **errp);
> +int vfio_kvm_device_del_fd(int fd, Error **errp);
> +
>  extern const MemoryRegionOps vfio_region_ops;
>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>  extern VFIOGroupList vfio_group_list;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index de6b4a86e2..959b1362bb 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1818,17 +1818,17 @@ void vfio_reset_handler(void *opaque)
>      }
>  }
>  
> -static void vfio_kvm_device_add_group(VFIOGroup *group)
> +int vfio_kvm_device_add_fd(int fd, Error **errp)
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
> @@ -1837,38 +1837,61 @@ static void vfio_kvm_device_add_group(VFIOGroup *group)
>          };
>  
>          if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> -            error_report("Failed to create KVM VFIO device: %m");
> -            return;
> +            error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
> +            return -errno;
>          }
>  
>          vfio_kvm_device_fd = cd.fd;
>      }
>  
>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -        error_report("Failed to add group %d to KVM VFIO device: %m",
> -                     group->groupid);
> +        error_setg_errno(errp, errno, "Failed to add fd %d to KVM VFIO device",
> +                         fd);
> +        return -errno;
>      }
>  #endif
> +    return 0;
>  }
>  
> -static void vfio_kvm_device_del_group(VFIOGroup *group)
> +int vfio_kvm_device_del_fd(int fd, Error **errp)
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
> +        error_setg(errp, "KVM VFIO device isn't created yet");
> +        return -EINVAL;
>      }
>  
>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -        error_report("Failed to remove group %d from KVM VFIO device: %m",
> -                     group->groupid);
> +        error_setg_errno(errp, errno,
> +                         "Failed to remove fd %d from KVM VFIO device", fd);
> +        return -errno;
>      }
>  #endif
> +    return 0;
> +}
> +
> +static void vfio_kvm_device_add_group(VFIOGroup *group)
> +{
> +    Error *err = NULL;
> +
> +    if (vfio_kvm_device_add_fd(group->fd, &err)) {
> +        error_reportf_err(err, "group ID %d: ", group->groupid);
> +    }
> +}
> +
> +static void vfio_kvm_device_del_group(VFIOGroup *group)
> +{
> +    Error *err = NULL;
> +
> +    if (vfio_kvm_device_del_fd(group->fd, &err)) {
> +        error_reportf_err(err, "group ID %d: ", group->groupid);
> +    }
>  }
>  
>  static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
Looks good to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


