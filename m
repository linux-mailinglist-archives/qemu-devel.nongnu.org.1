Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759D81591B
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 13:55:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEUBN-0002ol-TX; Sat, 16 Dec 2023 07:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEUBK-0002nS-RO; Sat, 16 Dec 2023 07:54:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEUBE-0000Tx-K1; Sat, 16 Dec 2023 07:54:14 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0193D75A4BA;
 Sat, 16 Dec 2023 13:53:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eV5CGc74RIto; Sat, 16 Dec 2023 13:53:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B2F9C75A406; Sat, 16 Dec 2023 13:53:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B006275607B;
 Sat, 16 Dec 2023 13:53:55 +0100 (CET)
Date: Sat, 16 Dec 2023 13:53:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] docs/system: Document running Linux on amigaone
 machine
In-Reply-To: <20231216123013.67978-1-shentey@gmail.com>
Message-ID: <da92f16c-585a-7d1f-fa0b-9a6912f7760e@eik.bme.hu>
References: <20231216123013.67978-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1143594639-1702731235=:3206"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1143594639-1702731235=:3206
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 16 Dec 2023, Bernhard Beschow wrote:
> Documentation on how to run Linux on the amigaone machine is currently burried
> in the depths of the qemu-devel mailing list [1] and in the source code. Let's
> collect the information in the QEMU handbook for a one stop solution.

Thanks for collecting this info and adding it as documentation. A few 
small comments bellow.

> [1] https://lore.kernel.org/qemu-devel/dafc407d-3749-e6f4-3a66-750fde8965f9@eik.bme.hu/

Do we want to keep an URL in the commit log? kernel.org is quite stable 
but not sure it would need to be in the commit message.

> Co-authored-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> MAINTAINERS                  |  1 +
> docs/system/ppc/amigaone.rst | 53 ++++++++++++++++++++++++++++++++++++
> docs/system/target-ppc.rst   |  1 +
> hw/ppc/amigaone.c            |  9 ------
> 4 files changed, 55 insertions(+), 9 deletions(-)
> create mode 100644 docs/system/ppc/amigaone.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 695e0bd34f..a2dd1407e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1560,6 +1560,7 @@ amigaone
> M: BALATON Zoltan <balaton@eik.bme.hu>
> L: qemu-ppc@nongnu.org
> S: Maintained
> +F: docs/system/ppc/amigaone.rst
> F: hw/ppc/amigaone.c
> F: hw/pci-host/articia.c
> F: include/hw/pci-host/articia.h
> diff --git a/docs/system/ppc/amigaone.rst b/docs/system/ppc/amigaone.rst
> new file mode 100644
> index 0000000000..c3f11a7bb2
> --- /dev/null
> +++ b/docs/system/ppc/amigaone.rst

Maybe call it amigang.rst so it can be a place for docs on other PPC 
AmigaNG machines such as pegasos2 and sam460ex in the future to collect 
them in one place.

> @@ -0,0 +1,53 @@
> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
> +===============================================
> +
> +The ``amigaone`` model emulates an AmigaOne XE mainboard developed by Eyetech. Use
> +the executable ``qemu-system-ppc`` to simulate a complete system.

QEMU is not a simulator so even if that's repeating this should say 
emulate. (Should this doc be formatted with 80 chars line too like 
sources?)

> +
> +Emulated devices
> +----------------
> +
> + *  PowerPC 7457 v1.2 CPU
> + *  Articia S north bridge
> + *  VT82C686B south bridge
> + *  PCI VGA compatible card
> +
> +
> +Preparation
> +-----------
> +
> +A firmware binary is necessary for the boot process and is available at
> +https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28.
> +It needs to be extracted with the following command:
> +
> +.. code-block:: bash
> +
> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
> +
> +The firmware binary is unable to run QEMU‘s standard vgabios and
> +``VGABIOS-lgpl-latest.bin`` is needed instead. It can be downloaded from
> +http://www.nongnu.org/vgabios.
> +
> +
> +Running Linux
> +-------------
> +
> +There are some Linux images under the following link that work on the
> +``amigaone`` machine:
> +https://sourceforge.net/projects/amigaone-linux/files/debian-installer/. To boot
> +the system run:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -M amigaone -bios u-boot-amigaone.bin \
> +                    -cdrom "A1 Linux Net Installer.iso" \
> +                    -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
> +
> +From the firmware menu that appears select ``Boot sequence`` →
> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
> +hit escape once more and from the exit menu that appears select either
> +``Save settings and exit`` or ``Use settings for this session only``. It may
> +take a long time loading the kernel into memory but eventually it boots and the
> +installer becomes visible.
> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
> index 4f6eb93b17..c1daa463cf 100644
> --- a/docs/system/target-ppc.rst
> +++ b/docs/system/target-ppc.rst
> @@ -18,6 +18,7 @@ help``.
>    :maxdepth: 1
>
>    ppc/embedded
> +   ppc/amigaone
>    ppc/powermac
>    ppc/powernv
>    ppc/ppce500
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index ddfa09457a..4f680a5bdd 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -27,15 +27,6 @@
>
> #define BUS_FREQ_HZ 100000000
>
> -/*
> - * Firmware binary available at
> - * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
> - * then "tail -c 524288 updater.image >u-boot-amigaone.bin"
> - *
> - * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it, use
> - * -device VGA,romfile=VGABIOS-lgpl-latest.bin
> - * from http://www.nongnu.org/vgabios/ instead.
> - */

Maybe it's worth keeping the comment here in case somebody reads the 
source but not documentation. Do you want to send a v2 or want me to take 
over and do it myself?

Regards,
BALATON Zoltan
--3866299591-1143594639-1702731235=:3206--

