Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666B709400
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwhE-0000DV-D5; Fri, 19 May 2023 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh3-0000BI-Dm
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh1-0008SN-8h
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:37 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J2pJKn002052; Fri, 19 May 2023 02:46:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=nDdoYy/t0hOZ081DVTBqbp7lBYMx5Z4qe0SmmVB4zIY=;
 b=SBL4b0HoP4vWNqI+lm/IfjEpgEzZkuvi9W64lTTYo6pm8oBcponZetzKy0aMNri3DXKe
 jH8vhzPXgdvVqD38F52cVMB7J3O6vNbgXotIrgK9ZIWOhTw30lPb7lUm2O6JWZ4vuMss
 OhoOOxRgmkCVm4PrGC9bugE1rxFX3SXf+Fa6bHImx+2Btl6qj3ZctOdGRuyyUCJ43KPQ
 EhtV5aiGLJUEVrKSXDsfQHvpHd0dZBIBejVIr75zBlxXSRsgV+/KULgc8NAaum6TUwAY
 1A8+62CuBGcf1HyV8bko0EJGzhqSkIB+n3LkrWgRZRFAFwwVtVnCSB+GmF5peujPPBQB Kw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw4fna3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKtbrpcYat+6aNyKm7FHhjfxXMzUe9Pt3+mwO1XmFK/bIaHqA+42ebD5IGymnNkiqIMhcClr0DC5A4vbnAsgYPvpxARsSqTG4QjL8RtmJK47UI6/m4m03hlkQq2S1oBS8EokPnCTkixNeHk7u58iLjwpHrKlzkRUvtv+pHcH2vY7s6fchZhxz888vo30QQeqhEkRY7vmjnlmFaCUYCIOXSyWxnGhFI/DrSsWMdesmAFJVg0DCHTUmZ/yzgrvWjbicHwc5oc0uUo5KkoKVXwk6yE7BAM9rVklzN+IiC0zTd89krh/VroKSjGuP1QrSgPF9GXU5ieKp6vxDM/TOS28WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDdoYy/t0hOZ081DVTBqbp7lBYMx5Z4qe0SmmVB4zIY=;
 b=VFaKhx4qF8+oDSc8VAIxQhoC8gVBYZuBzay3uS1Y2EUTaZnzrOpfQlvufsNPpA1RIgHur6D9bn5hChsa2pEKv5iO/B2aPyPs8UYX1sZg7vryheits5MupEOewjPFK2siDaQbvIQ6diivFRfcjQQIITA7sK0B7tY7AxLY28KBNEwvUSlOz2181ntJOcNQl62y8QtAMLOh+Y6GJy8ZukpDrCBipviB+Gt3H8LfLDVHpMZ7Xt1RJmwO2xm0GVe82Y9rmCWUtjuC5sLzwbJxd/xWT3ZdQRXAYEtzODebuAKzKnmDJ1tiAw6xStqEwqTbpzrqnFOXLIh0WBmGmd/PQkeHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDdoYy/t0hOZ081DVTBqbp7lBYMx5Z4qe0SmmVB4zIY=;
 b=cpdMWxjzgLeE9kbiyXK88Lib+3GD3DlQbT71KvqDlI75Y66QZow50a8b0H4YyjwecUEqqMZ+h9ecLgDu+Ma1S9+b0f3c37f3nlrWcUhRDT9lpguofetJnCtljUsSL2l26uYTw1HEmfWMOfYupMG6Yaj9Kmq8T1lpejTmcwJEaoJpXkzzBrQhDPYIei64zld7m2vh0qfSgHNGooT+l/JpZxLlMvSNgPZ08hXWE19kv3mntGojX27ygpiJVCW8ftJNzeBLBr19xHewLLqL+RzR2BdyUQT34vg1mSl+hMEphDCvTsn89s6f91Eu5rFZXIlha95d1bZUjqy75D0h5ViPbA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:32 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
