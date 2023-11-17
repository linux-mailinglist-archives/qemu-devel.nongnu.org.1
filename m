Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D27EF32A
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 13:59:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3yR8-0005Pt-Pc; Fri, 17 Nov 2023 07:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3yQz-0005N4-Ql
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3yQy-0007l5-02
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 07:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700225934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmvDnzn+nudHMUHN+IVqUsSYUiBvOg3k8FDa6m3FW9Y=;
 b=WhPh4/m8nAzK2YwhIel+RxF2/WS4Vl8ptMGc5IcfjgIcj8MQ9S5s/L47jZsaPpzyfuC9lw
 1CJ1cX/VUbDh2l2MNZeNZv02+MHwTkapqbgV2pCSwPdQT5Cm7FLrXvj2BKo3XDygs1jACP
 oAtx0tz1JCk1vebTsWSmCusQHITCZ1s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-GjKKQWzxM8yzXq6LahYt6Q-1; Fri, 17 Nov 2023 07:58:52 -0500
X-MC-Unique: GjKKQWzxM8yzXq6LahYt6Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5c7047f5ee7so11489427b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 04:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700225932; x=1700830732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmvDnzn+nudHMUHN+IVqUsSYUiBvOg3k8FDa6m3FW9Y=;
 b=ZbdNzj1KevOjzpeYn83UeTcsMyyB0dhWtqgLzMsduN9qtbm/54B8vm0cxhLkbq7u59
 uwhxxqRoreR+aKxgTIGypC4LLyOzVvvCjkwchDoGetHevQyTSvbbLAIP3dzD1LRIV4cl
 pJRnFEDrrEHhDerQsNyQUTc5gbF1MxCMgWd8023kNVLcPgr0TjPaFR920ymb6qgFwscT
 X80iyjIH03kWrBa+0mO23hWPwe2ilGlKM74q0RNyPFO3CXIKzFARl5Ug0u1xy8t4+SSA
 I6VPckMXlce2Q6fA6VckgMwsxGmCl6juyPsBVkGLwGjQXYziUXwJ0h492YsIfLehwSsJ
 a3nQ==
X-Gm-Message-State: AOJu0Yzd6bRC7MZEIaEXb8tryLTSa1TpfJ32iXUVhk4RaxJpabPsPxJN
 MOZLCrYJXZw4Ex/uYd/3YCQ+EP3C6BrqCImPNzPWLB3y5Sr0aJHVTFvirh7Rr0YlZn7ScsQtQjX
 ZtXSBaYHz7kD6kWM=
X-Received: by 2002:a25:32cf:0:b0:da3:76d3:e4fb with SMTP id
 y198-20020a2532cf000000b00da376d3e4fbmr16407600yby.26.1700225932155; 
 Fri, 17 Nov 2023 04:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4RpyMq0bnUl03FlBJOQJeahl6ZRUOW0gaQyGPuRsgV+7pPPIIxz1wTeftXs0YKcoM6ompGw==
X-Received: by 2002:a25:32cf:0:b0:da3:76d3:e4fb with SMTP id
 y198-20020a2532cf000000b00da376d3e4fbmr16407582yby.26.1700225931832; 
 Fri, 17 Nov 2023 04:58:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 jy13-20020a0562142b4d00b0065b229ecb8dsm609510qvb.3.2023.11.17.04.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 04:58:51 -0800 (PST)
Message-ID: <9e2a138d-48b1-47d1-88f5-2794c3692854@redhat.com>
Date: Fri, 17 Nov 2023 13:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Add VFIO iommufd backend documentation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231117093512.1999666-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231117093512.1999666-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/17/23 10:35, Zhenzhong Duan wrote:
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

The content looks good but it lacks formatting. Please try to generate
the docs.

Thanks,

C.


