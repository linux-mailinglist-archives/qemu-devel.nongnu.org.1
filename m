Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25E7B5DF9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 02:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSym-00014r-OH; Mon, 02 Oct 2023 20:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSyk-00014j-Ub
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSyi-00081x-7F
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696291771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQ1f52MB4V11uTw9Tw6mw2QM2E2dQmC4sFW/qlXJ8tA=;
 b=NUGIyVLf65pHhABjmYrqxHXZcsBZjdmweMS72jFrkc/+mvoM7oLPEnjYE8vxReSv/RaiOx
 aNuE2ookxKJCOxc0rOHzfLe6vbFAuIDr2c1tybftFLseTin0LLETsIKgf/vp5QgcZI2EwN
 zw84OGCRgl7WtPu86kfxna6oFH+2XEI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-hRXOsuibO5GBiWuq0tnZ2g-1; Mon, 02 Oct 2023 20:09:20 -0400
X-MC-Unique: hRXOsuibO5GBiWuq0tnZ2g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-27745c2f5d0so348397a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 17:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696291759; x=1696896559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQ1f52MB4V11uTw9Tw6mw2QM2E2dQmC4sFW/qlXJ8tA=;
 b=lKIzxSYPVm7iSnF714Re1JTt5gvuApRFl8WS4qLIQoCOGaxnWa8XqFaVrWc5/3+BWq
 4tIZNgIn97IhFGE9cfyppoeerVQta4JLt8RriIeQY8BjGytMg2kAlT85IbBkbURsZiHA
 0xQr2C0xKcp+EL4lIBtPWdZBBwP/k0+K4yZ8lFqkBDx51Zsm4wI4Pzpg5cyhfM0DZHmz
 Dt3YC7iN2C0KPZPTQfIG3jWTritRohKqGGfWGDzvtKY0StOV85VpAg8VZAp3qAmX9rI4
 MqyY+FGQ0xvwTTwNkHR6Yd5414m8AUVNmpPA2lYK0k3u9tL/ZuVR+/JC1PcdwN+9rq/n
 8GMg==
X-Gm-Message-State: AOJu0Yxw8CJlRU+B/DnAL8vnB0mLKzlodwePfAVcK1ls2/kBGOMhH+pa
 DUHt4/T6R/pXkH/X30OZ5SuYij7iV8ReXBjLOy32MGu4D3m9Y/79AIqbrpAdH8GdJkLsQ9vZukx
 ZH/b8MYODkk8p09c=
X-Received: by 2002:a17:90b:906:b0:26f:d6f4:9646 with SMTP id
 bo6-20020a17090b090600b0026fd6f49646mr10349320pjb.40.1696291759042; 
 Mon, 02 Oct 2023 17:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE03YTFfYEwh19ZN7xQKWkwnfVnIKf021wZiPsI7JT7B3qbj5kHVOGo+s9a0ZWQcG/U04DcvA==
X-Received: by 2002:a17:90b:906:b0:26f:d6f4:9646 with SMTP id
 bo6-20020a17090b090600b0026fd6f49646mr10349277pjb.40.1696291758668; 
 Mon, 02 Oct 2023 17:09:18 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a19d800b002775f7dbd7esm49098pjj.49.2023.10.02.17.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 17:09:18 -0700 (PDT)
Message-ID: <5dc18701-973b-bd1c-8704-479ea67a7be8@redhat.com>
Date: Tue, 3 Oct 2023 10:09:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 05/10] hw/acpi: Update CPUs AML with cpu-(ctrl)dev
 change
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-6-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-6-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/30/23 10:19, Salil Mehta wrote:
> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is based on
> PCI and is IO port based and hence existing cpus AML code assumes _CRS objects
> would evaluate to a system resource which describes IO Port address. But on ARM
> arch CPUs control device(\\_SB.PRES) register interface is memory-mapped hence
> _CRS object should evaluate to system resource which describes memory-mapped
> base address.
> 
> This cpus AML code change updates the existing inerface of the build cpus AML
> function to accept both IO/MEMORY type regions and update the _CRS object
> correspondingly.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c         | 23 ++++++++++++++++-------
>   hw/i386/acpi-build.c  |  2 +-
>   include/hw/acpi/cpu.h |  5 +++--
>   3 files changed, 20 insertions(+), 10 deletions(-)
> 

With commit log improved to address Jonathan's comments why @event_handler_method
won't be needed on aarch64:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 45defdc0e2..66a71660ec 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -338,9 +338,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
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
> @@ -367,13 +368,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
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
> @@ -699,9 +706,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
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
> index 4d2d40bab5..611d3d044d 100644
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


