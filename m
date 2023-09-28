Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B267B1059
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfnT-0000kr-0b; Wed, 27 Sep 2023 21:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfnQ-0000kF-SI
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfnP-0000Io-0J
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695864386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofbQlFG7DfY6BCrLZ0NPamX51zA/0IQOtNdVPXeHaqE=;
 b=c6+61P9vBOFFo/elpalnuesDFJBHOs6EQrnvdr8F9+Ybb93Ve88jDPhhmcINCWfWm4F36V
 wJCjn84z87VDUQunMlCrxocXpW2xsksQOcrJ7sQ/wHfLoPXgKE0gSNRFmg5x//TJdUfOGQ
 oGwjHj3B+Jx8VmHJQ+ZocmqTJh/MJL8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-6wMgAC_6N2m9rbMB-xIj1w-1; Wed, 27 Sep 2023 21:26:24 -0400
X-MC-Unique: 6wMgAC_6N2m9rbMB-xIj1w-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-57dce07c62aso14038590a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 18:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695864383; x=1696469183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ofbQlFG7DfY6BCrLZ0NPamX51zA/0IQOtNdVPXeHaqE=;
 b=McKRQHLjc9zGJ4B4qEW1zne03YR2zF/guKyrEnPjMo+eG+M9fDg/cQ7lPjwe+n6Y4d
 GHh9fjbTMeymu6EPq+yl769yLFMyyyYOSIzvHd/tHhgrAcfxSy5WszcBTb+jg0OnTOKc
 B7UYUnQTL+ftgdBqlKQ4uDHtxeHnoHna6xdOyKHpalB4gjeup7c2FyAa0HHJsa+sUr8d
 /ysSmYdgSaXqbrP9/CJDHj+EHaIEfLUXzMhANn0XBoe+UBI1ccfbnFUXO9b/sV8KukVn
 wZk/nJ2x/xXiHXDiQkQoKn0HaS0TE1E3RaAaQ8C2dG8HolyDMGc+cPiiPMQaHyw5THuj
 Gcug==
X-Gm-Message-State: AOJu0YwJND589wRhdF9jWLtlfOr95OjLq7onA5E2yPYKbEvC4axKkbZd
 QoQWxlsO8euRtA3TBQ2o/J9GyC3KfUo0OTlr3+iliDI+LXCyBY59VzvNmiWHgi8f0wkBbcCXxFq
 uporNg1QNcxvj6co=
X-Received: by 2002:a05:6a21:4982:b0:15d:7767:6553 with SMTP id
 ax2-20020a056a21498200b0015d77676553mr3411419pzc.35.1695864383283; 
 Wed, 27 Sep 2023 18:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ4L0y7g3Yta5s/0ARIaC+adC12OwVZZgHJAmsogm4QCeRwptE6s0a5gQknNwF7Bla9NGoXw==
X-Received: by 2002:a05:6a21:4982:b0:15d:7767:6553 with SMTP id
 ax2-20020a056a21498200b0015d77676553mr3411385pzc.35.1695864382901; 
 Wed, 27 Sep 2023 18:26:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a170902868b00b001c22292ad7esm2378560plo.232.2023.09.27.18.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 18:26:22 -0700 (PDT)
Message-ID: <26f2a18a-4315-443f-560a-c4f007434206@redhat.com>
Date: Thu, 28 Sep 2023 11:26:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 16/37] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-17-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-17-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/26/23 20:04, Salil Mehta wrote:
> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is based on
> PCI and is IO port based and hence existing cpus AML code assumes _CRS objects
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                           . The existing AML code assumes _CRS object
> would evaluate to a system resource which describes IO Port address. But on ARM
   ^^^^^^^^^^^^^^^^^^^
   is evaluated to a
   
> arch CPUs control device(\\_SB.PRES) register interface is memory-mapped hence
> _CRS object should evaluate to system resource which describes memory-mapped
               ^^^^^^
               should be evaluated
> base address.
> 
> This cpus AML code change updates the existing inerface of the build cpus AML
> function to accept both IO/MEMORY type regions and update the _CRS object
> correspondingly.
> 
> NOTE: Beside above CPU scan shall be triggered when OSPM evaluates _EVT method
>        part of the GED framework which is covered in subsequent patch.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c         | 23 ++++++++++++++++-------
>   hw/i386/acpi-build.c  |  2 +-
>   include/hw/acpi/cpu.h |  5 +++--
>   3 files changed, 20 insertions(+), 10 deletions(-)
> 

I guess the commit log can be simplified to:

The CPU hotplug register block is declared as a IO region on x86, or a memory
region on arm64 in build_cpus_aml(), as part of the generic container device
(\\_SB.PCI0 or \\_SB.PRES).

Adapt build_cpus_aml() so that IO region and memory region can be handled
in the mean while.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index d5ba37b209..232720992d 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -341,9 +341,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
>   #define CPU_FW_EJECT_EVENT "CEJF"
>   
>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    hwaddr io_base,
> +                    hwaddr base_addr,
>                       const char *res_root,
> -                    const char *event_handler_method)
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs)
>   {
>       Aml *ifctx;
>       Aml *field;
> @@ -370,13 +371,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>           aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>   
>           crs = aml_resource_template();
> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
>                                  ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else {
> +            aml_append(crs, aml_memory32_fixed(base_addr,
> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> +        }
> +
>           aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>   
>           /* declare CPU hotplug MMIO region with related access fields */
>           aml_append(cpu_ctrl_dev,
> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> +            aml_operation_region("PRST", rs, aml_int(base_addr),
>                                    ACPI_CPU_HOTPLUG_REG_LEN));
>   
>           field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> @@ -702,9 +709,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>       aml_append(sb_scope, cpus_dev);
>       aml_append(table, sb_scope);
>   
> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
>   
>       g_free(cphp_res_path);
>   }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index bb12b0ad43..560f108d38 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,7 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>           };
>           build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
> -                       "\\_SB.PCI0", "\\_GPE._E02");
> +                       "\\_SB.PCI0", "\\_GPE._E02", AML_SYSTEM_IO);
>       }
>   
>       if (pcms->memhp_io_base && nr_mem) {
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 999caaf510..b87ebfdf4b 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -56,9 +56,10 @@ typedef struct CPUHotplugFeatures {
>   } CPUHotplugFeatures;
>   
>   void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    hwaddr io_base,
> +                    hwaddr base_addr,
>                       const char *res_root,
> -                    const char *event_handler_method);
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs);
>   
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>   

Thanks,
Gavin


