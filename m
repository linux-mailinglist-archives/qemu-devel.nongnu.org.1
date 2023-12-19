Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F215C817EA3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 01:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNi5-0006hb-Pz; Mon, 18 Dec 2023 19:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNi2-0006hF-Ol; Mon, 18 Dec 2023 19:11:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNi1-0000W8-7O; Mon, 18 Dec 2023 19:11:42 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0286475A4C2;
 Tue, 19 Dec 2023 01:11:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id S29TuSnDrEii; Tue, 19 Dec 2023 01:11:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B7C575A406; Tue, 19 Dec 2023 01:11:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 19072756094;
 Tue, 19 Dec 2023 01:11:37 +0100 (CET)
Date: Tue, 19 Dec 2023 01:11:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 11/12] hw/ppc/pegasos2: Let pegasos2 machine configure
 SuperI/O functions
In-Reply-To: <20231218185114.119736-12-shentey@gmail.com>
Message-ID: <9ccd94d1-130f-b009-cd25-f32122c78908@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-12-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Mon, 18 Dec 2023, Bernhard Beschow wrote:
> This is a preparation for implementing relocation and toggling of SuperI/O
> functions in the VT8231 device model. Upon reset, all SuperI/O functions will be
> deactivated, so in case if no -bios is given, let the machine configure those
> functions the same way pegasos2.rom would do. For now the meantime this will be

"same way pegasos2 firmware would do". You can drop the last sentence 
about no-op as it does not make much sense as it is or reword it if you 
want to keep it.

Regards,
BALATON Zoltan

> a no-op.
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

