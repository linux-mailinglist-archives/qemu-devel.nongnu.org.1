Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5A826451
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:55:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMTcL-00015R-Ph; Sun, 07 Jan 2024 08:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMTcJ-00015B-Ln; Sun, 07 Jan 2024 08:55:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMTcH-0001uT-Gq; Sun, 07 Jan 2024 08:55:07 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 12E8F4E6D04;
 Sun,  7 Jan 2024 14:54:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id e6stFTtT9lvs; Sun,  7 Jan 2024 14:54:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2473A4E6BDF; Sun,  7 Jan 2024 14:54:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 20D7674577C;
 Sun,  7 Jan 2024 14:54:57 +0100 (CET)
Date: Sun, 7 Jan 2024 14:54:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH v4 10/11] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
In-Reply-To: <20240106210531.140542-11-shentey@gmail.com>
Message-ID: <fa7a9464-912c-19d7-e9d0-b1a0896e0cac@eik.bme.hu>
References: <20240106210531.140542-1-shentey@gmail.com>
 <20240106210531.140542-11-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sat, 6 Jan 2024, Bernhard Beschow wrote:
> This is a preparation for implementing relocation and toggling of SuperI/O
> functions in the VT8231 device model. Upon reset, all SuperI/O functions will be
> deactivated, so in case if no -bios is given, let the machine configure those
> functions the same way Pegasos II firmware would do.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ppc/pegasos2.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 3203a4a728..0a40ebd542 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
> }
>
> +static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t addr,
> +                                   uint32_t val)
> +{
> +    AddressSpace *as = CPU(pm->cpu)->as;

I think this function should not need Pegasos2MachineState *pm and can 
just use cpu_physical_memory_write() instead. Otherwise

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> +
> +    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
> +    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
> +}
> +
> static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
> {
>     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
> @@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
>
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>                               PCI_INTERRUPT_LINE, 2, 0x9);
> +    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
> +                              0x50, 1, 0x6);
> +    pegasos2_superio_write(pm, 0xf4, 0xbe);
> +    pegasos2_superio_write(pm, 0xf6, 0xef);
> +    pegasos2_superio_write(pm, 0xf7, 0xfc);
> +    pegasos2_superio_write(pm, 0xf2, 0x14);
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>                               0x50, 1, 0x2);
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>

