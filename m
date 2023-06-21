Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D089B73827C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwRo-0006US-QF; Wed, 21 Jun 2023 07:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBwRm-0006U2-9S
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:56:26 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBwRk-0007dh-8C
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:56:25 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 26E1A748A61;
 Wed, 21 Jun 2023 13:56:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD16C748A5D; Wed, 21 Jun 2023 13:56:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DB69D748A60;
 Wed, 21 Jun 2023 13:56:12 +0200 (CEST)
Date: Wed, 21 Jun 2023 13:56:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 05/24] q800: move CPU object into Q800MachineState
In-Reply-To: <20230621085353.113233-6-mark.cave-ayland@ilande.co.uk>
Message-ID: <eaa9eb9e-1a1f-82a6-7daa-3fe547f59c24@eik.bme.hu>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-6-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-346340854-1687348572=:25233"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-346340854-1687348572=:25233
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
> Also change the instantiation of the CPU to use object_initialize_child()
> followed by a separate realisation.

Also seems to restrict valid CPU types but not mentioned in commit 
message. Should this patch be split up?

Regards,
BALATON Zoltan

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/m68k/q800.c         | 18 +++++++++++++-----
> include/hw/m68k/q800.h |  3 +++
> 2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 062a3c6c76..2b651de3c1 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
>
> static void q800_machine_init(MachineState *machine)
> {
> -    M68kCPU *cpu = NULL;
> +    Q800MachineState *m = Q800_MACHINE(machine);
>     int linux_boot;
>     int32_t kernel_size;
>     uint64_t elf_entry;
> @@ -407,8 +407,9 @@ static void q800_machine_init(MachineState *machine)
>     }
>
>     /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu, machine->cpu_type);
> +    qdev_realize(DEVICE(&m->cpu), NULL, &error_fatal);
> +    qemu_register_reset(main_cpu_reset, &m->cpu);
>
>     /* RAM */
>     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> @@ -430,7 +431,8 @@ static void q800_machine_init(MachineState *machine)
>
>     /* IRQ Glue */
>     glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
> +                             &error_abort);
>     sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>
>     /* VIA 1 */
> @@ -605,7 +607,7 @@ static void q800_machine_init(MachineState *machine)
>
>     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>
> -    cs = CPU(cpu);
> +    cs = CPU(&m->cpu);
>     if (linux_boot) {
>         uint64_t high;
>         void *param_blob, *param_ptr, *param_rng_seed;
> @@ -735,6 +737,11 @@ static GlobalProperty hw_compat_q800[] = {
> };
> static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
>
> +static const char *q800_machine_valid_cpu_types[] = {
> +    M68K_CPU_TYPE_NAME("m68040"),
> +    NULL
> +};
> +
> static void q800_machine_class_init(ObjectClass *oc, void *data)
> {
>     MachineClass *mc = MACHINE_CLASS(oc);
> @@ -742,6 +749,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>     mc->desc = "Macintosh Quadra 800";
>     mc->init = q800_machine_init;
>     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
> +    mc->valid_cpu_types = q800_machine_valid_cpu_types;
>     mc->max_cpus = 1;
>     mc->block_default_type = IF_SCSI;
>     mc->default_ram_id = "m68k_mac.ram";
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index f3bc17aa1b..4cb1a51dfe 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -25,6 +25,7 @@
>
> #include "hw/boards.h"
> #include "qom/object.h"
> +#include "target/m68k/cpu-qom.h"
>
> /*
>  * The main Q800 machine
> @@ -32,6 +33,8 @@
>
> struct Q800MachineState {
>     MachineState parent_obj;
> +
> +    M68kCPU cpu;
> };
>
> #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
>
--3866299591-346340854-1687348572=:25233--

