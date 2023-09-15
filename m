Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96777A25BF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDZT-0003To-L6; Fri, 15 Sep 2023 14:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qhDZO-0003RF-C0
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qhDZK-0000ET-M6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694802569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaZK3mFqaw+Jg90ApEwZVstojushZ858ipAn4faXowM=;
 b=e5n7MYqiJzbOxthcsXJMD617G0C5JZtd6ilkREeol2aseY7+rh7xsUwdfpT+bKEe+eWtq+
 eZEKGh4n1lUhjKYroHHerVPCPVO6taY9+VJIOUpcAmzaKpO0m9zhLGJPFkjurgKN+6GK8t
 BHnW7f/cp3pMeqb4x08zawz2ia7fAic=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-bRgkkKLBOZW7XHVPFv00XQ-1; Fri, 15 Sep 2023 14:29:27 -0400
X-MC-Unique: bRgkkKLBOZW7XHVPFv00XQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34670b3089dso22617465ab.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 11:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694802567; x=1695407367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaZK3mFqaw+Jg90ApEwZVstojushZ858ipAn4faXowM=;
 b=BjPc3JoNHCu0vfD2Ahk9L//OuH49VQ4jpHAMopWiRZXcMVWO/Jn50S7ABVsG/uUvvB
 2aCtKj6HZWxPnMOd3pl9x8YmsUjMWsyXjIkqZcoduYpwJ4qEiUOs6wqFG4GvcT7M3FTh
 t/ltBdBGmIHnqmUBdSjA/gC6UYyIJibWIjKJhTqnK6VSzisnnxGmx2Ca0Kx+83WVO0N3
 tJ/tOtp94XzMGn2vza4+oRmxLNX4x0eovGg7Zn/gtMWxZCTPvaznbDY9t0XjN3i7SGQr
 HGEA9V9Ab1dUYM006ue4pLxPpTYy9zcUR3XAgi6aZg78bxPkNfHX2ngLZLOE3jNSdi+M
 SS6g==
X-Gm-Message-State: AOJu0YxdIOC9tNgYiMbnQo0IsiRfi2MXZ8SYh+gJiwDEWJvjl51tt4sl
 11wYEnV0mdhVLTb91J4sm7Sc50l7/kgye6otP/2WwGkU31eJhvBlIZSxcThJ8iddUXA1PIktAMl
 FxBFgqwanJ4RMiAE=
X-Received: by 2002:a92:c248:0:b0:34f:30f0:d4e6 with SMTP id
 k8-20020a92c248000000b0034f30f0d4e6mr5612934ilo.1.1694802566384; 
 Fri, 15 Sep 2023 11:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJeaw7WwSH+9DW9SSI+/bfUX5c4lr5SKHv6+df4BjSoMSvaWQL4PviX5AEYPCkkrUiC+N/DA==
X-Received: by 2002:a92:c248:0:b0:34f:30f0:d4e6 with SMTP id
 k8-20020a92c248000000b0034f30f0d4e6mr5612899ilo.1.1694802565809; 
 Fri, 15 Sep 2023 11:29:25 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92cbc5000000b0034a92425cbcsm1229266ilq.84.2023.09.15.11.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 11:29:24 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:29:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] spapr: Remove support for NVIDIA V100 GPU with NVLink2
Message-ID: <20230915122922.1d17b215.alex.williamson@redhat.com>
In-Reply-To: <20230915075936.326712-1-clg@kaod.org>
References: <20230915075936.326712-1-clg@kaod.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 Sep 2023 09:59:36 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> NVLink2 support was removed from the PPC PowerNV platform and VFIO in
> Linux 5.13 with commits :
>=20
>   562d1e207d32 ("powerpc/powernv: remove the nvlink support")
>   b392a1989170 ("vfio/pci: remove vfio_pci_nvlink2")
>=20
> This was 2.5 years ago. Do the same in QEMU with a revert of commit
> ec132efaa81f ("spapr: Support NVIDIA V100 GPU with NVLink2"). Some
> adjustements are required on the NUMA part.
>=20
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Acked-by: Alex Williamson <alex.williamson@redhat.com>

