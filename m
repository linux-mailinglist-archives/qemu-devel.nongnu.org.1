Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA07D9994
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMjf-0005tq-ON; Fri, 27 Oct 2023 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwMjV-0005tO-77
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwMjS-0001hj-Rl
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698412713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF6VVCxboXhKIs5wCjsGQQ7u5mOJRHdkheC80a1pjWg=;
 b=hjuvutP6PZwHrvHk7bJAt1MzmOr0viXLNMnYKqOdlxp0FbAL1+q5++tEqc/u7MD1Y0+2w/
 sEEyZ5vIrn1rtRUMf9au+lVMBuWDn7xfK2V1bD+22E//W7S4O0HXm5j3sS+idyX9axXWPO
 8gbqKMD5zC5WCrsbzI6tqaFAjlYCd5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-F11KXPSyMeyKt-WHJj8Y8w-1; Fri, 27 Oct 2023 09:18:32 -0400
X-MC-Unique: F11KXPSyMeyKt-WHJj8Y8w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9cd789f0284so135994866b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698412711; x=1699017511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TF6VVCxboXhKIs5wCjsGQQ7u5mOJRHdkheC80a1pjWg=;
 b=QKiX7lT5RvX8Kq8vOTHMUe/ZvxQKTIA8Jelh5dfmuc30QQQr0k8LN+RSIKp8deh0zR
 QQgO4RvUU3NS1ozGHvh+QjO786Pg5Q6U+mHXgYdfHTtEOkbJcT3FmdppIZ1HrqIJo0BK
 aGhnAXccaEkBhdvHyN2PeukDJoKeDCdkWwhlC0HYj4i0z7/34NwvJtxl4I2iUU4fTrL2
 E2ldfxFDXkmOW+tefjuxH6De2cxi1looxSpVnGKb2uqYxjVSvFdYDS+MJp3/UG5Y8ao4
 ALTgs3AiLIP+mTVOJ7vX7PEOhOU0IbQ9iMC7Ae5E5r6XmYCwKPctm+MnpcZScNwvT2Eg
 sHeA==
X-Gm-Message-State: AOJu0YyoRreoGA8dD1EyPB5RdYgfLqxC/Bp4jdypqK2Du5vYANY12ull
 VQmUUKxJuM5CmCB+ljLy4C7emy9Z9zj1DvcskIriI43sRuubIW6eXyGCTK4CWSZzQ5soL6+8H+2
 dtGF+Mxt1Blqszeo=
X-Received: by 2002:a17:906:da84:b0:9be:30c2:b8fd with SMTP id
 xh4-20020a170906da8400b009be30c2b8fdmr2323602ejb.66.1698412711085; 
 Fri, 27 Oct 2023 06:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/IqR5MSACSaPr0YzIpfc6LCzSipSVZ3BBHFfczanqI+uPE+v8k4bSqXVoEFA07cX4cDppQ==
X-Received: by 2002:a17:906:da84:b0:9be:30c2:b8fd with SMTP id
 xh4-20020a170906da8400b009be30c2b8fdmr2323580ejb.66.1698412710706; 
 Fri, 27 Oct 2023 06:18:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 mb6-20020a170906eb0600b009adce1c97ccsm1184408ejb.53.2023.10.27.06.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 06:18:30 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:18:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V6 7/9] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <20231027151828.5c9d499b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231013105129.25648-8-salil.mehta@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
 <20231013105129.25648-8-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 13 Oct 2023 11:51:27 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> ACPI GED shall be used to convey to the guest kernel about any CPU hot-(un)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> to support CPU hotplug state and events.
> 

This is a part of hw wiring which you started to introduce in 4/9
Given patches are small, I'd merge this into 4/9 to avoid broken context.
So essentially GED improvement would consist from hw and aml parts.
with some extra refactoring (5/9) in a separate patch.

> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> ---
>  hw/acpi/generic_event_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 62d504d231..0d5f0140e5 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/cpu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                         !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>      AcpiGedState *s = ACPI_GED(adev);
>  
>      acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>  }
>  
>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_PWR_DOWN_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);


