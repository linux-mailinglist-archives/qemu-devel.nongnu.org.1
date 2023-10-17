Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9887CC8EE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsn1p-0007hi-1i; Tue, 17 Oct 2023 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsn1m-0007hL-Rs
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:34:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsn1l-00044n-AL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:34:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 584D17456A7;
 Tue, 17 Oct 2023 18:33:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2095A745681; Tue, 17 Oct 2023 18:33:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1F6BB7456AA;
 Tue, 17 Oct 2023 18:33:31 +0200 (CEST)
Date: Tue, 17 Oct 2023 18:33:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 08/11] hw/hppa: Export machine name, BTLBs, power-button
 address via fw_cfg
In-Reply-To: <20231017154645.95844-9-deller@kernel.org>
Message-ID: <5a4278fe-461b-5ec6-852b-d77371babf7a@eik.bme.hu>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-9-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 17 Oct 2023, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> Provide necessary info to SeaBIOS-hppa.

If this is needed by the updated SeaBIOS in patch 1 shouldn't this come 
before that?

Regards,
BALATON Zoltan

> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> hw/hppa/machine.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index c6d8deffcf..de925259ea 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -118,11 +118,13 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
> }
>
> -static FWCfgState *create_fw_cfg(MachineState *ms)
> +static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus)
> {
>     FWCfgState *fw_cfg;
>     uint64_t val;
>     const char qemu_version[] = QEMU_VERSION;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    int len;
>
>     fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
> @@ -137,8 +139,20 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
>                     g_memdup(&val, sizeof(val)), sizeof(val));
>
> +    val = cpu_to_le64(HPPA_BTLB_ENTRIES);
> +    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
> +                    g_memdup(&val, sizeof(val)), sizeof(val));
> +
> +    len = strlen(mc->name) + 1;
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
> +                    g_memdup(mc->name, len), len);
> +
>     val = cpu_to_le64(HPA_POWER_BUTTON);
> -    fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
> +                    g_memdup(&val, sizeof(val)), sizeof(val));
> +
> +    val = cpu_to_le64(CPU_HPA + 24);
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
>                     g_memdup(&val, sizeof(val)), sizeof(val));
>
>     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
> @@ -148,6 +162,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>                     g_memdup(qemu_version, sizeof(qemu_version)),
>                     sizeof(qemu_version));
>
> +    fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
> +
>     return fw_cfg;
> }
>
> @@ -250,7 +266,7 @@ static void machine_hppa_init(MachineState *machine)
>                      parallel_hds[0]);
>
>     /* fw_cfg configuration interface */
> -    create_fw_cfg(machine);
> +    create_fw_cfg(machine, pci_bus);
>
>     /* SCSI disk setup. */
>     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>