Date: Fri, 19 May 2023 09:46:14 +0000
Message-Id: <20230519094617.7078-7-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230519094617.7078-1-het.gala@nutanix.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 97470706-bc40-41de-058c-08db584ded28
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjBrWHG5YkxbmBkKJtgS1vxEyF8cq9lznbpT2ibqDsUkPhUew1BOF2P1pZtrn3e4egGIKeIxUIuLHS9UqE3pPXlIqQFA7X1OfMTASc3YYtrAmnColQbd1DIg0Y7I2meNOP1Oe2vv7q6n2/34gPONO2v7xTJ9qBxZoXT8x3qqSq3U5jmmZKEpIglNCxv+YFFiTdRX4eHEaUjIQXcbw3R+6z+QbYqwMJ/LdUTy7WGh8Cd55MOvzViMIgWFXGA+jiJpmlosUsTjyTugzcRFywMJFi2Z6yxEgsTr0WRb+lZBn/REwwVr5qsAJk6knQqsToxdySoeWDTd02j/V/9ZttOKbuKVC3EP0g8UqSKCIvAadS9T8UKBoA4L5l30HozSuLC/IIjwY+c+/Sc0KVrKVc/hxeaVrgyCf4WsFJwb2rPM85Le7KA7WLudz1Yisqz+vkmuZeBxmdtLju9X+/1TZmH/9YjLob5fXsJbliTbfXywtPn7rWjLPqgu5soNIyqIycaePVhp9owhHdCP6jTfD7Xe4UKHrIf/VYJi6V3zOGTbSAMcQlKcQYvrGGIKBgr4oiUvTcvgqn9V6xGIlkyrllKLubsOVVvzIzy8iwBh61pwbxrm/SpgGIw/DYWgalNAhakNNVxXEFqFZNIU86K6MMcGMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1OFSKPGZHEwBlXhbyl1kwNCzTkHSAHsjyjyYjpP0zIkdt6kAzHJTMpZTy0El?=
 =?us-ascii?Q?aM0H2MoNMUiTgd2cvsf9bxt/7T34mrjp3g1+1QRuMBDUPGtZXlU73GpQSCoL?=
 =?us-ascii?Q?wYANtf9gld8fceYebYzIyPEn19Vlo58oN7PHGB5Vjx31nEZNVD31I37QcHRm?=
 =?us-ascii?Q?I0MrZ5Jib2vvPjvc96Exuuf5n3Io9gzwX17Y6LDFgOjKoemzu629q0QQtz9R?=
 =?us-ascii?Q?yUbWyWsX9Jt/8gh2oQv4mQVTp8o3thlhWT9d0lQzZXxmlwX8CZPGVM5/7rd8?=
 =?us-ascii?Q?5Hp4Y06FaK2JNqpNDm+bRWoARpxD7+faJIewnKa9fIPdFodd86zfdKiCY2V0?=
 =?us-ascii?Q?av7nwExLHh9xuVq8l4pof2oAEWsLKbYe0Bd7bNgeCmsh4OeCLY2WmA73PV5h?=
 =?us-ascii?Q?6II5mIJGpqw9KGuP6aHve54LC3wr4uOZqX4KGRgbrGlj+aT5SQlSfbVvaANC?=
 =?us-ascii?Q?e/JA/AL3Z2nd5itkxxFueAhGOi9deIEJ1+XzrfFzROemk8Scqd0a3auam2eT?=
 =?us-ascii?Q?Zp4oKBN4pS0CaDXEqOMc9icHpCLbRH96CLncQwaztA2Il8pXvAxNp6YY8vIh?=
 =?us-ascii?Q?tncKeMHOOpQdCAxLrIEeKjbro++c+6T0dc7ZZ7c6PvSKjb8nrOSt2fHDO3Oq?=
 =?us-ascii?Q?aciK2x6q8HovvzszPF9yLYtI4TByB3qq+Gw3wfthR9UccrtoAx0i54jTwoB9?=
 =?us-ascii?Q?hODaoI0ILZIs8UPFldXBbaTNEyYZjHdAZVeWMvYcLVe5Y++Xys6yHi3Ytc+Z?=
 =?us-ascii?Q?uaX5K5yVTraa67/nKblO3TyOcnslnE4yi/MSVanrf+jtBQ75Q+DXkxJOXqMF?=
 =?us-ascii?Q?3Mg238qAbtE/Le9QJV/zAVxw5UhRPtn4K7vKHiPEHLLqjAJKaAP8zRmDj7pW?=
 =?us-ascii?Q?2x6uE8a1PxKJzNObJW4UM11OP8QNBSeK0diEv3WDiufwY3Eb48x2G5LKpzvQ?=
 =?us-ascii?Q?ya4eJ4PsE5s5RhZ8CRqMiTDNIwm/fL0PuEatvjep4uhqwa88GtQBr1ry0+k/?=
 =?us-ascii?Q?AMJkf5kyC6YiZSUsGVOADFxuexbh/jWssUl051pZxIMR/1TPdItj9hYDdree?=
 =?us-ascii?Q?pirG4YWvDlCQS7Ac3DlUelM91g5+yXC689VxslVJj3T/WxmsWwoJeJC1tMWp?=
 =?us-ascii?Q?35zaqd9yPm8rd6H547M3KbqBxqk0OapDO7rOx7hHCr3/NLKz0V3zvKj/ldGC?=
 =?us-ascii?Q?ip+ndOYdBN4tF1AEUbJcQbyViN0U2XgrFN+mcrFi1hRTO92MowVixjqDV3Sf?=
 =?us-ascii?Q?UovvULBuiUAF0yIxu6W72P0JM2XoQ+OsX1vxQRQetzf56JEDkf++R7dYQxHU?=
 =?us-ascii?Q?q3xPGwccUZHM/5yc+KLyhImrEggzMnwCZKsa4o4OMRp7SE6TkrX5kSAtQ0kG?=
 =?us-ascii?Q?UY/bGHtmbNiNhu/KpPTaCxJmCm0GB9De/jzMcnqWQRqBRoinplXEoefog3/6?=
 =?us-ascii?Q?JeZ7Rb65meiKaRkJhQW8iQYY/uSrVihZQEMWn3BGSyGEn49Z7Q750jNpMv9b?=
 =?us-ascii?Q?JIFgIeKT8aRwm3f0Qb7iRqh3499Lwn9w1tNzlVaq1gkWml2Ix4/+NU3MR4g+?=
 =?us-ascii?Q?dog4tKNjEkkGm+G+qev8TTW8GLJ/rv3u+yN1X41ylSvzqeQNPvZD66K7tzBU?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97470706-bc40-41de-058c-08db584ded28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:31.9988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEyE56kGxGn0l7rU/dzp8WK9HVR6haRRglmblt2/a45IVIU+7D4porimO5H1nb7YZztmt8NmIpkwt8tmDFcPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: lk28twIj2DWmd25lI_ujmQBkmT6f_-PN
