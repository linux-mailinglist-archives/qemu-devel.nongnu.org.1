Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516C95BF8C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Aug 2024 22:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shER0-0008KV-CY; Thu, 22 Aug 2024 16:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shEQv-0008JV-NE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:29:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shEQs-0001OD-IK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:29:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71433cba1b7so1080921b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724358561; x=1724963361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1bZNp8aIgYT8p1KCbUzK8c7m4JbJyyn7EKuHWb1abT0=;
 b=MuhoEpXMFqyPUepG6PO79gpYCvyCabvgDXCAEJJhpJrAXsrjUMdkBNKA2B6tSgxlfM
 si/9Jk93isI88CmlVGxu9OlopHr78VLWhbWaSzN0iEo1jKxKC3jyEaT88S4W6t29vapw
 KcPbpa6YSq1V5DC8PO3Zl6/sqQsop36jsAgUWLM1gbqF6WC51BFIOa8PnWg+Jx4deYTa
 EqClBHbsCMpyQd3HCqVlrtvaAT0HymCbyrQcQiRNxmrWD58LVstrufjTLgsnbxduVLqa
 bUZqa8PrvhW31lD1WtbcKTlT+2nXCqxFQVw93qmZ0pzw5+pFg2KLtvIHKd7SdIrrEfUQ
 5SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724358561; x=1724963361;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bZNp8aIgYT8p1KCbUzK8c7m4JbJyyn7EKuHWb1abT0=;
 b=QQvv27tDCZe7nNMIV/837X1UEKXwEZdCgMDX/AHz8fCP19dD7i7Pgilqzayn8eTH+N
 3i438DS023j6v3XwpFAnrCMsp5T/0I5XQAk7lDxhiQPgiGzBYcMXkZvQGFU+iqydfgwy
 229Y18dxPSMPTif0/DDYzIhqbf8SXDOsExEH4S2Jexl/RFRIIf4W9TftXH5zYKLIPyTw
 PBkKDr9JK2OkAdqByu0NlT/dOUwajUkcTCSO9ugvWjwpmpWLRTLeny8JV+HEY84wyM2t
 wgFl8LSl8z8Z/3ntQ+x0OurM+l4JQkcczpIRrDMqtl5ZXCagOout+SqdsSM2T4OGsxDR
 LC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHffx/7kAGOpdjLOI5HMrdRVWoWO+bP2v+Ohf+Pk83NKfFcekY/Ah5xIm67TaLLmmgTs6vsI6u8EOQ@nongnu.org
X-Gm-Message-State: AOJu0YzxqhavxUqW23l733EJXGXUKl5F9vqM5HrbhnO9g0iMoO6/K2Gm
 2t0rySgWXd4vTcLr4PuM/c9dqdtRYJMTBE6jyiKSIE7ESiSPN0zrcvkt00ejoyw=
X-Google-Smtp-Source: AGHT+IGT5zPk2OOtVlcujrG+8wjTBonRcPbRSaYkz69ZukwVxDiTM1jFGR2CVVmmOtdTZrMeIvnOhQ==
X-Received: by 2002:a05:6a00:460e:b0:710:9d5e:555c with SMTP id
 d2e1a72fcca58-714458939d7mr205588b3a.23.1724358560848; 
 Thu, 22 Aug 2024 13:29:20 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9abfd5b1sm1785158a12.0.2024.08.22.13.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 13:29:20 -0700 (PDT)
Message-ID: <dbdeebc5-fe10-4f0f-b816-a112afd9f626@ventanamicro.com>
Date: Thu, 22 Aug 2024 17:29:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Add support for generating OpenSBI domains in the
 device tree
