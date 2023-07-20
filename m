Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7D475A456
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 04:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMJLE-0001Yn-B2; Wed, 19 Jul 2023 22:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMJLB-0001YQ-Fz
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMJL9-00068g-Rm
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689819867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBuv5t5LLyq7eRZEqgThuTdfuvKinh/QXbM6D2qbs1g=;
 b=dH/blYQycgXsq5duzpKPoDuYOSqFJHZ9qmehbPT32aK4cu+iA5WBjY+cYtH3enPoJB2m07
 UixwoDnDRN+MSOvO/cGpCsjpINxNELHReocbcDmPak67pXY8ITOygPg+iAS0f6XtzhAF3K
 RBsBT9AT1YITx0M1o7Z4NHvfaWCPszI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Lnqv-51zOz-sgKw0a466Fw-1; Wed, 19 Jul 2023 22:24:25 -0400
X-MC-Unique: Lnqv-51zOz-sgKw0a466Fw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f51e170fso1934831fa.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 19:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689819557; x=1692411557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBuv5t5LLyq7eRZEqgThuTdfuvKinh/QXbM6D2qbs1g=;
 b=OfQ7gEEc9hQLU7A6a1NGBfps0o00yjoA4x19q7bQFqhyiol9LGGpITzG6TdXVVGf65
 9twszUhq/OWzFssKzlITvRwC+NnT0KYEWh+uw9FjSrSbR7WiFNynVyWZC/Z8vtiDdMSs
 6JHurEvMnYj1rCL1WBf0VyB42MGZbFfQegt7ZvMbCVsNviwZYd06GoYCV46Co5qcRfF4
 wq3oCHJtRbCQteIBP/CsLn18zFwx+wu0kXLa4DaO/ten0Es3w5yjqYyHzIdE9gkfhZuq
 4afOEjMz0Q0F/qZgoA4OGf09Pn4y9+/k3kpJEIz7FMVfQLHaT8dcQUQ0qJ332SX8fvOz
 2kJA==
X-Gm-Message-State: ABy/qLbLVlLNQr3TAlbeasP4IzyJlvy6vfa4BaxFFycnTyuzEANlrQeD
 JWEUX9srhLG1MC1lKWjRp91B3vRqfFeqcWFbaRljeb7uZJh7eZ6PAioXgzyspZYejCGt8Exz8L6
 AYCvUNeoRZ8S1yrb5cVcjAejRLX2LVZ8=
X-Received: by 2002:a2e:3803:0:b0:2b1:a89a:5f2b with SMTP id
 f3-20020a2e3803000000b002b1a89a5f2bmr795854lja.2.1689819556760; 
 Wed, 19 Jul 2023 19:19:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDXwTinemypn12LVTdhkbDvtwb5jhgqJ/Gkr773HmrdWCnCRsZZ3ExTg1540GT2iT5GW+axrJGGNJGXDghP7o=
X-Received: by 2002:a2e:3803:0:b0:2b1:a89a:5f2b with SMTP id
 f3-20020a2e3803000000b002b1a89a5f2bmr795844lja.2.1689819556417; Wed, 19 Jul
 2023 19:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
 <1689731808-3009-2-git-send-email-yui.washidu@gmail.com>
In-Reply-To: <1689731808-3009-2-git-send-email-yui.washidu@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 10:19:04 +0800
Message-ID: <CACGkMEtDvOJqHmp-zOCM=ZBj1kx+vN=C9kXE19rth81+Kcr1RQ@mail.gmail.com>
Subject: Re: [RFC 1/1] virtio-pci: add SR-IOV capability
To: Yui Washizu <yui.washidu@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, akihiko.odaki@daynix.com, 
 yvugenfi@redhat.com, ybendito@redhat.com, mapfelba@redhat.com, 
 marcel@redhat.com, ghammer@redhat.com, mdean@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Wed, Jul 19, 2023 at 9:59=E2=80=AFAM Yui Washizu <yui.washidu@gmail.com>=
 wrote:
>
> This enables SR-IOV emulation on virtio-pci devices by adding SR-IOV capa=
bility
> It also introduces a newly added property 'sriov_max_vfs'
> to enable or disable the SR-IOV feature on the virtio-pci device in guest=
,
> as well as to specify the maximum number of VFs that can be created in th=
e guest.
> Currently only virtio-net is supported.
> Also, the vendor ID and device ID remain the same for both the PF and VF,
> enabling existing guest PF drivers to be used in the VF without any modif=
ications.
>
> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> ---
>  hw/pci/msix.c                  |  8 +++--
>  hw/pci/pci.c                   |  4 +++
>  hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
>  include/hw/virtio/virtio-pci.h |  1 +
>  4 files changed, 66 insertions(+), 9 deletions(-)
>
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index ab8869d9d0..3b94ce389f 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -421,8 +421,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned=
 short nentries,
