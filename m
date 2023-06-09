Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6E72A12F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fqb-00072U-QN; Fri, 09 Jun 2023 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqI-0006zJ-77; Fri, 09 Jun 2023 13:24:07 -0400
Received: from mail-bn8nam04on20731.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::731]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqF-0004ne-Ek; Fri, 09 Jun 2023 13:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd3PAjxmUyMr5feI4zITj6TQjaZD1P4Ylq12Hx+Rq5k3GdLAFR2ijTp0RZ6SnEADMCpWRUwreylYe5nlN9ejXhtcbh8ZRQfMOUzqETsWQG4578zyHBC2NktqbYYZIpeBK2sOzdjU6uZKOVqSZsf9+LV/zRxtoPbHzueuz7gNW6bc8MHhPLEpc+1uTcKbJE305LH1x3H6EHqbd+Rwxzaej4gvnHcuuDi6PNvctrD+QtsJF59Y3hOootNozMhohYkNjBJf3L6+3wAiAxyG6ofaXVfynTFSjtmohWw8golCokgqiTUl8IjixTzAByXrjv1tjnUJM+fI52GghXDlE2eQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxn4vPThl+baVuxP8ItkNRPLUFSSsevGoNesf5gj2Ic=;
 b=g+051uCMqi7e+0aHu14Q6TnQVNpZzY+r+Mhaz7YkUu0dym5mlxcFHkq1Y7JYYoNnWYR9jRNQ4pxbi6TFanRQD0O1DGEVC3i6s7Lac+r0JF694vyBjjVMhRYTBV/O57oUvvOjDoR0LsHJF1mlCWE/mgyQTsUNlSDzOdrE08nMvQKHmv+nYrpYFhc9W0RW/SPBLgkfWMwgrq64GvKseRj/tpEm6j94mOtls9lKwWkHQRGlFDR9z+ADKUGsz1m0a1RN0QgxWrjh/WWGyD8J8d6XzV3H2M3iy35mvlLFRiNymyWi0d4Z/088NV9EttO6/+yS4SLsUOUtnc0bhUasZl7YoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxn4vPThl+baVuxP8ItkNRPLUFSSsevGoNesf5gj2Ic=;
 b=eaWAJAS0gQw7SCEX9mujn1X5ZmyfZXeeIl3BNZrxTPsNnkEB07JAHM34c24QNxxnFmD36xhdwesq+9IDHa33V5eTvd1mN4oVlSMK85VSPslEnXh25LaMeoysgT8oclTnz1qBt5suNvk/RLe2rdMovef972KNSkSdDkdjegG6csU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SJ2PR01MB8126.prod.exchangelabs.com (2603:10b6:a03:4fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 17:23:54 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:23:54 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v3 6/8] targer/arm: Inform helpers whether a PAC instruction
 is 'combined'
