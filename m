Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08A8075E4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:58:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvCj-0008R8-4q; Wed, 06 Dec 2023 11:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rAvCg-0008Pa-Gl; Wed, 06 Dec 2023 11:56:54 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rAvCd-0006ZN-Mm; Wed, 06 Dec 2023 11:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701881811; x=1733417811;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NKRjgHaEJWXCNvOaNv7NW1iG2Gx8MCRVSiENZF8b5oI=;
 b=QLXPlP0s8wj6uY6PlmD1tuLw8ZmnOIPcVMzajYBrFSY0U9Fm+REPra4o
 BgHq7EWovDp8J5Njj6JdGp+PolUweCaJ3Az+avBGxM2pXuM0MyJi9gbwE
 ZcxhIcDknY6ou9jFxRdEbgHQWUNbdBrkA0RHKO9FTYFI1vqAgzbj65ebg
 XjfslaCb93YN7v71SqRC1oWa38aW9dvzUusLpYBF2WKvIf2q9i7AwV+Pb
 jvFEvrOAzQRFRVxZdfN8OQ0GuHtMsEzx+1HBpocHjrc1LCkt9XrCHsAyw
 QRpKbG6RK3TrgqJ76BCETbDiRYRSYl6/vAS4ZWFtdBiG1aV74lyQAVPYu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391259273"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; d="scan'208";a="391259273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 08:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018628339"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; d="scan'208";a="1018628339"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2023 08:56:35 -0800
Date: Thu, 7 Dec 2023 01:08:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, maz@kernel.org,
 jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, linuxarm@huawei.com
Subject: Re: [PATCH V7 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Message-ID: <ZXCqp32ggIFvUweu@intel.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-4-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113201236.30668-4-salil.mehta@huawei.com>
Received-SPF: pass client-ip=192.55.52.93; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

On Mon, Nov 13, 2023 at 08:12:31PM +0000, Salil Mehta via wrote:
> Date: Mon, 13 Nov 2023 20:12:31 +0000
> From: Salil Mehta via <qemu-devel@nongnu.org>
> Subject: [PATCH V7 3/8] hw/acpi: Update ACPI GED framework to support vCPU
>  Hotplug
> X-Mailer: git-send-email 2.8.3
> 

[snip]

> @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>      sysbus_init_mmio(sbd, &ged_st->regs);
> +
> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
> +                       ACPI_CPU_HOTPLUG_REG_LEN);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
> +                        &s->cpuhp_state, 0);

I find this cpu_hotplug_hw_init() can still cause qtest errors on x86
platforms as you mentioned in v6: https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net/T/#m108f102b2fe92b7dd7218f2f942f7b233a9d6af3

IIUC, microvm machine has its own 'possible_cpus_arch_ids' and that is
inherited from its parent x86 machine.

The above error is because device-introspect-test sets the none-machine:

# starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3094820.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3094820.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -nodefaults -machine none -accel qtest

So what about just checking mc->possible_cpu_arch_ids instead of an
assert in cpu_hotplug_hw_init()?

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 4b24a2500361..303f1f1f57bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -221,7 +221,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     const CPUArchIdList *id_list;
     int i;

-    assert(mc->possible_cpu_arch_ids);
+    if (!mc->possible_cpu_arch_ids) {
+        return;
+    }
+
     id_list = mc->possible_cpu_arch_ids(machine);
     state->dev_count = id_list->len;
     state->devs = g_new0(typeof(*state->devs), state->dev_count);

This check seems to be acceptable in the general code path? Not all machines
have possible_cpu_arch_ids, after all.

Thanks,
Zhao

>  }
>  
>  static void acpi_ged_class_init(ObjectClass *class, void *data)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce0214..90fc41cbb8 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -60,6 +60,7 @@
>  #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>  
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
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -106,6 +108,8 @@ struct AcpiGedState {
>      SysBusDevice parent_obj;
>      MemHotplugState memhp_state;
>      MemoryRegion container_memhp;
> +    CPUHotplugState cpuhp_state;
> +    MemoryRegion container_cpuhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
>      qemu_irq irq;
> -- 
> 2.34.1
> 
> 

