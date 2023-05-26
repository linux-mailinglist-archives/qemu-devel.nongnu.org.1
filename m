Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDFF7125F5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Vy8-0001yi-TX; Fri, 26 May 2023 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vy2-0001yH-4v
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vxn-00081g-HW
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBlDdH017613; Fri, 26 May 2023 04:50:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=ygcEi7bQKJV1a0mY+3gjAXMoM4Tvfd0LB2BA4zP9mTw=;
 b=aJInityTCToSJ0QZy7BK1C0VudmYiAaqYX5CXHUmA3Bw2nAtLesiN93KjJuzrizEst5k
 ss7EvaP3FJNSLV3/ryf8n2fWV9dBhjS+1bKvkiKBzJ/WWSpMwizOaB5ZrKe/9OB+erMK
 AUyMkxK5GBlK9eO6JFEqmoDY0HRSqRiCfXxO+oqydmTWfGpifDDIN+X2F1A20nx48GOd
 D7VtTSwTAim9gD5htevM8sYBuHan8/8ILSbPLW5wcSXwLIY3WxANOgeG6+JFemcX80yT
 qfMvIMLFG+7B8SHGNOriS47d8Pp4Qyk8fMJtiOuxzHPsc5nBpZ8Hh/HrZ5GRxiNQOqX/ cQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qt58gauqq-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 04:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJFpF3Tr+voaMH9LwMH23Mk10Nv+ZynzS9QFs2iGW7eK/Q3H60U9/lOPuWcARZtBdOsu6aVPMf5yUYxt/4HlMsT39Q6BZf9mti2D1l/ME5opp8AUv4xDflnW7wv3dNy2EV004ZSiRvx5fShImzqDmEUeFsQDTUTGW+RZvTXbPLJscx/VvwEzEZH+OM90/qdFApItAv/m55vdK1ZxZzMPIyvZa4dilm70LyUA/4sMM6C5KPAF/4pD1rNCZryK/XBN/ryw1EAucrnxX132Nt4/As2vjrmK0dP5JB5ihvPkiLJ90u40pedwiDwwa2TlxM/nJMwtGzVNoLu6cjWgZvtMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygcEi7bQKJV1a0mY+3gjAXMoM4Tvfd0LB2BA4zP9mTw=;
 b=gX96M68EBNeCO9Iw5squ2B6xrxvZENt5h7Vsa1xC2evI42/4ae7P7ie3hP7b28F0ZppRmpX5NdaVaVxbuATuAC4Xzn+grf2Lkb764eDN/HfXPcBHeTCGMgTOINFeWrURu/p63sDhrKnkPe5RVmMmQRrH/67tPfM5olZph702Fo2tKo24T7gaLZ61Ye55NCdy5k7sr/O7zmURtye9TZ68BS7Y99lj/Pz0S+BR9wDzbHwFLgTJxz69vJ1juDi8TuxFDZ+EpRu2plvdO2dpHiKOkP8oX7qnzsqcE1y8jR1Fglbi7+vPp0p/zHHpKU13J0Pwq70mBD+vnntjZtA1llbl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygcEi7bQKJV1a0mY+3gjAXMoM4Tvfd0LB2BA4zP9mTw=;
 b=Sy8Mm9p2nz3MPfp5H+DOeLOCDML7EEefxhRy24OWhUTZ0N4BfqmI0W1/nCHUinJN2eiTPLuPZOHfM+edFvaXR62r3oOS8QAnk23TNFOyyVFVSIek3DIgdxO9C2+Zp0sQqSOK6TjUog3MREVXGWOTrvmKKB0gRUINRL8JwcVFxj2NFyiS3jmwrrvvAkdQdNQjV45P2Vyjxx8O00JJGR8yb9+REoluNv54uNgOgV1zmu3YoZiSlBUaHmp6s2CtdRWYhVvrmLEBPbu5+frxo9mSm/PcjHhlNYz910RK4k1f+SlXzGTEHP7oAkO30/YNoaxNaSwdVTxT0/AIas/n9QritQ==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CO6PR02MB8738.namprd02.prod.outlook.com (2603:10b6:303:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 11:50:26 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 11:50:26 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC 2/2] migration: Update error description outside migration.c
