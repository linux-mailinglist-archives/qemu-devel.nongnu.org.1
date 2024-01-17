Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D158E830EBF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDjx-0003Xr-5j; Wed, 17 Jan 2024 16:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rQDju-0003XA-Fy; Wed, 17 Jan 2024 16:46:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rQDjr-0003Yr-VD; Wed, 17 Jan 2024 16:46:26 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TFfXH5MNVz6K5Xl;
 Thu, 18 Jan 2024 05:43:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D3934140519;
 Thu, 18 Jan 2024 05:46:12 +0800 (CST)
Received: from localhost (10.48.153.213) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 21:46:11 +0000
Date: Wed, 17 Jan 2024 21:46:08 +0000
To: Salil Mehta via <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@huawei.com>, <qemu-arm@nongnu.org>,
 <maz@kernel.org>, <jean-philippe@linaro.org>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: Re: [PATCH RFC V2 19/37] hw/acpi: ACPI/AML Changes to reflect the
 correct _STA.{PRES, ENA} Bits to Guest
Message-ID: <20240117214608.00007d1b@Huawei.com>
In-Reply-To: <20230926100436.28284-20-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-20-salil.mehta@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.213]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 26 Sep 2023 11:04:18 +0100
Salil Mehta via <qemu-devel@nongnu.org> wrote:

> ACPI AML changes to properly reflect the _STA.PRES and _STA.ENA Bits to the
> guest during initialzation, when CPUs are hotplugged and after CPUs are
> hot-unplugged.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Hi Salil,

Just brought up a qemu on qemu test setup again to poke
the kernel series and hopefully resolve a few questions there.
Ran into a trivial problem in which the kernel was trying and
failing to attach an ACPI handler before these were hotplugged.
Came down to the kernel code now treating functional in _STA as
meaning can be enumerated and effectively
ignoring all the other bits.

Requires a change to the value presented by default...
See below.  Fix may well be completely wrong even though it works ;)

Thanks,

Jonathan

> ---
>  hw/acpi/cpu.c                  | 49 +++++++++++++++++++++++++++++++---
>  hw/acpi/generic_event_device.c | 11 ++++++++
>  include/hw/acpi/cpu.h          |  2 ++
>  3 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 232720992d..e1299696d3 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -63,10 +63,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>      cdev = &cpu_st->devs[cpu_st->selector];
>      switch (addr) {
>      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
> -        val |= cdev->cpu ? 1 : 0;
> +        val |= cdev->is_enabled ? 1 : 0;
>          val |= cdev->is_inserting ? 2 : 0;
>          val |= cdev->is_removing  ? 4 : 0;
>          val |= cdev->fw_remove  ? 16 : 0;
> +        val |= cdev->is_present ? 32 : 0;
>          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>          break;
>      case ACPI_CPU_CMD_DATA_OFFSET_RW:
> @@ -228,7 +229,21 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>          struct CPUState *cpu = CPU(id_list->cpus[i].cpu);
>          if (qemu_present_cpu(cpu)) {
>              state->devs[i].cpu = cpu;
> +            state->devs[i].is_present = true;
> +        } else {
> +            if (qemu_persistent_cpu(cpu)) {
> +                state->devs[i].is_present = true;
> +            } else {
> +                state->devs[i].is_present = false;
> +            }
>          }
> +
> +        if (qemu_enabled_cpu(cpu)) {
> +            state->devs[i].is_enabled = true;
> +        } else {
> +            state->devs[i].is_enabled = false;
> +        }
> +
>          state->devs[i].arch_id = id_list->cpus[i].arch_id;
>      }
>      memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
> @@ -261,6 +276,8 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>      }
>  
>      cdev->cpu = CPU(dev);
> +    cdev->is_present = true;
> +    cdev->is_enabled = true;
>      if (dev->hotplugged) {
>          cdev->is_inserting = true;
>          acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
> @@ -292,6 +309,11 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
>          return;
>      }
>  
> +    cdev->is_enabled = false;
> +    if (!qemu_persistent_cpu(CPU(dev))) {
> +        cdev->is_present = false;
> +    }
> +
>      cdev->cpu = NULL;
>  }
>  
> @@ -302,6 +324,8 @@ static const VMStateDescription vmstate_cpuhp_sts = {
>      .fields      = (VMStateField[]) {
>          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
>          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
> +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),
>          VMSTATE_UINT32(ost_event, AcpiCpuStatus),
>          VMSTATE_UINT32(ost_status, AcpiCpuStatus),
>          VMSTATE_END_OF_LIST()
> @@ -339,6 +363,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPU_REMOVE_EVENT  "CRMV"
>  #define CPU_EJECT_EVENT   "CEJ0"
>  #define CPU_FW_EJECT_EVENT "CEJF"
> +#define CPU_PRESENT       "CPRS"
>  
>  void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      hwaddr base_addr,
> @@ -399,7 +424,9 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>          /* tell firmware to do device eject, write only */
>          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> -        aml_append(field, aml_reserved_field(3));
> +        /* 1 if present, read only */
> +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> +        aml_append(field, aml_reserved_field(2));
>          aml_append(field, aml_named_field(CPU_COMMAND, 8));
>          aml_append(cpu_ctrl_dev, field);
>  
> @@ -429,6 +456,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
>          Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
>          Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
> +        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
>          Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
>          Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
>          Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
> @@ -457,13 +485,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          {
>              Aml *idx = aml_arg(0);
>              Aml *sta = aml_local(0);
> +            Aml *ifctx2;
> +            Aml *else_ctx;
>  
>              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>              aml_append(method, aml_store(idx, cpu_selector));
>              aml_append(method, aml_store(zero, sta));
> -            ifctx = aml_if(aml_equal(is_enabled, one));
> +            ifctx = aml_if(aml_equal(is_present, one));
>              {
> -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> +                ifctx2 = aml_if(aml_equal(is_enabled, one));
> +                {
> +                    /* cpu is present and enabled */
> +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
> +                }
> +                aml_append(ifctx, ifctx2);
> +                else_ctx = aml_else();
> +                {
> +                    /* cpu is present but disabled */
> +                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
For the current kernel patches, functional should not be set. So this should
be something like 0x5.

> +                }
> +                aml_append(ifctx, else_ctx);
>              }
>              aml_append(method, ifctx);
>              aml_append(method, aml_release(ctrl_lock));

