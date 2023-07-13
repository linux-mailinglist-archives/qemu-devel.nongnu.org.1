Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A7751F66
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1A-0002Vv-RY; Thu, 13 Jul 2023 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0t-0002TO-8B
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0m-0003ac-0a
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:31 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4xf1v007647; Thu, 13 Jul 2023 03:57:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9
 yI=; b=jutiz/d6VKTDqDhS1gHSW0nYUFIiRl+jUP6urjUaIRrj3C4//as4utNXO
 sTEzaDlCGtx6DVyrCvfBnsLX0yX1hK71Px4ETKn40HmDQ+iDwd9Xdvsa4y/b6i0V
 T1CCrkbO49KRo7bqq8uHNY1wvNA8zbJblOOBkkTiAHM/yQtwDQoeJXZOJ5lCgGeQ
 SryRhWjp2S0TpYnY8xTUSaqpRqrjsFCHcmzYFRW3cwLFQIwRmp7Nml/4AIOK4Pmg
 it4uFuTzayZbGXkcLLhKvzsQuWwWt52lYqUxftHmoOB9StETiE2F46XbLFW7OAr3
 fmqzKKLqyEvpiIibCa7q2dl1z9W4A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auCll1b4he8TbukuQQTfPpHqeUvskJ47AuHgt7wVuDzr6VsewobwZJGHre55AiAvkgaz9W0iL6RKYU0jGfFdmLEITW7+tDRiBy3veVCLbbvL1RmqJs0JmSWIXyf2nFJEpdDEuvjKe5vo4COeDYaqZIQCTmlqyLeBwkQUyZ044qALgPNr2QyXvvTPagJOoKQr4KjLFaoUymLErMMcq9Kr3XpTK9HMexf7woWJjHks8TZFlGHsR4B9eJZWfyRfztneM00ao118Oq1McAs+/ENrzUfsYHofcfF3KnXCnG4c+0gVrjTKaii21Itmk7ofZDndXonkTCik11fHvuqq79JCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9yI=;
 b=OcJhCpngH64LU8k/80/I6poe0+7CFJ0biZOO31qBVscgcUeUYrVJTzx71lQuruJR6m9t8IE2ZEjzkSqfXsDI7qjdQjuSCgd/R0eQvRoJS+s+9mme1hcKDu+xRz+DdadEOrBLQnEDdsFWmMMu6CiS99FFDhIR6nFIpVph3B1a0mSJzgmVCAD8M8iXc4Eb2CXXaj+8EwMAsTdi15u1lZYFI74kghtijKo3fj1GfZVufR+K+fYOo0KDg4tNejyswUohO6Jg8IGqt0C+fJYRpbRkMe6jwIj5E8xJ2R9g+OR/m/8/OzPmTYObOHo8lcakNqJzh+4nNCaF1QxNhBFrEV+39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9yI=;
 b=Fad0np6sabRn94Vm+07OCrBdKTQ+ZE2EzHUyJfMRaAY3HreUvDlfH/QUN6wlb6mmu9qS4SovQ8Mx0a5H9GCdV8I/HrE10Uj+223wFc1uSldil1ExqO69xIKu7LA6EbvNhFL8qZE15SR3z2JoAZo16/vJYa0j1inPyWBZ/BoqxPWbvyoYbwaDCvxbaOtZfQAN6y7SGEmPAdkYMcJuoTSfoNUFOlsOheCq0DIpfzu+jjTR5WSIPCoI8YDU1ZguJeZCGSaqRnMix7nGjccW7WlB9/TUI6vQpDMHGGUYh1wf9mwX+2ybORDUvrY4IdpoifYmKJDXfm7d6mDZEe231RJNSg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:23 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:23 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 3/9] migration: convert socket backend to accept
 MigrateAddress
