Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAA7B14DA
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllPq-0001DT-Ei; Thu, 28 Sep 2023 03:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qllPm-0001D5-KO; Thu, 28 Sep 2023 03:26:27 -0400
Received: from mail-dm6nam04on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::618]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michal.Orzel@amd.com>)
 id 1qllPi-0003kd-Oj; Thu, 28 Sep 2023 03:26:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9PXRo6eBCV8e8BrXeOI93ArqVM5geGleeBOAHT92KFRhHHfvgVkR9neuOO0u2LVSqjsQCiA01Kz4TBcMagfM8aRPfZXCfzXP/keAXW4Du1FHQXaTqiSKhBFHD6HbwDINi8OkBSRQBR3UFRf3H2tvLnY8AH11o9u0qjiJ9ZXvJBf4BT7yQVbJWrMJVBZWeYuZlSe+dYTR49a/zQxKB6khmT5GStVihOj+X0VZOc6SoQ1ejyT88LhJDy1XUlemCGzXkheYwHYRmSjMsmMRFgDdu0k12KYny2Y3NZOGFfXorH5ZTgiR3+h2aI8BOPhncKP3xs5qEGfNRQzxQukuQMUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Lh/Fba5YMLgwTxiAO/0LSIeUyNytNHfPNn2TESqnlA=;
 b=JJJFsnmiDX3xLWOslpoZDO3QvPdF8hH5UzArFCFZvvqCbEGK4mtPiYDx/fsVBiXUk4dV278s0ee5pW1z+VmPtl4lyf3Y8spG8xmEaugagiOd1VIdei6sfY2wTyPjYL8VsAU5xu9Co/uNYinoeDKPQQ8PKKSzN+8m7lNNzOJkQyg9npB9bQ8XHKEY3PqGaJsx7pexzg4FeJv4SE66BMrPPLCvSDZTC79Zdcb66Q56fjCfe7tHyyNZmEk9d4sUEueu2ArZdfGUTfwbZ5Y13JmqnUxU+gUhv4UrBVOeqSYhl98eG6ILU56+3gq+upd4ejnE2nBEpAg8JiW/rGdV5ksTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Lh/Fba5YMLgwTxiAO/0LSIeUyNytNHfPNn2TESqnlA=;
 b=Zjv7hsMpbzGIRN93KjPk4MkE0tujir832AAmAtm3mYmgn3GfosZjrBWkmKEGVaQeWD4SuHOPSXhqmAJD9jAgNCzGb3xzvCtskFZ3Ql1PdSlXE5powWfKekGBVEza35I9VvI/+bh7rK5lsNW4k6j4MSPQAGAFI1ml1//FvriWg+8=
