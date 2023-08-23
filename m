Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604A78520D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYig3-00056V-8s; Wed, 23 Aug 2023 03:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qYig1-00056G-5X
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:53:17 -0400
Received: from mail-mw2nam12olkn2101.outbound.protection.outlook.com
 ([40.92.23.101] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qYifz-0003M4-Fe
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:53:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h41yL08CCeflWldJioptZiWXWJl88dKNSMTQ/kHRojVnCfy5GquVJSYFPy3tnYHdqqoLdqbeozAmbHF3C42vjIQm2fLyszNacCYa69HbNYyct8ki6esrvLHyjWVj64hnJV8tC1sJneFaI/RT5DKrUu0PGwZe8awsbWJ0N8W6Tz3/K4hhYlbgCE02xmiBf8/LrqDp7qMOT4dnaevE7SVm6WvkFyVG1hx1uocF4ctl5Viy04bwXU8aN7myXmgHEMktP/v3UpkWWCnes+oiaMqWYKKcjbWU5V640/iuSG+pNm6jslIG9Yw9eM7XQXDUQfCWsW7roDv2V7Bb+bVLRj32JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0Q7J/M7ey85pPTYjez15dkk3S+TTUYLLiL3nbWoetU=;
 b=b9mJbfnmr/c9PUtGZSJCJ9AoyO2UZb6tpUxjWDmkHi4N1ta1rsQhxrfPaBSabCAbu3iEX9FnZx7ci3/dRBXgIEitj28NkLyu+ia8Y1sQuLWry7+AuEyf4WgBqBH1sOLWhqcvg8ahPBw8QiOgd/SJCzX4TkIBuWg53HShGwHAnQ6dQAMYR1TEBHOVc4xU0nm/gA2nfrQnb1a4DLHRGGclpPHfad159oqp9pWUEc/JPykWnFq2DYiFgR6j2EDDvlF0hLvW4+pDa9fsjVBo/3GWqMwdCjODjsnmyY9nwMArLiQ6FMQgi99z0kkGaFxtQu1BtfG/eB23LYK6WdKhbpZdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0Q7J/M7ey85pPTYjez15dkk3S+TTUYLLiL3nbWoetU=;
 b=vSGAv1Mb8yFzjghnZRt8FP75t9vY1jHUsmWcOJDfuRnjrmjgpBMWBQVDIcAddTqWesmp0kKEoAXv6cPs2KHfGDuiRELvF72Ho9w7NVcuFzzFCDoSC/AFW8s3A+OdFb3PM2llhn7CZ0yHSG8HBygcE3dY+oDUECL8dJkxmA7YED1jH/rLKloED1CPnq50boa2D/jpmnyZ2+M7psq+326w5EpK/v4vit/T/FbiQfrqJiERlYUOzUkmTM8pVYqAS+faFpq0Ve5s9ZAA5C0WKbyuSt/cqKKXNnuR+q9DG2yi2ukWbZHSFWVcAqUkOGv78/ON3/UxpPkvOg/dpcHRj5U67g==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:48:11 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 07:48:11 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,
	"alloc.young" <alloc.young@outlook.com>
Subject: [PATCH] softmmu: Fix dirtylimit memory leak
Date: Wed, 23 Aug 2023 15:47:49 +0800
Message-ID: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [epE9m1drZsaGMCkYg+V+DKdW/uAK/bCUvSTsR0tQ2Mc=]
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <20230823074749.1077266-1-alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|DM6PR11MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4268d9c9-8ecf-4986-181b-08dba3ad4c56
X-MS-Exchange-SLBlob-MailProps: CLk2x5OX5VYpZfGexXE2DFe1mddf6nrYlu1/Cim2Hz1RgJKtX2OZYGJvSbC1kXN5M5KV51RXBeFtZWxR//vfU1ERFNXm+TkWkWxOLNnfzYDfRPEdJhe2Rb6oOt5c+2fhx5YWUfq3lpGGO7Ase+kWubNQgTXsoO0F+NPSUzSdDlxb2nPdjlGS1kVqZERhjWwL5ZOrynvk5/rKs6ig/9rAWWf/gumWjBsp5vOvf6VunB8acnjzeNe/wfgfOqd3SpSjToGmR4waps/XQIqHYvblK+13wY4YSvfi8MBHM196wKdOSldlVzlybThRIfjes63FKWbVfkFJREfFtdkoJBoARqV4Jyxd6IzcS6hBFc0NFeI4voN80DBnv69HqUVQY8qo5L28zy5iNuf3pcuZslQxmW/aiJJoTXbXePnqYdliqZ5Es2hDc9QDTZItLjK2UkP7DbMN+rnecXVWfmeL8R1R7eF2GhK0pt0Qio2QfKZCQTpMrpXoUAujJ2/emw4Gti3Y0njD+oJQ98hR3r+swzM0+DpbGux3xPv9FP2mfQQaUCJNY5zmkMw3tsXtg/hyYnOXTQFEAehGFXeXTt+8QJjcTaH3w0vx0giLdYh/F/WlfoOpSVHF0zsjAlAiXGQS7tXusgUNyAWfTZNA06Hay5iAUyXej54I+xKeKx+0s7NbJW2Qne0jWPaiA4WMMU8fcn2Ouk1rt3WavZJlI+1VyUJ7DQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sN5xSqwsVX/MRtqXabVe8zebHUjdecLVSfeHWBdiZvzxthjEAY+NtE0jZXbyx715VsllkLbEfaaF+dWymsU7A0MAKiKutSpAwSMy0oAGNVjPLcrzpe6sz0uLWIkhAp51Qzd7RyGTF8OKHO0ZsxyW80LtHGXMLJxBzZD+D0Gm47pmETwmiK5isBlEtmwG82OuzH4GSb/8uIPDzOiEKQX72cBJwHXUgz5W5i4NjdqdANQIJnY+eN5EdSI0Rs8yUmTMmhkafzx4g04DbJwm/se8hoBwyci0LhI9VYqOPsxSybrurkrvM9xzotTkgHa4L+vc3IGCFHR88LM8Eb2/5hMQ5z/pZcEQQCpU17U9U7V3mw+kl71PBU5VqOtTsyK0v4z8ch3yihfr6Kb+U05MXCnCurucdneTiD85ZEfbBrFTDqUWPH77vjjWDhhBdRLT5ToE+yj0hjOzIWxLhKsAX2Ko58aw/ABETg0AkXOnRKT9pJcqsMI3UaD4HIonJ/Ybr3dwgcoqEVF9Nt4tEMU7kTHX8w96YgvjJGe6o3+dnmd806WDFIC3k08W6P3+wnO0+kgfD9lif1HKql/o9gbeak/lFIsH2uRzPu+RJF9USWFdbeQnPIunenpnRvHLEWFaHqAC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h63qqjQh7FIonZCBVS2oHz5VAk4Q2yDhxFitb/jSH5UTtUkekUgxtiULkKl2?=
 =?us-ascii?Q?78M+NMBJMTyaWu8WdsylNB/Xug+ULFsyyK6SeiQhBseVDzOvyeortlodLAQr?=
 =?us-ascii?Q?FwjUTETLOjE73ASdMEwVN6nNoE65QWUBIUuKEnQO1MIrIddA9I907dJACQrg?=
 =?us-ascii?Q?htJOw1xQFUAx1uZyRRfU5mDuFlaM7Zz7jVOhBHAkkQtlfE0Blul3Pc4TkdZ2?=
 =?us-ascii?Q?57vaIDvUh1XASp7A1ETrhDGRH6lac4DxtUBcgvUX25ORc2IMZ6+FjC+uhuKP?=
 =?us-ascii?Q?rGaZY2uObD/VcMtArOwLvG1eAXAlZJPrIsPFEw6UWNZtT4unQzbJUILUH8Ft?=
 =?us-ascii?Q?LMZbVdIzintO8O1jUgN9/mKunIQGow5KaPs2FUeityAtW+1t8e72y/iw/kYK?=
 =?us-ascii?Q?8h/6efLKWz1wWE9Pv6BrItwGAo08zyRu+y8Y6CPkckibxFVqJBl8Wv2g3R6n?=
 =?us-ascii?Q?x5GsWvkBewgcgE/MeKK/P25WWw+p2QOQdkCvyDHp/11AESoEHE+FuLVRb5pa?=
 =?us-ascii?Q?fgi1QTJqUUAagwi206mtoxI35hG934LQIvj0AhFHTQ79kTx2G/Qf2csCt6lW?=
 =?us-ascii?Q?TbaP5k1swpexpwwgjhcomhdeud5KCipdOH1yVHPQQtzmPUb8LGS9zhStMPeF?=
 =?us-ascii?Q?ZMgAZgEFAgDGom46zcn/xQqRIJ3+9vNFDeciR7LnKDQURRJcOT0mFEXgam4i?=
 =?us-ascii?Q?GhKTsecJ4qgTfked0AITzUkaIORD4VlbAPbEcTbTHjXUpMglXP1Pb5EUIaUk?=
 =?us-ascii?Q?o+fXqJ/K6riQoSzMBzLKjNJp3PCab4OTJWoLmx0WFCP/uDAxGe08FLssmEH8?=
 =?us-ascii?Q?zOduTlcYygJnDxDh9VgStCFBZVTCeuv4uDZhDIgXuoMVS7bKMNe6ZaC3KmDJ?=
 =?us-ascii?Q?pIrXOl7C3YqZ6VfgICVTV/hkbEjqOm+H0kBLN/94qF+VqEqPNWjlekCWWYWt?=
 =?us-ascii?Q?4hNNNd3GPHkNpIobcfGLgNMr3ZHSBdLSKucQh9Apqx1jDJRVpw+NkooR1Bwy?=
 =?us-ascii?Q?OnGbdjjXNAFwz1NAbZ55ZdN88ViYRd0O2QR0fQ4IpSBtcfwYhOeZByv9ciN7?=
 =?us-ascii?Q?n6D6T8FKwcRzsfFbj+qsoll+h+oJNqaJmfSjEx+V/CHVwT3CLE9yE6YQ0NWm?=
 =?us-ascii?Q?F9rCwAnab5UYKYjHvlzndjsuBXY79P/jERLZ3JIDa/nlIs84uSQIqt0xk5uw?=
 =?us-ascii?Q?+lEsDqb0tO0v51777YhAIMNBs0uuAfD0AG6OvxLW4T4hXrEuoX7e1s3tEb8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4268d9c9-8ecf-4986-181b-08dba3ad4c56
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:48:11.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4545
Received-SPF: pass client-ip=40.92.23.101;
 envelope-from=alloc.young@outlook.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

From: "alloc.young" <alloc.young@outlook.com>

Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
handle memory deallocation, alse use g_free to match g_malloc
&& g_new functions.

Signed-off-by: alloc.young <alloc.young@outlook.com>
---
 softmmu/dirtylimit.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 3c275ee55b..fa959d7743 100644
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


