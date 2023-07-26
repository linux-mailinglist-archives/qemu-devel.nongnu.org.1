Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39214763967
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMk-0003ue-R2; Wed, 26 Jul 2023 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM8-0003Vi-8I
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM2-0001DT-Fz
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36QBXhfO001667; Wed, 26 Jul 2023 07:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=1RWg++S2pfo96T5lilV6dKQCZagQS5NWNDQurhkmL
 Bc=; b=gRdxrFrvjnwRvBqFvZWO4gVWN7FKkBYmnNxRUz6ki0MKDt2wTQ+ktbPSc
 nalT/ofdkwChaN5eCbXZSweThZLGj2ptyGAN/Jqsg14iU72EkJSYVylhQN366p2t
 zt8Gn2+85qp+XQcYqhJOFGei7BKyDzmnXk9KoB2/AisZa1sk4kxwndyAnPPi6PIq
 nEzl5urQA7JF3hQtEzZ7JQXvJSoepe3a6q588vqVeOva2u22feXQ8ZWw1nRlywD5
 tQnBYDkIdOM8+krpIiwannNY9YSH9pT9VSUusT29BhH5p7P5O5fxekhCSp8jokC5
 Hsxz7IaX02VZTXSvLp1XzT4FgKPeg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0envfyep-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9+bJayZx3+PkuOWPnP3qsp2ENKvRANFSuI39ww4gz9wR0htB+sjP9kuZwbPQPOgtysvDibA6BoaSpS+XqLZKV1PiGWZwYH+Id+4i6Cbg2JjjGPNHEMWNz43PKRbvir/hGNkwnptL1N2qURmMBmNd8bRRpXWaNRUjf5csWtGtwHVn43rylNyMpFmmvvfwPDTQYjMpm1TZWs15OvY9jVU6p1sJGg0SyE4OIiIaJRpNm+PHg0gVbdO9/Wjej9LiXtbqJTAYpPpzy+WiO7ffLX0JcZzUy2KSqZ2nf9d6aVMA1YagMXE4oTnVJaFdDKpsz/SLgPnsfbq0sE+s3W9jDANCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RWg++S2pfo96T5lilV6dKQCZagQS5NWNDQurhkmLBc=;
 b=Ui/GXJewcjCGFKzSmJco/AsAZBUzkjpluQA5LvYLbCbXs1I6FVDCcJ2MW5Z9ATvgFnNtoyHloAYC3y/T1zWdAcBtJ99nT1vkbb64NEZTizMn/5wT6ZfH3Dvwkq4GIRRX3wvdEgBzCbozE1gewOCnqPjGIYwpGW29PGEn2PVvNu9KqZeF0vgNPFUEmgyNZ33kNEMldO9Kdg0eHChlLemtcLCwvYfs4Jt5eZuXlwFYT3o5Ai4oetVROQliqiRJ/0bEywsxobneaDO7jR80px2YZF16AaY1sDlu5gBZnPgPlPM1lEYRei0BgHHs/J0wMoch8mtuQOHBfU1HI2mo/34MaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RWg++S2pfo96T5lilV6dKQCZagQS5NWNDQurhkmLBc=;
 b=e2XkNXHxKT3493gqBNXQrzUhparPQRhDe7e25O/GJReADpoWVRlq8z+/JCm+O7/uvMxtKyI6ngf5qHfGQGTZEFaHgWS2gqG8OxsrI9kKrWW2w8mDWu7DgwdH9hPihfHbLId6zsHNrbKE0cxXeYB9XMtXnI3fLopWTdz3bZT1rQXZm+AitX9MK8bti0SnINVY9tEWEjNc9rVr6Gm45GKKD1dzWrUefUIVQO6WSoOSDNW9hMf1aiGZSuYStV9/QEAkSyiAZcjqD7A6eDmaQ7K6K6h3bAkUxh+DzUGDhMjjSbYiVZlsklnQiJAugorFT8KzO/GfkPwiKEE28BvKE2TaFA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:56 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:56 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Date: Wed, 26 Jul 2023 14:18:32 +0000