Received: from CYZPR19CA0006.namprd19.prod.outlook.com (2603:10b6:930:8e::14)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Thu, 28 Sep
 2023 07:26:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::45) by CYZPR19CA0006.outlook.office365.com
 (2603:10b6:930:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 07:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 07:26:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 02:26:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 02:26:15 -0500
Received: from [10.71.193.39] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 28 Sep 2023 02:26:14 -0500
Message-ID: <ec0addbb-7456-92ab-998c-b41cfbe0b29a@amd.com>
Date: Thu, 28 Sep 2023 09:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <stefano.stabellini@amd.com>, <Oleksandr_Tyshchenko@epam.com>
References: <20230922132111.9149-1-michal.orzel@amd.com>
 <CAFEAcA-Vbzt2q17-s_A4cw+sn2bx8uQS2QGFXt5b2nj9d0UJig@mail.gmail.com>
From: Michal Orzel <michal.orzel@amd.com>
In-Reply-To: <CAFEAcA-Vbzt2q17-s_A4cw+sn2bx8uQS2QGFXt5b2nj9d0UJig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 02753afb-955a-4d52-a111-08dbbff43401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzsk1/wuEpiEAby7n2/GmWNpb2xOGDFGjsFy9QhBqtJwYAf1IcbWMNRgvi6wxCaLKk4CeD6imC2TwQl6SAcUD+chN2QA6STFFGj/O4uULVnanZxpyXdlLzaKoTmaGw7OLeS3briocV393V+JXxPffHDJffgQzgdgAc4yEmje+49O4BekfWLL19pEuGK1cFIEd9cknrWBIa3tY0FKMJjJK2mlKnHuzAq7QIwy5CsfaEJPRKftqvvDSqKyWkWAdL4fjvlhrItttblFS9eNDlXMM7HnbMbwSaDtcQnTISA05rVuatTRz4MrYXh2dgm5OJiJArwezwy8tx1Pg9gJuYHm8ippTBYZ9uJHHhg4rhDAgqK4Gw6kKYlzRIraKiTuNtIrYLKh49aPdDaijJprwNzCtl2tw4YDTIWQDM/KPen7LcRTvI06K98DDaG02Gbz99RgkWigvyHAtHARL9o9C8pAjdTYA/EJF5dghm1muCrJ/I33QfYD65udac1zAAXH8zRTovGsOUvvzlhjKnGs1VKEgyuOjDsFr9s6fhnC7n/88XM8uhwnY13HOf8PyqT2UxnesRW82KYagsuCWHOf7mUVM5YnkOUGRTjtNAgted5bjnW9SL+IYJLuQ4uGxv675Eau83KHoDvUwIes2FthRHpSFeYgAPWazG5GGQj5VAV6PYhuCkrO6cc7c/5pxHVQzafvSd9XxvqP2tPSW5bfiOxLZSUtV7ZoQb96IwAfSN+fBujfo5auhCkEn3/AUm9IOIXe4EjPWrW/bUlTOsGbM9av2ymWxlNLJSddZ0JjwyLFJkyqjCFWIEnWhKn1acJy4LYP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(54906003)(82740400003)(31696002)(53546011)(86362001)(6666004)(70206006)(2616005)(336012)(47076005)(83380400001)(356005)(426003)(26005)(36860700001)(478600001)(81166007)(6916009)(316002)(40480700001)(5660300002)(44832011)(16576012)(8936002)(70586007)(41300700001)(36756003)(8676002)(4326008)(31686004)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:26:16.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02753afb-955a-4d52-a111-08dbbff43401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::618;
 envelope-from=Michal.Orzel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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

Hi,

On 27/09/2023 17:49, Peter Maydell wrote:
> 
> 
> On Fri, 22 Sept 2023 at 14:21, Michal Orzel <michal.orzel@amd.com> wrote:
>>
>> On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
>> of Xen, a trap from EL2 was observed which is something not reproducible
>> on HW (also, Xen does not trap accesses to physical counter).
>>
>> This is because gt_counter_access() checks for an incorrect bit (1
>> instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
>> physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
>> When HCR_EL2.E2H is 0:
>>  - EL1PCTEN, bit [0]: refers to physical counter
>>  - EL1PCEN, bit [1]: refers to physical timer registers
>>
>> Fix it by checking for the right bit (i.e. 0) and update the comment
>> referring to incorrect bit name.
>>
>> Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
>> Signed-off-by: Michal Orzel <michal.orzel@amd.com>
>> ---
>> This is now in conformance to ARM ARM CNTPCT_EL0 pseudocode:
>> if PSTATE.EL == EL0 then
>> ...
>>     elif EL2Enabled() && HCR_EL2.E2H == '0' && CNTHCTL_EL2.EL1PCTEN == '0' then
>>         AArch64.SystemAccessTrap(EL2, 0x18);
>> ---
>>  target/arm/helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 3b22596eabf3..3a2d77b3f81e 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2483,9 +2483,9 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
>>                  return CP_ACCESS_TRAP_EL2;
>>              }
>>          } else {
>> -            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
>> +            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCTEN. */
>>              if (has_el2 && timeridx == GTIMER_PHYS &&
>> -                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
>> +                !extract32(env->cp15.cnthctl_el2, 0, 1)) {
>>                  return CP_ACCESS_TRAP_EL2;
>>              }
>>          }
> 
> I agree that the current logic is not correct, but this change
> makes this code identical to the "case 1" handling, so we
> can delete the whole "if (hcr & HCR_E2H) { ... } else { ...  }"
> block and instead fall through, as we already do in gt_timer_access().
Ok, will do.

~Michal

