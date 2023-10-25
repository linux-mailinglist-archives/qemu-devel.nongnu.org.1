Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491A7D7522
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvk6t-0005JB-BX; Wed, 25 Oct 2023 16:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvk6j-0005II-UY
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:04:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvk6f-0002Bk-9R
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:04:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so568045ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698264234; x=1698869034; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UL0pnqYK+dW5BCakN9SEKEtwdWTiIYLvWf2MI75e6dE=;
 b=VQt37NM3Cgz+DNpmiT2R+n69oeQBmPL0OpbRFSmnk8r3hbB122JP1lLfWfUSzsdhjV
 9C1va5GQGuOiq4JZOLj/eMkHdyiZtjnXssp0H9xKz5n84mqH15uPflLu7NV++z5dgLHo
 Uk6G0TeLb8KwtPbCLaCz6OSvTQOqnOvbnojIlqx/IVk4iv6gb+Yr8Kgg/dJN+EPyI/gK
 nfvGKOVoJuLsgqAH2GewLSr5Hvwy6GxcRS8gS35ueY6I/acQT45E2AP0xXDXTzThiZb6
 bGZ6vL7+NkH/Am+zoqj+SyMAQqcLXjf5omQC7x5a6BxDctS129v49jcaC640lDLPSx6c
 SFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698264234; x=1698869034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UL0pnqYK+dW5BCakN9SEKEtwdWTiIYLvWf2MI75e6dE=;
 b=qmLkW4E1BmC7byzbNBxosDC+vM8ZHZ99WP7UIB6EoO7jufOOofn313cPxBrwsGW223
 8M5gFrKx/1DLMVZujpnfjIztMqj7XpgfO+XoLjfiePE16VLoUHvi6zPLTAtqtafX7nKA
 FEU6g/xEyV5FvENFf2XOor6DI9RSDZhvT0t45V3lqQsif3DWHInyiWcPJgfYCQQ59GBJ
 qtkC91E3ko/RqL/U3KttyX85lxJUq7s7x+2d1a81GIAid29b+r3ZzQtvsvd3IGyQsSYe
 c/5LIOcqPONGozb8EDRRylyD1xWPXrNV2DsxC9zEQJ6/KEg8gHfpyesxC+NtTMVe6wWM
 IcpQ==
X-Gm-Message-State: AOJu0YxVowut2OmvIt+0eZTsEsCVDklZwsQhOkR+i0v2Vuhc/KqbwlPS
 EKY8uBfgLb1rxd7CaRkIjUvYoA==
X-Google-Smtp-Source: AGHT+IEjT+nLwnwNSmc8WuV2JbtHg3vadUVcsarf3q9B/Jlx9z6Qnz6waTdyIVyRxjTPMFoz0hdLIQ==
X-Received: by 2002:a17:903:191:b0:1c5:c546:febf with SMTP id
 z17-20020a170903019100b001c5c546febfmr17874168plg.35.1698264233958; 
 Wed, 25 Oct 2023 13:03:53 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78]) by smtp.gmail.com with ESMTPSA id
 v8-20020a170902b7c800b001c41e1e9ca7sm9476694plz.215.2023.10.25.13.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 13:03:53 -0700 (PDT)
Date: Thu, 26 Oct 2023 01:33:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v3 02/12] hw/arm/virt-acpi-build.c: Migrate virtio
 creation to common location
Message-ID: <ZTl0ngYIjtWfH360@sunil-laptop>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-3-sunilvl@ventanamicro.com>
 <20231023-4a2aa642f94372aa617fd8e1@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-4a2aa642f94372aa617fd8e1@orel>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 23, 2023 at 02:28:22PM +0200, Andrew Jones wrote:
