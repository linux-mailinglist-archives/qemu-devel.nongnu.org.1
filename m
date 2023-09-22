Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 610267AA93D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:45:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjZtK-0008Pt-9G; Fri, 22 Sep 2023 02:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjZtI-0008PT-Hy
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjZtG-0002ik-PR
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695365029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpYhSX6PWOKhLvQQ3Rug6nv+3LhdNr8dXF2qvm5U9qk=;
 b=emIN1uoILtc4Y0K0HJ33HpUjdTJhShm3jt1tkr5A1VuGFEt/833efp9bJcPvtlmVFq5qe+
 5ShiWnhxGJBqnUW1juoMW4oD0Bap3kJfWmCaLmFtgn8LlZzq1VDUs9LadX6x5y47CZKCUm
 xoudlmn2dx4ZCNJVoONCX/reqGnfD+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-K1Q87LcYNN-1LpviHfmD8w-1; Fri, 22 Sep 2023 02:43:47 -0400
X-MC-Unique: K1Q87LcYNN-1LpviHfmD8w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-404f81fe7cfso14631085e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 23:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695365026; x=1695969826;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CpYhSX6PWOKhLvQQ3Rug6nv+3LhdNr8dXF2qvm5U9qk=;
 b=X1oD8Rsn2t5mLHE1NHciq69UOBj+7fuCt6Pjesh6h84ycE+sfDr8OYqjdp1OZ9KCK5
 HPn5CdFwBp0kLhNoh4mvgoc4kxeV1aw6h0+DSH0YBmwGlwQRhprSwVoQMh8LOHeGIh26
 xAFcx1jdi1WCALOHYpiwzrHyTkktc4S3ru1maL5zrl6gCqYL2bZsopthmDYM6ymAHNeD
 HSgor2rQBaubczNasFH12q/y5it0q3ukxvpees64qfYJHB7aK+p+klXrgrf6bTZT51tz
 2MTetSylfKESSWTmWbTB/ceCv9I8HfFCfPL4097W6gXjaTAtTBGdwxdNmOEElL2svN30
 0aVw==
X-Gm-Message-State: AOJu0YzUKmttzuVHH2HAmBT4yu+wNAonYCXs7WIM9ki2uGRFH0MgorHB
 sBFwzi0Ze9DUxkJwdJWIGFyYUOe09vNMjJNtBVa3ARePhudU9iYSEIhv2TX9poTufparZth7I9k
 VX4Nq61yx0zKuSEc=
X-Received: by 2002:a7b:ce94:0:b0:401:c8b9:4b86 with SMTP id
 q20-20020a7bce94000000b00401c8b94b86mr1227145wmj.9.1695365026316; 
 Thu, 21 Sep 2023 23:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxDhdy4EXcnTU6dOwMAcKmmWtu3a+WspJULoWniNqA/96ljg7lLM+Uhtu5Y1R5y4gra61sng==
X-Received: by 2002:a7b:ce94:0:b0:401:c8b9:4b86 with SMTP id
 q20-20020a7bce94000000b00401c8b94b86mr1227137wmj.9.1695365025918; 
 Thu, 21 Sep 2023 23:43:45 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 b15-20020adfde0f000000b0031c6cc74882sm3624851wrm.107.2023.09.21.23.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 23:43:45 -0700 (PDT)
Message-ID: <052e2425-f2fa-76ee-dd40-639d88210b4c@redhat.com>
Date: Fri, 22 Sep 2023 08:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
In-Reply-To: <20230921121051.192355-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/09/2023 14.10, Paolo Bonzini wrote:
> These are the last users of the 128K SeaBIOS blob in the i440FX family.
> Removing them allows us to drop PCI support from the 128K blob,
> thus making it easier to update SeaBIOS to newer versions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/about/deprecated.rst           |  8 ----
>   docs/about/removed-features.rst     |  2 +-
>   hw/i386/pc.c                        | 54 ---------------------
>   hw/i386/pc_piix.c                   | 73 -----------------------------
>   tests/qtest/test-x86-cpuid-compat.c | 10 +---
>   5 files changed, 2 insertions(+), 145 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 694a165a54a..d59bcf36230 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -261,14 +261,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> -``pc-i440fx-1.4`` up to ``pc-i440fx-1.7`` (since 7.0)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -These old machine types are quite neglected nowadays and thus might have
> -various pitfalls with regards to live migration. Use a newer machine type
> -instead.

