Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C9A5EE2D
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 09:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tse4r-0004RZ-9P; Thu, 13 Mar 2025 04:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tse4n-0004QP-LE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tse4k-0004QC-Mj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 04:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741855076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ChK0rOKmhoCQiH66KIKjKocStM1fuZtKmvKhWtBaURA=;
 b=GT0xEna0BIzS4wF6BX7WycrwWPDlqoBjdXbYLSSZcvGt/noDDDgM/UgED6RBfruHtNAg/+
 9NHBY1eBCYpoUJUB/1QHExA8+f/IvwmzK20atFFs9xoP+8606cL+MWRAEXVQTQGNubCaWZ
 Rt1BKtt28Mf312cVjdt78ntxYJrh+5U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-_YJcrWXgMrm5yzgwg9XR3A-1; Thu, 13 Mar 2025 04:37:54 -0400
X-MC-Unique: _YJcrWXgMrm5yzgwg9XR3A-1
X-Mimecast-MFC-AGG-ID: _YJcrWXgMrm5yzgwg9XR3A_1741855073
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so3202535e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741855073; x=1742459873;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChK0rOKmhoCQiH66KIKjKocStM1fuZtKmvKhWtBaURA=;
 b=LrIqNuq4+6bK8BEHFnndFspTZ903tSFZNMjQgvtOnK9eiwr87ggKYhTwAr9hthoJnn
 /ohy58fKpFNjVQ97EcelrvxOzFwHxcTp+D4L2bdecObcFc+fzkPQkuiV7tQ2F+BqDJ6H
 zEWny4JuKLU8501zFBmE/Rb8Wafmy5MCpYVJBTA5qUXncizMMbTT3YUfBfq02q6ISG9A
 IV1cg5E4mGkHXJ/kEr57bj7/3rR3zuLLSA5VypgvvGawyRRRZ1o9dytWTJov2+0Kt9DS
 uzHMaoHlj1UoEK+nRXoyMY2NjceolGe+ydpEZcnJ+LqgI7EBeTosH76L7CoVAQ8Vy8Q6
 pW/w==
X-Gm-Message-State: AOJu0YziVSIczsmMM7U3S0rPKRBfjmCwmRuQXiSZibSqtOUKwJuTbMVt
 1ZL6rSZiC0Y+pfvd3IEKtNgI+FDCbP3kH+26pTg8wuhdD5r28VDX8st5JroPDgDeL4H40qMVmgp
 dy5ePVomQaFrfQCfVJGIPKLM0VIkApW+JfVJV7UnixiqHDstsBB/IJPUrRpRWYr0=
X-Gm-Gg: ASbGncsEAdK/QD7paZ+gYRIbZ4mW9vACLnMHYUCl8xFj1YlChx4SbnK5Bhkrp1Fz9A0
 B0/t9ygMaAutcjuqbThtboq4N1kGNX4/bedo0fszHL60fOydCih0YgzQGnpa+jvUw9cPFxOmozc
 Uy0xqUQvHhOFHmW0H/7vROjXW9TC6ai8YkdkmDDR57Xb0dxLDPxdAbKHdiAwOtK+ou4StyJNgyy
 phTc+16qxfBKf8r4JrAOM1/sxGKw2PGrtSX6oz9/vd83MhKMwkJa32ACU1i606Pdy7vCX5X7cqo
 cxFkmMkq0LE77jJ6ZTB8JZ5dqyq7GtY2J37xrwZxzvayB86t4kPiNQ==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43d068397bemr74046725e9.15.1741855072455; 
 Thu, 13 Mar 2025 01:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFENXHtHKulAgK+VcprOZGjsMNJUtIGGz3TqTP5EjRb+T9rDwn3KNB+8TKuj67F7C1cXSGkWw==
X-Received: by 2002:a05:600c:510e:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-43d068397bemr74046465e9.15.1741855071932; 
 Thu, 13 Mar 2025 01:37:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5cbfsm45084265e9.30.2025.03.13.01.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 01:37:51 -0700 (PDT)