Date: Fri,  9 Jun 2023 13:23:22 -0400
Message-Id: <20230609172324.982888-7-aaron@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609172324.982888-1-aaron@os.amperecomputing.com>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:b0::14) To CH0PR01MB7124.prod.exchangelabs.com
 (2603:10b6:610:f3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7124:EE_|SJ2PR01MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 11085a27-53bd-4cdd-3937-08db690e4ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VocPE2Zcb8HFQEZeuW9HlVVRep/JLOim1MIYPOc/ocA4MQIn0aq+icPxyxA+XYG+w81G2jrsKMKzMqTIALIPG+O2mEWjQVIZqvoP9y4yfnSAg1xfJNK+khOdIFRYz7b/jsFzWC1zqLExvQsbpT6p1nRopUZX9QIfinrY1VxP3CUWNj3VRxTt4DVyziXs5v1mZrzl9PyMtltKT2MWrHIY/baQlV1tCMIbZsagO7ePk8cR3NOZhab5vJnP0PMobHCOchty7tZFVEiR9Zp+LC04wbDyFxXLqKLU378JgwpCvemwHi4Kv6k8Df8Sm5hbjy7Fxu34zAKmUCrlY67YsxvlWdy8wA+LuzCl9Iwzmap8mKq7gK+W92nYhbW8STxADeIvy0o4kFwXC6aJUGYVyS+WxByUG6QEnutYY1Dx/39u2ukKwyALeGF/zPKtETEzzHnvjCayjvAjfEZgMqWSPE00/Z8pRzeXB3uZ1yX9uNuvmuikZhjOWMtTL5pBBjk0Kmg1zp7lZAYtTTsoWLp3nSADTD9V9KgPEuufNpfvwblDdIJLw1s1SxhqLVKfacZw0mKdSEsCwfDbPCffS9vx63vKrNmBr26tS1nVLVBFhTVbSMeDmd2l2O8Ldndlnp2Ba+kr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199021)(8676002)(316002)(5660300002)(66946007)(66476007)(66556008)(4326008)(2906002)(8936002)(41300700001)(110136005)(52116002)(6666004)(6486002)(6512007)(26005)(1076003)(186003)(107886003)(2616005)(6506007)(83380400001)(478600001)(38350700002)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z1nLNhH/klC9HISph90jOnELFHz7jv3iQx1xkJBZnJolggBOwSKiTIjtoi+O?=
 =?us-ascii?Q?VEvzReCzwp6/Of6xBS0d8VIfs19TcjrPoHuWBbw+x2SeQ3SlgXl+JuFJyg9s?=
 =?us-ascii?Q?rBQASTS2Q1MaYnMONwxJMk+cViCjQTXyN8fICRnAaopTtcWY1ohDUlpeB2Tt?=
 =?us-ascii?Q?RX50TxAHST9ucx0Pc9oWKpnBy6fSZqtXdgE21nV2CHC9iwK/F5Jf3nVpR3S9?=
 =?us-ascii?Q?MPuD25U6FWfzNlobiw9XZLM+QUcs6UZH8KHbhYgcivVL2qt4jnmCcg/YTsH3?=
 =?us-ascii?Q?DLocTPEhmnzA80SvVoes4uwMuE0V5jdnQno/vDHOe0b37NdlTP6RykQ2kXS9?=
 =?us-ascii?Q?OlYxnDpR13xO/bxU2LaYbIyS27Zi61vwyI7LMymuAZhjoLCW+2DVIkA5Czla?=
 =?us-ascii?Q?nm1R+PtL4Oe/ArXRyzswAAtf3ag7jUUBRmnIqRM8HhipvOeHIGHopdQg3+K0?=
 =?us-ascii?Q?S65PvZZTTUMKk8LYBXl73utUFH340EqbgjYId3MbNawnlOrCBimGk/1oHV16?=
 =?us-ascii?Q?6UK3NEb0SBpwGfd9Qk3ZkwDxfzo9wtyisNc9tAy+LGgKwrpvuckL50vuPDC9?=
 =?us-ascii?Q?1UNc8/yGV47pU1DWeoESb0bA5v/upDOM9Hlm6exadrVDEqpFcoprpEn96T4C?=
 =?us-ascii?Q?W5SbwfnIIOPD8EMloXfy3IBewK14uxZfjRIz1N+sD9O0G92d8cMYVsL7s9zI?=
 =?us-ascii?Q?g12gq+XkOMz1TcdxiKrtRFcnXCmEptu3t9T6x+NRmPFQrgNivgpJQT9NzuIt?=
 =?us-ascii?Q?C7l/Fw0/TjPYs0bB7I3wTpososXWqORG43+zxeBJ1ENoHLwYxSDfsSZ3eEmJ?=
 =?us-ascii?Q?eW+jl9A1weiqcOm3HivbQzgjRJ6xJ9KVruRnPvuaHjeq34fe1Hk3K5tKvjZ+?=
 =?us-ascii?Q?D6rPrLOoV0VgguLJ8tZOv8eksPsFuUdg6yEo7mvSNotaC3JDHb1zRPSWzdkq?=
 =?us-ascii?Q?3faLLftGOQGXGf57SSr3hp/5rR3HsR4qJ9RkQMFvmSwb76eefJ3b5mfEHXe5?=
 =?us-ascii?Q?VxINpK7aHLnPlWuyDxulDmGPEQDlC/wa2qSo9PGUbQHN0Uhk2+oS7xNrM4Mt?=
 =?us-ascii?Q?m7JkPihvf0hlCeNzvJlbK1yTCZmPXgL7nmNmeEKLX973g8dcVmdaMGe0fVTG?=
 =?us-ascii?Q?GjmBH/ax2P/9P6IKK8tP0Th2ARipWL4Y7W2zNzk6b+qFBEXovtpyHJTzvIfb?=
 =?us-ascii?Q?9x+TG0Ka4P0BkNjDdsutkWgB63sXe6VCtzRr/x3StZmylWlvfBcTdvHcJWmf?=
 =?us-ascii?Q?1mrxdwVHGQHRplnKejcsXsrFSaVklyepSW5HaHEmFStAs5sTpFxQSskEEINh?=
 =?us-ascii?Q?MIuSPwWHzs4HrDUPp9KRxYImIY4dMk4CphX1AqB+TTQ9n6nUtDVGtMW+3ZBH?=
 =?us-ascii?Q?lP27CwkjVdUDONwRydr9FRdJIc3mSLPLzh8NE3zpx0/WRf2CjKgSKVVavESz?=
 =?us-ascii?Q?jrDVvph8cNvuN3reivxdJfsWAb4KEWkbaipKEiFWx00QoQHUY71CmJdjzwG/?=
 =?us-ascii?Q?5SGkDUoZFrWJJqM3hXtnICQIf15309CZfZqhJz+wMAHbwqClf1cxGjESn020?=
 =?us-ascii?Q?hg7cuVaHyWxT9PlxeXMgXWlADH90Ldj00lmwchH0U//wyZen9kGPhPJJje+b?=
 =?us-ascii?Q?2fUyUpFTalGKy+qIqyL+Zwk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11085a27-53bd-4cdd-3937-08db690e4ce0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:23:54.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpwbwtbTWu+7YEHBMb5ArynMXcgApaxMTf/p8qbTr9mgSoNy59zv1vh8l5qQBF6UlY2cMyyH3q8pCTDDrVxOOJOFBIkujsiPeiIig2rVp39e7/3z+GDeLNs2TjS/rIJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8126
