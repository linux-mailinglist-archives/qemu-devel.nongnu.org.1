Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB505712784
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XWZ-0008ON-Vn; Fri, 26 May 2023 09:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2XWT-0008NN-43; Fri, 26 May 2023 09:30:26 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2XWR-0002JH-4a; Fri, 26 May 2023 09:30:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 722B074635C;
 Fri, 26 May 2023 15:30:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3C4FD74633D; Fri, 26 May 2023 15:30:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 38E7A745720;
 Fri, 26 May 2023 15:30:19 +0200 (CEST)
Date: Fri, 26 May 2023 15:30:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ppc/mac_newworld: Check for the availability of
 pci-ohci before using it
In-Reply-To: <20230526125323.2386324-1-thuth@redhat.com>
Message-ID: <e2854ac5-e786-fcdf-453a-5a4fd343e871@eik.bme.hu>
References: <20230526125323.2386324-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Fri, 26 May 2023, Thomas Huth wrote:
> pci-ohci might habe been disabled in the QEMU binary (e.g. when "configure"
> has been run with "--without-default-devices"). Thus we should check
> for its availability before blindly using it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> hw/ppc/mac_newworld.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 535710314a..c7cca430e1 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -349,7 +349,8 @@ static void ppc_core99_init(MachineState *machine)
>                                     sysbus_mmio_get_region(s, 3));
>     }
>
> -    machine->usb |= defaults_enabled() && !machine->usb_disabled;
> +    machine->usb |= defaults_enabled() && !machine->usb_disabled &&
> +                    module_object_class_by_name("pci-ohci") != 0;

Considering that PowerMacs have an OHCI controller built in soldered to 
the motherboard should this depend on it instead and not rely on pulling 
it in with PCI_DEVICES and --without-default-devices disabling it?

Currently it's not quite emulating a real Mac but I think we should aim 
for going that way rather than to keep emulating random Mac hardware.

Regards,
BALATON Zoltan

>     has_pmu = (core99_machine->via_config != CORE99_VIA_CONFIG_CUDA);
>     has_adb = (core99_machine->via_config == CORE99_VIA_CONFIG_CUDA ||
>                core99_machine->via_config == CORE99_VIA_CONFIG_PMU_ADB);
>

