Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A574D578
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0G-0008PA-SA; Mon, 10 Jul 2023 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq09-0008KQ-RG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq07-0000mD-4I
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6feiG020935; Mon, 10 Jul 2023 05:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9
 yI=; b=uoiwHHPWaSLXnpn+UXJYEGRTzZ9gLr2krHwhYeQCJW3RT7xIAPUr+RS3u
 vbNuA5YxjAHU0eVPpYjknCJGT4WInpRLsC0vu5md/K6oZzV388m8yALv2OHeoeBW
 Rr2FVgNI+7ob4JWzN9ydKLCaiYfEb8nCosD+E/zet9vAvuE0ChNJ7aOi86C8z23w
 E6sY3jWjnya26SZyPSQejR+f3azKDAphig7k8UNskXiCQhBsTLNaMxUjtermMuN/
 tbMFec8u1nC7bQ47KrZ8ndhMt0mogcys7MKf4QLoVgNrG2e4BC1Fg9lgWUB5ilqo
 cdpKXOPA+wDNyLo95kb/WsM2ZqCEQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7awaxxh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwmUWoY4EmtNFzwufm6FdY87CJyjgojJBcIF9uD3by6eb1YlEYocASogXNHTerUUO0P8mVK0tl5z62qyBI5WgKzf46jKk7iaBmRSSZLyEDgJIjc+1tLtHqtsRiht1UvCxm33zPVIOGtEVxB1j77TAb4onq8b+ZUMzvyq+Zv3Kfjo00VLnDLQyn6WHtRolAE2374Vacd0aWAlLv4dXZ1453OBLeykx997fSvAmKSsPttnjpJanpLclnK6+Cb0clzjl/Ce9yzGa5U5MZZute5yVXrtGMI9sjSkNGkkxdwDW+tdNn20dexEv75RYXWnDaF+tXqw0m1qagf95LNeMIz4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9yI=;
 b=dQEvaSm+zFOpxOj6W7HdcH7o5be7nodrSwQ/X8o0TAiUN15pTD2uwI6LDjFTGkCaLwK5kDKfhRS6GG0FVeyKEaXuyTsm9u6Q9tXHHt0a/4BEn2ZkqRszc27G3+riYiGENylNtJX5hKVR3H1qAqH1k65KeubxNy7MQdt7FfxoS9aK/NI0Qf4ZoxupVU+d19hz0Fxar+pdJATYnY3qj0OaiJ/JzHPK56DEXvFdpCMEK77xEHVwgKAmM8m5EoJTVCYC86LGb9enMSEn+xLtC5OQO1ILD56XgdBk2S5uIprNWei/HIC593O+zVh5qTupoEOIiWOjSX+nGC/Ve/yB4+lbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeDi+b0ZZWKX5mKEfvo36KjkLu9vTDbr6zhVX4Ev9yI=;
 b=g/7KmUxwmi5vGPX6Rbxzy5akEnmJl6c8v06+Fj3j9van/bgYEkIsP4mzKOqlur1DSlSqlWSRD6C33eb5faSt6rozkVChcoCREJ4A4US43PdxyU2c/vaBkxFt8srsUcy9ohOO7y/blMJ8WhtYhhCOe8b/7O2bbDZQwJq2o1OehBMdIbl+TwbjJd0KevPOKMWGOiXMps8c0DiIvUfcd9g5oC2Wtz8Ww3/nlXGpgFv4lKivzDc+wi64M2Cclr9oq0Eior+rrQNcey/OoxgUalIeb52wbwSvXU992kLgWclsolIuuAsqxWWkZsYCwp2HUgVk6YuSwfNveuzIERSPcF3Aiw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MW6PR02MB9934.namprd02.prod.outlook.com (2603:10b6:303:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Mon, 10 Jul
 2023 12:28:13 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:13 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 3/9] migration: convert socket backend to accept
 MigrateAddress struct