To: Gregor Haas <gregorhaas1997@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, alistair.francis@wdc.com
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <20240805210444.497723-2-gregorhaas1997@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240805210444.497723-2-gregorhaas1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 8/5/24 6:04 PM, Gregor Haas wrote:
> OpenSBI has support for domains, which are partitions of CPUs and memory into
> isolated compartments. Domains can be specified in the device tree according to
> a standardized format [1], which OpenSBI parses at boot time to initialize all
> system domains. This patch enables simply specifying domains (and their
> associated memory regions) on the QEMU command line, from which these are then
> rendered into the machine's device tree.
> 
> At machine initialization time, a new create_fdt_opensbi_domains() function
> walks the peripherals/peripherals-anon containers, identifies all domains and
> memregions, and parses them into the relevant device tree structures.
> 
> [1] https://github.com/riscv-software-src/opensbi/blob/master/docs/domain_support.md
> 
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   MAINTAINERS                       |   7 +
>   hw/riscv/Kconfig                  |   4 +
>   hw/riscv/meson.build              |   1 +
>   hw/riscv/opensbi_domain.c         | 542 ++++++++++++++++++++++++++++++
>   hw/riscv/virt.c                   |   3 +
>   include/hw/riscv/opensbi_domain.h |  50 +++
>   6 files changed, 607 insertions(+)
>   create mode 100644 hw/riscv/opensbi_domain.c
>   create mode 100644 include/hw/riscv/opensbi_domain.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98eddf7ae1..796c023a7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -355,6 +355,13 @@ F: target/riscv/XVentanaCondOps.decode
>   F: target/riscv/insn_trans/trans_xventanacondops.c.inc
>   F: disas/riscv-xventana*
>   
> +RISC-V OpenSBI domain support
> +M: Gregor Haas <gregorhaas1997@gmail.com>
> +L: qemu-riscv@nongnu.org
> +S: Maintained
> +F: hw/riscv/opensbi_domain.c
> +F: include/hw/riscv/opensbi_domain.h
> +
>   RENESAS RX CPUs
>   R: Yoshinori Sato <ysato@users.sourceforge.jp>
>   S: Orphan
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..db3a4d77ad 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,6 +1,9 @@
>   config RISCV_NUMA
>       bool
>   
> +config RISCV_OPENSBI_DOMAIN
> +    bool
> +
>   config IBEX
>       bool
>   
> @@ -40,6 +43,7 @@ config RISCV_VIRT
>       imply TPM_TIS_SYSBUS
>       select DEVICE_TREE
>       select RISCV_NUMA
> +    select RISCV_OPENSBI_DOMAIN
>       select GOLDFISH_RTC
>       select PCI
>       select PCI_EXPRESS_GENERIC_BRIDGE
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093..f47626c164 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -1,6 +1,7 @@
>   riscv_ss = ss.source_set()
>   riscv_ss.add(files('boot.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_OPENSBI_DOMAIN', if_true: files('opensbi_domain.c'))
>   riscv_ss.add(files('riscv_hart.c'))
>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> diff --git a/hw/riscv/opensbi_domain.c b/hw/riscv/opensbi_domain.c
> new file mode 100644
> index 0000000000..67a6bab538
> --- /dev/null
> +++ b/hw/riscv/opensbi_domain.c
> @@ -0,0 +1,542 @@
> +#include "qemu/osdep.h"
> +#include "hw/riscv/opensbi_domain.h"
> +#include "hw/boards.h"
> +#include "hw/riscv/virt.h"
> +#include "qapi/error.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/device_tree.h"
> +
> +#include <libfdt.h>
> +
> +static void create_fdt_domain_possible_harts(MachineState *ms,
> +                                             OpenSBIDomainState *s,
> +                                             char *path) {
> +    unsigned long i, cpu;
> +    unsigned long num_cpus;
> +
> +    num_cpus = s->last_possible_hart - s->first_possible_hart + 1;
> +    if (num_cpus) {
> +        g_autofree uint32_t *phandles = g_malloc0_n(num_cpus, sizeof(uint32_t));
> +
> +        for (i = 0, cpu = s->first_possible_hart; i < num_cpus; i++, cpu++) {
> +            g_autofree char *cpu_name = g_strdup_printf("/cpus/cpu@%li", cpu);
> +            phandles[i] = cpu_to_fdt32(qemu_fdt_get_phandle(
> +                    ms->fdt, cpu_name));
> +        }
> +
> +        qemu_fdt_setprop(ms->fdt, path, "possible-harts",
> +                         phandles, num_cpus * 4);
> +    }
> +}
> +
> +static void create_fdt_domain_regions(MachineState *ms,
> +                                      OpenSBIDomainState *s,
> +                                      char *path) {
> +    unsigned long i;
> +    int num_regions = 0;
> +    DeviceState *ds;
> +
> +    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> +        if (s->regions[i]) {
> +            num_regions++;
> +        }
> +    }
> +
> +    if (num_regions) {
> +        g_autofree uint32_t *regions =
> +                 g_malloc0_n(num_regions, 2 * sizeof(uint32_t));
> +        for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> +            if (s->regions[i]) {
> +                ds = DEVICE(s->regions[i]);
> +                g_autofree char *region_name = g_strdup_printf(
> +                       "/chosen/opensbi-domains/%s", ds->id);
> +                regions[2 * i] = cpu_to_fdt32(qemu_fdt_get_phandle
> +                        (ms->fdt, region_name));
> +                regions[2 * i + 1] = cpu_to_fdt32(s->region_perms[i]);
> +            }
> +        }
> +
> +        qemu_fdt_setprop(ms->fdt, path, "regions",
> +                         regions, num_regions * 8);
> +    }
> +}
> +
> +struct DomainFDTState {
> +    MachineState *ms;
> +    bool regions;
> +};
> +
> +static void create_fdt_one_domain(MachineState *ms, OpenSBIDomainState *s)
> +{
> +    DeviceState *ds = DEVICE(s);
> +    g_autofree char *path, *cpu_name;
> +
> +    if (ds->id) {
> +        path = g_strdup_printf("/chosen/opensbi-domains/%s",
> +                               ds->id);
> +    } else {
> +        path = g_strdup_printf("/chosen/opensbi-domains/domain@%lx",
> +                               s->next_addr);
> +    }
> +
> +    qemu_fdt_add_subnode(ms->fdt, path);
> +    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
> +                            "opensbi,domain,instance");
> +    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
> +                           qemu_fdt_alloc_phandle(ms->fdt));
> +
> +    create_fdt_domain_possible_harts(ms, s, path);
> +    create_fdt_domain_regions(ms, s, path);
> +
> +    /* Assign boot hart to this domain */
> +    if (s->boot_hart != -1) {
> +        cpu_name = g_strdup_printf("/cpus/cpu@%i", s->boot_hart);
> +        qemu_fdt_setprop_cell(ms->fdt, path, "boot-hart",
> +                              qemu_fdt_get_phandle(ms->fdt, cpu_name));
> +        if (s->assign) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
> +                                    qemu_fdt_get_phandle(ms->fdt, path));
> +        }
> +    }
> +
> +    if (s->next_arg1 != -1) {
> +        qemu_fdt_setprop_cells(ms->fdt, path, "next-arg1",
> +                             (uint64_t) s->next_arg1 >> 32, s->next_arg1);
> +    }
> +
> +    if (s->next_addr != -1) {
> +        qemu_fdt_setprop_cells(ms->fdt, path, "next-addr",
> +                             (uint64_t) s->next_addr >> 32, s->next_addr);
> +    }
> +
> +    if (s->next_mode != -1) {
> +        qemu_fdt_setprop_cell(ms->fdt, path, "next-mode",
> +                            s->next_mode);
> +    }
> +
> +    if (s->system_reset_allowed) {
> +        qemu_fdt_setprop(ms->fdt, path, "system-reset-allowed", NULL, 0);
> +    }
> +
> +    if (s->system_suspend_allowed) {
> +        qemu_fdt_setprop(ms->fdt, path, "system-suspend-allowed", NULL, 0);
> +    }
> +}
> +
> +static uint32_t create_fdt_one_device(MachineState *ms, char *device)
> +{
> +    uint32_t phandle;
> +    int offs = fdt_path_offset(ms->fdt, device);
> +
> +    if (offs < 0) {
> +        error_report("%s: Could not find device %s: %s", __func__,
> +                     device, fdt_strerror(offs));
> +        exit(1);
> +    }
> +
> +    phandle = fdt_get_phandle(ms->fdt, offs);
> +    if (!phandle) {
> +        phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +        qemu_fdt_setprop_cell(ms->fdt, device, "phandle", phandle);
> +    }
> +
> +    return phandle;
> +}
> +
> +static void create_fdt_one_memregion(MachineState *ms,
> +                                     OpenSBIMemregionState *s)
> +{
> +    g_autofree char *path;
> +    int i, dev, num_devices;
> +    DeviceState *ds = DEVICE(s);
> +
> +    path = g_strdup_printf("/chosen/opensbi-domains/%s", ds->id);
> +    qemu_fdt_add_subnode(ms->fdt, path);
> +    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
> +                            "opensbi,domain,memregion");
> +    qemu_fdt_setprop_cells(ms->fdt, path, "base",
> +                           (uint64_t) s->base >> 32, s->base);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, path, "order",
> +                          (uint32_t) s->order);
> +
> +    if (s->mmio) {
> +        qemu_fdt_setprop(ms->fdt, path, "mmio", NULL, 0);
> +
> +        /* Get all phandles for related devices */
> +        num_devices = 0;
> +        for (i = 0; i < OPENSBI_MEMREGION_DEVICES_MAX; i++) {
> +            if (s->devices[i]) {
> +                num_devices++;
> +            }
> +        }
> +
> +        if (num_devices) {
> +            g_autofree uint32_t *devices =
> +                g_malloc0_n(num_devices, sizeof(uint32_t));
> +            for (i = 0, dev = 0; i < OPENSBI_MEMREGION_DEVICES_MAX &&
> +                                 dev < num_devices; i++) {
> +                if (s->devices[i]) {
> +                    devices[dev++] = create_fdt_one_device(ms,
> +                                                         s->devices[i]);
> +                }
> +            }
> +
> +            qemu_fdt_setprop(ms->fdt, path, "devices", devices,
> +                             num_devices * 4);
> +        }
> +    }
> +
> +    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
> +                           qemu_fdt_alloc_phandle(ms->fdt));
> +}
> +
> +static int create_fdt_domains(Object *obj, void *opaque)
> +{
> +    struct DomainFDTState *dfs = opaque;
> +    OpenSBIDomainState *osds;
> +    OpenSBIMemregionState *osms;
> +
> +    osds = (OpenSBIDomainState *)
> +            object_dynamic_cast(obj, TYPE_OPENSBI_DOMAIN);
> +    osms = (OpenSBIMemregionState *)
> +            object_dynamic_cast(obj, TYPE_OPENSBI_MEMREGION);
> +
> +    if (dfs->regions) {
> +        if (osms) {
> +            create_fdt_one_memregion(dfs->ms, osms);
> +        }
> +    } else {
> +        if (osds) {
> +            create_fdt_one_domain(dfs->ms, osds);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const char *containers[] = {
> +        "/peripheral", "/peripheral-anon"
> +};
> +
> +void create_fdt_opensbi_domains(MachineState *s)
> +{
> +    int i;
> +    MachineState *ms = MACHINE(s);
> +    Object *container;
> +
> +    struct DomainFDTState check = {
> +            .ms = ms,
> +            .regions = true
> +    };
> +
> +    /* Make sure that top-level node exists */
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen/opensbi-domains");
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen/opensbi-domains",
> +                            "compatible", "opensbi,domain,config");
> +
> +    /* Do a scan through regions first */
> +    for (i = 0; i < ARRAY_SIZE(containers); i++) {
> +        container = container_get(OBJECT(s), containers[i]);
> +        object_child_foreach(container, create_fdt_domains, &check);
> +    }
> +
> +    /* Then scan through domains */
> +    check.regions = false;
> +    for (i = 0; i < ARRAY_SIZE(containers); i++) {
> +        container = container_get(OBJECT(s), containers[i]);
> +        object_child_foreach(container, create_fdt_domains, &check);
> +    }
> +}
> +
> +/* OpenSBI Memregions */
> +
> +static void set_mmio(Object *obj, bool val, Error **err)
> +{
> +    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
> +    s->mmio = val;
> +}
> +
> +static void set_device(Object *obj, const char *val, Error **err)
> +{
> +    int i;
> +    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
> +
> +    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> +        if (!s->devices[i]) {
> +            s->devices[i] = g_strdup(val);
> +            break;
> +        }
> +    }
> +}
> +
> +static void opensbi_memregion_instance_init(Object *obj)
> +{
> +    int i;
> +    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
> +
> +    s->base = -1;
> +    object_property_add_uint64_ptr(obj, "base", &s->base,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "base",
> +                                    "The base address of the domain memory region. If \"order\" is also specified, "
> +                                    "this property should be a 2 ^ order aligned 64 bit address");
> +
> +    s->order = -1;
> +    object_property_add_uint32_ptr(obj, "order", &s->order,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "order",
> +                                    "The order of the domain memory region. This property should have a 32 bit value "
> +                                    "(i.e. one DT cell) in the range 3 <= order <= __riscv_xlen.");
> +
> +    s->mmio = false;
> +    object_property_add_bool(obj, "mmio", NULL, set_mmio);
> +    object_property_set_description(obj, "mmio",
> +                                    "A boolean flag representing whether the domain memory region is a "
> +                                    "memory-mapped I/O (MMIO) region.");
> +
> +    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> +        g_autofree char *propname = g_strdup_printf("device%i", i);
> +        object_property_add_str(obj, propname, NULL, set_device);
> +
> +        g_autofree char *description = g_strdup_printf(
> +                "Device %i (out of %i) for this memregion. This property should be a device tree path to the device.",
> +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> +        object_property_set_description(obj, propname, description);
> +    }
> +}
> +
> +static void opensbi_memregion_realize(DeviceState *ds, Error **errp)
> +{
> +    #if defined(TARGET_RISCV32)
> +    int xlen = 32;
> +    #elif defined(TARGET_RISCV64)
> +    int xlen = 64;
> +    #endif
> +
> +    OpenSBIMemregionState *s = OPENSBI_MEMREGION(ds);
> +
> +    if (s->base == -1) {
> +        error_setg(errp, "must specify base");
> +        return;
> +    }
> +
> +    if (s->order == -1) {
> +        error_setg(errp, "must specify order");
> +        return;
> +    }
> +
> +    /* Check order bounds */
> +    if (s->order < 3 || s->order > xlen) {
> +        error_setg(errp, "order must be between 3 and %d", xlen);
> +        return;
> +    }
> +
> +    /* Check base alignment */
> +    if (s->order < xlen && (s->base & (BIT(s->order) - 1))) {
> +        error_setg(errp, "base not aligned to order");
> +        return;
> +    }
> +}
> +
> +static void opensbi_memregion_class_init(ObjectClass *oc, void *opaque)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    dc->realize = opensbi_memregion_realize;
> +}
> +
> +static const TypeInfo opensbi_memregion_info = {
> +        .name = TYPE_OPENSBI_MEMREGION,
> +        .parent = TYPE_DEVICE,
> +        .instance_init = opensbi_memregion_instance_init,
> +        .instance_size = sizeof(OpenSBIDomainState),
> +        .class_init = opensbi_memregion_class_init
> +};
> +
> +/* OpenSBI Domains */
> +
> +static void set_sysreset_allowed(Object *obj, bool val, Error **err)
> +{
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
> +    s->system_reset_allowed = val;
> +}
> +
> +static void set_suspend_allowed(Object *obj, bool val, Error **err)
> +{
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
> +    s->system_suspend_allowed = val;
> +}
> +
> +static void set_assign(Object *obj, bool val, Error **err)
> +{
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
> +    s->assign = val;
> +}
> +
> +static void set_possible_harts(Object *obj, const char *str, Error **err)
> +{
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
> +    const char *firstcpu,  *firstcpu_end, *lastcpu;
> +
> +    firstcpu = str;
> +    if (qemu_strtoul(firstcpu, &firstcpu_end, 0,
> +                     &s->first_possible_hart) < 0) {
> +        error_setg(err, "could not convert firstcpu");
> +        return;
> +    }
> +
> +    lastcpu = qemu_strchrnul(str, '-');
> +    if (*lastcpu) {
> +        if (lastcpu != firstcpu_end) {
> +            error_setg(err, "could not separate firstcpu and lastcpu");
> +            return;
> +        }
> +
> +        lastcpu++;
> +        if (qemu_strtoul(lastcpu, NULL, 0,
> +                         &s->last_possible_hart) < 0) {
> +            error_setg(err, "could not convert lastcpu");
> +            return;
> +        }
> +    } else {
> +        s->last_possible_hart = s->first_possible_hart;
> +    }
> +}
> +
> +static void opensbi_domain_instance_init(Object *obj)
> +{
> +    int i;
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
> +
> +    s->boot_hart = VIRT_CPUS_MAX;
> +    object_property_add_uint32_ptr(obj, "boot-hart", &s->boot_hart,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "boot-hart",
> +                                    "The HART booting the domain instance.");
> +
> +    s->first_possible_hart = -1;
> +    s->last_possible_hart = -1;
> +    object_property_add_str(obj, "possible-harts", NULL, set_possible_harts);
> +    object_property_set_description(obj, "possible-harts",
> +                                    "The contiguous list of CPUs for the domain instance, specified as firstcpu[-lastcpu]");
> +
> +    s->next_arg1 = -1;
> +    object_property_add_uint64_ptr(obj, "next-arg1", &s->next_arg1,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "next-arg1",
> +                                    "The 64 bit next booting stage arg1 for the domain instance.");
> +
> +    s->next_addr = -1;
> +    object_property_add_uint64_ptr(obj, "next-addr", &s->next_addr,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "next-addr",
> +                                    "The 64 bit next booting stage address for the domain instance.");
> +
> +    s->next_mode = -1;
> +    object_property_add_uint32_ptr(obj, "next-mode", &s->next_mode,
> +                                   OBJ_PROP_FLAG_WRITE);
> +    object_property_set_description(obj, "next-mode",
> +                                    "The 32 bit next booting stage mode for the domain instance.");
> +
> +    s->system_reset_allowed = false;
> +    object_property_add_bool(obj, "system-reset-allowed", NULL,
> +                             set_sysreset_allowed);
> +    object_property_set_description(obj, "system-reset-allowed",
> +                                    "Whether the domain instance is allowed to do system reset.");
> +
> +    s->system_suspend_allowed = false;
> +    object_property_add_bool(obj, "system-suspend-allowed", NULL,
> +                             set_suspend_allowed);
> +    object_property_set_description(obj, "system-suspend-allowed",
> +                                    "Whether the domain instance is allowed to do system suspend.");
> +
> +    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> +        s->regions[i] = NULL;
> +        g_autofree char *reg_propname = g_strdup_printf("region%i", i);
> +        object_property_add_link(obj, reg_propname, TYPE_OPENSBI_MEMREGION,
> +                                 (Object **) &s->regions[i],
> +                                 qdev_prop_allow_set_link_before_realize, 0);
> +
> +        g_autofree char *reg_description = g_strdup_printf(
> +                "Region %i (out of %i) for this domain.",
> +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> +        object_property_set_description(obj, reg_propname, reg_description);
> +
> +        s->region_perms[i] = 0;
> +        g_autofree char *perm_propname = g_strdup_printf("perms%i", i);
> +        object_property_add_uint32_ptr(obj, perm_propname, &s->region_perms[i],
> +                                       OBJ_PROP_FLAG_WRITE);
> +
> +        g_autofree char *perm_description = g_strdup_printf(
> +                "Permissions for region %i for this domain.", i);
> +        object_property_set_description(obj, perm_propname, perm_description);
> +    }
> +
> +    object_property_add_bool(obj, "assign", NULL, set_assign);
> +    object_property_set_description(obj, "assign",
> +                                    "Whether to assign this domain to its boot hart.");
> +}
> +
> +static void opensbi_domain_realize(DeviceState *ds, Error **errp)
> +{
> +    OpenSBIDomainState *s = OPENSBI_DOMAIN(ds);
> +
> +    if (s->boot_hart >= VIRT_CPUS_MAX) {
> +        error_setg(errp, "boot hart larger than maximum number of CPUs (%d)",
> +                 VIRT_CPUS_MAX);
> +        return;
> +    }
> +
> +    if (s->first_possible_hart == -1) {
> +        if (s->last_possible_hart != -1) {
> +            error_setg(errp,
> +                     "last possible hart set when first possible hart unset");
> +            return;
> +        }
> +    } else {
> +        if (s->first_possible_hart >= VIRT_CPUS_MAX) {
> +            error_setg(errp,
> +                     "first possible hart larger than maximum number of CPUs (%d)",
> +                     VIRT_CPUS_MAX);
> +            return;
> +        }
> +
> +        if (s->last_possible_hart != -1) {
> +            if (s->last_possible_hart < s->first_possible_hart) {
> +                error_setg(errp,
> +                         "last possible hart larger than first possible hart");
> +                return;
> +            }
> +
> +            if (s->last_possible_hart >= VIRT_CPUS_MAX) {
> +                error_setg(errp,
> +                         "last possible hart larger than maximum number of CPUS (%d)",
> +                         VIRT_CPUS_MAX);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +static void opensbi_domain_class_init(ObjectClass *oc, void *opaque)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    dc->realize = opensbi_domain_realize;
> +}
> +
> +static const TypeInfo opensbi_domain_info = {
> +        .name = TYPE_OPENSBI_DOMAIN,
> +        .parent = TYPE_DEVICE,
> +        .instance_init = opensbi_domain_instance_init,
> +        .instance_size = sizeof(OpenSBIDomainState),
> +        .class_init = opensbi_domain_class_init
> +};
> +
> +static void opensbi_register_types(void)
> +{
> +    type_register_static(&opensbi_domain_info);
> +    type_register_static(&opensbi_memregion_info);
> +}
> +
> +type_init(opensbi_register_types)
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9981e0f6c9..bb4bf3ce5b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,7 @@
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> +#include "hw/riscv/opensbi_domain.h"
>   
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia(RISCVVirtState *s)
> @@ -1051,6 +1052,8 @@ static void finalize_fdt(RISCVVirtState *s)
>       create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
>   
>       create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> +
> +    create_fdt_opensbi_domains(MACHINE(s));
>   }
>   
>   static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> diff --git a/include/hw/riscv/opensbi_domain.h b/include/hw/riscv/opensbi_domain.h
> new file mode 100644
> index 0000000000..bcce16a609
> --- /dev/null
> +++ b/include/hw/riscv/opensbi_domain.h
> @@ -0,0 +1,50 @@
> +
> +#ifndef RISCV_DOMAIN_H
> +#define RISCV_DOMAIN_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "cpu.h"
> +
> +#define TYPE_OPENSBI_MEMREGION "opensbi-memregion"
> +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIMemregionState, OPENSBI_MEMREGION)
> +
> +#define OPENSBI_MEMREGION_DEVICES_MAX   16
> +
> +struct OpenSBIMemregionState {
> +    /* public */
> +    DeviceState parent_obj;
> +
> +    /* private */
> +    uint64_t base;
> +    uint32_t order;
> +    bool mmio;
> +    char *devices[OPENSBI_MEMREGION_DEVICES_MAX];
> +};
> +
> +#define TYPE_OPENSBI_DOMAIN "opensbi-domain"
> +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIDomainState, OPENSBI_DOMAIN)
> +
> +#define OPENSBI_DOMAIN_MEMREGIONS_MAX   16
> +
> +struct OpenSBIDomainState {
> +    /* public */
> +    DeviceState parent_obj;
> +
> +    /* private */
> +    OpenSBIMemregionState *regions[OPENSBI_DOMAIN_MEMREGIONS_MAX];
> +    unsigned int region_perms[OPENSBI_DOMAIN_MEMREGIONS_MAX];
> +    unsigned long first_possible_hart, last_possible_hart;
> +    unsigned int boot_hart;
> +    uint64_t next_arg1;
> +    uint64_t next_addr;
> +    uint32_t next_mode;
> +    bool system_reset_allowed;
> +    bool system_suspend_allowed;
> +
> +    bool assign;
> +};
> +
> +void create_fdt_opensbi_domains(MachineState *s);
> +
> +#endif /* RISCV_DOMAIN_H */

