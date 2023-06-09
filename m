Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4272A12C
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fqF-0006wd-Id; Fri, 09 Jun 2023 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqC-0006wG-HS; Fri, 09 Jun 2023 13:24:00 -0400
Received: from mail-bn8nam04on20731.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::731]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q7fqA-0004ne-VP; Fri, 09 Jun 2023 13:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjT1WR0xpNiCo9Gl/5Qpfoe13orshzVdrHCxiaMUvEeAGZdcpqm4P+LWXs1OfqALkpZwzYuN3v0o9Pvu1cdB6KGsfWNhVvjUwH+Oxh9sft+W6avdhRHfC7e9mbQcChiG7r3pliOzP/lLnpuOuLderfLPKrWkL9vaH6hlWYROL7ZKWDuEOnx7J7PJaRlyqUK2tXvD+mwQ4JyGgLxCoSq91rxU55/4T0LVNFNnVT+lELuVgzifKtXRV9JVpe1jRflu4jP0mCiM2kCeJ4h9+LS9tMp0mwMJig5ZEndiw78/xZRCp0/hoMlEraDqlY1xcFA4V9azqlELoGvLbkGgNlxeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnGBeRQCal4T4ULSbd3fbm3NoE/NjS+HeP6vgLIFZhw=;
 b=QvLfe7ZjvJZNbxfxKhzk3IzwfcgxMOcC1LtTmtI7N+xSjuv5lfe494ped++TpzAx9OHXYpJhTQdJ44bChdSg+E6dhWCI2TmB/wWwk8LZB2HuvwpToBuNRfdeWEmCZouc1dA/GR8P6FeHdQOQi08+FzMAOspEpY5e0LuZ4y0C3edN5CinZR9QwZUVf5rK6ioKC7BWz7cxl+7bojyYhbqUDhDVhOA/A9idPLaIvlxwtkM8b7hvfVYtpN3W11r6wXYknEzP2VSWyQ8E4t0yj035Y5KalQqNBVmclHszdHD7ViuiZuspYAbdc8DaGC1JJCnCJgFQAuqk0mf1U0NNuQ5yCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnGBeRQCal4T4ULSbd3fbm3NoE/NjS+HeP6vgLIFZhw=;
 b=adeSE8WgFz+pSu/oS+DhGufGENEEaS8pliIEgf4ny5sWae79MDoPbpazijMW271R7Y3Ey8Hm74f90MPnDmmLliIrnFMctYCsRwjamPXOqhiViJn8Wd6fJpmgYQDLobIGUAmGKp/yQY+X4Pgu7gWbO8BRKrUTIkHiDLEulOojXFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SJ2PR01MB8126.prod.exchangelabs.com (2603:10b6:a03:4fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 17:23:53 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:23:53 +0000
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
Subject: [PATCH v3 4/8] target/arm: Implement v8.3 EnhancedPAC
Date: Fri,  9 Jun 2023 13:23:20 -0400
Message-Id: <20230609172324.982888-5-aaron@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8448076-d311-466f-9db7-08db690e4bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpkRnqlUIN1tAXj11nClmW35YgRm9np73wjtcRa/uqnumqhs6WEoxr3jpzuXwEcvkZhPAHtDISdccoMNdCcBFX6KBzGEPZlkvxjzLeKpMGcXOEGyGE7vtWEf+GWWxXUoROpoVEcdvqaUazqIsbkcTBhL+8t4kZXI3brnZtsvrT/0dX2CZTbJWz4x+eTxPFYSegfZpKw/os6z7N3KgpDOGcX598mDMEsVAc5ersSvutcWJKZUcwwuflwcZs6P1gkNaFG9PWh8m0hQoOOsgHjnF5C/xuiGmeIwefoM41XKeXLEZSe7AiJnjz8Hif4K08QG3QLlQoHzQQHbDH8yR4yclNpw5ZLGgB/MNFKaxQ+IHMPOXqDxa4yPA8pD9dPOOSKUrck8MQtp8WhcX3Hlvy7xv5eoBOsLxRuKGKV6xC234DA8HVgPIUVEGjX+DXzqZTHK0HUGWPDujI9zDiOW4Y8+SV3TJ79Y558LqC2VMEYmrL49Bv/LXaBHim4GET9+fi7xc1IPRf6ojJ0LeMUGBnhyXi4VF6jM7XsmX/2iSENRFy1NA5pE7fZzPLoevu0g8kL2/OMaWY+WZxXAqkT7PggAaWdrfSYLrrYFRXVHB9+DVXJxTNmcIPcOruCWo/J4admV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199021)(8676002)(316002)(5660300002)(66946007)(66476007)(66556008)(4326008)(2906002)(8936002)(41300700001)(110136005)(52116002)(6666004)(6486002)(6512007)(26005)(1076003)(186003)(107886003)(2616005)(6506007)(83380400001)(478600001)(38350700002)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PN/DW1KNKD8PvRvQFUg/WPYpf+6QyQlCnZY/8p6guWln6DqvBnLxNVfIUq6v?=
 =?us-ascii?Q?HaZ5U6jq38VEgIF0NWxaavXTChhoFYp+C5vdw0mmotB3NwzKyLx/iWoAkayq?=
 =?us-ascii?Q?//uh7jbLmw5pX8Fv9+KCx0CmNPjopF1JZzlocwTXJn5HOgMoveglnlsC4YMV?=
 =?us-ascii?Q?KC/jY+f1xG54UBYuf7vyWSK2kmc9r1qPyPFz7n0rO+vZ/P9IRSbrmW5pRE0J?=
 =?us-ascii?Q?Tzp6x6Srmy7jvZRu686WiZk5d7dykGf/fWakyrgDT6g3/wI4Wn6Z48IhzJ4s?=
 =?us-ascii?Q?9eyj6NNlRpZJDDSoZ+Wwd5MZ4HezVTqQZ024rJ/k++/HEIvbwBaFgVZz6+60?=
 =?us-ascii?Q?xH5ObXGgsHiU6Sb6NQKViP0sZDqoFSdCKhuCVN2+36E/vgbIKlClL+oC/6gU?=
 =?us-ascii?Q?8I4Z1I1LxFBy0DMGeectc4y8oB48dj+l9gPaZD7UfS/EmeZuO65SvuE73FWh?=
 =?us-ascii?Q?itT7u0yjqNxvWI9m1gVcROBO14uu3bLxY6D2uF+IwLx1erBt9gAo8NAqmEQd?=
 =?us-ascii?Q?sBiUkfWDIjebgvRlLUkqs1oyAtVmE4Qx7CA1zaKXwoHBPO/8CpgXK0qZVUNp?=
 =?us-ascii?Q?szZYk9rcelN9dfJNwuoszERoMalYRrgnCqrJW+ODRBt1+nHPKJsaE55ig6lf?=
 =?us-ascii?Q?ygizYkvcq03f2xOjLXhmJ1jp2nZPMvCAarwPXUOxnL/OfApOFu500VZNQbtz?=
 =?us-ascii?Q?rTizHuHhyo+uoAU6p3LWO3A/Mjf35X6N3uE6X9LlHFFUbsDOVmasN5qigDUV?=
 =?us-ascii?Q?XLfy+G4FQ0VAVX5Mn4SP5kShRN5VofiwTcC60i1uPRcLMi5slcVgpds4OrFK?=
 =?us-ascii?Q?f2hPC0YD95+yoOkO/OylyPLHZHe2sCONHbnWsI5O2/1UYdpoHCtz+8PJgP3W?=
 =?us-ascii?Q?QTKBRWuHLv9n3Ko6LasEMm5ZGeFeD2Qm/B1Jms14QIdtUUAGVSKMiNQT7YCX?=
 =?us-ascii?Q?2rRmikEEdlPpPcdM11QU2K8PmXYCZAT70ZeNxh3OD7kIP3ZxIAaoAE7X0qU5?=
 =?us-ascii?Q?3jTinJ4rzuDWKVSiqGDPjGLkebMPB8kogPPIQIdpFCiz0fiLyrlKlUiSh6I+?=
 =?us-ascii?Q?4RFNfoPSNiEDdl05VpVqU9pitEjv0FubPuoKN+c1KlNpXHUPcuvhIWHRQU5l?=
 =?us-ascii?Q?l+9poP1gmX1FlO663wRWprm2DyzpcykoLUolZQhuwuB2nymPmTbjUUq2WkVN?=
 =?us-ascii?Q?nA6EG7yNctesJZdz+ZlKFdxJvhVKXubfyJwTzzaogrwvzvDLZDf49Fvj1zHi?=
 =?us-ascii?Q?5uHDBBkgO0AJUbcBARCAFulbbhxBYRXBHteMpqUJcK4fNDdLgO1IcqlcArdi?=
 =?us-ascii?Q?JJbG+hSn2Kt3dm0zqA5vpqjK8SkMMYLJxt3DqCfwMtnJ+hPVgT/6Wbg07vO2?=
 =?us-ascii?Q?hOLWjYQPUmZgqW/0JAPD6Gao0BcsFvvAWGFo27u4LwvDInDWqLLMGf2/jmEK?=
 =?us-ascii?Q?hIAM3duaJcsRtxt+NbmluHXI+N5BmwEP5lwONYRoExt66dGy6WxJ/foeJU9U?=
 =?us-ascii?Q?t1Y70eqpo3shau0QpbN6oqFTUryHQhzEPP52CN4g7tfi1NvBaToCkOgcOMsb?=
 =?us-ascii?Q?lfxy8KUyWgA6cSImyRxx9ndZyjvzg7Mkgt84P2/0vEbAzS7UQ/hpUYy1CW6a?=
 =?us-ascii?Q?WO/G/IM+YnJ2QWi4T515M8w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8448076-d311-466f-9db7-08db690e4bf6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:23:52.9314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NFcwZsVVfj5Bh9eA7S/Nl/7PQvXtXxRbJqKgGwGHRIhnjI6E+nkwxmTJwI9mCBiZw+ea2ziDxOAw+BSm/GWoUOilsJq+Wl1qjItrYY7JuDIUAMRkYDaJt+oIyoxbhup
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

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/pauth_helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 68942015e1..1e9159c313 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -326,6 +326,7 @@ static uint64_t pauth_computepac(CPUARMState *env, uint64_t data,
 static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
+    ARMCPU *cpu = env_archcpu(env);
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
     ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
     uint64_t pac, ext_ptr, ext, test;
@@ -351,11 +352,15 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        /*
-         * Note that our top_bit is one greater than the pseudocode's
-         * version, hence "- 2" here.
-         */
-        pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        if (cpu_isar_feature(aa64_pauth_epac, cpu)) {
+            pac = 0;
+        } else {
+            /*
+             * Note that our top_bit is one greater than the pseudocode's
+             * version, hence "- 2" here.
+             */
+            pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
+        }
     }
 
     /*
-- 
2.25.1


