Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9307C55FD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZiT-0004Rn-HK; Wed, 11 Oct 2023 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqZiH-0004Ol-Ab; Wed, 11 Oct 2023 09:57:26 -0400
Received: from mail-dm6nam04on20705.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::705]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqZiC-00053C-97; Wed, 11 Oct 2023 09:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4CyPaqaMknX2JE2qpN0OEDEvMdo3W+9YohjL3yYoL1JpNAfhN4g/C/xoO519+EijeCHJ+GdXf7+n09ix/ipbC80DTfvfElEue0Vtk+NVGuLWy2WDmB2UJCB0e4COQOvRRmXEQpJX+ivd6O/LWLLGmYFxfwRUB52in8uCEOkIvJAhBgIpoT4zTN3jn1vGNietx7FgrWoHC3QLzdnX+4OXI5Wb4f9rIJT7wgnBZYncrJ5ibWIVQ2dDo9ubGpp+6SqoiokIwctP0nmRoEP9qrrOJDPZzdq69JFWQJzCSpSv27e5dLugKkPFmuWZ2yt0CocGTtTxniIFSuhbKmxSo1bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhSHMW6KzJDLpQ+r18VSXPqzH5nwOT4RcPW4mbBoyng=;
 b=DtZ31argSqnX+3gjqM3IGo0qZTg5mEY7lYaM3aso4TINgNoKF/qyQzJoE0ZvePLGTO3d3t7DaMypuxi62BR229Xid7nIPR2MyqOqC2zkJyTUf/ZAAe61t/NQcgycJVxEuvtTrM+selJY1Un52Ue2J5xtW6U/GrS29rQ2YJBh7O9CTkdd4pq9jb2up1jrhG9MJ/vAN+/CO68hEZY96qs7tY4oEnUYiXbdWEd1O0TK+b7LsoZCVJwZmldlPJJ7yzWfvfRbw/2RWTTje3xPO5sZbhSHf8InUPImC8fvyxFHV+vgqeHSIlgg19grVPi2XeHIeKBEHGYsPSga9a263ANDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhSHMW6KzJDLpQ+r18VSXPqzH5nwOT4RcPW4mbBoyng=;
 b=sJIlKvpG9gQ2U4o4UBC7MWgRPZ1PW5GcXDrtAGJUd7P8dWhhkm4+P5X3ZRuOasf9ycCSRr6ajRmZJI1BYZBF/v4LaUVnX6oyXDlnvq9Ltw07EFm0L+GAV8OUzu7ncIsCvDxfOZg57y0ZNONviOj7TZcmc2jEYYRc+WghrCxVmt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB3685.prod.exchangelabs.com (2603:10b6:a02:8e::13) by
 DS7PR01MB7760.prod.exchangelabs.com (2603:10b6:8:7f::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 13:57:10 +0000
Received: from BYAPR01MB3685.prod.exchangelabs.com
 ([fe80::cb75:71bb:e8be:64da]) by BYAPR01MB3685.prod.exchangelabs.com
 ([fe80::cb75:71bb:e8be:64da%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 13:57:08 +0000
Content-Type: multipart/alternative;
 boundary="------------kB0zeOeanlWDKmEl8YkPWb5r"
Message-ID: <2ca14bc2-eaf1-a047-f72b-f00b632147c4@amperemail.onmicrosoft.com>
Date: Wed, 11 Oct 2023 19:26:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 00/10] Add architecture agnostic code to support vCPU
 Hotplug
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009203601.17584-1-salil.mehta@huawei.com>
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20231009203601.17584-1-salil.mehta@huawei.com>
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To BYAPR01MB3685.prod.exchangelabs.com
 (2603:10b6:a02:8e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB3685:EE_|DS7PR01MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 134d957b-fbaa-40ba-b590-08dbca61f59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTh+qjIevUhpmgUgv+d64DmJlYWzyYD3UUjeNF7sTwgODDSPJDG1bTepjkGETZ7ImDbjE1Rcin5+tKlxBb1leJk/Qgg+hHG0FHqMy3wHdaWPTbCdrYPnQvsgOdZqSOF75wwPPvz8uTg0Tu7BsaKA5SWi1r6lkftEUEtxofril4LY42NX8KQUx+h5sDGGcsQRHcP2S6OLDrCI3UV7pUTfb/n6s0IWt61EiUitnrrri7a8qqIW2M10nU5xNJAXhFYPbW5fp4VdQoJ+NI3yhXZppkFo/k6DmzM5HLSd/9u7PnyfWQMdIu7hIWjZuCwdNGreFXyzT3x598mOwvKWkO/jrFK39T6daDdzRg7djRv4ZWuwWC2HF8JoitBEAd29JwCxni/m0d/0pTQVNlRxoWuW5H+okwnEPBpSVYRas+UqBdbKv3mxTh3oAyvwv4f0l4gnO3PgPr4T0Qd08lV84xtcppscM0rtupM7+FdDU49Dtb2hsnxkpjpfeySNI+hMlgc1K4bUcXftnB71PifaWL1mRqturTiCqSCWw2CBv2Src88tLqN0eEdY9/rvjycGmB/yUFTg3H20ablrBphgWDhL+IdvxSFJpPzgjvUmSCyY8fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB3685.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(31686004)(2616005)(33964004)(53546011)(6512007)(83170400001)(31696002)(38100700002)(166002)(7406005)(2906002)(26005)(83380400001)(66574015)(966005)(6486002)(6666004)(6506007)(478600001)(42882007)(8676002)(4326008)(316002)(8936002)(41300700001)(7416002)(66946007)(66476007)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmsxTDB4WDFFRG03c24xWU9MaU8zNGJ4U0QwN1FJMjJDZ0JaZ2ZseXBobHkz?=
 =?utf-8?B?Z2dsQmZQNXFobXFmT1o4ZWdCZ2JtV2JLbWNrNTNpeGRnVnRNSklvUFRJNjhB?=
 =?utf-8?B?eVcwcm1tWldJd2Zqay9nUitqeVNOUXdrUDFvNE5oc1kxb2gwd01KZUR0bld6?=
 =?utf-8?B?ZldQVjZ5L1l0eUNBNzd3c1Nwbzc5a1lWUW1OTDlRbzRsQk1yazBNbHhFYjA2?=
 =?utf-8?B?ZS9wdmFzWmIxek5oM0pManZzOHZNMUNObjRWWWV4SjZzZ3EwTStjNFdsaWVG?=
 =?utf-8?B?YU1ZbS9aem9VSVBiTXlNMjZ1UmlFRE9STjVWQStQVGFhc2xjejBTTkFFT3pK?=
 =?utf-8?B?RWxCMDJJa25nNmE4b0c3Qkx5SGJLU3B3MU16RG4zdGtUSFo0ZC81UEJkVkxu?=
 =?utf-8?B?dGIwSUR4OU9yZExlQkVpU0VkSDVFa2w2UkppWGUwR05hbVJGMGxMakV4R0Jm?=
 =?utf-8?B?dXJIOHN0UzdsNnB2V2g0YjJxR2syM0FyRTYzWHZ0dlVCaHEyZndLUnRSenpU?=
 =?utf-8?B?Qmo5S2hsY0FxLzVFRkNEUXNnTk1UaURCdkpvS0xyNVIyTHZQWU42bXAwSEpR?=
 =?utf-8?B?ZVd4SW9vRlhlQmJxeHhHa2M2YlhTY2hPb3FlS1NONXpwbjVnZnhsVHNQN1JP?=
 =?utf-8?B?OUdIdytzZmxxdFVPdnAyY0tvR2Jld1ArdG96Y3Ria3g3YnZkdFlHL24rdmNU?=
 =?utf-8?B?Q3VITThqeE5EZmdmZmxSK0lyTVB0RHdWU2l0eXFVNjRMZzZLbS8zTkVTT0xG?=
 =?utf-8?B?b1FIdVJwMjR5NjVVSDU1K3NxYnkzeC9Ka1hjY0diQjBxNjZVZ2h1Rm44M05r?=
 =?utf-8?B?UXJYU2JjQTBGeklZN2Z1c3dYM1NIWVpBY2JlbnN5RDNaOVlYaWthWHlabGox?=
 =?utf-8?B?dnB4RVowREJuZFFUY0tVdmQ3QXByWUtYZlkwaUp6K1hYVk5sSW9adFEyV0pS?=
 =?utf-8?B?RTJWdjc5WnZ6anlNZklWcVRMODRjak5QRWVCSU82UU8zRmUyaW5lWUxzWjV0?=
 =?utf-8?B?Q1pjM011V09CQVhST2lrbWwzKzcrSDdLMGxCUDNmOXZ2RXJIemsxWVY5Mnl5?=
 =?utf-8?B?NVduQW92QVFVR2xuT2ZCajRobVM3dE1ZSElaRVArbmxLVkpqNktFTU4ra2RF?=
 =?utf-8?B?MXBNZFphbXFKclNvakkvc1hwQUJva2NmeFdNU1o1dzNFZklESUZlWTAyVzFP?=
 =?utf-8?B?VEJ1YzEzNFc3NHErWitEN2tPQWJvdWVnSVhoNG5wU01LSTJSTlA0YXhydlhH?=
 =?utf-8?B?VDFEcWx5MnFZTkV6c2F0VUhBTXZmY0hNTW1obDExaGlWL2tYZGF5eXVJdzFn?=
 =?utf-8?B?bnZObVhYVSt6YU4rM1N5aHo3aTFjYk9EeHlTc0ZYY2RtVUF0aHUyT0Y1NFlO?=
 =?utf-8?B?eW1vMi84d014ME95TWlMN2ZXeTVFc1VnakVpRE1aZEJYMURab1MvZ2pMR3pW?=
 =?utf-8?B?cWZVSTNzMG1WbVlCN2cvblYyNU5adEE5cm50bDdJSWxKN2ZsdW8zQm4zSG1W?=
 =?utf-8?B?dDBmcVJ6UytHZ0EvWDZzMEhZREZOU3RnSWJndXJRQ1ZHRU0zcVNBdFMrVVND?=
 =?utf-8?B?U1V5c2JOMlZ2a3I5SEphNGRsbHJPNkwwSkZzSlpqKyt4MFhhOWp4MHB3MXpO?=
 =?utf-8?B?Y3FzNnhtQ0FycHRSeG1ZeTE0OWpoRTEydTJtUXZGdHVUcnh3WkFHcEQ2TENw?=
 =?utf-8?B?dG5hcnU1Z205dkpRYm5NMk81b3IrNUMxUGI2TWhXMDBZb3VvbnVXQmNENjJM?=
 =?utf-8?B?K2V2d2hnYjIrZWVSUmR1TVFxbmhqVGVoN1BqQVNwSSs1K0RTeVhrQ1kyYncy?=
 =?utf-8?B?WVdXQis4bEwyQWpJajF2N3daSWFpdjQ3Yi9VNlU2MTZ1RTdEeHdmUGhScmFq?=
 =?utf-8?B?S0VzKzkxbHROV2gwekZxUGx5OWJNeS92WHpGRDlqNDZ4YWFmMGhaanJJYkZL?=
 =?utf-8?B?cGNTdHVwRzl2VE5WbkVkZ3dPZUFVVTYwaVFVejlhWDNXb3hRcSt4S1ZsL1py?=
 =?utf-8?B?TVVUMVk1NGY3Z2h5eUtPdWdPdS85ZUFyalNaZGh5bGlQSXdVb0RaQVcyMUJW?=
 =?utf-8?B?UFlCZHVlWEhqNlFSemZRdk4yL2xndXE1SjRJU3RWUFRldjJBbHJ6M0xVQUdN?=
 =?utf-8?B?elZJL3Z0YSt2THhhNHVFb2ZybFEyK3JVcEpadTBCcGVOeVhRTGZIS1hhSE1o?=
 =?utf-8?Q?TvbScCP4YghrAbDQNfYezoI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d957b-fbaa-40ba-b590-08dbca61f59f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3685.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:57:08.6328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NquSKLBLt1Azi/Rcy45e00+mslMw9M+cXXtuYTU+Z+TilBMgcRx2wnGsm23s5uIIWpwAbqAecisHJrnnAgE5ABqwUceNpsSL5RwZQeCqm4LNtmN64nlU/TS11aq/Y1Lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7760
Received-SPF: pass client-ip=2a01:111:f400:7e8b::705;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001, NICE_REPLY_A=-3.339,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------kB0zeOeanlWDKmEl8YkPWb5r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 10-10-2023 02:05, Salil Mehta wrote:
> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
>
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 4,6,7]
> 3. ACPI CPUs AML code change [Patch 5]
> 4. Helper functions to support unrealization of CPU objects [Patch 8,9]
> 5. Misc [Patch 2,3,10]
>
>
> Repository:
>
> [*]https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v2.common.v4
>
>
> Revision History:
>
> RFC V3 -> RFC V4
> 1. Addressed David Hilderbrand's comments
>     - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>     - Added Reviewed-by tags for patches {2,4}
> Link:https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/
>
> RFC V2 -> RFC V3
> 1. Addressed Jonathan Cameron's comments
>     - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
>     - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>     - Updated [Patch V2 03/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
>     - Updated [Patch V2 05/10] commit-log with details of conditional event handler method
>     - Added Reviewed-by tags for patches {2,3,4,6,7}
> 2. Addressed Gavin Shan's comments
>     - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>     - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>     - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
>     - Fixed the kvm_{create,park}_vcpu prototypes docs
>     - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> 3. Addressed one earlier missed comment by Alex Bennée in RFC V1
>     - Added traces instead of DPRINTF in the newly added and some existing functions
> Link:https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/
>
> RFC V1 -> RFC V2
> 1. Addressed Alex Bennée's comments
>     - Refactored the kvm_create_vcpu logic to get rid of goto
>     - Added the docs for kvm_{create,park}_vcpu prototypes
>     - Splitted the gdbstub and AddressSpace destruction change into separate patches
>     - Added Reviewed-by tags for patches {2,10}
> Link:https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/
>
> References:
>
> [1]https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/
> [2]https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [3]https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/
>
>
> Jean-Philippe Brucker (1):
>    target/arm/kvm: Write CPU state back to KVM on reset
>
> Salil Mehta (9):
>    accel/kvm: Extract common KVM vCPU {creation,parking} code
>    hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>    hw/acpi: Add ACPI CPU hotplug init stub
>    hw/acpi: Init GED framework with CPU hotplug events
>    hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>    hw/acpi: Update GED _EVT method AML with CPU scan
>    hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>    physmem: Add helper function to destroy CPU AddressSpace
>    gdbstub: Add helper function to unregister GDB register space
>
>   accel/kvm/kvm-all.c                    | 64 ++++++++++++++++++++------
>   accel/kvm/trace-events                 |  4 ++
>   gdbstub/gdbstub.c                      | 15 ++++++
>   hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++
>   hw/acpi/cpu.c                          | 27 +++++++----
>   hw/acpi/generic_event_device.c         | 22 +++++++++
>   hw/i386/acpi-build.c                   |  2 +-
>   include/exec/cpu-common.h              |  8 ++++
>   include/exec/gdbstub.h                 |  5 ++
>   include/hw/acpi/cpu.h                  |  5 +-
>   include/hw/acpi/cpu_hotplug.h          |  4 ++
>   include/hw/acpi/generic_event_device.h |  5 ++
>   include/hw/core/cpu.h                  |  1 +
>   include/sysemu/kvm.h                   | 16 +++++++
>   softmmu/physmem.c                      | 25 ++++++++++
>   target/arm/kvm.c                       |  8 +++-
>   16 files changed, 189 insertions(+), 28 deletions(-)

Tested sanity cases on Ampere's platform.
Also tested VM live migration.

Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>

_Regards_,

-Vishnu

--------------kB0zeOeanlWDKmEl8YkPWb5r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 10-10-2023 02:05, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231009203601.17584-1-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">Virtual CPU hotplug support is being added across various architectures[1][3].
This series adds various code bits common across all architectures:

1. vCPU creation and Parking code refactor [Patch 1]
2. Update ACPI GED framework to support vCPU Hotplug [Patch 4,6,7]
3. ACPI CPUs AML code change [Patch 5]
4. Helper functions to support unrealization of CPU objects [Patch 8,9]
5. Misc [Patch 2,3,10]


Repository:

[*] <a class="moz-txt-link-freetext" href="https://github.com/salil-mehta/qemu.git">https://github.com/salil-mehta/qemu.git</a> virt-cpuhp-armv8/rfc-v2.common.v4


Revision History:

RFC V3 -&gt; RFC V4
1. Addressed David Hilderbrand's comments
   - Fixed the wrong doc comment of kvm_park_vcpu API prototype
   - Added Reviewed-by tags for patches {2,4}
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.com/</a>

RFC V2 -&gt; RFC V3
1. Addressed Jonathan Cameron's comments
   - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'integer'
   - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
   - Updated [Patch V2 03/10] commit-log with details of ACPI_CPU_SCAN_METHOD macro
   - Updated [Patch V2 05/10] commit-log with details of conditional event handler method
   - Added Reviewed-by tags for patches {2,3,4,6,7}
2. Addressed Gavin Shan's comments
   - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
   - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
   - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
   - Fixed the kvm_{create,park}_vcpu prototypes docs
   - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
3. Addressed one earlier missed comment by Alex Bennée in RFC V1
   - Added traces instead of DPRINTF in the newly added and some existing functions
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/</a>

RFC V1 -&gt; RFC V2
1. Addressed Alex Bennée's comments
   - Refactored the kvm_create_vcpu logic to get rid of goto
   - Added the docs for kvm_{create,park}_vcpu prototypes
   - Splitted the gdbstub and AddressSpace destruction change into separate patches
   - Added Reviewed-by tags for patches {2,10}
Link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.com/</a>

References:

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/">https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/</a>
[2] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/">https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/</a>
[3] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/">https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/</a>


Jean-Philippe Brucker (1):
  target/arm/kvm: Write CPU state back to KVM on reset

Salil Mehta (9):
  accel/kvm: Extract common KVM vCPU {creation,parking} code
  hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
  hw/acpi: Add ACPI CPU hotplug init stub
  hw/acpi: Init GED framework with CPU hotplug events
  hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
  hw/acpi: Update GED _EVT method AML with CPU scan
  hw/acpi: Update ACPI GED framework to support vCPU Hotplug
  physmem: Add helper function to destroy CPU AddressSpace
  gdbstub: Add helper function to unregister GDB register space

 accel/kvm/kvm-all.c                    | 64 ++++++++++++++++++++------
 accel/kvm/trace-events                 |  4 ++
 gdbstub/gdbstub.c                      | 15 ++++++
 hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++
 hw/acpi/cpu.c                          | 27 +++++++----
 hw/acpi/generic_event_device.c         | 22 +++++++++
 hw/i386/acpi-build.c                   |  2 +-
 include/exec/cpu-common.h              |  8 ++++
 include/exec/gdbstub.h                 |  5 ++
 include/hw/acpi/cpu.h                  |  5 +-
 include/hw/acpi/cpu_hotplug.h          |  4 ++
 include/hw/acpi/generic_event_device.h |  5 ++
 include/hw/core/cpu.h                  |  1 +
 include/sysemu/kvm.h                   | 16 +++++++
 softmmu/physmem.c                      | 25 ++++++++++
 target/arm/kvm.c                       |  8 +++-
 16 files changed, 189 insertions(+), 28 deletions(-)
</pre>
    </blockquote>
    <p>Tested sanity cases on Ampere's platform.<br>
      Also tested VM live migration.<br>
      <br>
      Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a></p>
    <p><u>Regards</u>,</p>
    <p>-Vishnu<br>
    </p>
    <blockquote type="cite" cite="mid:20231009203601.17584-1-salil.mehta@huawei.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------kB0zeOeanlWDKmEl8YkPWb5r--

