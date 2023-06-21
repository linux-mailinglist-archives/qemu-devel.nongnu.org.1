Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A93738254
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBw6f-0006Nr-Ac; Wed, 21 Jun 2023 07:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw6c-0006M2-NZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qBw6a-0005ul-VL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687347271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVWtwz/oKEY7LGg7d9m+nsxMmkiSrNStNfA3RHMwdtE=;
 b=QSjL2MwL/JSIuRkyZg0Jkw7KTHdeGcIhoNt/mLiB4Xt3pt6HhYnR+F2fdhzFDPnwtRanKP
 dejWUHx8wfEuO/SwfPAfbsSJ8r4KPmnVn2lzsTFd2Iu2OsRU3p6ekY6zdYft+lOkCA6crI
 HTTOoNNbR2Ol/aXhgC9U+fPwbAjV/iQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-CdZXswR6M9GlJZXbMN1TPQ-1; Wed, 21 Jun 2023 07:34:29 -0400
X-MC-Unique: CdZXswR6M9GlJZXbMN1TPQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355c9028so413481066b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687347268; x=1689939268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVWtwz/oKEY7LGg7d9m+nsxMmkiSrNStNfA3RHMwdtE=;
 b=K/3W1Ln3P+3LacrKEwMlcKlln4nCG/P53gS+R+3lAEnP6hnyLvOGJsmqsBw+N9iI7G
 9uhsH4UqZJ+lcHv282GzkThfYQGq2G6n+0DipVc4x+JQW42rZ8yQh80hyBWK2pnfC0Zz
 ybyUURZpKb7575Kju3RdKuqFkQ1JGopCAj9MwnMBAMqHr9RgPDM2JxeSeKfdaenq8ts5
 aiO0qhD7b0fRk8I47Ad7kKJ1gNtXiKhhLZrR9ClOPfMP8AsDt3mvNLKhMuX3xCDwL2lV
 hvPLytNHVWyrh77Q2QiO2MA6U3cbP/WVkSLXUkMPbbARz8tOx839P2thu4pGUTcGBjk5
 wzYw==
X-Gm-Message-State: AC+VfDyfVM4R7RM9JhHonj6lIaTWrQPXtB7CEMe2ShndNRVZiM2jDTHi
 o5NEz2G4z1x0m5xP4uRnjYnrii3XA3sTTwN39NfV7KIu2usDse4tzzTZBBhu+xkZsNoYTaXAw06
 UrabspQQ97sJlfn8=
X-Received: by 2002:a17:907:3f29:b0:973:8cb7:4d81 with SMTP id
 hq41-20020a1709073f2900b009738cb74d81mr18147839ejc.49.1687347268579; 
 Wed, 21 Jun 2023 04:34:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FZyGzwX8EXGGH41McsKg9OS0/xgP8330ijLmlm7Fe7LsuIYEUeHBDDkzWjFHRq0oiGTvi2g==
X-Received: by 2002:a17:907:3f29:b0:973:8cb7:4d81 with SMTP id
 hq41-20020a1709073f2900b009738cb74d81mr18147820ejc.49.1687347268260; 
 Wed, 21 Jun 2023 04:34:28 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 t24-20020a170906179800b00988e953a586sm2962964eje.61.2023.06.21.04.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 04:34:27 -0700 (PDT)
Date: Wed, 21 Jun 2023 13:34:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v1 23/23] s3 support: enabling s3 with q35
Message-ID: <20230621133427.5091fbf7@imammedo.users.ipa.redhat.com>
In-Reply-To: <109921db6ea7bfbb46130cbd3734f41068d38fe5.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <109921db6ea7bfbb46130cbd3734f41068d38fe5.1687278381.git.jupham125@gmail.com>
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

On Tue, 20 Jun 2023 13:24:57 -0400
Joel Upham <jupham125@gmail.com> wrote:

> Resetting pci devices after s3 causes guest freezes, as xen usually
> likes to handle resetting devices.

I'd prefer Xen side being fixed instead of hacking reset logic in qemu/q35.
 

> Signed-off-by: Joel Upham <jupham125@gmail.com>
> ---
>  hw/acpi/ich9.c    | 12 ++++++++----
>  hw/pci-host/q35.c |  3 ++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 1c236be1c7..234706a191 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -143,7 +143,8 @@ static int ich9_pm_post_load(void *opaque, int version_id)
>  {
>      ICH9LPCPMRegs *pm = opaque;
>      uint32_t pm_io_base = pm->pm_io_base;
> -    pm->pm_io_base = 0;
> +    if (!xen_enabled())
> +        pm->pm_io_base = 0;
>      ich9_pm_iospace_update(pm, pm_io_base);
>      return 0;
>  }
> @@ -274,7 +275,10 @@ static void pm_reset(void *opaque)
>      acpi_pm1_evt_reset(&pm->acpi_regs);
>      acpi_pm1_cnt_reset(&pm->acpi_regs);
>      acpi_pm_tmr_reset(&pm->acpi_regs);
> -    acpi_gpe_reset(&pm->acpi_regs);
> +    /* Noticed guest freezing in xen when this was reset after S3. */
> +    if (!xen_enabled()) {
> +        acpi_gpe_reset(&pm->acpi_regs);
> +    }
>  
>      pm->smi_en = 0;
>      if (!pm->smm_enabled) {
> @@ -322,7 +326,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>          acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>      }
>  
> -    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
> +    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge || xen_enabled()) {
>          acpi_pcihp_init(OBJECT(lpc_pci),
>                          &pm->acpi_pci_hotplug,
>                          pci_get_bus(lpc_pci),
> @@ -345,7 +349,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
>          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
>  
> -    if (pm->acpi_memory_hotplug.is_enabled) {
> +    if (pm->acpi_memory_hotplug.is_enabled || xen_enabled()) {
>          acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
>                                   &pm->acpi_memory_hotplug,
>                                   ACPI_MEMORY_HOTPLUG_BASE);
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 1fe4e5a5c9..5891839ce9 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -580,7 +580,8 @@ static void mch_reset(DeviceState *qdev)
>      d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
>      d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
>  
> -    mch_update(mch);
> +    if (!xen_enabled())
> +        mch_update(mch);
>  }
>  
>  static void mch_realize(PCIDevice *d, Error **errp)


