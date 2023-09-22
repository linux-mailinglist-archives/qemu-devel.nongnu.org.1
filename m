Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2657AA94A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:49:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjZyJ-0001BD-D7; Fri, 22 Sep 2023 02:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjZyF-0001B0-NH
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjZyE-0003cP-7N
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695365337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0VRdHN1u/WKHbhuvzQvzy/5E//X4sYpcI5P2OfCDSU=;
 b=Sd0rfaHoWXzSjO7Xt4ITu9GIJv0EBEJhAP0Hleti70f5xBBBYfHX4sllWobXVAPxItGTDv
 6KhaoWwko3NdC2SOAMHZxmKGUKaaiHd1OpMIIc3/IgNtHVNtKFMya3+nx6T0XhG0FfOPlY
 92Iqlyu1nY3UwhL4WbUKC1iPqo2g8+o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-nlJmTGhXO7KfM4r8Iw3LOQ-1; Fri, 22 Sep 2023 02:48:55 -0400
X-MC-Unique: nlJmTGhXO7KfM4r8Iw3LOQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso132382666b.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 23:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695365334; x=1695970134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0VRdHN1u/WKHbhuvzQvzy/5E//X4sYpcI5P2OfCDSU=;
 b=IWjP5cr5LMyTPfl5wDPGgrvYcq6MxD5z3UDBvB2SbgCbkM531poGBw9+CosvkhrrHe
 aobaPvq/JW+fz//cQkWyzUN+T6uUPQJQvC72ZAv9hmHYe6IIuLlMpV3N+7vLNCkWPr1I
 XCZTVSZGU2DHwX8RtHy4PiGQUQZWMhaKXbKm/CTMvZNXRUswnhH6Uj3lHCfmruxy1ho0
 HfO+jHE+omr8BMivhjTDwTElb66N317qsyiyLkc8U7WE6nPQn4Gr7Tef+OhoGJvlbHEh
 nYh1ud/m1zVltCsoUdaORN3UcQfl0gFi/nFAZidBkau522sRPZZmmB8IKrqoL/lPMrFv
 6Qpg==
X-Gm-Message-State: AOJu0YyPTAK+Pwkldno9oglLWKPW8BdpjNSxvRwIDyHjCerWJ03aR2RT
 iFP8Da0Dho5IVPl8VIjerwf3temEI8DQ1hqMJbazvpehl8THCxXm9GSrGgTYc42Dc83xWS2Gj6+
 eQ0+Gv9+CmMd/N1M=
X-Received: by 2002:a17:906:2001:b0:9a4:88af:b82 with SMTP id
 1-20020a170906200100b009a488af0b82mr6172683ejo.77.1695365334353; 
 Thu, 21 Sep 2023 23:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvN5l8zyNYLjTqCwQXd93dCuXtKJgTX7t8VMUHN6de9Tv6VISX2CCd7lB8nJQkikeeQimcJQ==
X-Received: by 2002:a17:906:2001:b0:9a4:88af:b82 with SMTP id
 1-20020a170906200100b009a488af0b82mr6172674ejo.77.1695365334041; 
 Thu, 21 Sep 2023 23:48:54 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 r11-20020a170906704b00b00999bb1e01dfsm2232466ejj.52.2023.09.21.23.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 23:48:53 -0700 (PDT)
Message-ID: <9ad33139-93e3-12af-a67d-c7a3906198ce@redhat.com>
Date: Fri, 22 Sep 2023 08:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] seabios: remove PCI drivers from bios.bin
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230921121051.192355-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
> bios.bin is now used only by ISA PC, so PCI drivers are not necessary.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   pc-bios/bios.bin         | Bin 131072 -> 131072 bytes
>   roms/config.seabios-128k |  30 ++++++++++++++++++++++--------
>   2 files changed, 22 insertions(+), 8 deletions(-)
...
> diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
> index d18c802c46e..06f4ba35bbe 100644
> --- a/roms/config.seabios-128k
> +++ b/roms/config.seabios-128k
> @@ -1,21 +1,35 @@
> -# for qemu machine types 1.7 + older
> -# need to turn off features (xhci,uas) to make it fit into 128k
> +# SeaBIOS Configuration for -M isapc
> +
> +#
> +# General Features
> +#
>   CONFIG_QEMU=y
>   CONFIG_ROM_SIZE=128
>   CONFIG_ATA_DMA=n
>   CONFIG_BOOTSPLASH=n
>   CONFIG_XEN=n
> -CONFIG_USB_OHCI=n
> -CONFIG_USB_XHCI=n
> -CONFIG_USB_UAS=n
> +CONFIG_ATA_PIO32=n
> +CONFIG_AHCI=n
>   CONFIG_SDCARD=n
>   CONFIG_TCGBIOS=n
> -CONFIG_MPT_SCSI=n
> -CONFIG_ESP_SCSI=n
> -CONFIG_MEGASAS=n
> +CONFIG_VIRTIO_BLK=n
> +CONFIG_VIRTIO_SCSI=n
>   CONFIG_PVSCSI=n
> +CONFIG_ESP_SCSI=n
> +CONFIG_LSI_SCSI=n
> +CONFIG_MEGASAS=n
> +CONFIG_MPT_SCSI=n

Why did you change the order of MPT, ESP and MEGASAS?

Apart from that, wrt to the config file changes:
Reviewed-by: Thomas Huth <thuth@redhat.com>

>   CONFIG_NVME=n
>   CONFIG_USE_SMM=n
>   CONFIG_VGAHOOKS=n
>   CONFIG_HOST_BIOS_GEOMETRY=n
> +CONFIG_PS2PORT=n
> +CONFIG_USB=n
> +CONFIG_PMTIMER=n
> +CONFIG_PCIBIOS=n
> +CONFIG_DISABLE_A20=n
> +CONFIG_WRITABLE_UPPERMEMORY=n
> +CONFIG_ACPI=n
>   CONFIG_ACPI_PARSE=n
> +CONFIG_DEBUG_SERIAL=n
> +CONFIG_DEBUG_SERIAL_MMIO=n


