Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2207B8DC3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo819-0000nM-JF; Wed, 04 Oct 2023 15:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo817-0000iy-D7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo815-0002NA-EE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696449522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKBf5vCPL5p0wmnmvDgBoFRPhzhwwXfvYV2rXLpLo2M=;
 b=c8vcpIyiTMShC/+j8p1qL5FQdS8LmyHjmxsK8Io1ZM+13/cmGbbsl51C445CcDfxadyT7d
 dDFS14dcsO5lCFvcv0SC24kA5/9YmjJf+FlJHfc0l2auLLATXn3B8zQ+D8nsq0r43Gkc1w
 EB7fq47QOzNHoEEKficjUSA8EY91mPM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-SMaTYZlpMqKLnMmnKjJXbQ-1; Wed, 04 Oct 2023 15:58:40 -0400
X-MC-Unique: SMaTYZlpMqKLnMmnKjJXbQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740bc7ad6fso28942585a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 12:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696449520; x=1697054320;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IKBf5vCPL5p0wmnmvDgBoFRPhzhwwXfvYV2rXLpLo2M=;
 b=n/6Zv2Psyup/4Wm5SiymHgPzGeJoigXe6YEIfU9Qb1Vt1jGkUlngVLofnj2q5Xf4MR
 CmmPpmsz2tB1KG1QtsUjG7u//JOJ157WSRS1MKkho0tOpWCiD6Jk8qRj/MUVeVHD43WD
 IoNkBF8lZWjbjReZu9KXBUQmz7IyqWV79qeYE5676MdUoa9Rio6ckuXGA1hxd9COt+hU
 egB1meDFbQQoOTznD0OJRZY6936X/uP9sqPAhNT1kWf5Q57MRiggy4Git+fJ6H4FxDg3
 F00sQL52k/kGIqNTNNfegf6DSWruj1lI43pdhn9fov/inw0XTiAuGrtkZml5P9KQ0Ywq
 V6Nw==
X-Gm-Message-State: AOJu0YyrWZ0hYfohzPo/N48YHPC19XFrWcpa3llyHZb/UjNBU1s0Twg0
 Jac7ZvqGEHrwqAqmVJQgMJ2PoUjkzApnMkgxl95veYW/yjtBEhE1wVp+9NSOJcaiwZNokAlw26E
 gY4NCWgJM6PoL27c=
X-Received: by 2002:a05:620a:4487:b0:775:9a54:a02b with SMTP id
 x7-20020a05620a448700b007759a54a02bmr3625135qkp.64.1696449520405; 
 Wed, 04 Oct 2023 12:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBw6tUy+wKk2b007rh6Q8iItDIC9n/k24QiJhpWBDrKV9uUrETb+qX67MY67xJP8onfNjgw==
X-Received: by 2002:a05:620a:4487:b0:775:9a54:a02b with SMTP id
 x7-20020a05620a448700b007759a54a02bmr3625107qkp.64.1696449520101; 
 Wed, 04 Oct 2023 12:58:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w16-20020ae9e510000000b0077411a459a8sm1503603qkf.4.2023.10.04.12.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 12:58:39 -0700 (PDT)
Message-ID: <81ead96c-e7e7-2d38-db77-264d7aee924a@redhat.com>
Date: Wed, 4 Oct 2023 21:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/15] Prerequisite changes for IOMMUFD support
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
References: <20231004154518.334760-1-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231004154518.334760-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 10/4/23 17:43, Eric Auger wrote:
> Hi All,
> 
> With the agreement of Zhenzhong, here is a v3 respin of the IOMMUFD
> prerequisite series. This applies on top of vfio-next:
> https://github.com/legoater/qemu/, branch vfio-next.
> 
> Per Cédric's suggestion, the IOMMUFD patchset v1[1] is now split
> into two series, this prerequisite series and the new IOMMUFD backend
> introduction support series. Hopefully this will ease the review.
> 
> The main purpose of this series is to make "common.c" group agnostic:
> all group related code are moved into container.c. Then we are prepared
> for next series, abstract base container, adding new backend, etc.
> 
> This series can be found at
> https://github.com/eauger/qemu/tree/prereq_v4
> 
> Test done:
> - PCI device were tested
> - device hotplug test
> - with or without vIOMMU
> - VFIO migration with a E800 net card(no dirty sync support) passthrough
> - platform and ccw were only compile-tested due to environment limit
> 
> Zhenzhong, Yi, Eric

LGTM, I did a small adjustment in vfio_detach_device() in patches 13+15.

Applied to vfio-next.

Thanks,

C.


