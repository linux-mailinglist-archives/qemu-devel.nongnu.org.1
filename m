Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDEC7BE312
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNo-00044e-H8; Mon, 09 Oct 2023 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNa-0003qY-0B
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNY-000384-2U
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:05 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DaBN6001999; Mon, 9 Oct 2023 07:37:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=z4Iy9RE32w6Qfo9PK472vq9yuUMO8SFEiuW9Mk+9t
 44=; b=XEfsjRXLrui5AdVRPqW3l0/lXyxqhKumMWNWdr3eGkiM8FS0ZEMvc66L8
 AkS4bBDGzEATjjmw0+8j9JQf1YlnynpDOxn3EDuMph8/Ge3SIPDNdFbSSglZTpil
 5qqACG2ndJGCQkKSa8a2c+J1fpci8XMXO9l1UNcSU+V000eFouhaS7zEsmcSyAGx
 dY7ljwNR/z6HCiuPZgSJ1IWzHG2wM41S+bPQAX9GNt++PZp775x/99HXqaMs/xLs
 u1Lu2n+P3nyXzal3tNbvc0opEeVrg90mDhuJwftY1Lt5yog5zICaiUz3x+YbzWH+
 PXmbEZ/YQeBmyOU0DKInnmQsZCSEw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02tm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvAavqr6CrKXT0IBX19q1kwiH5EPJDZqA9vcnTmj7cXIMj1Jrn60Ar6yfBElyftZEL9YYfkhmseXTWmqJxLylNndWP5/jGatFg6mC49axNScA63LL6vaqtAM7+wPC0qjz0Ai60ml1mZvM79ysVSynshXqzFYWf31kqm5vVjOol2YtR0p6oEu18FTkKPWMmeT9TFcppjROEBGJFnyjK9IiPxwvRICDTeECqMYsFdu9mgKUIxCHTysJfG/9cMfc6+O4fqQ2qWAAiCLmaZm0J09iAV2ZCClwn61x+ct/V98yTsdhdHrX5zG2l7bNeiSJDvBUgaz6pjkpLTr6akq0wRcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Iy9RE32w6Qfo9PK472vq9yuUMO8SFEiuW9Mk+9t44=;
 b=VBBKYp+RFVT1V/poGVvcenGnqeZP4oIVFIeUOaRKg16PU+Eu7Pajs+srKRCjZgYV8X7VNYdTlxh6mSKu+MQoZO5ML+SeKkzPmNmkMpJVL1cqMDxyr1vR3crIy5MrHhhaE3Pr9h/9Tn4Wi2R4QGfm8MMpXGL9EGj/tPz8ouIV0oI2oAwJfIJv30lDe81yX930OPX3goCFWr10ywhsTcFmF0V/ej84jeTx/WoH6n/gNh6UMJLF4ccW2hjoCieLEKq/eYq3Fj4oifh6PkR8fqFaqmUPcQkWEUj5gZdNqrzaTK6Xz5NIQK5H/dDVXNZb+JOAycZsggwBXp7Qtixs+nQ1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Iy9RE32w6Qfo9PK472vq9yuUMO8SFEiuW9Mk+9t44=;
 b=Ak23RTf7gIuXKPZilRiWMZrr4hWa29hvOQWJs4STalf+WVjXhxRNeVvTVh2kq+FQGMAl2nNWFDdsD4qTkU08oMNNa42NFKd8H50HAyykCyb6dEs3DdcWR2LGe8UT789GsUEoMTMs3sygh6Rev3k2gdrAHkcr8/MG4TtYlziDBvTCY8lezx4hqZYM5a5Dgcaq4rjrEUUxHMHEvcOhDO3QYWyT0F33rSY5KQy/dfI8cme1Ajjd4/mP40sRNwNfgbLjhj/cvvhRkThUUKaYpwPAFXjyX0zvTc4xon+9McJc7PxbtJldgHv3RVP/xrN9DNOnv6fJf7Tb3MvqT27LBYe9KA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:59 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:59 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Date: Mon,  9 Oct 2023 14:36:14 +0000