Message-ID: <ff4aca8d-b1c3-4151-922f-1b32c732fa50@redhat.com>
Date: Thu, 13 Mar 2025 09:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Update IGD passthrough docoumentation
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250312155002.286841-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250312155002.286841-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Please fix in the Subject "documentation"

On 3/12/25 16:50, Tomita Moeko wrote:
> A previous change made the OpRegion and LPC quirks independent of the
> exising legacy mode, update the docoumentation accordingly. More related

existing                          documentation


Thanks,

C.


> topics, like creating EFI Option ROM of IGD for OVMF, how to solve the
> VFIO_DMA_MAP Invalid Argument warning, as well as details on IGD memory
> internals, are also added.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>   docs/igd-assign.txt | 262 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 193 insertions(+), 69 deletions(-)
> 
> diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
> index e17bb50789..c7c4565906 100644
> --- a/docs/igd-assign.txt
> +++ b/docs/igd-assign.txt
> @@ -1,44 +1,69 @@
>   Intel Graphics Device (IGD) assignment with vfio-pci
>   ====================================================
>   
> -IGD has two different modes for assignment using vfio-pci:
> -
> -1) Universal Pass-Through (UPT) mode:
> -
> -   In this mode the IGD device is added as a *secondary* (ie. non-primary)
> -   graphics device in combination with an emulated primary graphics device.
> -   This mode *requires* guest driver support to remove the external
> -   dependencies generally associated with IGD (see below).  Those guest
> -   drivers only support this mode for Broadwell and newer IGD, according to
> -   Intel.  Additionally, this mode by default, and as officially supported
> -   by Intel, does not support direct video output.  The intention is to use
> -   this mode either to provide hardware acceleration to the emulated graphics
> -   or to use this mode in combination with guest-based remote access software,
> -   for example VNC (see below for optional output support).  This mode
> -   theoretically has no device specific handling dependencies on vfio-pci or
> -   the VM firmware.
> -
> -2) "Legacy" mode:
> -
> -   In this mode the IGD device is intended to be the primary and exclusive
> -   graphics device in the VM[1], as such QEMU does not facilitate any sort
> -   of remote graphics to the VM in this mode.  A connected physical monitor
> -   is the intended output device for IGD.  This mode includes several
> -   requirements and restrictions:
> -
> -    * IGD must be given address 02.0 on the PCI root bus in the VM
> -    * The host kernel must support vfio extensions for IGD (v4.6)
> -    * vfio VGA support very likely needs to be enabled in the host kernel
> -    * The VM firmware must support specific fw_cfg enablers for IGD
> -    * The VM machine type must support a PCI host bridge at 00.0 (standard)
> -    * The VM machine type must provide or allow to be created a special
> -      ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
> -      PCI address 1f.0.
> -    * The IGD device must have a VGA ROM, either provided via the romfile
> -      option or loaded automatically through vfio (standard).  rombar=0
> -      will disable legacy mode support.
> -    * Hotplug of the IGD device is not supported.
> -    * The IGD device must be a SandyBridge or newer model device.
> +Using vfio-pci, we can passthrough Intel Graphics Device (IGD) to guest, either
> +serve as primary and exclusive graphics adapter, or used in combination with an
> +emulated primary graphics device, depending on the config and guest driver
> +support. However, IGD devices are not "clean" PCI devices, they use extra
> +memory regions other than BARs. Special handling is required to make them work
> +properly, including:
> +
> +* OpRegion for accessing Virtual BIOS Table (VBT) that contains display output
> +  information.
> +* Data Stolen Memory (DSM) region used as VRAM at early stage (BIOS/UEFI)
> +
> +Certain guest software also depends on following conditions to work:
> +(*-Required by)
> +
> +| Condition                                   | Linux | Windows | VBIOS | EFI GOP |
> +|---------------------------------------------|-------|---------|-------|---------|
> +| #1 IGD has a valid OpRegion containing VBT  |  * ^1 |    *    |   *   |    *    |
> +| #2 VID/DID of LPC bridge at 00:1f.0 matches |       |         |   *   |    *    |
> +| #3 IGD is assigned to BDF 00:02.0           |       |         |   *   |    *    |
> +| #4 IGD has VGA controller device class      |       |         |   *   |    *    |
> +| #5 Host's VGA ranges are mapped to IGD      |       |         |   *   |         |
> +| #6 Guest has valid VBIOS or UEFI Option ROM |       |         |   *   |    *    |
> +
> +^1 Though i915 driver is able to mock a OpRegion, it is still recommended to
> +   use the VBT copied from host OpRegion to prevent incorrect configuration.
> +
> +For #1, the "x-igd-opregion=on" option exposes a copy of host IGD OpRegion to
> +guest via fw_cfg, where guest firmware can set up guest OpRegion with it.
> +
> +For #2, "x-igd-lpc=on" option copies the IDs of host LPC bridge and host bridge
> +to guest. Currently this is only supported on i440fx machines as there is
> +already an ICH9 LPC bridge present on q35 machines, overwriting its IDs may
> +lead to unexpected behavior.
> +
> +For #3, "addr=2.0" assigns IGD to 00:02.0.
> +
> +For #4, the primary display must be set to IGD in host BIOS.
> +
> +For #5, "x-vga=on" enables guest access to standard VGA IO/MMIO ranges.
> +
> +For #6, ROM either provided via the ROM BAR or romfile= option is needed, this
> +Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
> +"Guest firmware" section.
> +
> +QEMU also provides a "Legacy" mode that implicitly enables full functionality
> +on IGD, it is automatically enabled when
> +* Machine type is i440fx
> +* IGD is assigned to guest BDF 00:02.0
> +* ROM BAR or romfile is present
> +
> +In "Legacy" mode, QEMU will automatically setup OpRegion, LPC bridge IDs and
> +VGA range access, which is equivalent to:
> +  x-igd-opregion=on,x-igd-lpc=on,x-vga=on
> +
> +By default, "Legacy" mode won't fail, it continues on error. User can set
> +"x-igd-legacy-mode=on" to force enabling legacy mode, this also checks if the
> +conditions above for legacy mode is met, and if any error occurs, QEMU will
> +fail immediately. Users can also set "x-igd-legacy-mode=off" to disable legacy
> +mode.
> +
> +In legacy mode, as the guest VGA ranges are assigned to IGD device, all other
> +graphics devices should be removed, this can be done using "-nographic" or
> +"-vga none" or "-nodefaults", along with adding the device using vfio-pci.
>   
>   For either mode, depending on the host kernel, the i915 driver in the host
>   may generate faults and errors upon re-binding to an IGD device after it
> @@ -73,31 +98,39 @@ DVI, or DisplayPort) may be unsupported in some use cases.  In the author's
>   experience, even DP to VGA adapters can be troublesome while adapters between
>   digital formats work well.
>   
> -Usage
> -=====
> -The intention is for IGD assignment to be transparent for users and thus for
> -management tools like libvirt.  To make use of legacy mode, simply remove all
> -other graphics options and use "-nographic" and either "-vga none" or
> -"-nodefaults", along with adding the device using vfio-pci:
>   
> -    -device vfio-pci,host=00:02.0,id=hostdev0,bus=pci.0,addr=0x2
> +Options
> +=======
> +* x-igd-opregion=[on|*off*]
> +  Copy host IGD OpRegion and expose it to guest with fw_cfg
> +
> +* x-igd-lpc=[on|*off*]
> +  Creates a dummy LPC bridge at 00:1f:0 with host VID/DID (i440fx only)
> +
> +* x-igd-legacy-mode=[on|off|*auto*]
> +  Enable/Disable legacy mode
> +
> +* x-igd-gms=[hex, default 0]
> +  Overriding DSM region size in GGC register, 0 means uses host value.
> +  Use this only when the DSM size cannot be changed through the
> +  'DVMT Pre-Allocated' option in host BIOS.
>   
> -For UPT mode, retain the default emulated graphics and simply add the vfio-pci
> -device making use of any other bus address other than 02.0.  libvirt will
> -default to assigning the device a UPT compatible address while legacy mode
> -users will need to manually edit the XML if using a tool like virt-manager
> -where the VM device address is not expressly specified.
>   
> -An experimental vfio-pci option also exists to enable OpRegion, and thus
> -external monitor support, for UPT mode.  This can be enabled by adding
> -"x-igd-opregion=on" to the vfio-pci device options for the IGD device.  As
> -with legacy mode, this requires the host to support features introduced in
> -the v4.6 kernel.  If Intel chooses to embrace this support, the option may
> -be made non-experimental in the future, opening it to libvirt support.
> +Examples
> +========
> +* Adding IGD with automatically legacy mode support
> +  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0
>   
> -Developer ABI
> -=============
> -Legacy mode IGD support imposes two fw_cfg requirements on the VM firmware:
> +* Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
> +  (For UEFI guests)
> +  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-opregion=on,x-igd-lpc=on,romfile=efi_oprom.rom
> +
> +
> +Guest firmware
> +==============
> +Guest firmware is responsible for setting up OpRegion and Base of Data Stolen
> +Memory (BDSM) in guest address space. IGD passthrough support imposes two
> +fw_cfg requirements on the VM firmware:
>   
>   1) "etc/igd-opregion"
>   
> @@ -117,17 +150,108 @@ Legacy mode IGD support imposes two fw_cfg requirements on the VM firmware:
>      Firmware must allocate a reserved memory below 4GB with required 1MB
>      alignment equal to this size.  Additionally the base address of this
>      reserved region must be written to the dword BDSM register in PCI config
> -   space of the IGD device at offset 0x5C.  As this support is related to
> -   running the IGD ROM, which has other dependencies on the device appearing
> -   at guest address 00:02.0, it's expected that this fw_cfg file is only
> -   relevant to a single PCI class VGA device with Intel vendor ID, appearing
> -   at PCI bus address 00:02.0.
> +   space of the IGD device at offset 0x5C (or 0xC0 for Gen 11+ devices using
> +   64-bit BDSM).  As this support is related to running the IGD ROM, which
> +   has other dependencies on the device appearing at guest address 00:02.0,
> +   it's expected that this fw_cfg file is only relevant to a single PCI
> +   class VGA device with Intel vendor ID, appearing at PCI bus address 00:02.0.
> +
> +Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
> +However, the support is not accepted by upstream EDK2/OVMF. A recommended
> +solution is to create a virtual OpRom with following DXE drivers:
> +
> +* IgdAssignmentDxe: Set up OpRegion and BDSM according to fw_cfg (must)
> +* IntelGopDriver: Closed-source Intel GOP driver
> +* PlatformGopPolicy: Protocol required by IntelGopDriver
> +
> +IntelGopDriver and PlatformGopPolicy is only required when enabling GOP on IGD.
> +
> +The original IgdAssignmentDxe can be found at [3]. A Intel maintained version
> +with PlatformGopPolicy for industrial computing is at [4]. There is also an
> +unofficially maintained version with newer Gen11+ device support at [5].
> +You need to build them with EDK2.
> +
> +For the IntelGopDriver, Intel never released it to public. You may contact
> +Intel support to get one as [4] said, if you are an Intel primer customer,
> +or you can try extract it from your host firmware using "UEFI BIOS Updater"[6].
> +
> +Once you got all the required DXE drivers, a Option ROM can be generated with
> +EfiRom utility in EDK2, using
> +  EfiRom -f 0x8086 -i <Device ID of your IGD> -o output.rom \
> +  -e IgdAssignmentDxe.efi PlatformGOPPolicy.efi IntelGopDriver.efi
> +
> +
> +Known issues
> +============
> +When using OVMF as guest firmware, you may encounter the following warning:
> +warning: vfio_container_dma_map(0x55fab36ce610, 0x380010000000, 0x108000, 0x7fd336000000) = -22 (Invalid argument)
> +Solution:
> +Set the host physical address bits to IOMMU address width using
> +  -cpu host,host-phys-bits-limit=<IOMMU address width>
> +Or in libvirt XML with
> +  <cpu>
> +    <maxphysaddr mode='passthrough' limit='<IOMMU address width>'/>
> +  </cpu>
> +The IOMMU address width can be determined with
> +echo $(( ((0x$(cat /sys/devices/virtual/iommu/dmar0/intel-iommu/cap) & 0x3F0000) >> 16) + 1 ))
> +Refer https://edk2.groups.io/g/devel/topic/patch_v1/102359124 for more details
> +
> +
> +Memory View
> +===========
> +IGD has it own address space. To use system RAM as VRAM, a single-level page
> +table named Graphics Translation Table (GTT) is used for the address
> +translation. Each page table entry points a 4KB page. The translation flow is:
> +
> +(PTE size 8)             +-------------+---+
> +                         |   Address   | V |  V: Valid Bit
> +                         +-------------+---+
> +                         | ...         |   |
> +IGD:0x01ae9010     0xd740| 0x70ffc000  | 1 |  Mem:0x42ba3e010^
> +-----------------> 0xd748| 0x42ba3e000 | 1 +------------------>
> +(addr << 12) * 8   0xd750| 0x42ba3f000 | 1 |
> +                         | ...         |   |
> +                         +-------------+---+
> +^ The address may be remapped by IOMMU
> +
> +The memory region store GTT is called GTT Stolen Memory (GSM), it is located
> +right below the Data Stolen Memory (DSM). Accessing this region directly is
> +not allowed, any access will immediately freeze the whole system. The only way
> +to access it is through the second half of MMIO BAR0.
> +
> +The Data Stolen Memory is reserved by firmware, and acts as the VRAM in pre-OS
> +environments. In QEMU, guest firmware (Seabios/OVMF) is responsible for
> +reserving a continuous region and program its base address to BDSM register,
> +then let VBIOS/GOP driver initializing this region. Illustration below shows
> +how DSM is mapped.
> +
> +       IGD Addr Space                 Host Addr Space         Guest Addr Space
> +       +-------------+                +-------------+         +-------------+
> +       |             |                |             |         |             |
> +       |             |                |             |         |             |
> +       |             |                +-------------+         +-------------+
> +       |             |                | Data Stolen |         | Data Stolen |
> +       |             |                |   (Guest)   |         |   (Guest)   |
> +       |             |  +------------>+-------------+<------->+-------------+<--Guest BDSM
> +       |             |  | Passthrough |             | EPT     |             |   Emulated by QEMU
> +DSMSIZE+-------------+  | with IOMMU  |             | Mapping |             |   Programmed by guest FW
> +       |             |  |             |             |         |             |
> +       |             |  |             |             |         |             |
> +      0+-------------+--+             |             |         |             |
> +                        |             +-------------+         |             |
> +                        |             | Data Stolen |         +-------------+
> +                        |             |   (Host)    |
> +                        +------------>+-------------+<--Host BDSM
> +                          Non-        |             |   "real" one in HW
> +                          Passthrough |             |   Programmed by host FW
> +                                      +-------------+
>   
>   Footnotes
>   =========
> -[1] Nothing precludes adding additional emulated or assigned graphics devices
> -    as non-primary, other than the combination typically not working.  I only
> -    intend to set user expectations, others are welcome to find working
> -    combinations or fix whatever issues prevent this from working in the common
> -    case.
> +[1] https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/dump-video-bios.html
>   [2] # echo "vfio-pci" > /sys/bus/pci/devices/0000:00:02.0/driver_override
> +[3] https://web.archive.org/web/20240827012422/https://bugzilla.tianocore.org/show_bug.cgi?id=935
> +    Tianocore bugzilla was down since Jan 2025 :(
> +[4] https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html, Patch 0001-0004
> +[5] https://github.com/tomitamoeko/VfioIgdPkg
> +[6] https://winraid.level1techs.com/t/tool-guide-news-uefi-bios-updater-ubu/30357


