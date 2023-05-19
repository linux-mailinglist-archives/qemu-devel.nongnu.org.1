Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87E70A22D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 23:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q084C-00056i-7g; Fri, 19 May 2023 17:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q0849-00056S-2g; Fri, 19 May 2023 17:55:13 -0400
Received: from mail-mw2nam10olkn20829.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::829]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q0847-0003zG-DD; Fri, 19 May 2023 17:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcN1WiE1aVJ15+bVqX4pmJ2zEwwG00XlCIxUpsFGUui2SPlu+XQW5SMzKeGfH31BB03iZCjTnk12ALQNkwRlSmhnoyyqzwGDkf4AbMmHpQmDHmoOKiAzRck0hHU3SSgnFcObfcU19Vcb6gw2sDIl3PVAG0TTsXz1U6pZSO93JDEfwoeohkCgaDZX7DwnHxgr7Bn/ZpWF4y415haFLxj0ehoxa1d7x2InWzU0/1ZA3o9aYY5WSA26T9HM3LqMVZoVYi3AEoQ8qKTGETiRBKwi2Fxp0eIzuJAVOb5orDTrsv5PEwGpgAEuBFE6KJvyrO0odHmw6XCe+cFMTxbjnfbSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVhbSTn1f9xXwvJ+hF0swcFm8FM4hyHM9DIsrQ1twmY=;
 b=K2yf9jr27z0chLeN5TlVcIBq5qM2AR8Kk5VrCLayg7h5sEYzc1q5p2difw5+XW+Q01KKqsFmvGok5LFzmgzyAvrPIvH7aIcWq1mDCsTrF6ZaBLwjAKLhsPfJmTMVOjwJhbQD0DzMQRzA8xcPQ4NZWNitbMYPrKE+ppo8+exD7aK7X4/rTeTApnDGCqHnaqqSZZq4vyX5YJx1SowZSwDYYTXSJE6Lr14Lj/w1YVrawjrlzf7bpwi2fCiBSNZWy/ewSqrRFrKMIuVY7GkxEo0eLCR9RO02BQC8BMaaNa+5p2JVJ3VMVWOoWISn6UCWI5tlmsI7O0260oIOuKMDAAI18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVhbSTn1f9xXwvJ+hF0swcFm8FM4hyHM9DIsrQ1twmY=;
 b=qW4fdhKLhDRrvqGrhkl1GZcXY45X8Cg3LDfZjWWCaK8iE0hcoCUuZABWw+yxsex5dnvmdi5O/Y/Yczg4gWIjxpc0tMuSJ1HslnvKNXttoDsn48GsxNtUUrImrMLpXr3UYUcnqBEHLDmHwa4Jk0ronfIdme+jz/yiI21XsmsGeP9m5jQnOMs9qjfwJeqI3V8c6GCuAuUGWT9vW0MVT1E7mfrGeq8xrnsnYNUWdj2h/bE+DIpHmBmHbEGbxjD0HBiOY3JAkKHTA6zph/F5MyyYTEjCJfPPT7fxhZwu8sRv8IXEA/nUL1Yrd/3+WVl12+hQsrRsa7TVkah71piwVsMHdg==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Fri, 19 May
 2023 21:55:07 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::bf6e:1dc2:10ea:cc04%3]) with mapi id 15.20.6387.033; Fri, 19 May 2023
 21:55:07 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v3 1/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Fri, 19 May 2023 14:38:44 -0700
