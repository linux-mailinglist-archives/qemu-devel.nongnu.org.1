Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A027D1BEF
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 11:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu7xL-0002D3-Cs; Sat, 21 Oct 2023 05:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qu7xI-0002CF-Si
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 05:07:36 -0400
Received: from mailout09.t-online.de ([194.25.134.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qu7xG-0005k9-J4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 05:07:36 -0400
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout09.t-online.de (Postfix) with SMTP id DF0695E769;
 Sat, 21 Oct 2023 11:07:29 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.16.231]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qu7xB-1TRaN70; Sat, 21 Oct 2023 11:07:29 +0200
Message-ID: <235cbc94-8de9-4960-bb4d-3d861784436a@t-online.de>
Date: Sat, 21 Oct 2023 11:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/11] Add virtio-sound-pci device
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
 <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1697879249-DEFFADE8-F97DDEFD/0/0 CLEAN NORMAL
X-TOI-MSGID: 6e71619d-d34e-44d0-866f-b7450655235f
Received-SPF: pass client-ip=194.25.134.84; envelope-from=vr_qemu@t-online.de;
 helo=mailout09.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19.10.23 um 12:03 schrieb Emmanouil Pitsidianakis:
> This patch adds a PCI wrapper device for the virtio-sound device.
> It is necessary to instantiate a virtio-snd device in a guest.
> All sound logic will be added to the virtio-snd device in the following
> commits.
>
> To add this device with a guest, you'll need a >=5.13 kernel compiled
> with CONFIG_SND_VIRTIO=y, which at the time of writing most distros have
> off by default.
>
> Use with following flags in the invocation:
>
> Pulseaudio:
>   -audio driver=pa,model=virtio
>   or
>   -audio driver=pa,model=virtio,server=/run/user/1000/pulse/native
> sdl:
>   -audio driver=sdl,model=virtio
> coreaudio (macos/darwin):
>   -audio driver=coreaudio,model=virtio
> etc.
>
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS               |  1 +
>  hw/audio/meson.build      |  1 +
>  hw/audio/virtio-snd-pci.c | 93 +++++++++++++++++++++++++++++++++++++++
>  system/qdev-monitor.c     |  1 +
>  4 files changed, 96 insertions(+)
>  create mode 100644 hw/audio/virtio-snd-pci.c


> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1b8005ae55..f007ee6953 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -111,6 +111,7 @@ static const QDevAlias qdev_alias_table[] = {
>      { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},

Hi Manos,

the virtio-sound device alias doesn't work.

> ./qemu-system-x86_64 -machine q35 -device virtio-sound,audiodev=audio0
-audiodev pipewire,id=audio0
qemu-system-x86_64: -device virtio-sound,audiodev=audio0: No
'virtio-bus' bus found for device 'virtio-sound'

This can be fixed if you change

--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -21,7 +21,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_snd.h"
 
-#define TYPE_VIRTIO_SND "virtio-sound"
+#define TYPE_VIRTIO_SND "virtio-sound-device"
 #define VIRTIO_SND(obj) \
         OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
 
in patch 01/11.  The other virtio devices also have a device suffix in
their type name. Additionally I would insert this line

+    { "virtio-sound-device", "virtio-sound", QEMU_ARCH_VIRTIO_MMIO},

here.

With best regards,
Volker

> +    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
>      { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },


