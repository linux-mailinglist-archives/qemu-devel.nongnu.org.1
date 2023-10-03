Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26147B61CC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZK7-0006sK-BQ; Tue, 03 Oct 2023 02:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK4-0006qv-0H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:56:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qnZK2-0006mw-33
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:55:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3936cpNC027912; Mon, 2 Oct 2023 23:55:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=KcQ+Nhein9nvjliI+jF+x4+Lmgbi3+z8sMeFeifpo
 YY=; b=2G8ShltExd9N9x0x24wzEHOYE1vh6Sjm37ocIx8knepPoAWX03X2gNIpr
 Q3rvACbnRph+0nYCt1kdeK4Czv8Ja9kHWxfegxbtlOFZEz4J7fSUfjeUwua2o6p6
 gWqb9kpRJJa58bKIlJFWqeqiGrC888FNWlObPzH2x/iTvOSe9OES3nv3lXd5NVVd
 VFxG9IdbHVM31Q3J0+Ysp46ZmbukdYbdfRED9SgPIy0DIbkMRlr7rhJPoHscNIWa
 eFBH5RZyLqn3VoLMbRhoXIhTW8UEOtL2An3mFLNa2hWN6k5IjvdyONMYgvEToLo2
 3rtGYwFi+qcnCTFEooZ8ffgx5X6ZA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tejrdc0u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Oct 2023 23:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jypLqWhpEspqN06AEvZwJKwEGwzYBx5ykxHrEpcz4Y2+YxKRNR3HQDw3VCrcCEr6aq6LB98rDQ3GwOEa1H/eWpXPPW4zVrndY9Qv2c4d3DU/5KLYJABsH2/+a8o5bXWLuxCBxnlAeweFUu+rujlJPoZdnjyseQ5IP+jJIS4IGV99CfEb6p9o3iSMYLWDKR/pGA6dvOmYKI0u6W6sZE0Jq5xitb9O694v9TTAcKpbC4EGaZ/snwU+qPFwDSKSji/FdEkD6o7lsvNDML59OrOg88+tYerYzCk/HKrLrdRv2gpnA+p/lRPSoL2jdpgAOosD47wKvgm67STFQTolUI8Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcQ+Nhein9nvjliI+jF+x4+Lmgbi3+z8sMeFeifpoYY=;
 b=Iyqsn872D08iYsIAEJ6C2r7jTPabZ74zQIFUhIXLTbXD9lQePJ4tmvBllg/+6d1QHFYdGWokZCFfFEH+APPJItkdsbe6UDfPy8lXgbwt3B9mIHjM0Oz6KVrE7KG4AgNgD/Zwj/tuxbnK0V/DMKriywMNVz55iblARVxHSvEHCH0TQen9trbGR7iEbycW90OCtGvN2zr2j4y0HV6CmnrPc+PgiqeLqsoEqDBseJqsdtb9Uc5bsdeAWzm3L9WsJCGG0uUEL/1U46F+ubfERlu35ZYtCfXrsnuP+6Ykt0E2JEidKFQTMNdZ6IqzJNa50A08p902H4jY9yFDr8Bwff4fVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcQ+Nhein9nvjliI+jF+x4+Lmgbi3+z8sMeFeifpoYY=;
 b=lgaGg8YuLHAhlwhdVaKpNxFB8yUUFGQBeXzWJrHrUFueGh4eVYftGIXHGvppC88l7HqZ7cUXyAxV0gjoMNSud0FklKl4NEAoxk9vzLDykl/yDlELGJGe8Pdc96OiEsyXcT+l3LJ8ghn2Qe2jTfY6v9VlulnhVAgR/yHrW5NgUE9M9rOMMRgY1p6Af0zPZXdshGx4Yzzy77DAOt+1zhDubt1LtkgpOhpPtIoRACH8anBD3DZstiRhAA1knMQ2CGmrsW1a//r9mH6OubtHMeU9AHkoNq6dPJSXZw4m3wLNsqI6yvv0R5vlaQSTv28bdlwzAfrRgwSXMG3402uMgfxEpg==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9746.namprd02.prod.outlook.com (2603:10b6:610:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 06:55:54 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77%4]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 06:55:54 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
