Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02F7B61CB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZK8-0006sT-3Y; Tue, 03 Oct 2023 02:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK6-0006s3-Iz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:56:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK4-0006n2-Lg
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:56:02 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3936IKpr030186; Mon, 2 Oct 2023 23:55:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Vea0tOHYdyh0Rsy4W3bng8+52Z6tbIO729vJZ04lJ
 +c=; b=R3VoACsfIHy63r8u+i697i4XtQvlT+yI1zFSSyEo5U8U0cLXeFFcPoz5n
 ATgfQ40Z9uiSf3xJwOna7EeKWWHyF8YvrnRnU6JIh7Z/hOGh+qCj6nUKdwvRMQmX
 356HAG5Eq06NFDhAcrGJTsaREAVsunt7df1JNqa/HxFgl7x6fW/4eQx/rROWOa7f
 u+UPO7dQLM/Iw7havnRw9pxyXI0RLvpTsW38mZkYP2r6lcN4tEvD4s+b7txcl+Wn
 5TpqndIXOSa1h0O7wypEiugyPBaPv4SJt7as18EZuJKSrsVN5MP4pZ57Iw4MyVOH
 /zQQtaCiFydjmsUzB19BMtzMXiQjw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rm7fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Oct 2023 23:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbYnM7/YOPXk51M955GctjDFTJAuhetdRCE8AZKWKe632hVZzdncQOdcphE42Knt7vcfU69cY1drbEctiP+0ZBwmDRR05Z88UqcU9cdB88Zetwi+OpDVhWTPajb7XM0EUEooNH/brcFlWeao686nJY+BQFJaJfjJpeefxPIjdxpv96ZTgEM+gQeWvzZeFVOWOqbkJtxGycFZ7nsHE3UBYBkQRzAWKz6qr0AyaiMFC3uZpirndvIgY3eOBaj8Rcl37hI6gvSgncWD6bsv+g9lqOtoJKzuVe5CP72ZnSED+jUsgpe3iLszthJbVF5EgMOJ7Alzpy5NdiUAaDQqOTIQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vea0tOHYdyh0Rsy4W3bng8+52Z6tbIO729vJZ04lJ+c=;
 b=R6/wg4lA4V6xyM2tKQv3PKOin8YWvHxp1XYqWAeaRI+uBjNtAS9wioh+2TgxZ7QyYJgw90phb5sRkx1w1qAD70FfJP856xC6bAa0yuVLNKNdMZOkAxdJAjn+b3kvmXtiuJQcc8hLBBrHWpiTNKYUibl9IEJ/2MQF/DRLfGkV8gC9Qp9VT0mpUZhVyOsbmUdjFxk6I1J6Y4WHZeOGexedOCudhiRAY00yLjbQphQMZzs4Mk6RNsrI+NfXjbS4OQxtPzo82Gkym9Ynhv65iN6aLjZSaDODcDsscgyS9rilo8BbVeUHMziAa0g8nJfvuKGNxRlR4LYPIkEImYYtcLaXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vea0tOHYdyh0Rsy4W3bng8+52Z6tbIO729vJZ04lJ+c=;
 b=hKMFkHJv9t7Jw91t2Un6CSmBZW5BmUizKD/ox6Dl1FUTV1Z4rpqNGoQJxkXpuqx6IlUHXaX396kjaSdrLynyBnFsC1YW23LkIdeSDEVdXkdihXdFeQNOi6Hnu5tpYoXVfZX/vqXsrG3Ov3rm8+swSQSgcekuxJUaE+lwU11WKqw7PF7+p2pQOCwFk228RdwQdrlCIGVQUXbob8xFGCNStGdJ7MoPtEfhc4fLVzwxz/1q5wsCy2yKw26+TZzl2p88CEJzP45m5vEx5lTrzBtfSIt27a3VOcLh0axlk5+3JyzmtNiOzRb6lCB1TyRLvIq1gstRY4gOrukW1jxMsjNUbg==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9746.namprd02.prod.outlook.com (2603:10b6:610:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 06:55:56 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77%4]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 06:55:56 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 2/2] migration: Update error description outside migration.c