Received-SPF: pass client-ip=2a01:111:f400:7e8d::731;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

An instruction is a 'combined' Pointer Authentication instruction if it
does something in addition to PAC - for instance, branching to or
loading an address from the authenticated pointer. Knowing whether a PAC
operation is 'combined' is needed to implement the FPACCOMBINE feature
for ARMv8.3.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  4 ++
 target/arm/tcg/pauth_helper.c  | 71 +++++++++++++++++++++++++++-------
 target/arm/tcg/translate-a64.c | 12 +++---
 3 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 3d5957c11f..57cfd68569 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -90,9 +90,13 @@ DEF_HELPER_FLAGS_3(pacda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacga, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autia, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autia_combined, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autib, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autib_combined, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autda_combined, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autdb_combined, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index b0282d1a05..278d6d36bc 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -396,7 +396,8 @@ static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
 }
 
 static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
-                           ARMPACKey *key, bool data, int keynumber)
+                           ARMPACKey *key, bool data, int keynumber,
+                           uintptr_t ra, bool is_combined)
 {
     ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
@@ -518,44 +519,88 @@ uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
     return pac & 0xffffffff00000000ull;
 }
 
-uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
+static uint64_t pauth_autia(CPUARMState *env, uint64_t x, uint64_t y,
+                            uintptr_t ra, bool is_combined)
 {
     int el = arm_current_el(env);
     if (!pauth_key_enabled(env, el, SCTLR_EnIA)) {
         return x;
     }
-    pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->keys.apia, false, 0);
+    pauth_check_trap(env, el, ra);
+    return pauth_auth(env, x, y, &env->keys.apia, false, 0, ra, is_combined);
 }
 
-uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
+uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autia(env, x, y, GETPC(), false);
+}
+
+uint64_t HELPER(autia_combined)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autia(env, x, y, GETPC(), true);
+}
+
+static uint64_t pauth_autib(CPUARMState *env, uint64_t x, uint64_t y,
+                            uintptr_t ra, bool is_combined)
 {
     int el = arm_current_el(env);
     if (!pauth_key_enabled(env, el, SCTLR_EnIB)) {
         return x;
     }
-    pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->keys.apib, false, 1);
+    pauth_check_trap(env, el, ra);
+    return pauth_auth(env, x, y, &env->keys.apib, false, 1, ra, is_combined);
 }
 
-uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
+uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autib(env, x, y, GETPC(), false);
+}
+
+uint64_t HELPER(autib_combined)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autib(env, x, y, GETPC(), true);
+}
+
+static uint64_t pauth_autda(CPUARMState *env, uint64_t x, uint64_t y,
+                            uintptr_t ra, bool is_combined)
 {
     int el = arm_current_el(env);
     if (!pauth_key_enabled(env, el, SCTLR_EnDA)) {
         return x;
     }
-    pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->keys.apda, true, 0);
+    pauth_check_trap(env, el, ra);
+    return pauth_auth(env, x, y, &env->keys.apda, true, 0, ra, is_combined);
 }
 
-uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
+uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autda(env, x, y, GETPC(), false);
+}
+
+uint64_t HELPER(autda_combined)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autda(env, x, y, GETPC(), true);
+}
+
+static uint64_t pauth_autdb(CPUARMState *env, uint64_t x, uint64_t y,
+                            uintptr_t ra, bool is_combined)
 {
     int el = arm_current_el(env);
     if (!pauth_key_enabled(env, el, SCTLR_EnDB)) {
         return x;
     }
-    pauth_check_trap(env, el, GETPC());
-    return pauth_auth(env, x, y, &env->keys.apdb, true, 1);
+    pauth_check_trap(env, el, ra);
+    return pauth_auth(env, x, y, &env->keys.apdb, true, 1, ra, is_combined);
+}
+
+uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autdb(env, x, y, GETPC(), false);
+}
+
+uint64_t HELPER(autdb_combined)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    return pauth_autdb(env, x, y, GETPC(), true);
 }
 
 uint64_t HELPER(xpaci)(CPUARMState *env, uint64_t a)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aa93f37e21..e1e49b7325 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1508,9 +1508,9 @@ static TCGv_i64 auth_branch_target(DisasContext *s, TCGv_i64 dst,
 
     truedst = tcg_temp_new_i64();
     if (use_key_a) {
-        gen_helper_autia(truedst, cpu_env, dst, modifier);
+        gen_helper_autia_combined(truedst, cpu_env, dst, modifier);
     } else {
-        gen_helper_autib(truedst, cpu_env, dst, modifier);
+        gen_helper_autib_combined(truedst, cpu_env, dst, modifier);
     }
     return truedst;
 }
@@ -3587,11 +3587,11 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
 
     if (s->pauth_active) {
         if (use_key_a) {
-            gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
-                             tcg_constant_i64(0));
+            gen_helper_autda_combined(dirty_addr, cpu_env, dirty_addr,
+                                      tcg_constant_i64(0));
         } else {
-            gen_helper_autdb(dirty_addr, cpu_env, dirty_addr,
-                             tcg_constant_i64(0));
+            gen_helper_autdb_combined(dirty_addr, cpu_env, dirty_addr,
+                                      tcg_constant_i64(0));
         }
     }
 
-- 
2.25.1


