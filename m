Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6B7821CF
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXvf0-0004L7-Bq; Sun, 20 Aug 2023 23:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvey-0004Kn-5p
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvev-0007ET-EB
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:55 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37L0eAoL032093; Sun, 20 Aug 2023 20:32:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=FxmeBqXXQDYJurqHbQXewSXVv0MMatw8ulB+h2pVK
 Uo=; b=EdMcb549ujUQdbrQRkvMlJBXa/uC1T5WZvjktPzhr6PZIz1DgSoyBTj3k
 u4VBBUwdetmiEtZpkJoSL6wkE9vhlE8sGGlJ0NGsMizw8PuraoO5TD+kt+4EC38H
 MIFu5AbeOqmrvxKco9CMErIkcO7vcfehAh3c/rlTSQxQwu6V4w4/YIWrlmzY/UCo
 3nX0pJWIMVzkC5DCQoVZPKEKzUM9WY94f5uq1uKIIwR+RLUOqav8FycH3XMk6s6q
 /PLaU2euumhnGRTi+rJR552QCBcWfPkJjubKHH7vmL0gCtBdvbeuvVnbOeFEubG+
 pBue+8f2Z5QlMmMGredSqwcSnOZJA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sktp1gak9-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Aug 2023 20:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3cvT2raY43hKLLHTSMR3cgSZiqj1W9kHeqtw2J/jQjajhwXjYLVyrzVzi9rwX07TYV15nfHkxiyKBstffGL6KArzgWR4jKKMlh+oqrRf325h2XFOGRUEQC0Zw76RV8dnFqIveFHco2QBbn8QSuyQY/O7qDmM884OhzXH7vuT27MKSHALaEEnCSitofu/dSeONZD3ne8g6IMmt+c8RSZSED4XEZ/GsEsNS4K/DS9ttTg88yw9cj+l41JMg8AZcIZ/BwwG06wzsvnHTlZBcKEhxiT5kDV9NjhzPAOD7th/45wCqH5GbYB9k+8EegTjsXV7dC6YxCTYHZP9+YbUq9jWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxmeBqXXQDYJurqHbQXewSXVv0MMatw8ulB+h2pVKUo=;
 b=IaEW/N8fx6Pp42SNSequz6MXtDiLkv8iTJCrb4cjb62+ooPo4t7VrlpwFphttw8TDL5MgonmdFiF7vLsIxbT2DKqZLcXlh3Vch6tTIOWGQfxEHYtSwBIWNa0wSPKts0cxxW1KS0m+LhL3E+eFuifWuctrb4C1IzVLFAv/yz/9BR0cEhX1FrkYar7solwkmKsCdW8iKRM+L6c+ijg2jBX1T/dYObU0DRuD/zghCYClpnYwJZKNPe+3bEuEaLbZ9NUxy9bS7cUFLFz2nYmfUgfdqnRh+k8sRzbh8kJR8p0HUS31Y7fWGb+bZQvjTRF3nxqPJ8YAMT+J+ofnq3uWkrTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxmeBqXXQDYJurqHbQXewSXVv0MMatw8ulB+h2pVKUo=;
 b=c7NPP+ORnbYXOK2BIFUTO90Ez2qc2UuMMXjG+FZ61mOwW+cF5W+tGzUMKtrQJQyFxe8bodmekIQePyreSx5F1b31RxfNnxpMopf5ArWPhuwlQ0m4gADAgfgsmV7G/xRO6FZZNdCBoUOCW/bmt9oyTiz954glniykhwIj5bbmvEsfUn9Y299l/0TB8xVrhN7p3wLD0aNtw855qowohoMpFvnDt+ULxeOdtlRnyDb1eaGTFp3jGiYFzQHgsCTNMRt80iP/ckBmI/lzQ77wNxmiX3mExoIsovwIvu8u+OBqkV3PMHsCjJupGn7DlGodcahRiRBI27TaSev0MvCbojihCA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CYXPR02MB10228.namprd02.prod.outlook.com (2603:10b6:930:dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 03:32:49 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::6c22:957:5d20:651b]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::6c22:957:5d20:651b%6]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 03:32:49 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v4 2/2] migration: Update error description outside migration.c
