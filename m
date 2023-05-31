Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F9718B6C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Shz-0003H0-60; Wed, 31 May 2023 16:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4Shw-0003Fm-80
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:46:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q4Shs-0005bG-Uc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:46:11 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6t3Z-1q91s00JiB-018GRt; Wed, 31 May 2023 22:46:07 +0200
Message-ID: <3872e933-449a-1e9d-e978-7a94717dcac2@vivier.eu>
Date: Wed, 31 May 2023 22:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 20/23] q800: don't access Nubus bus directly from the
 mac-nubus-bridge device
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-21-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230531125400.288917-21-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YSAI1cM8qNO8O6A4lqPt+efRp+iHpyduq1SWwKcgcgGF9IsCNIt
 AMfAAHk7yI5L2hBmHw3c9msEBPbDp8vHAR7rCaA0gy8utv83B0RQMRzrA/UFtyJAOPCQ8qv
 BtR5zJ7sijSfo9ZCLsjKqOzzS8uy+Kn/y3XlvPTKDxNzkMSj180x/a4uYe3YkZyRaSFy/hM
 bMl9v2OE2gZaHPyHB+QUA==
UI-OutboundReport: notjunk:1;M01:P0:UIx9V/XMsmM=;QaPGYpqpIzSVUitQB6PBsxDDXsG
 f3X8dmS7fh5ZkCahLz40ankCRhgCXs4m6U0PPRPNmOY4vuvh3ibPIpN8O/27zCR9x6j/6yOs6
 4bZI59EBVxGa6FQL2n4/oJGQaqMxwenEfZ2Gtkg3BC4fNx8J39ktC/dLOWHQE1gSHIWi0WSHx
 DYfai5nijzJl4iVGQF/AgWJVJh7f10pHVLuDbKKcThUfYZrrdAu4QdtU0oy4nmfFkqHHtEj6n
 wc1nu9vPNaHdgFsCdYgItuy3K9unQcaxfjDltlYG0unG7e2Yn3I9vdp4kbE4O4DKDHh8Kqy/k
 rvle3SCqGMU7aMYUhu09GCdc996yJo/fM4ftakWsn+YHgCxp03EQPbkvTGg0OI9sH0c4dVruA
 tVQldNe7SssRcpZH2J15yl6dfe4Lpyb8PsnzzgYI7fWMFtd9cnfV4m6Py6XErzMrMDbaFVWNi
 o7xKLIl+Dreft1Ag9RU4AqtqkRrisMPO079CjXYDceDdHeCHfWQUBBfwFSP5ed61wMfqZNqzu
 8DcC6FyD1IHsUN2FNfKlYKVdVvoEYzj++ClqkGwA0QsEozTRVwFEraGi0bzSqm6iR4Dqrngsy
 ncYA5EQhVIZAgCa4B1rW8D+jSe0CJuCoLh7+m9uX8FJTdwLT4t0EAxFamFLsE1ZkcgmDXVbN5
 lWDsYMiD2rfDg34YxEGAvzDq117xMDvyp5L2QeIgfA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

Le 31/05/2023 à 14:53, Mark Cave-Ayland a écrit :
> Instead use the qdev_get_child_bus() function which is intended for this exact
> purpose.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index d02a1a7a1f..946cb09e30 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -445,7 +445,7 @@ static void q800_machine_init(MachineState *machine)
>                             qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
>                                                    VIA2_NUBUS_IRQ_9));
>   
> -    nubus = &NUBUS_BRIDGE(dev)->bus;
> +    nubus = NUBUS_BUS(qdev_get_child_bus(dev, "nubus-bus.0"));
>   
>       /* framebuffer in nubus slot #9 */
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


