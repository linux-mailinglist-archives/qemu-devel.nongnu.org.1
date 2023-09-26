Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEA7AE763
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql35w-0002Ic-Qo; Tue, 26 Sep 2023 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql35o-0002Eo-V3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:52 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql35Z-0008Lx-Oh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:52 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mgefy-1rJ0Oe1AEO-00h5pv; Tue, 26 Sep 2023 10:06:36 +0200
Message-ID: <94d3329e-f1fa-e0b9-2cf6-5dd0d8d89877@vivier.eu>
Date: Tue, 26 Sep 2023 10:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 18/20] q800: add ESCC alias at 0xc000
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-19-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E5JlZTQp3zr50+669wurSF2xjtdg2lsBhG1OOem+8CeSlwTvbv4
 5G3zSzQc4Yqu+vfB3ib8+nLhiZyjYRK3xjaJHKb00FU/iyBycGX8BrdthiWWHpBsvYgSRMV
 Qfa5P3axT1bC8u4s3E+91ANGwh4svDI7sbLQUAPHjFrEY6f/5yLnIwwJduToAfGjxdCqFZv
 CTSe13kNha+LAnZVjzNAA==
UI-OutboundReport: notjunk:1;M01:P0:/O1FPkiqtf8=;x7mQcmvQeYE55kU/xIaU5XEK+7f
 F3EdlpLuWouyBSs0u6YTzELHkW7pv04K+DqpM6fLIrw7TUz3RU7gYc4S6oOgIDSzkHUTPCIlu
 ZHLItgya2s/Yb5sHV84n2idZatz8hoVFk2tY/yt9nleC9b6VQ6IeAYMKLIWP9+j1eZ76c3/VY
 di8NhMTGPfudpSRiBesHvPO7Fll5Tc6S29BSwiG84w6Vr+k1YxDEbCUEJ4QIXf9mYisye50bS
 vnHUUGjsEuwL365Q3nvKCEUZJfKBq3JEbfrJSdGvATZ2RY97iTzNXpdnPmXkqMJ4bWEMsE7h+
 QL4t7HsEv4q06YiPj3GbvhkHAJZZveEUDyvMB9m8mk1LjGAbdPaIDNjLx3exX3QgEMWSRz5o/
 hdoECM9I2brwcAYbTb54/2xidldjkMSJnykFriZWwunSCL0+k4V5cCjda9/avU5EXHyePuwrH
 PjILzb7AbaVqR3Cco+5pe7Na3XfYz8p/1fwUIeQ+gCZ+BXAKUP5bl+uME2sCMCVPeqqMzjVF6
 vSQkt1EL536AhTfjjU8J1/9n4yqs45fzFIBKbpUb4QDj+v7jiDUwro//XY0DNW1/ZvU7zzWNp
 teJdP/wygNTssy+42kX4KKVqEfcA7zMWfwXkBLUmMH7GdtCsMZ6FI/iWo18U4dMZgx07Sz+Tw
 8PJqzR/jweHI5rx+oLjSn/2r2tSWP3YNRQ4L/pKH2gl2m3KurnC6nO0C1YNfrw4RoQ3SbzlWt
 90+YBcuXKrZKsFwIHWvJqsSgYgkaKZCo7fFk2URu6ckKZC/a9sHQhbIL4X6KomPt6T3fnPG4q
 vUuIYIoXNY9j86QT0RMLPbXprdi8zZ+oS2v/Vbs74jqiegxq+GGLyAxuURDCwI1KWmpGhh8er
 hlKj1rauKtR2cQA==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> Tests on real Q800 hardware show that the ESCC is addressable at multiple locations
> within the ESCC memory region - at least 0xc000, 0xc020 (as expected by the MacOS
> toolbox ROM) and 0xc040.
> 
> All released NetBSD kernels before 10 use the 0xc000 address which causes a fatal
> error when running the MacOS booter. Add a single memory region alias at 0xc000
> to enable NetBSD kernels to start booting under QEMU.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++++
>   include/hw/m68k/q800.h | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 5ae7c37760..b5b2cabc33 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -451,6 +451,12 @@ static void q800_machine_init(MachineState *machine)
>       memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE,
>                                   sysbus_mmio_get_region(sysbus, 0));
>   
> +    /* Create alias for NetBSD */
> +    memory_region_init_alias(&m->escc_alias, OBJECT(machine), "escc-alias",
> +                             sysbus_mmio_get_region(sysbus, 0), 0, 0x8);
> +    memory_region_add_subregion(&m->macio, SCC_BASE - IO_BASE - 0x20,
> +                                &m->escc_alias);
> +
>       /* SCSI */
>   
>       object_initialize_child(OBJECT(machine), "esp", &m->esp,
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index fbaacd88bd..348eaf4703 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -67,6 +67,7 @@ struct Q800MachineState {
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>       MemoryRegion machine_id;
> +    MemoryRegion escc_alias;
>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