Message-ID: <DS7PR12MB63098739F9B61D53062B74F6AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
References: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iyi6Rs91/BFUron5LzA8Y9aDwGCNAQ0g]
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230519213845.283679-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b3e449-ebfa-4675-b92e-08db58b3b548
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nvAoS/oQTVQZ1S7Y8lGJvUp6lYURevRgkpBqiNUxyv9+UqC1zRKn73j9KUsBQBKQEAkXugecF27P+pOQs1t+rqcXYXCODn7USF10zT9b66mgwsvsRREKRv7RuEXBDjMCNxfxcx4VFb0WawRyIIxkeHQaLwszC3ow683vQ8gxWhr7IHt6WuCfVKwKRLhqW2ydXvURvCatFBOtC+P1Kq+/PMDI4I922ICmMSMWaf5W8AJvYn1CUdlEfVny5JzA73sTWHh6tmrb5uAn5hg1bqOX1HxLodHT7CiXLAjtzKp4gGPVP2qbfFlJYF+pfs1xw4VWgBHt8zO9KMwCfmdE0YIiO+E32n15KwBt2nWJDHulrkx5DaefJg5mr8WOoH3F7BvI/h5bMrjtbRxErUYxphJRt74LLD8VVAmYZaTwtH/C/KzgIjCOT6p79BmKAQRiQ/TBIRI1ChH2IJUdWMif5/02CkWmhX7LXeLGsIgS7ZvXJZgThpG+X3+UOJHxeka3cmLfssasbSZSqS/VDUojreUnGBWLreyLI7BwCpwJwvpZwnZjGJ0uot3GyppfB3e0pdZrz0jGXHWFgRsImi7GtCdnCa3ycmaIGJ+xrCMT+a68KqxgiDkvTXOQDeZS0Xof0KCVQbCD6a03MYw35kGH9i9F/q3gjraPML6GWjCokVEJMiExgWUp4iyeGgSImDugohmGG2T0DJXzIrzZJZje6P3pvvRQmnHm1a3cn0x+xuU8FJ1xZBfsHoGwe9XBZCQsJ+a2nQRjMBIuEzeNqN7WYxO7UN
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOiIS367X1FSj/YXm4d1kN7hgmeHrGrSW2geT1f261QgoxWXNVpSv7lNoexRyjMXvMSEvmTJ0rbhFng6mIO5d6IqbgDDSYEVkpJqoOxCR0eRcEbykqX3lfGMEzhQsYAhFYiQjijwvyzLC3Uv93gsGyK2ZqdeHHp/26rEH9qxGYtDFqgdmd594vJhjrBEIv/rFbQZGlHtj5hY23l962CRl8RSM12ty+N6lSqVc4xMg75mYiN+f78sze44QANw4sdM2si/si3fANEbD0uwOBDzo/EvyBicLQxbPxbGHdEULrXtVEmnrB4LkqPHwAOOBKBG8Vv0F40U9avabdasfGNrD/gsHh6mjzUa1M2Qek0QXcLMAg4dhLgFvulV6v0Rt5pXBYNXTbLeb5ABqrQGbTtA2QcNSaR8+ltdFsZf/YKEu/9qSRHqRavMTHajgQBh+WCaLFnkMD2NR7ZxIpUG87lFSDc4LYosM0QFb12DqdaNwiHG3YmQC5wdVFcwwkVCxj8usivlv3nxDSguRTx+Z82hRVnCu+T//WoEtEV3VRFjoP3RHTmy/ZCc2wAViFX8mwoAXF+5u8cFnicmwQExhECRT+fynyvUyLRRmwqMwMbDlwISMzc9mgOnjarNLEUAofx+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6yU7gNHm+h3X7MUfR8CddmLqctuL5MFd2FK1bMyC8BubNcJxMPYy+8HYIB1?=
 =?us-ascii?Q?7FZRUh6W85cO0hDQk2/fjnXG57mQAzab3x8e+hBtqxJpbbf5IkyVCkXrqzFz?=
 =?us-ascii?Q?0/K4prTkdQJnbF8HP7iq29MrZ4Q16kjeJTsXh/XhYN7yx5vCmkoS498KGKVk?=
 =?us-ascii?Q?j+Lt41B6r3nIwWHkv9dftSgedJkU/TRDbzDwXP9n85UoeDx880AEy1Stp7Ei?=
 =?us-ascii?Q?OGOSw6/822aBhQu4kNxgKLAvA1yzFvDBuh7Br1vpM8tY3qsC2YOnmjsPeWSl?=
 =?us-ascii?Q?meV2D6MV0Ua1/DTJx6rp6o2tY0loWdWEb0T08mLX9PzskpuT9YlKmWBSyZl6?=
 =?us-ascii?Q?bNY7Vppf/Y96OG+jGNFi8NP7abY9EBdqJBJl89VZPNXWrsVkshZ42Z25HZlc?=
 =?us-ascii?Q?GynB68qiHuaxk0wS++y0qqWyHQ+t91SxtZ03uj0UZf0cP8jonDPeaWewqsuu?=
 =?us-ascii?Q?NqchKfadqw9lSO7f0Gd7NTWuxdvMtRnBUpnbnRnekFBxNC5OTmnfys/wFIrC?=
 =?us-ascii?Q?7FVUnfyKZa9pv9aMKK2o4vGqPVI/kL2iTvctIsaYSawOH+FJYiDr8t6gXrio?=
 =?us-ascii?Q?gzHaJhBPJNx9c3208z1+F7xmtG20UqbpqujCgDwFKPijqnk8PA0p9nhqCk/S?=
 =?us-ascii?Q?wprpP3sWXdubPJO7FKTJCYj8xFrzjuCLPCPQI16mYwefg3IspGm/8CHduoUd?=
 =?us-ascii?Q?3bpAOh3fEhA0sIqMAAO3N4q/MjK/mUte4OnOowVJdaH3jAMlF88D5GRz0vGG?=
 =?us-ascii?Q?xSXUCImKJ6x8mn05TGPVqX8j1eCNX3wxFosvRbI1ddoC2WzZmRYH/Im0l6VC?=
 =?us-ascii?Q?zhCeRxJq8pNE0jjQMEbYZ9OAmIFjrYRUelyB/ZLmdq4bE9LuUW/YwkkcHct4?=
 =?us-ascii?Q?62zLjmSP1gpQogJIU4cqB/8dFV9AyezW1F1pDoi6S7WKmKI9BMnnbyAJCTld?=
 =?us-ascii?Q?iFsKh+j5u9mEqTW0X7k4w/nVpxMmEIyGYNZSaVC50a9Q43nyeHY/nshhmv/l?=
 =?us-ascii?Q?gWPRoF9dTNhe0ndbQmHq0geb5aYD9tUuEdEeyeg8B1UHjceFS69v3BhoQCch?=
 =?us-ascii?Q?qOfp+jMnZbLuqubBz43RuissDp4j3X5aRWrL2oDN6NfvvacqlCTzQ44srd6B?=
 =?us-ascii?Q?500nIMrMPplmP+GxkFo84/x7Ta0pqxvTCm7cY9Gq6HqBOSj3bBxUhi42WNa/?=
 =?us-ascii?Q?H/VXyR1qw+btQ2yBErZsa0pUZNUFvxjiFKF1faW3EC/0+1mdwOpMTarcSC4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b3e449-ebfa-4675-b92e-08db58b3b548
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 21:55:07.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
Received-SPF: pass client-ip=2a01:111:f400:7e89::829;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
user_cache_maint_handler() in arch/arm64/kernel/traps.c).