Message-Id: <20230726141833.50252-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 869ce140-305b-42a1-0080-08db8de33f0a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LedcK338KB+zKZr3phyddsb9WBq2go2Eg5vppj67WC8GOylebJDMOhdce1MtA8/5Crqoe55lS+6VqK17L2ET4oSSgx0n9+wQOPDdQUhuinpkYCw6lnmZl2WlvmXhdD/RsAWHK6pOqXlMKt3teAQneAwV4serURnpont0MKT80HUmrK/QEX+aILgF7P1ZFMjXEnTUp0gZ5nQBjtFSvjDrJ+MeY5Vurt1eLpBVV6lz4atGrE3yyAVbSmHMygg1RQKvsR1TNziK6r+Onr1LyfUmHuq5nMDm2v5dXy2ygXYfi6QL2o3bfES/NYZpoNbPj60Aqpla1Ws5MWjShhxgrT8KsUfQ7kcuQBQCUE7bD/mXqVOyTpPQeFfdZesMOzg3aNDY7pBH/Fk/K3vBVW0/PQ+nG7SPhVNlDrcyBLNg3HciAf81+kvoNE5bzATh+FI6JmUA5dAVsjDRMTyLHPAlrYeKdC1Qksh4HBWemylaei/W+itCFeynjS/QEHna1lDEvWf1ARcEYUzwC6JSooW2qagFMDzRBSt3qd1tFl/F81Ne5bZEtn/orb9r0rwOCf4ZVEZiPZIoXekwBQXEPRq6K8jcp+io0yUPCZwtIJ0aOek9YMWFEPG9xYMfhdwjN5Vrq0EX1WDsXLBb09S4lrdIeoUpLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(66899021)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?75broSeaYtQ1ePlgMOFBNJ3xS47jMSVjmWGef/HubIvQgVT6tMflgTehfPTM?=
 =?us-ascii?Q?/xK/N3rJYPYd38G50rnzYyOHsgErPvASvv78oJmUtbDdIV0usRqzA8xETvBh?=
 =?us-ascii?Q?S4Z3ZDCjTUfZ5VhjTS0L1pxjUgSBy5znf76K8NA0Ez42Unc8djXB81by5Vla?=
 =?us-ascii?Q?r2wKXY0LnuwcrQfpVSeXfSZp7mVIQmT29Lvmo56llv6Iw+IehRDZbVZreiQK?=
 =?us-ascii?Q?fxtaR7BxB1sX8oNR7ne6rWQXzThPqchteCpJTCfocVvh0iGksdLcvXVmUonD?=
 =?us-ascii?Q?s1t5LwjfXH1uf9aQJOCB0lBDxK0g1uui5s2/ZrAyvuOCn9tBPH8n1X8CWYey?=
 =?us-ascii?Q?6OKqqZjr14C9w8cOEv/ZzTVraXQYOaWx4LkX0nvjjEoaveiq+VICZnmN48Df?=
 =?us-ascii?Q?ldlgVK9yBX2JjTBa52DZJohO3BZhIfY1mOXxyy9Ya93nj16ktaz9a2kyHKn0?=
 =?us-ascii?Q?M3Qx6GF6W29GU73sVR5M/gOsRzWGzSzMzAqhyb46qwv+NVG4WTafd/kcX46z?=
 =?us-ascii?Q?J0snqohCeh6g+7x8G9T7eGxxU/EgOHQf50EFXaECCLBkGNoaqd58QvEfB1Wr?=
 =?us-ascii?Q?cEq13zkwEnPti/ka5vcWLC+wf1oTN2uP2flKRc/ADrai3W22oaJade1maSfU?=
 =?us-ascii?Q?BXvi68ZksqWL56aTZem3rjxz+yGJBqXoqMl/+v1hwcWL+Cp/6vUY0EAGHrKT?=
 =?us-ascii?Q?OIUeB5YRUjl7KLVe4vdH17SPnr3eLZY0tuIcfUg+dMz9rAsSBDJWu0AltZl+?=
 =?us-ascii?Q?MznzBjBNsH6Nxwf6aKLrPvv1zPZwhs2iR8PkOS3sYTMJXiaXUIi58M9wokuJ?=
 =?us-ascii?Q?1pl4xdUeqId5Hcv0OZfflvo3bfgRhRMPkFfgIxpZThRqf/COe3XxkA31IoxH?=
 =?us-ascii?Q?XqsyTVsbCNVQk8wsWpedAfyncLpdMqajWhU+559dH1oFDm02ROFesJmMKyMh?=
 =?us-ascii?Q?MpczQ8vpqBTrWO0hrdAGoTfi+8l15pwDhqc5chdNkLxznIY9QzQWHpxOYrLn?=
 =?us-ascii?Q?ei8gNs7FASTiNt6HfJlOhXC7FBi15cGSRZ7SQAy5nr7TaRtNizFCXAd5Pw06?=
 =?us-ascii?Q?v+lsvWNTqOG0hqJHMi5fW/CSrlnKetQsXHM10V897YehlNmzliXUEVOlTSVI?=
 =?us-ascii?Q?JITItfY42vhHZNkJUjT9rhtUlTFLwVIIw0mhgCAOJT1r5Lhr5FDSTSk/lebJ?=
 =?us-ascii?Q?k0/2zztDzPxN+xxTY4Zdk8gdHeE0uxx8lKNwbse1lN2e6bR2jaIzUg6q0fsk?=
 =?us-ascii?Q?K2UoVOFVYbixC7nP/zeWT+ByA5jT9NmJ0H3j6N3W9DPao8DTae0uFJt+k0Vb?=
 =?us-ascii?Q?3MNNVVJEZ0UyL++EfURUWwZHfWdKjQWVzo6gzRvmnqDJ7UMcZ/0fphVdma+h?=
 =?us-ascii?Q?cMD4fRYtuUactkjtBNtzBDZlOJLvrFEI2KHO5fTQV3yWopVzt7NZ1Y5oPtnZ?=
 =?us-ascii?Q?A/fKnRxwZ7lLgwpkc8jLW7ERLJYleRj2O225PfIT9Ftlbfpzdo/uTPMXRbcV?=
 =?us-ascii?Q?VpuZOme3kPllq1lTTrcKITc510NDECEyHcvTVhdFkquH5mvXnX8hWudbmuSM?=
 =?us-ascii?Q?HHEJaG3sd5RO8cQJcdUEpywXL2bnw5vmcYxHFl0Mu6IFZWS3MSEWHjmPunVR?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ce140-305b-42a1-0080-08db8de33f0a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:55.9739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzMZzTIW5KbxGniqLEjHEMIeoJhirZMsuvGk9rXW3PB1Rk8Dy2WiMm1iGtiBluCKFTJlVJKidOIkEGm5Dygdww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: hu2x96EUSAnBqrxJ7HMLddUCZTmwSQTY
X-Proofpoint-ORIG-GUID: hu2x96EUSAnBqrxJ7HMLddUCZTmwSQTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration-hmp-cmds.c | 15 +++++++++++++--
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 49b150f33f..42463ad31f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -423,9 +423,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    migrate_uri_parse(uri, &channel, &err);
+    QAPI_LIST_PREPEND(caps, channel);
 
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
     hmp_handle_error(mon, err);
 }
 
@@ -704,9 +709,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    migrate_uri_parse(uri, &channel, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index d54ecbb00d..213832670f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -425,9 +425,8 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri,
-                              MigrationChannel **channel,
-                              Error **errp)
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..f833e02b6d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -501,7 +501,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.22.3