>          return ret;
>      }
>
> -    pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
> -                     &dev->msix_exclusive_bar);
> +    if (pci_is_vf(dev)) {
> +        pcie_sriov_vf_register_bar(dev, bar_nr, &dev->msix_exclusive_bar=
);
> +    } else {
> +        pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                         &dev->msix_exclusive_bar);
> +    }
>
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..cbd50b38ea 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2325,6 +2325,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bo=
ol is_default_rom,
>          return;
>      }
>
> +    if (pci_is_vf(pdev)) {
> +        return;
> +    }
> +
>      if (!pdev->rom_bar) {
>          /*
>           * Load rom via fw_cfg instead of creating a rom bar,
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index edbc0daa18..2315c2647a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -49,6 +49,8 @@
>   * configuration space */
>  #define VIRTIO_PCI_CONFIG_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_enabl=
ed(dev))
>
> +#define VIRTIO_MAX_VFS 127
> +
>  static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
>                                 VirtIOPCIProxy *dev);
>  static void virtio_pci_reset(DeviceState *qdev);
> @@ -1907,6 +1909,11 @@ static void virtio_pci_pre_plugged(DeviceState *d,=
 Error **errp)
>
>      if (virtio_pci_modern(proxy)) {
>          virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
> +        if (proxy->sriov_max_vfs) {
> +            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
> +        }
> +    } else if (proxy->sriov_max_vfs) {
> +        error_setg(errp, "VirtIO PCI modern is required for the use of S=
R-IOV");
>      }
>
>      virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
> @@ -2015,22 +2022,62 @@ static void virtio_pci_device_plugged(DeviceState=
 *d, Error **errp)
>          virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
>          virtio_pci_modern_mem_region_map(proxy, &proxy->notify, &notify.=
cap);
>
> +        if (!pci_is_vf(&proxy->pci_dev) && proxy->sriov_max_vfs) {
> +            if (virtio_bus_get_vdev_id(bus) !=3D VIRTIO_ID_NET) {
> +                error_setg(errp, "sriov_max_vfs prop is not supported by=
 %s",
> +                           proxy->pci_dev.name);
> +                return;
> +            }
> +            if (proxy->sriov_max_vfs > VIRTIO_MAX_VFS) {
> +                error_setg(errp, "sriov_max_vfs must be between 0 and %d=
",
> +                           VIRTIO_MAX_VFS);
> +                return;
> +            }
> +
> +            pcie_sriov_pf_init(&proxy->pci_dev, PCI_CONFIG_SPACE_SIZE,
> +                               proxy->pci_dev.name,
> +                               PCI_DEVICE_ID_VIRTIO_10_BASE
> +                               + virtio_bus_get_vdev_id(bus),
> +                               proxy->sriov_max_vfs, proxy->sriov_max_vf=
s, 1, 1);
> +            if (proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
> +                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern=
_io_bar_idx,
> +                                          PCI_BASE_ADDRESS_SPACE_IO, 4);
> +            }
> +            if (proxy->nvectors) {
> +                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->msix_b=
ar_idx,
> +                                          PCI_BASE_ADDRESS_SPACE_MEMORY,=
 4 * 1024);
> +            }
> +            pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern_mem=
_bar_idx,
> +                                      PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                                      PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                                      PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                                      16 * 1024);
> +        }
> +
>          if (modern_pio) {
>              memory_region_init(&proxy->io_bar, OBJECT(proxy),
>                                 "virtio-pci-io", 0x4);
>
> -            pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
> -                             PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
> +            if (pci_is_vf(&proxy->pci_dev))
> +                pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->moder=
n_io_bar_idx,
> +                                           &proxy->io_bar);

We probably don't need another memory bar for notification.

Thanks

> +            else
> +                pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_i=
dx,
> +                                 PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_b=
ar);
>
>              virtio_pci_modern_io_region_map(proxy, &proxy->notify_pio,
>                                              &notify_pio.cap);
>          }
>
> -        pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> -                         PCI_BASE_ADDRESS_SPACE_MEMORY |
> -                         PCI_BASE_ADDRESS_MEM_PREFETCH |
> -                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> -                         &proxy->modern_bar);
> +        if (pci_is_vf(&proxy->pci_dev))
> +            pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->modern_me=
m_bar_idx,
> +                                       &proxy->modern_bar);
> +        else
> +            pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
> +                             PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                             PCI_BASE_ADDRESS_MEM_PREFETCH |
> +                             PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                             &proxy->modern_bar);
>
>          proxy->config_cap =3D virtio_pci_add_mem_cap(proxy, &cfg.cap);
>          cfg_mask =3D (void *)(proxy->pci_dev.wmask + proxy->config_cap);
> @@ -2298,6 +2345,7 @@ static Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_AER_BIT, false),
> +    DEFINE_PROP_UINT16("sriov_max_vfs", VirtIOPCIProxy, sriov_max_vfs, 0=
),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pc=
i.h
> index ab2051b64b..05ab6ddc3f 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -150,6 +150,7 @@ struct VirtIOPCIProxy {
>      uint32_t flags;
>      bool disable_modern;
>      bool ignore_backend_features;
> +    uint16_t sriov_max_vfs;
>      OnOffAuto disable_legacy;
>      /* Transitional device id */
>      uint16_t trans_devid;
> --
> 2.39.3
>