> On Thu, Oct 19, 2023 at 06:56:38PM +0530, Sunil V L wrote:
> > RISC-V also needs to create the virtio in DSDT in the same way as ARM. So,
> > instead of duplicating the code, move this function to the device specific
> > file which is common across architectures.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/arm/virt-acpi-build.c        | 29 ++---------------------------
> >  hw/virtio/meson.build           |  1 +
> >  hw/virtio/virtio-acpi.c         | 28 ++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-acpi.h | 11 +++++++++++
> 
> Need SPDX for these new files as well.
> 
> >  4 files changed, 42 insertions(+), 27 deletions(-)
> >  create mode 100644 hw/virtio/virtio-acpi.c
> >  create mode 100644 include/hw/virtio/virtio-acpi.h
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index b8e725d953..69733f6663 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -58,6 +58,7 @@
> >  #include "migration/vmstate.h"
> >  #include "hw/acpi/ghes.h"
> >  #include "hw/acpi/viot.h"
> > +#include "hw/virtio/virtio-acpi.h"
> >  
> >  #define ARM_SPI_BASE 32
> >  
> > @@ -118,32 +119,6 @@ static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
> >      aml_append(scope, dev);
> >  }
> >  
> > -static void acpi_dsdt_add_virtio(Aml *scope,
> > -                                 const MemMapEntry *virtio_mmio_memmap,
> > -                                 uint32_t mmio_irq, int num)
> > -{
> > -    hwaddr base = virtio_mmio_memmap->base;
> > -    hwaddr size = virtio_mmio_memmap->size;
> > -    int i;
> > -
> > -    for (i = 0; i < num; i++) {
> > -        uint32_t irq = mmio_irq + i;
> > -        Aml *dev = aml_device("VR%02u", i);
> > -        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> > -        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > -
> > -        Aml *crs = aml_resource_template();
> > -        aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> > -        aml_append(crs,
> > -                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> > -                                 AML_EXCLUSIVE, &irq, 1));
> > -        aml_append(dev, aml_name_decl("_CRS", crs));
> > -        aml_append(scope, dev);
> > -        base += size;
> > -    }
> > -}
> > -
> >  static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
> >                                uint32_t irq, VirtMachineState *vms)
> >  {
> > @@ -850,7 +825,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> >      }
> >      fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
> > -    acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > +    virtio_acpi_dsdt_add(scope, &memmap[VIRT_MMIO],
> >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> >      acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
> >      if (vms->acpi_dev) {
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index c0055a7832..9d62097a21 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -79,3 +79,4 @@ system_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
> >  system_ss.add(files('virtio-hmp-cmds.c'))
> >  
> >  specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
> > +system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
> > diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
> > new file mode 100644
> > index 0000000000..977499defd
> > --- /dev/null
> > +++ b/hw/virtio/virtio-acpi.c
> > @@ -0,0 +1,28 @@
> > +#include "hw/virtio/virtio-acpi.h"
> > +#include "hw/acpi/aml-build.h"
> > +
> > +void virtio_acpi_dsdt_add(Aml *scope,
> > +                          const MemMapEntry *virtio_mmio_memmap,
> > +                          uint32_t mmio_irq, int num)
> > +{
> > +    hwaddr base = virtio_mmio_memmap->base;
> > +    hwaddr size = virtio_mmio_memmap->size;
> > +    int i;
> > +
> > +    for (i = 0; i < num; i++) {
> > +        uint32_t irq = mmio_irq + i;
> > +        Aml *dev = aml_device("VR%02u", i);
> > +        aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> > +        aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> > +        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > +
> > +        Aml *crs = aml_resource_template();
> > +        aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> > +        aml_append(crs,
> > +                   aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> > +                                 AML_EXCLUSIVE, &irq, 1));
> > +        aml_append(dev, aml_name_decl("_CRS", crs));
> > +        aml_append(scope, dev);
> > +        base += size;
> > +    }
> > +}
> > diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
> > new file mode 100644
> > index 0000000000..b8687b1b42
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-acpi.h
> > @@ -0,0 +1,11 @@
> > +#ifndef VIRTIO_ACPI_H
> > +#define VIRTIO_ACPI_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "exec/hwaddr.h"
> > +
> > +void virtio_acpi_dsdt_add(Aml *scope, const MemMapEntry *virtio_mmio_memmap,
> > +                          uint32_t mmio_irq, int num);
> > +
> > +#endif
> > +
> > -- 
> > 2.34.1
> >
> 
> Shouldn't we also try to apply this to microvm which has nearly the same
> code?
> 
Okay. Let me add a patch to update microvm code also. Let me send next
revision with your and Daniel's comments addressed.

Thanks!
Sunil
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

