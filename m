Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E252720B20
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5CZK-000605-HB; Fri, 02 Jun 2023 17:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q5CZI-0005zn-At; Fri, 02 Jun 2023 17:44:20 -0400
Received: from mail-mw2nam04olkn2082c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::82c]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q5CZE-0000g4-59; Fri, 02 Jun 2023 17:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdLon8mp+1/VXV9KgwDXrsqjGxqGMaLR+wPRPePoSacgO8BaJRzCwGau+/jLiKcL9W+Sl8XF05OlGJD4aPUFW5FHxEbtFH8JPXFWTXSfHkuzpxIa4/ya2Hhr97FLpeSqpYjkNOfSfXpZtSc6GhqRPRmYesqWc92xd1DsDYXyFXBNstQ5/unnnd3H2hSm8suG7/2OiQCwYKzfNry0gYsLEs/F1vtvd5XHn7q7m/XJB4dbs8ujdY1lGdrdJS4zU7gvPgZrSjiPAWvrV4sP6gyla0wl5gAn6KZOJhgow6LTqj89S3Z52ydVGXMWr+RI3HRw7qtZV8uTzZ5YG44h52zL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TM1HI3izRiT+DvYa7io2AISdZlGuXEjEXDA9g5vJ/4=;
 b=YzW7kELPH1snasSopBQKOuCxJN0rpm2cUouYFP5FhdnA1vN61AtRdSlp6vhTqd6O2eDKc3M1spd980auugjbTucyuLO2n37nKeHvFqclMnnGW7N5TVK0A+D5kVMXJ0/zvhaA3DxWvQ6V13Uh6DnH9JsHfRfEWgkom7dKVGm0r+Z45xcSI+jiVONx5jkrQEQbc5JlGCnoFTWmtpCsjnJitcBvIS6LQflp1gHHnhUQhs/PAWwlEhgtjelWkt95+3PxRgQV+aJInTOZZ9/9Z0PxYElzNgR+AuNJRfSyCTFv9icLHKoSAw+SnCFn26msD/lzozjZMgWvV4Kc0mbbLlh1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TM1HI3izRiT+DvYa7io2AISdZlGuXEjEXDA9g5vJ/4=;
 b=kfuJy+JtQ1y9VhHqDp9OljZuGHJpw422P3BqlCjmDzwXC3xjMRdnrS99zEUeNx+lzkff4O/0Ax9LfztdLAO2ax8eqxyE2C7D94N9HFj86yg2Fkbmd6XThrd8ohy4AnTVefQirGZixLm/adfBwSQPg6HDuioyGCyosNkwU5nZDAowVqzeZpLIMKt8f5meWhTmPGS5XIKZbK5PQv43KVRI/jAZsekio3W5Ob1xzFMTej0HQKTZH0xAJ95cvaVJ3f4rldLXdfl9T+CKm7V3TJbI3wkJ+Z43UAEnrC1HjjWs/eav+OaeAKLw7vSkjwHZfMNPrsXxL2SJ4/iGEB78xXAqxQ==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 21:44:11 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 21:44:11 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH] target/arm: trap DCC access in user mode emulation
