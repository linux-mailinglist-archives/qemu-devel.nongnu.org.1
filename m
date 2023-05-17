Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA518707079
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLcL-0005sJ-18; Wed, 17 May 2023 14:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzLcI-0005rz-UM; Wed, 17 May 2023 14:11:15 -0400
Received: from mail-bn7nam10olkn20830.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::830]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1pzLcG-0003ed-NS; Wed, 17 May 2023 14:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd/fORGWEZr2p6Lx1hp9MKKJxR+J99yXn2Eo/yJ9c9m/XoE6+CmpZEZxs9kd6EU/jY4fC+oX57k6aG1y7EJnKy/hY7+/Z83LuEV3AnaSKpZ2SNusStbm5FkwuvIV2u9S1tAik9j6DpUwJoY5V6mEdk484C7xvlDBJ0sM1AxeLba0OyEYSLuywmpaqIjYACrYfJfgFNuDisJ79+O8dcqRnGFHjFcwXCqhdU7LyyVk1CN612cZ35k1mMEoSonyhfm5NQ8c/oXX5GmOlKjxnpNK7UygGBNWEOknAM3k13b9rmYhnENQAzFeLv8twMPbYQ4LkkMqVnvdpk4sSyUFkpr0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEC9gdb40zwyWiwzciPUS9+7LJnbbb/oogeGMAT4xNU=;
 b=IUxgfTrRjQLD2FJQ43Sq47j0cxApZAhrS6dJmkOh7s0Kg528QOG+K6gKbWO3JbE6L8fSnDTzIpeFaJGFmmnxJGzRVuQVncnPvLh9rmDHQ5k482Z6oTsfuszPYH8B4cJRz1i9fsHP0xm73VjELumqsGc3/fWJN66HSfdF2+6ZHJZRLTMrsi+T4Zfr5GqqDMUmbcpK1wPvyj7G84zdXCCAJeaSoXjNm9pWtNX7F9H0rhkf165tk+9FmQjf5ObuJGiepaRw47PbxvbcgtnufEWGLBoS5/TbpR7fyPZE8/EExrbAGLF9YKSJOXT5vtJsww/Bw+RxsWKX5hlX582ChdTKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEC9gdb40zwyWiwzciPUS9+7LJnbbb/oogeGMAT4xNU=;
 b=C6DBRKw/MpEZKu/6QDdeqdNPgJS4tpzL1FkxAxkb0i8luc5MtJ8WvWTkIXhU/7/tcwPAwNH+wAJQWfRXERSrlHyjpPJ0jU63I8SLQbyDqG1228IecIL1J7FtuP70y8XXFjNsPnfesGSoEGTt9ZvMrt0irYZ3LflLYPH7TGOfC3baUddz/Qs87Kj8u1AiYNkatlpTtlDK3/8xw+8rhS391MORcY9UVjSfI7kvwE0N2S1Kt3cI9yp5w+7TOFYvAJMj2hjRWtdA2woCjXxA3DkMjC2+i3oTzxxuMycyUTflnzjXStAjAOp6YViCAGYkbuL7b1it6/nO5xedYKIY8n/u9A==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 18:11:09 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 18:11:09 +0000
