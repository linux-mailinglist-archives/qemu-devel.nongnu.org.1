Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350D9515AB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Aug 2024 09:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8ay-0005tl-Vw; Wed, 14 Aug 2024 03:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1se8aw-0005rv-Na
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1se8ar-00047m-J8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723621131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oc3aTjU8HWXyxmTz6UJCCM/6umGObf5/rb0G6OpUxpc=;
 b=YkVQG6EH4q8Eq+kRSJftXxmsgPK+AmlElztPR/qg+Ob40d56CZ9khwk+w2CiuX5noX+UsP
 DV79Kbd/CssUbXLras2AB1RywOdJtz2/+o+MyUe+M5mtsYbGr4gPS64/3ZkLG1fRoAblSC
 USTdO+UrHPQMgsZN150Al70vqJNkzUI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-xWjCGcaqNVC8yYl3dtOeIA-1; Wed, 14 Aug 2024 03:38:49 -0400
X-MC-Unique: xWjCGcaqNVC8yYl3dtOeIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7a8281dba5so529615966b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 00:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723621128; x=1724225928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc3aTjU8HWXyxmTz6UJCCM/6umGObf5/rb0G6OpUxpc=;
 b=FafIF8f7yIJRRnty8cgZy/vxaQBlPqmtUJDhUG3eGj4JPrf/Pr1+E+0vnGjfYlkjR8
 B1SxpggfRXxhGkVYUBEztl91c+hSksOqZLa9nHU7PDJVyWg3OrDoS0rCsANAlXGfjhTj
 xPa8RXRXcNVnCTShyRvqWNql9fIbSC8s4+dEMwmqd1sbAFXg7Hlc8BMcDsAoeK/odAWE
 IijTe0rbPJbrabnoZBk5ZFlA3k5Rtayd0gw9vLSL9ESyjHOh9TtHS7i8emRFqNFTo/pY
 JQ/biZwFL+OLxC+DqsfF3Xf/HyEt/eM4uO1XaoXrcx+6lHNcYeV/lRNCR48dBDahSvBY
 +JJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPUcXKl7YuOx9FWg4XU6TkfpCgPcEMEkv9PwNpgP65eGXglf/yIDuVC94egw+iHbRaNCEg3yBIWB+R@nongnu.org
X-Gm-Message-State: AOJu0YwzZSOn0kQE4pm7KWDyR2Q4lqLzdHp6gyml14L3Yajv3jaD3lMp
 v7AqDB9uTW9k91OG0a3/PXLRqyrWpAMnwYUn84b8W4llIjQ7MtE3wvER5K46KdtA2Ij9WbvaAqr
 CF9e3AeHQLKKvqZ1M/HMaxdaxgIycUXnmfx2RX7YvtMj9gKq8zt9J
X-Received: by 2002:a17:907:3f25:b0:a7d:4dc4:3d8 with SMTP id
 a640c23a62f3a-a836701bb07mr115513666b.54.1723621128524; 
 Wed, 14 Aug 2024 00:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm5GukSx2TiVJhZWRQjxQ16ZMf8mxEx8QfTVbYYaWnyu9LQfARUK6lvCulUuhRsLEWBneSNg==
X-Received: by 2002:a17:907:3f25:b0:a7d:4dc4:3d8 with SMTP id
 a640c23a62f3a-a836701bb07mr115510566b.54.1723621127668; 
 Wed, 14 Aug 2024 00:38:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fa13desm137152066b.48.2024.08.14.00.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 00:38:47 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:38:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 01/10] acpi/generic_event_device: add an APEI error
 device
Message-ID: <20240814033158-mutt-send-email-mst@kernel.org>
References: <cover.1723591201.git.mchehab+huawei@kernel.org>
 <0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be6db8d06b3abab551f24dcc645d46d72d3f668.1723591201.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 14, 2024 at 01:23:23AM +0200, Mauro Carvalho Chehab wrote:
> Adds a generic error device to handle generic hardware error
> events as specified at ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the guest via ACPI APEI Generic Hardware Error Source (GHES).
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/aml-build.c                    | 10 ++++++++++
>  hw/acpi/generic_event_device.c         |  8 ++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/aml-build.h            |  2 ++
>  include/hw/acpi/generic_event_device.h |  1 +
>  5 files changed, 22 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe3d..cb167523859f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2520,3 +2520,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>  
>      return var;
>  }
> +
> +/* ACPI 5.0: 18.3.2.6.2 Event Notification For Generic Error Sources */



I could not find Event Notification For Generic Error Sources in ACPI
5.0.



Instead, I see
18.3.2.6.2 SCI Notification For Generic Error Sources

What did I miss?


> +Aml *aml_error_device(void)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));




> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +

comment on why is this here?

> +    return dev;
> +}
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..1673e9695be3 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT
>  };
>  
>  /*
> @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_ERROR_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> +                                      aml_int(0x80)));
> +                break;
>              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name("\\_SB.NVDR"),
> @@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_GENERIC_ERROR) {
> +        sel = ACPI_GED_ERROR_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50aa..8294f8f0ccca 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_GENERIC_ERROR = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb33..44d1a6af0c69 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -252,6 +252,7 @@ struct CrsRangeSet {
>  /* Consumer/Producer */
>  #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
>  
> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
>  /**
>   * init_aml_allocator:
>   *
> @@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
>               uint8_t channel);
>  Aml *aml_sleep(uint64_t msec);
>  Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
> +Aml *aml_error_device(void);
>  
>  /* Block AML object primitives */
>  Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b56d..9ace8fe70328 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -98,6 +98,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> -- 
> 2.46.0