X-Proofpoint-GUID: lk28twIj2DWmd25lI_ujmQBkmT6f_-PN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

MigrateChannelList allows to connect accross multiple interfaces. Added
MigrateChannelList struct as argument to migration QAPIs.

Future patchset series plans to include multiple MigrateChannels
for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
is the preferred choice of argument over 'MigrateChannel' and making
migration QAPIs future proof.

For current patchset series, have limited the size of the list to single
element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration-hmp-cmds.c |  16 +++--
 migration/migration.c          |  38 +++++++++---
 qapi/migration.json            | 104 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 144 insertions(+), 16 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..8ddfa258ad 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -423,10 +423,12 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrateChannelList *caps = NULL;
+    g_autoptr(MigrateChannel) channel = g_new0(MigrateChannel, 1);
 
-    qmp_migrate_incoming(uri, &err);
-
-    hmp_handle_error(mon, err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate_incoming(uri, false, caps, &err);
+    qapi_free_MigrateChannelList(caps);
 }
 
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
@@ -704,9 +706,13 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrateChannelList *caps = NULL;
+    g_autoptr(MigrateChannel) channel = g_new0(MigrateChannel, 1);
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate(uri, false, caps, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
+    qapi_free_MigrateChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 0a6ab9229b..abccc6bf26 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -463,10 +463,22 @@ static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrateChannelList *channels,
+                                          Error **errp)
 {
     g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1488,7 +1500,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrateChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1506,7 +1519,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1542,7 +1555,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1675,14 +1688,25 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
-                 bool has_inc, bool inc, bool has_detach, bool detach,
-                 bool has_resume, bool resume, Error **errp)
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrateChannelList *channels, bool has_blk, bool blk,
+                 bool has_inc, bool inc, bool has_detach,
+                 bool detach, bool has_resume, bool resume, Error **errp)
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index c500744bb7..86bbc916d1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1448,12 +1448,47 @@
     'exec': 'MigrateExecCommand',
     'rdma': 'InetSocketAddress' } }
 
+##
+# @MigrateChannelType:
+#
+# The supported options for migration channel type requests
+#
+# @main: Support request for main outbound migration control channel
+#
+# Since 8.1
+##
+{ 'enum': 'MigrateChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrateChannel:
+#
+# Information regarding migration Channel-type for transferring packets,
+# source and corresponding destination interface for socket connection
+# and number of multifd channels over the interface.
+#
+# @channeltype: Name of Channel type for transfering packet information
+#
+# @addr: Information regarding migration parameters of destination interface
+#
+# Since 8.1
+##
+{ 'struct': 'MigrateChannel',
+  'data': {
+       'channeltype': 'MigrateChannelType',
+       'addr': 'MigrateAddress' } }
+
 ##
 # @migrate:
 #
 # Migrates the current running guest to another Virtual Machine.
 #
 # @uri: the Uniform Resource Identifier of the destination VM
+#       for migration thread
+#
+# @channels: Struct containing list of migration channel types, with all
+#            the information regarding destination interfaces required for
+#            initiating a migration stream.
 #
 # @blk: do block migration (full disk copy)
 #
@@ -1479,14 +1514,44 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of default
+#    destination VM. This connection will be bound to default network
+#
+# 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
+#    of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "socket", "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrateChannel' ], '*blk': 'bool',
+           '*inc': 'bool', '*detach': 'bool', '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1497,6 +1562,10 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: Struct containing list of migration channel types, with all
+#            the information regarding destination interfaces required for
+#            initiating a migration stream.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1512,13 +1581,42 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 4. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
+#    of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "socket", "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channeltype": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrateChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6c2427262b..ade411eb4f 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2633,7 +2633,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.22.3


