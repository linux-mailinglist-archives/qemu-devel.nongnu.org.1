Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F28787DBE
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 04:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZMeS-0001nn-JN; Thu, 24 Aug 2023 22:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMeR-0001nB-1m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:34:19 -0400
Received: from mail-mw2nam12olkn20823.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::823]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMeO-0001aU-KO
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:34:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1qylwzI84ImAVZapYYRlnlMWiarNu+bPZYvyAc4Dy4pDS3enkd5vroNZZutvqyxFLCV+sYwjG7SNgyCOASTjG9ZvG8jTFMFo/2CSws96fEJtgMHMIbZYqXCbGYjl0fIHSKSgbi1Aq1heofFDRH4mhBis4NW6qENScR/zhc/z8f9zPPSgmnTwOlnzZcezXI3e2FHwGPqcCsuHC8AvuclspZvoWX0fQSkOJM92VRIK5tBNIiiO7myaD/AsZ3g7MsWARZ/A3jtuk30qfh2pDMsvcwfjPbnXJRCEJr8/AtG+xIoZbp6hQJS2V3NVVAHyQO2jam9YuAt6xlM4jSaiM6Yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSfmnLunuA9AjVDvHjybVAS8mdwyvHyBlM/JEI4Jyy8=;
 b=ZaGxe7S2gFpSefNhpoBtSx9yt1iaFSpsNkZSxLPmspmU3PEqAXj/XhnPaBYMyaFCxx0QUhfaiIkSbCcI0m3qhsueTEzbU7Tyco3RUQ4rj+UKHCLbH1PPDrsNt72lMft/m/ZO4bDWnZ9krq6NNZK/MV2j6vBI2oF2wfB6k4qS9x1/K1xw8w+nn8SH88s322gTnpMDKF+DGnuDrn8wFdKiSQ2bMugJx5H7iMj1DuGKjXoFtPT4qgTGB0DIvrdcKyA/SYfpbrmzv/ThJx4tofjK3LK2CuDY/Ybhhhi/oL8zfb+HxduLh/Tc42hx0JDQFySG96l7tmaqnET0k72Ij1XIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSfmnLunuA9AjVDvHjybVAS8mdwyvHyBlM/JEI4Jyy8=;
 b=k1C8y7KgBCC4qWsa6moSA4XFTVf/YuMSuPx/+itW//eJ4iJLshhpPY0yUcxQCJYhcINNMHR6u0Tv5h7ugWXee5iR1QE6LcvttCEIB39fD/HHaXtZQ+7ZK1eDShX0qFaLcAWA6D+TYTX31F/AMQjaeKmi9IHozrana9rB6XeS9nGGgzGRDRBrdSN1wu1eNyAWGqVHaZPZCvA1E4zvQn9ErxCpgYriK/Zm8W6J5Jz+QPp4YNuR0RETMp94yZJaD9YbaqgsYsNRDsLbTXAxwGxmvTA6nOwHTF9XNLyNcwPWH6k5Hr4Gwduf9sO9Io8BPPk+8VXo22hGHH1TINphGFl5tg==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:33:41 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:33:41 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: mjt@tls.msk.ru,
	qemu-devel@nongnu.org,
	alloc <alloc.young@outlook.com>
