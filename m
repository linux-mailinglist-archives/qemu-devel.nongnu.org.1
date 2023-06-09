Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECE72A131
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:25:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fqd-00074W-Qq; Fri, 09 Jun 2023 13:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqJ-0006zZ-Q2; Fri, 09 Jun 2023 13:24:08 -0400
Received: from mail-bn8nam12on20703.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::703]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqI-0004mw-4Y; Fri, 09 Jun 2023 13:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAQCYmObKq3tkFaPueS1V1V14q7Pbe3bjEGZ4ZGbYuDLnNtvP5Xac4MtmlVIiNYg4j/HfSlloyx4WHDA9/IbBmcdeec0tfM9LaIy9sN+aB5NxvSuL99y39M6mfWTy21Jiqee6PfAORywyRLQ7Goa2eIvXFqfcREHQ0KdxMeCGvuSunJQDnmWwlD7JAgksfgysKWxi0JXRkRsoquwHGmciZkAXHXcnJfFOkxW/WxzkqOuoWkWZr+R7U5z41biwjrLGRZVLXH4LiY0PSCENjkAbsTyJ1sDwe/yGix1w0ZxzAESMHAfFtzecab9aRCWWgLzSoWjzzYTq0hq7bJjzkM6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcJxsvx6FUu9stgirpLFuzIgGEys/dzaCRNKasjZZQo=;
 b=GIB+ynUIhLPU/uxHWhylIZ9QxT3aflicR5U2quYRts9T7YOvbKKh3s5LhOZJS6i2CjLPZfgntik0TZ4VHf5qC2oDrso9wi5rX49A/iwW/+IVwaIwTylc4TplCFt48NFuaUDa4K4+dkXHAYC38Ni908Y6l69oxNnaNsjdDHxo9wTksdPr0xMmjrn4hnqiOmnx31T19MMooYwluyNp3aTbguhw23EZ4ffsqfECyKnySGc0Hq4bPu8ySyQFct33Ej1o3FvRTV5dkTxRttlxSiaYT3DFgz+HczL6kS9zDP8kbqA4yAYnhrtz4A4lqIREpne1U4lQ26Z1nwxdR9Gc3nR8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcJxsvx6FUu9stgirpLFuzIgGEys/dzaCRNKasjZZQo=;
 b=J638GnXErWVNGkiFaXEWYFrJpZHuCBMSsQBvvYeYbCAcA/h5S2tRJcfb8TL7YQWf7lf6Z3n0qyfh4hbm/j/sUQ2HZrR7+uhEFBi51Qf5FZIUCOKcQjk88/rqqqzoDKEF3nEFOSn5pK58QKY4Hz3MjQZdx0GQfV4LodogbRYvUVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SJ2PR01MB8481.prod.exchangelabs.com (2603:10b6:a03:562::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Fri, 9 Jun 2023 17:23:52 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:23:52 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v3 2/8] target/arm: v8.3 PAC ID_AA64ISAR[12] feature-detection