>  hw/vfio/pci.h               |   2 -
>  include/hw/pci-host/spapr.h |  45 ----
>  include/hw/ppc/spapr.h      |   9 +-
>  hw/ppc/spapr.c              |  22 +-
>  hw/ppc/spapr_numa.c         |  49 +---
>  hw/ppc/spapr_pci.c          |  19 --
>  hw/ppc/spapr_pci_nvlink2.c  | 442 ------------------------------------
>  hw/vfio/pci-quirks.c        | 115 ----------
>  hw/vfio/pci.c               |  14 --
>  hw/ppc/meson.build          |   1 -
>  hw/vfio/trace-events        |   4 -
>  11 files changed, 14 insertions(+), 708 deletions(-)
>  delete mode 100644 hw/ppc/spapr_pci_nvlink2.c
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a2771b9ff3cc..2d836093a83d 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -221,8 +221,6 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **er=
rp);
>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                 struct vfio_region_info *info,
>                                 Error **errp);
> -int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
> -int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
> =20
>  void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 5b03a7b0eb3f..3778aac27b60 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -47,8 +47,6 @@ typedef struct SpaprPciLsi {
>      uint32_t irq;
>  } SpaprPciLsi;
> =20
> -typedef struct SpaprPhbPciNvGpuConfig SpaprPhbPciNvGpuConfig;
> -
>  struct SpaprPhbState {
>      PCIHostState parent_obj;
> =20
> @@ -90,9 +88,6 @@ struct SpaprPhbState {
>      uint32_t mig_liobn;
>      hwaddr mig_mem_win_addr, mig_mem_win_size;
>      hwaddr mig_io_win_addr, mig_io_win_size;
> -    hwaddr nv2_gpa_win_addr;
> -    hwaddr nv2_atsd_win_addr;
> -    SpaprPhbPciNvGpuConfig *nvgpus;
>      bool pre_5_1_assoc;
>  };
> =20
> @@ -112,20 +107,6 @@ struct SpaprPhbState {
> =20
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> =20
> -#define SPAPR_PCI_NV2RAM64_WIN_BASE  SPAPR_PCI_LIMIT
> -#define SPAPR_PCI_NV2RAM64_WIN_SIZE  (2 * TiB) /* For up to 6 GPUs 256GB=
 each */
> -
> -/* Max number of NVLinks per GPU in any physical box */
> -#define NVGPU_MAX_LINKS              3
> -
> -/*
> - * GPU RAM starts at 64TiB so huge DMA window to cover it all ends at 12=
8TiB
> - * which is enough. We do not need DMA for ATSD so we put them at 128TiB.
> - */
> -#define SPAPR_PCI_NV2ATSD_WIN_BASE   (128 * TiB)
> -#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
> -                                      64 * KiB)
> -
>  int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
>                   uint32_t intc_phandle, void *fdt, int *node_offset);
> =20
> @@ -149,13 +130,6 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb=
, int *state);
>  int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
>  int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
>  void spapr_phb_vfio_reset(DeviceState *qdev);
> -void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp);
> -void spapr_phb_nvgpu_free(SpaprPhbState *sphb);
> -void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus=
_off,
> -                                 Error **errp);
> -void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt);
> -void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
> -                                        SpaprPhbState *sphb);
>  #else
>  static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>  {
> @@ -182,25 +156,6 @@ static inline int spapr_phb_vfio_eeh_configure(Spapr=
PhbState *sphb)
>  static inline void spapr_phb_vfio_reset(DeviceState *qdev)
>  {
>  }
> -static inline void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **er=
rp)
> -{
> -}
> -static inline void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
> -{
> -}
> -static inline void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void=
 *fdt,
