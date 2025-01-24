Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69418A1B77E
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 14:54:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbK7f-0000i2-Pr; Fri, 24 Jan 2025 08:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbK7b-0000hY-IZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:53:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbK7Y-0006Vw-BX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737726797; x=1769262797;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=67rDz6BHsGdGw5DKljt0RG9iB3nrPb4VjqyPp4LpTXY=;
 b=mezIoZN/PlP01BmlmB7jyxwbJgPcvV+8I/p3lUc2NKbanPurdP1Ougus
 rXRDYUcvdVfbUkroadROsAK2V+nuu++lyuaSqr0lHJ5p61iMoKR9058wV
 HDZgXyYAfhilgRWLUiHQuwkJxnII3ABFS/LntEuyfdjk6BD5h0PmYmkId
 njJbCn5J9sj93jZS838Bj3jakUb38S6yp+7xQM6OxT7hnGUAbXmwKm7Ze
 TZDMP4iylO6tnSQ5nwLsEegltgmsUV2zo9TWoZ/HB0ZX64pLBEFSH/HGE
 QA31k0hZFrwvTxyB2JjFRyZNJR0/aJBUGN7hyMrqa6qC1qqKyal6kEg7M Q==;
X-CSE-ConnectionGUID: 9KYVkc7ERVuYEhL3au28oQ==
X-CSE-MsgGUID: zjPIyE29TKyEZ+EpaC/uYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38404384"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="38404384"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:53:13 -0800
X-CSE-ConnectionGUID: afm8EiATRAixOqj8ztxS0A==
X-CSE-MsgGUID: sdhES3QZQRSjxaeHK3Vdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112905370"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:53:08 -0800
Message-ID: <04ac7fdc-6518-455b-b1b0-ffa713aa8136@intel.com>
Date: Fri, 24 Jan 2025 21:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 41/60] hw/i386: add option to forcibly report edge
 trigger in acpi tables
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, rick.p.edgecombe@intel.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-42-xiaoyao.li@intel.com>
 <Z1tmG63P4TR0UYO8@iweiny-mobl>
 <e97102e9-9c38-46a9-912a-0ccc7753f560@intel.com>
 <20250123135349.3b58f67b@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250123135349.3b58f67b@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/23/2025 8:53 PM, Igor Mammedov wrote:
> On Tue, 14 Jan 2025 21:01:27 +0800
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> On 12/13/2024 6:39 AM, Ira Weiny wrote:
>>> On Tue, Nov 05, 2024 at 01:23:49AM -0500, Xiaoyao Li wrote:
>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>
>>>> When level trigger isn't supported on x86 platform,
> 
> it used to be level before this patch like for forever, so either
> we have a bug or above statement isn't correct.

This patch originated from Isaku.

As you said, almost all of the ACPI info tell Level triggere before. I'm 
not sure just changing Level trigger to Edge trigger in ACPI would be 
sufficient. I need to learn and think carefully on it.

So I will drop this patch and the one before, for next sereis 
submission. And I will submit the new version of this one later separately.

Thanks!

>>>> forcibly report edge trigger in acpi tables.
>>>
>>> This commit message is pretty sparse.  I was thinking of suggesting to squash
>>> this with patch 40 but it occurred to me that perhaps these are split to accept
>>> TDX specifics from general functionality.  Is that the case here?  Is that true
>>> with other patches in the series?  If so what other situations would require
>>> this in the generic code beyond TDX?
>>
>> The goal is trying to avoid adding TDX specific all around QEMU. So we
>> are trying to add new general interface as a patch and TDX uses the
>> interface as another patch.
> 
> in other words level trigger is not supported when TDX is enable,
> do I get it right?

yes.

