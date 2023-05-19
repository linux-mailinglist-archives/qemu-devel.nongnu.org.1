Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F7709245
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvtg-0001ZR-GQ; Fri, 19 May 2023 04:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzvtd-0001Z9-6s
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzvtb-0008Ov-Ci
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfGM0F2DqFrM2zvwPeiLpuDTBpUpEhdxAZI4NWajA+M=;
 b=ipajp1OJRPAT+AXMvUDKo2QcLl0mWS1klClOQv20n+Oczzp/XIWDyWxi0DZs5OtXbQF+4Q
 3cUH/mmsnEVP2Xh/v2KQSWHUmeV/QgvOyHkpTTywgruIP/wIUQ34LbLEo1YogH8a2iO6eo
 m/z1dKb5ryzPG/0XkH0x67++bwXWpyg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-PeqLCgLiO5ywQLPjgFoOkQ-1; Fri, 19 May 2023 04:55:27 -0400
X-MC-Unique: PeqLCgLiO5ywQLPjgFoOkQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ac7e062911so16128201fa.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486526; x=1687078526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfGM0F2DqFrM2zvwPeiLpuDTBpUpEhdxAZI4NWajA+M=;
 b=O1FLdafKajn6buFnECAGwQKeTzdcJWFeoCJ8B4sO+F+Vp0ipNqF3j5dSHitBcjOvhu
 o07RhJ8OHJbZAED26wXImuylQc5dxU3YgpXis3b742v1pm1oou9GrsHkDsKddQO1OFJe
 UMFwgRwI5+3TOVq8S5Y0zQldLnrxJ3+avGD3zMog6xUOj5HByBWDeDiDpXqV+4LL76Yf
 7qq5AygUlJlPSLCCwiSYzov54XH65KBrH26oZ8L5GKBaVMOJCjMhHidUeml2f3O7+bLB
 6BFhAiK3Xi/ht8pliSugk5SlyZHWuXaG2AZbYVc/c993m8mEF6Gkq0rcKdP73ealabYQ
 CVZQ==
X-Gm-Message-State: AC+VfDzW4f6fopaI9fXDfuEe3duSDuiWLrp7a1k5S8u2hUqESJN1fu+b
 ImRMmjRf85NNXOPvVPl8GZZJVCc3ajvUt4n8vQwZLnKP1nKnNqig6F4SARM7DN+2NpCg391PtHq
 6OwkbBXSxEEQPw+c=
X-Received: by 2002:a2e:7a15:0:b0:2a8:ac95:be75 with SMTP id
 v21-20020a2e7a15000000b002a8ac95be75mr445395ljc.42.1684486526175; 
 Fri, 19 May 2023 01:55:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wCC9XiDiAtvWoYkLTRr2uhNt+/1ay9GyN1AKSCOtK0nqCXgZG40E7xmdd6tj3cbqXOX5D/Q==
X-Received: by 2002:a2e:7a15:0:b0:2a8:ac95:be75 with SMTP id
 v21-20020a2e7a15000000b002a8ac95be75mr445387ljc.42.1684486525806; 
 Fri, 19 May 2023 01:55:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a2e6810000000b002ac88e29049sm717856lja.43.2023.05.19.01.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:55:25 -0700 (PDT)
Date: Fri, 19 May 2023 04:55:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] hw/i386/pc: Create RTC controllers in south bridges
Message-ID: <20230519045450-mutt-send-email-mst@kernel.org>
References: <20230519084734.220480-1-shentey@gmail.com>
 <20230519084734.220480-2-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519084734.220480-2-shentey@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 19, 2023 at 10:47:33AM +0200, Bernhard Beschow wrote:
> Just like in the real hardware (and in PIIX4), create the RTC
> controllers in the south bridges.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20221022150508.26830-11-shentey@gmail.com>

Please do not include this Message-Id field when you post.

