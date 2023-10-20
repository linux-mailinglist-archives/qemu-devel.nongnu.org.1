Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D3C7D0FFC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp28-0004gC-Rg; Fri, 20 Oct 2023 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtp27-0004ds-DL
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtp1u-00027L-PU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32db8924201so557056f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697806505; x=1698411305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9hw7HkiTNzj85z9L8QGhIY1A6LuiA6eNsu10HcWRzTw=;
 b=QUnApw4tCjR5KfQ5bHme2GtQEAbHMSmKUWivTuhFxgzPUYtgFckSoEQ7WJfhpHlngN
 iuwbJI+r8IiIsb0ThoJhaCRVt9an45sW34dsmD+oKZ2ELs0ah938E1NXM1/tuu9kJW9M
 hen4qPVZmy9mx5bLzGpwbDgC3jpZyVN3/nukAhfBwQV5olnTJOq9Czbgnbl/7JtzObdR
 r+MBpjQtTgqjF04Op1qv4YLoHbF8ozpHcRLNw5bPk705Hjfaj8nN/Of5f/+E+GuAcMIF
 G6pulm6UkUYpmZXH1jzjzfuFsZaTEKMSPGCLtC64pcCNN5G6oQ31aQPlVofpCsefZLK6
 ii9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697806505; x=1698411305;
 h=content-transfer-encoding:in-reply-to:from:to:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hw7HkiTNzj85z9L8QGhIY1A6LuiA6eNsu10HcWRzTw=;
 b=Npb7nLcW0epaiUivkJVY3L7v0kUfdmkMDY1gTMFPEJQ/hTHuEmgea0pFUa/uXHUgyd
 bgZAgUz6J6G+y4Tncwd8YbE0dwvFFuQ3vtoL6iualciP6F8x+fHMzUoxPr44dHcZLhmV
 jEPlgJpoUCcouJfqCB1eJ/uAWQVtmhNz8UhwYvv99fre4133Zi1XNShdT6h43MdYugtP
 pLtY2mSQEtT6owlRd1A8Zq4TYCRYGy/s9+VQ8PTwh+x88GqXz0xalADFRArDfVQSYQEC
 YfZ8HJffmXwZjyhTLoX1HG4k/rfZEc1397EqYS8Ii4g+AEvrPh+1A4xeEHLmfp7ueIhF
 WMFg==
X-Gm-Message-State: AOJu0YxQSrQhSd1vc4Ihnjay1cZKIsXd+5AB3Ct9eVKLRbY61v0uQf21
 7Z68LdUWBbjcM5+ZsZvxU3pdNswSGVFF/nPS5fU=
X-Google-Smtp-Source: AGHT+IF38zyjZoZ/GZIZpj8GT15TLM+OVQy75GQfi4bOHoDJiYrP0D5dX5oWKfEfl4lggvkbUoHrIg==
X-Received: by 2002:a5d:43c3:0:b0:32d:9fc9:d14a with SMTP id
 v3-20020a5d43c3000000b0032d9fc9d14amr1400118wrr.12.1697806504905; 
 Fri, 20 Oct 2023 05:55:04 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d50c4000000b0032da319a27asm1665601wrt.9.2023.10.20.05.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 05:55:04 -0700 (PDT)
Message-ID: <d6900cfb-328b-bd96-e323-bda62e8557ac@linaro.org>
Date: Fri, 20 Oct 2023 14:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL v2 00/46] Misc HW/UI patches for 2023-10-19
Content-Language: en-US
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
References: <20231020125201.49361-1-philmd@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020125201.49361-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=unavailable autolearn_force=no
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

Grr, I forgot to Cc qemu-devel@ ...

