Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01270D85F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 11:05:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Nvp-0005KW-As; Tue, 23 May 2023 05:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1q1Nvm-0005Jc-W6; Tue, 23 May 2023 05:03:47 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1q1Nvk-000825-Hw; Tue, 23 May 2023 05:03:46 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 439FE60806FA;
 Tue, 23 May 2023 11:03:34 +0200 (CEST)
Message-ID: <6dc2e78d-319d-d1de-5d1a-6fdbbbdfe713@csgraf.de>
Date: Tue, 23 May 2023 11:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] hw/ppc/e500plat: Fix modifying QOM class internal
 state from instance
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>, Stuart Yoder <stuart.yoder@freescale.com>
References: <20230523064408.57941-1-philmd@linaro.org>
 <20230523064408.57941-3-philmd@linaro.org>
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20230523064408.57941-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

Hi Philippe,

On 23.05.23 08:44, Philippe Mathieu-Daudé wrote:
> QOM object instance should not modify its class state (because
> all other objects instanciated from this class get affected).
>
> Instead of modifying the PPCE500MachineClass 'mpic_version' field
> in the instance machine_init() handler, set it in the machine
> class init handler (e500plat_machine_class_init).
>
> Inspired-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/e500plat.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 3032bd3f6d..c3b0ed01cf 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -30,18 +30,6 @@ static void e500plat_fixup_devtree(void *fdt)
>                        sizeof(compatible));
>   }
>   
> -static void e500plat_init(MachineState *machine)
> -{
> -    PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
> -    /* Older KVM versions don't support EPR which breaks guests when we announce
> -       MPIC variants that support EPR. Revert to an older one for those */
> -    if (kvm_enabled() && !kvmppc_has_cap_epr()) {
> -        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
> -    }
> -
> -    ppce500_init(machine);


Won't this drop the call to ppce500_init(machine)?

> -}
> -
>   static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **errp)
>   {
> @@ -81,7 +69,6 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
>       pmc->pci_first_slot = 0x1;
>       pmc->pci_nr_slots = PCI_SLOT_MAX - 1;
>       pmc->fixup_devtree = e500plat_fixup_devtree;
> -    pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_42;
>       pmc->has_mpc8xxx_gpio = true;
>       pmc->has_esdhc = true;
>       pmc->platform_bus_base = 0xf00000000ULL;
> @@ -94,8 +81,18 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
>       pmc->pci_mmio_bus_base = 0xE0000000ULL;
>       pmc->spin_base = 0xFEF000000ULL;
>   
> +    if (kvm_enabled() && !kvmppc_has_cap_epr()) {
> +        /*
> +         * Older KVM versions don't support EPR which breaks guests when
> +         * we announce MPIC variants that support EPR. Revert to an older
> +         * one for those.
> +         */
> +        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_20;
> +    } else {
> +        pmc->mpic_version = OPENPIC_MODEL_FSL_MPIC_42;
> +    }
> +
>       mc->desc = "generic paravirt e500 platform";
> -    mc->init = e500plat_init;


I suppose best would be to just put it in here instead of e500plat_init?


Alex


>       mc->max_cpus = 32;
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
>       mc->default_ram_id = "mpc8544ds.ram";

