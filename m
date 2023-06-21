Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71E73824D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBw0U-0002IF-Eh; Wed, 21 Jun 2023 07:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw0S-0002Hg-Db
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw0Q-0001Lp-Kv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687346882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yphGCBfO/6x46f1sDPNo65ZnoDyIGQUDnYSCxhOhoA=;
 b=gnnS0LOoG2n3qW75/ZJ0gRIEKViY5FXEb56O00AoNuTvUgm48CWGryM9KRvy3LoBIt6oMg
 P0bXJHm8fFM9E/NSRo3gIt9v9W6tStywLeaHIu2BWv6VEsf4cKJxhLU25BXdwyvKN8Uxad
 LgqH11lG8FCX0Cmu1IZt5snmyrgeqms=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-tSM82_WsN1W7ac51S9VgLQ-1; Wed, 21 Jun 2023 07:28:00 -0400
X-MC-Unique: tSM82_WsN1W7ac51S9VgLQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51836731bfbso2954345a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687346878; x=1689938878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yphGCBfO/6x46f1sDPNo65ZnoDyIGQUDnYSCxhOhoA=;
 b=Bz3arWrth2+2l3eGUTyPbFu0m3/+Xg4SGfGXNpC9bxgExW5lTtQciMOGFWvUMo0iob
 Nn/2+ul0qE5hsOIij73Ph+YLXyxzjPJ+pENC0h7rAMaQI6iwmJUzZshesGojlTbR2kLQ
 OrZDtreHbQWeWVauucKLWtYIge3Q+plFrtADx/mUNXkzNajw4dYMdbksW9cqaUMmYqPK
 N1vJIQHib4HG2ndgfjpsHhkQTd4gwhf/hj7BtHr/gfd/ue/u7/xb9zgARXcKcPtADDxB
 on2I6QKxZrnWkYvDQMYeYyz5EBuZRrfduqtyLdNX3Ez9p8Bd9LlnLyR8/TmQXcGqzJxJ
 7POQ==
X-Gm-Message-State: AC+VfDxbW6VDTH3qHcBLzNcG0wgywddeg/0TI4rfO/F/dBJs6lOz0Blr
 zu3Mfa/8FWZ56jgunK5MUgQJ/UzD3NeZw8PVIq5nifkBNkktDfSKHFFzhx5UGe9eicujQ3gCSag
 qjnQgNi2VeS/bj+K872tFnp8=
X-Received: by 2002:a05:6402:78d:b0:51a:3fda:8cfd with SMTP id
 d13-20020a056402078d00b0051a3fda8cfdmr8567914edy.14.1687346878775; 
 Wed, 21 Jun 2023 04:27:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+eskFpCUIUd6omHiOvlooVPiCn4m9xlA28+Wymv2T6pjW63mcX5d3buTQA4yfSq+j9lznFw==
X-Received: by 2002:a05:6402:78d:b0:51a:3fda:8cfd with SMTP id
 d13-20020a056402078d00b0051a3fda8cfdmr8567895edy.14.1687346878458; 
 Wed, 21 Jun 2023 04:27:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 u8-20020aa7d0c8000000b0051a3248cf96sm2476500edo.57.2023.06.21.04.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 04:27:57 -0700 (PDT)
Date: Wed, 21 Jun 2023 13:27:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 02/23] pc/q35: Apply PCI bus BSEL property for Xen
 PCI device hotplug
Message-ID: <20230621132757.2a951cdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
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

On Tue, 20 Jun 2023 13:24:36 -0400
Joel Upham <jupham125@gmail.com> wrote:

> On Q35 we still need to assign BSEL property to bus(es) for PCI device
> add/hotplug to work.
> Extend acpi_set_pci_info() function to support Q35 as well. This patch adds new (trivial)
> function find_q35() which returns root PCIBus object on Q35, in a way
> similar to what find_i440fx does.

I think patch is mostly obsolete, q35 ACPI PCI hotplug is supported in upstream QEMU.

Also see comment below.
 
> 
> Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> Signed-off-by: Joel Upham <jupham125@gmail.com>
> ---
>  hw/acpi/pcihp.c      | 4 +++-
>  hw/pci-host/q35.c    | 9 +++++++++
>  include/hw/i386/pc.h | 3 +++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index cdd6f775a1..f4e39d7a9c 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -40,6 +40,7 @@
>  #include "qapi/error.h"
>  #include "qom/qom-qobject.h"
>  #include "trace.h"
> +#include "sysemu/xen.h"
>  
>  #define ACPI_PCIHP_SIZE 0x0018
>  #define PCI_UP_BASE 0x0000
> @@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>      bool is_bridge = IS_PCI_BRIDGE(br);
>  
>      /* hotplugged bridges can't be described in ACPI ignore them */
> -    if (qbus_is_hotpluggable(BUS(bus))) {

> +    /* Xen requires hotplugging to the root device, even on the Q35 chipset */
pls explain what 'root device' is.
Why can't you use root-ports for hotplug?

> +    if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {
>          if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
>              bus_bsel = g_malloc(sizeof *bus_bsel);
>  
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index fd18920e7f..fe5fc0f47c 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)
>                               qdev_prop_allow_set_link_before_realize, 0);
>  }
>  
> +PCIBus *find_q35(void)
> +{
> +    PCIHostState *s = OBJECT_CHECK(PCIHostState,
> +                                   object_resolve_path("/machine/q35", NULL),
> +                                   TYPE_PCI_HOST_BRIDGE);
> +    return s ? s->bus : NULL;
> +}
> +
> +
>  static const TypeInfo q35_host_info = {
>      .name       = TYPE_Q35_HOST_DEVICE,
>      .parent     = TYPE_PCIE_HOST_BRIDGE,
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c661e9cc80..550f8fa221 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
>  /* sgx.c */
>  void pc_machine_init_sgx_epc(PCMachineState *pcms);
>  
> +/* q35.c */
> +PCIBus *find_q35(void);
> +
>  extern GlobalProperty pc_compat_8_0[];
>  extern const size_t pc_compat_8_0_len;
>  


