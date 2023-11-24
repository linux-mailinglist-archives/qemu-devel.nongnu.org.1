Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08C7F7A0B
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:06:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Zbw-0006vq-5G; Fri, 24 Nov 2023 12:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Zbu-0006vZ-8b
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Zbr-0005I2-MF
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700845494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV08Mg7zL7cwji3fZJdMQUEka/HT29wVQMTZBjTEI4s=;
 b=EPo9FwP/cgrncJJ8/tX4XWjFvLRtmOUTVwyl4T0DUO4Q4dyOAIrlZlwy29/ox4wI2FWq1M
 ydmYWoJmMxUTACkNeCeuchVOwqn6C/HreAfCETup0G/+Ajh5YoMs6GRXj2xbQSdroA098+
 dEN1JgT4GETNdotTEi9dK4Ogrm2RHsE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-CQrhP7A5Nl2j-Q4zBfbu3w-1; Fri, 24 Nov 2023 12:04:53 -0500
X-MC-Unique: CQrhP7A5Nl2j-Q4zBfbu3w-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ce0c99f117so1901788a34.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845492; x=1701450292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV08Mg7zL7cwji3fZJdMQUEka/HT29wVQMTZBjTEI4s=;
 b=kYgsm3gF62FgT6Y488q+8gAiY0S/WCDRQwP6oOcEKkW9cc3XuQBiExtd+orP4lqyUn
 znn+sB93/D0k1+nocy4dnUazYovQWAhyV+RzBrhJwW5Jn7jImjFUnieV52WbmB7FWcSK
 alQjC0cilMK21IxVMXoQdomqF62t6fWm674MMNjoxfRlfla4I0fqC+eGOK5NMxUP3tRO
 bfiALEXbswXz0u43E4NyX8K05LeJ9NGXDzaN1FI4exHQEXgwFjiDsnH0DuFbizA/4VzO
 ZCdaznkcZ6LchkdaNWp2yqx09H6Y6X9aJr872vntJPx5geIBbE+2w9gMGeEdCIss6w2/
 uABQ==
X-Gm-Message-State: AOJu0Yw+72yX3KTbd6kk0UvHH077blzj0zOViARseQgei5ZAjzb9+2+b
 +lb5wLaYHCG0kF2+hjtQCcyASRE/UZPtxqn9pKsp25iYspvSqmZm30QHmcKQDa1SOuZ92dYcDjk
 jztutXXJpNxXuMAg=
X-Received: by 2002:a05:6830:411d:b0:6d8:1ec:7845 with SMTP id
 w29-20020a056830411d00b006d801ec7845mr1890920ott.2.1700845492575; 
 Fri, 24 Nov 2023 09:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3nyCiAcUyqx14QypnSgCgGpyuWmndUwft5HuRoqlxl2zqZ/54nJoZAwITuvPkPoVNATesuw==
X-Received: by 2002:a05:6830:411d:b0:6d8:1ec:7845 with SMTP id
 w29-20020a056830411d00b006d801ec7845mr1890861ott.2.1700845492248; 
 Fri, 24 Nov 2023 09:04:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 qh6-20020a0562144c0600b0067a16d12a20sm630548qvb.86.2023.11.24.09.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:04:51 -0800 (PST)
Date: Fri, 24 Nov 2023 18:04:43 +0100
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
Subject: Re: [PATCH V7 5/8] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20231124180443.604d5f99@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-6-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-6-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, 13 Nov 2023 20:12:33 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:


wrt subj: 'cpu-(ctrl)dev change' doesn't make any sense to me, pls rephrase and be more specific.

> CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
> based and existing CPUs AML code assumes _CRS objects would evaluate to a system
> resource which describes IO Port address. But on ARM arch CPUs control
> device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
> evaluate to system resource which describes memory-mapped base address. Update
> build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
> update the _CRS object.


> On x86, CPU Hotplug uses Generic ACPI GPE Block Bit 2 (GPE.2) event handler to
> notify OSPM about any CPU hot(un)plug events. Latest CPU Hotplug is based on
                                                ^^^ latest supported ATM is x86
and not based on GED vvvv, suggest to drop sentence or actually whole paragraph.

> ACPI Generic Event Device framework and uses ACPI GED device for the same. Not
> all architectures support GPE based CPU Hotplug event handler. Hence, make AML
> for GPE.2 event handler conditional.

this is the 2nd different thing the patch does, pls split that into another,
for more on that see related hunk.

> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/acpi/cpu.c         | 23 ++++++++++++++++-------
>  hw/i386/acpi-build.c  |  3 ++-
>  include/hw/acpi/cpu.h |  5 +++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index de1f9295dc..5b0eaad1c5 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -339,9 +339,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_FW_EJECT_EVENT "CEJF"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>                      const char *res_root,
> -                    const char *event_handler_method)
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs)
>  {
>      Aml *ifctx;
>      Aml *field;
> @@ -366,13 +367,19 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
>  
>          crs = aml_resource_template();
> -        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
>                                 ACPI_CPU_HOTPLUG_REG_LEN));
> +        } else {
> +            aml_append(crs, aml_memory32_fixed(base_addr,
> +                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
> +        }
> +
>          aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
>  
>          /* declare CPU hotplug MMIO region with related access fields */
>          aml_append(cpu_ctrl_dev,
> -            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
> +            aml_operation_region("PRST", rs, aml_int(base_addr),
>                                   ACPI_CPU_HOTPLUG_REG_LEN));
>  
>          field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
> @@ -696,9 +703,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>      aml_append(sb_scope, cpus_dev);
>      aml_append(table, sb_scope);
>  
> -    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> +        aml_append(table, method);
> +    }

indeed, injecting a method won't work with GED (and well it's hackish to begin with).
Suggest to get rid of it and make event source initiate the call to CPU_SCAN_METHOD.
Something like (similar to what you do in 4/8): (maybe make it part of 4/8)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 011d2c6c2d..ed35f2390f 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -341,7 +341,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
                     const char *res_root,
-                    const char *event_handler_method)
+                    )
 {
     Aml *ifctx;
     Aml *field;
@@ -696,9 +696,5 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     aml_append(sb_scope, cpus_dev);
     aml_append(table, sb_scope);
 
-    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
-    aml_append(table, method);
-
     g_free(cphp_res_path);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 80db183b78..e740e402bf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1856,6 +1856,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(method, aml_release(aml_name("\\_SB.PCI0.BLCK")));
             }
             aml_append(scope, method);

+            if (!pcmc->legacy_cpu_hotplug) {
...
+                aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
...
             }
         }
         aml_append(dsdt, scope);
     }


>  
>      g_free(cphp_res_path);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3f2b27cf75..f9f31f9db5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,7 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>          };
>          build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
> -                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
> +                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
> +                       AML_SYSTEM_IO);
>      }
>  
>      if (pcms->memhp_io_base && nr_mem) {
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index bc901660fb..b521a4e0de 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -60,9 +60,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
>                                    GArray *entry, bool force_enabled);
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
> -                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
> +                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
>                      const char *res_root,
> -                    const char *event_handler_method);
> +                    const char *event_handler_method,
> +                    AmlRegionSpace rs);
>  
>  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>  