Subject: [PATCH v2 2/2] softmmu/dirtylimit: Convert free to g_free
Date: Fri, 25 Aug 2023 10:32:51 +0800
Message-ID: <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
References: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1GTWlVuUzMQ57fRBCYVY+Q1yPkq9Q2bIUm/D6H1dYkA=]
X-ClientProxiedBy: TY1PR01CA0189.jpnprd01.prod.outlook.com (2603:1096:403::19)
 To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <4ea87d7b8c4565f36b6d27ad83ae8e042796f1c5.1692925847.git.alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 956cabdd-d9bb-40cc-3486-08dba513b22f
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayEad0gv6pJaltsDtbd6NSVllMnjD0YIkdXJeo1MVtAQQhVoivno3uKqu2hVwGhI/835mixNDAl8ZMf2kC8FvPLFQP9yj8YPyc8aEHv+L7Dh++gHrueuIHLtLBUj3JGOAph8grVkA1oc5mi56SKv+gGA+jxoE/hAC+Yn2hqOi7UAcj0OLoieu6Ek+f+V5Xn/1U2p9zYYrvy1K/hfsgoQDxHbORQ99lMC0gdW5UG8OBOeTy3fTPvlfX31O3N8Fx6sx3LKirwbnneyQYrJQsTc7ynYyGQFh2CsIB+71UK8ITLOCOB22Fi+78+YuEgDBC6QShMsLRSm1RxVQxZBdpS3sx/GnO0Wreh+atLwGqzBw0sUv/7JrvxgDROLcvKft4yio85EoYpVzEKEQnOsB+h0gpNr65jWOp4hkv/HaxBpbovkcECBYq6qfycN9Qp1vlOkLHQ+nUaqnVbvqQ1uLsfPfO+1YdNhj+6FS1U+qphK6QypjmgniK7dBC9lC7UwMtRMrgsoz/MueqmxLkqnXXvtPtRm8/ZD79aEqOmDfPFTxaraP/r9ZfHWYCERMBOm1iXQzXnQ7PgDzjrrwpWjA6GHnILcmixi12S0HX8PYWlVuBFZlgoDFM1ChsVgtm+H53J4qeOfPXKjM4LxM6B7OW+ykrRS+LiKLrAcvol7oPJP+N8VQh2mIsPnLH9Syw19W8x9HZDD5xmoD5ncOWx9Ejk0dbGRxJdQwBpfwwQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43TxdznQZ1FEcFye20HHtS0Ljx/mCypGfqEnHNaDSbudXir0icNMF5HjS8ZLWLyaKDpIA5LNPxBw3k80ZGxDTt+SgVROTsw9hFyniyn4i5AY2YopJp7hWmhH49v4qmjuOK5pFcNk4dCNYs5JArrbC4v5iDqvGgAAXHOmCsAr1odYSivAq3qkUubLqvBTMlfDLmT6k/pftxeokP4SxqvRviFO8/zXcedpxi087BLJ/KoReD4GooSIciJnkch1bBqJ+rZFjgt/qFW+XTqNowvmB9tVSje16zL+GogLuJ7hQpWvAWfl7YZPwdDh1Kej6gch4dmeReZ2htaikIK1oy0jAWAu5o17eR9fXgGjSsut39TyY2txFL3f7D0t0lKY8/6GH/CaStg6hq6OBs6Yort919nZj/C8eXsKYMQMN/ZIcGO06yXrmkbaxBGUwjRPfpvjNKWxjOm/I2AzfTLUb1Aib+7JbFb2YDZOCogOchVyM3Gp3b2R7okDWunM3LEM1SWqXag37nphgcTQJwvPQ1S8nyD0Z3A8CuXwwRSRV9rnnnVLMu5bEBzOyv57VW6zuXEwi5qFfuOO0abk1Oc0ENqCa3HkKl4sV4rAcHytFsKQQHlRu1P2YfTXvZS5ZxmvABYW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWFQForDixOKHNCwMJVmp9dHhcq5GRQhBwN4Mip3lePWW9mmZcIiP9+meFC0?=
 =?us-ascii?Q?ZOvq/R04AhlGL6IB7kX9M/BkxTnoHval9h/xDqvGOY2VI2IC1uLXP5Kl7+vk?=
 =?us-ascii?Q?kHMDS6Z9pU7Ybs/ka0qJKZdVlQIsQvYk2Ey50QyoR+sJtSCyDgvLyBpbKx9I?=
 =?us-ascii?Q?XV8udpMvTxjVtCjro38F+FfYvpX9axK2p4QgtUfRjAa7/+ZUieFNVDdovAE/?=
 =?us-ascii?Q?3MNb4RlvQuOvwhj8S3wO9btGpTsodDXi95VL3knMP5bZQeaO/xLEBsZnyqfy?=
 =?us-ascii?Q?56hJLRNZYiEMMZfMtLnTHmMEPrLgT8krjlbxlHmb+mKyzKUqm8m2ArzYMC21?=
 =?us-ascii?Q?iTqiLhp1g5sDam/lY3saxjbH6orCXeoZeWv+UZ9GuDIXCjZtjIsqi9as4f99?=
 =?us-ascii?Q?DgOSO0OjPP7c1/wTbmy/I+MIi5BGkdxasoNkMF+8QS1jmjjSvD187lUOhUdO?=
 =?us-ascii?Q?QDs/hKmR8ivNmWK/9x8683F9FJ36chJO6W/yx9SzMJeTOlrchEijyzwZ87DF?=
 =?us-ascii?Q?Eet8DbyHRhA1OHrol+r6obbWKp5bxhy90xkgLn8Y5xfB4D5yxzqTq++U186s?=
 =?us-ascii?Q?VgyXedEsdieSgFz9Lf9hHOxVm1KrVrYPqtKMPYREa512V2wT6hFcJ76T2Kyp?=
 =?us-ascii?Q?nsK5NhNDqM6lXLIYapyhMfTQ0pUvP3pgzOQCNZpCc4Z1gcNbWIfsH9CiMnCO?=
 =?us-ascii?Q?e95krw0zZwCgYOVCFvGIl2kSE3XWEMpk+kGshhl8R59L37XBpuXCt9A1wNVZ?=
 =?us-ascii?Q?uWgf6b3tq+VKs5hMcIK1/zu9tuIKE+V5k/G4DerfogexY8BTRSDiZkyH5XWw?=
 =?us-ascii?Q?g3j7hEX5QaNZSehKDC2+PHtfc8u099fifNRYnVWogePUpmwK+H52g1TOr5xG?=
 =?us-ascii?Q?Nz8Nr990VvodqyeJ3NJIh602xPBL1O/YmL/YaIldKw2bRdhtY0XUTVfYKrLQ?=
 =?us-ascii?Q?j/nHnWDpBuS8U1HF7gcVVXr+tK+guUZqAimVIPRLLQDYEVzh9uQGNeYcw3Rs?=
 =?us-ascii?Q?5xgHuVcfoBzIyUGBBwQumXy10JvAARoho1TwEH3Fhl8aj81kR1Q+CABAuDGf?=
 =?us-ascii?Q?+wNobAFhF2s7IkbPuPiQoH+0uegW/gsavPZnLj4u41gn1Y+Gh96cBVeuVWEd?=
 =?us-ascii?Q?aLE/SpdWoFwT9Moqs1PzUlvjaEwvfzbFlkmcbbOQ/Z/ZNImM1RsoSa4DTaLN?=
 =?us-ascii?Q?1uwTpfmDfM9jAqzHQX+4JDpS8JRCwMsCcIGiNoOjSn2YqSNKOQN/fN2La5w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956cabdd-d9bb-40cc-3486-08dba513b22f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:33:41.8316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