> -                                               int bus_off, Error **errp)
> -{
> -}
> -static inline void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb,
> -                                                   void *fdt)
> -{
> -}
> -static inline void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, vo=
id *fdt,
> -                                                      int offset,
> -                                                      SpaprPhbState *sph=
b)
> -{
> -}
>  #endif
> =20
>  void spapr_phb_dma_reset(SpaprPhbState *sphb);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f4bd204d8633..fca60b403198 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -103,11 +103,8 @@ typedef enum {
> =20
>  #define FDT_MAX_SIZE                    0x200000
> =20
> -/* Max number of GPUs per system */
> -#define NVGPU_MAX_NUM              6
> -
>  /* Max number of NUMA nodes */
> -#define NUMA_NODES_MAX_NUM         (MAX_NODES + NVGPU_MAX_NUM)
> +#define NUMA_NODES_MAX_NUM         (MAX_NODES)
> =20
>  /*
>   * NUMA FORM1 macros. FORM1_DIST_REF_POINTS was taken from
> @@ -160,8 +157,7 @@ struct SpaprMachineClass {
>      bool (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,
>                            hwaddr *mmio32, hwaddr *mmio64,
> -                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2g=
pa,
> -                          hwaddr *nv2atsd, Error **errp);
> +                          unsigned n_dma, uint32_t *liobns, Error **errp=
);
>      SpaprResizeHpt resize_hpt_default;
>      SpaprCapabilities default_caps;
>      SpaprIrq *irq;
> @@ -276,7 +272,6 @@ struct SpaprMachineState {
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      SpaprCapabilities def, eff, mig;
> =20
> -    unsigned gpu_numa_id;
>      SpaprTpmProxy *tpm_proxy;
> =20
>      uint32_t FORM1_assoc_array[NUMA_NODES_MAX_NUM][FORM1_NUMA_ASSOC_SIZE=
];
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f7cc6a890f45..de3c616b4637 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2875,8 +2875,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>      /* init CPUs */
>      spapr_init_cpus(spapr);
> =20
> -    spapr->gpu_numa_id =3D spapr_numa_initial_nvgpu_numa_id(machine);
> -
>      /* Init numa_assoc_array */
>      spapr_numa_associativity_init(spapr, machine);
> =20
> @@ -4134,7 +4132,6 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>                             &sphb->buid, &sphb->io_win_addr,
>                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
>                             windows_supported, sphb->dma_liobn,
> -                           &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_=
addr,
>                             errp);
>  }
> =20
> @@ -4397,8 +4394,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
_ids(MachineState *machine)
>  static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
>                                  uint64_t *buid, hwaddr *pio,
>                                  hwaddr *mmio32, hwaddr *mmio64,
> -                                unsigned n_dma, uint32_t *liobns,
> -                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error *=
*errp)
> +                                unsigned n_dma, uint32_t *liobns, Error =
**errp)
>  {
>      /*
>       * New-style PHB window placement.
> @@ -4443,9 +4439,6 @@ static bool spapr_phb_placement(SpaprMachineState *=
spapr, uint32_t index,
>      *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>      *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
> -
> -    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64=
_WIN_SIZE;
> -    *nv2atsd =3D SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_=
WIN_SIZE;
>      return true;
>  }
> =20
> @@ -4963,16 +4956,12 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
>  static bool phb_placement_4_0(SpaprMachineState *spapr, uint32_t index,
>                                uint64_t *buid, hwaddr *pio,
>                                hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns,
> -                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
> +                              unsigned n_dma, uint32_t *liobns, Error **=
errp)
>  {
>      if (!spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_=
dma,
> -                             liobns, nv2gpa, nv2atsd, errp)) {
> +                             liobns, errp)) {
>          return false;
>      }
> -
> -    *nv2gpa =3D 0;
> -    *nv2atsd =3D 0;
>      return true;
>  }
>  static void spapr_machine_4_0_class_options(MachineClass *mc)
> @@ -5137,8 +5126,7 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>  static bool phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
>                                uint64_t *buid, hwaddr *pio,
>                                hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns,
> -                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
> +                              unsigned n_dma, uint32_t *liobns, Error **=
errp)
>  {
>      /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>      const uint64_t base_buid =3D 0x800000020000000ULL;
> @@ -5183,8 +5171,6 @@ static bool phb_placement_2_7(SpaprMachineState *sp=
apr, uint32_t index,
>       * window into contiguous 32-bit and 64-bit windows
>       */
> =20
> -    *nv2gpa =3D 0;
> -    *nv2atsd =3D 0;
>      return true;
>  }
> =20
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index a64098c375e0..b95ca3dd36fc 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -108,20 +108,6 @@ static bool spapr_numa_is_symmetrical(MachineState *=
ms)
>      return true;
>  }
> =20
> -/*
> - * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
> - * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
> - * called from vPHB reset handler so we initialize the counter here.
> - * If no NUMA is configured from the QEMU side, we start from 1 as GPU R=
AM
> - * must be equally distant from any other node.
> - * The final value of spapr->gpu_numa_id is going to be written to
> - * max-associativity-domains in spapr_build_fdt().
> - */
> -unsigned int spapr_numa_initial_nvgpu_numa_id(MachineState *machine)
> -{
> -    return MAX(1, machine->numa_state->num_nodes);
> -}
> -
>  /*
>   * This function will translate the user distances into
>   * what the kernel understand as possible values: 10
> @@ -277,7 +263,7 @@ static void spapr_numa_FORM1_affinity_init(SpaprMachi=
neState *spapr,
>  {
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      int nb_numa_nodes =3D machine->numa_state->num_nodes;
> -    int i, j, max_nodes_with_gpus;
> +    int i, j;
> =20
>      /*
>       * For all associativity arrays: first position is the size,
> @@ -293,17 +279,7 @@ static void spapr_numa_FORM1_affinity_init(SpaprMach=
ineState *spapr,
>          spapr->FORM1_assoc_array[i][FORM1_DIST_REF_POINTS] =3D cpu_to_be=
32(i);
>      }
> =20
> -    /*
> -     * Initialize NVLink GPU associativity arrays. We know that
> -     * the first GPU will take the first available NUMA id, and
> -     * we'll have a maximum of NVGPU_MAX_NUM GPUs in the machine.
> -     * At this point we're not sure if there are GPUs or not, but
> -     * let's initialize the associativity arrays and allow NVLink
> -     * GPUs to be handled like regular NUMA nodes later on.
> -     */
> -    max_nodes_with_gpus =3D nb_numa_nodes + NVGPU_MAX_NUM;
> -
> -    for (i =3D nb_numa_nodes; i < max_nodes_with_gpus; i++) {
> +    for (i =3D nb_numa_nodes; i < nb_numa_nodes; i++) {
>          spapr->FORM1_assoc_array[i][0] =3D cpu_to_be32(FORM1_DIST_REF_PO=
INTS);
> =20
>          for (j =3D 1; j < FORM1_DIST_REF_POINTS; j++) {
> @@ -345,10 +321,6 @@ static void spapr_numa_FORM2_affinity_init(SpaprMach=
ineState *spapr)
>       * CPUs will write an additional 'vcpu_id' on top of the arrays
>       * being initialized here. 'numa_id' is represented by the
>       * index 'i' of the loop.
> -     *
> -     * Given that this initialization is also valid for GPU associativity
> -     * arrays, handle everything in one single step by populating the
> -     * arrays up to NUMA_NODES_MAX_NUM.
>       */
>      for (i =3D 0; i < NUMA_NODES_MAX_NUM; i++) {
>          spapr->FORM2_assoc_array[i][0] =3D cpu_to_be32(1);
> @@ -461,8 +433,6 @@ static void spapr_numa_FORM1_write_rtas_dt(SpaprMachi=
neState *spapr,
>  {
>      MachineState *ms =3D MACHINE(spapr);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> -    uint32_t number_nvgpus_nodes =3D spapr->gpu_numa_id -
> -                                   spapr_numa_initial_nvgpu_numa_id(ms);
>      uint32_t refpoints[] =3D {
>          cpu_to_be32(0x4),
>          cpu_to_be32(0x3),
> @@ -470,7 +440,7 @@ static void spapr_numa_FORM1_write_rtas_dt(SpaprMachi=
neState *spapr,
>          cpu_to_be32(0x1),
>      };
>      uint32_t nr_refpoints =3D ARRAY_SIZE(refpoints);
> -    uint32_t maxdomain =3D ms->numa_state->num_nodes + number_nvgpus_nod=
es;
> +    uint32_t maxdomain =3D ms->numa_state->num_nodes;
>      uint32_t maxdomains[] =3D {
>          cpu_to_be32(4),
>          cpu_to_be32(maxdomain),
> @@ -486,13 +456,12 @@ static void spapr_numa_FORM1_write_rtas_dt(SpaprMac=
hineState *spapr,
>              cpu_to_be32(0x4),
>              cpu_to_be32(0x2),
>          };
> -        uint32_t legacy_maxdomain =3D spapr->gpu_numa_id > 1 ? 1 : 0;
>          uint32_t legacy_maxdomains[] =3D {
>              cpu_to_be32(4),
> -            cpu_to_be32(legacy_maxdomain),
> -            cpu_to_be32(legacy_maxdomain),
> -            cpu_to_be32(legacy_maxdomain),
> -            cpu_to_be32(spapr->gpu_numa_id),
> +            cpu_to_be32(0),
> +            cpu_to_be32(0),
> +            cpu_to_be32(0),
> +            cpu_to_be32(nb_numa_nodes ? nb_numa_nodes : 1),
>          };
> =20
>          G_STATIC_ASSERT(sizeof(legacy_refpoints) <=3D sizeof(refpoints));
> @@ -581,8 +550,6 @@ static void spapr_numa_FORM2_write_rtas_dt(SpaprMachi=
neState *spapr,
>                                             void *fdt, int rtas)
>  {
>      MachineState *ms =3D MACHINE(spapr);
> -    uint32_t number_nvgpus_nodes =3D spapr->gpu_numa_id -
> -                                   spapr_numa_initial_nvgpu_numa_id(ms);
> =20
>      /*
>       * In FORM2, ibm,associativity-reference-points will point to
> @@ -596,7 +563,7 @@ static void spapr_numa_FORM2_write_rtas_dt(SpaprMachi=
neState *spapr,
>       */
>      uint32_t refpoints[] =3D { cpu_to_be32(1) };
> =20
> -    uint32_t maxdomain =3D ms->numa_state->num_nodes + number_nvgpus_nod=
es;
> +    uint32_t maxdomain =3D ms->numa_state->num_nodes;
>      uint32_t maxdomains[] =3D { cpu_to_be32(1), cpu_to_be32(maxdomain) };
> =20
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 75aacda65a14..ce1495931744 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1443,8 +1443,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb,=
 PCIDevice *dev,
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
>      }
> =20
> -    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
> -
>      if (!IS_PCI_BRIDGE(dev)) {
>          /* Properties only for non-bridges */
>          uint32_t min_grant =3D pci_default_read_config(dev, PCI_MIN_GNT,=
 1);
> @@ -1757,8 +1755,6 @@ static void spapr_phb_unrealize(DeviceState *dev)
>      int i;
>      const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> =20
> -    spapr_phb_nvgpu_free(sphb);
> -
>      if (sphb->msi) {
>          g_hash_table_unref(sphb->msi);
>          sphb->msi =3D NULL;
> @@ -2069,14 +2065,8 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
>  static void spapr_phb_reset(DeviceState *qdev)
>  {
>      SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
> -    Error *err =3D NULL;
> =20
>      spapr_phb_dma_reset(sphb);
> -    spapr_phb_nvgpu_free(sphb);
> -    spapr_phb_nvgpu_setup(sphb, &err);
> -    if (err) {
> -        error_report_err(err);
> -    }
> =20
>      /* Reset the IOMMU state */
>      object_child_foreach(OBJECT(qdev), spapr_phb_children_reset, NULL);
> @@ -2112,8 +2102,6 @@ static Property spapr_phb_properties[] =3D {
>                       pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
>                       pcie_ecs, true),
> -    DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
> -    DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
>      DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
>                       pre_5_1_assoc, false),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -2362,7 +2350,6 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhb=
State *phb,
>      };
>      SpaprTceTable *tcet;
>      SpaprDrc *drc;
> -    Error *err =3D NULL;
> =20
>      /* Start populating the FDT */
>      _FDT(bus_off =3D fdt_add_subnode(fdt, 0, phb->dtbusname));
> @@ -2443,12 +2430,6 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPh=
bState *phb,
>          return ret;
>      }
> =20
> -    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &err);
> -    if (err) {
> -        error_report_err(err);
> -    }
> -    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
> -
>      return 0;
>  }
> =20
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> deleted file mode 100644
> index 2a8a11be1d68..000000000000
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ /dev/null
> @@ -1,442 +0,0 @@
> -/*
> - * QEMU sPAPR PCI for NVLink2 pass through
> - *
> - * Copyright (c) 2019 Alexey Kardashevskiy, IBM Corporation.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> - * of this software and associated documentation files (the "Software"),=
 to deal
> - * in the Software without restriction, including without limitation the=
 rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> - * THE SOFTWARE.
> - */
> -#include "qemu/osdep.h"
> -#include "qapi/error.h"
> -#include "hw/pci/pci.h"
> -#include "hw/pci-host/spapr.h"
> -#include "hw/ppc/spapr_numa.h"
> -#include "qemu/error-report.h"
> -#include "hw/ppc/fdt.h"
> -#include "hw/pci/pci_bridge.h"
> -
> -#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
> -                                     (((phb)->index) << 16) | ((pdev)->d=
evfn))
> -#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
> -                                     (((phb)->index) << 16))
> -#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
> -                                     ((gn) << 4) | (nn))
> -
> -typedef struct SpaprPhbPciNvGpuSlot {
> -        uint64_t tgt;
> -        uint64_t gpa;
> -        unsigned numa_id;
> -        PCIDevice *gpdev;
> -        int linknum;
> -        struct {
> -            uint64_t atsd_gpa;
> -            PCIDevice *npdev;
> -            uint32_t link_speed;
> -        } links[NVGPU_MAX_LINKS];
> -} SpaprPhbPciNvGpuSlot;
> -
> -struct SpaprPhbPciNvGpuConfig {
> -    uint64_t nv2_ram_current;
> -    uint64_t nv2_atsd_current;
> -    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] */
> -    SpaprPhbPciNvGpuSlot slots[NVGPU_MAX_NUM];
> -    Error *err;
> -};
> -
> -static SpaprPhbPciNvGpuSlot *
> -spapr_nvgpu_get_slot(SpaprPhbPciNvGpuConfig *nvgpus, uint64_t tgt)
> -{
> -    int i;
> -
> -    /* Search for partially collected "slot" */
> -    for (i =3D 0; i < nvgpus->num; ++i) {
> -        if (nvgpus->slots[i].tgt =3D=3D tgt) {
> -            return &nvgpus->slots[i];
> -        }
> -    }
> -
> -    if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->slots)) {
> -        return NULL;
> -    }
> -
> -    i =3D nvgpus->num;
> -    nvgpus->slots[i].tgt =3D tgt;
> -    ++nvgpus->num;
> -
> -    return &nvgpus->slots[i];
> -}
> -
> -static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
> -                                    PCIDevice *pdev, uint64_t tgt,
> -                                    MemoryRegion *mr, Error **errp)
> -{
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
> -    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
> -
> -    if (!nvslot) {
> -        error_setg(errp, "Found too many GPUs per vPHB");
> -        return;
> -    }
> -    g_assert(!nvslot->gpdev);
> -    nvslot->gpdev =3D pdev;
> -
> -    nvslot->gpa =3D nvgpus->nv2_ram_current;
> -    nvgpus->nv2_ram_current +=3D memory_region_size(mr);
> -    nvslot->numa_id =3D spapr->gpu_numa_id;
> -    ++spapr->gpu_numa_id;
> -}
> -
> -static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
> -                                    PCIDevice *pdev, uint64_t tgt,
> -                                    MemoryRegion *mr, Error **errp)
> -{
> -    SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
> -    int j;
> -
> -    if (!nvslot) {
> -        error_setg(errp, "Found too many NVLink bridges per vPHB");
> -        return;
> -    }
> -
> -    j =3D nvslot->linknum;
> -    if (j =3D=3D ARRAY_SIZE(nvslot->links)) {
> -        error_setg(errp, "Found too many NVLink bridges per GPU");
> -        return;
> -    }
> -    ++nvslot->linknum;
> -
> -    g_assert(!nvslot->links[j].npdev);
> -    nvslot->links[j].npdev =3D pdev;
> -    nvslot->links[j].atsd_gpa =3D nvgpus->nv2_atsd_current;
> -    nvgpus->nv2_atsd_current +=3D memory_region_size(mr);
> -    nvslot->links[j].link_speed =3D
> -        object_property_get_uint(OBJECT(pdev), "nvlink2-link-speed", NUL=
L);
> -}
> -
> -static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
> -                                        void *opaque)
> -{
> -    PCIBus *sec_bus;
> -    Object *po =3D OBJECT(pdev);
> -    uint64_t tgt =3D object_property_get_uint(po, "nvlink2-tgt", NULL);
> -
> -    if (tgt) {
> -        Error *local_err =3D NULL;
> -        SpaprPhbPciNvGpuConfig *nvgpus =3D opaque;
> -        Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr[0]",=
 NULL);
> -        Object *mr_npu =3D object_property_get_link(po, "nvlink2-atsd-mr=
[0]",
> -                                                  NULL);
> -
> -        g_assert(mr_gpu || mr_npu);
> -        if (mr_gpu) {
> -            spapr_pci_collect_nvgpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
gpu),
> -                                    &local_err);
> -        } else {
> -            spapr_pci_collect_nvnpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
npu),
> -                                    &local_err);
> -        }
> -        error_propagate(&nvgpus->err, local_err);
> -    }
> -    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> -         PCI_HEADER_TYPE_BRIDGE)) {
> -        return;
> -    }
> -
> -    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> -    if (!sec_bus) {
> -        return;
> -    }
> -
> -    pci_for_each_device_under_bus(sec_bus, spapr_phb_pci_collect_nvgpu, =
opaque);
> -}
> -
> -void spapr_phb_nvgpu_setup(SpaprPhbState *sphb, Error **errp)
> -{
> -    int i, j, valid_gpu_num;
> -    PCIBus *bus;
> -
> -    /* Search for GPUs and NPUs */
> -    if (!sphb->nv2_gpa_win_addr || !sphb->nv2_atsd_win_addr) {
> -        return;
> -    }
> -
> -    sphb->nvgpus =3D g_new0(SpaprPhbPciNvGpuConfig, 1);
> -    sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
> -    sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
> -
> -    bus =3D PCI_HOST_BRIDGE(sphb)->bus;
> -    pci_for_each_device_under_bus(bus, spapr_phb_pci_collect_nvgpu,
> -                                  sphb->nvgpus);
> -
> -    if (sphb->nvgpus->err) {
> -        error_propagate(errp, sphb->nvgpus->err);
> -        sphb->nvgpus->err =3D NULL;
> -        goto cleanup_exit;
> -    }
> -
> -    /* Add found GPU RAM and ATSD MRs if found */
> -    for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
> -        Object *nvmrobj;
> -        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> -
> -        if (!nvslot->gpdev) {
> -            continue;
> -        }
> -        nvmrobj =3D object_property_get_link(OBJECT(nvslot->gpdev),
> -                                           "nvlink2-mr[0]", NULL);
> -        /* ATSD is pointless without GPU RAM MR so skip those */
> -        if (!nvmrobj) {
> -            continue;
> -        }
> -
> -        ++valid_gpu_num;
> -        memory_region_add_subregion(get_system_memory(), nvslot->gpa,
> -                                    MEMORY_REGION(nvmrobj));
> -
> -        for (j =3D 0; j < nvslot->linknum; ++j) {
> -            Object *atsdmrobj;
> -
> -            atsdmrobj =3D object_property_get_link(OBJECT(nvslot->links[=
j].npdev),
> -                                                 "nvlink2-atsd-mr[0]", N=
ULL);
> -            if (!atsdmrobj) {
> -                continue;
> -            }
> -            memory_region_add_subregion(get_system_memory(),
> -                                        nvslot->links[j].atsd_gpa,
> -                                        MEMORY_REGION(atsdmrobj));
> -        }
> -    }
> -
> -    if (valid_gpu_num) {
> -        return;
> -    }
> -    /* We did not find any interesting GPU */
> -cleanup_exit:
> -    g_free(sphb->nvgpus);
> -    sphb->nvgpus =3D NULL;
> -}
> -
> -void spapr_phb_nvgpu_free(SpaprPhbState *sphb)
> -{
> -    int i, j;
> -
> -    if (!sphb->nvgpus) {
> -        return;
> -    }
> -
> -    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> -        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
> -                                                    "nvlink2-mr[0]", NUL=
L);
> -
> -        if (nv_mrobj) {
> -            memory_region_del_subregion(get_system_memory(),
> -                                        MEMORY_REGION(nv_mrobj));
> -        }
> -        for (j =3D 0; j < nvslot->linknum; ++j) {
> -            PCIDevice *npdev =3D nvslot->links[j].npdev;
> -            Object *atsd_mrobj;
> -            atsd_mrobj =3D object_property_get_link(OBJECT(npdev),
> -                                                  "nvlink2-atsd-mr[0]", =
NULL);
> -            if (atsd_mrobj) {
> -                memory_region_del_subregion(get_system_memory(),
> -                                            MEMORY_REGION(atsd_mrobj));
> -            }
> -        }
> -    }
> -    g_free(sphb->nvgpus);
> -    sphb->nvgpus =3D NULL;
> -}
> -
> -void spapr_phb_nvgpu_populate_dt(SpaprPhbState *sphb, void *fdt, int bus=
_off,
> -                                 Error **errp)
> -{
> -    int i, j, atsdnum =3D 0;
> -    uint64_t atsd[8]; /* The existing limitation of known guests */
> -
> -    if (!sphb->nvgpus) {
> -        return;
> -    }
> -
> -    for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)=
); ++i) {
> -        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> -
> -        if (!nvslot->gpdev) {
> -            continue;
> -        }
> -        for (j =3D 0; j < nvslot->linknum; ++j) {
> -            if (!nvslot->links[j].atsd_gpa) {
> -                continue;
> -            }
> -
> -            if (atsdnum =3D=3D ARRAY_SIZE(atsd)) {
> -                error_report("Only %"PRIuPTR" ATSD registers supported",
> -                             ARRAY_SIZE(atsd));
> -                break;
> -            }
> -            atsd[atsdnum] =3D cpu_to_be64(nvslot->links[j].atsd_gpa);
> -            ++atsdnum;
> -        }
> -    }
> -
> -    if (!atsdnum) {
> -        error_setg(errp, "No ATSD registers found");
> -        return;
> -    }
> -
> -    if (!spapr_phb_eeh_available(sphb)) {
> -        /*
> -         * ibm,mmio-atsd contains ATSD registers; these belong to an NPU=
 PHB
> -         * which we do not emulate as a separate device. Instead we put
> -         * ibm,mmio-atsd to the vPHB with GPU and make sure that we do n=
ot
> -         * put GPUs from different IOMMU groups to the same vPHB to ensu=
re
> -         * that the guest will use ATSDs from the corresponding NPU.
> -         */
> -        error_setg(errp, "ATSD requires separate vPHB per GPU IOMMU grou=
p");
> -        return;
> -    }
> -
> -    _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd", atsd,
> -                      atsdnum * sizeof(atsd[0]))));
> -}
> -
> -void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
> -{
> -    int i, j, linkidx, npuoff;
> -    g_autofree char *npuname =3D NULL;
> -
> -    if (!sphb->nvgpus) {
> -        return;
> -    }
> -
> -    npuname =3D g_strdup_printf("npuphb%d", sphb->index);
> -    npuoff =3D fdt_add_subnode(fdt, 0, npuname);
> -    _FDT(npuoff);
> -    _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
> -    _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
> -    /* Advertise NPU as POWER9 so the guest can enable NPU2 contexts */
> -    _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9-npu"=
)));
> -
> -    for (i =3D 0, linkidx =3D 0; i < sphb->nvgpus->num; ++i) {
> -        for (j =3D 0; j < sphb->nvgpus->slots[i].linknum; ++j) {
> -            g_autofree char *linkname =3D g_strdup_printf("link@%d", lin=
kidx);
> -            int off =3D fdt_add_subnode(fdt, npuoff, linkname);
> -
> -            _FDT(off);
> -            /* _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx))); */
> -            _FDT((fdt_setprop_string(fdt, off, "compatible",
> -                                     "ibm,npu-link")));
> -            _FDT((fdt_setprop_cell(fdt, off, "phandle",
> -                                   PHANDLE_NVLINK(sphb, i, j))));
> -            _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index", linki=
dx)));
> -            ++linkidx;
> -        }
> -    }
> -
> -    /* Add memory nodes for GPU RAM and mark them unusable */
> -    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> -        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
> -                                                    "nvlink2-mr[0]",
> -                                                    &error_abort);
> -        uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);
> -        uint64_t mem_reg[2] =3D { cpu_to_be64(nvslot->gpa), cpu_to_be64(=
size) };
> -        g_autofree char *mem_name =3D g_strdup_printf("memory@%"PRIx64,
> -                                                    nvslot->gpa);
> -        int off =3D fdt_add_subnode(fdt, 0, mem_name);
> -
> -        _FDT(off);
> -        _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
> -        _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
> -
> -        spapr_numa_write_associativity_dt(SPAPR_MACHINE(qdev_get_machine=
()),
> -                                          fdt, off, nvslot->numa_id);
> -
> -        _FDT((fdt_setprop_string(fdt, off, "compatible",
> -                                 "ibm,coherent-device-memory")));
> -
> -        mem_reg[1] =3D cpu_to_be64(0);
> -        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg,
> -                          sizeof(mem_reg))));
> -        _FDT((fdt_setprop_cell(fdt, off, "phandle",
> -                               PHANDLE_GPURAM(sphb, i))));
> -    }
> -
> -}
> -
> -void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
> -                                        SpaprPhbState *sphb)
> -{
> -    int i, j;
> -
> -    if (!sphb->nvgpus) {
> -        return;
> -    }
> -
> -    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> -        SpaprPhbPciNvGpuSlot *nvslot =3D &sphb->nvgpus->slots[i];
> -
> -        /* Skip "slot" without attached GPU */
> -        if (!nvslot->gpdev) {
> -            continue;
> -        }
> -        if (dev =3D=3D nvslot->gpdev) {
> -            g_autofree uint32_t *npus =3D g_new(uint32_t, nvslot->linknu=
m);
> -
> -            for (j =3D 0; j < nvslot->linknum; ++j) {
> -                PCIDevice *npdev =3D nvslot->links[j].npdev;
> -
> -                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> -            }
> -            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> -                             j * sizeof(npus[0])));
> -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> -                                   PHANDLE_PCIDEV(sphb, dev))));
> -            continue;
> -        }
> -
> -        for (j =3D 0; j < nvslot->linknum; ++j) {
> -            if (dev !=3D nvslot->links[j].npdev) {
> -                continue;
> -            }
> -
> -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> -                                   PHANDLE_PCIDEV(sphb, dev))));
> -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> -                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
> -            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> -                                   PHANDLE_NVLINK(sphb, i, j))));
> -            /*
> -             * If we ever want to emulate GPU RAM at the same location a=
s on
> -             * the host - here is the encoding GPA->TGT:
> -             *
> -             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> -             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> -             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> -             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> -             */
> -            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> -                                  PHANDLE_GPURAM(sphb, i)));
> -            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> -                                 nvslot->tgt));
> -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> -                                  nvslot->links[j].link_speed));
> -        }
> -    }
> -}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f4ff83680572..84b1a7b9485c 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1610,121 +1610,6 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevic=
e *vdev, Error **errp)
>      return 0;
>  }
> =20
> -int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> -{
> -    int ret;
> -    void *p;
> -    struct vfio_region_info *nv2reg =3D NULL;
> -    struct vfio_info_cap_header *hdr;
> -    struct vfio_region_info_cap_nvlink2_ssatgt *cap;
> -    VFIOQuirk *quirk;
> -
> -    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> -                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> -                                   PCI_VENDOR_ID_NVIDIA,
> -                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RA=
M,
> -                                   &nv2reg);
> -    if (ret) {
> -        return ret;
> -    }
> -
> -    hdr =3D vfio_get_region_info_cap(nv2reg, VFIO_REGION_INFO_CAP_NVLINK=
2_SSATGT);
> -    if (!hdr) {
> -        ret =3D -ENODEV;
> -        goto free_exit;
> -    }
> -    cap =3D (void *) hdr;
> -
> -    p =3D mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE,
> -             MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
> -    if (p =3D=3D MAP_FAILED) {
> -        ret =3D -errno;
> -        goto free_exit;
> -    }
> -
> -    quirk =3D vfio_quirk_alloc(1);
> -    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev), "nvlink2-mr=
",
> -                               nv2reg->size, p);
> -    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> -
> -    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
> -                                   (uint64_t *) &cap->tgt,
> -                                   OBJ_PROP_FLAG_READ);
> -    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
> -                                          nv2reg->size);
> -free_exit:
> -    g_free(nv2reg);
> -
> -    return ret;
> -}
> -
> -int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> -{
> -    int ret;
> -    void *p;
> -    struct vfio_region_info *atsdreg =3D NULL;
> -    struct vfio_info_cap_header *hdr;
> -    struct vfio_region_info_cap_nvlink2_ssatgt *captgt;
> -    struct vfio_region_info_cap_nvlink2_lnkspd *capspeed;
> -    VFIOQuirk *quirk;
> -
> -    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> -                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> -                                   PCI_VENDOR_ID_IBM,
> -                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> -                                   &atsdreg);
> -    if (ret) {
> -        return ret;
> -    }
> -
> -    hdr =3D vfio_get_region_info_cap(atsdreg,
> -                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> -    if (!hdr) {
> -        ret =3D -ENODEV;
> -        goto free_exit;
> -    }
> -    captgt =3D (void *) hdr;
> -
> -    hdr =3D vfio_get_region_info_cap(atsdreg,
> -                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
> -    if (!hdr) {
> -        ret =3D -ENODEV;
> -        goto free_exit;
> -    }
> -    capspeed =3D (void *) hdr;
> -
> -    /* Some NVLink bridges may not have assigned ATSD */
> -    if (atsdreg->size) {
> -        p =3D mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE,
> -                 MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
> -        if (p =3D=3D MAP_FAILED) {
> -            ret =3D -errno;
> -            goto free_exit;
> -        }
> -
> -        quirk =3D vfio_quirk_alloc(1);
> -        memory_region_init_ram_device_ptr(&quirk->mem[0], OBJECT(vdev),
> -                                          "nvlink2-atsd-mr", atsdreg->si=
ze, p);
> -        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> -    }
> -
> -    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
> -                                   (uint64_t *) &captgt->tgt,
> -                                   OBJ_PROP_FLAG_READ);
> -    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
> -                                              atsdreg->size);
> -
> -    object_property_add_uint32_ptr(OBJECT(vdev), "nvlink2-link-speed",
> -                                   &capspeed->link_speed,
> -                                   OBJ_PROP_FLAG_READ);
> -    trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
> -                                              capspeed->link_speed);
> -free_exit:
> -    g_free(atsdreg);
> -
> -    return ret;
> -}
> -
>  /*
>   * The VMD endpoint provides a real PCIe domain to the guest and the gue=
st
>   * kernel performs enumeration of the VMD sub-device domain. Guest trans=
actions
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b1130f..3b2ca3c24ca2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3271,20 +3271,6 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>          }
>      }
> =20
> -    if (vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID)) {
> -        ret =3D vfio_pci_nvidia_v100_ram_init(vdev, errp);
> -        if (ret && ret !=3D -ENODEV) {
> -            error_report("Failed to setup NVIDIA V100 GPU RAM");
> -        }
> -    }
> -
> -    if (vfio_pci_is(vdev, PCI_VENDOR_ID_IBM, PCI_ANY_ID)) {
> -        ret =3D vfio_pci_nvlink2_init(vdev, errp);
> -        if (ret && ret !=3D -ENODEV) {
> -            error_report("Failed to setup NVlink2 bridge");
> -        }
> -    }
> -
>      if (!pdev->failover_pair_id) {
>          if (!vfio_migration_realize(vbasedev, errp)) {
>              goto out_deregister;
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index a313d4b964ad..7c2c52434a66 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -36,7 +36,6 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_t=
rue: files(
>  ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>  ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
>    'spapr_pci_vfio.c',
> -  'spapr_pci_nvlink2.c'
>  ))
> =20
>  # IBM PowerNV
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 81ec7c7a958b..e64ca4a01961 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -82,10 +82,6 @@ vfio_ioeventfd_handler(const char *name, uint64_t addr=
, unsigned size, uint64_t
>  vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size, uint=
64_t data, bool vfio) "%s+0x%"PRIx64"[%d]:0x%"PRIx64" vfio:%d"
>  vfio_pci_igd_opregion_enabled(const char *name) "%s"
> =20
> -vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t=
 size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> -vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint=
64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> -vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_spee=
d) "%s link_speed=3D0x%x"
> -
>  # igd.c
>  vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data,=
 uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
>  vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"


