Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C752B7821D1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXvf2-0004M1-0j; Sun, 20 Aug 2023 23:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvey-0004Km-0w
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qXvev-0007EH-GD
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:32:55 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37L0eAoK032093; Sun, 20 Aug 2023 20:32:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=8EA9x38gLp9aFQtgaBVdFbf+bizpWSZf+27g8RYhe
 K4=; b=2DqfAubzsbbwJjnrc27mokumAo1z8SRjkS375ZsKYHwHqnkX+Lq+jigJX
 zzUjeV0ye8/U53XMLYeSAgyBJ3PotRCdUot8AXfsqPkcmOL47bFY95zlIS5rXMFM
 sNjSvlecTUbbDAeSmfJAJIoq0fqHGrT1dv/MR+K/2nNPtcjFhu6BpamWFMpg98yQ
 m9156oDxlkF1VMmRnfgOPR801mFYdLvSK5qQ9hU3JucDuOsfJWOE0L3QVjbkEX4X
 3/D6X23XtwK2caJoC+hAqjjFowlAiLC1l21GXOKLYI8zt/4QnFWM8+d/Ftu70n66
 U+zuzpHjFbQJ6zafh3PrckYO80XFw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sktp1gak9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Aug 2023 20:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcfQEadB9+8319a9WswcSnlvgvmr6gDg/569TZxQpONqTEUbQKNfsKcJGdd6tPZl0qfjDAAU5FpKJpJxHc7rLca8R3D3sKBiiNEARwaBX7AuLXbwdfAq0F52JsoMTF53Gy4eTmyuo9zPX+p+1eFXIFVwXP70JGnk00sj5f0zD02Qaxy5REOXuCOIEUOboX4af3/t22BrKY3t55e7onV69CKd85OjWPKsHz8T+6bSZ0UDYsGffWBKtkQ20CyaK+8W/Xj9OTutlmeixQIb3JDloNSaDKBxf+1qoSwkbHSoZnknB3RbVsyPiaVeZCiJkUJtESEOE1DMV3pBUM2Xh9kV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EA9x38gLp9aFQtgaBVdFbf+bizpWSZf+27g8RYheK4=;
 b=VawS3mT/UswdUB3HhJMFeodpdlt78w9MQt/WsEaT8U9Tp3NpItLyetRwrFgj1A6H9YKugVN2W+gCFRDnhVnm1VD0+TsIkpcNwfOuETk0a66ycEmFJ7ZO9vegicVYC+ItfI+2QPlXSHZzU7RZjVqAEya7cM1XHkg3cgoyWNIRqroxgeYT+4XOqyG5ih+q5MUElElVaMJbuleHSdIzUnUpGv589HCQMwQ4l9x83QeAHL0ts0HHdiQd7niZQbcbmgEXFahvesYC2ptvNMlA1vD4avQBfRuXYwW+1cKUo5oNaUK/d0v2ORb5r5UnNqxHzMtLzA43UayrEbB12X9f0SpexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EA9x38gLp9aFQtgaBVdFbf+bizpWSZf+27g8RYheK4=;
 b=bPRIJ0snlxZstlPS+9NGzrWeF43HUtRhuYwqCP4cLfjBOKLloHJFPjkRjwh9r7UugGxdCuJC4/mTOVmeAfuNCRMR0w1MhdFqgTOPvx7wXUtmmK47ocXrwW0FdXfN8Tzrl6Ya7LmHZFBnPOQ6Pb7L3wvD8VxHPJH4rHpESyn1xjMsEfaxHvzHuWcPF5dbkyg0oDw/bi5JR5WtSQlwA+I7bc0p2BdrVMYCqO0MY/5b8vCc/NOImszsUYtCjPUwqz6e9DK7UL76mIEjzHvJYnll3vkREuC90aJDYyJ03y9gVo/wkVM17pWHiQupohapB2prXb99WdqlVXcOHwXZiriAyA==
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
Subject: [PATCH v4 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
Date: Mon, 21 Aug 2023 03:32:15 +0000
Message-Id: <20230821033215.6112-2-tejus.gk@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79c55882-8682-4c34-48f2-08dba1f74a81
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcVboOuqqi7qfTAygqWiw1oO/tX2ERD27pE80Ko1Mz5HfgM+H9N/49vFsKeUss7YsNEV6oeY8VKGejsHdJ+qqO40yJtwz+/q2gY1sC45ciFtXWaWtJx9OcO2b2H+2kIAz2e1Jj+aHk0rwzHinoHK9w6Z/KeKstDHH4iduvMO+H3xXRxuMUin0ExVHdP80PmFHsQTOLh6fYccRHEbY87Bv5CFXd/ZWSMikcdY8ElKueioiAX47pqN3yG3RVCSt7FCJT6aPAJNtL4czJBauWJkp9p2WQQsG/kbo+rKMP6EzGFpUVqmuk9TzgdXB06mXicIChOArnzXTAgR8tibJe6vxiJD7TiCe+7pSBvOi3QvvREVn+nIQiRxIU9cJSyAs7jIWZZhRDvtfdgbbhXiOoMLA5WJBqWhWEKVAQumou7Bed7Qb3Wz9jj+36hKbshhK5XHnipNjo55rtpnvCWnv36PDFlhVdqGOwM9w1UefmIo6bhaNkFdFZ81TW+Z5TP61jfSHV41RSpN7eWgoxOPv+dLWEM0rjLpRrm1lHZB6vlNxr1DUyH/OjeVS2Zk5szZY4AS+2F46sZU3+7XrHeLzPT4iNlke+/TBowyE4E984Ut/DLNjUItxtm+hFCQEyUFGmgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(6666004)(6512007)(52116002)(6486002)(478600001)(83380400001)(41300700001)(5660300002)(86362001)(8936002)(8676002)(38350700002)(38100700002)(107886003)(6916009)(4326008)(66946007)(66476007)(66556008)(2616005)(316002)(26005)(1076003)(6506007)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6oTDT278UmPQY4rCKH7bDFVN5kxHYilQhCCT1Y1klb234GvPKivR1J/4zgZq?=
 =?us-ascii?Q?TTvmOTg4Zphj1R6jvE3xfvmIPM99uZ5VgApvvb8+FAlSS47clC5m2tjqDe13?=
 =?us-ascii?Q?mLhVDKudVdOEpqjLnqq1evBWwd3L8WtXMxBZIyvd+z85Gzwo7ctMh6fJ9zyn?=
 =?us-ascii?Q?Eyko33XLWQhtl2sTszqKx3b2cA0a5cYCaTWw63lRA8sqHxQL0U9nGIcLubyc?=
 =?us-ascii?Q?penTGULMvcmU9onG5wnGziaYRufOub/lB8fKL9VCXQZGSYYJDzXp9SbliQ2Z?=
 =?us-ascii?Q?5jWcqLTZKN+pUvX9tC1W5r1Bvyk4AWucGKa4kFW41pkbS+QHEW9RUaUiDCfT?=
 =?us-ascii?Q?MDD5EOFt/ex1/FRtTt0ggS0vdVK8akhREu12li//dDPPj60ipr9mw5HnCojv?=
 =?us-ascii?Q?CeveLituNyrO+dpVk6SAALcP9hHyIUc3FaEVplB9vR1Rk4efBHUFxqREvv8e?=
 =?us-ascii?Q?FZ712EF9yffk226sSRQpE51kRLkLccqqzr+UfGp7IGA2KRcbB4+cztYSDp70?=
 =?us-ascii?Q?/C3Jm4fem+b69zGRLKyJeOzJrWBZNdZbhB0psFEqYjro2H4EjrQzNezvZdW9?=
 =?us-ascii?Q?hFKLsTsu/FelSl9jMWEqNCOeiChMSM2YTRplE+O3/XbzR5u+y9CuuDT8Fazo?=
 =?us-ascii?Q?Duw8KWeQD/NrpKDRI+n+x1QjYbfFHzn7CIYd3cUSOaq8WRrVov3dKd4QRV6Y?=
 =?us-ascii?Q?aJFPwYRaDwk4gaJO2OhjJZFJmrO9yFMLVlUHD5/ggZEj7DhLO1fq7H1NYFqS?=
 =?us-ascii?Q?IousMiI0xDcwh2kyeJDfKdhIc1ThsTHbjiQVc8zJ1BioVpl0ntYApqSZTW/f?=
 =?us-ascii?Q?MIAQxr6aeQx08GysCgNVah/J+EWMz/g+nkgNdiSNJmKMj+KWiMXZtk/jj6+k?=
 =?us-ascii?Q?ArYFhgWZJmwdb2on5HVT5WBSH1OJPtGhvfXaRVsmt33cMANEXrnMwIsrMjSM?=
 =?us-ascii?Q?ZXAtNqE/AWbHqmPJWOAyiODYUnpgWCWK8uJgAOhoMGwpDWnd51I/oxU2sB8Q?=
 =?us-ascii?Q?gy6K+g7VUndTNoQIJuu5Soe/6DUAb4kQit8j/p3fdh7Gvv0cubZ/1QpzYTBe?=
 =?us-ascii?Q?Q7xBtxDGXdVSBlt4SVhhlguU+RpAfV617EauM4E/+F3V5Bt7xas3RPGqdrVb?=
 =?us-ascii?Q?D/4EzSfENBcX8cPGczGCLNrZdGUXqvJMBCqhD8Dj0uHX2zkDGdjzWgo0H56m?=
 =?us-ascii?Q?JJIbzXGsdpOqm+jk5hQ8JUf1wunc+rZOgieVDiSc9nExvRNVOHpmGzUlGPp9?=
 =?us-ascii?Q?MwMSYGoMVYXEt0wotCUT9N9Vk56TdeiAgbVFzi30Ughl7aCFCLbcrQnMu890?=
 =?us-ascii?Q?6pWNtuq1uJcx8+zYAV1r3PlIdvvk4Q+mu6h62lcGVTJrRJPgOXD4vaNOiCaq?=
 =?us-ascii?Q?F6MwadxgWKW+SV6wIkVwXb4PW56JTgfBZcevXkc4MpwywdF1zQhWDLt6kv1C?=
 =?us-ascii?Q?f91YSkx587gth245e2P1StgxQzFLuqeq3yNItf/UT0vO3yWBVlYmOaSDqfl5?=
 =?us-ascii?Q?Wb6MfgkhIgnNs5jDebVQNgN3Naz/pWZerYwJyUIxwoLvrlYyLBTt7PhLW4/9?=
 =?us-ascii?Q?BAdXrvux2A31dKPkLFwoqQ2Wk7JqzPt3QzLIB4mJGxfDuazgUlFsvR6XhG89?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c55882-8682-4c34-48f2-08dba1f74a81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 03:32:48.3773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrX9uLpTZlhjFkFjvK54y6S56U6JF563wn6mpdyY6osQRSCrdSJWbGKNBQTgMEG6+0U+qqFhINe3Rt3+7b0Avw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10228
X-Proofpoint-ORIG-GUID: qoT6lTml6NxPNLYwAfYHwuCcJw3UwXzc
X-Proofpoint-GUID: qoT6lTml6NxPNLYwAfYHwuCcJw3UwXzc
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
index d1b8abe08d..2eb6002b3c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1194,9 +1194,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
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
index a2cb8855e2..6c404ead1e 100644
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
index 31842c3afb..417a83215d 100644
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


