Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C8715D36
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xWv-0004A6-3K; Tue, 30 May 2023 07:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xWp-00049n-08
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:28:39 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xWn-0000RB-Av
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:28:38 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MKKlN-1pnedI1LX5-00Lr0G; Tue, 30 May 2023 13:28:35 +0200
Message-ID: <7f5b87e3-48ee-c4a7-719e-31a8d1c6e281@vivier.eu>
Date: Tue, 30 May 2023 13:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 17/30] q800: add easc bool machine class property to
 switch between ASC and EASC
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-18-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-18-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:akdFrm1kujsbw0mA2kKTjoFNmPGVoOF7qnK0Hw1RPriGwIRYqJ+
 hb8RS/3Y8KXa/vBseGvJ9Pbs4CFeMmYA6qYzClhLTSFtovI4cCxGbd/agzbXzwkxji7bQwJ
 iTQBi2ffVJ2IkP700i04w8fOoLuQ/9MwokojQps+g/7EhH/Qr+v62uuc4gsRNRvLb+28DtF
 K594w1CiSjZruFjfMfC+A==
UI-OutboundReport: notjunk:1;M01:P0:kwzf3FpTrbM=;8D/2sS8gFnAlxyy71swzD2Y5aOh
 mmwuyymGtiiq+Y7XhjA/z8F1Q8s4T0Uf2Dv6cA1RrydvdfT7iGkFjKQ7PWPF7Dy1uY4IYzgcC
 bmxJTmkjSD7E5qayhhF3nRHa/ZzEZRgx5gpohc3O8LUuQw6O9MeV/CVDNtM/qigwmgdLCz4lE
 LxHhk9Gq1KSiJvQvGwQZHcVuSl/xpiKNEgLCcM62Af9350NoayWkvu/D/z2VDffZXeBbi7KaL
 P+Oj4EeNL90R+xVMo61DiS86Q3NGeshSYMY6/iK1xzZ0ayCgnUbtI5ZdVhXu9ERSi7UP/JHPE
 zOuPZgasyyWUbq7nboZJ/8HlJMZnrltY26BlmCD6AXRiTia1XNQhAkovwvMdNqxLzGiHyJJ4S
 RIiKeNy0zsU4TzjZWpSdGk0XoWDkfmRd6Boex/RzKUuAzx8gEqHtfIKhdSdzU6F7/RfGcmPyd
 1DBlQIg5QRZW3ncGCIYxaLZTHFPLrT+cCmX1Sb41czWj0i0gCcZWCZ1g3gNRMY5erRpkHTw/M
 1ZQVkaIWwWBsuCcV/BVngNZTuGZit0Q5iWtbumt99ZhICnCiFeAK8hfp0bhAx4hnpn3TPy9ll
 vk9WhBkwYizmNTwt7nOoLImuG0aabuTbfhxtomJgAF95agibT8UES6yrgt+6HQmontnmgyRnW
 +pnYKdPWU9yAiKz8IANnUgBrXtWcQ3Bq7lNHKJRg5w==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
> (default) or to original mode. The real Q800 hardware used an EASC chip however
> a lot of older software only works with the older ASC chip.
> 
> Adding this as a machine parameter allows QEMU to be used as an developer aid
> for testing and migrating code from ASC to EASC.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ed862f9e9d..1af1a06f64 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -710,7 +710,8 @@ static void q800_machine_init(MachineState *machine)
>       /* Apple Sound Chip */
>   
>       dev = qdev_new(TYPE_ASC);
> -    qdev_prop_set_uint8(dev, "asctype", ASC_TYPE_EASC);
> +    qdev_prop_set_uint8(dev, "asctype", m->easc ? ASC_TYPE_EASC
> +                                                : ASC_TYPE_ASC);
>       sysbus = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
> @@ -886,6 +887,28 @@ static void q800_machine_init(MachineState *machine)
>       }
>   }
>   
> +static bool q800_get_easc(Object *obj, Error **errp)
> +{
> +    Q800MachineState *ms = Q800_MACHINE(obj);
> +
> +    return ms->easc;
> +}
> +
> +static void q800_set_easc(Object *obj, bool value, Error **errp)
> +{
> +    Q800MachineState *ms = Q800_MACHINE(obj);
> +
> +    ms->easc = value;
> +}
> +
> +static void q800_init(Object *obj)
> +{
> +    Q800MachineState *ms = Q800_MACHINE(obj);
> +
> +    /* Default to EASC */
> +    ms->easc = true;
> +}
> +
>   static GlobalProperty hw_compat_q800[] = {
>       { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
>       { "scsi-hd", "vendor", " SEAGATE" },
> @@ -912,11 +935,16 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_SCSI;
>       mc->default_ram_id = "m68k_mac.ram";
>       compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
> +
> +    object_class_property_add_bool(oc, "easc", q800_get_easc, q800_set_easc);
> +    object_class_property_set_description(oc, "easc",
> +        "Set to off to use ASC rather than EASC");
>   }
>   
>   static const TypeInfo q800_machine_typeinfo = {
>       .name       = MACHINE_TYPE_NAME("q800"),
>       .parent     = TYPE_MACHINE,
> +    .instance_init = q800_init,
>       .instance_size = sizeof(Q800MachineState),
>       .class_init = q800_machine_class_init,
>   };
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 0602d07d3d..0144be5e6e 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -30,6 +30,7 @@
>   struct Q800MachineState {
>       MachineState parent_obj;
>   
> +    bool easc;
>       M68kCPU *cpu;
>       MemoryRegion rom;
>       DeviceState *glue;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