> If yes, then mention it in commit message and also mention
> followup patch which would use this.
> 
> see my other comments below.
>   
>>
>>> Ira
>>>    
>>>>
>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>>    hw/i386/acpi-build.c  | 99 ++++++++++++++++++++++++++++---------------
>>>>    hw/i386/acpi-common.c | 45 +++++++++++++++-----
>>>>    2 files changed, 101 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index 4967aa745902..d0a5bfc69e9a 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -888,7 +888,8 @@ static void build_dbg_aml(Aml *table)
>>>>        aml_append(table, scope);
>>>>    }
>>>>    
>>>> -static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
>>>> +static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg,
>>>> +                           bool level_trigger_unsupported)
> 
> do not use negative naming, or even better pass AML_EDGE || AML_LEVEL as an argument here.
> the same applies to other places that use level_trigger_unsupported.
> 
>>>>    {
>>>>        Aml *dev;
>>>>        Aml *crs;
>>>> @@ -900,7 +901,10 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
>>>>        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>>>>    
>>>>        crs = aml_resource_template();
>>>> -    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>>>> +    aml_append(crs, aml_interrupt(AML_CONSUMER,
>>>> +                                  level_trigger_unsupported ?
>>>> +                                  AML_EDGE : AML_LEVEL,
>>>> +                                  AML_ACTIVE_HIGH,
>>>>                                      AML_SHARED, irqs, ARRAY_SIZE(irqs)));
>>>>        aml_append(dev, aml_name_decl("_PRS", crs));
>>>>    
>>>> @@ -924,7 +928,8 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
>>>>        return dev;
>>>>     }
>>>>    
>>>> -static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
>>>> +static Aml *build_gsi_link_dev(const char *name, uint8_t uid,
>>>> +                               uint8_t gsi, bool level_trigger_unsupported)
>>>>    {
>>>>        Aml *dev;
>>>>        Aml *crs;
>>>> @@ -937,7 +942,10 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
>>>>    
>>>>        crs = aml_resource_template();
>>>>        irqs = gsi;
>>>> -    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>>>> +    aml_append(crs, aml_interrupt(AML_CONSUMER,
>>>> +                                  level_trigger_unsupported ?
>>>> +                                  AML_EDGE : AML_LEVEL,
>>>> +                                  AML_ACTIVE_HIGH,
>>>>                                      AML_SHARED, &irqs, 1));
>>>>        aml_append(dev, aml_name_decl("_PRS", crs));
>>>>    
>>>> @@ -956,7 +964,7 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
>>>>    }
>>>>    
>>>>    /* _CRS method - get current settings */
>>>> -static Aml *build_iqcr_method(bool is_piix4)
>>>> +static Aml *build_iqcr_method(bool is_piix4, bool level_trigger_unsupported)
>>>>    {
>>>>        Aml *if_ctx;
>>>>        uint32_t irqs;
>>>> @@ -964,7 +972,9 @@ static Aml *build_iqcr_method(bool is_piix4)
>>>>        Aml *crs = aml_resource_template();
>>>>    
>>>>        irqs = 0;
>>>> -    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
>>>> +    aml_append(crs, aml_interrupt(AML_CONSUMER,
>>>> +                                  level_trigger_unsupported ?
>>>> +                                  AML_EDGE : AML_LEVEL,
>>>>                                      AML_ACTIVE_HIGH, AML_SHARED, &irqs, 1));
>>>>        aml_append(method, aml_name_decl("PRR0", crs));
>>>>    
>>>> @@ -998,7 +1008,7 @@ static Aml *build_irq_status_method(void)
>>>>        return method;
>>>>    }
>>>>    
>>>> -static void build_piix4_pci0_int(Aml *table)
>>>> +static void build_piix4_pci0_int(Aml *table, bool level_trigger_unsupported)
>>>>    {
>>>>        Aml *dev;
>>>>        Aml *crs;
>>>> @@ -1011,12 +1021,16 @@ static void build_piix4_pci0_int(Aml *table)
>>>>        aml_append(sb_scope, pci0_scope);
>>>>    
>>>>        aml_append(sb_scope, build_irq_status_method());
>>>> -    aml_append(sb_scope, build_iqcr_method(true));
>>>> +    aml_append(sb_scope, build_iqcr_method(true, level_trigger_unsupported));
>>>>    
>>>> -    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3")));
>>>> +    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3"),
>>>> +                                        level_trigger_unsupported));
>>>>    
>>>>        dev = aml_device("LNKS");
>>>>        {
>>>> @@ -1025,7 +1039,9 @@ static void build_piix4_pci0_int(Aml *table)
> 
> do we really need piix4 machine to work with TDX?
> 
>>>>    
>>>>            crs = aml_resource_template();
>>>>            irqs = 9;
>>>> -        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
>>>> +        aml_append(crs, aml_interrupt(AML_CONSUMER,
>>>> +                                      level_trigger_unsupported ?
>>>> +                                      AML_EDGE : AML_LEVEL,
>>>>                                          AML_ACTIVE_HIGH, AML_SHARED,
>>>>                                          &irqs, 1));
>>>>            aml_append(dev, aml_name_decl("_PRS", crs));
>>>> @@ -1111,7 +1127,7 @@ static Aml *build_q35_routing_table(const char *str)
>>>>        return pkg;
>>>>    }
>>>>    
>>>> -static void build_q35_pci0_int(Aml *table)
>>>> +static void build_q35_pci0_int(Aml *table, bool level_trigger_unsupported)
>>>>    {
>>>>        Aml *method;
>>>>        Aml *sb_scope = aml_scope("_SB");
>>>> @@ -1150,25 +1166,41 @@ static void build_q35_pci0_int(Aml *table)
>>>>        aml_append(sb_scope, pci0_scope);
>>>>    
>>>>        aml_append(sb_scope, build_irq_status_method());
>>>> -    aml_append(sb_scope, build_iqcr_method(false));
>>>> +    aml_append(sb_scope, build_iqcr_method(false, level_trigger_unsupported));
>>>>    
>>>> -    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG")));
>>>> -    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH")));
>>>> +    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG"),
>>>> +                                        level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH"),
>>>> +                                        level_trigger_unsupported));
>>>>    
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16));
>>>> -    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16,
>>>> +                                            level_trigger_unsupported));
>>>> +    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17,
>>>> +                                            level_trigger_unsupported));
>>>>    
>>>>        aml_append(table, sb_scope);
>>>>    }
>>>> @@ -1350,6 +1382,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>>        PCMachineState *pcms = PC_MACHINE(machine);
>>>>        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
>>>>        X86MachineState *x86ms = X86_MACHINE(machine);
>>>> +    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
>>>>        AcpiMcfgInfo mcfg;
>>>>        bool mcfg_valid = !!acpi_get_mcfg(&mcfg);
>>>>        uint32_t nr_mem = machine->ram_slots;
>>>> @@ -1382,7 +1415,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>>            if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
>>>>                build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>>>>            }
>>>> -        build_piix4_pci0_int(dsdt);
>>>> +        build_piix4_pci0_int(dsdt, level_trigger_unsupported);
>>>>        } else if (q35) {
>>>>            sb_scope = aml_scope("_SB");
>>>>            dev = aml_device("PCI0");
>>>> @@ -1426,7 +1459,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>>            if (pm->pcihp_bridge_en) {
>>>>                build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
>>>>            }
>>>> -        build_q35_pci0_int(dsdt);
>>>> +        build_q35_pci0_int(dsdt, level_trigger_unsupported);
>>>>        }
>>>>    
>>>>        if (misc->has_hpet) {
>>>> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
>>>> index 0cc2919bb851..ad38a6b31162 100644
>>>> --- a/hw/i386/acpi-common.c
>>>> +++ b/hw/i386/acpi-common.c
>>>> @@ -103,6 +103,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> 
> MADT change should be its own patch.
> 
>>>>        const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
>>>>        AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
>>>>                            .oem_table_id = oem_table_id };
>>>> +    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
>>>>    
>>>>        acpi_table_begin(&table, table_data);
>>>>        /* Local APIC Address */
>>>> @@ -124,18 +125,42 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>>>>                         IO_APIC_SECONDARY_ADDRESS, IO_APIC_SECONDARY_IRQBASE);
>>>>        }
>>>>    
>>>> -    if (x86mc->apic_xrupt_override) {
>>>> -        build_xrupt_override(table_data, 0, 2,
>>>> -            0 /* Flags: Conforms to the specifications of the bus */);
>>>> -    }
>>>> +    if (level_trigger_unsupported) {
> 
> maybe, try to set flags as local var first,
> and then use it in build_xrupt_override() instead of rewriting/shifting
> existing blocks
> 
>>>> +        /* Force edge trigger */
>>>> +        if (x86mc->apic_xrupt_override) {
>>>> +            build_xrupt_override(table_data, 0, 2,
>>>> +                                 /* Flags: active high, edge triggered */
>>>> +                                 1 | (1 << 2));
> pls point to spec where it comes from
> 
> 
>>>> +        }
>>>> +
>>>> +        for (i = x86mc->apic_xrupt_override ? 1 : 0; i < 16; i++) {
>                                                    ^^^^^^^
> before patch it was always starting from 1,
> so above does come from?
> 
>>>> +            build_xrupt_override(table_data, i, i,
>>>> +                                 /* Flags: active high, edge triggered */
>>>> +                                 1 | (1 << 2));
>>>> +        }
> 
>>>> +        if (x86ms->ioapic2) {
>>>> +            for (i = 0; i < 16; i++) {
>>>> +                build_xrupt_override(table_data, IO_APIC_SECONDARY_IRQBASE + i,
>>>> +                                     IO_APIC_SECONDARY_IRQBASE + i,
>>>> +                                     /* Flags: active high, edge triggered */
>>>> +                                     1 | (1 << 2));
>>>> +            }
>>>> +        }
> and this is absolutely new hunk, perhaps its own patch with explanation why it's need
> 
>>>> +    } else {
>>>> +        if (x86mc->apic_xrupt_override) {
>>>> +            build_xrupt_override(table_data, 0, 2,
>>>> +                    0 /* Flags: Conforms to the specifications of the bus */);
>>>> +        }
>>>>    
>>>> -    for (i = 1; i < 16; i++) {
>>>> -        if (!(x86ms->pci_irq_mask & (1 << i))) {
>>>> -            /* No need for a INT source override structure. */
>>>> -            continue;
>>>> +        for (i = 1; i < 16; i++) {
>>>> +            if (!(x86ms->pci_irq_mask & (1 << i))) {
>>>> +                /* No need for a INT source override structure. */
>>>> +                continue;
>>>> +            }
>>>> +            build_xrupt_override(table_data, i, i,
>>>> +                0xd /* Flags: Active high, Level Triggered */);
>>>>            }
>>>> -        build_xrupt_override(table_data, i, i,
>>>> -            0xd /* Flags: Active high, Level Triggered */);
>>>>        }
>>>>    
>>>>        if (x2apic_mode) {
>>>> -- 
>>>> 2.34.1
>>>>   
>>
> 
> 


