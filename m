Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D7765A9A
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4je-0007UN-Ns; Thu, 27 Jul 2023 13:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4jY-0007RC-Ex
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qP4jW-0008Pf-Gx
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690478701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oghVzF4nOFeyBEiPgYBACsdepkdnc21taneX+DNg3c4=;
 b=YZe+zoYZbLb6+zlPFopO+rGNY4h1YVLn2McR72Unq6DR3Tg+ao6NMA/foJkACFt6GRw87+
 4U5iSuqsmqHyOXHgPcIGI98Y/MmpI6pCX2gPnsXdVp6l90gymCE70d8SilUbO5ucahld1Z
 zePnl20hp9j9xU0tCjnMoQNw87iXYaU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ziEWcZBiN-K1qcx3eUjSDQ-1; Thu, 27 Jul 2023 13:24:59 -0400
X-MC-Unique: ziEWcZBiN-K1qcx3eUjSDQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-780addd7382so78710339f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690478698; x=1691083498;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oghVzF4nOFeyBEiPgYBACsdepkdnc21taneX+DNg3c4=;
 b=C/wuYrxJdrrqBpIad4deibCF0pvt6JB4zHb92RO9it9sfr7kiKZdM3TgThDIxLWAke
 wRFy4yuOnHidsgpa0au7TUatgZQ02dXTOyW7Sk3Ue0fAqnlzucP+gpwXEN6WYLSlWJjv
 ppBeLsCO6/I4naD3HT7whOUgXzYr3q6aQvHZ2uxlCGq3oRLb2rhr9BXzv4BfAoFjb2ZY
 w2DnTgLL4n6r1rNtlk+HMcnFzFgOyDnSI/hrt/OO6L5uFDjAwO4bLtOGmrsiGHPLzv8O
 0AJaktOGwYldqcj6Hn/4Bdokb5q2uLY/HPICIBZ9EesX6czDsIF7pVGHxSzsFy78LRXa
 HfQA==
X-Gm-Message-State: ABy/qLbfiDu7jMRhF1oN2gXv6DfRiFWai9CY811+jlilu73MppHKNHyC
 6zf9I9eQpDqS9/Pm9t+kbJ41D3r7F8SUYr18QxpKP1lcWbAuaCNgZY5e0OBChePZC0i0zpaYqLM
 ssTV94jHGftLOT70=
X-Received: by 2002:a5d:8705:0:b0:783:5e20:768d with SMTP id
 u5-20020a5d8705000000b007835e20768dmr132486iom.18.1690478698510; 
 Thu, 27 Jul 2023 10:24:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaVNopm+jtJhZoml0RG2ikPDllQBT+HCTH7xhvWIs2oaqaHwPPCVuveXrFGiUYvNsJVL6BgA==
X-Received: by 2002:a5d:8705:0:b0:783:5e20:768d with SMTP id
 u5-20020a5d8705000000b007835e20768dmr132469iom.18.1690478698231; 
 Thu, 27 Jul 2023 10:24:58 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 cw11-20020a05663849cb00b0042adc25ab12sm556261jab.44.2023.07.27.10.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 10:24:57 -0700 (PDT)
Date: Thu, 27 Jul 2023 11:24:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jing Liu <jing2.liu@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic
 MSI-X allocation
Message-ID: <20230727112457.1422f285.alex.williamson@redhat.com>
In-Reply-To: <20230727072410.135743-2-jing2.liu@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
Organization: Red Hat
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

On Thu, 27 Jul 2023 03:24:08 -0400
Jing Liu <jing2.liu@intel.com> wrote:

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
>  hw/vfio/pci.c        | 12 ++++++++++++
>  hw/vfio/pci.h        |  1 +
>  hw/vfio/trace-events |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b1130f..0c4ac0873d40 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>  
>  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>  {
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
>      int ret;
>      Error *err = NULL;
>  
> @@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>          memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
>      }
>  
> +    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret) {
> +        /* This can fail for an old kernel or legacy PCI dev */
> +        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));

We only call vfio_msix_setup() if the device has an MSI-X capability,
so the "legacy PCI" portion of this comment seems unjustified.
Otherwise the GET_IRQ_INFO ioctl has always existed, so I'd also
question the "old kernel" part of this comment.  We don't currently
sanity test the device exposed MSI-X info versus that reported by
GET_IRQ_INFO, but it seems valid to do so.  I'd expect this to happen
in vfio_msix_early_setup() though, especially since that's where the
remainder of VFIOMSIXInfo is setup.

> +    } else {
> +        vdev->msix->irq_info_flags = irq_info.flags;
> +    }
> +    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
> +                                         vdev->msix->irq_info_flags);
> +
>      return 0;
>  }
>  
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a2771b9ff3cc..ad34ec56d0ae 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
>      uint32_t table_offset;
>      uint32_t pba_offset;
>      unsigned long *pending;
> +    uint32_t irq_info_flags;

Why not simply pull out a "noresize" bool?  Thanks,

Alex

>  } VFIOMSIXInfo;
>  
>  #define TYPE_VFIO_PCI "vfio-pci"
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e4f..7d4a398f044d 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -28,6 +28,8 @@ vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x,
>  vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
>  vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
>  vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
> +vfio_msix_setup_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> +vfio_msix_setup_irq_info_flags(const char *name, uint32_t flags) " (%s) MSI-X irq info flags 0x%x"
>  vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
>  vfio_check_pm_reset(const char *name) "%s Supports PM reset"
>  vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"