Date: Mon, 10 Jul 2023 12:27:44 +0000
Message-Id: <20230710122750.69194-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230710122750.69194-1-het.gala@nutanix.com>
References: <20230710122750.69194-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MW6PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5162cd-fd94-494c-bdb9-08db81412121
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWACG4ph5VisOyf9BPrwNGq9v/GWe6p29Pskf5hbZVlk09bviMA+2Pe7klkjUUv2vf4opNgo1G9YHg3H30mKGB2Xk7luhHKjdJlhqkJHgY0m4XMgd4QJY3TGzgruT+CZNwQIUofkxkeyMYYbgtEkzXVUDRDrZut0e3iG3h+EcLGiljV1y7L2hS2UOeULkH505NLQhCp1UKmhxdaI5FRvIHFlwK1GKZNI9WDY5nABMbXMTnumGiGX3WkNuvEtnVWoN1m+cttPDmNqlapm6eOx2LvOJMXUQFsVSgeaPWyRxW40AD7bwLthYe8v8BHAIf+P4PZGYyjPQXYP+MdyI4POyz0I9sZlu/PcwWwtFpZhH1fJ1hIYlMr75CGltwFvLADZxfMlt0Sevjk2osLurPq3r2hlQoSeByPf2/Q/cUX3rcM84h72xX8ixCD5IrVy6VYfAquIhKIbHEEesicNaAYqu39JKCyM3YiXi3x4YWg0zJ7J0MX61UZWu7x2fcO+WJDpjI++H4ckn5HLTi3WyxKk2Nttb8TCe5TQhEs9AzV9tGd7b2Qpb/qk5fIx7powloPgsGcuT5fB7HwaamyvSq/aXJcUZBOBx0Qbs7Wdls1wTdbbtXMhRAjJ8fF0Gzfiosap
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(38350700002)(5660300002)(66476007)(8936002)(8676002)(44832011)(83380400001)(38100700002)(66946007)(66556008)(36756003)(2906002)(478600001)(6916009)(86362001)(4326008)(41300700001)(316002)(6666004)(6512007)(6486002)(1076003)(52116002)(186003)(6506007)(107886003)(26005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2knWZq9JA5WO0h6NjQBgd4wT3ydc1sw5YWidYQDZRsxkEDoLgLHlWtLduzn?=
 =?us-ascii?Q?qzUvEDtxlcwUpgZxUAniACdDrrvESSHpX7c8nre9ZGiLgImrWSRJo3W7THUf?=
 =?us-ascii?Q?j4kuZS4tlcK5W9rs7wzmTdDD/cpk1WB9ldX8H/KPp9G/mmX9l3DVgnWfVwh8?=
 =?us-ascii?Q?5mTpDYQ798o5Esu1sA8TRBGv5Af9uTi4EwOedn3sPhXwkPRk791+zbkpxTZG?=
 =?us-ascii?Q?fS+vi94SrMPqaET8GAaTacnFCpVPY1gttAmmRI8l7yk/VLN2vkhsrdjOrweh?=
 =?us-ascii?Q?EnaCZkkIw7j+hlBci+CJS6Z8pO461ZWg/cdHGS6BaBMA73ECXaAsiheIm3AM?=
 =?us-ascii?Q?fmwNUo/QOEqfkLLOY9LBc7ErgZwew8zZa+QgHTiFnxsknh9WkGzIzPOj4itE?=
 =?us-ascii?Q?tySILJFyfQPrzQWLK3pAjqZrQQO4w6HJQ+E15FxFaw31Sg6A9MvWbPAIrC8I?=
 =?us-ascii?Q?iQzbAUbyY5nYFGJI3o38qDpqHDCjW1TiAEQeSs58PNwNAXKd/ngxqyA0Flt7?=
 =?us-ascii?Q?4pYnvFKwrncVcKmfLqBl+OZysZf1c2bjE4slyXlSClFUikLIIfRrtVzgE3fG?=
 =?us-ascii?Q?uscILuuWVBF5vCgSZBGytZWyVmPNAjHxwpPWNkCjxmNfG4cod2Xrnf3rSscC?=
 =?us-ascii?Q?C728l69mGnLw0ZrNpweEclOlTuIvqhuVRlT15jSammg0qaJ7LAq+JGyeGMPS?=
 =?us-ascii?Q?1zcUef180wREWGbET3cc2okJRmkfviJylX4eadg47fCt0hYaJS1YGeIZWYCk?=
 =?us-ascii?Q?EGueEdI0L/dpUIfwWgzrVJtiFacjyraXVl2MSD23CjoQwjLjOyo4FNyJVkMJ?=
 =?us-ascii?Q?LN64OC/2Yph1UdbofTg61iU8fMdagY4T7cE8tI28/tD1WptjpHXUyAVZZ4mN?=
 =?us-ascii?Q?XMzJeeYmyVOjGZINJMRnGbBxdzW8ChLwInaMNM8rf9ozM787Y5Qjj2K42dui?=
 =?us-ascii?Q?dTY/67Bim2xF+zHh+XC60jBlFbgT7J2gHz+kKr8+BFuzIl6HAVoY5dbOffn3?=
 =?us-ascii?Q?HTn0bBHbSM4h8fwD3+NBT7ktsiybXrR+Ws/sImy/zWe8t4CtDFJs9hPas0nu?=
 =?us-ascii?Q?gbJehzQhlR/VBWihEgEgoy7iBvJCVSMs537HUIDGXEc2sdZgNsmnoON6DcSY?=
 =?us-ascii?Q?2Ne6QZzwOfy5Yo2x5x99z4yZ/j0jZKjojfxnDxOIvH3pxFH17E2QjCr+Mg3Z?=
 =?us-ascii?Q?XGYXWKwDJoWwJ/r4KNDsYaBKBFCENpSQV6efKQ/wEKfuSf4uC1cdlg2zNpkC?=
 =?us-ascii?Q?PH5MW6adhJHR7SblgS91elOFazPh9G2WX5RrvkukHTbB02qS5njVaXIQnkOt?=
 =?us-ascii?Q?BdKw7qxBMO/RkT0phU+BWN8JpwgH2s1AvxDKzVrePJCgDfu06jUkyl0hNYOy?=
 =?us-ascii?Q?p0Dy5wwipymk0ZJUA7Z2HelbIVH0VRw8mO4CsYKj1ak6jXbo75Z2WA/VCZm5?=
 =?us-ascii?Q?zXNnII4EFwIDY1dafasDj759MY/AZ+yzcx9LCbFu8V3ZqSSQ9DIWdQh1aUkc?=
 =?us-ascii?Q?Fo85be1OWpEArH6siY1rDkrB/K+Orloj6TJ7JSp6Itvj+4658pDrJxeDS/cX?=
 =?us-ascii?Q?Zyz77FlFL0ij7DnuBjSdjJLm9XagJ2RWp7tv61PxBF79MuhoRnMPS0GEK5MZ?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5162cd-fd94-494c-bdb9-08db81412121
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:13.2936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZEKrDlzHHeLqUrO1lN3lb2EXqTOL2ajPuyHxpCtALhMMiCNrzHjJ0zCmChUafbps4pRzQkZmYufrnyxcMGSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9934
X-Proofpoint-GUID: rAOIvy9Uy0-tTybHR1SAkbJpps3wuiGc
X-Proofpoint-ORIG-GUID: rAOIvy9Uy0-tTybHR1SAkbJpps3wuiGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
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