Date: Tue,  3 Oct 2023 06:55:37 +0000
Message-Id: <20231003065538.244752-2-tejus.gk@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86a3d744-25d1-41a1-da87-08dbc3ddc9b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytKtr8VtUoDWu7CDV0SucPB4JTZSMPvwRcjxywiOlUFNrgTC8RvdMmTdXv7mt0HMatIo8BYtfsc/JnBYyp/k9ocZ7gk7J0LWCaQM6Kq+5QQQ1JmZFPDNe+MtUf/06FomMr7RBvZ8tm9TaXJfLOEWm7M0TuLTn7IxrF68QTPC6AeZpZWGUhWHGkuUSrcuxjH2N7gd7AX+g47UwsNgpbn5ZuUfH9Rq/Zn0F9dK3JjczLeqwFaJBqC0exQXV+Eie+bRdmBzuqLyBsWljN87PwAGGATqv5SBHGWUO2zEg8n7lF19EWQ8LsXn4n6p0gc8phLGaq2lSJ0L5redqO6roOiwa21h/r1zwey7RrYJLZ5qGRIrCojazmz1J+iR9t6C+ZIO/kRfArYpGFGlVEm92vDjwXRXdMGpOqYWTJ5YXjgKUMOR+IIdkbQE8lw8ojWvIAADrE6cv4GTD6mHfSEO7vFIsL42QRBfO9pjTb4wKaPG5Wife2En2QebFlczDUGr6YdBsthiQZ6yQbZK7Y62JZxkgOQoOivlsBrbI61t2B8g2+kkQ32VSKltXH7lfzg0TxnbX7plxC+wlTxFPn2h+T7igb68V2c7Iy8WNTdpbDxYTSzqs9Rdo5lhpScd5fpl11v0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(66476007)(52116002)(41300700001)(66556008)(6506007)(66946007)(2906002)(8936002)(4326008)(5660300002)(8676002)(6486002)(107886003)(478600001)(6666004)(83380400001)(86362001)(26005)(36756003)(2616005)(1076003)(38350700002)(6512007)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LE/iFza9Ao3rE46fJjMQspUlGL3H2zQAW0ofuWJcEzlgN9jQ0oS0GnQGUKAq?=
 =?us-ascii?Q?aX4w6eijNSFWojYLDJojhOeMSlFrGdQlXYBSowbzLI7y4FgHVYfWV65v3kMC?=
 =?us-ascii?Q?zaelZM5jB3VbeLCrF2NPk0hNQzaBa+JxwLB7c4ZOoUwn2W5Shk+zu3X8npg2?=
 =?us-ascii?Q?r6ohjQikKUtrvV31a2JwqjDVUzSbnPxA/g1kaysh1focheZy+0OssLyr+GNC?=
 =?us-ascii?Q?6j5IwcYNGgDJh6vbF9kAfglYBkitjD32QP0y8RiWSW+8QJJi9L9sZM55LsEO?=
 =?us-ascii?Q?ZqmrbVP0zwojXZOHiEwljF16rnjY/pStdfyUdBjCTtMBhdb4V7bzEG7c+qHu?=
 =?us-ascii?Q?AaNNOGiRoQQnJ5uLrfsLuA0wk8T/yw4UX0TiENsfghe3RO1sxYTn1Q+JCojZ?=
 =?us-ascii?Q?f1pn5SsR2BsMn7MhtGd/IyzUex3371vk3c6S/TSjP4BCrpaTWainsOUBTB2R?=
 =?us-ascii?Q?oq8OrLM81WeQXWgpHrzSqjOH0tK+TqqxcjZEE3LZ8/siL0BKf72992QE73XE?=
 =?us-ascii?Q?jHEz63jKcLuLC5J1qK8aDZ8KL3k2owzqO4PW1C26Pn6DGIBQm7e6/FlEO3Cl?=
 =?us-ascii?Q?U+5o1NwnumMTJuBKLYnhaoSrxIrSlrf/DKShk3WXCZKU2yYBTkA4Leb5DrJ5?=
 =?us-ascii?Q?v4S7CNcc3FPgJ0g/76I89wDjEUZB3/UtUV0CGY83x2Y+YrMngAXBjz3mWG55?=
 =?us-ascii?Q?GIY9/hcHa87AKFmJTiWvrQTZnxFYM4/5LaJ+smnXzLG9YQcN2aVJIZ/skk5N?=
 =?us-ascii?Q?FQndKIitu9I+HNBVVtCcBYhuybNlDcqgm7sAlZvZ0Xrx8twslbSt/hqbGl9K?=
 =?us-ascii?Q?yvCUBY0cWBkoDYHJ5rQdYOk4DoFdSlrTXFDh1xOZoq4ZEgEWwCSfIUnmrX0+?=
 =?us-ascii?Q?49vnBDMRsrZ2ldzNGMld6WV4DI4rPA40wkATCeA15xitBQVNDAPCEzBu58JB?=
 =?us-ascii?Q?L3Uj2AJ+3SyNkjXSYPGeMo7IfxwFQ7YUQt00km+yWm0JJEQYtuOnpbylfZ24?=
 =?us-ascii?Q?UWVA8Nr0/Wyzbu5ooRtYhfHZEgJV5JYqbchpNC04Itf/pbREE4vuHFUZv/S8?=
 =?us-ascii?Q?xJ4cOow0dDy9SegztWFlGQFOnDTsA25J7Oub1vr5SWpHLbq+325SdO0Vl67e?=
 =?us-ascii?Q?07AFhjyq7N+AWAH1o5QYf3fEnKOX99lZJIo4+4VrE/mrraCir9+d039ahTpt?=
 =?us-ascii?Q?xAuE58Pmpj+v/FAU3a0KRUMVixnLJZ/DVZQljv6hEGVHCvNr0vpnchO6dEtk?=
 =?us-ascii?Q?kVDqeRFNwmXh5eSuaD5b7jvhKhTMDeptKqelHA8eoMgiYGUliFGM2MJLn7qP?=
 =?us-ascii?Q?zcCmGnim0Cr+VLJNrWQ+k/yAuZgeZVZME9KtDwLH6XPvy7ojoa9JH0T7V18I?=
 =?us-ascii?Q?0i6PBZA/Xn0gqrxNssiqAJZbqSdnE66Zx9+rtMrsaZf7GMEMDc/9Eq30J7jO?=
 =?us-ascii?Q?nfGRbmHHfX+5d/8frketIHsMhob3glNdvzQVmMP1lDgOxybaq8PMC6oPYx3I?=
 =?us-ascii?Q?SSCjZbdqWU/in/Ov3T19qVw7cwdCe81kC4L2SFosWdgPZdcHhnxek6DEQ3C2?=
 =?us-ascii?Q?8Nd7xan2Zzdb/XDCZA2xShWa8QcIFiXamOksFAgLHIFaLhiBx+S/deU2MM4H?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a3d744-25d1-41a1-da87-08dbc3ddc9b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:55:54.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCjrsUTa8KF1JUggZO2bfxGl8xzZcZOHSYpGB3RY09gw79d2x4ld9h1oWgJuYQJrdbUPtQNsNb5U4rchb6kgOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9746
