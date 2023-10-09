Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4EC7BE645
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpt1z-0004OM-Ne; Mon, 09 Oct 2023 12:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt1w-0004NW-7F
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt1u-0004pr-Uv
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696868570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMdWteBtwuomK48Cg0YckEzg6lLeJTeFzxkgqdswAOY=;
 b=NlhU9D+owte66wZF+jTvOJ7nHZdeMrdM3C033eDNb+ni1m+i3pDBIoGejDCzi6gCk0Ae/J
 vFmnwmMEyJsof7Rd3dnoxut2uj7ZtXAtudqiou03PiBTw8KEo3EOHHDW1WrllzxiHZNrGf
 ofzP2V/7dr0seKg3c/Xf0S9X0jZyY3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-5GrtQu9AOUKBgS4WMQ3yWw-1; Mon, 09 Oct 2023 12:22:27 -0400
X-MC-Unique: 5GrtQu9AOUKBgS4WMQ3yWw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32006e08483so3074954f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696868546; x=1697473346;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMdWteBtwuomK48Cg0YckEzg6lLeJTeFzxkgqdswAOY=;
 b=FSHKjh2IcMMb8dLHl/nfrBh8Pe/PRB2vonLOe3+Tz4DgoZhtEW9Q4vtyoxQk06EKLd
 XP0opdPspVqDlOFgEPsZ3urK2J4VUYMAKl2WJ3VatpvARZoMU1lWe0Z54P34rAOxWwlJ
 84ntwbGK0jF+1a/XCpIwVM/UdJktDL3qKDvg2fHRovRCOERYT6ZvLPTicleb7cN1/tha
 kgSXOozTVaxRIVZdM9NShQhlLfms228hDr1yA5O0fjJ1G8hsc/t1eOoh7M6i3y/dkCEZ
 C94Xx2+ZEjNoE26bxrXa+6MoKXYpyJrExzEZX7044rDaj95L22Mf7hlB9SXU3ZiMCoSU
 2jaQ==
X-Gm-Message-State: AOJu0YxnwhYxcUOvopIM1HExF0qFZH2J1w9/9dSdUfxEtdCj4cL0IfEY
 U9qzsYRO81k5LcvG48rsprA4PRLZb98L4iPXcsFPzZwv1m5pe7mOLzmFVNj0PNoPVzC/vv5Etyy
 LjoY0LyEKxsoh40w=
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr14218947wru.28.1696868545804; 
 Mon, 09 Oct 2023 09:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzNYBCGGD+1A97M1i8ZRZd8ufUjNMl3KqVaMgdi3N2ryiz9Gn0Ic4EyYbDMFefmQ6kEHweqw==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr14218917wru.28.1696868545455; 
 Mon, 09 Oct 2023 09:22:25 -0700 (PDT)
Received: from redhat.com ([2.55.57.209]) by smtp.gmail.com with ESMTPSA id
 v4-20020aa7d9c4000000b0052284228e3bsm6297066eds.8.2023.10.09.09.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:22:24 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:22:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 4/6] hw/acpi/pcihp: Clean up global variable shadowing in
 acpi_pcihp_init()
Message-ID: <20231009122157-mutt-send-email-mst@kernel.org>
References: <20231009094747.54240-1-philmd@linaro.org>
 <20231009094747.54240-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009094747.54240-5-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 09, 2023 at 11:47:44AM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   hw/acpi/pcihp.c:499:36: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>                        MemoryRegion *address_space_io,
>                                      ^
>   include/exec/address-spaces.h:35:21: note: previous declaration is here
>   extern AddressSpace address_space_io;
>                       ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/acpi/pcihp.h | 2 +-
>  hw/acpi/pcihp.c         | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ef59810c17..ac21a95913 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -56,7 +56,7 @@ typedef struct AcpiPciHpState {
>  } AcpiPciHpState;
>  
>  void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
> -                     MemoryRegion *address_space_io, uint16_t io_base);
> +                     MemoryRegion *io, uint16_t io_base);
>  
>  bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
>  void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index cdd6f775a1..4f75c873e2 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -496,8 +496,7 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
>  };
>  
>  void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
> -                     MemoryRegion *address_space_io,
> -                     uint16_t io_base)
> +                     MemoryRegion *io, uint16_t io_base)
>  {
>      s->io_len = ACPI_PCIHP_SIZE;
>      s->io_base = io_base;
> @@ -506,7 +505,7 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
>  
>      memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
>                            "acpi-pci-hotplug", s->io_len);
> -    memory_region_add_subregion(address_space_io, s->io_base, &s->io);
> +    memory_region_add_subregion(io, s->io_base, &s->io);
>  
>      object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
>                                     OBJ_PROP_FLAG_READ);
> -- 
> 2.41.0


