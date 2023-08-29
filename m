Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CE78C600
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayr1-0008OJ-8Y; Tue, 29 Aug 2023 09:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayqx-0008O1-TO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayqu-0008IQ-9y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693316031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89ki7Yjm/ZcC+AOH/EJ+n0WwRq/Pa125lMzhJLNspe4=;
 b=K/3oo4yrEBJbGh9kIysrsy7uJ/2HOTI5coLXLvKzgUWeQPqjDtf81zuMTmQxwiNimN/2Tj
 BA6EqkBAajkv4Caj+H41EXv13N4WoWYhN5+1uQeVVsS2NsiQx9aIDl5ECumkIY88oYKh/4
 crXVDGVOEu2Ek2q5Uv7GfDOhLhTy1Xg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-D4lSUrzmOVa18CuOeYjwtA-1; Tue, 29 Aug 2023 09:33:49 -0400
X-MC-Unique: D4lSUrzmOVa18CuOeYjwtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c89a09099so1739096f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693316028; x=1693920828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=89ki7Yjm/ZcC+AOH/EJ+n0WwRq/Pa125lMzhJLNspe4=;
 b=gobrWSjSXg7zmhBr4N3dXxOBZyjuo/DJ19WahW8vSoIqfJwDpkEsPKpQIyqUowuEmY
 8rGytQXAQNOGheiR8Hz7iHHl7w/qLwk1BdKFg/2NDtWRoC0EojYVx1ojFDl62FHW/1uS
 Geg15YwN2cVlKNuGcgry/vnJow9gX1kRua2/m81IHV/zqELFqbcXhmWGWXALCEmweVXY
 TiiyPcy1b91e+Rxs37/S5owordMzLbimXa1em3UvFn255hbS6/kP5A/zF0+mKF1g6B4v
 wfMvM+BCq7UbL45VlxPNjhUpwmZdFKSEINuWvbixfEYjbT8uKbbMlRzQ7ln6ISpJLRju
 4RTw==
X-Gm-Message-State: AOJu0YyLK5mKT3BKKPEzlLa0dAOpvx8j2Dy20QfRONGEdjVNdggVd++L
 blEm3Pk9MGNQn7/rEztuD6RwZmkvgBRB5whsAUx1ppuYyspGioyVJTirhX9lAyrXZ1y7ldyG06I
 ffzFRgoA74y3lMYc=
X-Received: by 2002:a5d:630e:0:b0:317:61af:d64a with SMTP id
 i14-20020a5d630e000000b0031761afd64amr21353243wru.3.1693316028584; 
 Tue, 29 Aug 2023 06:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3Hugb+tpUVppmgfhA0FOJKxVwaAFhTY0WG/F/9PXYH+ZPK6Yy9jlsp9yj6WnRM5/erNzbsw==
X-Received: by 2002:a5d:630e:0:b0:317:61af:d64a with SMTP id
 i14-20020a5d630e000000b0031761afd64amr21353230wru.3.1693316028256; 
 Tue, 29 Aug 2023 06:33:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4205000000b00317ddccb0d1sm13792731wrq.24.2023.08.29.06.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:33:47 -0700 (PDT)
Message-ID: <76d4ad43-72ba-a3cb-1c6a-85575c2e0e29@redhat.com>
Date: Tue, 29 Aug 2023 15:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/4] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com, jing2.liu@linux.intel.com
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-2-jing2.liu@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230822072927.224803-2-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello Jing,

On 8/22/23 09:29, Jing Liu wrote:
> Kernel provides the guidance of dynamic MSI-X allocation support of
> passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
> guide user space.
> 
> Fetch the flags from host to determine if dynamic MSI-X allocation is
> supported.
> 
> Originally-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> ---
> Changes since RFC v1:
> - Filter the dynamic MSI-X allocation flag and store as a bool type.
>    (Alex)
> - Move the detection to vfio_msix_early_setup(). (Alex)
> - Report error of getting irq info and remove the trace of failure
>    case. (Alex, Cédric)
> ---
>   hw/vfio/pci.c        | 15 +++++++++++++--
>   hw/vfio/pci.h        |  1 +
>   hw/vfio/trace-events |  2 +-
>   3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b1130f..8a3b34f3c196 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1493,7 +1493,9 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t pos;
>       uint16_t ctrl;
>       uint32_t table, pba;
> -    int fd = vdev->vbasedev.fd;
> +    int ret, fd = vdev->vbasedev.fd;
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> +                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
>       VFIOMSIXInfo *msix;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
> @@ -1530,6 +1532,14 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
>       msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
>   
> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "failed to get MSI-X irq info");

Missing :
             g_free(msix);


With this fixed,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


  
> +        return;
> +    }
> +
> +    msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
> +
>       /*
>        * Test the size of the pba_offset variable and catch if it extends outside
>        * of the specified BAR. If it is the case, we need to apply a hardware
> @@ -1562,7 +1572,8 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       }
>   
>       trace_vfio_msix_early_setup(vdev->vbasedev.name, pos, msix->table_bar,
> -                                msix->table_offset, msix->entries);
> +                                msix->table_offset, msix->entries,
> +                                msix->noresize);
>       vdev->msix = msix;
>   
>       vfio_pci_fixup_msix_region(vdev);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a2771b9ff3cc..0717574d79e9 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
>       uint32_t table_offset;
>       uint32_t pba_offset;
>       unsigned long *pending;
> +    bool noresize;
>   } VFIOMSIXInfo;
>   
>   #define TYPE_VFIO_PCI "vfio-pci"
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e4f..6de5d9ba8e46 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -27,7 +27,7 @@ vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"
>   vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
>   vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
>   vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
> -vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
> +vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d, noresize %d"
>   vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
>   vfio_check_pm_reset(const char *name) "%s Supports PM reset"
>   vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"


