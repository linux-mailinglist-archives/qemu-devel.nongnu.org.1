Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8BB35EEA
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Aug 2025 14:13:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsXu-0001QE-Dz; Tue, 26 Aug 2025 08:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsXe-0001NN-Ku
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:12:47 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqsXV-0006iU-7w
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756210358; x=1787746358;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=WhassqupnqkOf72vLKM6R9tmUwJdpwM0nIHLpy3jHdo=;
 b=ZRYRk5wyuudrjl0fZOTR29dM67kxNNb11FNE2QKtbFQCAfjulZP1blRE
 ZZMgRL+QLYdnpX1RuM0gODu39O6GqhWc2XHzr4WitxlCy2u7RujQ9AyJx
 IxO5SIdSLeEInQ8JA+mSUarhd23vQBw/mRTEZj/aUJQm/72mjpBAjeMFV
 pBpAsVOjcCGb5MgNozN3CCnQ1MOOPNhZTl21IZ89Rff3XSooMkPT/5RZJ
 FrlDlWzeP4ikFqpskDSGEDq7Z+8CZrEHyDd5pj66u+grUIt64aiiZz9ev
 UO8rTxccv7tX6jBDs7dfPYLgFhCEiimfKSEwGpgPtyLxkmWIzroo1zWW1 A==;
X-CSE-ConnectionGUID: nCeC98wsTXOLMim0VHms5Q==
X-CSE-MsgGUID: sAw28ZlOTJmmx2uVyHH4CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62274855"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62274855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:12:31 -0700
X-CSE-ConnectionGUID: frfB08ADR4WMFsoFwKIFyg==
X-CSE-MsgGUID: JkoMsM0zSI6Ibn7xZDmiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="206723773"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:12:29 -0700
Message-ID: <1a18ee50-2591-4ff7-b43c-141523302e11@intel.com>
Date: Tue, 26 Aug 2025 20:12:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/19] hw/i386/isapc.c: replace rom_memory with
 system_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-20-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-20-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.751,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 8/22/2025 8:12 PM, Mark Cave-Ayland wrote:
> Now that we can guarantee the isapc machine will never have a PCI bus, any
> instances of rom_memory can be replaced by system_memory and rom_memory
> removed completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/isapc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 62acdada3e..87193beb44 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -37,7 +37,6 @@ static void pc_init_isa(MachineState *machine)
>       ISABus *isa_bus;
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
> -    MemoryRegion *rom_memory = system_memory;
>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       uint32_t irq;
>       int i;
> @@ -76,7 +75,7 @@ static void pc_init_isa(MachineState *machine)
>   
>       /* allocate ram and load rom/bios */
>       if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
> +        pc_memory_init(pcms, system_memory, system_memory, 0);
>       } else {
>           assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                       x86ms->above_4g_mem_size);


