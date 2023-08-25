Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F408787DAE
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 04:34:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZMdP-0001Dt-Mh; Thu, 24 Aug 2023 22:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMdN-0001De-DK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:33:13 -0400
Received: from mail-mw2nam12olkn20817.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::817]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZMdL-0001X6-6y
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ole/bw7N/zkgqF97WLKUwnNMH5T30iAET55f2MZNmbAdqGWRtM/DBR9D7u6STNWjB7rmb5l/6F2SDlIlNU6skhSdJ0uX1Iz/pfitP1TIVJXVO4iqrqEaRhn0DGOEbmJxPXTH+ivZbORcyletRV1EDv23wzU+R9Dz57vq9vZcWw5u9qsGcIk8Vk4ymjKeKFq5JtVJeYinua1eJXO2bOA/afPx8G4KZpBN4m02GU2goYNFlE59P3ZpmEU2jfNxERImxcxzd5K9y9acqGHXqVYW+JxN42R5CEpCrLjmPuClQoKMv2jSzi3QUNHWpxxq5hiL04EAu4bGgDcC4MtqffZlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+8SZMnIWVynuduy4NTpdNCFWUxetALixt7hCAfwXH4=;
 b=H848wte8efeASZCS1vVzImj/OJ+fUn/NabCRC5K5Z+XOWW7wEFFJzcxjFDTUdajig3ay3cyCDorskmsnieh6ai0eyA8S7usnEb0efakxxcj3xT9+aMW2zmO4mqtsrbmokCQTdi89drOihZBS4dZk7vhupfSAuTQAak9EOF5Jyky+cpptheMVNPdDhD+/t8J4ebQHwBinv9bG5Fv+CGu1sE5u0CyF4aXKsE3kfHZeZQoVt7rymwPaZikIs3nNHeigWnKGGWE7cc8UU9z6CsHiq20TqMwD5maSav0dRJuoSdCt4Px9STKhyIgHNMrQ+uwpgAxtLruXlCcRP9s5LY+UUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+8SZMnIWVynuduy4NTpdNCFWUxetALixt7hCAfwXH4=;
 b=BzzAhkta1ypht5Pr6Par/u18ez3xkGWtiT8u0gTUEHHhQWceJTjnZXe7r4VT5FFqOmQoKzbEVxERFuCoerH1wEVzGWm95P31hDkGosmbHuNYRLbB2LZT5gpxpvmuPt7jvS1xFfwE8EZy59IAWxcQb4GmCvjw/Pm7atBeD9xsMqkeghBaYpcnwmzmcmGcCCblbmPWtL85smYYI9gJGVyoC8jNQIFOgBLRjrWPhd/DlGkNZS0nbY8V5etrt0RDwuZ6lPP97Oi8RZozdH1zwYRuiLRzzK98CfBYb3C21aij8eOgpEaW9nMbukmBBLtMeRtU0TMkt/BXgSzWKHZk2+oXxA==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:32:34 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:32:34 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org,
 "alloc.young" <alloc.young@outlook.com>