Date: Fri,  9 Jun 2023 13:23:18 -0400
Message-Id: <20230609172324.982888-3-aaron@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: CH0PR01MB7124:EE_|SJ2PR01MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0c2b5d-86d2-4332-4a36-08db690e4b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGFe8ABmkf8AOjLlZx1N6Yiahn6bVuGRwt5gPzCrs3gwgNM8R3MNPxIgUsy/Lk89b0Z0b2tNDs1U5pUyzRYh8g+WfShZMvBLDXiAowKtyYxBIbz05fGdpvwm8QzB9jB3j50pu/GKXJBR74il6B8bAvpvMRrfqko66HEdOGd2kcNWjXCXDTB1FukG8nz2F53KbTv8UVMvkXgaPKC5FBUZC7AiTrTIo9pvuWYmGuG+Bhn+NwDTTy1Zh68qWrCaVVQVVo8+274J9IBNu3crnd9pOgHwebs1Jzv8bamTGcAgZIMW1oM81DVfhhsuiQu3rZyX7prOk11cqs3NJPD8DDpP0UwJUGgJPvyRqFViJDW45oOZLnLZkVqIskmpA23kPxtZTRjCU4/jKLpfLMJtmnTOEJCqWR8Dk8Y4kRacABq6yLDWDecbkuI6tvhV1b0t6eDSBWQVUpWcCrBGhrglYLsGlRsgNtHQeT/ysqFw3H/HGFJ7uk3F8wv7f0qq1JBgRXHb/TdlTp0yFCiYEouBRLrBEGiAdlCg7S776ncMgFdBZjuieM9otd1HAjt3U1HSLiH5RAVoLUu2pG7FwAdmz9gAYL9tFT8xy4C217qFVITuYVLFqZ1Ff2YtQkvUuZOI4d+9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39850400004)(396003)(376002)(451199021)(2906002)(83380400001)(26005)(1076003)(6506007)(6512007)(478600001)(110136005)(107886003)(52116002)(6486002)(6666004)(8936002)(8676002)(41300700001)(5660300002)(2616005)(66946007)(66476007)(4326008)(66556008)(186003)(316002)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBeQqbUup/3S9llsBFMJt2ScH3tZvVC3u9HGL31TBvyWycL8Ua6RqcMGRnIr?=
 =?us-ascii?Q?+6VW0KI4gkDxWbFluzboROxyHre480VTXlkjUPfHjwY1JujF1ZJ4bTTux5zG?=
 =?us-ascii?Q?eBNMn1oRqSLShInbWRW6isaAF+QJZsE758aLyLYv9OI7onnQk6Rd3Ba35WcX?=
 =?us-ascii?Q?sGXjnzIu1DDEXJ54IKiS6aoa1ppswQ6C5fWMT8dwaxI5lj+S+/VtZfiyOSIg?=
 =?us-ascii?Q?HqjN1OjfjvgmW9GTnajA0abuIUhyQu4/3Xy8IpiVOStLhxhUI3xMdGBY2Y9s?=
 =?us-ascii?Q?9oi1W/lKUHKwsgweZPkhsrFdAxGv+Lq+vH4fRyiVG65+HivFncUGm7YWOXVO?=
 =?us-ascii?Q?SRPqZgiINP56fy1mxkdWcbYWM8aus+scLvGsugT/EvSIbWbQBPxPqzuCripD?=
 =?us-ascii?Q?N1y7cLTfFhs4xH3Vu583qJ84mu50v+ZM12MozcEPIN8jbircqbOX1Dj+qVH8?=
 =?us-ascii?Q?x9VBOdOqAy/AA8Pmg86Oa2eM2P26xIhNgnjgPEkBt74L1HtRMkXgmD1ZF+Em?=
 =?us-ascii?Q?Nt7o5+w96J0Xp/ncoS2UYkyddL/o3McFndj3+lZMYCHrPRs2E4im41OD9cKV?=
 =?us-ascii?Q?oPqEttufGwRMlIsQM95sRMT8FAXkUIuVkHoRO++C3WOQDcz7e8PnX1xzuy79?=
 =?us-ascii?Q?zqOEhM1/VqJ/E7+CooKkaVEGEUyOiAZf3mE8aAYz0usN7cXDiVJXcrF/qrsk?=
 =?us-ascii?Q?oU1Mdb9X7e9Fk/AJvY7JIV+nLvBVUK521SxfA4EIEyqrKK69CiRjxAzaf46H?=
 =?us-ascii?Q?xIz8nvxXothExQN6bQ35KEmUsgwFGgj6vFL49kajKBXwZC0TxgRCMV3CqIoA?=
 =?us-ascii?Q?0iynCVrhk+x6OY/IR+o7pKAvq4kN6VbeJAJI4SnLt45pFrZqQVt9slU0I+XB?=
 =?us-ascii?Q?amiG+46tzuhaLCZjOfsmj7sFgK4ijCHrS4a7wVNHx3kk9vX2oNssOnZZK8wq?=
 =?us-ascii?Q?GzwyhTqnTGsePvTESldp19WXfvCX69FeYAAjft6aHG50KCO1NKhNq4lAYP5d?=
 =?us-ascii?Q?5RLAb7x7N0OuPBDIJ+UFNcX0AsbELnoTy0oclp4+8lVhMdA9663NVkbD21nT?=
 =?us-ascii?Q?5McJe40efS9N2z4QDQ+92DgWRbrT3cDJmSJrQ5Wgcd4rHXgTOem+pOafWry5?=
 =?us-ascii?Q?e6iv96rnWzetwb9i0jxZtKkF6xYU4CWGHYkWWtdjMTLOAeqIU0pdU963nND4?=
 =?us-ascii?Q?iUXjDyEAAb5frITk2VHBBeUKVwvBzw3o0xB7Lkt3FGlAKSj0HbUkxUSEtKqe?=
 =?us-ascii?Q?Tp+imZkeks9PqIh+gXAQx/rNfDmbhiPpwfwNeWGB14wTH3xwgebwuymm7MC2?=
 =?us-ascii?Q?L1IX2+NLxqie8ytH7mO9viJtFC5WLA5ll8ZUJ7waHnV4otuorsHOiTy7wC7W?=
 =?us-ascii?Q?1V4AGkBao9tpmHP4oxMZD1CTZRDPLZxiBLFIfKU7sAeD9RAXaUZIQN81KOTM?=
 =?us-ascii?Q?oDza+xbrGKhMZE0WPCenaR2iuIftAOZ6zVpgPpAKaEUQnWV8aT52BncYR5H0?=
 =?us-ascii?Q?QyG2Dt8gVA7fhV9sK/ML4EzasdNmK3ebgzXtHRCMN15NgxLImNm+a69sjQhT?=
 =?us-ascii?Q?mbsDq5lkPyZeHQ7GRUwanwM0yeC8W0oE2jiJR1aqLmLHTrp1kjIyiVTUqvN0?=
 =?us-ascii?Q?8QNiD5PKDgAldkl9QwQ86yg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0c2b5d-86d2-4332-4a36-08db690e4b59
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:23:51.9173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9e1UFooJ0Sld+v0HpPbac5cf2K8ACpqUWQNFAX31q2DZxZhXF3JigSJcV2FQUSHF9DHdA0Ic/Ry/wYzMQkCLQW8X1N4gmuVI2K8owezHL8W++5onI0tzdKT6r41e4aU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8481
Received-SPF: pass client-ip=2a01:111:f400:fe5b::703;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/cpu.h              | 65 +++++++++++++++++++++++++++++++++--
 target/arm/tcg/pauth_helper.c |  2 +-
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index df04c9a9ab..22dd898577 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3714,18 +3714,77 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
             (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
              FIELD_DP64(0, ID_AA64ISAR1, API, 0xf) |
              FIELD_DP64(0, ID_AA64ISAR1, GPA, 0xf) |
-             FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0;
+             FIELD_DP64(0, ID_AA64ISAR1, GPI, 0xf))) != 0 ||
+           (id->id_aa64isar2 &
+            (FIELD_DP64(0, ID_AA64ISAR2, APA3, 0xf) |
+             FIELD_DP64(0, ID_AA64ISAR2, GPA3, 0xf))) != 0;
 }
 
