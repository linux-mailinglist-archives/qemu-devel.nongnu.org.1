Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A675A396
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 02:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMHnx-0003w9-K9; Wed, 19 Jul 2023 20:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHnv-0003vt-8K
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:46:03 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qMHnt-0003Gw-Hy
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 20:46:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517bdc9e81dso83311a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689813960; x=1690418760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxOdnF4JwIqAiZRYSWbJHReSeNZreC9jk2nWS2SXAxs=;
 b=A0PnSnmShCF/phs5G95C5UHgNg219xyabonUvsa4/HwmvjB5uV8JM08eQhbi8vSBIp
 MUkOrF8In5264fodbX2/8oanuW4+J+ZP3X8Z6BIIxx8tMRr3+79uGh7LpIaFbMX7GKQO
 IMI8K4UB1Xh+ZSsKWKQSLNTzOAHJnqQSyN3A7fgLoLEItGQcWgjTY/p9xYvn6t2CyEca
 rA6tDO6CdRxcW2LgviTRkWg6xuL2R4Hf83hYuIYXq/YQpgV6iLRw9MSNGnOwaoQ9m1ED
 uM5MZw1O1VXary7FG4Ls2rlbg6i7F+DsrSnNoQ+gYtqyd9i0Bpc3XwLWNU1Mk+ascsGP
 ZumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689813960; x=1690418760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxOdnF4JwIqAiZRYSWbJHReSeNZreC9jk2nWS2SXAxs=;
 b=PE/3k7nEKsv6F+JSVyISTIb8emn36HTcwml1fVfTHmxZjkHFp87/xfa9ZrZNR5i/86
 NVZ8K+gUq9gwyZVdQX4JgcP7OC7087NVI4UfK98AH3PfK6Rj/FQLhqfBatCgqUEjnnXE
 rJtR1Y/a7Sm49m0vMb1VAYph7FBch6DBU8S6gSXl8W3QQtPTvqZJ6Ps/bw46XcYhV8JD
 oFJ1+jjG7osJl5X7QhnOjh/Zc817y67LCunHQxZKQGqfAdf1bBhkumWGbcnMF96oA260
 iDr6QLpDjytPS5JeaYcvvRCFfQHqTB75XvYLmvo55E/MVpwkcbBSXR/zX1iPbVENazPo
 e24A==
X-Gm-Message-State: ABy/qLaZfEDLtYddxN5WkMSExbZFI+3DrFTslYJFFqQMoukEZzNIvzt7
 K0Ynn+LorhLYZP4JERcUF5eKzg==
X-Google-Smtp-Source: APBJJlGOEq1rIazQgnoNBgQSgRdr+sNJtzWE+zOWRfHOSz+f62WI95v2jCq56VBPvSJFPstBGTufIA==
X-Received: by 2002:a05:6a20:7288:b0:134:80b3:896 with SMTP id
 o8-20020a056a20728800b0013480b30896mr7591123pzk.17.1689813959835; 
 Wed, 19 Jul 2023 17:45:59 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iy14-20020a170903130e00b001b53d3d8f3dsm4569105plb.299.2023.07.19.17.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 17:45:59 -0700 (PDT)