This patch enables execution of the two instructions in user mode
emulation.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 target/arm/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b7fd2e7e6..d4bee43bd0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7405,7 +7405,6 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-#ifndef CONFIG_USER_ONLY
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
@@ -7420,6 +7419,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
     /* This won't be crossing page boundaries */
     haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
     if (haddr) {
+#ifndef CONFIG_USER_ONLY
 
         ram_addr_t offset;
         MemoryRegion *mr;
@@ -7430,6 +7430,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         if (mr) {
             memory_region_writeback(mr, offset, dline_size);
         }
+#endif /*CONFIG_USER_ONLY*/
     }
 }
 
@@ -7448,7 +7449,6 @@ static const ARMCPRegInfo dcpodp_reg[] = {
       .fgt = FGT_DCCVADP,
       .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
 };
-#endif /*CONFIG_USER_ONLY*/
 
 static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
@@ -9092,7 +9092,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_tlbios, cpu)) {
         define_arm_cp_regs(cpu, tlbios_reginfo);
     }
-#ifndef CONFIG_USER_ONLY
     /* Data Cache clean instructions up to PoP */
     if (cpu_isar_feature(aa64_dcpop, cpu)) {
         define_one_arm_cp_reg(cpu, dcpop_reg);
@@ -9101,7 +9100,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             define_one_arm_cp_reg(cpu, dcpodp_reg);
         }
     }
-#endif /*CONFIG_USER_ONLY*/
 
     /*
      * If full MTE is enabled, add all of the system registers.
-- 
2.40.1


