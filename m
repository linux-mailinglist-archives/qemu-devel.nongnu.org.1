Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCE7F78DC
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:25:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YyZ-0003om-SG; Fri, 24 Nov 2023 11:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6YyY-0003oT-3L
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6YyW-0003yJ-6q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700843055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvZLC1a3doCjwxJXe9wXGBy327RrszPAUGwfEDg92j8=;
 b=APMGRqqDpMVcpBHnuPrixwL1w9LFsQH4f0ZRBariEWOIHsb+UnaR1H8Jy8vbKtDvOyO6f3
 V7i3N6fXnU+NrAFcBhSPR4qaGIahKh0fJmH/YxDy6/LH8kFL+k0QDg+A+tu36W7QSDgen6
 UEuVTyWaMfI+Wab7AVruwGQLM+Drv8A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-y3yPjWYrMTGhEoT3Mp1-bQ-1; Fri, 24 Nov 2023 11:24:13 -0500
X-MC-Unique: y3yPjWYrMTGhEoT3Mp1-bQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a029b93e484so144873366b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 08:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700843053; x=1701447853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvZLC1a3doCjwxJXe9wXGBy327RrszPAUGwfEDg92j8=;
 b=H2A1ao+2GMV9FB9DPf3IadcPOanclhl7wcmvxZSac4MpRll/LnWxJPofMcaS14GMXJ
 +/fq9ElhxLIpywlFO+j9iKZ6vGK0vzShgah0bm5gu7N5427SSzXiWyLestTYojeIVxSB
 6dCsfE59WB4o6mJBoV0gEtGoa0PS1Y9B32whU/YuJjqsZo7Y1pJdosx9kLNBpScGU8RE
 cSb1rtrLo6bDW0YE2xuzIJ8amlpJrVO9e47IAbXDKqIw7Xi7Wfw2GnXHxvnHVSfAqd1T
 lTEvpdqmQkmg2aMgzV2Wk1tGFnI1gHImjjvoHGW8j8tZJ1NM5TQ/Ql2Ql8sc/N4ok+ai
 +ViQ==
X-Gm-Message-State: AOJu0YxHtZht1OH45luZGp0IK5bcGzkBBKUrQW2OljV9Ckw5Clat/7eQ
 j5HTFJcMb+F1mUdvluRhwBMM2Z/Y5KeZJ/lCH3FeVYqGS+s+gXvSqjr2ABw7xw4hMy3kHi6R3Jp
 ybgAdJUPtrfGp67Q=
X-Received: by 2002:a17:906:6809:b0:9fe:42aa:425d with SMTP id
 k9-20020a170906680900b009fe42aa425dmr2564489ejr.76.1700843052862; 
 Fri, 24 Nov 2023 08:24:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2G9SbY8+V1Sc3A63ZkKH0sVGZCMUUP0pi5xLaZZtGeJxQZ68up4DWvb1Ij8NZwn2spsfhZQ==
X-Received: by 2002:a17:906:6809:b0:9fe:42aa:425d with SMTP id
 k9-20020a170906680900b009fe42aa425dmr2564471ejr.76.1700843052504; 
 Fri, 24 Nov 2023 08:24:12 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 qx23-20020a170906fcd700b009d2eb40ff9dsm2249210ejb.33.2023.11.24.08.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 08:24:12 -0800 (PST)
Date: Fri, 24 Nov 2023 17:24:10 +0100
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
Subject: Re: [PATCH V7 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20231124172410.327865fd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-5-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-5-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 13 Nov 2023 20:12:32 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
> results in start of the CPU scan. Scan figures out the CPU and the kind of
> event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
> method with the call to \\_SB.CPUS.CSCN
> 
> Also, macro CPU_SCAN_METHOD might be referred in other places like during GED
> intialization so it makes sense to have its definition placed in some common
> header file like cpu_hotplug.h. But doing this can cause compilation break

hw/acpi/cpu.h  would be a better place for it

Also, I'd rather rename w/acpi/cpu_hotplug.c:CPU_SCAN_METHOD to LEGACY_CPU_SCAN_METHOD
while keeping newer CPU_SCAN_METHOD as is and making it public.

> because of the conflicting macro definitions present in cpu.c and cpu_hotplug.c
> and because both these files get compiled due to historic reasons of x86 world
> i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface happens
> during runtime [1]. To mitigate above, for now, declare a new common macro
> ACPI_CPU_SCAN_METHOD for CPU scan method instead.
> (This needs a separate discussion later on for clean-up)
> 
> Reference:
> [1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-email-imammedo@redhat.com/
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/acpi/cpu.c                  | 2 +-
>  hw/acpi/generic_event_device.c | 4 ++++
>  include/hw/acpi/cpu_hotplug.h  | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 4b24a25003..de1f9295dc 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -323,7 +323,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPUHP_RES_DEVICE  "PRES"
>  #define CPU_LOCK          "CPLK"
>  #define CPU_STS_METHOD    "CSTA"
> -#define CPU_SCAN_METHOD   "CSCN"
> +#define CPU_SCAN_METHOD   ACPI_CPU_SCAN_METHOD
>  #define CPU_NOTIFY_METHOD "CTFY"
>  #define CPU_EJECT_METHOD  "CEJ0"
>  #define CPU_OST_METHOD    "COST"
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 57b0c2815b..f547b96d74 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -109,6 +109,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                  aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
>                                               MEMORY_SLOT_SCAN_METHOD));
>                  break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> +                                             ACPI_CPU_SCAN_METHOD));
> +                break;
>              case ACPI_GED_PWR_DOWN_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 48b291e45e..ef631750b4 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -20,6 +20,8 @@
>  #include "hw/acpi/cpu.h"
>  
>  #define ACPI_CPU_HOTPLUG_REG_LEN 12
> +#define ACPI_CPU_SCAN_METHOD "CSCN"
> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
>  
>  typedef struct AcpiCpuHotplug {
>      Object *device;