Subject: [PATCH v2 1/2] softmmu: Fix dirtylimit memory leak
Date: Fri, 25 Aug 2023 10:31:20 +0800
Message-ID: <SA1PR11MB6760B9AB7EAFBDAFB524ED06F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
References: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BugqierZPbBCfGHXsIptqA2KDNEWoivvGo3e83nWrXk=]
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <2e796c56b3ec535817ded15577e9e0077c20f6aa.1692925847.git.alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: f16f2d38-a7db-4932-649a-08dba51389e9
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayGFyzKqG2j+JWu7TdfJHtreszRPvNKDxsAQXCPywoArShX/ID2wnzbypwrIbm46+wvhNanMGBRELyzisZ+hBQ2CvFhw9f1pQqD3kN6eiC5pTaClCBdoTFBDDZqtrHQ3uB3Wua9vHu9kzQkw2qoqlILfqulWdh1k/0bRjwGUwxozLPPQ+EGMVHnYD1Yzbbl8T8UMPzqtrF4I9reIqealgXEdh8wjgu7nCN5PMYRMHF2SUeqNMZdCQIbZjPCOcpLPufTmX6QcUc6g3vHrQMR4cUKIE0UEiWA+xpit0xNVcYC+MCoLdD0/Rbuz6EJcz5g6BbygeqlSEWnvwsuU3hZorG8Jc4kBe0UykLCOSCDrCVfdyjsNbMGKoxdivmKgM62CwbL27CVYLWVURh/b8WlvUEmRslLR/ycW2hQdUTHytwpGYJUqh1VBgdrnT4aBraByZVmrv5xE0/Ua2TjB4XE/AtWFRNe0uTVXhkvCp732jevhxHPg5oS7kVrh5GTLmnwRIBj6b6pZM7e77hSJh4b6K/OVHEfwBf/lLoZAOJDjPyp6FC3RrqdH9ysrLTs17NRYkNRi1ghyJfcm3A6CoFzjxk3GaqHWiU2iSefTk9mbQPT8VcnSg7kNloCphirkAQZrfIw6lb25qOQ8W6ViG3TBJUxdIysA7TIHTLV99uVCqg7tBjkEfydEXCQ0ck9uqKO+xo59JWSn3XoBTEtVFgjKLEKdYQpwm+cSxIE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlIFZ6h9n7oJW4wtVva1xQPqBUHOSE4k3WrZbUaMru49j7uixgVuwZQV0+bWHg8OYriQ3UaBXSQ6Vav8kEjAcPJdI4DcO55OMnb3/VQrohStEn3oKdG6a/wSPty+pqiRnRTVMdLeQuU9Dd54h64vz+izPc8sqXSUXk1HHndU1pdMWjrnCzLF7C3SzP1k1U9nVMBF9XQRT47TEWLS9b+3AQD1+PIdiS6lUZ2Tg1z6fc8rRQwnHR/Zp4HXbBFs3F4xUrh5s1nm5HePjjQpyaQQAfcjQg0i5keElovrJdPQPihW8Tmv32I6bGX77x0QohnrCj7GlrjVaC6Wst6G4pR40wNJGosAWgtuWEZPi5lLp/pVU7tGayNvMTfiZY8SViZekxvrbDqU+nr2hNkOLbIA/uoCU5Rztv3ona4RbyPhtZAWqjqWAIfHz6ruej8o2AsQraYIkzedFY5UUXJPPu288C5DXKfQUJjB95gYeP+8b5ZX65ro7pu/RjoIex5Yrr5hS9098iO0Gck12jFWhgIHnHijn4A/qzexGkF1ukewU9+1xLK+L6OZvTLT/rrafTOBodjVTJlT8o9qRlhmD2c201paqs6HHEEQeKGPFY0XJiuqAYX7r1S7DSMtAWGXsABT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GY0Y4hI4/PsELA7DbwCrrQhDrOsNw1HkuASGKTvuaGc26qTw5kYRMX5TDWPr?=
 =?us-ascii?Q?QxS/UXWCJZqPMiYffOS+z8wZAKGqzAPDWwvd/TDTuBPwP3SczGdxhgfAyXkx?=
 =?us-ascii?Q?V06xykJhQ5s91t7LUK8hncC77OLghVPXnEl1YXsLyVRhykTOYcW4kjB52TAp?=
 =?us-ascii?Q?6BCDEeOzthCk6ozb496PSaLvmGRa2oHK0UWrTiQt0V0jsa0Br2S+wIRIlWfC?=
 =?us-ascii?Q?1uWynCn0rpQY10vyUli7JZ6mzhK5wxl22Il/R5/3BFZcifibHw1wYkhL+08N?=
 =?us-ascii?Q?NMrvbJnZo1EjEFx4jg4HC0zmJSQAyWVBd3Qbe6wgvXvjn17wPQ0j4EBL8z7k?=
 =?us-ascii?Q?DRd7swsh53XvoP3dPLLbJA34bndbru7M2pi36gMaTNNFryEsvbxRz1YjDt5k?=
 =?us-ascii?Q?wmROLWw2T+ufZZAitKpCJZdfVfoC23rpGc5txF5TzFJxbLzLtMEygMknM96g?=
 =?us-ascii?Q?C6mQ9RBdzpqEZUfMiMbEmMmFEgW7w/f0dn2ZGHjk9YyQVy8n1cSy0BNBIjTc?=
 =?us-ascii?Q?IoIrPIaYIOPiC4xWuUZTTD1PEKe+mLM2y7zngxOyMobHybNwMWL1yiR0sc7J?=
 =?us-ascii?Q?glwbfdAaE3Ksu3+lZ/Ei9YJ8G0FEdRhy7zoq5UVoDUuwV3ueY78aDHvvAh7j?=
 =?us-ascii?Q?+exIFtiVNyUCif86RC7fKfcEjqOJ0cBQs70UzUvZVxMWtKL97v8UnFhECez5?=
 =?us-ascii?Q?FPyD/S/RBDsDMeMBDJb3SPmlm3ndec48oM9UwqaRTonP9HSDwozjBqJvCgDg?=
 =?us-ascii?Q?GJaFTOCZtd/8rdadx4dmrF3tbnRVPyIxf+7NAtuoc104HyMa9NIevNTm60me?=
 =?us-ascii?Q?WKmktgrK/LrHOgDwhK7AeBlOjZaa8+oOAltE12NTML5ENa8lZct4BTzOH4Ik?=
 =?us-ascii?Q?c6Pf4QsWHrqaOxSzUwtscRx6V30SnDEQ/4K5in0l5PeuWxkITWpo+YactCCj?=
 =?us-ascii?Q?O7K6QDQ58lFRDKs3z88nf6z2IgJaRqPrplQcjwMpBivYKyMArH256JXD70mu?=
 =?us-ascii?Q?SaDI5a0XrRVqtfB+Cr5GpokaxvD/kmO3tedDNYkz/i+3GzlQ6trzn9U9ucp3?=
 =?us-ascii?Q?h38tj21yo7FaaXp34L2SZO2iv3g/7F5gBRwE4LrOx4LiGbw3//BBAYniI3YC?=
 =?us-ascii?Q?vZVCdgLu79YNoSYJ+CRwtkZt5I8LQLEIf6FC1n8qsKBATROwDLeITp0i/a6b?=
 =?us-ascii?Q?YmN+sbovqIq+YnK9EVieFSV35S/zXOwUWzcw9foARWyHudTRIC98S72pYJs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16f2d38-a7db-4932-649a-08dba51389e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:32:34.3274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
