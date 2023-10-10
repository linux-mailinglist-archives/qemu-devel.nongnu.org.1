Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5417BF583
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 10:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7wq-0004mD-Ge; Tue, 10 Oct 2023 04:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7wn-0004lt-Rc
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7wk-0002Ny-O5
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696925906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJ0U48nKeGwZvQdg8MpDAQSXjQBTOf1gUWygXvNgjcI=;
 b=dgy/BlHdNOlQG0KlUFm1ioNHA7ifJkF+yFQ06OTJarZPFJKXuDgyd6FY0UtgnswgCP7Qxl
 FcJWLvCCSmaoN4YOC/Xg0oIsQ4ymBODLKQRpNJzFekUT4YH72Dmad4nW/oyPaG97lQRo2h
 j1eGf9fVIVgKmsoBhJGwfrJotqHFt/Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ewugM4pnMbiPzv4HgScjOQ-1; Tue, 10 Oct 2023 04:18:24 -0400
X-MC-Unique: ewugM4pnMbiPzv4HgScjOQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-692becf84ffso1476158b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696925904; x=1697530704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJ0U48nKeGwZvQdg8MpDAQSXjQBTOf1gUWygXvNgjcI=;
 b=E9aIHBNFxZt1I0BGsWBpCl/vDUGmFY5oGBLuTjyFM/mv0y9Co4LAELXxwJgznqCDZ6
 fzUQgf43oTaDTLc8Gl/o9/zfl38b9toJ1MWN386W5CvDSs0v51ahgArWDDCCOEMx128b
 kKSGat5gLaXRAqCsWZfScbFAqP9PT3q3j9RoNm5bnseWTn4KzurbCwfR8MkuHmLZqRNZ
 0C7JSZ0aybsd/gU3avWPgZDCNH8Kix/un2Th/fu3ny/MpNQlGVqafZ5yCVctxup82YSZ
 q9NMxf0Z8QKPDpmOktwjsBAHXcmb1EgouYnFSo72ON1X98cDTF2Hz1YDxxcCYxR7OJci
 8ceQ==
X-Gm-Message-State: AOJu0Ywayxw8KZGdEbhqRc8deo8CdUcCChYnGBYyzxyc6iFMH4FRfOOO
 Q4iFq+L6c6TRZ4HCJBxkhXXIOUbqcRBRNHiU/k6GDwdT80GB2pny7uZ6de/W0IRwlCtGK405EoO
 zowbuTnFuZDf6KY4=
X-Received: by 2002:a05:6a00:2d1b:b0:68e:3eff:e93a with SMTP id
 fa27-20020a056a002d1b00b0068e3effe93amr18795664pfb.2.1696925903798; 
 Tue, 10 Oct 2023 01:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Jo66Ny2UBxbUeJ3LeRTrvgcKh1k4oF3P7OGwu3rLq7tRWrvTVSkRNNCz0UBzPCnwdJkHOQ==
X-Received: by 2002:a05:6a00:2d1b:b0:68e:3eff:e93a with SMTP id
 fa27-20020a056a002d1b00b0068e3effe93amr18795625pfb.2.1696925903417; 
 Tue, 10 Oct 2023 01:18:23 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 z18-20020aa791d2000000b0068fcb70ccafsm7568388pfa.129.2023.10.10.01.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 01:18:22 -0700 (PDT)
Message-ID: <d9fdeb5b-5da2-8411-7940-e64ad7ebf91b@redhat.com>
Date: Tue, 10 Oct 2023 16:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-8-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231009203601.17584-8-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10/10/23 04:35, Salil Mehta via wrote:
> ACPI GED shall be used to convey to the guest kernel about any CPU hot-(un)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> to support CPU hotplug state and events.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/acpi/generic_event_device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 62d504d231..0d5f0140e5 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/cpu.h"
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/irq.h"
>   #include "hw/mem/pc-dimm.h"
> @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>           } else {
>               acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
>           }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "virt: device plug request for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>       if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>                          !(object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)))) {
>           acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "acpi: device unplug request for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>           acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
>       } else {
>           error_setg(errp, "acpi: device unplug for unsupported device"
>                      " type: %s", object_get_typename(OBJECT(dev)));
> @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
>       AcpiGedState *s = ACPI_GED(adev);
>   
>       acpi_memory_ospm_status(&s->memhp_state, list);
> +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
>   }
>   
>   static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>           sel = ACPI_GED_PWR_DOWN_EVT;
>       } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
>       } else {
>           /* Unknown event. Return without generating interrupt. */
>           warn_report("GED: Unsupported event %d. No irq injected", ev);

-- 
Shaoqin


