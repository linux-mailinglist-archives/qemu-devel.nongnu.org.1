Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E37093FF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwhg-0000E7-Jl; Fri, 19 May 2023 05:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh4-0000By-CI
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh2-0008SW-Li
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:38 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J2p4Rw000994; Fri, 19 May 2023 02:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=CL1UKJsalFSKxW2mgL7YEqL+z4e/qcEiAXPCnFWtC58=;
 b=HAXpbx3aLfAazqUvQs7+vIToq5LQkUQwPpvLUzZI/8ABmglWxaui8WXiSluKLDZmu4tv
 CTSWW4/9u46Nm2T54Lbgliu7HiF9KtjAkNe9PHYJ/8ugrQmGMxbQKjtZn53WDjHBbRLc
 fYvyDq/WUxjSu+xZMLXfqwVgIGWi3LOz3sJrWij7L+N3gqIIzm5wUeWYN/1YFI92JoSY
 qCi8ousWe/3rpzB3WfiPghU3ttWGReMCuzE8/5QwHh/53p+Cq66CdR+HpnLcVOgMeygP
 vOPH/gLKdj/1sQK++GfxbQTP7hbhHOX9jz9F1Zur2l/i25Fh8qB6IXZguUZ9IfQPu8iG SA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmvu7dbmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkGokfEQ+MUU3fI7RXQCfa7usQ12QiC26G7uwO9hhlWvVoGUBaAC2mkUAA7HESQMuMGkkGoTKITP0UnvinOFiuokWG95THVnsrbt6rgA94iWLHRA6vaHvoys4cz751Q0/1WzdawarFlbAqBIiL6DBp1WNYmOGt8XTUfAXflp1NEb9QWJ7u/2ZC9NnLH8M11cR2lO/k+uZFxK5lSYCDwGPc/lezEtio6KyqPYQR7sxEDgmqA+lBWOZqBQq5xIKwknLSBM/8YDq2qFzodROHsjPzIGzEQPVwnYUs/a7VnkbUvBTQR8ujp+qNnc/jcl3ivpk9DLEMWwhMRlwsx37EwB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL1UKJsalFSKxW2mgL7YEqL+z4e/qcEiAXPCnFWtC58=;
 b=lo7cHCZ1Ks4wH5lhmPNipEshJ7ac6fF0fjrrE1e/w4J9OMQEHxwjh1KNXVBWMqGhpTFMD6UfSVdL1/n7QO5H+DNbeBXI1m82dVsBWNYs+KdooL0te2hu5oexCbK2ptTeXYXa4ooFN4frNe5y0HruT1UBjLEH7+BjIjWxI/LsSWvScR/CmC2W9i7eDyk8lgrX6lIdVo2RkVdTwwGzP18PRHAiR5ykjL8CV9smCEPVfcbx29QAb839KMXqWvntIk+i6zKs/Rl4XvKT1YEvcqB8nUQY6p0LQybe1oQ24pqm2wqscfFMleHEpwOOg+61dIBixwGqb1Vwd/Z7ltImVR5LMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL1UKJsalFSKxW2mgL7YEqL+z4e/qcEiAXPCnFWtC58=;
 b=cipLW7r4vRFgZfdkJMFFm9ZGHns+jGPkELTaXCRnc0P3htDBlacv0943OAMrS6kt9ukle2y5pOhuj5duPFyCC8jX7bWwJL8BwkHhHDFzm9zAI1WQx8utTDIfpaJS1ZhKlesZlUxa5uyLdTFQIxP6rqL2Fe2J7aFKVLuTtQOu7pUtgukSLqDKLkvDsmLPbg4hkB2HJLsZ9joLyXTMZ51wRcyfmfQighOTcGX+pH5R9e8y97t+heAQYwciDqSOsih4JZ3nvdPcPmKDs2N23fvbcqiWMLpfchV0SvzHllSJ6JkB2ZCR/OvOlTub7vV8aJeJ+NkY0TiooGtH/jeF8BkIgw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:33 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:33 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 7/9] migration: modify
 migration_channels_and_uri_compatible() to incorporate newer migration QAPI
 syntax
