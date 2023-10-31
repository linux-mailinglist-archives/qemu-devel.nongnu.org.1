Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088187DD7AD
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:18:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxw6Q-0003Jg-PU; Tue, 31 Oct 2023 17:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxw6N-0003IP-MM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:16:43 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxw6K-0006HR-R3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:16:43 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a8ee23f043so59698317b3.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698786998; x=1699391798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JiXdrzlK1M6pyRvpDlbcVP7At9aNJ3CDNJoKKO0qtZY=;
 b=OsvTyS3Y6xnMAT7EIld++1Ue1JwPpI3oAMw8nbpFvCkhYRpIBFfn2xp6bCjGYtUmud
 yRjq5cNmc6q45msy11v9IdOIjwglQ8/2GDeeIqmsN5X9+ImdHm4PEzwj26+jR6VK+6vK
 q99Om8l7mnkB8P6GzFfzzZyISwjz4HaXM0Tgy77ty0np5No3cU2G0z2L0+rbddM+fIgY
 s05W7L0TTFKplfewXB2P4pnpgFzvL3/+DBrmp6rCQZ3XjVn0GO5AS7dQFdgyngQnl9KI
 spNUW1aXiK7Ln/rPvRW04n4yBk53QH3uO0D1+b1N+HH355IKy3wY8bJcmSRUAtA58NXv
 /5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698786998; x=1699391798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JiXdrzlK1M6pyRvpDlbcVP7At9aNJ3CDNJoKKO0qtZY=;
 b=kr0TGAmogjZVilr2+vyMigx8voZQzAztFHhQGPunLQvPKPiaYm7utcfVFd9fzoTPlw
 Zhu/lpAhJsumq03bdOmHS0iqlaM6nRLYRKVr8KggOGMlUXiDXllVCzuRi3mvsfexBEUs
 IX6aoMuK6MrjBYSXqcipBfLFvsysNhmYR0PS5GHVEInV8igqFZAashYFctw42abC/pBB
 Vfa+qFGwWCYw+FaHIT0EvDcWqAchrCmOmBCOnX0esZDBZ8V/Hi9gZUxbQFLe9NIwZfod
 CMWG5Gt1CXdA3Wc3Uhe6U/HVUhwj3Xp/8+SLf959/rxGdQXiPl0DgU3AGJgdp3u3Nnf/
 zVjQ==
X-Gm-Message-State: AOJu0YyAf92mPcibGyM45kuxT+TRDZX3XOkqbDCZK6DRP3gyPnbrS9Oi
 yK9ypKTcirQsfrfzcqsU9+hH5g==
X-Google-Smtp-Source: AGHT+IEde+3aahzTyXify9h8H0O3JIilp7PWTmK24QxO/L9ABIwxpJOiE9GaCTWAmYyyWLR7A6UsoQ==
X-Received: by 2002:a81:e50c:0:b0:5b0:6326:75a4 with SMTP id
 s12-20020a81e50c000000b005b0632675a4mr9131393ywl.7.1698786997939; 
 Tue, 31 Oct 2023 14:16:37 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 e130-20020a816988000000b0059adc0c4392sm1314261ywc.140.2023.10.31.14.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 14:16:37 -0700 (PDT)
Message-ID: <711ebdc8-7088-4e27-8d84-d29a7884f2dd@ventanamicro.com>
Date: Tue, 31 Oct 2023 18:16:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-6-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231030143957.82988-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
> Devices should avoid calling qemu_get_cpu() because this call
> doesn't work as expected with heterogeneous machines. Such
> devices often iterate over a cluster of CPUs, which the device's
> parent has direct access (when creating the child device).
> 
> We can pass QOM as 'link' between objects, but we can't pass an
> array of links. Here we exploits QAPI simplicity, by using
> DEFINE_PROP_ARRAY and a list of strings, each string being the
> CPU canonical path in QOM tree (which is constant and unique).
> When the device realizes itself, the original CPU pointer is
> recovered via a object_resolve_path() call.
> 
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Inspired-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Tested with:
> $ make check-qtest-ppc{,64}
> $ make check-avocado AVOCADO_TAGS='machine:ppce500 machine:mpc8544ds'
> 
> RFC: See cover
> 
> FIXME: Should we free spin_cpu_list using g_autoptr(QList)?

By looking at how object_property_set_qobject() works I *think* we can free it.
Perhaps try using g_autofree and see if something explodes, hehe

Thanks,

Daniel