> ---
>   MAINTAINERS                    |   1 +
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/vfio-iommufd.rst    | 115 +++++++++++++++++++++++++++++++++
>   3 files changed, 117 insertions(+)
>   create mode 100644 docs/devel/vfio-iommufd.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d86ba56a49..07990456ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2175,6 +2175,7 @@ F: backends/iommufd.c
>   F: include/sysemu/iommufd.h
>   F: include/qemu/chardev_open.h
>   F: util/chardev_open.c
> +F: docs/devel/vfio-iommufd.rst
>   
>   vhost
>   M: Michael S. Tsirkin <mst@redhat.com>
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index 6f81df92bc..3def4a138b 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -18,5 +18,6 @@ Details about QEMU's various subsystems including how to add features to them.
>      s390-dasd-ipl
>      tracing
>      vfio-migration
> +   vfio-iommufd
>      writing-monitor-commands
>      virtio-backends
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> new file mode 100644
> index 0000000000..59804a7f26
> --- /dev/null
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -0,0 +1,115 @@
> +===============================
> +IOMMUFD BACKEND usage with VFIO
> +===============================
> +
> +(Same meaning for backend/container/BE)
> +
> +With the introduction of iommufd, the Linux kernel provides a generic
> +interface for user space drivers to propagate their DMA mappings to kernel
> +for assigned devices. While the legacy kernel interface is group-centric,
> +the new iommufd interface is device-centric, relying on device fd and iommufd.
> +
> +To support both interfaces in the QEMU VFIO device, introduce a base container
> +to abstract the common part of VFIO legacy and iommufd container. So that the
> +generic VFIO code can use either container.
> +
> +The base container implements generic functions such as memory_listener and
> +address space management whereas the derived container implements callbacks
> +specific to either legacy or iommufd. Each container has its own way to setup
> +secure context and dma management interface. The below diagram shows how it
> +looks like with both containers.
> +
> +                    VFIO                           AddressSpace/Memory
> +    +-------+  +----------+  +-----+  +-----+
> +    |  pci  |  | platform |  |  ap |  | ccw |
> +    +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
> +        |           |           |        |        |   AddressSpace       |
> +        |           |           |        |        +------------+---------+
> +    +---V-----------V-----------V--------V----+               /
> +    |           VFIOAddressSpace              | <------------+
> +    |                  |                      |  MemoryListener
> +    |        VFIOContainerBase list           |
> +    +-------+----------------------------+----+
> +            |                            |
> +            |                            |
> +    +-------V------+            +--------V----------+
> +    |   iommufd    |            |    vfio legacy    |
> +    |  container   |            |     container     |
> +    +-------+------+            +--------+----------+
> +            |                            |
> +            | /dev/iommu                 | /dev/vfio/vfio
> +            | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
> +Userspace   |                            |
> +============+============================+===========================
> +Kernel      |  device fd                 |
> +            +---------------+            | group/container fd
> +            | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
> +            |  ATTACH_IOAS) |            | device fd
> +            |               |            |
> +            |       +-------V------------V-----------------+
> +    iommufd |       |                vfio                  |
> +(map/unmap  |       +---------+--------------------+-------+
> +ioas_copy)  |                 |                    | map/unmap
> +            |                 |                    |
> +     +------V------+    +-----V------+      +------V--------+
> +     | iommfd core |    |  device    |      |  vfio iommu   |
> +     +-------------+    +------------+      +---------------+
> +
> +[Secure Context setup]
> +- iommufd BE: uses device fd and iommufd to setup secure context
> +              (bind_iommufd, attach_ioas)
> +- vfio legacy BE: uses group fd and container fd to setup secure context
> +                  (set_container, set_iommu)
> +
> +[Device access]
> +- iommufd BE: device fd is opened through /dev/vfio/devices/vfioX
> +- vfio legacy BE: device fd is retrieved from group fd ioctl
> +
> +[DMA Mapping flow]
> +1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
> +2. VFIO populates DMA map/unmap via the container BEs
> +   *) iommufd BE: uses iommufd
> +   *) vfio legacy BE: uses container fd
> +
> +
> +Example configuration
> +=====================
> +
> +Step 1: configure the host device
> +---------------------------------
> +
> +It's exactly same as the VFIO device with legacy VFIO container.
> +
> +Step 2: configure QEMU
> +----------------------
> +
> +Interactions with the /dev/iommu are abstracted by a new
> +iommufd object (compiled in with the CONFIG_IOMMUFD option).
> +
> +Any QEMU device (e.g. VFIO device) wishing to use /dev/iommu must be
> +linked with an iommufd object. It gets a new optional property named
> +iommufd which allows to pass an iommufd object. Take vfio-pci device
> +for example:
> +
> +    -object iommufd,id=iommufd0
> +    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> +
> +Note the /dev/iommu and VFIO cdev can be externally opened by a
> +management layer. In such a case the fd is passed, the fd supports
> +a string naming the fd or a number, for example:
> +
> +    -object iommufd,id=iommufd0,fd=22
> +    -device vfio-pci,iommufd=iommufd0,fd=23
> +
> +If the fd property is not passed, the fd is opened by QEMU.
> +
> +If no iommufd property is passed to the vfio-pci device, iommufd is
> +not used and the user gets the behavior based on the legacy VFIO
> +container:
> +
> +    -device vfio-pci,host=0000:02:00.0
> +
> +Supported platform
> +==================
> +
> +Supports X86, ARM and S390X currently.


