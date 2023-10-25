Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8187D765E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 23:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvl4x-00015E-5U; Wed, 25 Oct 2023 17:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvl4R-00012s-4V; Wed, 25 Oct 2023 17:05:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvl4O-0001JC-AP; Wed, 25 Oct 2023 17:05:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2298B756066;
 Wed, 25 Oct 2023 23:05:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D8F2B7456A7; Wed, 25 Oct 2023 23:05:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D6F46745681;
 Wed, 25 Oct 2023 23:05:36 +0200 (CEST)
Date: Wed, 25 Oct 2023 23:05:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 22/23] hw/display: make ATI_VGA depend on PIXMAN
In-Reply-To: <20231025190818.3278423-23-marcandre.lureau@redhat.com>
Message-ID: <63e8196a-da54-83fa-0eea-ed9a4b669186@eik.bme.hu>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1313484981-1698267825=:42723"
Content-ID: <fb638488-a307-f23b-1920-ba66f28b6179@eik.bme.hu>
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1313484981-1698267825=:42723
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <f73a3489-2682-4edb-3957-10b06512df60@eik.bme.hu>

On Wed, 25 Oct 2023, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> configs/devices/mips64el-softmmu/default.mak | 2 +-
> hw/display/Kconfig                           | 2 +-
> hw/display/meson.build                       | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
> index d5188f7ea5..8d85607571 100644
> --- a/configs/devices/mips64el-softmmu/default.mak
> +++ b/configs/devices/mips64el-softmmu/default.mak
> @@ -3,7 +3,7 @@
> include ../mips-softmmu/common.mak
> CONFIG_FULOONG=y
> CONFIG_LOONGSON3V=y
> -CONFIG_ATI_VGA=y
> +# CONFIG_ATI_VGA=n

I think I've asked this before but forgot the answer... However fuloong2e 
has an on board ati-vga so does this (or should it) disable CONFIG_FULOONG 
when !PIXMAN? Or that machine should omit the on board graphics in this 
case?

Regards,
BALATON Zoltan

> CONFIG_RTL8139_PCI=y
> CONFIG_JAZZ=y
> CONFIG_VT82C686=y
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1aafe1923d..4d8a6c4af8 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -125,7 +125,7 @@ config DPCD
> config ATI_VGA
>     bool
>     default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PCI && PIXMAN
>     select VGA
>     select BITBANG_I2C
>     select DDC
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 9c06aaee20..344dfe3d8c 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
>
> system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>
> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>
>
> if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>
--3866299591-1313484981-1698267825=:42723--

