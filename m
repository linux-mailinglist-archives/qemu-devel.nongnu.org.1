Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF17F988E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:10:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Tsd-0001Ju-8X; Mon, 27 Nov 2023 00:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r7TsU-0001Ee-JQ; Mon, 27 Nov 2023 00:09:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r7TsL-0006A2-Qz; Mon, 27 Nov 2023 00:09:45 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR4uia4002695; Mon, 27 Nov 2023 05:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZvLE9ADJYiL4pwCLo97g62VP3w7FJ5j6SXRL4t7JBzI=;
 b=AxiyD0NIPCqgYVRYsh58bBJFoE5UGegJweEUvmYz58y0Br6Sk2Ggve6e2xK9sIQ3LZ2J
 e0ToZK1yk26KKAiax1f4dO0RUr6jbBSHsUXinFPeHAxrscgGoo/NXFby8wFmRZ2ln6fu
 AnmHUDqjlQtb24RCbPjT1m8lFhxgd+Z/atZlSKIk8o3MieUfgo8cYKQICRfQSgUMpLgf
 ASkiSWl/V8aFZ+mmsEorHUyJsksx3KbikpfH/MYjrnb11wSdvap6d498WsnlqMjWNaI6
 aZAO1zBELedSqVknsLfyX1CJKOAaNLssXZzye+TCUCzhh89KXxF57QwGgP7u6sVgkTTG 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdj4sau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:08:59 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR4rTew017178;
 Mon, 27 Nov 2023 05:08:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umgdj4sad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:08:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AR444mC024294; Mon, 27 Nov 2023 05:08:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1dy71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 05:08:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AR58vCN11665956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 05:08:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A3A45805A;
 Mon, 27 Nov 2023 05:08:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3B2958051;
 Mon, 27 Nov 2023 05:08:45 +0000 (GMT)
Received: from [9.43.20.5] (unknown [9.43.20.5])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 05:08:45 +0000 (GMT)
Message-ID: <4cd6c1a9-af51-f000-0a7b-f28fe80f4c4b@linux.ibm.com>
Date: Mon, 27 Nov 2023 10:38:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-for-9.0 v2 5/8] hw: Prefer qdev_prop_set_bit over
 object_property_set_bool for QDev
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-6-philmd@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20231123143813.42632-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HIE5IxxWWwyUlofRbT60bBTZfrVAqaeJ
X-Proofpoint-GUID: ELl-3t7HMoS9Nnh_VI7sgDFNjSvXJAbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_02,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.477,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 11/23/23 20:08, Philippe Mathieu-Daudé wrote:
> The QOM API is lower level than the QDev one. When an instance is
> QDev and setting the property can not fail (using &error_abort),
> prefer qdev_prop_set_bit() over object_property_set_bool().
> 
> Mechanical transformation using the following coccinelle patch:
> 
>    @@
>    expression o, p, v;
>    @@
>    -            object_property_set_bool(OBJECT(o), p, v, &error_abort)
>    +            qdev_prop_set_bit(DEVICE(o), p, v)
>    @@@@
>    -            object_property_set_bool(o, p, v, &error_abort)
>    +            qdev_prop_set_bit(DEVICE(o), p, v)
> 
> manually adding the missing "hw/qdev-properties.h" header.
> 
> In hw/arm/armsse.c we use the available 'cpudev' instead of 'cpuobj'.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/acpi/cpu_hotplug.c               |  7 +++----
>   hw/acpi/ich9.c                      |  4 ++--
>   hw/acpi/piix4.c                     |  4 ++--
>   hw/arm/armsse.c                     |  3 +--
>   hw/arm/armv7m.c                     |  3 +--
>   hw/arm/aspeed_ast2400.c             |  3 +--
>   hw/arm/aspeed_ast2600.c             |  9 +++------
>   hw/arm/bcm2835_peripherals.c        |  3 +--
>   hw/arm/bcm2836.c                    |  4 ++--
>   hw/arm/boot.c                       |  4 ++--
>   hw/arm/fsl-imx25.c                  |  3 +--
>   hw/arm/fsl-imx31.c                  |  3 +--
>   hw/arm/fsl-imx6.c                   | 12 ++++--------
>   hw/arm/fsl-imx6ul.c                 |  8 ++++----
>   hw/arm/fsl-imx7.c                   | 10 ++++------
>   hw/arm/npcm7xx.c                    |  9 +++------
>   hw/arm/xlnx-versal.c                |  9 +++------
>   hw/arm/xlnx-zynqmp.c                |  9 +++------
>   hw/core/bus.c                       |  2 +-
>   hw/core/qdev.c                      |  2 +-
>   hw/i386/pc_piix.c                   | 19 ++++++-------------
>   hw/microblaze/petalogix_ml605_mmu.c |  5 ++---
>   hw/microblaze/xlnx-zynqmp-pmu.c     | 18 +++++++-----------
>   hw/mips/cps.c                       |  3 +--
>   hw/ppc/e500.c                       |  3 +--
>   hw/ppc/spapr_pci.c                  |  3 +--

