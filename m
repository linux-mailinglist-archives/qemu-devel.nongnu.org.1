Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D727383F4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBx7R-0005LB-T3; Wed, 21 Jun 2023 08:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7M-0005KR-IZ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7K-0002ZI-Nx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:24 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LBv889014880; Wed, 21 Jun 2023 05:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=kHk1kWFT1i669NA+60oVKMJacA/VAy7E9TMbeOWZI4o=;
 b=1EtxvphO3MfFCQu8NzxQ19fZIgknUF6cW31XZeA+rYPQXxfMODs2otvr8lHj6CJA6Hm9
 y5+MmyOzskobNlvpMVz6X8kWd2wEt/Y31+ffSgMbTHpILByRXHS9yCQf4ZbRnOZcWWnC
 QOxYSh0YHPA0EDcR/axWtOo09I0aCKEe070pf5DTrb8TVlOrHxj6KEH0kokFGdB6iNND
 LIDEcu0ZE6ULSncX11YLsn+N3Ce6HS1OU/wJWFfHc8VfuJSlNzKMG/nCF7I4/esuY61g
 dsO4Z7Jq7Vam7FP+vnk5KV410+KtCj4dX+hHUvvoToBL/NG1TtckmozOr+llWKYiUCqs JA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r98r5y9rf-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 05:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzxBKRdtEilZuAMOZWxz/E3fel8Mffgy24EzIHcr8Gxny2ebVy2UQ1jVWbugX0X+HOSTKMQeplcsLxzmQa7rg5np7AAOVPb9Sh/UrJkPegZf69KGX0vG78lDdF8hXEUfv+Fd44lkwX6HnlrMAUpRxFsqdXOoysH3TakeeEor0FYmCbpcl+IYpNMmtYAerXGOHNsSNI4ja1jCds2codoxx+NSrASSQQKLOvxUCKhXnBOAxlglGOAO/whPf2VMogm1/2xSHdj0gy8xYIPBcUb+XwKyU11A67fr93TJFtpZXxmL4n9ggEYvuxNyPYiqiAZT/KzPYnapDAK/3qG0aEjn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHk1kWFT1i669NA+60oVKMJacA/VAy7E9TMbeOWZI4o=;
 b=U3twOUs2CPvCG0jkLqawDqtim/kZw9+VX23u2A4Nh9XNe5u63sexbAQTr2UUVPCBIG0zpQo7raLCk7MqoPqXa13jTraC0ucDIro7C5eLIC8G1ekxfYxlWHPu2IFjhIBTWIGA2Yw2W/ewZ/ojLZuqNAURQV7fut54Z/HaeHSe+5c5xGwUgxX8tiDM/3XG4M84w4NzQkwjjrGhIQ3i+glgNiNQGd6OQ3NZnIwf5njxY6/KymF/0/VxqRormefYnvJ+IEV+s7s8jvCj+L6NW41WhO1v2wXxWV+7sCUe3We4uf+NmUNOPStdKxPCbAnFS/1+G7qvVHIYtEIq/Fxx7+3vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHk1kWFT1i669NA+60oVKMJacA/VAy7E9TMbeOWZI4o=;
 b=uy3QTKB3FamQSksl+LS7345z3G59avOTaA+ApcDgjELuoyiEfdevvZHJfdzCi3zgYPqy6diRQ3BbkHFTKPCM33rADMw9wKpQQXAvfGBrV9ehADvG9a8R1OAlYq7lYB/diuf9LHe0OJQa8wTQVWigmGZUkON5QSYm1MOz5K7yuxKq4iHGBeY+bHFPYE06xcDF23w++TzL+CZx+PzhoVAmM3JqFU7waGITlUv/aiQ/vhwQun5MViEJU9/seI4+4UsI4wabrJenD/+TyWeN/JylTUZDw0i2cjCEPPGSsP9IiAKcdIaTpIniXy98/EW7qLWUYuzL/pHo+Y/UIFMbpb9csw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by SN4PR0201MB8725.namprd02.prod.outlook.com (2603:10b6:806:1e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 12:39:19 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 12:39:19 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v2 2/2] migration: Update error description outside migration.c
