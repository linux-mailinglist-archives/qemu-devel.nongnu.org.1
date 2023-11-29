Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A47FE146
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 21:44:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ROt-00018f-Dv; Wed, 29 Nov 2023 15:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8ROq-00018J-Nb
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:43:12 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8ROo-0004tc-MQ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 15:43:12 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3ATG19Lk023275; Wed, 29 Nov 2023 12:43:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=p/XOLvMHbs6
 crkgqqVaRW2Crk4FnFljBAOE7QPREl9w=; b=yRIBO82Mx8bp37WskaM0kQ1oeTE
 mNOylJDb0XmO1HWDhNQVLgqH3iBNG44C1bvzzGg1NHJWwpAB+HLMY0UoBs9OpFVp
 UGYw5UuPZ7BByTVLu0eXbm0O8AFNC2O7D5dRNH43QouWrSE1xPRnlCWrWbLgfsFL
 /V6Q6zRAjuL/61pNtHr2uzjmVsDlMRSfm84PgvonHnj2RtAMn1VGCHJpCmbtXOov
 sCWXK/ibEIftn8pz6vHnw4Y2xtjCn5bSaJuFF4khTwKpWZBpdy8C8RwOB5k7uSaO
 2zPYkhLfIaQfcMM45Q7Pb8fFDdzIIWz+odyWoagnwclQqTWQ1/dnxoT90aQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3unvuchun7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 12:43:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfTW1r0NkBGHE4vEKPyKdYYYzHgAkq2Tzwq8nHVXNeVzi/3jpGPywQyZfaICrgN3BvZQnhISxY6lMpjsllVXGtmY6jr5MEDXYhGdTH0fL6ci8gNsFdWReYtrDaFQ7/QB9XD1LF8dtu6LhoaNaNB5YXsz1AQekq9cvB1nM/H0g3ER/VETaOC/wgXNSYnWc4FJA6NfzZx+vstYOjilgSn94ubj6ypu9nacNet+85t4A+H0Lr/D6a3a2pmhQ7XuScq9a4l8FXrZ3F0gQaeONprwse60LVWseStVXwj4qXt5ceFCsWLN8oKY1iU5wrOkGwvbmLzvf3EtPl8PCjEsl5vSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/XOLvMHbs6crkgqqVaRW2Crk4FnFljBAOE7QPREl9w=;
 b=Eppt0DSG/VIlsfZTsU8VTTnzhr02R5Uinp7Nr5YW2yzEhDWMhTDvBzhY8MGPSPSur9pTrEfrLWTcio+KCHE9nxbGWx+MoHCsmW7vzqWa0BudFXuJ/y9U8dtWvw3k1Ww5Qau94EsRexzuCjZWcDp0JVwvJ/RDmHBcA78nj99GPuRA+cUY2k8vtcqwMSnGRThQ5Uf6jExKOQ1he15vJ0KB/d0vzTvfBpi2juABsqvEANj8pbhc8AxLVtNtn2+MP1/r+RrYpxWhIdy/eTEWLnMywkmyh2U3RkuS4gd+e/JcL8evZNz8kiHj3e1uPmSehMNft3om+RCXT4geyr5AJUQ8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/XOLvMHbs6crkgqqVaRW2Crk4FnFljBAOE7QPREl9w=;
 b=BkAQKsccomLN/4YP5DHtsGj0PEtYCxZmZ/ynWJ4cohc+sG1bWLTtG9HK4EGOo2nwn/1DdApBhNsFBfHZL4dntvszQHM0aaQY5PDygBchZxl4gEyfAoGogQd2Iv1GWT+h2tQiyZiuyhgc1FHY9H21Nkjskm3+uatcXiPNfvpwSzlahhXxPCkQE4X3IO+u2scMOhAHD4m+JhJnX0VkZMxU7lWUpKz1ZOMVlC5XCi6HIL+OwXyvpeek/s5ZOzF5wyz4ZnUOJS8vlUWYiMI0XJBGYV81nNSjJRovTTmhPCOaulW6mRynroWYH9X6b25Gd8eS0/4580csVT35UZTsnjWKcA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA1PR02MB8970.namprd02.prod.outlook.com (2603:10b6:208:3ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Wed, 29 Nov
 2023 20:43:04 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 20:43:04 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, armbru@redhat.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v4] migration: Plug memory leak with migration URIs
