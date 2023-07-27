Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7CC765ABC
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4Jh-0005vl-LA; Thu, 27 Jul 2023 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP4Jf-0005vb-TH
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qP4Je-0001NO-ER
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690477097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9XPyUvJXurY3nbwRDos0PfDbaqejKfC2NDwQgV0nLA=;
 b=NsrgtjRF+G9kh2+6mVF94gDcgul6cGxhM1FpDSShaI6YfdG/7vP0+iu6uGkt5bmJ0R+Fx5
 ebVbibCc7zccFB+irZ0WBjhnLqWxJaW4iWZdPVSRZFc1npT3BQvSs6yKIlEJsqMLOZz9Jb
 3TUrg7Cgzj3gz9pjN7a58jHlfbfgCTM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-0TVocsAJNti-JKQL6q-6-w-1; Thu, 27 Jul 2023 12:58:16 -0400
X-MC-Unique: 0TVocsAJNti-JKQL6q-6-w-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6bc7afd0498so412162a34.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690477095; x=1691081895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9XPyUvJXurY3nbwRDos0PfDbaqejKfC2NDwQgV0nLA=;
 b=RlYv5WvWAIz5l0Mku+GdrWzaCIkpCp+2kRG1cDwnTGZGhWPkwQyjeFiZ61y0utR91D
 TVc+1IYc+AaGdQsPSPmWaIrel6J+rdlUQgE6mW4OZ9P9qadX33x96GISlmZlhmfg1+vX
 ObrPUuZRQbJweGFzKlqxTeq85O5WOfei8xyF1vo/Jkp9ZVqm6KtJ0PcWknLdfLsrYdt/
 xMw7TiKYiV7YrmIoBWEKMaZg5dZLz3iq53VBObuFhujj4jdifbEk+Zsbfy3ttA3HaHhP
 K+qYTYIXaXxt10W2tgskCy1AyuEYOZV5N0fJN0pi5EXr50RTMuXeBb+VMFf6falmju10
 8nkA==
X-Gm-Message-State: ABy/qLaxk21FzlJeR/GViloDE/7aKRSMb2WA8q9VOZKusFVVZQscQ/Q3
 rL+k8IJeKtU9n9QI5CK+PPrVmg7LD8OPx55muzDgE5OCZdNJ6q+gEwHUbcfxMTQv6D6pZKG30Ap
 EAuKsQMxSLgoDQHk=
X-Received: by 2002:a05:6830:4805:b0:6b9:b096:2617 with SMTP id
 dg5-20020a056830480500b006b9b0962617mr4794052otb.14.1690477095415; 
 Thu, 27 Jul 2023 09:58:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2jd6cgKGZW8G5zDpXipS6eyUP8yQ2nlfjQ8ci+Yw3ItQ8DHX5DaOD6PCDO2bSiHrDtePePA==
X-Received: by 2002:a05:6830:4805:b0:6b9:b096:2617 with SMTP id
 dg5-20020a056830480500b006b9b0962617mr4794036otb.14.1690477095119; 
 Thu, 27 Jul 2023 09:58:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a0cd983000000b0062de6537febsm550463qvj.58.2023.07.27.09.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:58:14 -0700 (PDT)
Message-ID: <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
Date: Thu, 27 Jul 2023 18:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230727072410.135743-2-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Jing,

On 7/27/23 09:24, Jing Liu wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> Kernel provides the guidance of dynamic MSI-X allocation support of
> passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
> guide user space.
> 
> Fetch and store the flags from host for later use to determine if
> specific flags are set.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
>   hw/vfio/pci.c        | 12 ++++++++++++
>   hw/vfio/pci.h        |  1 +
>   hw/vfio/trace-events |  2 ++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b1130f..0c4ac0873d40 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>   
>   static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>   {
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
>       int ret;
>       Error *err = NULL;
>   
> @@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>           memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>       }
>   
> +    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret) {
> +        /* This can fail for an old kernel or legacy PCI dev */
> +        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));

Is it possible to detect the error reported by a kernel (< 6.4) when
dynamic MSI-X are not supported. Looking at vfio_pci_ioctl_get_irq_info()
in the kernel, could info.flags be tested against VFIO_IRQ_INFO_NORESIZE ?

In that case, QEMU should report an error and the trace event is not
needed.

Thanks,

C.

> +    } else {
> +        vdev->msix->irq_info_flags = irq_info.flags;
> +    }
> +    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
> +                                         vdev->msix->irq_info_flags);
> +
>       return 0;
>   }
>   
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a2771b9ff3cc..ad34ec56d0ae 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
>       uint32_t table_offset;
>       uint32_t pba_offset;
>       unsigned long *pending;
> +    uint32_t irq_info_flags;
>   } VFIOMSIXInfo;
>   
>   #define TYPE_VFIO_PCI "vfio-pci"
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e4f..7d4a398f044d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -28,6 +28,8 @@ vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x,
>   vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
>   vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
>   vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
> +vfio_msix_setup_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> +vfio_msix_setup_irq_info_flags(const char *name, uint32_t flags) " (%s) MSI-X irq info flags 0x%x"
>   vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
>   vfio_check_pm_reset(const char *name) "%s Supports PM reset"
>   vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"


