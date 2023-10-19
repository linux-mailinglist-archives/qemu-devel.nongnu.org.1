Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC57CF4F3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQ5v-0005eM-3q; Thu, 19 Oct 2023 06:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtQ5o-0005bo-MF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:17:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtQ5l-0001EH-TD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:17:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so23372985e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697710644; x=1698315444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DuH5D7kyFrR0KYPFHg1lLKdvYtdK1Ff5bxPYZFtGDOE=;
 b=cFhnXMYK6DTiyJmPpFEPFFT2M81es2auGbCrN7VmHHPzEyt2s7ftUoUbg1/qG7Cvec
 ROIoxOZLU18CMJ1PVl0noNurEIdsAxitp1z/R8FosKkZHcZ+1cPEzxUlGQYUl7qQtbyj
 azUB0gD8wYUYZNrGeoXputuXe82x6ZUxMWcX7mOBABGvEfE13Q71HbkMRX4c3SMioQu9
 DB+eX8ycakvaW+MKucRqGb034ENi+a0BLzh3VrvNpzKhU5vLEMogliLeX7zHezTEjBzF
 Qzzk6ngwVnHMO/iZkEOYlJG9Gfaxa3azE3UpuaytmI7REwJ6/Nr7CSQ7ZXS0k1K+687q
 bUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710644; x=1698315444;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DuH5D7kyFrR0KYPFHg1lLKdvYtdK1Ff5bxPYZFtGDOE=;
 b=F9h7wxRiF8ZLOhDTMmh9TDSqX7Qzj6IbZ6kbhVR2dREhqmk13hxwBVAwilKZ4eB5Yn
 ugVqvK8o0/0gBOgq8P+KurJt7sgeUkNRuIWS01HbP5jZ2/Y+W1WhpaaNZWT8BcNsdz9C
 75v0erKeSWa2arnN0CwOlhz5dgH6N+caOgr9bL0goixkcjN4zz/vurmBwxy/SHZKiOYK
 CnMLTKTyt71lG+QIATiOqSIhBXyyV8JP7+qGDw6JCRhGnh60KkkdPN2NL1pLnhfIfCrv
 4Ju2BMHF2PGta4fyoNNxcBG9XQdutXx76m/jvZsnmta5ThGcwPb5rjjjtZlT24LKCwPU
 d5Gg==
X-Gm-Message-State: AOJu0Yw87yFC9EwRrkT55qlne5u5zWeevkTJ7lMH7n/ahqGaI81ab1kC
 weGEZl5vB849ZI7u2n5OG9hXxg==
X-Google-Smtp-Source: AGHT+IFnCsGcjcb3wK9dfhfI0X3I4CDIGgOoXl4WhbUggYCjpW6xr/rZXDw9hq9GVOlXDkwKplzRog==
X-Received: by 2002:a05:600c:4eca:b0:408:3ab3:a05e with SMTP id
 g10-20020a05600c4eca00b004083ab3a05emr1448715wmq.38.1697710643822; 
 Thu, 19 Oct 2023 03:17:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600001d100b0032d8034724esm4091443wrx.94.2023.10.19.03.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:17:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0CB4D1FFBB;
 Thu, 19 Oct 2023 11:17:23 +0100 (BST)
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-5-salil.mehta@huawei.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
Subject: Re: [PATCH V6 4/9] hw/acpi: Init GED framework with CPU hotplug events
Date: Thu, 19 Oct 2023 11:16:05 +0100
In-reply-to: <20231013105129.25648-5-salil.mehta@huawei.com>
Message-ID: <87fs26apcd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Salil Mehta <salil.mehta@huawei.com> writes:

> ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI =
events
> when OSPM/guest receives an interrupt listed in the _CRS object of GED. O=
SPM
> then maps or demultiplexes the event by evaluating _EVT method.
>
> This change adds the support of CPU hotplug event initialization in the
> existing GED framework.

Should we also update the docs here:

  https://qemu.readthedocs.io/en/master/specs/acpi_hw_reduced_hotplug.html

(see docs/specs/acpi_hw_reduced_hotplug.rst)

to add the new bits? Or maybe an update to documentation as the last
commit?

>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/acpi/generic_event_device.c         | 8 ++++++++
>  include/hw/acpi/generic_event_device.h | 5 +++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_devic=
e.c
> index a3d31631fe..d2fa1d0e4a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] =3D {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> +    ACPI_GED_CPU_HOTPLUG_EVT,
>  };
>=20=20
>  /*
> @@ -400,6 +401,13 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    s->cpuhp.device =3D OBJECT(s);
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp containe=
r",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);
>  }
>=20=20
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gen=
eric_event_device.h
> index ba84ce0214..a803ea818e 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>  #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>=20=20
>  #include "hw/sysbus.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/ghes.h"
>  #include "qom/object.h"
> @@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>=20=20
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -106,6 +108,9 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
> +    AcpiCpuHotplug cpuhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