For spapr:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   hw/rx/rx-gdbsim.c                   |  4 ++--
>   hw/sparc/sun4m.c                    |  3 +--
>   28 files changed, 64 insertions(+), 105 deletions(-)
> 
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 634bbecb31..1338c037b5 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "qapi/error.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/core/cpu.h"
>   #include "hw/i386/pc.h"
>   #include "hw/pci/pci.h"
> @@ -41,8 +42,7 @@ static void cpu_status_write(void *opaque, hwaddr addr, uint64_t data,
>        */
>       if (addr == 0 && data == 0) {
>           AcpiCpuHotplug *cpus = opaque;
> -        object_property_set_bool(cpus->device, "cpu-hotplug-legacy", false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cpus->device), "cpu-hotplug-legacy", false);
>       }
>   }
>   
> @@ -66,8 +66,7 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
>   
>       cpu_id = k->get_arch_id(cpu);
>       if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
> -        object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(g->device), "cpu-hotplug-legacy", false);
>           return;
>       }
>   
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 25e2c7243e..64b00673fe 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -30,6 +30,7 @@
>   #include "hw/pci/pci.h"
>   #include "migration/vmstate.h"
>   #include "qemu/timer.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/core/cpu.h"
>   #include "sysemu/reset.h"
>   #include "sysemu/runstate.h"
> @@ -197,8 +198,7 @@ static bool vmstate_test_use_cpuhp(void *opaque)
>   static int vmstate_cpuhp_pre_load(void *opaque)
>   {
>       ICH9LPCPMRegs *s = opaque;
> -    Object *obj = OBJECT(s->gpe_cpu.device);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
> +    qdev_prop_set_bit(DEVICE(s->gpe_cpu.device), "cpu-hotplug-legacy", false);
>       return 0;
>   }
>   
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index dd523d2e4c..215929ac6a 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -203,8 +203,8 @@ static bool vmstate_test_use_cpuhp(void *opaque)
>   
>   static int vmstate_cpuhp_pre_load(void *opaque)
>   {
> -    Object *obj = OBJECT(opaque);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
> +    DeviceState *dev = DEVICE(opaque);
> +    qdev_prop_set_bit(dev, "cpu-hotplug-legacy", false);
>       return 0;
>   }
>   
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 4672df180f..546b15e658 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -1022,8 +1022,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
>            * later if necessary.
>            */
>           if (extract32(info->cpuwait_rst, i, 1)) {
> -            object_property_set_bool(cpuobj, "start-powered-off", true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(cpudev, "start-powered-off", true);
>           }
>           if (!s->cpu_fpu[i]) {
>               if (!object_property_set_bool(cpuobj, "vfp", false, errp)) {
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index cbaebe9bf8..3a6d72b0f3 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -328,8 +328,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>       }
> -    object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
> -                             s->start_powered_off, &error_abort);
> +    qdev_prop_set_bit(DEVICE(s->cpu), "start-powered-off", s->start_powered_off);
>   
>       /*
>        * Real M-profile hardware can be configured with a different number of
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index a4334c81b8..4a247bfcbb 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -420,8 +420,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
>   
>       /* Net */
>       for (i = 0; i < sc->macs_num; i++) {
> -        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->ftgmac100[i]), "aspeed", true);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
>               return;
>           }
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index b965fbab5e..5ec8ad73cd 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -317,10 +317,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>   
>           object_property_set_int(OBJECT(&a->cpu[i]), "cntfrq", 1125000000,
>                                   &error_abort);
> -        object_property_set_bool(OBJECT(&a->cpu[i]), "neon", false,
> -                                &error_abort);
> -        object_property_set_bool(OBJECT(&a->cpu[i]), "vfp-d32", false,
> -                                &error_abort);
> +        qdev_prop_set_bit(DEVICE(&a->cpu[i]), "neon", false);
> +        qdev_prop_set_bit(DEVICE(&a->cpu[i]), "vfp-d32", false);
>           object_property_set_link(OBJECT(&a->cpu[i]), "memory",
>                                    OBJECT(s->memory), &error_abort);
>   
> @@ -500,8 +498,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>   
>       /* Net */
>       for (i = 0; i < sc->macs_num; i++) {
> -        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->ftgmac100[i]), "aspeed", true);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
>               return;
>           }
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 0233038b95..c07ca8817b 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -303,8 +303,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>                                &error_abort);
>       object_property_set_uint(OBJECT(&s->sdhci), "capareg",
>                                BCM2835_SDHC_CAPAREG, &error_abort);
> -    object_property_set_bool(OBJECT(&s->sdhci), "pending-insert-quirk", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->sdhci), "pending-insert-quirk", true);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
>           return;
>       }
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index b0674a22a6..1fdc3be6bb 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -135,8 +135,8 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
>                                   bc->peri_base, &error_abort);
>   
>           /* start powered off if not enabled */
> -        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
> -                                 n >= s->enabled_cpus, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[n].core), "start-powered-off",
> +                          n >= s->enabled_cpus);
>   
>           if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
>               return;
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 84ea6a807a..ebed887e5e 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -12,6 +12,7 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include <libfdt.h>
> +#include "hw/qdev-properties.h"
>   #include "hw/arm/boot.h"
>   #include "hw/arm/linux-boot-if.h"
>   #include "sysemu/kvm.h"
> @@ -1287,8 +1288,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
>                * CPU.
>                */
>               if (cs != first_cpu) {
> -                object_property_set_bool(cpuobj, "start-powered-off", true,
> -                                         &error_abort);
> +                qdev_prop_set_bit(DEVICE(cpuobj), "start-powered-off", true);
>               }
>           }
>       }
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 9aabbf7f58..fc6a7c8a8b 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -272,8 +272,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* Watchdog */
> -    object_property_set_bool(OBJECT(&s->wdt), "pretimeout-support", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->wdt), "pretimeout-support", true);
>       sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_abort);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index def27bb913..71f50ca802 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -171,8 +171,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
>               { FSL_IMX31_GPIO3_ADDR, FSL_IMX31_GPIO3_IRQ }
>           };
>   
> -        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-edge-sel", false);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
>               return;
>           }
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 7dc42cbfe6..17c399a37e 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -128,8 +128,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>   
>           /* All CPU but CPU 0 start in power off mode */
>           if (i) {
> -            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
> -                                     true, &error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->cpu[i]), "start-powered-off", true);
>           }
>   
>           if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> @@ -288,10 +287,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>               },
>           };
>   
> -        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", true,
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-edge-sel", true);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-upper-pin-irq", true);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
>               return;
>           }
> @@ -412,8 +409,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>               FSL_IMX6_WDOG2_IRQ,
>           };
>   
> -        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support", true);
>           sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index e37b69a5e1..4f4f2a6f41 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -410,8 +410,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>        * and we have to set all properties before calling sysbus_realize().
>        */
>       for (i = 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
> -        object_property_set_bool(OBJECT(&s->eth[i]), "phy-connected",
> -                                 s->phy_connected[i], &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->eth[i]), "phy-connected",
> +                          s->phy_connected[i]);
>           /*
>            * If the MDIO bus on this controller is not connected, assume the
>            * other controller provides support for it.
> @@ -542,8 +542,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>               FSL_IMX6UL_WDOG3_IRQ,
>           };
>   
> -        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support",
> +                          true);
>           sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 474cfdc87c..3138ffeb08 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -192,8 +192,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>                * Secondary CPUs start in powered-down state (and can be
>                * powered up via the SRC system reset controller)
>                */
> -            object_property_set_bool(o, "start-powered-off", true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(DEVICE(o), "start-powered-off", true);
>           }
>   
>           qdev_realize(DEVICE(o), NULL, &error_abort);
> @@ -424,8 +423,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>        * and we have to set all properties before calling sysbus_realize().
>        */
>       for (i = 0; i < FSL_IMX7_NUM_ETHS; i++) {
> -        object_property_set_bool(OBJECT(&s->eth[i]), "phy-connected",
> -                                 s->phy_connected[i], &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->eth[i]), "phy-connected",
> +                          s->phy_connected[i]);
>           /*
>            * If the MDIO bus on this controller is not connected, assume the
>            * other controller provides support for it.
> @@ -513,8 +512,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>               FSL_IMX7_WDOG4_IRQ,
>           };
>   
> -        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support", true);
>           sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>   
>           sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index 15ff21d047..7022df3cfa 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -478,12 +478,10 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>                                   &error_abort);
>           object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>                                   NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
> -        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[i]), "reset-hivecs", true);
>   
>           /* Disable security extensions. */
> -        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[i]), "has_el3", false);
>   
>           if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>               return;
> @@ -613,8 +611,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* USB Host */
> -    object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->ehci), "companion-enable", true);
>       sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);
>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 9600551c44..e3b730f5f5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -48,8 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
>           obj = OBJECT(&s->fpd.apu.cpu[i]);
>           if (i) {
>               /* Secondary CPUs start in powered-down state */
> -            object_property_set_bool(obj, "start-powered-off", true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
>           }
>   
>           object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
> @@ -150,8 +149,7 @@ static void versal_create_rpu_cpus(Versal *s)
>                                   "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
>                                   XLNX_VERSAL_RCPU_TYPE);
>           obj = OBJECT(&s->lpd.rpu.cpu[i]);
> -        object_property_set_bool(obj, "start-powered-off", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
>   
>           object_property_set_int(obj, "mp-affinity", 0x100 | i, &error_abort);
>           object_property_set_int(obj, "core-count", ARRAY_SIZE(s->lpd.rpu.cpu),
> @@ -536,8 +534,7 @@ static void versal_create_ospi(Versal *s, qemu_irq *pic)
>                               &s->pmc.iou.ospi.dma_src,
>                               TYPE_XLNX_CSU_DMA);
>   
> -    object_property_set_bool(OBJECT(&s->pmc.iou.ospi.dma_src), "is-dst",
> -                             false, &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->pmc.iou.ospi.dma_src), "is-dst", false);
>   
>       object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
>                               "dma", OBJECT(mr_dac), &error_abort);
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 5905a33015..f3ca3a7527 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -237,14 +237,12 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
>               /*
>                * Secondary CPUs start in powered-down state.
>                */
> -            object_property_set_bool(OBJECT(&s->rpu_cpu[i]),
> -                                     "start-powered-off", true, &error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->rpu_cpu[i]), "start-powered-off", true);
>           } else {
>               s->boot_cpu_ptr = &s->rpu_cpu[i];
>           }
>   
> -        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), "reset-hivecs", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->rpu_cpu[i]), "reset-hivecs", true);
>           if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, errp)) {
>               return;
>           }
> @@ -518,8 +516,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>               /*
>                * Secondary CPUs start in powered-down state.
>                */
> -            object_property_set_bool(OBJECT(&s->apu_cpu[i]),
> -                                     "start-powered-off", true, &error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->apu_cpu[i]), "start-powered-off", true);
>           } else {
>               s->boot_cpu_ptr = &s->apu_cpu[i];
>           }
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index c7831b5293..a24ebe5886 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -176,7 +176,7 @@ bool qbus_realize(BusState *bus, Error **errp)
>   
>   void qbus_unrealize(BusState *bus)
>   {
> -    object_property_set_bool(OBJECT(bus), "realized", false, &error_abort);
> +    qdev_prop_set_bit(DEVICE(bus), "realized", false);
>   }
>   
>   static bool bus_get_realized(Object *obj, Error **errp)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..f4aa99ed77 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -303,7 +303,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
>   
>   void qdev_unrealize(DeviceState *dev)
>   {
> -    object_property_set_bool(OBJECT(dev), "realized", false, &error_abort);
> +    qdev_prop_set_bit(dev, "realized", false);
>   }
>   
>   static int qdev_assert_realized_properly_cb(Object *obj, void *opaque)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index eace854335..6733652120 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -263,20 +263,13 @@ static void pc_init1(MachineState *machine,
>           size_t i;
>   
>           pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
> -        object_property_set_bool(OBJECT(pci_dev), "has-usb",
> -                                 machine_usb(machine), &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
> -                                 x86_machine_is_acpi_enabled(x86ms),
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
> -                                 &error_abort);
> -        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> -        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
> -                                 x86_machine_is_smm_enabled(x86ms),
> -                                 &error_abort);
>           dev = DEVICE(pci_dev);
> +        qdev_prop_set_bit(dev, "has-usb", machine_usb(machine));
> +        qdev_prop_set_bit(dev, "has-acpi", x86_machine_is_acpi_enabled(x86ms));
> +        qdev_prop_set_bit(dev, "has-pic", false);
> +        qdev_prop_set_bit(dev, "has-pit", false);
> +        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> +        qdev_prop_set_bit(dev, "smm-enabled", x86_machine_is_smm_enabled(x86ms));
>           for (i = 0; i < ISA_NUM_IRQS; i++) {
>               qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
>           }
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index fb7889cf67..626f9b0b56 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -88,9 +88,8 @@ petalogix_ml605_init(MachineState *machine)
>        * root instructions
>        */
>       object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
> -    object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
> +    qdev_prop_set_bit(DEVICE(cpu), "dcache-writeback", true);
> +    qdev_prop_set_bit(DEVICE(cpu), "endianness", true);
>       qdev_realize(DEVICE(cpu), NULL, &error_abort);
>   
>       /* Attach emulated BRAM through the LMB.  */
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 5a2016672a..19cc5efee3 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -18,6 +18,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/boards.h"
>   #include "cpu.h"
>   #include "boot.h"
> @@ -79,19 +80,14 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>   
>       object_property_set_uint(OBJECT(&s->cpu), "base-vectors",
>                                XLNX_ZYNQMP_PMU_ROM_ADDR, &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-stack-protection", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-stack-protection", true);
>       object_property_set_uint(OBJECT(&s->cpu), "use-fpu", 0, &error_abort);
>       object_property_set_uint(OBJECT(&s->cpu), "use-hw-mul", 0, &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-barrel", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-msr-instr", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-barrel", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-msr-instr", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-pcmp-instr", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-mmu", false);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "endianness", true);
>       object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
>                               &error_abort);
>       object_property_set_uint(OBJECT(&s->cpu), "pvr", 0, &error_abort);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4f12e23ab5..ee2a8d5563 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -78,8 +78,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>           CPUMIPSState *env = &cpu->env;
>   
>           /* All VPs are halted on reset. Leave powering up to CPC. */
> -        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", true);
>   
>           /* All cores use the same clock tree */
>           qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 566f1200dd..a63d48c512 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -954,8 +954,7 @@ void ppce500_init(MachineState *machine)
>            * Secondary CPU starts in halted state for now. Needs to change
>            * when implementing non-kernel boot.
>            */
> -        object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cs), "start-powered-off", i != 0);
>           qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>   
>           if (!firstenv) {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 6760823e13..266cf6c9e6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2490,8 +2490,7 @@ static int spapr_switch_one_vga(DeviceState *dev, void *opaque)
>           || object_dynamic_cast(OBJECT(dev), "secondary-vga")
>           || object_dynamic_cast(OBJECT(dev), "bochs-display")
>           || object_dynamic_cast(OBJECT(dev), "virtio-vga")) {
> -        object_property_set_bool(OBJECT(dev), "big-endian-framebuffer", be,
> -                                 &error_abort);
> +        qdev_prop_set_bit(dev, "big-endian-framebuffer", be);
>       }
>       return 0;
>   }
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 47c17026c7..53d3d560c8 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -21,6 +21,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
> +#include "hw/qdev-properties.h"
>   #include "hw/loader.h"
>   #include "hw/rx/rx62n.h"
>   #include "sysemu/qtest.h"
> @@ -103,8 +104,7 @@ static void rx_gdbsim_init(MachineState *machine)
>                                &error_abort);
>       object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
>                                rxc->xtal_freq_hz, &error_abort);
> -    object_property_set_bool(OBJECT(&s->mcu), "load-kernel",
> -                             kernel_filename != NULL, &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->mcu), "load-kernel", kernel_filename != NULL);
>   
>       if (!kernel_filename) {
>           if (machine->firmware) {
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 64895aebe3..d631d555d8 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -803,8 +803,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
>       env = &cpu->env;
>   
>       qemu_register_reset(sun4m_cpu_reset, cpu);
> -    object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", id != 0);
>       qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>       cpu_sparc_set_id(env, id);
>       *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);