Date: Wed, 29 Nov 2023 20:43:01 +0000
Message-Id: <20231129204301.131228-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0020.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::27) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA1PR02MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 44dab496-a10c-48da-bf80-08dbf11bc91b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8wqkc7j7eJcDoqZyPzgNje+6+T09gYMex1CpNxrndisQJeNLVvB5GcvRJJoGBK0KJqDKn6cRhLw61mJBQCn4LqnK91aGPGGkWF37qNzgEjAwVvPb3eeGSLOt6YjO6FYNuaEmQkuZt//SrasDYIBf4/s/v/TbBSMJecNgyX8d07xkufECTQ/lMUloOtBAGYNgIm1dMrv+gPMn7/TGEcXCYN7rRmmyM1f5WJwj0StU6yvBxsEi/AcH+CEcBckTd1E13grQIn1UGp2JKuGFDtB8VLkq8Zefx9eKHUCWiwQZiftBsPcgqO90uqLS+wjm3SS5aimJ7lVy2XB4vDkUbyt5Y7fnMFeOZf6M9EMDRgZwCOQ3FJBl1Y6Tk4XDDz66DN0hhmLMDeHw+VJur43S+kjux9pt0L2ILhof9MnH+EUxU+Rv5VZRLoevKkK9OwiJx5aJTBV9vIbWa4Mnm4ZjOuQOcsviMz2WY6kQYohKGuoSCF+51uejaZz1cE9WGSWuHJyEo+TxsNF9JdCncDzi0sko+e7CpUqbeQmYB9uZLY/KQAEw8WvOh2RW7i+KTP7y4tYXq1vq6pMUMhoChA51MMKg16FBYMzhYrqBMlUHSQCeOp1OZFoAPOiELxbNrBExFZFM1JeVMf98AVhkUbtbBzwS8MBqNuybHHRlu86qAR+WE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(5660300002)(316002)(6916009)(66556008)(8676002)(66946007)(66476007)(8936002)(6486002)(4326008)(478600001)(38350700005)(38100700002)(36756003)(26005)(44832011)(6512007)(6506007)(41300700001)(1076003)(107886003)(52116002)(6666004)(83380400001)(86362001)(202311291699003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVvQx4wTaneO6mAa0sTDjAcDiPd83ABLHSxncmhDRq0rcDo+c+ZAmYcGJT+G?=
 =?us-ascii?Q?QNp27/W5FBF9+zw208DYjoBAXsBeBBdOgiDRxPgZJGZsGsyLCznfaOBAhrIf?=
 =?us-ascii?Q?x6mMhhaI9ga63MxCoTfyzXjTneRai03cIn4i6DCYH76UZZx6YkzCCdNFsUaE?=
 =?us-ascii?Q?Jju4n/iuOhDUOAkO85KflFtbV1w7XVyKS0TBJyqOCbGDNZVtxxoj4iIFlL/0?=
 =?us-ascii?Q?EOr7M+y5MtNMD5RI7txaN2Fj+zcz1erNx7ZA+pbE/YWpPydcm0VFQobNm7ED?=
 =?us-ascii?Q?P17x9s+h/jeonDxDqeCw6l4Hk2DVEjzn65ZmpbXPj6lM0UhgzZaP1u6ANi6b?=
 =?us-ascii?Q?UyFA+cEoKep6yvTAZZeunk4sQJN7e8XhBkstHRL6ASt/DngZGcmwmn1SIUil?=
 =?us-ascii?Q?5YPLadjPuOoVSXn1NNk4tSdVu/S8+HxTFbsrrKXGzxjTE5SPQ3HCt9rD6DZ+?=
 =?us-ascii?Q?ac0KJsIzmRd1PV9LgoRX1IgaR8b0Edc1+86OPn6tzub0MGyYDqsxy0416Yjz?=
 =?us-ascii?Q?gS6Vj2OU2wL1I5NXPJwILnJf/4AUJicmNcpetmpy8JrmtYjXeNkJ9zXZOoao?=
 =?us-ascii?Q?XIaaR6x9n+2gh0VjXOd/+xI+/UHdMzDuldCdmA9jgn35dNLlND7rEZUQgNG6?=
 =?us-ascii?Q?cXNyWqrLaJEMmRygU82fwHr4JhGLCF0nbNxcEaB0jkUDNARbOWThN9exZsCs?=
 =?us-ascii?Q?HF3iN2Qd47EbPP33AHKMggMi4wE/aNpKDYf56tUDVoQbrfgd2EVkAeLtKqPI?=
 =?us-ascii?Q?v64OJ3dr5s4g+dwRXZhIbkMN8N/zjUJs/OnGSRL2UCKRnmmbbfgjnBVvepj0?=
 =?us-ascii?Q?vL1QLJCDNE6XD0PQeHjUM4dhscUpQ0aNk4pGZ1x8aR8H9X8LERD8+XoA7lrn?=
 =?us-ascii?Q?xt0GUyhWfws4upGRI0ElJ+0Cj68F5WBI7nKt1qgx09/HrGTs+mDgdCKNniqd?=
 =?us-ascii?Q?FDZ4ZOQu5qrb0G49/hG6IOEyi9Ye42Ln+6OiHycAlOfVpGCMD8kljkO3jAh4?=
 =?us-ascii?Q?b5eaTfOnDXpl652lRhRCIe9zbkDcJFm4YhNEZPbT6KA/IBs5iWpZIeNJOt46?=
 =?us-ascii?Q?IsOkTL2uo9FX6ckkjtctZ21A9RaHQV0wP/e/VtfGjlZlvH4D1jZSaew59LBq?=
 =?us-ascii?Q?7jGy0dfvn3B5n8aEL/1+53XpN/bT6ghB1bDRo/8yEYa8MKWx85Z90mvM5lTS?=
 =?us-ascii?Q?xi5Dz4GxANAltts9E+JaZQIZfxx6o6M9z0N79mIiuk5X2u591UdlID4vt35f?=
 =?us-ascii?Q?ahMN+lYJRu6NOitSVtt0v2orOW892YB31JOdo6JPERo6AfMTDx+X6Kln1C3i?=
 =?us-ascii?Q?ay7yZyiiRQNattVb7bdnzVpfB5QqOHuo+z+4tHbeGNDtR1dEz3CtQwxRHnDc?=
 =?us-ascii?Q?BZol8ty/zPUxeU/Lr8a98uw/TLxtw6O1yBYhq+CzuOIco/tl+rNvYnsOGUQD?=
 =?us-ascii?Q?hqnutvEdNQI2OwIgXuxLMZWGTuTP9FfxOFkNlDnACGoJ/X5bekrwlFflIH6R?=
 =?us-ascii?Q?GABKddWCd7ThSyumVVEQLBH6FKbU3AJ1xkxsXfKO6ZB5ZOYC3yPntO+JDOZo?=
 =?us-ascii?Q?6WLb+ks7/8Ig2Si8MJ5yfcP+D/HnFCKGI+uFwsIS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dab496-a10c-48da-bf80-08dbf11bc91b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:43:04.4613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtG/YnFYDUn2B6APoG0JSabf6eGAfAPJz4ftpBFLKs4mDr8VBrgtXtxUWnmSZSw1/IBcaw1lZ9/hFtLKkfLceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8970
X-Proofpoint-GUID: QIeI9w-siXphgwaMl-yo3cs8ZkCU8U4Z
X-Proofpoint-ORIG-GUID: QIeI9w-siXphgwaMl-yo3cs8ZkCU8U4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
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

migrate_uri_parse() allocates memory to 'channel' if the user
opts for old syntax - uri, which is leaked because there is no
code for freeing 'channel'.
So, free channel to avoid memory leak in case where 'channels'
is empty and uri parsing is required.

Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp migration flow")
Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..34340f3440 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -515,7 +515,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
@@ -1932,7 +1932,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
 
     /*
@@ -1949,18 +1949,18 @@ void qmp_migrate(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
-- 
2.22.3


