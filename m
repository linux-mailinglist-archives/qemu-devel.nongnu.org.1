Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8F7ABE1B
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 08:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjw8S-00034e-S8; Sat, 23 Sep 2023 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qjw8R-00034W-EX
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:28:59 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qjw8P-0007YB-Kd
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:28:59 -0400
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
 by mailout01.t-online.de (Postfix) with SMTP id 1B9A4A2B8;
 Sat, 23 Sep 2023 08:28:54 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.195]) by fwd80.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qjw8L-27okZl0; Sat, 23 Sep 2023 08:28:53 +0200
Message-ID: <1aa51f7a-711f-4d21-bff4-ccf58a9a8148@t-online.de>
Date: Sat, 23 Sep 2023 08:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] seabios: remove PCI drivers from bios.bin
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230921121051.192355-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1695450533-96FF7D42-3D9B4A08/0/0 CLEAN NORMAL
X-TOI-MSGID: 6b673afe-fede-47f9-aa1d-16b5d5e26ce1
Received-SPF: none client-ip=194.25.134.80; envelope-from=vr_qemu@t-online.de;
 helo=mailout01.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Am 21.09.23 um 14:10 schrieb Paolo Bonzini:
> bios.bin is now used only by ISA PC, so PCI drivers are not necessary.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  pc-bios/bios.bin         | Bin 131072 -> 131072 bytes
>  roms/config.seabios-128k |  30 ++++++++++++++++++++++--------
>  2 files changed, 22 insertions(+), 8 deletions(-)
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
>  CONFIG_QEMU=y
>  CONFIG_ROM_SIZE=128
>  CONFIG_ATA_DMA=n
>  CONFIG_BOOTSPLASH=n
>  CONFIG_XEN=n
> -CONFIG_USB_OHCI=n
> -CONFIG_USB_XHCI=n
> -CONFIG_USB_UAS=n
> +CONFIG_ATA_PIO32=n
> +CONFIG_AHCI=n
>  CONFIG_SDCARD=n
>  CONFIG_TCGBIOS=n
> -CONFIG_MPT_SCSI=n
> -CONFIG_ESP_SCSI=n
> -CONFIG_MEGASAS=n
> +CONFIG_VIRTIO_BLK=n
> +CONFIG_VIRTIO_SCSI=n
>  CONFIG_PVSCSI=n
> +CONFIG_ESP_SCSI=n
> +CONFIG_LSI_SCSI=n
> +CONFIG_MEGASAS=n
> +CONFIG_MPT_SCSI=n
>  CONFIG_NVME=n
>  CONFIG_USE_SMM=n
>  CONFIG_VGAHOOKS=n
>  CONFIG_HOST_BIOS_GEOMETRY=n
> +CONFIG_PS2PORT=n

Hi Paolo,

CONFIG_PS2PORT shouldn't be disabled. Otherwise FreeDOS and other
programs don't have a working keyboard.

With best regards,
Volker

> +CONFIG_USB=n
> +CONFIG_PMTIMER=n
> +CONFIG_PCIBIOS=n
> +CONFIG_DISABLE_A20=n
> +CONFIG_WRITABLE_UPPERMEMORY=n
> +CONFIG_ACPI=n
>  CONFIG_ACPI_PARSE=n
> +CONFIG_DEBUG_SERIAL=n
> +CONFIG_DEBUG_SERIAL_MMIO=n


