Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71867AE731
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2u4-0003P7-3f; Tue, 26 Sep 2023 03:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2u2-0003Oh-Bu
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:54:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2tz-00062K-EK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:54:42 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mv2pC-1rbm4y3cTw-00r3IX; Tue, 26 Sep 2023 09:54:37 +0200
Message-ID: <c611c374-88e6-c360-c521-8503ed790537@vivier.eu>
Date: Tue, 26 Sep 2023 09:54:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/20] q800: add easc bool machine class property to
 switch between ASC and EASC
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-11-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U/sjCsL50W8kE9hj7oOTlWIWfs6mf3iQGazRQBfmwV4hbdMJYS1
 fE6o7+4X3WIyPyRRnz5OzpakWkiPrCBGAin/k8GhThFt5TFOdlxDj8kCv8ZXsX3WvQXELZs
 dg/tMtqueqdt9xjqRHIH+AUqpmGAOL00bMvs4Wyh2vgAy+QttSJoUOWTLP6cE1wmyM6A5wN
 UYrQHVqLIYy+gNwaR1D8w==
UI-OutboundReport: notjunk:1;M01:P0:zJGKdE7HsZE=;pCFyrhw4KfdX1FegoUv8rWAZSWj
 gWaN7kWS377/+MhhO8fbRcxDpaTPAQvayOrmhX5TsT3wWnex7JQ7qRC6R25KRmfnhsLcroEs2
 Xm93e8a3+EPpB20y88iAQBxbDG3LzIsJwb23yaUqRehUw4BckaREDdhFgaBWp9VEmsQGY4pHA
 2zwYpFlv8DyMuWVpxZ2fkBjt6bP/SS9dgWspipahhNjIgPPFma/W9niUrDbN1PBYndyO1xbi8
 8mUvkIPofdoK5ZoMqCOOtLj6IduAz326VrPUZ0Ru79shh3+TwSsO/NxXVai9xO3CNOPHqiktU
 HbqynIfyjDdi0KiCv1I+PS/ih2a0jYCgJzgYj9tNeWxtNI/+VT91+/nC6iQ1qyJ6dX+7/0oFi
 zB1oGOotG7/JGKEFjwpbWHoDThFrErqlKKJiVr68uJ9qzQO/mHgfefWvnX+RdUvtB1snUpV17
 cdR5iSAt1rBIaCVeJmL7VauBp/8oBd7vO5vh24SkHr9AW1ipKGCV977CBKBHXJ8jIMGZuCc+v
 Tl76TXBDJk6rtMR/IWKqYF1O9WUKG6bbgPVjBE2EagjGVZRsGxQc/WtcG1yYiyISeTkUeAitX
 tdLbMTTQWS9q6fsk52n9Qr9XJ7UDxMtOof388n5u+Y33S0aMuvmZWIdETi1pQhE8jjzgVv0SJ
 BZSfGwimltxQQKhLrugVEZ9hIaDRDHwXyruBfVUmBcdSzQFYq6bZ8YEbgJEKlg8y8Wht+dhtj
 uqDD9pAF1Yqoj2WCHXgd7tYNK/GCldV5I/sZsJb6P5pXvvNaarN+3AHwat1kqSx6O4RGv3iZS
 xDuQniQ1YTXoSqnxzjAb716xnXnuATu4dqknUP4Q/RSMhv/srDiYNchJ/wpY2rr1bBWCxT6/v
 2+LvSikDe3sYwsQ==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
> (default) or to original mode. The real Q800 hardware used an EASC chip however
> a lot of older software only works with the older ASC chip.
> 
> Adding this as a machine parameter allows QEMU to be used as an developer aid
> for testing and migrating code from ASC to EASC.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ae07aa20ff..5ae7c37760 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -484,7 +484,8 @@ static void q800_machine_init(MachineState *machine)
>       /* Apple Sound Chip */
>   
>       object_initialize_child(OBJECT(machine), "asc", &m->asc, TYPE_ASC);
> -    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", ASC_TYPE_EASC);
> +    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", m->easc ? ASC_TYPE_EASC
> +                                                            : ASC_TYPE_ASC);
>       sysbus = SYS_BUS_DEVICE(&m->asc);
>       sysbus_realize_and_unref(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
> @@ -674,6 +675,28 @@ static void q800_machine_init(MachineState *machine)
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
> @@ -706,11 +729,16 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
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
> index 790cf433f3..fbaacd88bd 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -47,6 +47,7 @@
>   struct Q800MachineState {
>       MachineState parent_obj;
>   
> +    bool easc;
>       M68kCPU cpu;
>       MemoryRegion rom;
>       GLUEState glue;

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