Message-ID: <6cc530de-e945-5d73-caaf-07cfd3b0c562@daynix.com>
Date: Thu, 20 Jul 2023 09:45:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] virtio-pci: add SR-IOV capability
Content-Language: en-US
To: Yui Washizu <yui.washidu@gmail.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, yvugenfi@redhat.com,
 ybendito@redhat.com, mapfelba@redhat.com, marcel@redhat.com,
 ghammer@redhat.com, mdean@redhat.com
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <1689731808-3009-2-git-send-email-yui.washidu@gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1689731808-3009-2-git-send-email-yui.washidu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/19 10:56, Yui Washizu wrote:
> This enables SR-IOV emulation on virtio-pci devices by adding SR-IOV capability
> It also introduces a newly added property 'sriov_max_vfs'
> to enable or disable the SR-IOV feature on the virtio-pci device in guest,
> as well as to specify the maximum number of VFs that can be created in the guest.
> Currently only virtio-net is supported.
> Also, the vendor ID and device ID remain the same for both the PF and VF,
> enabling existing guest PF drivers to be used in the VF without any modifications.
> 
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> ---
>   hw/pci/msix.c                  |  8 +++--
>   hw/pci/pci.c                   |  4 +++
>   hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
>   include/hw/virtio/virtio-pci.h |  1 +
>   4 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index ab8869d9d0..3b94ce389f 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -421,8 +421,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>           return ret;
>       }
>   
> -    pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
> -                     &dev->msix_exclusive_bar);
> +    if (pci_is_vf(dev)) {
> +        pcie_sriov_vf_register_bar(dev, bar_nr, &dev->msix_exclusive_bar);
> +    } else {
> +        pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                         &dev->msix_exclusive_bar);
> +    }
>   
>       return 0;
>   }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..cbd50b38ea 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2325,6 +2325,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>           return;
>       }
>   
> +    if (pci_is_vf(pdev)) {
> +        return;
> +    }
> +
>       if (!pdev->rom_bar) {
>           /*
>            * Load rom via fw_cfg instead of creating a rom bar,
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index edbc0daa18..2315c2647a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -49,6 +49,8 @@
>    * configuration space */
>   #define VIRTIO_PCI_CONFIG_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_enabled(dev))
>   
> +#define VIRTIO_MAX_VFS 127
> +
>   static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
>                                  VirtIOPCIProxy *dev);
>   static void virtio_pci_reset(DeviceState *qdev);
> @@ -1907,6 +1909,11 @@ static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
>   
>       if (virtio_pci_modern(proxy)) {
>           virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> +        if (proxy->sriov_max_vfs) {
> +            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
> +        }
> +    } else if (proxy->sriov_max_vfs) {
> +        error_setg(errp, "VirtIO PCI modern is required for the use of SR-IOV");

Missing: return;

>       }
>   
>       virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
> @@ -2015,22 +2022,62 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>           virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
>           virtio_pci_modern_mem_region_map(proxy, &proxy->notify, &notify.cap);
>   
> +        if (!pci_is_vf(&proxy->pci_dev) && proxy->sriov_max_vfs) {
> +            if (virtio_bus_get_vdev_id(bus) != VIRTIO_ID_NET) {
> +                error_setg(errp, "sriov_max_vfs prop is not supported by %s",
> +                           proxy->pci_dev.name);
> +                return;
> +            }
> +            if (proxy->sriov_max_vfs > VIRTIO_MAX_VFS) {
> +                error_setg(errp, "sriov_max_vfs must be between 0 and %d",
> +                           VIRTIO_MAX_VFS);
> +                return;
> +            }
> +
> +            pcie_sriov_pf_init(&proxy->pci_dev, PCI_CONFIG_SPACE_SIZE,
> +                               proxy->pci_dev.name,
> +                               PCI_DEVICE_ID_VIRTIO_10_BASE
> +                               + virtio_bus_get_vdev_id(bus),
> +                               proxy->sriov_max_vfs, proxy->sriov_max_vfs, 1, 1);
> +            if (proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
> +                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
> +                                          PCI_BASE_ADDRESS_SPACE_IO, 4);
> +            }
> +            if (proxy->nvectors) {
> +                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->msix_bar_idx,
> +                                          PCI_BASE_ADDRESS_SPACE_MEMORY, 4 * 1024);
> +            }
> +            pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> +                                      PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                                      PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                                      PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                                      16 * 1024);
> +        }
> +
>           if (modern_pio) {
>               memory_region_init(&proxy->io_bar, OBJECT(proxy),
>                                  "virtio-pci-io", 0x4);
>   
> -            pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
> -                             PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
> +            if (pci_is_vf(&proxy->pci_dev))
> +                pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
> +                                           &proxy->io_bar);
> +            else
> +                pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
> +                                 PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
>   
>               virtio_pci_modern_io_region_map(proxy, &proxy->notify_pio,
>                                               &notify_pio.cap);
>           }
>   
> -        pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> -                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> -                         PCI_BASE_ADDRESS_MEM_PREFETCH |
> -                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> -                         &proxy->modern_bar);
> +        if (pci_is_vf(&proxy->pci_dev))
> +            pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> +                                       &proxy->modern_bar);
> +        else
> +            pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> +                             PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                             PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                             PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                             &proxy->modern_bar);
>   
>           proxy->config_cap = virtio_pci_add_mem_cap(proxy, &cfg.cap);
>           cfg_mask = (void *)(proxy->pci_dev.wmask + proxy->config_cap);
> @@ -2298,6 +2345,7 @@ static Property virtio_pci_properties[] = {
>                       VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>       DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>                       VIRTIO_PCI_FLAG_AER_BIT, false),
> +    DEFINE_PROP_UINT16("sriov_max_vfs", VirtIOPCIProxy, sriov_max_vfs, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index ab2051b64b..05ab6ddc3f 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -150,6 +150,7 @@ struct VirtIOPCIProxy {
>       uint32_t flags;
>       bool disable_modern;
>       bool ignore_backend_features;
> +    uint16_t sriov_max_vfs;
>       OnOffAuto disable_legacy;
>       /* Transitional device id */
>       uint16_t trans_devid;