X-Proofpoint-GUID: Yo5L0LkNbiQ0e79Ev6f5ov5RmgqMTo7H
X-Proofpoint-ORIG-GUID: Yo5L0LkNbiQ0e79Ev6f5ov5RmgqMTo7H
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

Currently, a few code paths exist in the function vmstate_save_state_v,
which ultimately leads to a migration failure. However, an update in the
current MigrationState for the error description is never done.

vmstate.c somehow doesn't seem to allow	the use	of migrate_set_error due
to some	dependencies for unit tests. Hence, this patch introduces a new
function vmstate_save_state_with_err, which will eventually propagate
the error message to savevm.c where a migrate_set_error	call can be
eventually done.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          |  2 +-
 migration/vmstate.c         | 12 +++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e4db910339..1a31fb7293 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1196,9 +1196,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc);
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
-                         int version_id);
+                         int version_id, Error **errp);
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..1f65294bf4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1000,7 +1000,7 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
+        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
         if (ret) {
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 438ea77cfa..dd9c76dbeb 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -315,11 +315,17 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id)
 {
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id);
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
+}
+
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id)
+                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
     int ret = 0;
     const VMStateField *field = vmsd->fields;
@@ -377,7 +383,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
                                                vmdesc_loop,
-                                               field->struct_version_id);
+                                               field->struct_version_id, errp);
                 } else {
                     ret = field->info->put(f, curr_elem, size, field,
                                      vmdesc_loop);
-- 
2.22.3