Date: Mon, 21 Aug 2023 03:32:16 +0000
Message-Id: <20230821033215.6112-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230821033215.6112-1-tejus.gk@nutanix.com>
References: <20230821033215.6112-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CYXPR02MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 62169fbd-3608-4dee-6be7-08dba1f74ac6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpRg4o/Hta5xCWPKu6l9DIudBjcutclzT9OrcME3NHT6B8U8WXZAcx7hXCFUDpsBev+h+Bve7mduh+//M3+EtjIjiJx0pYRfAbp96mVCo4xtIBWBpn2cuMkyhTbqkbuPtFYfp8a0BpMohs8syl+XxA8/MvKhZtFxoblX2sEtFYZYCZvIz7qzSyuTUQli5jbVJqLt7hyaa7jpdJkEfHetnP0IS6cCX0POpcK6Q7dnsrbvh6klKvGZ+0lStj8yEMMgZJbqC0KmNNoLVgzBKQ5C5admPCY0xl0sXgUbrGoduRePEfmXWfJj+KmhO2CK2+zc4qiNJUAn+4rUTwmR+6TA7ITtixY7Ub/Cpim7zRSFkkXbo5yKaL27HhlxEpsLEKlg6+ZIFA1k00NOpR3+NIS9G5pltISpnYmM39cTHowf+1QTGmk7OY4WxBTkZ+hvGU6uiG1KWf0wSRQuBKgq+Cu60aClVVgr96spbuPr1OGo5ZNYeHZpvzP2MYOjceMzpvrOCjr4IE23h0VzpPDT7VPkftzfIokY+kErjfnBqm0R5buZyhwjR553AHg8/C4dYnaafOfiOXaZ1zuNPVqSmH87n9YorxccEBbQKo582FxTGuEpWp4KCpKTBpntNelHDLUO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(6666004)(6512007)(52116002)(6486002)(478600001)(83380400001)(15650500001)(41300700001)(5660300002)(86362001)(8936002)(8676002)(38350700002)(38100700002)(107886003)(6916009)(4326008)(66946007)(66476007)(66556008)(2616005)(316002)(26005)(1076003)(6506007)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pozwdNDBN1TC8X66cRzIPfPkyWnomlKA/1O/wqj4i5KuFjkb5qWaanTIgTem?=
 =?us-ascii?Q?Bsxdzs6oKLN7k1EysespdohRaYOEd6MILEKgWjISQBo58IULa82t7PbMHczN?=
 =?us-ascii?Q?ibZ3G0o4VYSHpXuyyPC7Yr2cNrrrq5N5oMPkHo3z2/bs7rSldFb2sAJYiIjE?=
 =?us-ascii?Q?A/fAWJh03nHjNgsoWAmhzhrZHXneJIQ/hh/5Y6998zC2NVbz26JtiLWOP4Ff?=
 =?us-ascii?Q?ox84ne9rc8K8+mvKgn08KsQas/4EaI32p5YERoBDR28hp2RTFu959G9Bnaej?=
 =?us-ascii?Q?w6886vTrluuCok+Xjvepmg49cJvOABV6vS1cQFZfZ/2kHfXJR5rKsP/a2eL7?=
 =?us-ascii?Q?baeYZm4rYG7AI9aUdWLvI6r3fZDcGYRVBPWlFpz8DwVpNalRFMUEiEiQYyap?=
 =?us-ascii?Q?5U8Axz1grMPNS8fY5fN0jdiseBnBTVpGdv73d2kmgCvdX8AoTQK/s9fMMRoG?=
 =?us-ascii?Q?FNoof6997Ayb+nRsVUm3hoVovt3vMtI9+Fr9essvUNC1J0sMgXnHAeMduftk?=
 =?us-ascii?Q?x/h05TEkW9OEabRToTkEXkHhiNOtiwhBMR9Lc6v5K+eSdhUZLeti7D6tUrFl?=
 =?us-ascii?Q?oJ+K2jIMxpBNVz6DBLGi4RebOyj5Xp6bmXvoVn8bmQTEmy0NloeGlGeueNGl?=
 =?us-ascii?Q?w/o+LSBv6Xp6vSefjKFoGnkWF3bqGUefV9cYB0rR1HDr8n80IiS3bMNXjsaw?=
 =?us-ascii?Q?1eca3dygJeewR9DPoLuLnrNpds5ZBi875yztuhOfdXH8lhDqxI/lZhb6p9YV?=
 =?us-ascii?Q?iaWniirtQdzXEZEIhlZfWrXItZdXbaREgaj4a7iLvp+3TdS6hRm+cr+CPK5y?=
 =?us-ascii?Q?RqnCRXQaXUMC273wRg3wDfsuFXw8MzAQhZizUafJFtQBGfLRlTtIajCe/tK3?=
 =?us-ascii?Q?OVsWA8Lioww8P+6bq9USDeWwHeFZyNigzvi+9xRytBDI0L3P8g1YEgjn58v4?=
 =?us-ascii?Q?+/Y1S6YIkxUXqtimOfkr5oopLKBU9IRI0HlvZj0IOckbBGwutJKjWB/kNCEr?=
 =?us-ascii?Q?SXWc+emwQePgdDhEi1y4fz5EMZ3Bf/zmeYZUganY6LB4UwKXLsFTAWugb4Ya?=
 =?us-ascii?Q?A8e4oabu6RXrsgzfa8wP2cDDD7bRUIMt4nOrNgpqnQ2/MyOMw8DvYa4FLtJZ?=
 =?us-ascii?Q?DEHKmeiBTuBZy1RpZdLhr7coAk7zJxmEHTtvmIaU0thfrGQCiAu4JCq1M63F?=
 =?us-ascii?Q?sIBX12Xv1urXGbdc7ow4W3+bYnkQTRGGNTWaNKW2QeUhvTZKI7Sn8j5nmjxD?=
 =?us-ascii?Q?54reiGExFexfTxkcE/3OXL6LzLkRPTOuQ4V/ldB65RekMSr0pSta55RaiAKD?=
 =?us-ascii?Q?RErUe3Y/Fg+a4FgCA0zCyj5pB4Ylk52RV8v0tYUM95K0i8XZDT5BSF1nfk1p?=
 =?us-ascii?Q?pM8VSPjTzOGTG/fA8Fm4SlmmZNn0feY0RM3uZHMI9gneevsX5dkgJ3FXYeG4?=
 =?us-ascii?Q?I7pyyn/zuimpYMsufQCFB3Q3d9Jy6MEbTq0moaHINBWW/NxvreAp6JUnEvWW?=
 =?us-ascii?Q?PMPHwsBtDhlkhBsL/qFPLRU8bKsT1zYgs6iQvBv/9nzt2OGhqtw79kNciwHB?=
 =?us-ascii?Q?RN7wtcmUxc2PxUrCgAwzgg4iFH79MlAvjqD7Yr6i?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62169fbd-3608-4dee-6be7-08dba1f74ac6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 03:32:48.8301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQv9xe/1W0b9MN5A38eVvNRcN0By4lPpFJiDoDxPwqfPqEm4bE9oq580M1VYFEG1sF+8q+YxvVVWaEMWcEQQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10228
X-Proofpoint-ORIG-GUID: 9Kmaaitpsi_6wC-j1xogGh62KtGEuPV_
X-Proofpoint-GUID: 9Kmaaitpsi_6wC-j1xogGh62KtGEuPV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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
index 6c404ead1e..540bce3213 100644
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
index 417a83215d..7618822e61 100644
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


