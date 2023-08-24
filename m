Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33007865BF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 05:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ0nk-00061E-S1; Wed, 23 Aug 2023 23:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ0nj-000615-0H
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:14:27 -0400
Received: from mail-co1nam11olkn2081a.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::81a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ0ng-0007NK-E1
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:14:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qa9YGb4lJKDYdodBvCR5Z++jh4MBDOYYf1Z6QgJ4nVlN2r/Df5qpb5yaYBd1SZYLTBIktbIjG/Y504vmqkSLCrV/fR5TK4TTrBZ7+PA0ok+dK0w+EUseMZKLjp6frkfG1V3UAnqUKKv5r9JVwkMPhvKKysaQ73+L4/I27zDiyISy81FfDWl1ycfLkKw+pQG0Lndt15wtdMESD9JnZTbQtWA9/ncbUWGMn6tr1pt8c4z3RkoOmNXfnTvAdm5v4RxbVdFleOP01PhGmAEj2b6uuTEpe3fwFr6noZnRb9//1ib6Ul0YOERasJVwbjX9EFLfgI9+QrTXUOQUuDHviTZ9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKW5vJrIKJICKzeFkib9La9wcdpjcGCQmjbXWaxS9hQ=;
 b=ki9nqRWDeIH6pz60EM9haLvMCrV8xCgIjKpI8YhjJmUr6CzP1cW0mxutrnZPTs90LRwSEFZ687av25xeZONfbI8rjQd83D8wVz2mHkNS/hsumFpf9mWvNlrMCqRgeNYn/jNbB4lJTZESKVGnPbDjoOcBHB7D7XP2wJecxDgdqv2zVK9pKXfUbi5KenU/WD4vJnYSM9eU5b3OeEbvFnN6FQ6IHb2db+5FkXLmJzI9E5qJnSJ1L1LHbbupUKvmbvJoWdbVJ/IlewOmf50f0OaQibkd4QxY57Iv4be827Kx14LeiZ7Keeuoh1/7e2KwFSMQZLpUzm/zqYuUSDGTdxt/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKW5vJrIKJICKzeFkib9La9wcdpjcGCQmjbXWaxS9hQ=;
 b=hjgQNDv5CEG1hcpAF3aw3c40jbfxDeFnUH1khiLlWctQid85E/FUuzn53+J6AHlsOCC1DOsvmx9BeHnPGCgnU4ntpee8hiJja7H7oF199Jja+BRYOWHzTC2220ocxoIl33KHbG//s6JTIGQvejTdb4Xe+pK+5rxT+C/hjWZ/Q5UGhMSNfNreaAI7W7xvUpYNLOzRrP6otv3rv3RBqiTcmLio5483i9eUpu5U2LsNi0GeodA3Avwh/tk5By1izk9e6gwURsQKnBWe0mGJ03h1A6/5i9bOkobjpttg96NzvIXxkvNQQWobC/Qu82WyT6NkwxJ5+pyjYl/QvwdHwA0Ttw==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 03:14:20 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.020; Thu, 24 Aug 2023
 03:14:20 +0000
From: alloc.young@outlook.com
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org,
	"alloc.young" <alloc.young@outlook.com>
Subject: [PATCH] softmmu: Fix dirtylimit memory leak
Date: Thu, 24 Aug 2023 11:07:55 +0800
Message-ID: <SA1PR11MB6760CE6DC0456A65CE88D0E4F51DA@SA1PR11MB6760.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DWpl2Dj7XAimrogk1S8W84oDtsc4OefBZixyGo+5Wg0=]
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To SA1PR11MB6760.namprd11.prod.outlook.com
 (2603:10b6:806:25f::14)