Received-SPF: pass client-ip=2a01:111:f400:fe5a::817;
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

From: "alloc.young" <alloc.young@outlook.com>

Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
to handle memory deallocation.

Signed-off-by: alloc.young <alloc.young@outlook.com>
---
 softmmu/dirtylimit.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 3c275ee55b..e3ff53b8fc 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -653,7 +653,8 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(Error **errp)
 
 void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 {
-    DirtyLimitInfoList *limit, *head, *info = NULL;
+    DirtyLimitInfoList *info;
+    g_autoptr(DirtyLimitInfoList) head = NULL;
     Error *err = NULL;
 
     if (!dirtylimit_in_service()) {
@@ -661,20 +662,17 @@ void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    info = qmp_query_vcpu_dirty_limit(&err);
+    head = qmp_query_vcpu_dirty_limit(&err);
     if (err) {
         hmp_handle_error(mon, err);
         return;
     }
 
-    head = info;
-    for (limit = head; limit != NULL; limit = limit->next) {
+    for (info = head; info != NULL; info = info->next) {
         monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
                             " current rate %"PRIi64 " (MB/s)\n",
-                            limit->value->cpu_index,
-                            limit->value->limit_rate,
-                            limit->value->current_rate);
+                            info->value->cpu_index,
+                            info->value->limit_rate,
+                            info->value->current_rate);
     }
-
-    g_free(info);
 }
-- 
2.39.3


