Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 809987383F3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBx7Q-0005Kk-1A; Wed, 21 Jun 2023 08:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7M-0005KT-Ld
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7K-0002ZC-Nv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:24 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LBv888014880; Wed, 21 Jun 2023 05:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=NycAyCqw/JBaqV1yuSQvQn7KLKBLbYiKafE2Rt7ulPA=;
 b=QKalGs0G7+Hcl+U1LMVzQ4q6C3a/tK9ns3wDywSfLqLgXcVVfy94oTE9uo3G/mjtrIi2
 2j1x4cGsGgRd0nGYfdASmVOuR1Ze493hjAji7sOpzCw86TO58MYjM4FTA2tn9RJcVwRI
 RN+/87RilBmX1iNGFevsRjJZWyq9RzKoiaBJ+OKWOu8M75Q1hCMF5LqLfZ99t11BaZO+
 7Z5GKXRW+bVRcAYz0oabH6BFwg2BZiGic1YMNEigRvlyywVhkOnwhFxLFb3xZ+oc6LWu
 QoGANoS02+7SDGuVG/gBzFSNnPAEs9vBYpHg3ph4JdPJCVMdqoYk1iYNCLbJHsTIq3wV sQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r98r5y9rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 05:39:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW5rqrnFAeo8/o+OSdp4asP/0F/QSZQ2kylgWuXmxnMVKE0kLZ4TOX0IvnTKlZfzWyI79uh1S8i25ZJV/icKP9tBvPJD5clCejPE9JP4uCXZBJh3mlmCGk8pa77DVyn+jI3V9o87CIdAq0tRhjAZ6POhvjDIT8gkUh53UUKANdL/x8ftztkFRKIKCQ+C3UPpHumLpEr/cXsCKlBAdgujPmL+Yy/8mBokc6m6hwEoQvjqDdd1FNUDrW1H2AL68c0jdbNvHE4L8tAK5F7cSnsnFqaURVXT29xPRGOEkOip+SyRJtA7mpf1BsNAsXRNsWvGSFYmk1aNTKXOwaiNAuGF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NycAyCqw/JBaqV1yuSQvQn7KLKBLbYiKafE2Rt7ulPA=;
 b=fXnUphAKhNzFrusUPfH8NTNrUh93ExjUga4gUlXgiAtYK1JD+Y8RUoiuvLRCXf+MAkqvwuFlB3L94E6KH5cO2XYM46QdsHHBx9bJKkXCOHCEsfaXKSLfOCaDSXcv5Wp+y6h7Nr8omeaUb8dtzoUEqpU8xuyJAJbXYKbqgqvobbzZhAgGHcAfqV13UlPaDqDd04PpRBFT30D5Iy8x61FRfjEVXdZDu9KHh/LZ79VCeFy7B+G73aXHeCncyJIym06o+7ov6SZPKBOPaZstgM5tmgdAoAYo12MjwktVUHc6xzjiKM4+MVxtR4n1z2o78+B1k8segEfjkH62OPkfng6BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NycAyCqw/JBaqV1yuSQvQn7KLKBLbYiKafE2Rt7ulPA=;
 b=ubO4lfzGCr/WbFJGOEfB9HDkVrXNCIUHVoiLwGdhvLA/mTqEU+25no7lBPlWF/or88fO+53zL/hTpa780cBAVdoNkavSUy+iG/pUrj/Vzs00f0b/pChHHkxy6XIB6/6qMxfQSiqi5tPYpdz39sIgFVhrXptW5W1O3+d/nuXMoM2+jOLDgxblM1BlrHHfQUZS4IJGmn4whu9MnzdFY4fwYK12SN26EmafDZ5Kiq79NSMUTInpN68UPbPZhcexNb9QgJszL3+JHxz1GOPgRhgrJqAy/PEkw0p3g23sbH5Hx0PaGpNdJAD8A/n93J/vt7CsLkqTyFZcIhnwKKH9ueTHZA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by SN4PR0201MB8725.namprd02.prod.outlook.com (2603:10b6:806:1e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 12:39:18 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 12:39:18 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v2 1/2] migration/vmstate: Introduce
 vmstate_save_state_with_err
