Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FB721884
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qPB-0005hv-CH; Sun, 04 Jun 2023 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qP7-0005hc-DB
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:16:29 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q5qP5-0004Wu-G3
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:16:29 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIdS1-1prm2y1Afd-00Eb6T; Sun, 04 Jun 2023 18:16:21 +0200
Message-ID: <6e6e421b-2de4-f0b7-08a8-f3d022bc475b@vivier.eu>
Date: Sun, 4 Jun 2023 18:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 05/23] q800: move CPU object into Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-6-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230604131450.428797-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oaLpuljKSZ3ntPSYZ19FArRdD497wf0ehAwR+w6xzzYqXZRUMBb
 mELu8CBoGviOk0FfFQtmqXAVOl69/u22Qm4JuE4tURvE3hZ28Grnu7yf8W+rjvAGi/HN8U3
 4FPSKa4SedjVyR75+AinEDM8xJ0mjMZRBO59nZIxXLhSrZ79uCvDGoDWXjoURM/DnV4Phn0
 /3f2tTpyC6rA5wVnVP84A==
UI-OutboundReport: notjunk:1;M01:P0:gma7eljF3ts=;ILolciCAPkpg+WiMQpF40Y7qzb8
 ABsoEzuNj9PB6Mp2cQC9V/ctsp54ej/I44OxLY4Zj2HAEtC56k2VEC+IHWx7t8kZ0h8yHWSAu
 3JyxKp1h05sE0xi+fIfn3qtTnNgnRF+2KbCYs2uF/AE9dJWAjFLg4u4zcwjiXSmNimwSu6uhG
 PNSCeX/nrYw7n/DW3jO8e+jPxm1RXz9prYg50QWgA66lIL5FCOsu6VBeZhoa1A9v26pFQQhYX
 wCT/rXeOV53+a1ctL0L2KfJoXupOWKpd0YUaRwL1QyL3X4SA3FdwQDZ5lGxQeN96Fe+h+/+aC
 n7FwJ0SLzMRxtbr9Z2vUmoVLaopEp7RSyBZxT7xYOSa40lUQSTUYUtprZeXoxWW6e+AGG1F3k
 kozXYWsMMpQ/F3S9Tu3WfAlAKQDcptQxoRtdZDrfYl6AmabO18cBYogQo7ocxr41Yt0XVJxbp
 C5khu84KpCOyqeNcSeBDK4OKjHWdimTo0Pv/C21dtZtcU7O61ICS26GVYbVxfai/uneKCYTa5
 F/EL2hN2H5neINevx8hdR7mvaWxDaZsd2aBhHR+NHgiPf7lBMwpct9J9UtX3gfEbnyqmfarGR
 sHMYOHWDMl2f8wcYd759TGQwgta8nY9cP+deGtuk8mNCousFEQZtdMpP80urwQvvMnVXIZssG
 n8jpfzPy9brYSiwg7pTD1oXoSMghp15cDPotueFa6w==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 04/06/2023 à 15:14, Mark Cave-Ayland a écrit :
> Also change the instantiation of the CPU to use object_initialize_child()
> followed by a separate realisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 18 +++++++++++++-----
>   include/hw/m68k/q800.h |  3 +++
>   2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 3730b30dd1..d0ceb64b70 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
>   
>   static void q800_machine_init(MachineState *machine)
>   {
> -    M68kCPU *cpu = NULL;
> +    Q800MachineState *m = Q800_MACHINE(machine);
>       int linux_boot;
>       int32_t kernel_size;
>       uint64_t elf_entry;
> @@ -407,8 +407,9 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu, machine->cpu_type);
> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
> +    qemu_register_reset(main_cpu_reset, &m->cpu);
>   
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> @@ -430,7 +431,8 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* IRQ Glue */
>       glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>   
>       /* VIA 1 */
> @@ -605,7 +607,7 @@ static void q800_machine_init(MachineState *machine)
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>   
> -    cs = CPU(cpu);
> +    cs = CPU(&m->cpu);
>       if (linux_boot) {
>           uint64_t high;
>           void *param_blob, *param_ptr, *param_rng_seed;
> @@ -735,6 +737,11 @@ static GlobalProperty hw_compat_q800[] = {
>   };
>   static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
>   
> +static const char *q800_machine_valid_cpu_types[] = {
> +    M68K_CPU_TYPE_NAME("m68040"),
> +    NULL
> +};
> +
>   static void q800_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -742,6 +749,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>       mc->desc = "Macintosh Quadra 800";
>       mc->init = q800_machine_init;
>       mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
> +    mc->valid_cpu_types = q800_machine_valid_cpu_types;
>       mc->max_cpus = 1;
>       mc->block_default_type = IF_SCSI;
>       mc->default_ram_id = "m68k_mac.ram";
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index f3bc17aa1b..4cb1a51dfe 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -25,6 +25,7 @@
>   
>   #include "hw/boards.h"
>   #include "qom/object.h"
> +#include "target/m68k/cpu-qom.h"
>   
>   /*
>    * The main Q800 machine
> @@ -32,6 +33,8 @@
>   
>   struct Q800MachineState {
>       MachineState parent_obj;
> +
> +    M68kCPU cpu;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


