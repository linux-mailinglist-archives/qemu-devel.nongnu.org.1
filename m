Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CB747EA8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 09:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxM3-0004Mb-1r; Wed, 05 Jul 2023 03:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qGxM1-0004ML-49
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:55:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qGxLx-0003DC-3a
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:55:12 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mirb8-1plDUy1tum-00esOi; Wed, 05 Jul 2023 09:55:04 +0200
Message-ID: <d55d0e70-9280-c55f-22e2-64e78b5ca89d@vivier.eu>
Date: Wed, 5 Jul 2023 09:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/21] q800: allow accesses to RAM area even if less
 memory is available
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-7-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230702154838.722809-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PgOenGMVuaL0jFWEFkYr07+/b6XQdoSREaTSx+7tXyS1A0I6JgJ
 MS/o/qgKOqe91nkFIU45eL9thwFTUETj7htouboiKbTImX0CIiShoq/TYmPBnNP5Tc9bmrV
 BBXwn43AVvCWTlFzo52wWhkV3Tx8gkNnQS8Z39WQHQZYv5M5Z6i/pLueuywDLNhdINrZs1h
 1mH2HNQWhW/JcvvTrZfSw==
UI-OutboundReport: notjunk:1;M01:P0:GWNr8dc+/U4=;ftJP7SNpgB+yeG6E36V1PoAua4F
 RxGNktL5J9VMw6ueLvSf+Zq3XXE4eMkO4BMjTuC6x6gpf27BEsakpG6ToCEQdCZGeiU19qiKL
 UAVNc7iXPU/AzwVT8piOPrnKF/oWw/kaz3/91l3YrzkGpARewiI55iwwCi7yjVAJZtibgeuKW
 iJfPYAoBEug8gf1b0hhh7JswQlsi+2h2bRY5ETpgQWhRORqf849D1zRH9tlsiMAl1KpmGBTCC
 IqgyOvkYmlUkwRBLGpDOdJjWISTEwsbMo7pX5XDg+TdqHTd0YZ6xXWzO1kZ39f/BrMkeCrX37
 aUtRVCZnuh0jjoyqtbR9DZazvmcCJ9uZI+VQjRQN/+lCZ56b7h+ggP5t17QMqWlVvpcdgKVac
 5WnJrUsxv4OcQDDJlhDeoQWjyFx5WCmrket8U5KFMWT+574CsweSH/mk4Nbrr9Tng6rNUbLji
 jeqqFHbZ0FNMShMD+GCcv0X1ihe+LUEGXRdlMV3TByAl1jG9IYjMeLCruNNWdBGQzdXxL6Bbt
 hJ2JDN6I5et7inZe58vJV7y1PUoPM8Lp2GloHHdForp/YTA4p++uTpDfuQv7Q1R4q/rjaP+Ry
 VGfm703yjnNzCxZPwzgG1VOl349xWHYGrCAYO5dcsvBtT9ccSG934ELAKnVu/p11uYxCgDCBS
 1VSk377MRB7EMNFz9tReQfrkmD9KrXScFO6joA2Qaw==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Le 02/07/2023 à 17:48, Mark Cave-Ayland a écrit :
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
> index 081b95e9cf..3209309173 100644
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
> @@ -218,6 +221,27 @@ static const MemoryRegionOps machine_id_ops = {
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
> @@ -262,7 +286,11 @@ static void q800_machine_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, &m->cpu);
>   
>       /* RAM */
> -    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +    memory_region_init_io(&m->ramio, OBJECT(machine), &ramio_ops, &m->ramio,
> +                          "ram", RAM_SIZE);
> +    memory_region_add_subregion(get_system_memory(), 0x0, &m->ramio);
> +
> +    memory_region_add_subregion(&m->ramio, 0, machine->ram);
>   
>       /*
>        * Create container for all IO devices
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 98097165d9..04e4e0bce3 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -60,6 +60,7 @@ struct Q800MachineState {
>       MacfbNubusState macfb;
>       DJMEMCState djmemc;
>       IOSBState iosb;
> +    MemoryRegion ramio;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>       MemoryRegion machine_id;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