Date: Fri,  2 Jun 2023 14:43:27 -0700
Message-ID: <DS7PR12MB630905198DD8E69F6817544CAC4EA@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9DmVhJdkeXafypbweJNbV2oIUXtT7+On]
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230602214327.55739-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d53301e-7897-4c0b-7740-08db63b28051
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKyNVnLBfCRsxfwUnbUZe6oEOzx+ziJwhBFprBdWfdFM778blMnW5rrYMkrzn8EiDKgj6mNXEUWRF+OB9bx+jtz/D2oNhwhA1dNhc+y7A1QuHsPvwimnZKHyHTTYUCveNRO0+Vm4bwOQh6dluzPNLzm6d89SFyh1RHRnqNuK0uW3U5/Ou6Gg1J34LJOtDa6oHCpZtW1K5McGOuQbYQLFoEVI11KFkriQddwUrRZwvHA3UfWbRI4VUknM8PmDHz6deQFdmqqE1o4yK4QLPhHUNz0x6SNhONbBIZ8Bdm5gX6suzlpQKECZOtzMambPJdWmTiK8LBgtUaPq1UL+Ya9ZVubqk4sJZzhZpuPoH1UoVJCJh5Cw7OlbY5WpaXnuudv1hIG5o5XZyzl7F0fRp81Lsp7Y0x3BubMiwExqSAAXPzeYXpth0cjc96B22wTdbv3Qjkewap1ilUUyESfZ3MqXsPtO4VxqkBuLFhyMocfjRF7ZkKOb2IQAMLG4OHcxN8n8o2HnKqjf5/FPeauM5WvZmFueKMoWTEhZKOTVw4rMRte3FbEdUcvt+/Wgt/ElgTtl4NUPihI5mldfaKVz+UTMKTwgbHseMqNIS37UC3/PXmMQPpTON/DsQrvMCBYcPo0sQe+HyXnamUiLSHy6/HD9cpwWNnT7KpiU8NfNiGo8vEGcfY/JLvzq/XuXVrLIYGDyiQlqLxsa4zElRpByyyh8zsTqQLVWJFCqX80=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsivN1NWbfzR1KbJH8101OMIUOuMHk4TuUEdTZZOtTkTtW1/I1tiQpb6EbzRDRFpLu5OxRjaqBTjpDUW44zYRFDOS0MfTW0z21rddq4cppiNvgURuroMlDNETngXNKyVJsUj+f0t89RdQSAFhXZTqpi63mwl3j0bN8xs1x02UIpqElQMKF3tpTOaDRouZp6oqMmT6Q1YNYjqwhntzihV5NEqxYB0cpm9iZmUr88C42nCl42zIwV7IeD/eV+/tHquxCSWVG94tWxCytIKS4ZrhQ5BWafSjPEaKdKTztOippORqhrCfqUpr0pCaF+2+9iHFbundmZPWy0EPNyFhAmAOC1BHL6CqoJjCfp2QLiCvoMg3wrfNSzIDHCwgi1nb4B5FQLGHA5NCPT3hnspVMGiqTd2nDcLqbD5sz/n/o/NeBT3/zM/Q5xfXUKGoVYSmv3N0sty//lgT2bTdMWXQVew3TGhtoLiO0JLoj0ZJ2WlsO5dGO4YsJAOMVTOuIycDjluH6e2Tz6vfSikA4G0qPhnbTTs1NElB1VZhbBEQXXKZrfBBHURTi7GATR9yig02V2zUGSaLBjlAGdN8JPJta4LU4CZqpU522MqIzInV4XtfYA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWQ05GiA/VtZPYPzSW3tayTx70JH+SgPQGAy+cdFiqtzD41x6UdDjdjB12nE?=
 =?us-ascii?Q?cl0/geCPCySNP10CK5Yi+QPROpAOyXOGd/QBGuR5cZtcYVXA9zILMEgnr/Ib?=
 =?us-ascii?Q?fGgv/W+x98IUybPNssLEXATKrtJh6EpXnb3S5v6NWzNE7LBtG8c62Ga73Yai?=
 =?us-ascii?Q?Ch2RKs5Qy/T0kpVpLEYLTodEfpu4VN+MOAwpa1w9uEX8LHFGvi2kGO1xHBOP?=
 =?us-ascii?Q?AcuyROlT1H6eT3Wj9ICYW54NGZX/MxblufPPqR2m9S/Oz8VBsG7Kpku+JZDv?=
 =?us-ascii?Q?9Xzq4JREm88/vtK/b4yLUyIo94KM4UZ4ibtzaY3nnjEV2DUMRqmkdaWgakg/?=
 =?us-ascii?Q?9ZJcPVyKl004s6eTir5XkJBld32Dvpt0YzKZcd/BppynQn0C7EUyEKRrzmG/?=
 =?us-ascii?Q?1U8M6OA0rm9H4P+yYJ24eUx+paXGVoZlLA5Kkmt7lVCxOeK+QKN/dnIogdM6?=
 =?us-ascii?Q?0Zh3SeKTXkD2hxckBe+7/33kL1sLzhibK2FS1p5i//szRCZ8nEYAS/4uWdAw?=
 =?us-ascii?Q?5tCtMGXvf9MdV6pc7GHS2cz/UvVsRtND+2xyl/2U+irA3Nd90poxnpA+KA3b?=
 =?us-ascii?Q?7Ume323AkWIvJB2/6xKL+hmHdTNurbiuNLg2elw7a1ILMv9u1O4cuyojh/rJ?=
 =?us-ascii?Q?X3qurRM1GpUfXNXMr2Qg+/T5VY1KPdmZ6h1lFK/3oNqV9RnPPTnpYAeF68WG?=
 =?us-ascii?Q?0LFM6et/j2fhUN7NlAPyh8r8/0eAYsyiS0D5SHu1gfh7RTvmVo6oSbjM0PDn?=
 =?us-ascii?Q?F6g1/NO8nJnJstLRSWPmtwjW1+MU0gDHFTBiWL1mTkOHMKTQEM+wMnWp4YmO?=
 =?us-ascii?Q?i9EBjfzP+3BASS2FaoJALCASk4c1U8l9TL5cUq4jXYLDBQx3XcEZzRWhtNAa?=
 =?us-ascii?Q?Ax/vQgcT4Wrzu7xr9BHwFy4kh33a60yPp0uVQ3w9xbLx4qa/TwqTqmAs+UMK?=
 =?us-ascii?Q?BC++v83K4H/lnkSLSwalAluPWLe8rgt5yYoLuEe484vv5sbEYB2n0cE0Sub3?=
 =?us-ascii?Q?eg0Xxe6C4rR+UoC1sHt+0GC2LhGVDsIjGl0vRzehan359V24Apy9X0BYddKp?=
 =?us-ascii?Q?YWJW9Yw1BAaK2WM2w1c1aHD9nWe36YaFaS13VUYEeM/Nqa+omGYB5h7I3OUz?=
 =?us-ascii?Q?jSZi5WakqWxWTmSyRfrqlbZn6honbpb2lR/U3+SBZRtwb+ttimagtCkpPoT1?=
 =?us-ascii?Q?rPdNUfV6azsFFebGlk8KcjMD5oH7hMb5JzsrTkamnd+eWimFSCetqgwn9og?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d53301e-7897-4c0b-7740-08db63b28051
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:44:11.5842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
Received-SPF: pass client-ip=2a01:111:f400:7e8c::82c;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Accessing EL0-accessible Debug Communication Channel (DCC) registers in
user mode emulation is currently enabled.  However, it does not match
Linux behavior as Linux sets MDSCR_EL1.TDCC on startup to disable EL0
access to DCC (see __cpu_setup() in arch/arm64/mm/proc.S).