On 20/10/23 14:51, Philippe Mathieu-Daudé wrote:
> The following changes since commit 0d239e513e0117e66fa739fb71a43b9383a108ff:
> 
>    Merge tag 'pull-lu-20231018' of https://gitlab.com/rth7680/qemu into staging (2023-10-19 10:20:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20231020
> 
> for you to fetch changes up to 9f1b100236223d073915b8eedac3089ec64f8a6e:
> 
>    ui/input: Constify QemuInputHandler structure (2023-10-20 14:46:07 +0200)
> 
> Since v1:
> - Dropped PC_SPEAKER patch
> - Added MAINTAINERS::util/qemu-timer-common.c patch
> 
> ----------------------------------------------------------------
> Misc hardware patch queue
> 
> - MAINTAINERS updates (Zoltan, Thomas)
> - Fix cutils::get_relocated_path on Windows host (Akihiko)
> - Housekeeping in Memory APIs (Marc-André)
> - SDHCI fix for SDMA transfer (Lu, Jianxian)
> - Various QOM/QDev/SysBus cleanups (Philippe)
> - Constify QemuInputHandler structure (Philippe)
> 
> ----------------------------------------------------------------
> 
> Akihiko Odaki (1):
>    cutils: Fix get_relocated_path on Windows
> 
> BALATON Zoltan (1):
>    MAINTAINERS: Split vt82c686 out of fuloong2e
> 
> Lu Gao (1):
>    hw/sd/sdhci: Block Size Register bits [14:12] is lost
> 
> Luc Michel (1):
>    mailmap: update email addresses for Luc Michel
> 
> Marc-André Lureau (2):
>    memory: drop needless argument
>    memory: follow Error API guidelines
> 
> Philippe Mathieu-Daudé (36):
>    buildsys: Only display Objective-C information when Objective-C is
>      used
>    hw/mips/malta: Use sdram_type enum from 'hw/i2c/smbus_eeprom.h'
>    hw/mips: Merge 'hw/mips/cpudevs.h' with 'target/mips/cpu.h'
>    hw/misc/mips_itu: Declare itc_reconfigure() in 'hw/misc/mips_itu.h'
>    hw/misc/mips_itu: Make MIPSITUState target agnostic
>    hw/pci-host/sh_pcic: Declare CPU QOM types using DEFINE_TYPES() macro
>    hw/pci-host/sh_pcic: Correct PCI host / devfn#0 function names
>    hw/pci-host/sh_pcic: Replace magic value by proper definition
>    hw/sparc64/ebus: Access memory regions via pci_address_space_io()
>    hw/acpi/pcihp: Clean up global variable shadowing in acpi_pcihp_init()
>    hw/pci: Clean up global variable shadowing of address_space_io
>      variable
>    hw/s390x: Clean up global variable shadowing in
>      quiesce_powerdown_req()
>    hw/intc/apic: Use ERRP_GUARD() in apic_common_realize()
>    hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before accessing it
>    hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
>      pnv_xscom_init()
>    hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
>    hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
>    hw/ppc/pnv: Do not use SysBus API to map local MMIO region
>    hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
>    hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region
>    hw/i386/amd_iommu: Do not use SysBus API to map local MMIO region
>    hw/i386/intel_iommu: Do not use SysBus API to map local MMIO region
>    hw/misc/allwinner-dramc: Move sysbus_mmio_map call from init ->
>      realize
>    hw/misc/allwinner-dramc: Do not use SysBus API to map local MMIO
>      region
>    hw/pci-host/bonito: Do not use SysBus API to map local MMIO region
>    hw/acpi: Realize ACPI_GED sysbus device before accessing it
>    hw/arm/virt: Realize ARM_GICV2M sysbus device before accessing it
>    hw/isa: Realize ISA bridge device before accessing it
>    hw/s390x/css-bridge: Realize sysbus device before accessing it
>    hw/virtio/virtio-pmem: Replace impossible check by assertion
>    hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE() macros
>    hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
>    hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
>    hw/dma: Declare link using static DEFINE_PROP_LINK() macro
>    hw/net: Declare link using static DEFINE_PROP_LINK() macro
>    ui/input: Constify QemuInputHandler structure
> 
> Thomas Huth (4):
>    MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine section
>    MAINTAINERS: Add include/hw/intc/loongson_liointc.h to the Loongson-3
>      virt section
>    MAINTAINERS: Add include/hw/openrisc/ to the OpenRISC section
>    MAINTAINERS: Extend entry to cover util/qemu-timer-common.c, too
> 
>   MAINTAINERS                         | 18 +++++++--
>   meson.build                         |  6 ++-
>   include/hw/acpi/pcihp.h             |  2 +-
>   include/hw/core/cpu.h               |  4 +-
>   include/hw/core/sysemu-cpu-ops.h    |  2 +-
>   include/hw/mips/cpudevs.h           | 14 -------
>   include/hw/misc/mips_itu.h          |  4 +-
>   include/hw/pci/pci.h                |  9 ++---
>   include/hw/ppc/pnv_xscom.h          |  2 +-
>   include/hw/virtio/virtio-input.h    |  2 +-
>   include/sysemu/memory_mapping.h     |  2 +-
>   include/ui/input.h                  |  2 +-
>   target/i386/cpu.h                   |  2 +-
>   target/mips/cpu.h                   |  7 ++--
>   chardev/msmouse.c                   |  2 +-
>   chardev/wctablet.c                  |  2 +-
>   hw/acpi/pcihp.c                     |  5 +--
>   hw/arm/virt.c                       |  5 +--
>   hw/block/vhost-user-blk.c           |  4 +-
>   hw/char/escc.c                      |  2 +-
>   hw/core/cpu-sysemu.c                |  6 +--
>   hw/display/virtio-gpu.c             |  2 +-
>   hw/display/xenfb.c                  |  6 +--
>   hw/dma/xilinx_axidma.c              |  6 +--
>   hw/dma/xlnx-zdma.c                  |  7 +---
>   hw/dma/xlnx_csu_dma.c               | 13 ++-----
>   hw/i386/amd_iommu.c                 |  5 +--
>   hw/i386/intel_iommu.c               |  5 +--
>   hw/i386/microvm.c                   |  2 +-
>   hw/input/adb-kbd.c                  |  2 +-
>   hw/input/hid.c                      |  6 +--
>   hw/input/ps2.c                      |  4 +-
>   hw/input/virtio-input-hid.c         |  8 ++--
>   hw/intc/apic_common.c               |  4 ++
>   hw/intc/spapr_xive.c                | 12 +++---
>   hw/isa/isa-bus.c                    | 11 +++++-
>   hw/loongarch/virt.c                 |  2 +-
>   hw/mips/cps.c                       |  1 -
>   hw/mips/fuloong2e.c                 |  1 -
>   hw/mips/jazz.c                      |  1 -
>   hw/mips/loongson3_virt.c            |  1 -
>   hw/mips/malta.c                     |  3 +-
>   hw/mips/mips_int.c                  |  1 -
>   hw/mips/mipssim.c                   |  1 -
>   hw/misc/allwinner-r40-dramc.c       | 20 +++++-----
>   hw/misc/mips_itu.c                  |  4 +-
>   hw/net/cadence_gem.c                |  7 +---
>   hw/pci-host/bonito.c                | 30 +++++++--------
>   hw/pci-host/sh_pci.c                | 57 +++++++++++++----------------
>   hw/pci/pci.c                        | 25 +++++--------
>   hw/ppc/pnv.c                        | 26 +++----------
>   hw/ppc/pnv_xscom.c                  |  5 +--
>   hw/ppc/spapr_vio.c                  |  3 +-
>   hw/s390x/css-bridge.c               |  7 ++--
>   hw/s390x/sclpquiesce.c              |  8 ++--
>   hw/scsi/virtio-scsi.c               |  2 +-
>   hw/sd/sdhci.c                       | 15 ++++++--
>   hw/sparc64/sun4u.c                  |  8 ++--
>   hw/virtio/virtio-pmem.c             |  5 +--
>   system/memory_mapping.c             | 17 ++++-----
>   target/i386/arch_memory_mapping.c   |  6 ++-
>   target/mips/sysemu/cp0_timer.c      |  1 -
>   target/mips/tcg/sysemu/cp0_helper.c |  1 +
>   target/mips/tcg/sysemu/tlb_helper.c |  1 -
>   ui/input-legacy.c                   |  2 +-
>   ui/input.c                          |  4 +-
>   ui/vdagent.c                        |  2 +-
>   util/cutils.c                       | 18 +++++----
>   .mailmap                            |  3 ++
>   69 files changed, 222 insertions(+), 261 deletions(-)
>   delete mode 100644 include/hw/mips/cpudevs.h
> 