X-Microsoft-Original-Message-ID: <20230824030753.1078407-1-alloc.young@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6760:EE_|SA1PR11MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f877ae-8291-4201-ce0f-08dba4503528
X-MS-Exchange-SLBlob-MailProps: gMiuAN0LASIN8sI4YrjNChLI8VXzufppMkIXkAVONCCif9lEqh0mZX+LMHfR35zksKM/cQzIvq4cIW09srZDDOMKShnhbKcwE7bnLJESDNBM9fArBrxxaQbRImoVZuip8TWMCKNMXs+5VTE5W9QtfyIRQBPvQ+b7MXjdZze1mXH5nsWj8X0NxZPA0ZhISbu5cOoCB2BGF16P+LxEvuQTbPxs2lxdvvurZwIfIClMZXXXqUW0jUn5WrLPt0pvX/7OhNy+XBoZf3KdnjxY1JIZU5NhJ8qYdi5YJ+8pPepADBsoB6bFLQwx7jF0dk5Wt1Cu5h5+Y9eTP5ohUotS8oTkoFaWw+qpBnT79Mzr9gVpbI3Z6tIO95UstslL+KAPHVu/OdL//nKd3+quThvsQ9In2OhJ/wCIdlpI84wO/2S4KpFTRgG+VG0XrqM5b9LQ7s/VtAlPQjLVEpaoPa094P10IjFmYQcUEfW/UXKLQ5cbtk2pkZkkTKwkhyXebFnhvnKEQ6yIWoUVhUxQnKHuByzAaA9cQITDEZab1ZeFbK6OQ1XhOVEh+UpODqKEQTwHVIqdYU/sgOv43qlw3dz4xiFjqmR+soo2qdp3eAbibGNWHdUWjczIsDnTOMt/4ry2INVGS38XvucR6IWHN11sqNZNMGA1d4gP/v3VjLxgAbW864NZQnBU+8PPj7+dIJHrKL9cdq6FpR+6PwIigHTUPd8O1g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tpidbuwtbgEpF7dhfbVJPzQ1x945LQYUW8jv2p9mCmIQrtoRFNThFRVqxrKJ9Y/F7/gXuUI3STMk636VTOGnnBpLkAPgoW57TYkGhcKpYYFlLnV5hDDRV6rduhTSde3ZTBbFKstTk3q4NN9S+xXTxSg81zu2Ko5fbMR/ouhAOPLrk2OOw0k1V4h2+vU16b2L0iPNc6jJ3qwEVp1ELPhIZP23TIrqs+pkxGp8ndTGVI2NfgAcAQlwA1+Mejj+lgqy95LvYVTeYcJ0ze4xuY14e2h69tGSVZHnBnzWHDgT2BHfpv5PxTik3DewOmK9cr/6vp2kM1EuNKe8aWd+TeU60+wyjTUnff1NZm0PWvxUpO7CPMWZ4Dj8xKOjMq5EqZb4xqVTuXJFywhi8uJgVdRVavE0+xRnx46qP5jhrwEg/czOUYsMUmxGGkk3yQ2M3mWAGgwtLyN55ZN7TSUI8BphVxYglOm8M3MexSOWmGxUiCM3OTfZTC/5rGd0v5hAfYW0/+IB08g+dGE6BpTMM4M6zyOjIthMOwFEUQFcaDqkNy2q75pkB6JCwD2JF08F0PEYQPgWtbBAXDgVSvzSH+ZsHot2ps4TPljfq2NW08xXorAIixn3NP5XtkXxptpaHC9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buKsVLjvmmfJRt6L/HXrb6KXViWZns7LawWLaeSk1CdqVUEWhl5dEyC1o1gY?=
 =?us-ascii?Q?7S6LeK9Ki7T8ekBAjLXDM7TT/G6VrtDYcccSeSB2MapeVTt/uxtfGrjLswHS?=
 =?us-ascii?Q?arZ7kqgxGJx7jZko8ymubnVZpcrbYdM1LBgAmlP2fDN9qRjVTk3CmZ0uHqk4?=
 =?us-ascii?Q?3KvKas4jjQf5mDAsuvFnH/fOhf+Q+0Wqtsl7lIGy48LQnoFB/1nNXBpLgHVA?=
 =?us-ascii?Q?3kvGr95x8Es6pHDvb56BqZaTVgsWPqc/xvrQO7vhSvdvy5EdCLTZLK/vKqvu?=
 =?us-ascii?Q?nCEV3f/6NEp61svPdWC+KamFWueoqYhlZMij+LoFGvwCwuuTy/ym7HSOnFIK?=
 =?us-ascii?Q?LfQsKsKYSy+r8LMM/1M0+9A7Ur6tpycfSEuJe0BJ3c8v4HgjJ62TKW7FXU8c?=
 =?us-ascii?Q?wp3i9TYR3b72GiDVNLDXgqTjbT2VwsZNk4OHkAdLvYq/WIGoz4/UoKGtOgJX?=
 =?us-ascii?Q?uAwaagJyAv4b3NQ6wI9Ph6iUpAZo/Pi5mEYMtcPpYlM1SOUc2P38Ctjhgs7T?=
 =?us-ascii?Q?bNwxBFvI1YNriH+ksJKQfqmu+W5TW3brTQEA/LSbq5op5OvkeQ0BfemuVPU0?=
 =?us-ascii?Q?rn0spLjCf3Y1YxkaRvWfMx1pX9YsBPYvRD0x1HI+0wONsHspHykbbx+XTbLC?=
 =?us-ascii?Q?mQMvMUZscxP6T+ad0Ev7UXZgbFrdVyESk3mg1p8SRjGzYvHf9Q5rORet7Iot?=
 =?us-ascii?Q?SFMefMrxZKqlC3c5QWu+QJ2CUZL7kDoUKQl4WAhFNsicGw9o1kZ9+xDTjhUA?=
 =?us-ascii?Q?D9oRTwSWwQrDWipmnRSE5iJ9yc0TbtQ73AdcpX8mI+3PWBpkPkItcvz5pB/y?=
 =?us-ascii?Q?0DHqBbB+ehtmPC6MTMV0315Dnm21Pj87ImkyC12FsgouLDWc1jyIzw8ce7ge?=
 =?us-ascii?Q?TXVYecHtQH9Tp/SwVAgTbJKXWZF3tT04DpO2M7Fdo2JhVsmgHMT0qHvhe+/2?=
 =?us-ascii?Q?/nKKshjmi7NcFhPT/AilgTH/Nr/C8RoX7YD0PCRcCiRaSkSrvSStsC6BBT+H?=
 =?us-ascii?Q?lqZTd8UzFLBi9kq0gvRWI+fkivJ4hYrehZqhZmJn5v9aauEtFbLAga3+QRJ0?=
 =?us-ascii?Q?+4kLjfYc6FOIrSfA7Ofk1FZLJF8jjvhMyhU4m5uPTL8VKTpkqW67NrbCJoXe?=
 =?us-ascii?Q?0yxN5/6K7SHgdlrQusY7tc40Gxu/Tp3jKbdNGm7RbUqx5Iko8fxdJnQOg+gQ?=
 =?us-ascii?Q?ZCurN4nA0ms8IQAM4a1dUMdWU3CnpXwuLpKLr5aonQUbEiPlyAgVYvXyMLY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f877ae-8291-4201-ce0f-08dba4503528
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 03:14:20.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
Received-SPF: pass client-ip=2a01:111:f400:7eab::81a;
 envelope-from=alloc.young@outlook.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
Reviewed-by: Yong Huang <yong.huang@smartx.com>
---

v1->v2
drop g_free, just focus on fix memory leak issue

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