This patch fixes access_tdcc() to check MDSCR_EL1.TDCC for EL0 and sets
MDSCR_EL1.TDCC for user mode emulation to match Linux.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
---
 target/arm/cpu.c          | 2 ++
 target/arm/debug_helper.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5182ed0c91..4d5bb57f07 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -289,6 +289,8 @@ static void arm_cpu_reset_hold(Object *obj)
          * This is not yet exposed from the Linux kernel in any way.
          */
         env->cp15.sctlr_el[1] |= SCTLR_TSCXT;
+        /* Disable access to Debug Communication Channel (DCC). */
+        env->cp15.mdscr_el1 |= 1 << 12;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index d41cc643b1..8362462a07 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -842,12 +842,14 @@ static CPAccessResult access_tda(CPUARMState *env, const ARMCPRegInfo *ri,
  * is implemented then these are controlled by MDCR_EL2.TDCC for
  * EL2 and MDCR_EL3.TDCC for EL3. They are also controlled by
  * the general debug access trap bits MDCR_EL2.TDA and MDCR_EL3.TDA.
+ * For EL0, they are also controlled by MDSCR_EL1.TDCC.
  */
 static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
     int el = arm_current_el(env);
     uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
+    bool mdscr_el1_tdcc = extract32(env->cp15.mdscr_el1, 12, 1);
     bool mdcr_el2_tda = (mdcr_el2 & MDCR_TDA) || (mdcr_el2 & MDCR_TDE) ||
         (arm_hcr_el2_eff(env) & HCR_TGE);
     bool mdcr_el2_tdcc = cpu_isar_feature(aa64_fgt, env_archcpu(env)) &&
@@ -855,6 +857,9 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
     bool mdcr_el3_tdcc = cpu_isar_feature(aa64_fgt, env_archcpu(env)) &&
                                           (env->cp15.mdcr_el3 & MDCR_TDCC);
 
+    if (el < 1 && mdscr_el1_tdcc) {
+        return CP_ACCESS_TRAP;
+    }
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
     }
-- 
2.40.1