Date: Wed, 21 Jun 2023 12:38:43 +0000
Message-Id: <20230621123844.177739-2-tejus.gk@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f9d6c09-7fab-48d1-34bf-08db725487e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FYNQmLwsM5A2G1i33HuGqYcuSlITa/vRFl/voZMbIJLVym0uy2w+l7bN0pDsF3YZ7egbMsuR6b/Y+XUi5tTSV0Eet662Hshk41UH/FB0OKKeV+P/TtKuvSHt6G3dVZhwsDbAIzKgL/feEHvNv2P0qBWMEz10mJ96G6kuCkrlMlmroOVOU0wQQWFqmh3UsMMt7uToBkdy6yuyun2fST3aEE0mz0iDAfcc5DEN+PW+SJuQkt55+2SKzcC7yrCRAJPL8589ZKsMb4dPh204CIqgSDlB9YZ8Lai3QhbzK69FkeS84b4lJgf3yhvbDICiaT7fzNKNa1CWbS3XAH20NJzjgn5FcBj7vIWFZSzACINAMCuFPA/bYn7aXVfg99NalxcYcAnjzQt/f0NpJgIX9rqxOOEz+mQFGdbCY4LU9P/K+Pp+9qWVygkdkVD0kjj+p8UuZuWfuOz/oJ1Q/vthHGYJAVihlVF4EqgIc5VaPBws9k+h0ZcrJcmRt4sYFWztPNwtWIwmeRsrtFaJST9bJKKGAttaEWZN4m5yNbOZJJPHiU38Fi22LBpgyd+hwsjSPD6roloUGH6LLKuH2312oR/sU4mQ1YUnqEMwdIakScRLiOoJQhT0H6Cw2Wv/j33MXjj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(6512007)(36756003)(5660300002)(66556008)(66476007)(8676002)(41300700001)(8936002)(6916009)(38350700002)(38100700002)(86362001)(4326008)(66946007)(316002)(107886003)(6506007)(6486002)(1076003)(26005)(2906002)(186003)(52116002)(2616005)(478600001)(6666004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBwJ5hAX/5+t8UcUkLUxgmSZlQOeqLnwqk+MX0L8AxtpB51Mp0gFrH3BNw5V?=
 =?us-ascii?Q?C9WFm24SSw84P8ryu1i9V/XnyfFTVg0ZXAvfabAnDhZwWm+UVxMxw3FCVE4i?=
 =?us-ascii?Q?A4Cz4hdWLaWfQyhEPBGMTQCWy8IQzPez49F184AF3dR9QNLHarQ47MWR9LC+?=
 =?us-ascii?Q?X4Bw0fSEumeMxApbQ0mlpAAjAW6/0kq/ju1erwY++4SNmP7i201oPVmm30Pc?=
 =?us-ascii?Q?nRHnqOoz6m+sPIo7509ZCTfFiSGsaAm6Y3uObBbx5WcQlPcpXAbU0+HciDPa?=
 =?us-ascii?Q?vPifb8Fokgmx4TiBb1jbpXDmq+brbHe+xrrtUblm5+qg43WV0fmWywiueStj?=
 =?us-ascii?Q?4SlwD9HpI/1KjVbWNqKfw/SZnneVpZY2cX5RQkGyGUbZEPzXaImzAieCZo06?=
 =?us-ascii?Q?ep2DPZp8Pev22oiAQhu8PA5F9Hv4bTDC7xirXUNKz3a2aek8BIzq2er9naOz?=
 =?us-ascii?Q?tiRI7W2J/aNDujCB0SmOopqBBX89NH+tyaiibpDwbEGQIB7Npx0RUuwh/r9N?=
 =?us-ascii?Q?3ztf09wSUvNaxN1xjAFuYyI0mjQllGiXiw1obowTqix/aRXpxs5E8ss66ys4?=
 =?us-ascii?Q?we0TmINc4xSnRr/gEWv458f8ElpJq8Th52hRBJFSwlltDtBgjKWq1VZ5NcyX?=
 =?us-ascii?Q?hJiP6awK3EDmP6P+5FfqbRApkhsJa9NygORzqD1TTVLaiwT60h9ytyvaawSl?=
 =?us-ascii?Q?Y8R9iiCzrgdJAaK3QHxbFZ2b+/FzWKFyF+FFWxPHPvG3CKo4IExlCaZZpAkh?=
 =?us-ascii?Q?k+XeBeLU4oTz1hN8VA8970aVx4M7jKTJhY1Z+h1eJZwUibDrn1N1o1R4DsND?=
 =?us-ascii?Q?4jicB8VgteVruWkLrvCz9+t/12l+Knjk/yCbCKQNFpD/gT3ajgyu2oBjGW4s?=
 =?us-ascii?Q?ceRs3Benze4l4SNgvAoR2CSdWY/VWJ4YCgA9aEf4fF8F3Qajaj3EAmEpWkaQ?=
 =?us-ascii?Q?R7eMKefvjAsqAksTfLcMins5yJ+xeNgHW3KGCmAac+ZDZRUPyjjiWGtsxxXM?=
 =?us-ascii?Q?O21X2WBtO9GG52juCTzGGchGt6EIsxMouLquljzjhhsCF2iiROAXjLYNzCfV?=
 =?us-ascii?Q?C7bqC4nl3KYCxBrJVgkj9udH5vHvFlXEJiaX71mqZW0jt2EfEGRup/2oBcEf?=
 =?us-ascii?Q?wJ/B5NYahnTFws1sBjySb86p/IZZDffWVr/UT0cyzWRJs0M9jwgYNsaGrsG8?=
 =?us-ascii?Q?fpiEtVVnrfg2G5oBsIrmpdXpXmX+VNZ9fLqcoXXNz4GQ/ilzzt3g2L4ThU9s?=
 =?us-ascii?Q?oPXlXp/+lAwD9BmTUNY0qJpmbUyEPhhZaBb1IN4rZMwiZL6IgiiJyaJDO/mZ?=
 =?us-ascii?Q?jNMm1ZKGpJnMNZ887kB08k2+4aWkKX1ifAVnv39xyjTynhnNBRUwGZmQMrh6?=
 =?us-ascii?Q?bZp144jk94CwXB7OOzC3d5xe8OY3C5vO1Ez/9Dz8u9fkoHmOBWC5Kpe3B/Sh?=
 =?us-ascii?Q?ALsnGJb8GX6olDsesc6WwSypd1jMJqbVGI2MVY/GJGQ6XjNQU0TxWRLsQehd?=
 =?us-ascii?Q?3pPP/lPsnAiSP8xbLqQfJRALqQaCmcW/idDt4IU7aDytDu/w/Fw9bbtImKrP?=
 =?us-ascii?Q?x1ydeuYhMqaLm/xXLnnayp1AJzNkFKystFIOUgQS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9d6c09-7fab-48d1-34bf-08db725487e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:39:18.7533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHP9+mPqqJLQ1p0JoUbwm+vwPRLmQyonOkiluFwjtZ3QTLJRmGtUmckUoueCH8mJOqriwu+UrxtTmhBvNM0K2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8725
X-Proofpoint-ORIG-GUID: 74LVcYIQ9S-hd2bhU7ulMqRy5EeY2kcw
X-Proofpoint-GUID: 74LVcYIQ9S-hd2bhU7ulMqRy5EeY2kcw
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
index 084f5e784a..244d00ca74 100644
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
index bc284087f9..846aebd412 100644
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
index af01d54b6f..35a9b67afc 100644
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


