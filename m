Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE08715D27
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xUY-0001nA-SL; Tue, 30 May 2023 07:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xUV-0001lX-Ny
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:26:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xUF-00077S-JI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:26:14 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N7hrw-1q8io53wH4-014h6m; Tue, 30 May 2023 13:25:56 +0200
Message-ID: <44c06980-c8c6-a114-7507-555ee43bdc56@vivier.eu>
Date: Tue, 30 May 2023 13:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 13/30] q800: allow accesses to RAM area even if less
 memory is available
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-14-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jh4ZZ5AJMe9m8+LX4KYvaSx8wZEj0FuGXTvf15FrvyYYLq2ieI7
 pK8n62TPn8bkWw86lKewT+2iUdY86Z8XIN/mr9RBfG7TkNVQTpJ6ImWNK++bYHdIuPBnyw6
 6oXJP6zz9hUitCkpDvSIO22J4UddkLu3EfByX/R9KVwkhf38T4iDVcmwQUfmrGkpP6dXDQR
 yMI1T+P7X0x9YS5RyhVbw==
UI-OutboundReport: notjunk:1;M01:P0:Fl0mylS3cis=;fd7UGLK2Bh6mraLSJJO79UiKrwZ
 ioP1RVR06mMZ5eOMroewyTEXNbFE4w4kfHnT+Gx/EPK4X+FnnYzofnZWpFeB+VhM9rWL0OuZi
 Y9GDV/31IHcJjvRFABaWvEl3Jyi7KC03LpsfCZnW78k997l/iL7pWzfpMexihipBOJAbTa88T
 q9nr1ppVAxTJtGWYHvj56UhKilh/HsFuceCTiai8wN0KK1ZhpyHMmhiAptw6cV57wU6hn4QVl
 2thh20w5FhyD5wxWKVZyoX5EMp5SiFNOEQazLO7ks6o+JwKF3280kdh+YQZMi/N7x0dgDn0IC
 H+QEsM+NmmaZhy4SFNp7qIe38qbMgROmrQ5PRZPSzNt/kbL47xmcK/R0Tr6DxbvMGl0B4SBwL
 IGEq77cOBRt/rnrF0ZNP9EbTXTqNoqOKd1dWJbSVL6H19lVp/dI2rnnlczLbnr6oBJO4h72i/
 eufrTeLxdC1HZpeyquvVlcBMW8XpgfedyNtLjbc7uRwCtYOaneFYUlcv8VX2XFVN6FcpMVBhr
 6LcU+B3DQ13EJc3Jsd+0HgPOlQgUEaD4Q9kXxXN7Ng3I2lqAyhy6swj17UvqUDyfAnk6j7NsA
 qdLXS80gzMZEs2nEIESw89GW5dxzHLv/mAiG2phcAFdRfHyNUUuRDTxHK/bdjd6LY9KuaiswQ
 8a/KUiq/ukjJNYe7qaYOCcxe47CLzexbOuox+3IDTQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
> MacOS attempts a series of writes and reads over the entire RAM area in order
> to determine the amount of RAM within the machine. Allow accesses to the
> entire RAM area ignoring writes and always reading zero for areas where there
> is no physical RAM installed to allow MacOS to detect the memory size without
> faulting.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 8310670ec2..d12aeaa20e 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -86,6 +86,9 @@
>   
>   #define MAC_CLOCK  3686418
>   
> +/* Size of whole RAM area */
> +#define RAM_SIZE              0x40000000
> +
>   /*
>    * Slot 0x9 is reserved for use by the in-built framebuffer whilst only
>    * slots 0xc, 0xd and 0xe physically exist on the Quadra 800
> @@ -452,6 +455,27 @@ static const MemoryRegionOps machine_id_ops = {
>       },
>   };
>   
> +static uint64_t ramio_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0x0;
> +}
> +
> +static void ramio_write(void *opaque, hwaddr addr, uint64_t val,
> +                        unsigned size)
> +{
> +    return;
> +}
> +
> +static const MemoryRegionOps ramio_ops = {
> +    .read = ramio_read,
> +    .write = ramio_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
>   static void q800_machine_init(MachineState *machine)
>   {
>       Q800MachineState *m = Q800_MACHINE(machine);
> @@ -497,7 +521,11 @@ static void q800_machine_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, m->cpu);
>   
>       /* RAM */
> -    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +    memory_region_init_io(&m->ramio, NULL, &ramio_ops, &m->ramio,
> +                          "ram", RAM_SIZE);
> +    memory_region_add_subregion(get_system_memory(), 0x0, &m->ramio);
> +
> +    memory_region_add_subregion(&m->ramio, 0, machine->ram);
>   
>       /*
>        * Create container for all IO devices
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index e57aec849a..0602d07d3d 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -34,6 +34,7 @@ struct Q800MachineState {
>       MemoryRegion rom;
>       DeviceState *glue;
>       DeviceState *djmemc;
> +    MemoryRegion ramio;
>   
>       MemoryRegion macio;
>       MemoryRegion macio_alias;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