Message-Id: <20231009143615.86825-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ccb2b8-a8e0-4d05-fc57-08dbc8d531e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPi7ZVpB7uGzd2Op4xElZbWEnRGDd06wzpXRyGEsYdvz3xj8VPHYFP57vCaNsF+Lc3wOrXU1mGoBgxrXIwH1frqney8YDhYE9sEEVJ7soE2zGE5YM3WgcdxBkvrhHxRNt+cj0QUAXrDB/cmMY7CGR0NWJEM7SbE5v3ICjroaHPu2kxF/3dSpe2jhGmSFCjXVJN8xlRANsTuZ/euafkFMALCBrgcvTMRDlCRStgZwciT7BpX49koNDYGEdyivVgFqURCTG0YE3Uee1p2Hu234noz0qNagTBBVV0CGrJzRVZERbXSIfY1oudHh1MqNZV6GYK2Z6m1VIVOLdOiB2puYjYqr7S5PKE3aXbT9kBNDO/0SV9akCxntghW4zW1PltWmKaLvdpom6sLjSvBOMdWd+mLvzd91BRB5FS+ErEEKCpG2Fo2N5k9VU1NsJPcJXbhfyb/j4CCNEzSsCkxlp5yYXfLjgjsq60+dsZWMWvE0LgYzFCzyVMlqL4G+YaskphCYdfjyy0XvnGbc8iUOkND+ldaBd6/WO+D687XrqW1fFNMBXACBfvrCgBFfLyHkDcmaToseeRjROoI630LRur+JkUK3IbjDmhB8SuR7OIjX0ydUu0eZv9pYJTaccim+dha15HBObxs9VhUANvEDYeKvRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66899024)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdXTW/7XJTPptQ3o/OpZSagqXdCkYTHRCTwzYy/iCo4AalfVbjvqP2bg4cJQ?=
 =?us-ascii?Q?3bQaOuoTKHZiePf7y9z+WVL0YJH1+4j3gu9Nk+A9YH/xjQKayecyxfo9FWne?=
 =?us-ascii?Q?EJYWD6V57Dg720kTdlOQuBYbbTfAEDkXi2BqZYlEs5XpzYFAlNFTCl91O1SR?=
 =?us-ascii?Q?wDp58dFn3T/2BiIWwCq+ON8xn6EAtg2JltabjS/XDhgBLpnOJkVu94ukBO/l?=
 =?us-ascii?Q?kJT4BD9NSy+u5YM0VatR4C0p/jVlOJwvqVGitCsNrTGgpL7kyn6KWp1mQo24?=
 =?us-ascii?Q?FNhBm6VWsP1cYPMVu0XTjUClMuLd6FX4m9fTiZtFai8Vceruwgoy4MCMS6W0?=
 =?us-ascii?Q?QaEKlT21SCaWHj5hQ/JCP8e0erSCbdYlD+AgjcfSinvznr0eugMq1tH8apXv?=
 =?us-ascii?Q?036Asv/x9u2gS3DnEwYpcWjF6fD8wg8Oa4XDOGzNZWlcVdfjlQH/V/uKTbAs?=
 =?us-ascii?Q?y1gA299vpFN3+T9tR/KTsLpWSj3WC/BGNH9FsFfJiB6mN2nNbXuihI9yECtj?=
 =?us-ascii?Q?IyZVVOigVN7v/pUqwQ/QF2i9nqRIwmVPky3Wvo2kYs1lndN0ySh+tet160pR?=
 =?us-ascii?Q?mMTHE5V47jDXiv69kM5av5Dcx1xkcLmFFKMVZWTw1AbKULtboWS6ecMlwviI?=
 =?us-ascii?Q?GzfsQ9idjkF1+QL5ULkPxVHIU9AacsafEfF4nYrceX8kvfJQAtra2uVxEZmR?=
 =?us-ascii?Q?WVQ9yScS03QpZDHFfYgTYNl5IkIQi2T2/8xL7eQ2Elk74R8jbzgSWdhpkolW?=
 =?us-ascii?Q?rxDULQSLH9WMHWkuELC4LugtW2I685824yu1eFAY8JbUcbNP5/rJhBUusKAA?=
 =?us-ascii?Q?InGGrtQzftT/89fpSrXtHjg2Y6HytFaPppOSADs6ePu/1sF3RXIZIbbdwL1h?=
 =?us-ascii?Q?d5hfyyCp9hc2pWmPh7otHWdXKZuMGOAFCO2BEmhlqCslaSDTjsTHTOV5yuil?=
 =?us-ascii?Q?lqj4y9+M1Mn7R1Qdxe3XApazT7QOII39PqlxVDv7KCS+83qhhyRJeNl44//y?=
 =?us-ascii?Q?eDQl40EalEJWE/mNsnZ9TW+IV99+TwCTwu4duopfpz+eGdrr+FOkMeIdenq+?=
 =?us-ascii?Q?nY7eOrnhE1hWWNXy7evV25hnvQBOG7t9SqCXg7oDoBIACCO7GTqM0SsM98tm?=
 =?us-ascii?Q?/YqeoBYiNMA6xJ6moaL9OiRu16tbvC/0KjSSNqVllusob8NsZv+j4+39zS7l?=
 =?us-ascii?Q?zjIhI5i2aFqubBVp2qVahvn+oWYiAGBeyGuQ7OIfPf+Hn4SKVQfQDu7h/NvF?=
 =?us-ascii?Q?C+fZqWzgnBwjImBUoERtVk7/d+RE+aywuaLyE3v6d4deTTVCl8yrEIifxwuH?=
 =?us-ascii?Q?kiNRIWljidI/7ha4CVdvT86paK9aFqR0S1IbStt+C1k7m0qGobtyQsmQncbO?=
 =?us-ascii?Q?Ns4JZ+kmQcyCKr7j6BcVx5RV3fi4KZqd6Cf7FDcl63nNC3yxz9sxNdZLoVbs?=
 =?us-ascii?Q?b+Cj63lRWBetZ1xdPeVxBLgNrcoDNFY+nNcP1AZNhe/hnBFZ9F0ZwRXL+BBy?=
 =?us-ascii?Q?sVEdcPnyGvrLjfkfl9LDVazqqg1Hc2Rc2Nd1evipYP4RLAAmcjF1YfOvdqlg?=
 =?us-ascii?Q?ySHFScpGberTC3XX3Ue7GBqSujuGZcmxHvtpET+7cVXypJ5UbQEmi7T9wmP7?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ccb2b8-a8e0-4d05-fc57-08dbc8d531e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:59.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D1dYE/dFUe6cGe/+sQqSgythRe5ZNCk+83v/zxM5w4EOjoAsFE5mJGRDXWb2Em/W7Z28RgrsYf8MZ91RkuOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-ORIG-GUID: PaZoxJVww7RymDKtRx4ljGNSjIJKiqIz
X-Proofpoint-GUID: PaZoxJVww7RymDKtRx4ljGNSjIJKiqIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
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
index a2e6a5c51e..21b57f7ed8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    migrate_uri_parse(uri, &channel, &err);
+    QAPI_LIST_PREPEND(caps, channel);
 
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
     hmp_handle_error(mon, err);
 }
 
@@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
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
index ff04728b33..a651106bff 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,8 @@ void migrate_add_address(SocketAddress *address)
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
index 972597f4de..f9127707f5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -511,7 +511,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.22.3