Date: Wed, 17 May 2023 11:11:05 -0700
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2] target/arm: allow DC CVA[D]P in user mode emulation
Message-ID: <DS7PR12MB6309F0ECEECB9168D5F1AB89AC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-TMN: [Cqa7kFPPoO8fdO96vW/9UbbavHCXii2T]
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <ZGUYuYDGLT4hsNYu@manjaro-vmryzen>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e706d35-128f-4afd-2eaa-08db570216be
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjGPNGouocra99Px80ZGezu9SNY6St+BFFXt1KlnWf4e1yFlyK2mZNA5zLGQnNIrygxRjSjfsCBCr1iMk8tEJBS9u06pM1/qrFqFhcYY1sj4W3X7Fmi35w7z1DETwwKfekX8fgLzS5w1oX4i9a8nlEfd78/lQpzqfBkNdGi8nyQIIGKnoTc+AcWemUoc+nK1i8gJIpm8Cjc5tbdkhIfmEO3/VohlO0FHNjl7kKlivyyvF0dxpYzyu2p3NCTFafawHtWpUGknJYSJpjAnfNMzJ7DTba5faiMHOsIDyNyT+nJncE2x402gI8+Livqtze4XWOTmA+2G5PhHejfpXNGvLTvAoTo1f1optYtkqEbAtdf8VeSmKeJ5P6dkCck4OQlf+Eo5nvhc23zwgQLdn9yRZ5eBT1ERGDF18/4bSkkNwlOXiTno/1vZTu5UrhV9HqxMjHiv9zpawa3L7AqXXfIU4TpjO6NYzOwvf+KXsu9Z4BZwEMdl58Kz5OrIvoK4eS2UxJ0m3bEVwReakVTHKiawp3lTkWO2+SPBw12uNa/mePRIzupq1lG3/sNbCeiXDMyw3FT9iQideYkL0GOsS9hyw5Dff0t+SfB/enk8Tm9B5niwm48OVxHHKYA8NYJSWwdT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5jOGpJZEEvWXl1MVlBemxWQlRKaXVjeHVDM2FSSFZ3MlFYQ3dudTREb0h3?=
 =?utf-8?B?Q0Fzd2k2ZklDellxODVBWGRncmFsQ2ljY3NDaXUvWVRFMDAyOTR6SkZnNzZR?=
 =?utf-8?B?aFFKYWVHV29scVE2M0I3cXlGeGhlM0t5MC80Q01LVXQrM2laRHdFeFFMZ2x5?=
 =?utf-8?B?L0hNcWRpRkZiV0J1Qlh3UDkyTW1QZkMyeC9vWXplS2VublhuNkpEOFVETW9O?=
 =?utf-8?B?YUNYL1J3T2NzZnZZOVMyRkpsUXRBdngrTVlDcncvUUJHL0QvbWdEa1l6Q0to?=
 =?utf-8?B?bWtFQTNObHVBaFZpU3ptMVNtWld5elRpb0IzWGhsSG04OUNUV2FFMFZoWEtO?=
 =?utf-8?B?MUx2N0ZnVXJWWEdRM0gvU2hjSm5KbjRyNXlmV0dXRUpmaXFhOGsxVzdHSUZR?=
 =?utf-8?B?Uyt1eEsrSEV2OTVHWnUyZVlndjh3ZFo2TnUxWjM1Zmk1OVF1ZkVPMTlIVlZ6?=
 =?utf-8?B?cDk0Q2xlUWVFQXVlVThtanhyVEo0S0srVFRrMmhXdnM5eG9YZEQ4by9aa2VM?=
 =?utf-8?B?eGRKUGpyc24yMmpBSFczQUcyTTRyRTVpSnQyMnhFaExidlFOYVgzamNGOVV6?=
 =?utf-8?B?SHN5WEpQYzZScFQ3VnhaMSt1UHlxK3NzWmlSVU5zdnBTN3NzejREdWdhWkFl?=
 =?utf-8?B?dW1RYzR5WE1QY0hkdGZENFBZR3JCcEJuZWpZYURjVWRheVZ3QmJUQW5vTGRm?=
 =?utf-8?B?c2lFbERFaGowbHV5RncxemZwbUo3ZWo5cDkwRkJNL0wxNmMyclk4bFhRcFZW?=
 =?utf-8?B?M2NCY0ppRk92ejZpTy8xMVBsNVlPcDh3dU9mdjI4bkFsNDVHeEUzWElHUU55?=
 =?utf-8?B?dk96YlMyaWV2anZMVUZicFlzQ2ovZnNXMklsTjNpU05DaUlzM0hoNGZhdGIr?=
 =?utf-8?B?TkZpazNmRk8ydWZ0dVdHQ254VWRSSXA1UHhYanVXYjNveDB1ZGkyQW1EMFhv?=
 =?utf-8?B?cHVTNzlRaW03bW1YTDk5Uk9GODYxRzhCZ2ZFYU0ySjRkUWFoTWxkWXpOdlMy?=
 =?utf-8?B?ajJnR0phTXFMSUE0Lytpd3ZTbStMMjlJdDlEejV4b1JtbU81bUlNWkdreGVn?=
 =?utf-8?B?elVTbjZCb0ZhaW9KOXJhbGlRWndWdmxjSUVleWtzQ3lhaUZvQ28wTmZGcmQv?=
 =?utf-8?B?TUd0R0NoazI0ckptKytMUGNmZDZsTE04N2Z2SHJFQUU5K0VSL2JwN0l5akRk?=
 =?utf-8?B?UE85OFMrSHNiR1FrOTAyYVlITFhpcUc3SHNmYnp6QmFhQUhmcWpxdHl3NUll?=
 =?utf-8?B?NVU5Ylc2U2YyNWZRbjAvTXdCNlFZZUFCMzIrZ0dJQ1BHQkQ2bFhiQkJiOU5i?=
 =?utf-8?B?Wk9kWDNyMHY1LzAvMUUzUkIyQnhWdlUwbER6KzBWdjF0VFlMdnpaNUROMEVN?=
 =?utf-8?B?WSt1UmRQVDVwQ09mRFg4SXZ4WTRvRlVGQkZsb2dmOGFoSlh2c3dPWTl5TTNz?=
 =?utf-8?B?aFpxc3pDVTFvVjVhWDdLa0NSWld1RFExWkh0dlJoRHpUcFdDcGFtT2FBZW50?=
 =?utf-8?B?NExBdXNoenMxdW9XV0cweFMwbmpvMG9Yc01tK29YYm9XUlkxM1ZGSlluTk9N?=
 =?utf-8?B?aE53SnhhOVY0SEozaTJ6MWk5N2JRaW5WQk90TmplQ21wYlRtTUxKa1RVVUVj?=
 =?utf-8?Q?65gd2vBpzCt1eh8zluRlTucC/1lPFcYmIQ6BPjgkZyBo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e706d35-128f-4afd-2eaa-08db570216be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:11:09.0436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
