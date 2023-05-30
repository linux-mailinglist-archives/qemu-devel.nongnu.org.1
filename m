Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145E715D10
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:24:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xS1-0000Ct-07; Tue, 30 May 2023 07:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xRy-0000Cb-L8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:23:38 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xRx-0005wB-0N
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:23:38 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mw9Hm-1qKFJR27Nc-00s7ui; Tue, 30 May 2023 13:23:33 +0200
Message-ID: <7da67b1d-1723-1f9e-107d-937c2de60050@vivier.eu>
Date: Tue, 30 May 2023 13:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/30] q800: introduce mac-io container memory region
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-8-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/h/VqdbNnXxM3tB3YwQsd9numVisYKNBOWcHe5ZsCAz5bFnFMMp
 /AIjtd+yDcTWf1WcpGRbkvduO64V+d5bKdeK1uJMSJzTCUosU/jH584Hn4XnFPwk/qg+DUG
 QbeeCF6CL8sA+JVNcDfUtQoJFq1oF+9J/6LFG45m5CxAzrKrZVdmJ1Ymm7Abe9WQ4qxOngW
 6k+6w7t3OIDNKwvJxIFyA==
UI-OutboundReport: notjunk:1;M01:P0:NB9vMFTgRz8=;TWQ4kIhHdGu6AAIZ7gQh7zYI5l1
 XNMnoe6t+9pGE9mv5VtMhccODk+R+xYiUD/Em29kPuVal9KvV3PzgJgU/P9/m3fEqzOzV/sRl
 YtxYi26Pu7puIx2dhfc8e0S4sdVHJqW2x3DOxNC+XaQ+dXsl+tDhrOTd7oM3Ii9tc1o3oMsMo
 yUsQGSMWs+VEjiyFUAvuPde9qmiPbIWYfqqD2xOmZR1AkzsIpWDcgfJDgk8ot1tDiY03HXvkd
 7a1ADIgyVMDf7gimMG39LHsLmu8ybtvDOCakgHBwCMZy/bYoBii9PdKNiSE2M/Hd6nFWBo8wR
 QHlz9UWIBb0gOYWG/S95dErE6adNL038klI/8kVyTAuv1AoETzziH6SlYrAu376/5HtHIjZWR
 iQoQ7z1PYPcblSuFEMp+7EwmtouHmEiPTATIAXQU4U/Z6MNUK3LDq2hZIesk55QUGeMLVfWQM
 MBEQlIdpb+fl0ir9xQO8L3u0BH2pSprTwGnaabtI3mychXWVzYoXu186Trn/ZTuSH+iaLAvt4
 cBKxzbmIK24ubF6DCToxyqWNB9kYZNM/d8SzQh8QIGdbiQ1KJY6EgMqa5GtQbvYrbkFB+z+vJ
 V/FZdA2EYV/My2+Bat4EqbWnf7r4cvGDeONj0v+TYJeRD/WFd7p+kPwXcK4wZ1/uC/pDSYAcv
 wzSBVWfsz23LfZXjJ+6XaiO3Uo1S/PmVYArha8qDJA==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
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
> index c22a98d616..6399631ed0 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -410,6 +410,12 @@ static void q800_machine_init(MachineState *machine)
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>   
> +    /*
> +     * Create container for all IO devices
> +     */
> +    memory_region_init(&m->macio, NULL, "mac-io", IO_SLICE);
> +    memory_region_add_subregion(get_system_memory(), IO_BASE, &m->macio);
> +
>       /*
>        * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
>        * from IO_BASE + IO_SLICE to IO_BASE + IO_SIZE
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index de02af53be..156872a124 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -33,6 +33,7 @@ struct Q800MachineState {
>       M68kCPU *cpu;
>       MemoryRegion rom;
>       DeviceState *glue;
> +    MemoryRegion macio;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