-static inline bool isar_feature_aa64_pauth_arch(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_pauth_arch_qarma5(const ARMISARegisters *id)
 {
     /*
-     * Return true if pauth is enabled with the architected QARMA algorithm.
+     * Return true if pauth is enabled with the architected QARMA5 algorithm.
      * QEMU will always set APA+GPA to the same value.
      */
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
 }
 
+static inline bool isar_feature_aa64_pauth_arch_qarma3(const ARMISARegisters *id)
+{
+    /*
+     * Return true if pauth is enabled with the architected QARMA3 algorithm.
+     * QEMU will always set APA3+GPA3 to the same result.
+     */
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+}
+
+static inline bool isar_feature_aa64_pauth_arch(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_pauth_arch_qarma5(id) ||
+        isar_feature_aa64_pauth_arch_qarma3(id);
+}
+
+static inline int isar_feature_pauth_get_features(const ARMISARegisters *id)
+{
+    if (isar_feature_aa64_pauth_arch_qarma5(id)) {
+        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA);
+    } else if (isar_feature_aa64_pauth_arch_qarma3(id)) {
+        return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3);
+    } else {
+        return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API);
+    }
+}
+
+static inline bool isar_feature_aa64_pauth_epac(const ARMISARegisters *id)
+{
+    /*
+     * Note that unlike most AArch64 features, EPAC is treated (in the ARM
+     * psedocode, at least) as not being implemented by larger values of this
+     * field. Our usage of '>=' rather than '==' here causes our implementation
+     * of PAC logic to diverge from ARM pseudocode - we must check that
+     * isar_feature_aa64_pauth2() returns false AND
+     * isar_feature_aa64_pauth_epac() returns true, where the pseudocode reads
+     * as if EPAC is not implemented if the value of this register is > 0b10.
+     * See the implementation of pauth_addpac() for an example.
+     */
+    return isar_feature_pauth_get_features(id) >= 0b0010;
+}
+
+static inline bool isar_feature_aa64_pauth2(const ARMISARegisters *id)
+{
+    return isar_feature_pauth_get_features(id) >= 0b0011;
+}
+
+static inline bool isar_feature_aa64_fpac(const ARMISARegisters *id)
+{
+    return isar_feature_pauth_get_features(id) >= 0b0100;
+}
+
+static inline bool isar_feature_aa64_fpac_combine(const ARMISARegisters *id)
+{
+    return isar_feature_pauth_get_features(id) >= 0b0101;
+}
+
 static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TLB) == 2;
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 62af569341..3ff4610a26 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -282,7 +282,7 @@ static uint64_t pauth_computepac_impdef(uint64_t data, uint64_t modifier,
 static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
                                  uint64_t modifier, ARMPACKey key)
 {
-    if (cpu_isar_feature(aa64_pauth_arch, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_pauth_arch_qarma5, env_archcpu(env))) {
         return pauth_computepac_architected(data, modifier, key);
     } else {
         return pauth_computepac_impdef(data, modifier, key);
-- 
2.25.1