Date: Thu, 13 Jul 2023 10:57:07 +0000
Message-Id: <20230713105713.236883-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230713105713.236883-1-het.gala@nutanix.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 271de12f-9b21-4b87-4bd4-08db838ff008
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5ZRxE1oLMMW/zojVNRuET/Um4zKu5GKkDm3K1teAmwjvELuJpx96XYhRtBxbwhLkpN2ffGK6uzBRdXJpYFK5ogG+MNY2zb/43cQzvq2jlM/166hdGgsgOSxtcbS7zB0kZ0Oa4klFechGXrzzDU6PTIbrjSaPTmOlbQXGV9ar56mqQWzTztADsQ8hZBN/YIZeieUEZP1KPO4y7CrLDQC/QNxJLA0LaucFtaJ7XgySJx1gKU+iMGMUJ9cYIFxiw16l8/H/Ijb23NgVxjGO+wJU5QOYYp6Jg7IF3P5ZdSfQTrwcCmriadEEqIWV3KV9MouJ5J99H9yNJpscsOEcULVT8xBKE+dZdIXizT1c08J9z7MVMJ1do0wuYamS942mnSw2toyDGT5Us96lEBvWdNiP/kIAd5y1HeLPTPnejyvtISxQnlGRkLXKwMXRBVf9P+j53AL+CI2gjne4RKra2i3xeTjQzxGWhl1A8nb+G5WvjVFDV3c+ppWciGMkbQZGUfc/FDJlbSEZXj1JAy8C01nPsZbiqZpR1cTJYCIJTwm20wy+ll4/3rzErAHuD30fUtXfIcjthv91ycoXNX4N4SnFRw5FEgB2UuR2VjQW5xGmZUlF8DQmZOkD0oJkFrpgaEm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZiQSGfYaz8gNMkcx1YpUtSNR+v+CdY8xhj2wgxg6WFd+EluLlSe2UndFctnd?=
 =?us-ascii?Q?pg+itj/zs9+CkxWoaEpmcTJk0h0LBIh6UbDJWyrd3WTAc8PzGpapR6T5pAsk?=
 =?us-ascii?Q?iXg/uBuoX8SSTfySE9Hsj6Uv3WrUtL5FOQm9v2cZjvo5cP9yAQX1NbCwgNmW?=
 =?us-ascii?Q?wevGVhIj8NTakGx2l5/hgD3Cizl5Ij5ebkNCEyeudU+W6FirP4i3Q9up6CRv?=
 =?us-ascii?Q?DbIQ/8JQfs2xZl7/7cwzNDrYeLykMq4CiqZVb3wRvM1sX6qVydCezKYas0Jm?=
 =?us-ascii?Q?3ztyv9DVLAwYCbaH2DuKb7v2eKVW4sBqd9vmYKHf0jV1dKFcc+JGRHbwAFu1?=
 =?us-ascii?Q?bHdVd1BzHOlgjSkdo4QIFdLTA2jbCnPQw26H9syOga4V1G+oprjeIidt6Kf5?=
 =?us-ascii?Q?9/qtD4lavsokDoduhhPn19ayvA+M3t7qrcO9RFOkt08mUDMfWSgfdMJ81aL6?=
 =?us-ascii?Q?5uqe8k3kx8/37FNj6RSBf+pFf5pAIBR1GKaT1i1mZZSc8dZ3eLMfSRZoeznA?=
 =?us-ascii?Q?6P4D71O1MHStrMWi3vGkaYUdStyypcGGuKtfBjKKeurIi0Eaaxs5m3R5gK8y?=
 =?us-ascii?Q?2mvdYI40PCjL7koin/phSIg42Lgvwa46aoIwwl8Ne/Y9gZNnnAVxxzpdzdQk?=
 =?us-ascii?Q?K2dqfUvRGAr877FoNSGLL+NoTHvT6uy822YC4TdKHUDTN6fDYog+mf/eZXok?=
 =?us-ascii?Q?Lh3jJUv4sL5TWLIdXnCoXRYhK86a21zSczrgYSN7rFxGkcXrIhmCzEty8yn7?=
 =?us-ascii?Q?IQiOtTArvF3NLE38n57TqK4yNUzQ2+MTYB0mdzQum50DR2S3f7KYrs44yCGx?=
 =?us-ascii?Q?RMyh01X5rV32MiCeL4nHHOb2fNkf9FpiVzWLr+EYeT/7Rw1VQUeHB0rIeI5E?=
 =?us-ascii?Q?JOrd7DedeWONyWZcKpwf+nkERYGoOUkTEIcdbhr/6ly19P9hIyS4p0uvI2kb?=
 =?us-ascii?Q?AoOp4ddfr217lw2UxDmIj+6/2KZms4/IQa8G+2/owPbddHyDWW+HouYOWEnG?=
 =?us-ascii?Q?lDyvsAFI2Ki8JJL2jXQJq1kocY1pvv+trnah3mXaDpl2OIpEtrJyFMkq1BQr?=
 =?us-ascii?Q?sJqFoE9k6ub3rTBq4ygjXkvjQ5zHjhkqZruz4fOsjiyy4g29cxYFSSs05D3N?=
 =?us-ascii?Q?l+Jc390VfK/hDkUZxpWq7s3kQeUVI5BIYFbibUiolAIo3k+Xvmleorr8X1nK?=
 =?us-ascii?Q?Z64i7hfHRJ9Mn4jaSfnkD4TBqGe59G3PkmgZyITRpc+RInASmKvcRd8ZAhQ2?=
 =?us-ascii?Q?mUZSWw7pMONaKX5zkNMk6AyDJenLxl93PXkW9L3v8tjr5GcRUVkpJAPP59Gy?=
 =?us-ascii?Q?0wB1KU95iNgAjGur5TYaKb8+pbgQhY+u+uJRnXLF+cCT7JjAdp9GfDsgDq+C?=
 =?us-ascii?Q?LARcd2Lt1LWsmX7oqX6sm0wR7HjulNF4/PjFU8CQs+Il42Kq4TCB7MibEINH?=
 =?us-ascii?Q?G7Ug+A21DzJGVp10vx1MybWWpY58EYrukCPq9d13+bpL7Nzo3NRRnhl4wIEn?=
 =?us-ascii?Q?TxL0jDF1KIkPoFK6O0we0dVKmn9Lp6pi7RXjq9zF/RtcZLf97KqWKRLRayoB?=
 =?us-ascii?Q?8VpuCoq9JZdOFKAgP1Ae6fku+8iMxkRFzEIGetXSKcY891eK+dIR4ZqYGGzu?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271de12f-9b21-4b87-4bd4-08db838ff008
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:23.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxLqMcPcj8bUy3WUN7U9kuYOiBGl0GB+BeYlaW5gnF18ymi5Y6Gpp5IHXgZ85BLI8RzehFlV4cxGikSvyP1ERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: gSxbnfd3Tkqvv-MziHYx-rsfOgf3ewSg
X-Proofpoint-ORIG-GUID: gSxbnfd3Tkqvv-MziHYx-rsfOgf3ewSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 32 +++++++++++++++++++-------------
 migration/socket.c    | 34 +++++-----------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index af2ec50061..8108d4248f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -480,18 +480,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1697,7 +1700,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, &local_err)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
@@ -1714,18 +1717,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..8e7430b266 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -108,10 +108,9 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
@@ -135,18 +134,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +159,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +199,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
-- 
2.22.3