Date: Fri, 26 May 2023 11:50:03 +0000
Message-Id: <20230526115003.212004-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230526115003.212004-1-tejus.gk@nutanix.com>
References: <20230526115003.212004-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CO6PR02MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: a36e78c3-2480-4ef8-6a33-08db5ddf64fe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wvyw0HfP0CovEnAVJ/jCbtmz446GL8PL8QrmLFfr3f0Q2nlvGYX4hdSYfiHXzwwYa9DCrCuiW0m1x1ZdJ3a2fxojJXAWVBO+z+iWgSkGGokhye7zTLOTz2X3LhzMq91woAwvVp5cInTyRudbO8EZ1z7qyH/4FCjkfmjm3TysV60sEXC1i4geNo4XJTmNNiG0HTzMXGwSQx173Tk01N3DBqaQmpjm41zeBGmEO6Ep2+eM9Kpxu/WLDrIVAQU3ShcBAl0L+vlsiRxfuBrgPy83/9EnjCuFtEss5rwWYe0cZgF1F9byvNy+GdHwJLe8Mt+AHmyBUOHASD8/lqkTolx42cn4P8pRp1XuPq6YyYduwg3eNq3Kr8vnROOPwmJz49qMBybj+oh8bI72yRkybDS85RG0vJCCqME4aN0OUuCLliHDdr3kq++zy2fMqSiWaVIJSi2JEk4m3wWDR1FQJjfatcLUR6uwRjv/4g1vUHsOyYza6u+GtTvAEq1pEhE8Ud05irrDCLiQv7qccOp75sEbV5HMcFOYXjYHcBm70YyHf5mohuMTHz4FqL648IaWSk5+iWVYga/DU8XITeYAlRc2rSLY/ksKR22dkrJuj1IPbdLvyAo7undZhVMs9/OrcrpS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(316002)(6666004)(1076003)(26005)(6506007)(6512007)(36756003)(107886003)(66476007)(66946007)(66556008)(6916009)(4326008)(38350700002)(38100700002)(5660300002)(52116002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(86362001)(478600001)(186003)(15650500001)(2906002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PkEix3CnvADUkOGHscnk787ksbtl0YELYwMCBtpSXDkhGV9NoaEGrE+ATuMJ?=
 =?us-ascii?Q?/MnTuXzqUoxBcYXv9QJ8XR3LBseJ2/B2O2Z3V9srSM94bYVEu5BlGex+PpPG?=
 =?us-ascii?Q?Q+J06CtaH8Lx0ym/UMi/qilYjb23WWLtVmoRFscbhQv/2+2z9WoN87Rux4Z5?=
 =?us-ascii?Q?MbKutfqDL2HqJrqxgAw8fmcbAwui5Lu55/K86LLxBB3Hl/0PGTP2qWpLjKdU?=
 =?us-ascii?Q?DOT+u5lQcPp23wxlulwUl7HKcLpYumY5NwI4RYvmTsx3EM/GLQPqCQiWzaW6?=
 =?us-ascii?Q?IYzAKYvUdxsrOjqsk3BonESwkD8M6P3HOdFjQDhfjod/XJ+NlVxWztVEu0FX?=
 =?us-ascii?Q?RdpP7VB9bST/9hkGWFG8cE8VkY4jP0MmKjs/j+hg6v8YJmtpEt+P+jUVqyrO?=
 =?us-ascii?Q?sF6vdMeHr8g5h1ZcEW6iAyJzVgzOF9YIKqErBO+V6fR0b85GdEYu0VYbOhDq?=
 =?us-ascii?Q?ci00YPJ4cyMh5BtbFcH+5769I0sPeMlIO3wFKIfeYM++zxvA87qM5BRpWDpQ?=
 =?us-ascii?Q?5cE2TW7rX6qSVOHuOHm7rvKtDwmt10m+cRiH8mHF4Lw8HryT2sHxGUBXd1CR?=
 =?us-ascii?Q?93AvjYrQvGJxp2iXK79urVXoItsUx3cQqeTHabmq3bTiqnJmFGQ5W49r/C6l?=
 =?us-ascii?Q?xJs7VWPPYE6CxuRgsQxVQQsthfOWn8qJWvGSJtY6v5MOoKDU7h5wrFuKw612?=
 =?us-ascii?Q?4+hmYGxuyGnCK0kdpUcC9rDQzh3LSwvgvBDb8XikSr+7aRjt9m7LxQiO4+Fc?=
 =?us-ascii?Q?Eu265S2U0D60T8ap5i6kEOLgh4yf23pAi8Y9bfyu9iXMfVn3SLjq7HifSDA3?=
 =?us-ascii?Q?dm6D3Bp1jTgChQu0MHQs+NuNzwtI3X4GuzKXhki8XCZYKk9cWOsqDyMVj/g7?=
 =?us-ascii?Q?rc/PpmLTlD82VRL9Kz9z8fDjlFyf+YQB6OC860IKX1EkNACriwtP9cGh/69X?=
 =?us-ascii?Q?BwZET6/ghNzBsN3gclJYNe4AivYFAU2HbWJLw9UZERLvWDsBOdy8wii3KpB4?=
 =?us-ascii?Q?Gy1zrVP38HpHNlbI+JobS635JYxfm+1Ld1GRtr12rOpmdOr0CkeTtP4+WoJn?=
 =?us-ascii?Q?eoM/ngs5Xsd4y1EXPRx/vSOFND78cK2Qi3zTdKkUwkxoxGuf8rocP/30kmW3?=
 =?us-ascii?Q?k96mKdHO9So78MtiyUTylSwIX/5Lq1SoxOfqiY7YgcanrTSegBfMNZkCDwl5?=
 =?us-ascii?Q?GssM7AfECAho2wt57JazU3que02sS3mmlDVT8vSaFZm1NtrKOd8H34x1olUz?=
 =?us-ascii?Q?CseBPG8VfEtowuqjrn4mHZy7DzPnvY+V0dSfnsDgeBQWh+lcIsVmCjHd7Ow0?=
 =?us-ascii?Q?L8IFMRI1Q8LMgtCP4HkUBw2f6DIDJcStNXeuErX279ZMJHw9R2CDTf3t44kv?=
 =?us-ascii?Q?HHiDsmsDkQV0oArXGW7po42C23cSV/l87nDeJQZT+despQH9FCChdjV8dXE5?=
 =?us-ascii?Q?yXeq2o4auVpyek6W12ZZTKSbYRuVE7CKlZ39xkRJgYmAx9XKs43a53a+RoVS?=
 =?us-ascii?Q?Ybnl9SmAAecqNAl4IEeMBubjMX7DLb46ivYUsod9vz7AL+dMk7vwaeJdM9n3?=
 =?us-ascii?Q?X08G2lcvIO6nXxhT+uL475lZxBLJ8A5q945MfDYs?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36e78c3-2480-4ef8-6a33-08db5ddf64fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 11:50:25.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQJIrjmMV2tMQqrbPXfGthmyYCbnID7H3yppJcRzXuB9OFh6V38f3q7Et8Sng62VNwBGl4y8lKq1g960KvvHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8738
X-Proofpoint-GUID: Uu2BFo0x1_WXtdOwH-X3BlBXlOPhOorX
X-Proofpoint-ORIG-GUID: Uu2BFo0x1_WXtdOwH-X3BlBXlOPhOorX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A few code paths exist in the source code,where a migration is
marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
outside	of migration.c

In such	cases, an error_report() call is made, however the current
MigrationState is never	updated	with the error description, and	hence
clients	like libvirt never know	the actual reason for the failure.

This patch covers such cases outside of	migration.c and	updates	the
error description at the appropriate places.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/savevm.c  | 17 ++++++++++++++---
 migration/vmstate.c |  7 ++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ec7f66619f..783d42009c 100644
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
 
@@ -1475,8 +1483,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
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
index 35a9b67afc..71dc21c273 100644
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


