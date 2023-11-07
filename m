Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFEB7E4088
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:45:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MNP-0003WQ-Dn; Tue, 07 Nov 2023 08:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MNL-0003TL-3g
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MNJ-0005q5-Eo
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4A5NIE9XFZZVx2DZB0IIIaSU3ccWHSmI5yZcm7I+cA=;
 b=IIQyDkclQDfYyqDiqnuGdytQz4mxLE8qGw5av7tfh8j717jDmpE6c+RDxlpwS+WidRGFeR
 E5K5EVqC9SgDYCN7Moqhs7BUVZf72RaUz1fLmwkdMS8Bx8r4RhhmAE3ds1r/hGIkW0bkV0
 GZ3dWODalOVQCoGJdqnaqF+Up9ICCl4=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-oZZwvFWNMHmT-RL6x70Dbw-1; Tue, 07 Nov 2023 08:44:06 -0500
X-MC-Unique: oZZwvFWNMHmT-RL6x70Dbw-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4abfef1031cso1617625e0c.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699364646; x=1699969446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4A5NIE9XFZZVx2DZB0IIIaSU3ccWHSmI5yZcm7I+cA=;
 b=DU/ZYO2Yia+ncxkaeV1BKLoKrgmYZ/dLEfHylkD/JTq9z5ZokCPen0c4JlnhLQy+eW
 ZNoMjhuQaxE/AoA2Dp0hn0gzJxPeppeOn6qBANV9JH8xAR2mAO/YmeRZIEEacHqcnFyf
 b3imincjaMHuZH3j20Fv0Puh0Ljp/kPwSDWYDIEAQxAxLzPz7uGdCdtyqwqFQDwjprko
 tXQBsyhH640SK9hKQKCAMavcd6UJRtB60utSNWF8AztfbL75BHfDsfaCgp0ikFVoo1N+
 j9bj0Un544lf7bDJte9Xn/WtF+Tlolkp1XEGvCS/3o3Gjih3eK27RjkD1Ss+LC6TjOd/
 1ndQ==
X-Gm-Message-State: AOJu0YxMldX9ZIHrT1Q+++1NKVc6Tf3hFasdY9YfkVlAbNPza/LhJhhy
 6K8ATvxxIiW215p6tYdykipRF/tDemG/e0kNV/7Y6XlH3J5jkeaAnL4lQmZo7zGNC8RqMoY8Bw/
 Q6cQKbzXFgZloQsI=
X-Received: by 2002:a1f:a689:0:b0:4ac:174d:4d3d with SMTP id
 p131-20020a1fa689000000b004ac174d4d3dmr6472758vke.2.1699364645991; 
 Tue, 07 Nov 2023 05:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOgrbRzio6NukyJC1Y+NLRMY+E1C+zk1AVAdoVpyyfUn/NtlT0pl1Pm6ywKmBzojK+rn+YZQ==
X-Received: by 2002:a1f:a689:0:b0:4ac:174d:4d3d with SMTP id
 p131-20020a1fa689000000b004ac174d4d3dmr6472740vke.2.1699364645747; 
 Tue, 07 Nov 2023 05:44:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a05620a022d00b0077a02cf7949sm4204315qkm.32.2023.11.07.05.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:44:05 -0800 (PST)
Message-ID: <0c363b88-5e69-4fd7-a80b-bf9b7821263d@redhat.com>
Date: Tue, 7 Nov 2023 14:44:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 41/41] vfio: Compile out iommufd for PPC target
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-42-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-42-zhenzhong.duan@intel.com>
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

On 11/2/23 08:13, Zhenzhong Duan wrote:
> Since PPC doesn't support IOMMUFD, make iommufd related code
> compiled out.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Please drop this patch.

Instead, add

     imply IOMMUFD

in hw/{i386,s390x,arm}/Kconfig for platforms supporting IOMMUFD.

Thanks,

C.



> ---
>   hw/vfio/common.c     | 2 +-
>   hw/vfio/pci.c        | 2 +-
>   hw/vfio/platform.c   | 2 +-
>   backends/meson.build | 4 ++--
>   hw/vfio/meson.build  | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 1c9203183d..000717cef3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1504,7 +1504,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
>   {
>       const VFIOIOMMUOps *ops;
>   
> -#ifdef CONFIG_IOMMUFD
> +#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
>       if (vbasedev->iommufd) {
>           ops = &vfio_iommufd_ops;
>       } else
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d8f658ea47..2287e45119 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3550,7 +3550,7 @@ static Property vfio_pci_dev_properties[] = {
>                                      qdev_prop_nv_gpudirect_clique, uint8_t),
>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>                                   OFF_AUTOPCIBAR_OFF),
> -#ifdef CONFIG_IOMMUFD
> +#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>   #endif
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index aa0b2b9583..c8f4ae5a06 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -648,7 +648,7 @@ static Property vfio_platform_dev_properties[] = {
>       DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
>                          mmap_timeout, 1100),
>       DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
> -#ifdef CONFIG_IOMMUFD
> +#if defined(CONFIG_IOMMUFD) && !defined(TARGET_PPC)
>       DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>   #endif
> diff --git a/backends/meson.build b/backends/meson.build
> index 05ac57ff15..9dbdfa87f7 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -21,9 +21,9 @@ if have_vhost_user
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
>   if have_iommufd
> -  system_ss.add(files('iommufd.c'))
> +  system_ss.add(when: 'TARGET_PPC', if_false: files('iommufd.c'))
>   else
> -  system_ss.add(files('iommufd-stub.c'))
> +  system_ss.add(when: 'TARGET_PPC', if_false: files('iommufd-stub.c'))
>   endif
>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 9cae2c9e21..4423bb3cd4 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -8,7 +8,7 @@ vfio_ss.add(files(
>     'migration.c',
>   ))
>   if have_iommufd
> -  vfio_ss.add(files('iommufd.c'))
> +  vfio_ss.add(when: 'TARGET_PPC', if_false: files('iommufd.c'))
>   endif
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'display.c',


