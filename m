Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86016715CDE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:19:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xNQ-0005W3-Ru; Tue, 30 May 2023 07:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xNM-0005VT-HZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:18:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xNK-00043u-Tx
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:18:52 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7bJ5-1q0MKq0GvF-0081Fr; Tue, 30 May 2023 13:18:49 +0200
Message-ID: <af34be69-e7e6-ebb9-8226-741dcad54278@vivier.eu>
Date: Tue, 30 May 2023 13:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/30] q800: move CPU object into Q800MachineState
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-5-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3bHt5I4518b+UbziHZeDDRstAyMkDuK2TjRb8NQ0+u+xUotLBVM
 LF4Lu9fhLhuxTVZUS9miHYAVPvYnNhcsACkN36BPc+CKsENtuOhvgfDGzoNBxYW++S9UDYz
 4ibJzeDdQVeProSBF/yhcVUXdADRFZXNORcFL9uWx7P5BSf2xlz6+aNCXbxqFpAby5XAfy4
 yrhsIiNIePqFXs5HRTE2w==
UI-OutboundReport: notjunk:1;M01:P0:v3fbBRjjHb4=;5OUFkA+Ktx3bliQivy5G5hnjoQt
 L7GtMgvicvhWKhciRoZy7DF2fo14P5hCsvajoRE1QOEApUN9OAlrILF9StA5LD6mcrQXshu17
 vn4uCoMEtZM/jPY51zzXGXWjePVnOXr0IlPNcP7D0UnAoh7lptVgfNf/2P7/K+kbarzvbJkot
 pdzZkYZf/VgXrp63qG51rhVPgX3imaYe9PxAFVseOmbSPAahIMSPFmqVd8vECbvuMYD6RvqPK
 6A0BBK0DCGvXnxslN5ULbIPRI1EDntBGu88G5d2cjYnzluD/dy2tZS7nvhqivPZeSiqvgYRO4
 mKxA5ViGxtot42BN6bLSyuKQy+SXCqPju7AsRsuVDgrCyIfgGp9EjkLoBw3cfMopTyVa9XNBf
 +i4nQFQmVrCsf/DBGokZT5tdITSs32smPQWe/xYGCtxzKIsSSWbwSpbbETqNHnup8r2Hjy9v4
 9MN+1PTGxFuYiS+57wiwa8fhGW11U9d7c1rdWrVOuigwqc/gNv5ig2bFiQXnwiba1FhK9f2Uo
 uDzvA3IDFUgXC6Dz46PAghsNFEtNJfvPA6V/8J/oG6bA7UX/I2i72mR76Aur7x1/jom4/3A1N
 uRcG3BPD5cMA7UTMgc6QEKW58edsWeio/SeOtNaLrarmLRalzu7zkS0/DMEd5r89/mWlUp4rM
 kvo/oOSGxf6oxNMh++ugwMmZhur/pC9CcSU3QUczyA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 10 +++++-----
>   include/hw/m68k/q800.h |  4 +++-
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 976da06231..ee6175ceb4 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -363,7 +363,7 @@ static uint8_t fake_mac_rom[] = {
>   
>   static void q800_machine_init(MachineState *machine)
>   {
> -    M68kCPU *cpu = NULL;
> +    Q800MachineState *m = Q800_MACHINE(machine);
>       int linux_boot;
>       int32_t kernel_size;
>       uint64_t elf_entry;
> @@ -406,8 +406,8 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    m->cpu = M68K_CPU(cpu_create(machine->cpu_type));
> +    qemu_register_reset(main_cpu_reset, m->cpu);
>   
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> @@ -429,7 +429,7 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* IRQ Glue */
>       glue = qdev_new(TYPE_GLUE);
> -    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
> +    object_property_set_link(OBJECT(glue), "cpu", OBJECT(m->cpu), &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
>   
>       /* VIA 1 */
> @@ -604,7 +604,7 @@ static void q800_machine_init(MachineState *machine)
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
>   
> -    cs = CPU(cpu);
> +    cs = CPU(m->cpu);
>       if (linux_boot) {
>           uint64_t high;
>           void *param_blob, *param_ptr, *param_rng_seed;
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 560fd6f93d..5867c3ae33 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -29,9 +29,11 @@
>   
>   struct Q800MachineState {
>       MachineState parent_obj;
> +
> +    M68kCPU *cpu;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
> -OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, q800, Q800_MACHINE, MachineState)
> +OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)
>   
>   #endif

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