Date: Tue,  3 Oct 2023 06:55:38 +0000
Message-Id: <20231003065538.244752-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231003065538.244752-1-tejus.gk@nutanix.com>
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::31) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH3PR02MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4510fc-36cd-45e4-c533-08dbc3ddcb08
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAE7IKws/pB93xcT7h3jHfjjdRGjYUav9bLEuCAVCJ/gSx/kRV4QEvbdHOZ3a6+Mw3vkEhAtukf6vJX1WUuJMqB/iFkwmq/JsYYPI92hXG0CpW4v1jIblwetIqhg9SdHTkxKf09sdNfuWXh0T65ecNdyzqRZDrry2uq8BF0wjPhvW0iC3/jLGOz1G3SE3Mubr8l+mycVfMXb7M9h+W067M85GKCy85S9U19ZvGmHpvcaU2NzyaWJaBJRGBPlHDmjP6DmGcmpFhWMj79ktNkD1f0Z0+caL1gMNNuZh7wy+YVhUp6UVNt2YM5lxdV7xK1wki2OAKFRSj3wpjT1NRiyCz3YSpLgMZsh+DEQDKrJD/cZMgzlRrySgOp/b0PDJoa3BRDhSSg2XZn0AHNtTl6rTdy4IzSsSrkbYorH5BRX1d4O5Om8pbbleZccRYrz8CkFzfTJXpH/sTDrXmIT+KbOaKuo7l/7XEPQ3oBnLKeVqt1aJdWsr7tx0mVqYtTQIaLDyqAFizm4L35bYTv2efNAoGfu1DkkOx3D6PdVq/h2Mdhry+/AS/fEjYhg19XnvrvYC33ws/TDYI0EsILivfyrrrgF685yGAwgIJ8hhrtg+TRGLGjtLsnMqvWP01JxQEZO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(15650500001)(316002)(66476007)(52116002)(41300700001)(66556008)(6506007)(66946007)(2906002)(8936002)(4326008)(5660300002)(8676002)(6486002)(107886003)(478600001)(6666004)(83380400001)(86362001)(26005)(36756003)(2616005)(1076003)(38350700002)(6512007)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymockN7k7U8mp0GH5k9fTImMP6Nscb7SiEDGG72Sq/cYBJmvMW8Sqdw0pFZq?=
 =?us-ascii?Q?qI+ghNBa9xlILsT5s3yyS53dCv2UugAGujXs4j2GuGeOzFo48zNF3EMfFj57?=
 =?us-ascii?Q?LtaDIaFvZgqWGvE83Y0H1sAur8WK+LhedaoUKU7qUbMTmH+1giHIST+lvzZz?=
 =?us-ascii?Q?pY1W+nt+bXrrOAhH8cMffqxF7PvB99T7oGYDJIcvCCCTe/Vyt71RNiwNx2qO?=
 =?us-ascii?Q?IXeMIT5e07Faf0MEI8YmfVTGrygYLVwhN1C5eTDqost1aa5eD/IwlL/ZoQLh?=
 =?us-ascii?Q?eTp/P9Rl/WRWsXSWfVPs60zG/puHq3O6hj91UPQVJdQqUSOKrHIdl6v6DEqY?=
 =?us-ascii?Q?dn3zKAskG8IsjAENtXxNf6MNWRZM40TX2tcPgI+iCaaRO5I3l5ZPvWhhC0On?=
 =?us-ascii?Q?i8oYmS9QzDKpd0Is/ZD0R3G2L5ZjRt8OuRXgGcx3/sEWfmE/f32ji9lNRI0c?=
 =?us-ascii?Q?AEFV76pRWxLybiaqHDpzUafQt4XZ2BgcCaguThC0BAs4NFCd2rGdV0f8qZzh?=
 =?us-ascii?Q?MtxoDN64NJuCvbA0phdzSwx9Xez9m0TG/htmHxzV0u7RkbMsXjKuv+2SIPrI?=
 =?us-ascii?Q?kguFwWdEDyJz31SchcXE1sJzrXcrLCLBQeETSLyAplHchnxZGW/o9fkiPExV?=
 =?us-ascii?Q?Lx1gcrYClYyCLhEsn0Cpm1HOvgxo1CN9VrYdsJhuiurM3DeWGUbzVzds2178?=
 =?us-ascii?Q?SIqPyDvhIRnQS9WuuZtZh+d4kYiHjIKerREa2vOxB1Knr8Lx38+TWH3Y0h27?=
 =?us-ascii?Q?S83EIkVP1B+NBu/pPK8DaOGkwNayAtr9VIGKNQGYTTFeZGGEvDX2P8HkVp7f?=
 =?us-ascii?Q?7KPcbfKioKcckgjxFn3oj1jVvFlChQnR9XzbZxq33FT0IdfU6HMZ30z/UQbe?=
 =?us-ascii?Q?AZQfoAdXltkexzi6aiZxx+vLEJ1UggnH9lzUdj5OtNl5lFZjkRA7HBVFS7sq?=
 =?us-ascii?Q?iu4IeQmUrXPQT/lw9RAC9+Mnti/1ds+G91Xq7N4AJkoqOOPu9SJSHr8LlKOE?=
 =?us-ascii?Q?NXXXzbbnf1Iq85N5MtgB/yGJ8nOBZTEuK236jtEuIvvjqfuyuO27Xocv9qRQ?=
 =?us-ascii?Q?z0PKqJ5kQ0CBEBbrfka0VSW86P1SXUlwNw2yJXhafIkxDUD2BWEwQGcN4JxA?=
 =?us-ascii?Q?VtVN0SwYvkp/JtbDaHBn1jP2CtwadFVrQQuE6ujjXDd8ihZ4Qj0jZTCSz/i8?=
 =?us-ascii?Q?HCK9rbzA9t1Pna73HW5ySvK1NxeGuKilgfGaGWPlfsBGF3V5cF8aqG8ri+Ym?=
 =?us-ascii?Q?mN2RmixI5zOlLMAUNgySvA0gcATOtUHvin2aKo4QdrMxd5YJiRWnEq9WvMPr?=
 =?us-ascii?Q?rPRn5b+wfgOwJol/7qfAesWQi3zxOrZMnSmY+X/UYJeEMK8cNYCBfrAdxevD?=
 =?us-ascii?Q?D6jGzCVtdkwLynpB4xLtgZyrLbP20BQRBaRJZUqcZLiD2B5TYNFSRLr+RtTs?=
 =?us-ascii?Q?rrgi+MYjY3PgahnkXKkrBxpMOGQ1wpYIWTZNTTKZuVj1tUulitpFZhsXDPJT?=
 =?us-ascii?Q?X2lKB9yBeJv+CySXkOvZ6aJk5/YMuf4K9eU6vIz4aIqgIU/OUrx3JzxImptP?=
 =?us-ascii?Q?iAko5M+8Elovew0HDYEn9Q+EVsE41ua3L1brv6lGROEZN7ptUJ1x/TTXreQh?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4510fc-36cd-45e4-c533-08dbc3ddcb08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:55:56.5715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+bvQxs+KyE8MwuI6bxa9bZ4U1TSRUxNl/q3NlQSx+vsPIXmUupY50wHOgA0jbK2WbhbdtjmKSPd+J1T5EpdAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9746
