Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13005718B28
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SQT-0004av-9L; Wed, 31 May 2023 16:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SQO-0004a0-G2
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4SQM-0001Zg-JN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:28:04 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAwTn-1pxXTs0yoT-00BNVH; Wed, 31 May 2023 22:28:01 +0200
Message-ID: <6445c607-29cd-c2cd-24b1-e2f6acbe97b6@vivier.eu>
Date: Wed, 31 May 2023 22:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/23] q800: introduce mac-io container memory region
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-10-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lAk0/ZUq38fteDyNbCPGWrtQ7VrONbhzhMNqBEkiT9iiEaEouPu
 Osq0Uc5YgcOJRrPUizqh5lxnIKmIwPLhXrCkUIT5fCFC5ASoOP26Ak1Yk1HUqbefvacQYdn
 J5LNlVybfnIEW1IzfjYPUuOLi5fJDG07uwkOfvG5VarDowVjU1qwmcu2BdB2x2CTgXI3Ndb
 jydBR9nCt7IpZMsNJ8acQ==
UI-OutboundReport: notjunk:1;M01:P0:9KheiRqfCiA=;1R6wWdIRLi5YFwTrMdwztogw/yj
 7PebWVc+K3f8Bc9ACZGBtUfs9j30X292lZSXTpOo3Q5qMsEw5rJsCCA7FoPH1S4xlUr2LYhOy
 CTz33LcThSr+DJYPfpgB4vQ1CvLWixPjtBjGEOMMe4vM0TpC/jWyoF7VqWDqwZPDWVAD4irak
 9jUhI8Wp2xEE8GEE88IUELcN0P4v3nEimJl0NI9PQ4KrHkdFGoTmgCRdP7Rp3ZST2pNoQLiQ9
 q4gGzQ9mi6ebWYyr7cgdsnxP1ZcmSmm5QOu9PrgfB4oFS//gOEzK/K868/GxFYpueukSb3T9u
 pq2nr3AJN0hgt/ahyZeZUwvdbgXGPR2DaFCTPe6pdnaEoQPmJwoR8+/UswA4mvr8t38I4ET5G
 Unml/aazvogsbTMbOakuU3+oSUKrWAzRFAXaYsHYUK++HDOIozP48owHnhcvjsl/tvyi2EPyz
 obc8HmYv00yfQXnaAhYQNWCf0bhCbPSOo+Hdj97sCivtzqD2gbUysWj0iXgP41RLtUIHf1FPc
 +nz0MM2Fu54i08cxLCjn0clWWnIu/uJBqwqB5xa0cfF0T2UM5yktkNEHaWbFIjZujASujIFNA
 7Zgv8EZXdhGGgMHJUUrNLjNhDO8aWmHVYQfBfumUED7BfHfGFdCOxbcT98wbpgXAQ00MWu23p
 G6pOKFCBj7rC/HJAI/xe6YXuVJgTGwJH4HuxySOuXw==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> Move all devices from the IO region to within the container in preparation
> for updating the IO aliasing mechanism.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++++
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 7bd8e795d2..2394d14c97 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -178,6 +178,12 @@ static void q800_machine_init(MachineState *machine)
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>   
> +    /*
> +     * Create container for all IO devices
> +     */
> +    memory_region_init(&m->macio, OBJECT(machine), "mac-io", IO_SLICE);
> +    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
> +
>       /*
>        * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
>        * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 8e1bb0735d..b9de8e36cd 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -35,6 +35,7 @@ struct Q800MachineState {
>       M68kCPU cpu;
>       MemoryRegion rom;
>       GLUEState glue;
> +    MemoryRegion macio;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


