Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F173824E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBw13-0002V8-2Q; Wed, 21 Jun 2023 07:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw11-0002Ug-CY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw0z-0001bS-Pk
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687346925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xathR/t2Ikw02K4dyoTcVKom9t1EZ5V8unf9o6ytpco=;
 b=PBuoc1xRlN+ri+Wla2X0AAXDlKtq8F3ABnkeGwZU2Cyu1ZyI+xvvRinGwZSe0V1WCb/uqY
 xtK+BCFYPK6dbpV0HSoxVC3C03eW6DVPRcghxYX7qynOuj5TS994rX4mN9r9M+2VFGGXGc
 FlcIEUvcsfLSPrkseSxaliWJA8SwQtY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BDbfqZ-ENxqSu07OmI1vdg-1; Wed, 21 Jun 2023 07:28:43 -0400
X-MC-Unique: BDbfqZ-ENxqSu07OmI1vdg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so3764315a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687346923; x=1689938923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xathR/t2Ikw02K4dyoTcVKom9t1EZ5V8unf9o6ytpco=;
 b=NxcD7SmiztJI55JFb9K1S/wA32pXj8j9mT0y9yMoc4jsD2wmddDu7C60t/sgOSPHpJ
 150ljWdO5umOp5mdK41XmRW27A7/+lX4h0zapBZYWrTrBgTxKJcndqK3ZlFv37e1PC0y
 ++2D3X9T12eoXY+cAQ5og6KgRUPXoivEgR3qKOKM2g0MzRp1bKKDdJd+nVa8LIMc4okX
 AgESHcjfwuCsX/AJBW8GfbEdlgdt7p0Q9RIRJlx4nZGhe49xkBcXq5HS8J+krfwjP7ja
 zEoPhcjVv1JHYcwFXSeCM3Wb1imraovQ5qssYVK3ih/XHPZtw6h9cQgSs2E4+KmsOFsm
 tEqw==
X-Gm-Message-State: AC+VfDx6Zfs3W/NiC0lYlu6gOH9b6qog+1OPSokEdO01jvWv+Du/J4wG
 EH0HWrELauvCiV4uxnNdo658ysmcUzicFJFifTYcAOVlk+t3FLrRRnatEM7XyGB++vnKHz6VXN2
 MQcVRpZqPf8+0nMc=
X-Received: by 2002:a50:ef19:0:b0:51b:ac91:9f58 with SMTP id
 m25-20020a50ef19000000b0051bac919f58mr4825660eds.4.1687346922882; 
 Wed, 21 Jun 2023 04:28:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mRtpoB4D3RWovlFYrpuLTOb6GkV4MGrWkC6CTQxYMhVISxScpArmHEXsCRJEzfVj31K8deQ==
X-Received: by 2002:a50:ef19:0:b0:51b:ac91:9f58 with SMTP id
 m25-20020a50ef19000000b0051bac919f58mr4825646eds.4.1687346922578; 
 Wed, 21 Jun 2023 04:28:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d8-20020a056402078800b005187a42b44fsm2476093edy.58.2023.06.21.04.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 04:28:42 -0700 (PDT)
Date: Wed, 21 Jun 2023 13:28:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 03/23] q35/acpi/xen: Provide ACPI PCI hotplug
 interface for Xen on Q35
Message-ID: <20230621132840.7cf3e05f@imammedo.users.ipa.redhat.com>
In-Reply-To: <5e066d5cfb355656a8704f4d07ba697507613568.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <5e066d5cfb355656a8704f4d07ba697507613568.1687278381.git.jupham125@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 20 Jun 2023 13:24:37 -0400
Joel Upham <jupham125@gmail.com> wrote:

> This patch allows to use ACPI PCI hotplug functionality for Xen on Q35.
> All added code depends on xen_enabled(), so no functionality change for
> non-Xen usage.
> 
> We need to call the acpi_set_pci_info function from ich9_pm_init as well,
> so it was made globally visible again (as it was before).

this patch is also likely obsolete 

> 
> Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> Signed-off-by: Joel Upham <jupham125@gmail.com>
> ---
>  hw/acpi/ich9.c          | 10 ++++++++++
>  hw/acpi/pcihp.c         |  2 +-
>  include/hw/acpi/pcihp.h |  2 ++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 25e2c7243e..1c236be1c7 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -39,6 +39,8 @@
>  #include "hw/southbridge/ich9.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/xen/xen.h"
> +#include "sysemu/xen.h"
>  
>  //#define DEBUG
>  
> @@ -67,6 +69,10 @@ static void ich9_gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
>      ICH9LPCPMRegs *pm = opaque;
>      acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
>      acpi_update_sci(&pm->acpi_regs, pm->irq);
> +
> +    if (xen_enabled()) {
> +        acpi_pcihp_reset(&pm->acpi_pci_hotplug);
> +    }
>  }
>  
>  static const MemoryRegionOps ich9_gpe_ops = {
> @@ -332,6 +338,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>      pm->powerdown_notifier.notify = pm_powerdown_req;
>      qemu_register_powerdown_notifier(&pm->powerdown_notifier);
>  
> +    if (xen_enabled()) {
> +            acpi_set_pci_info(true);
> +    }
> +
>      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
>  
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index f4e39d7a9c..5b065d670c 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -99,7 +99,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>      return info;
>  }
>  
> -static void acpi_set_pci_info(bool has_bridge_hotplug)
> +void acpi_set_pci_info(bool has_bridge_hotplug)
>  {
>      static bool bsel_is_set;
>      Object *host = acpi_get_i386_pci_host();
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ef59810c17..d35a517c9e 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -72,6 +72,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
>  
> +void acpi_set_pci_info(bool has_bridge_hotplug);
> +
>  void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus);
>  
>  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;