X-Proofpoint-ORIG-GUID: pOQgILALmqgTEQ9GJjb9GV-QPahKbtco
X-Proofpoint-GUID: pOQgILALmqgTEQ9GJjb9GV-QPahKbtco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A few code paths exist in the source code,where a migration is
marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
outside	of migration.c

In such	cases, an error_report() call is made, however the current
MigrationState is never	updated	with the error description, and	hence
clients	like libvirt never know	the actual reason for the failure.

This patch covers such cases outside of	migration.c and	updates	the
error description at the appropriate places.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/savevm.c  | 17 ++++++++++++++---
 migration/vmstate.c |  7 ++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1f65294bf4..60eec7c31f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -979,6 +979,8 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
 {
     int ret;
+    Error *local_err = NULL;
+    MigrationState *s = migrate_get_current();
 
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
@@ -1002,6 +1004,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     } else {
         ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
         if (ret) {
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -1068,10 +1072,14 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 {
     uint32_t tmp;
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
 
     if (len > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("%s: Unreasonably large packaged state: %zu",
+        error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
                      __func__, len);
+        migrate_set_error(ms, local_err);
+        error_report_err(local_err);
         return -1;
     }
 
@@ -1499,8 +1507,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            error_report("%s: bdrv_inactivate_all() failed (%d)",
-                         __func__, ret);
+            Error *local_err = NULL;
+            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
+                       __func__, ret);
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index dd9c76dbeb..4cde30bf2d 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -14,6 +14,7 @@
 #include "migration.h"
 #include "migration/vmstate.h"
 #include "savevm.h"
+#include "qapi/error.h"
 #include "qapi/qmp/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
@@ -336,7 +337,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
-            error_report("pre-save failed: %s", vmsd->name);
+            error_setg(errp, "pre-save failed: %s", vmsd->name);
             return ret;
         }
     }
@@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                      vmdesc_loop);
                 }
                 if (ret) {
-                    error_report("Save of field %s/%s failed",
-                                 vmsd->name, field->name);
+                    error_setg(errp, "Save of field %s/%s failed",
+                                vmsd->name, field->name);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-- 
2.22.3