> ---
>  include/hw/southbridge/ich9.h |  2 ++
>  include/hw/southbridge/piix.h |  3 +++
>  hw/i386/pc.c                  | 12 +++++++++++-
>  hw/i386/pc_piix.c             |  8 ++++++++
>  hw/i386/pc_q35.c              |  2 ++
>  hw/isa/lpc_ich9.c             |  8 ++++++++
>  hw/isa/piix3.c                | 15 +++++++++++++++
>  hw/isa/Kconfig                |  2 ++
>  8 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index 7004eecbf9..fd01649d04 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -6,6 +6,7 @@
>  #include "hw/intc/ioapic.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_device.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "exec/memory.h"
>  #include "qemu/notify.h"
>  #include "qom/object.h"
> @@ -30,6 +31,7 @@ struct ICH9LPCState {
>      */
>      uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
>  
> +    MC146818RtcState rtc;
>      APMState apm;
>      ICH9LPCPMRegs pm;
>      uint32_t sci_level; /* track sci level */
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
> index 0bf48e936d..a840340308 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -13,6 +13,7 @@
>  #define HW_SOUTHBRIDGE_PIIX_H
>  
>  #include "hw/pci/pci_device.h"
> +#include "hw/rtc/mc146818rtc.h"
>  
>  /* PIRQRC[A:D]: PIRQx Route Control Registers */
>  #define PIIX_PIRQCA 0x60
> @@ -51,6 +52,8 @@ struct PIIXState {
>      /* This member isn't used. Just for save/load compatibility */
>      int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
>  
> +    MC146818RtcState rtc;
> +
>      /* Reset Control Register contents */
>      uint8_t rcr;
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d761c8c775..2bf7de694e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1318,7 +1318,17 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>          pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
>          rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
>      }
> -    *rtc_state = ISA_DEVICE(mc146818_rtc_init(isa_bus, 2000, rtc_irq));
> +
> +    if (rtc_irq) {
> +        qdev_connect_gpio_out(DEVICE(*rtc_state), 0, rtc_irq);
> +    } else {
> +        uint32_t irq = object_property_get_uint(OBJECT(*rtc_state),
> +                                                "irq",
> +                                                &error_fatal);
> +        isa_connect_gpio_out(*rtc_state, 0, irq);
> +    }
> +    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(*rtc_state),
> +                              "date");
>  
>  #ifdef CONFIG_XEN_EMU
>      if (xen_mode == XEN_EMULATE) {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 66a849d279..682f51577c 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -32,6 +32,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic.h"
>  #include "hw/pci-host/i440fx.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/southbridge/piix.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/firmware/smbios.h"
> @@ -240,10 +241,17 @@ static void pc_init1(MachineState *machine,
>          piix3->pic = x86ms->gsi;
>          piix3_devfn = piix3->dev.devfn;
>          isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
> +        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> +                                                             "rtc"));
>      } else {
>          pci_bus = NULL;
>          isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
>                                &error_abort);
> +
> +        rtc_state = isa_new(TYPE_MC146818_RTC);
> +        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
> +        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
> +
>          i8257_dma_init(isa_bus, 0);
>          pcms->hpet_enabled = false;
>      }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index f02919d92c..2bbd0d02df 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -242,6 +242,8 @@ static void pc_q35_init(MachineState *machine)
>                        x86_machine_is_smm_enabled(x86ms));
>      pci_realize_and_unref(lpc, host_bus, &error_fatal);
>  
> +    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
> +
>      object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
>                               TYPE_HOTPLUG_HANDLER,
>                               (Object **)&x86ms->acpi_dev,
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 9714b0001e..9c47a2f6c7 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -658,6 +658,8 @@ static void ich9_lpc_initfn(Object *obj)
>      static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
>      static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
>  
> +    object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
> +
>      object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
>                                    &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
> @@ -723,6 +725,12 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>  
>      i8257_dma_init(isa_bus, 0);
>  
> +    /* RTC */
> +    qdev_prop_set_int32(DEVICE(&lpc->rtc), "base_year", 2000);
> +    if (!qdev_realize(DEVICE(&lpc->rtc), BUS(isa_bus), errp)) {
> +        return;
> +    }
> +
>      pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
>      pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
>      pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
> index a9cb39bf21..f9103ea45a 100644
> --- a/hw/isa/piix3.c
> +++ b/hw/isa/piix3.c
> @@ -28,6 +28,7 @@
>  #include "hw/dma/i8257.h"
>  #include "hw/southbridge/piix.h"
>  #include "hw/irq.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/isa/isa.h"
>  #include "hw/xen/xen.h"
>  #include "sysemu/runstate.h"
> @@ -301,6 +302,12 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
>                                          PIIX_RCR_IOPORT, &d->rcr_mem, 1);
>  
>      i8257_dma_init(isa_bus, 0);
> +
> +    /* RTC */
> +    qdev_prop_set_int32(DEVICE(&d->rtc), "base_year", 2000);
> +    if (!qdev_realize(DEVICE(&d->rtc), BUS(isa_bus), errp)) {
> +        return;
> +    }
>  }
>  
>  static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> @@ -324,6 +331,13 @@ static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>      qbus_build_aml(bus, scope);
>  }
>  
> +static void pci_piix3_init(Object *obj)
> +{
> +    PIIX3State *d = PIIX3_PCI_DEVICE(obj);
> +
> +    object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
> +}
> +
>  static void pci_piix3_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -350,6 +364,7 @@ static const TypeInfo piix3_pci_type_info = {
>      .name = TYPE_PIIX3_PCI_DEVICE,
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PIIX3State),
> +    .instance_init = pci_piix3_init,
>      .abstract = true,
>      .class_init = pci_piix3_class_init,
>      .interfaces = (InterfaceInfo[]) {
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 0156a66889..c10cbc5fc1 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -35,6 +35,7 @@ config PIIX3
>      bool
>      select I8257
>      select ISA_BUS
> +    select MC146818RTC
>  
>  config PIIX4
>      bool
> @@ -79,3 +80,4 @@ config LPC_ICH9
>      select I8257
>      select ISA_BUS
>      select ACPI_ICH9
> +    select MC146818RTC
> -- 
> 2.40.1