> ---
>   hw/ppc/e500.c         |  6 ++++++
>   hw/ppc/ppce500_spin.c | 48 ++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index e38f46df38..8b31143dca 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -18,6 +18,7 @@
>   #include "qemu/datadir.h"
>   #include "qemu/units.h"
>   #include "qemu/guest-random.h"
> +#include "qapi/qmp/qlist.h"
>   #include "qapi/error.h"
>   #include "e500.h"
>   #include "e500-ccsr.h"
> @@ -930,11 +931,13 @@ void ppce500_init(MachineState *machine)
>       SysBusDevice *s;
>       PPCE500CCSRState *ccsr;
>       I2CBus *i2c;
> +    QList *spin_cpu_list = qlist_new();
>   
>       irqs = g_new0(IrqLines, smp_cpus);
>       for (i = 0; i < smp_cpus; i++) {
>           PowerPCCPU *cpu;
>           CPUState *cs;
> +        g_autofree char *cpu_qompath;
>   
>           cpu = POWERPC_CPU(object_new(machine->cpu_type));
>           env = &cpu->env;
> @@ -954,6 +957,8 @@ void ppce500_init(MachineState *machine)
>           object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
>                                    &error_fatal);
>           qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
> +        cpu_qompath = object_get_canonical_path(OBJECT(cs));
> +        qlist_append_str(spin_cpu_list, cpu_qompath);
>   
>           if (!firstenv) {
>               firstenv = env;
> @@ -1083,6 +1088,7 @@ void ppce500_init(MachineState *machine)
>   
>       /* Register spinning region */
>       dev = qdev_new("e500-spin");
> +    qdev_prop_set_array(dev, "cpus-qom-path", spin_cpu_list);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, pmc->spin_base);
>   
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index e3608d8c16..a67046b2ea 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -30,11 +30,13 @@
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
>   #include "qemu/units.h"
> +#include "qapi/error.h"
>   #include "hw/hw.h"
>   #include "hw/sysbus.h"
>   #include "sysemu/hw_accel.h"
>   #include "e500.h"
>   #include "qom/object.h"
> +#include "hw/qdev-properties.h"
>   
>   #define MAX_CPUS 32
>   
> @@ -46,6 +48,10 @@ typedef struct spin_info {
>       uint64_t reserved;
>   } QEMU_PACKED SpinInfo;
>   
> +/*
> + * QEMU interface:
> + *  + QOM array property "cpus-qom-path": QOM canonical path of each CPU.
> + */
>   #define TYPE_E500_SPIN "e500-spin"
>   OBJECT_DECLARE_SIMPLE_TYPE(SpinState, E500_SPIN)
>   
> @@ -54,6 +60,9 @@ struct SpinState {
>   
>       MemoryRegion iomem;
>       SpinInfo spin[MAX_CPUS];
> +    uint32_t cpu_count;
> +    char **cpu_canonical_path;
> +    CPUState **cpu;
>   };
>   
>   static void spin_reset(DeviceState *dev)
> @@ -121,16 +130,10 @@ static void spin_write(void *opaque, hwaddr addr, uint64_t value,
>   {
>       SpinState *s = opaque;
>       int env_idx = addr / sizeof(SpinInfo);
> -    CPUState *cpu;
> +    CPUState *cpu = s->cpu[env_idx];
>       SpinInfo *curspin = &s->spin[env_idx];
>       uint8_t *curspin_p = (uint8_t*)curspin;
>   
> -    cpu = qemu_get_cpu(env_idx);
> -    if (cpu == NULL) {
> -        /* Unknown CPU */
> -        return;
> -    }
> -
>       if (cpu->cpu_index == 0) {
>           /* primary CPU doesn't spin */
>           return;
> @@ -188,11 +191,42 @@ static void ppce500_spin_initfn(Object *obj)
>       sysbus_init_mmio(dev, &s->iomem);
>   }
>   
> +static void ppce500_spin_realize(DeviceState *dev, Error **errp)
> +{
> +    SpinState *s = E500_SPIN(dev);
> +
> +    if (s->cpu_count == 0) {
> +        error_setg(errp, "'cpus-qom-path' property array must be set");
> +        return;
> +    } else if (s->cpu_count > MAX_CPUS) {
> +        error_setg(errp, "at most %d CPUs are supported", MAX_CPUS);
> +        return;
> +    }
> +
> +    s->cpu = g_new(CPUState *, s->cpu_count);
> +    for (unsigned i = 0; i < s->cpu_count; i++) {
> +        bool ambiguous;
> +        Object *obj;
> +
> +        obj = object_resolve_path(s->cpu_canonical_path[i], &ambiguous);
> +        assert(!ambiguous);
> +        s->cpu[i] = CPU(obj);
> +    }
> +}
> +
> +static Property ppce500_spin_properties[] = {
> +    DEFINE_PROP_ARRAY("cpus-qom-path", SpinState, cpu_count,
> +                      cpu_canonical_path, qdev_prop_string, char *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void ppce500_spin_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->reset = spin_reset;
> +    dc->realize = ppce500_spin_realize;
> +    device_class_set_props(dc, ppce500_spin_properties);
>   }
>   
>   static const TypeInfo ppce500_spin_types[] = {