Received-SPF: pass client-ip=2a01:111:f400:7e8a::830;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 05/17/2023 10:31 AM -0700, Zhuojia Shen wrote:
> DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> user_cache_maint_handler() in arch/arm64/kernel/traps.c).
> 
> This patch enables execution of the two instructions in user mode
> emulation.
> 
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> ---
>  target/arm/helper.c               |  6 ++--
>  tests/tcg/aarch64/Makefile.target | 11 ++++++++
>  tests/tcg/aarch64/dcpodp-1.c      | 47 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/dcpodp-2.c      | 47 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/dcpop-1.c       | 47 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/dcpop-2.c       | 47 +++++++++++++++++++++++++++++++
>  6 files changed, 201 insertions(+), 4 deletions(-)
>  create mode 100644 tests/tcg/aarch64/dcpodp-1.c
>  create mode 100644 tests/tcg/aarch64/dcpodp-2.c
>  create mode 100644 tests/tcg/aarch64/dcpop-1.c
>  create mode 100644 tests/tcg/aarch64/dcpop-2.c
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0b7fd2e7e6..d4bee43bd0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7405,7 +7405,6 @@ static const ARMCPRegInfo rndr_reginfo[] = {
>        .access = PL0_R, .readfn = rndr_readfn },
>  };
>  
> -#ifndef CONFIG_USER_ONLY
>  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>                            uint64_t value)
>  {
> @@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>      /* This won't be crossing page boundaries */
>      haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
>      if (haddr) {
> +#ifndef CONFIG_USER_ONLY
>  
>          ram_addr_t offset;
>          MemoryRegion *mr;
> @@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>          if (mr) {
>              memory_region_writeback(mr, offset, dline_size);
>          }
> +#endif /*CONFIG_USER_ONLY*/
>      }
>  }
>  
> @@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
>        .fgt = FGT_DCCVADP,
>        .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
>  };
> -#endif /*CONFIG_USER_ONLY*/
>  
>  static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
>                                         bool isread)
> @@ -9092,7 +9092,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_tlbios, cpu)) {
>          define_arm_cp_regs(cpu, tlbios_reginfo);
>      }
> -#ifndef CONFIG_USER_ONLY
>      /* Data Cache clean instructions up to PoP */
>      if (cpu_isar_feature(aa64_dcpop, cpu)) {
>          define_one_arm_cp_reg(cpu, dcpop_reg);
> @@ -9101,7 +9100,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              define_one_arm_cp_reg(cpu, dcpodp_reg);
>          }
>      }
> -#endif /*CONFIG_USER_ONLY*/
>  
>      /*
>       * If full MTE is enabled, add all of the system registers.
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> index 0315795487..714a30355d 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -21,12 +21,23 @@ config-cc.mak: Makefile
>  	$(quiet-@)( \
>  	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
>  	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
> +	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
>  	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
> +	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
>  	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
>  	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
>  	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
>  -include config-cc.mak
>  
> +ifneq ($(CROSS_CC_HAS_ARMV8_2),)
> +AARCH64_TESTS += dcpop-1 dcpop-2
> +dcpop-1 dcpop-2: CFLAGS += -march=armv8.2-a
> +endif
> +ifneq ($(CROSS_CC_HAS_ARMV8_5),)
> +AARCH64_TESTS += dcpodp-1 dcpodp-2
> +dcpodp-1 dcpodp-2: CFLAGS += -march=armv8.5-a
> +endif
> +
>  # Pauth Tests
>  ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>  AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
> diff --git a/tests/tcg/aarch64/dcpodp-1.c b/tests/tcg/aarch64/dcpodp-1.c
> new file mode 100644
> index 0000000000..47c466a9bf
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpodp-1.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVADP instruction */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP2_DCPODP
> +#define HWCAP2_DCPODP (1 << 0)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_FAILURE);
> +}
> +
> +static int do_dc_cvadp(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
> +
> +    return EXIT_SUCCESS;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {

Should be AT_HWCAP2.

> +        return do_dc_cvadp();
> +    } else {
> +        printf("SKIP: no HWCAP2_DCPODP on this system\n");
> +        return EXIT_SUCCESS;
> +    }
> +}
> diff --git a/tests/tcg/aarch64/dcpodp-2.c b/tests/tcg/aarch64/dcpodp-2.c
> new file mode 100644
> index 0000000000..3245d7883d
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpodp-2.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVADP instruction on unmapped address */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP2_DCPODP
> +#define HWCAP2_DCPODP (1 << 0)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_SUCCESS);
> +}
> +
> +static int do_dc_cvadp(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvadp, %0\n\t" :: "r"(NULL));
> +
> +    return EXIT_FAILURE;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP2_DCPODP) {

Should be AT_HWCAP2.

> +        return do_dc_cvadp();
> +    } else {
> +        printf("SKIP: no HWCAP2_DCPODP on this system\n");
> +        return EXIT_SUCCESS;
> +    }
> +}
> diff --git a/tests/tcg/aarch64/dcpop-1.c b/tests/tcg/aarch64/dcpop-1.c
> new file mode 100644
> index 0000000000..c9fc5b7e57
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpop-1.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVAP instruction */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP_DCPOP
> +#define HWCAP_DCPOP (1 << 16)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_FAILURE);
> +}
> +
> +static int do_dc_cvap(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvap, %0\n\t" :: "r"(&sa));
> +
> +    return EXIT_SUCCESS;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
> +        return do_dc_cvap();
> +    } else {
> +        printf("SKIP: no HWCAP_DCPOP on this system\n");
> +        return EXIT_SUCCESS;
> +    }
> +}
> diff --git a/tests/tcg/aarch64/dcpop-2.c b/tests/tcg/aarch64/dcpop-2.c
> new file mode 100644
> index 0000000000..8f8ed81720
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpop-2.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVAP instruction on unmapped address */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP_DCPOP
> +#define HWCAP_DCPOP (1 << 16)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_SUCCESS);
> +}
> +
> +static int do_dc_cvap(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvap, %0\n\t" :: "r"(NULL));
> +
> +    return EXIT_FAILURE;
> +}
> +
> +int main(void)
> +{
> +    if (getauxval(AT_HWCAP) & HWCAP_DCPOP) {
> +        return do_dc_cvap();
> +    } else {
> +        printf("SKIP: no HWCAP_DCPOP on this system\n");
> +        return EXIT_SUCCESS;
> +    }
> +}
> -- 
> 2.40.1
> 