> [1] https://lore.kernel.org/all/20230830103754.36461-1-zhenzhong.duan@intel.com/t/#u
> 
> Changelog:
> 
> v4:
> - include qemu/error-report.h in helpers.c
> - in ap.c, fix the wrongly added
>    vfio_detach_device(vbasedev) and g_free(vbasedev->name);
>    also added error_prepend
> - simplified vbasedev setting in ccw.c
> - vfio_detach_device: dropped check on
>    !vbasedev->container
> - container.c: restore dropped comment
> 
> v3:
> - rebased on vfio-next as suggested by Cedric
> - added vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
> - collected Cedric's R-b
> - Fix some error paths in vfio/cpi which now properly detach the device
>    and also free the vbasedev->name
> - Fix vfio/ccw migration (hopefully) [Matthew inputs]
> - Split [PATCH v2 11/12] vfio/common: Introduce two kinds of VFIO device lists
>    into 3 patches
> 
> v2:
> - Refine patch description per Eric
> - return errno and errp in vfio_kvm_device_[add/del]_fd per Eric
> - make memory listener register/deregister in seperate patch per Eric
> - Include the .h file first per Cédric
> - Add trace event in vfio_attach_device per Cédric
> - drop the change to vfio_viommu_preset by refactor per Cédric
> - Introduce global VFIO device list and per container list per Alex
> 
> Note changelog below are from full IOMMUFD series:
> 
> v1:
> - Alloc hwpt instead of using auto hwpt
> - elaborate iommufd code per Nicolin
> - consolidate two patches and drop as.c
> - typo error fix and function rename
> 
> rfcv4:
> - rebase on top of v8.0.3
> - Add one patch from Yi which is about vfio device add in kvm
> - Remove IOAS_COPY optimization and focus on functions in this patchset
> - Fix wrong name issue reported and fix suggested by Matthew
> - Fix compilation issue reported and fix sugggsted by Nicolin
> - Use query_dirty_bitmap callback to replace get_dirty_bitmap for better
> granularity
> - Add dev_iter_next() callback to avoid adding so many callback
>    at container scope, add VFIODevice.hwpt to support that
> - Restore all functions back to common from container whenever possible,
>    mainly migration and reset related functions
> - Add --enable/disable-iommufd config option, enabled by default in linux
> - Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
> - Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
> - vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove
> redundant code
> - Add FD passing support for vfio device backed by IOMMUFD
> - Fix hot unplug resource leak issue in vfio_legacy_detach_device()
> - Fix FD leak in vfio_get_devicefd()
> 
> rfcv3:
> - rebase on top of v7.2.0
> - Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
>    VFIO backends
> - Fix use after free in error path, reported by Alister
> - Split common.c in several steps to ease the review
> 
> rfcv2:
> - remove the first three patches of rfcv1
> - add open cdev helper suggested by Jason
> - remove the QOMification of the VFIOContainer and simply use standard ops
> (David)
> - add "-object iommufd" suggested by Alex
> 
> Thanks
> Zhenzhong
> 
> 
> Eric Auger (7):
>    scripts/update-linux-headers: Add iommufd.h
>    vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
>    vfio/common: Introduce vfio_container_add|del_section_window()
>    vfio/pci: Introduce vfio_[attach/detach]_device
>    vfio/platform: Use vfio_[attach/detach]_device
>    vfio/ap: Use vfio_[attach/detach]_device
>    vfio/ccw: Use vfio_[attach/detach]_device
> 
> Yi Liu (2):
>    vfio/common: Move IOMMU agnostic helpers to a separate file
>    vfio/common: Move legacy VFIO backend code into separate container.c
> 
> Zhenzhong Duan (6):
>    linux-headers: Add iommufd.h
>    vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>    vfio/common: Move VFIO reset handler registration to a group agnostic
>      function
>    vfio/common: Introduce a per container device list
>    vfio/common: Store the parent container in VFIODevice
>    vfio/common: Introduce a global VFIODevice list
> 
>   include/hw/vfio/vfio-common.h   |   60 +-
>   linux-headers/linux/iommufd.h   |  444 ++++++++
>   hw/vfio/ap.c                    |   69 +-
>   hw/vfio/ccw.c                   |  122 +-
>   hw/vfio/common.c                | 1851 ++-----------------------------
>   hw/vfio/container.c             | 1157 +++++++++++++++++++
>   hw/vfio/helpers.c               |  612 ++++++++++
>   hw/vfio/pci.c                   |   67 +-
>   hw/vfio/platform.c              |   43 +-
>   hw/vfio/meson.build             |    2 +
>   hw/vfio/trace-events            |    4 +-
>   scripts/update-linux-headers.sh |    3 +-
>   12 files changed, 2458 insertions(+), 1976 deletions(-)
>   create mode 100644 linux-headers/linux/iommufd.h
>   create mode 100644 hw/vfio/container.c
>   create mode 100644 hw/vfio/helpers.c
> 