Received-SPF: pass client-ip=2a01:111:f400:fe5a::823;
 envelope-from=alloc.young@outlook.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: alloc <alloc.young@outlook.com>

Convert free to g_free to match g_new and g_malloc functions.

Signed-off-by: alloc <alloc.young@outlook.com>
---
 softmmu/dirtylimit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index e3ff53b8fc..fa959d7743 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)
             stat.rates[i].dirty_rate;
     }
 
-    free(stat.rates);
+    g_free(stat.rates);
 }
 
 static void *vcpu_dirty_rate_stat_thread(void *opaque)
@@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)
 
 void vcpu_dirty_rate_stat_finalize(void)
 {
-    free(vcpu_dirty_rate_stat->stat.rates);
+    g_free(vcpu_dirty_rate_stat->stat.rates);
     vcpu_dirty_rate_stat->stat.rates = NULL;
 
-    free(vcpu_dirty_rate_stat);
+    g_free(vcpu_dirty_rate_stat);
     vcpu_dirty_rate_stat = NULL;
 }
 
@@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)
 
 void dirtylimit_state_finalize(void)
 {
-    free(dirtylimit_state->states);
+    g_free(dirtylimit_state->states);
     dirtylimit_state->states = NULL;
 
-    free(dirtylimit_state);
+    g_free(dirtylimit_state);
     dirtylimit_state = NULL;
 
     trace_dirtylimit_state_finalize();
-- 
2.39.3