Date: Wed, 21 Jun 2023 12:38:44 +0000
Message-Id: <20230621123844.177739-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230621123844.177739-1-tejus.gk@nutanix.com>
References: <20230621123844.177739-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|SN4PR0201MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e15753d-2562-4184-f570-08db7254882b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTKtLhdVeemkjG1zS5ReweBpovn4OHtZ4HE0aYjR1GqnA/Ho8phlaZ/WkK9Tvr4vSynjidFgBElipv5RdBKfiFSy5+GDJbNxWfhDB5A1Zc4zTyGw88gHeO0foJhp0sheIB7Dj7xJd18o6yI1QqSfvHaBS98L61Fi3U3W3kpzuY2h5ax81Sb58dRle5J9WNRtDrR15H6ZXHFhj7xlefRtk9qmAYo40ZvhNA4iVYR1dGCCqZXk7nosnBMAzWkMUDShlY+tDGfNkGzyaDhmoNINq85xQ8r7vXUF2LrmKD66bB4iZ3V7k+zkJkZq/uHdsMfAbjbjzXu6q1Oeto351oTx56kbOFRJUQ6ajPZOiG88XqS/nb4hT7FJ1HaGc6ER2LRvM9zPml+NuZvpupNVDwG1y2K8I7ev2+EDuROqnX7NcGOFakzevc7XMGNkv0JQDPRETWBlen8iqXeLd9/KIKXUYhJc8qcCSGzyQ48kyVY0OYWNsUf6Ap3QeO5oYs9zd3s2OPzCWhMMMXt3jHKJP1w4cvouYAZRXddO7ZJ3DTywgcAdGov9AZShmDP7cjv8PYYNgFUfbV2qYpD8R3n3LRgqpef51ZGDqDu0H6lMjQ7lJmeLUuqHnjqLUzXxvZyZvri8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(6512007)(36756003)(5660300002)(66556008)(66476007)(8676002)(41300700001)(8936002)(6916009)(38350700002)(38100700002)(86362001)(4326008)(66946007)(316002)(107886003)(6506007)(6486002)(15650500001)(1076003)(26005)(2906002)(186003)(52116002)(2616005)(478600001)(6666004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SaRHNZRAgXyV3bqENNKPYt83PHO+i9EketepVgEYL62Rvrg2r4MFIoMwthlP?=
 =?us-ascii?Q?9FKFHpnhML3GaaKtE9jlpokZVpm8Ytg1+1Ynhf7fYyUy1/ZAzDw7sxSXJLu+?=
 =?us-ascii?Q?NvrhP5n1Wxz5YNmv3sbTrQIzMsPdy+EIUME/FzfoeP9qccpfulGIqOtXAe53?=
 =?us-ascii?Q?e6xV26dXBrbqzUqodwMohZKjZ2p3KCRkGdQMF0U3LoG6D+P+kKny2cmssNi8?=
 =?us-ascii?Q?Eo1w/i28rHxk5gzHQuO9NqZ4KX2oYbc4VCU12XJ60D9ma2kGtYZqaBJH3S26?=
 =?us-ascii?Q?1uhdy9TyddlHyto1FX2Qwhy2CKhVHQXVwYshKrlvINygTQ0GRb3U4OBAdNxO?=
 =?us-ascii?Q?zmSOnjQX/E3ojcuZQaVX5UWKHT5FK2j8D1vhPdnnBtn9rNEoSgy/jeNnVQTB?=
 =?us-ascii?Q?ZcR10g5tcT5KHK1su4KuDIKQ6c0mEqVDpiE0jmXrMsr3e9pdoEL+oT+RJ+se?=
 =?us-ascii?Q?tK+QlaoTg+zERZ7/5lXJhCwF31T9HEdyFHlXxtfSNL9uyAzL54GmzzuRWm94?=
 =?us-ascii?Q?Ga1nIB25XhjVXsCe3Gyu9e0XXVruvCleJxH8ChMrMJVqrCPy2EM5Wj+Xf/Rs?=
 =?us-ascii?Q?LPEx1IVYmDdt8ojJJxn7bf+cFJ0iIYufWciHZpExoxkCVZmlBcWULuAoeLxs?=
 =?us-ascii?Q?dbCE3eLKRaiGiiJ24FYXvmJ5DmdGH188G5QJAuyqTTrl0uIVrpZ1OFlLwqKd?=
 =?us-ascii?Q?NEBXl1p57MUrOFep2fMrptErtAlurMb9hCsMmb8DtlIbFc/MMCR/Kw4PdAeh?=
 =?us-ascii?Q?0AbAvuRmYMEmg5olO67rb+ct/nOaCLfQNQm3CzEGHCuSX4dyUt3e79Cwlsjh?=
 =?us-ascii?Q?o6CD2ggWVPjSjecNwkOLYjWGtz25xYCbN16U6fhGNFf3QGp6hmQWo08GFRtw?=
 =?us-ascii?Q?VwKJB5izGSpHWox74W5iSWews8VXrTEczIQ5agpoXqbaeLcCrvgYx/9My/zR?=
 =?us-ascii?Q?oPtpnI3oDYTmGuq8UWHUzeQkMUQ1xNwQFyFHaNWyT1fEnQUTEKj+mfimMjZM?=
 =?us-ascii?Q?+WLEyKK625u7WbKC4LbJYFYF76Zm4SmFArUgn7KSd0JFsxLL86ThdVtXDVLF?=
 =?us-ascii?Q?DEhYhBI2QxRQ6OyATAuAYbXZQsKwMLVFcLZsdNPSek6XGtKiSK8SLPfksNcs?=
 =?us-ascii?Q?pyfhh01nfwfHAdCUfUlvAG9Wum/fkTgl4bJPF8+icMqw/sH3wIMuvZqkWw2w?=
 =?us-ascii?Q?2qTZ8CWMw9DAb2W9RNhT2OveH3bgRUzH1kfmlQyuIfPaxLvDTQtqSauyUNnP?=
 =?us-ascii?Q?xDUfYuTb6lpQAOMyC0ZZNFkHlFj/WoRYO/Hll2j8TtsSCP2GIsUfIu9U+OVb?=
 =?us-ascii?Q?TCVkB8UfQDcDyuky7oSyIZ/13itVsSlUPzMlKdERl7nlSKMQukVuSd7+VMH3?=
 =?us-ascii?Q?ZbwUtuuTIYrU+DjXwiBO4nHaPmDZvCZG056aAAQk2NcoiB0yKXcUkn1IMl54?=
 =?us-ascii?Q?6jhXLNkiRZavagPwo+DcCwcwNOvAmrbTHOPKMGZh3QrPbCZKl9ywIofCrHxr?=
 =?us-ascii?Q?6+YirS9M0Vv57EGsV9JbAPozErOHodLahZclikQcFSCByVpW9AdX2olIBxkl?=
 =?us-ascii?Q?jNs/EYvHgX8qZ+p8ahX/oWAdslVc2eEUha77CXXn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e15753d-2562-4184-f570-08db7254882b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:39:19.1688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyDVjopjapoFHzPEbG/lwqrg6OAOXuvUKhjYt/N368nAa4ATTj6Ke+v717JSZdzmIBQB5Mkt8fJgCIEOs7p2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8725
X-Proofpoint-ORIG-GUID: lleDKoaDZ5Qm7RybfFVoGIsghGoCsX9w
X-Proofpoint-GUID: lleDKoaDZ5Qm7RybfFVoGIsghGoCsX9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
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

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/savevm.c  | 17 ++++++++++++++---
 migration/vmstate.c |  7 ++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 846aebd412..b8f564cb86 100644
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