While you're at it ... do we maybe want to start deprecating the next batch 
of machine types already? (Say pc-i440fx-2.0 up to pc-i440fx-2.2 maybe?)

> -
>   Backend options
>   ---------------
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 39468b6e926..56e078ad126 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -730,7 +730,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
>   
>   This machine has been renamed ``fuloong2e``.
>   
> -``pc-0.10`` up to ``pc-1.3`` (removed in 4.0 up to 6.0)
> +``pc-0.10`` up to ``pc-1.7`` (removed in 4.0 up to 8.2)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''''

The names started to change with version 1.4, so it's "pc-i440fx-1.7" and 
not "pc-1.7".

>   These machine types were very old and likely could not be used for live
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c411..1c7898a2d34 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -359,60 +359,6 @@ GlobalProperty pc_compat_2_0[] = {
>   };
>   const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
>   
> -GlobalProperty pc_compat_1_7[] = {
> -    PC_CPU_MODEL_IDS("1.7.0")
> -    { TYPE_USB_DEVICE, "msos-desc", "no" },
> -    { "PIIX4_PM", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" },
> -    { "hpet", HPET_INTCAP, "4" },
> -};
> -const size_t pc_compat_1_7_len = G_N_ELEMENTS(pc_compat_1_7);
> -
> -GlobalProperty pc_compat_1_6[] = {
> -    PC_CPU_MODEL_IDS("1.6.0")
> -    { "e1000", "mitigation", "off" },
> -    { "qemu64-" TYPE_X86_CPU, "model", "2" },
> -    { "qemu32-" TYPE_X86_CPU, "model", "3" },
> -    { "i440FX-pcihost", "short_root_bus", "1" },
> -    { "q35-pcihost", "short_root_bus", "1" },
> -};
> -const size_t pc_compat_1_6_len = G_N_ELEMENTS(pc_compat_1_6);
> -
> -GlobalProperty pc_compat_1_5[] = {
> -    PC_CPU_MODEL_IDS("1.5.0")
> -    { "Conroe-" TYPE_X86_CPU, "model", "2" },
> -    { "Conroe-" TYPE_X86_CPU, "min-level", "2" },
> -    { "Penryn-" TYPE_X86_CPU, "model", "2" },
> -    { "Penryn-" TYPE_X86_CPU, "min-level", "2" },
> -    { "Nehalem-" TYPE_X86_CPU, "model", "2" },
> -    { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
> -    { "virtio-net-pci", "any_layout", "off" },
> -    { TYPE_X86_CPU, "pmu", "on" },
> -    { "i440FX-pcihost", "short_root_bus", "0" },
> -    { "q35-pcihost", "short_root_bus", "0" },
> -};
> -const size_t pc_compat_1_5_len = G_N_ELEMENTS(pc_compat_1_5);
> -
> -GlobalProperty pc_compat_1_4[] = {
> -    PC_CPU_MODEL_IDS("1.4.0")
> -    { "scsi-hd", "discard_granularity", "0" },
> -    { "scsi-cd", "discard_granularity", "0" },
> -    { "ide-hd", "discard_granularity", "0" },
> -    { "ide-cd", "discard_granularity", "0" },
> -    { "virtio-blk-pci", "discard_granularity", "0" },
> -    /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string: */
> -    { "virtio-serial-pci", "vectors", "0xFFFFFFFF" },
> -    { "virtio-net-pci", "ctrl_guest_offloads", "off" },
> -    { "e1000", "romfile", "pxe-e1000.rom" },
> -    { "ne2k_pci", "romfile", "pxe-ne2k_pci.rom" },
> -    { "pcnet", "romfile", "pxe-pcnet.rom" },
> -    { "rtl8139", "romfile", "pxe-rtl8139.rom" },
> -    { "virtio-net-pci", "romfile", "pxe-virtio.rom" },
> -    { "486-" TYPE_X86_CPU, "model", "0" },
> -    { "n270" "-" TYPE_X86_CPU, "movbe", "off" },
> -    { "Westmere" "-" TYPE_X86_CPU, "pclmulqdq", "off" },
> -};
> -const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);

It might be worth to have a closer look at the above settings in the various 
devices - maybe we can get rid of some compatibility handling code in the 
devices now, in case the properties are not set by other targets as well.

  Thomas