Date: Fri, 19 May 2023 09:46:15 +0000
Message-Id: <20230519094617.7078-8-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c089761-6159-4bee-a55c-08db584dee30
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDFSMCRdux8bcTQB4JH5F21SHBBXFMB4cgkMy/pagl2ERDfZf9b4AAPbqcs4SFolhrM7petWu834gmrdKGRuUsHJLJHC88y6MN2uV76rrwkE9M+QIvpB05Bp51ckeSczxehSZNyaoALp+WIA44YVwz7z7z/Ap1c3gm9sfUAc+eW5mUFeaIW6YLKqXBWC5HTx3QDYnIO26mjtFchMczsA2l00hWy4LtGizTNtHf2NZK3XSj9+WkJPp1b5wpgg3TCEYZHn36SSg0g2iMwgqt/4Bcs80/uBpTC3vgLlhOr2Mpgh60yeVB38DhWU9lHaoOdluPWJJ6Zhdl5jV8x4xqvBUJTN93VAjN61XeKjjS0p3e5eVEgw7dHNH+DmxmPUjk/6AqrVUDhnQU+20Bxla4eVHJUZK6/jgU0eLYiCplWiVdDuBi3TEEiFtm39Azys41JRWqTetCS4a8GJn4JxvT9HpSgw8KZj7pBbgNDMgT2GqOo34bUvsFOSmUP7jjMkgdLWoe7OK67a5o7Nc8xvEYz+bd0yjWlkFPMA4M6x1n0zn0gLBRVE8c89RUA9xMMnDLEidNyd3SAqZPUpqTemhNABTqHoFYKLYnsait7cgJjRJEtxoYgDmoTCh7GVRNi1Cs2C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SsaZrEtZgkTVaflv/RVuO592iRJygVz+e7o+4M6n278NTdqpzr7XwDy5UL05?=
 =?us-ascii?Q?tj4A6faL94o/dQ5i1fkelNWgJNlLihjDlVcbC/DjXWTW6lhIUzCQrEAyfhQC?=
 =?us-ascii?Q?H0Ep77KE/DVCJR+hPBZnHSyMdQJZmhfjlaM7e8vSluy/hpDRQDuBKcxlWtJT?=
 =?us-ascii?Q?tKpSH0EExcR+hjP58TNQSU+0r7H2SaAP5EN6vrhPXjjqhFyH8Xr1vfLCjNIo?=
 =?us-ascii?Q?bc61vOZ6M0uNToddTWQKwp5V8fEIuML0NJbiF+qwO7yH3NEFU5vbVI6wX0yl?=
 =?us-ascii?Q?APAIZVlK3CCQNMbp+AQsm5ZtzTwn5FmllRxgGPlkj4P28Usbm490p+ibTDb5?=
 =?us-ascii?Q?ueHQxmVcITtn44j/9ES+H2dKRn+LSmIL3MSsv11DlYFNJTBmhiJkL2iJqany?=
 =?us-ascii?Q?jrpgWG90dHcmS3J+4qm87ZHZthSd1tFUSA4y+82lbA718fmXsogrkR7zH80x?=
 =?us-ascii?Q?F8RcrA+pzjrEzvAXZCUP6NtVz1EScBpzNEci6jQb2rYuJG+x1Q1NGCwvJ1oJ?=
 =?us-ascii?Q?NeEDVR4Ou8k0/bzBZpTUaAe64SHxD0D+0B59eympRGhP5niftfjcPyywx0fg?=
 =?us-ascii?Q?R1wodbb15cFa/SkmEMzU/jObS8ZnX4iM/GgjZAYfnlZ3WDVgKbG8bqrNlanE?=
 =?us-ascii?Q?X2WXlzm+V3rUxyuXj7ayLJ5Rmsq0OjFtQtdCOJpx4QUsT+du6C5D87ZvsODT?=
 =?us-ascii?Q?9Xp51DEQpq7JoKf8vchiKjipg0/EXANQRBfJv1+28lCWgUc1+TYx9rwBpEeV?=
 =?us-ascii?Q?4k4rGoBEVBmO26BcRzcLo+O3jkVTpLO/Hm0lnTK1frY7j7ILNG1pohujWsFo?=
 =?us-ascii?Q?lKX7BviIJLachFOGltKGv0tmL5po0Zj9CfitmMRYYT6Cv+1pjcHrTfzSKvnt?=
 =?us-ascii?Q?6GZIkfiIIi+6o8+E7u6ubPeRa+VVRwElzt9P5eSjFdW+lv7uzTIgpe5DAh1L?=
 =?us-ascii?Q?uHk8FHTbT1+Z5umdmazjccwTz2StloXc001Z05fQ9dYPCx7noONHsaG+BPsf?=
 =?us-ascii?Q?CIzy1YQcymUIEdIOFGFW+fPg4w37mqionK4ONyHpjd+4tyNW5VRY366i+gQf?=
 =?us-ascii?Q?bAvuVM0Oj3KyaQgVcPPd9UDqDU9wgmFvmUYbUM3k83QUbGTj9uQ/3dFohGC/?=
 =?us-ascii?Q?etCTE86Fp65APtlgf4pt87BvHKNr21IRME76TaTI52aCBVLjpEBYJQ2VMZre?=
 =?us-ascii?Q?5cfEyg5peKCaz6YEtQsZxbfvtTMx9qiETtpsVwlZPvYnpSoBQdgc47ZmoIY2?=
 =?us-ascii?Q?LS1KJHTFyPiwP2IMwfr5+Y+3b2Fp5ftMnZ9JHXQScYzQOjjQKL5YrDV9WIMe?=
 =?us-ascii?Q?kRlqaePbVIoSJo+eWw1uY0e0QEtaVaZ2TayKBayAp66Sw2PsBWOwYwtcsm3T?=
 =?us-ascii?Q?IgcLG3lmSuzUSIrup+kS+Z7Iwd/1YDjuI8O3qwjRZadJa4MvGoXYNCKM76ic?=
 =?us-ascii?Q?/WZPVmyqxwhn5WQ9GE3HKzRrDifY0+FwW4tZK5aZOBv2QRCshlDDzp9Z6GQK?=
 =?us-ascii?Q?fspV2A/xi95mCpJe+fyiHKXZH3hTG8moIroUMzirEaMhEEL6O/PzOeXXc+S5?=
 =?us-ascii?Q?+xcg4224uPRqqtVJX9I29YfOUN9M01ilzSQX4D5n?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c089761-6159-4bee-a55c-08db584dee30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:33.7277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNZ74nu+ah8ve/dGIlyNJGPSAmNa2HDaU9Hh3ImRfWkgEYQrEtEvk8aT0wRE/Ow0cuPInlkbhiZDkkkc0HGirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: 9TDzAZKN9cbwS5gKyZDTUL6GJaXbRSz7
X-Proofpoint-GUID: 9TDzAZKN9cbwS5gKyZDTUL6GJaXbRSz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
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

migration_channels_and_uri_compatible() check for transport mechanism
suitable for multifd migration gets executed when the caller calls old
uri syntax. It needs it to be run when using the mordern MigrateCHannel
QAPI syntax too.

After URI -> 'MigrateChannel' object conversion,
migration_channels_and_uri_compatible() ->
migration_channels_and_transport_compatible() passes object as argument
and checks for valid transport mechanism.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index abccc6bf26..8afdea4f91 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -103,17 +103,20 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool uri_supports_multi_channels(const char *uri)
+static bool transport_supports_multi_channels(SocketAddress *saddr)
 {
-    return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
-           strstart(uri, "vsock:", NULL);
+    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
 }
 
 static bool
-migration_channels_and_uri_compatible(const char *uri, Error **errp)
+migration_channels_and_transport_compatible(MigrateAddress *addrs,
+                                            Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        !uri_supports_multi_channels(uri)) {
+        (addrs->transport == MIGRATE_TRANSPORT_SOCKET) &&
+        !transport_supports_multi_channels(&addrs->u.socket)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
@@ -479,12 +482,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
@@ -1707,12 +1710,12 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
-- 
2.22.3


