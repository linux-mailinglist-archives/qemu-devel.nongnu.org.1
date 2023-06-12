Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E272C641
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hoS-0007O8-6g; Mon, 12 Jun 2023 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hoQ-0007Ni-3B
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hoO-0006Or-HB
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686577342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIHRkHIk31UtksEpOUT6Bc8hNYG5AGq8W88SjYBvB34=;
 b=PfCePmONIho+MveL8GxWA0L7NohNZ1on/y/DhKYIoS8l52K9lJFI37W3LJvd6ZIy1f8qbr
 VuqhobimfROcrKrGGCeZ1LRGqe/ZV0T+KBwOq5y0Yde6fFL/zMLU6jaNSp9yvVR3vDtJ71
 RZcEdp+JPP/qRHvuIiMY+mZ1s/eSQCw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-QbgU_zqpP_GrKg3ZWUDYKQ-1; Mon, 12 Jun 2023 09:42:21 -0400
X-MC-Unique: QbgU_zqpP_GrKg3ZWUDYKQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-977cb78acfcso391667066b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686577340; x=1689169340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIHRkHIk31UtksEpOUT6Bc8hNYG5AGq8W88SjYBvB34=;
 b=ZLD6AKSq6U44riFOxjkZTuMY52knTAhpq98x5j5OlFgM73IgrN+2BIgYCAwyy1gqnC
 sXcFlH0VuBONDrabd3jo0IU4+ChcwZM4hI9YC/9+Pgyw8gW7souexkHZX0cGrYQx8yQS
 osGYkyBN6sLrw1mtcXx/+UrozyHo2/FWIH9FPcZTtNBMBZY9fqQ9ZgtoozJscc5i+AcB
 CzXjnDQrxqViOqUy6+Ep+1MF5aHEhWHB0huef8bcumd5a4/2Yzt+vV4BW9eWt2BxVXei
 v6Y1kt3aXIg24OBEd5h3a2/58Io9PmrMvxw+C5JOZ7FQt3VGGicScOBLBqx3M7Z8RvtP
 SmOA==
X-Gm-Message-State: AC+VfDx+LyAP9L6R3QibAJkin+YriM7BrVVZyohUP4/ii9ROUg7c/qv0
 WbS/JiKRW9HpINYrcoE9LMsvx+mxlhsRFGAXYjl/qRm/2eYUpqy4tnhGuaKYKaan6K9qUHtqkCo
 mzmauT5SuxAwPUig=
X-Received: by 2002:a17:907:2da4:b0:981:a949:27f3 with SMTP id
 gt36-20020a1709072da400b00981a94927f3mr3388305ejc.55.1686577340329; 
 Mon, 12 Jun 2023 06:42:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rYWHIUxxatq7Pz9AH0RLAqpg3ySW0r2R7Uv26FngdxvQNXxv83MDSrGl2OzomSngQH7P0xQ==
X-Received: by 2002:a17:907:2da4:b0:981:a949:27f3 with SMTP id
 gt36-20020a1709072da400b00981a94927f3mr3388293ejc.55.1686577339964; 
 Mon, 12 Jun 2023 06:42:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r26-20020a1709067fda00b0096a1ba4e0d1sm5234668ejs.32.2023.06.12.06.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:42:19 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:42:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 03/15] hw/pci-host/q35: Initialize PCMachineState::bus
 in board code
Message-ID: <20230612154218.13efd9db@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-4-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-4-shentey@gmail.com>
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

On Sun, 11 Jun 2023 12:34:00 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> The Q35 PCI host currently sets the PC machine's PCI bus attribute
> through global state, thereby assuming the machine to be a PC machine.
> The Q35 machine code already holds on to Q35's pci bus attribute, so can
> easily set its own property while preserving encapsulation.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_q35.c  | 4 +++-
>  hw/pci-host/q35.c | 1 -
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 62c5d652b7..29b46d3e1c 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -230,10 +230,12 @@ static void pc_q35_init(MachineState *machine)
>                              x86ms->below_4g_mem_size, NULL);
>      object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>                              x86ms->above_4g_mem_size, NULL);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>  
>      /* pci */
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>      host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
> +    pcms->bus = host_bus;
> +
>      /* create ISA bus */
>      lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
>                                  TYPE_ICH9_LPC_DEVICE);
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 859c197f25..23b689dba3 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -66,7 +66,6 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
>                                  s->mch.pci_address_space,
>                                  s->mch.address_space_io,
>                                  0, TYPE_PCIE_BUS);
> -    PC_MACHINE(qdev_get_machine())->bus = pci->bus;
>      pci->bypass_iommu =
>          PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
>      qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);


