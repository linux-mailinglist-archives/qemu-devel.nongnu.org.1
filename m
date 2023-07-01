Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E7744934
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 15:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFakf-0005lJ-S6; Sat, 01 Jul 2023 09:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qFakd-0005l1-Nn; Sat, 01 Jul 2023 09:34:59 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1qFakY-0007rL-Ta; Sat, 01 Jul 2023 09:34:58 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 6CBE0A00F2; Sat,  1 Jul 2023 15:34:40 +0200 (CEST)
Date: Sat, 1 Jul 2023 15:34:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Olaf Hering <olaf@aepfle.de>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Lev Kujawski <lkujaw@member.fsf.org>, Bernhard Beschow <shentey@gmail.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230701111341.25500-1-olaf@aepfle.de>
Message-ID: <alpine.LMD.2.03.2307011532500.25684@eik.bme.hu>
References: <20230701111341.25500-1-olaf@aepfle.de>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-530943996-1688218480=:25684"
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--1117279078-530943996-1688218480=:25684
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 1 Jul 2023, Olaf Hering wrote:
> According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA=E2=80=
=94BUS
> MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
> 32bit wide. To properly reset it to default values, all 32bit need to be
> cleared. Bit #1 "Resource Type Indicator (RTE)" needs to be enabled.
>
> The initial change wrote just the lower 8 bit, leaving parts of the "Bus
> Master Interface Base Address" address at bit 15:4 unchanged.
>
> This bug went unnoticed until commit ee358e919e38 ("hw/ide/piix: Convert
> reset handler to DeviceReset"). After this change, piix_ide_reset is
> exercised after the "unplug" command from a Xen HVM domU, which was not
> the case prior that commit. This function resets the command register.
> As a result the ata_piix driver inside the domU will see a disabled PCI
> device. The generic PCI code will reenable the PCI device. On the qemu
> side, this runs pci_default_write_config/pci_update_mappings. Here a
> changed address is returned by pci_bar_address, this is the address
> which was truncated in piix_ide_reset. In case of a Xen HVM domU, the
> address changes from 0xc120 to 0xc100.
>
> While the unplug is supposed to hide the IDE disks, the changed BMIBA
> address breaks the UHCI device. In case the domU has an USB tablet
> configured, to recive absolute pointer coordinates for the GUI, it will
> cause a hang during device discovery of the partly discovered USB hid
> device. Reading the USBSTS word size register will fail. The access ends
> up in the QEMU piix-bmdma device, instead of the expected uhci device.
> Here a byte size request is expected, and a value of ~0 is returned. As
> a result the UCHI driver sees an error state in the register, and turns
> off the UHCI controller.
>
> Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved suppor=
t for 82371SB (Function 1)")
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
> hw/ide/piix.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index 41d60921e3..6449ba8b6b 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -118,7 +118,7 @@ static void piix_ide_reset(DeviceState *dev)
>     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
>     pci_set_word(pci_conf + PCI_STATUS,
>                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
> -    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
> +    pci_set_word(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */

Commit message is way longer than the patch itself and very detailed but I=
=20
may have lost in the details. If all 32 bits should be writtern does this=
=20
need pci_set_long instead of pci_set_word?

Regards,
BALATON Zoltan

> }
>
> static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)
>
> base-commit: d145c0da22cde391d8c6672d33146ce306e8bf75
>
>
--1117279078-530943996-1688218480=:25684--

