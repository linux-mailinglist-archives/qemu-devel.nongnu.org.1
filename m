Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A87565AB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOm5-0001eQ-OB; Mon, 17 Jul 2023 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOm1-0001df-Co
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOlr-0005L4-RY
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689602413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NCHkA3hYOAqoAx3UvlKxfIjR02hnQlaQNfRDJaJ0MQ=;
 b=GMTqv/sbosKiH4EQ0eGnhRQufUMaQaexihS1n9toKkiN8gVONMbPAMuEa19TXw09q7wAa7
 Sh/YUUz+MT3T1yZk/IoTB0ftxZDvc8l9ZKC1gUS6488z7zTqPxvvuiDHDnsKTpWcF5D6li
 DDNTuDEEiwILLGYvIfn2/sumPUZMX3A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-5iWdm6WaNa-hC6Ft6nOR1w-1; Mon, 17 Jul 2023 10:00:11 -0400
X-MC-Unique: 5iWdm6WaNa-hC6Ft6nOR1w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso41079911fa.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689602409; x=1692194409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NCHkA3hYOAqoAx3UvlKxfIjR02hnQlaQNfRDJaJ0MQ=;
 b=T9fxrCTUzRTMk27D1NP9p18/NntrbFTT9Tqb9Q0fy0kC408CfQVeIt815Z4UjC5I7M
 rTu1maohxP6FUOe+L0Yr4xZoJxFPCNz7bR0/6XyizJGBDSzLY4DbX5z11K0YM1lCbTMR
 rrQVAKdmu5prts9FsHEow9eyYFM+vFHnygRCEfs1VoNxPJXRKxdoN+wmbIdtN0kIpivY
 jHTt64pJ/koWHK1DXQnDyh3jvEJRHPAlXajIbctAZnICN7SXOUdon7LcYvC500T5QXwF
 Q8v8rA1edPqimYbNVTMhmygFigxpPwux1kAHl0eFzdvoN2BMj4cxoGRKxB8qkq0LXMCm
 Sk1w==
X-Gm-Message-State: ABy/qLYd45zn65ua4CHaLU/tev9yau/A/DixWJClq6+a3Kn1wZ3hm7ty
 ElVnApYRD542eUIQpxy03guAGsh1XPfvFPeDnLbsQLCrcM1GwIWcgolJhrtw7gEpZpRNVACaBfs
 hcd1fo6o/pWwk/fg=
X-Received: by 2002:a2e:9d93:0:b0:2b6:eb8c:af06 with SMTP id
 c19-20020a2e9d93000000b002b6eb8caf06mr8510904ljj.8.1689602409120; 
 Mon, 17 Jul 2023 07:00:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG760SUY3BBn9pD6zzGAznOYKnj1PjDqSF5FCgb5nKHp3YZbfeV9WhZ5A3kMPLvLqCz+fOdZQ==
X-Received: by 2002:a2e:9d93:0:b0:2b6:eb8c:af06 with SMTP id
 c19-20020a2e9d93000000b002b6eb8caf06mr8510891ljj.8.1689602408774; 
 Mon, 17 Jul 2023 07:00:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 mj7-20020a170906af8700b0098963eb0c3dsm9214666ejb.26.2023.07.17.07.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 07:00:08 -0700 (PDT)
Date: Mon, 17 Jul 2023 16:00:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: Re: [PATCH v2 07/11] hw/arm/virt: add plug handler for TPM on SysBus
Message-ID: <20230717160007.67bb67df@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230714070931.23476-8-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-8-j@getutm.app>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 14 Jul 2023 00:09:23 -0700
Joelle van Dyne <j@getutm.app> wrote:

> TPM needs to know its own base address in order to generate its DSDT
> device entry.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  hw/arm/virt.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc2663..432148ef47 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2732,6 +2732,37 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                           dev, &error_abort);
>  }
>  
> +#ifdef CONFIG_TPM

ifdefs are not really welcome, usually we use stubs instead
see stubs/virtio-md-pci.c or hw/display/acpi-vga-stub.c as an example.

> +static void virt_tpm_plug(VirtMachineState *vms, TPMIf *tpmif)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
> +    MemoryRegion *sbdev_mr;
> +    hwaddr tpm_base;
> +    uint64_t tpm_size;
> +
> +    if (!sbdev || !object_dynamic_cast(OBJECT(sbdev), TYPE_SYS_BUS_DEVICE)) {
it seems object_dynamic_cast() can deal with NULL object,  perhaps drop !sbdev part

> +        return;
> +    }
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    assert(tpm_base != -1);
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +    tpm_size = memory_region_size(sbdev_mr);
> +

> +    if (object_property_find(OBJECT(sbdev), "baseaddr")) {
> +        object_property_set_uint(OBJECT(sbdev), "baseaddr", tpm_base, NULL);
> +    }
> +    if (object_property_find(OBJECT(sbdev), "size")) {
> +        object_property_set_uint(OBJECT(sbdev), "size", tpm_size, NULL);
> +    }
why both properties wrapped into conditions?
Also can addr/size be wrong and cause property setter fail?
(if yes then you'd need to s/, NULL, &error_abort/)


> +}
> +#endif
> +
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> @@ -2803,6 +2834,12 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          vms->virtio_iommu_bdf = pci_get_bdf(pdev);
>          create_virtio_iommu_dt_bindings(vms);
>      }
> +
> +#ifdef CONFIG_TPM
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_TPM_IF)) {
> +        virt_tpm_plug(vms, TPM_IF(dev));
> +    }
> +#endif
>  }
>  
>  static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,


