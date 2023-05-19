Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD90709407
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwh4-0000BP-5e; Fri, 19 May 2023 05:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgy-00009X-Mb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgv-0008Rb-No
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J5Jq35003348; Fri, 19 May 2023 02:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=RZJ/ECXJccVQZPzOfM3CWxAHJVk11v6IfR/PzTdt964=;
 b=SlR4QIGsRlfvxI0RTBBXN2iWPV/0OWRHCNDQN2pCnANOrCRYh7BzZGtlr5E0BbG+CAIc
 cnuVuQLaJDpoejkKHLB/fGit7uhjkWPIba+GUE0uZVN+rrukP/UhNF9GZLmLwhedctUR
 aP32ajtyTYd6kt17xsbkYInsKETmQzfocBjSYcuf0mYrHijPgCzP3Vklqt4fyaGD/wNA
 sUR66qcsDfjI9AOyygqwkTHg7RIp1lnyCW4KAhl/D9awga6qswPD7HMoF3fvuVhiVz+V
 mZOJryDTZQ/FoOn8CmoLviiPP8B/Gdn12mBJOg93LSs16RRYqhPxRdt3gfZIv2shHWmF Rw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw0vda2f-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQJCiNzfsgUKhOtTLA3aeGF84UHRViuRKSCi3rOGq228s3wzvrRtUnjeT14FzEZ7ml3/Fl9qNZv3+1eVK8ccUpS//U229D2nlIkLlYcy9inxEiXlaYeqCFYjkrBzK8tTmInzrlS7V731YtVLBKpDB212fNJkIwAM9vXnlpksPa2PfVSNrBWNprMd+FgJ6bB4LTa0PXnsOoWQBV833/EbYQuhKBbAkRLRKVVKzJlS88JkgYVcMMwEtnTBkwcaVRH+oowtMY5Z1AKwPj8W71Pj6XGL9gC/JxMWJWjdulRlo7j5w2BLvosB9RRxyUJmuJuKKKsnKPXNU186jz4fz9Tbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZJ/ECXJccVQZPzOfM3CWxAHJVk11v6IfR/PzTdt964=;
 b=ZiOvwaBXXGIEl6ypsiCENZWg3bZgQ1u8720SiXF+rjEcqDpeQMXwIxWOR1j7XcY81zsQvlut0vhWgqpDmiDb/lY+jGotNGCnpAiGlQwMvjx8D1xgJZMNMAwhvRRcz3oo5f4uyxLALlYKcm4HzRaZNAucY6lL/I44gZyv/DBju5ZpimyRaHxXLzyO+K9m7v/2mWSR7/MP/EAKUqB7pQUUcB3wxxUZRgGlR+56OO5llBI53PgINHsTFiknM69vzaBWdxwiAEFYE5vhq/4IeCKBd6yMlo8DHgfrsXqammkjPgoBDLh9q2TSAuuoruD1eQbAffA3T1/gCN1mK9Hsz2IcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZJ/ECXJccVQZPzOfM3CWxAHJVk11v6IfR/PzTdt964=;
 b=a7Fhak834gMRq6PcVhZBivrYEmKNCjFhY970ORI3fO0xm16iRZrjOmFCMJwYt8Q2mqpD/deERwKzmqBeUbF9sy6GLuADE4UM0BQnLuumZ8QtoVKSzPzHa+2Ceh9lRZvlTYLxRsrs/hRu5gGTevoJM4yRv22kPsikE6wcuho6qlPW6mXsg0Bfj4sLBgWYUi2AT2Viq0ekVMjz2l57wgOSeUWxRWeTQ4CmMXEKEeSKTuZOy/EvldOpsA4oHUPdVKYo0Ajs9qjTb3MVxDB/V62GcmXlIl1069pBjVSTz52jw7LBeHgQXN5S1lbQvzw3nUXZSmnyBw0BZtkdIBnz+sl28Q==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:27 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:27 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 3/9] migration: convert socket backend to accept
 MigrateAddress struct
Date: Fri, 19 May 2023 09:46:11 +0000
Message-Id: <20230519094617.7078-4-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8a6af4f-cf29-42f3-46f9-08db584dea72
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylz+qWCaY08kc4azpcUldv2oBAWDV4rhSYkYEXV0d6Xg9J6F7jzPAiJU9cGk8QETX8E/AWbUylI3+Igvz4tB/tzefUiXHFD9zEpLbn/ReNwe12TjOj9i/B84pHc1XCvvmZvVSFaKQbYjJa/ggw5eXM2lp+e8Y8YyCdX2HhArmrTyWkLw4WwZBtPQIXc0e931x85IfJca6PBKc8jSksDmKql/hP2ANRY3hlbtB3N8etkMwOVeQFLKtU3/JNspa3ToIB5x/KEcbcbOFyqr5ETyRG4hRKoV4TXUrU8L3w/E7yKVQqSObPtNIzpQmTkHNRumsolphkvtQlreB+jL9jawAVclsev0w+iOppddOsYBivOwViwJI4/E4RPTfPpcgdAc4yNIWDRqHJvQkmPOin/hl4fOlNvYn/cgtEm1zFA6cdzWl9hM6UfTefZAmwE4SOYoB0HKLIrP/o968xG8o6qjjcHkrOQWbIpv7gEHQlvNU9LAW3v4dT+RIuQrBXMWAONS5weyf0Abn203X6PZYpHLluUXFqlyshG4vvslkWGFe1OkWoaHiGrCsjz7GArRagPVTcsKySX2k/s5dFUBcf3Sj0HhSiZQW+Y16Tdv+faVo16SdVjz+ZkfJFVDkXwHv/6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZiz77zbSFQagXuUT87B9ilYu+4+GDwV3rW22J7HNF0x84h/syumhrPAPJ/Z?=
 =?us-ascii?Q?+v+Lr6j1RE0HB59YsQmxqVTWR4Yz4rqeuAlcsUUk1kidGDC1OS7MxoYnXLoz?=
 =?us-ascii?Q?yQFvvoW1eCglDaPN7x7Uwz2sDOknsFVQNpjXIsbGgF6D/oebkOIiqZ8FP36V?=
 =?us-ascii?Q?osQfljpZgdVBAgh7+gLh2IBLZYse6K62pfaReBMo7qQLeyq5RUWTZTFZbnAz?=
 =?us-ascii?Q?S3j98iDIZX6eeD24/QyObRk2TcImxVDvLLO0f6TmY7mEQI6VGADcTggdrkfA?=
 =?us-ascii?Q?Twuq3E65PvFua2k1Wz/zRflSf+fHp/1SC4kaRVWBX7977uUW5BMOhT1SLQtq?=
 =?us-ascii?Q?t6zBcE1FYU+ywE223DR8/eVJE3fALN2VGFAN5rPgCjuOtQEf609H8HSqyxrr?=
 =?us-ascii?Q?aWXjD+u3+3xkpU5arr/DI3xCFFKvjY6q/aQCWpOfgLZQ2nXHpLL7vecyOByE?=
 =?us-ascii?Q?rXHV9jnlKcbxRYDfFXao6Yw8qDksUEcWTsPp745hXwSMoH4vrVPXeMnvfczr?=
 =?us-ascii?Q?0+ifAS52zafD/vJeE8TRY+lGlU/+dn7fNyDXd83DLXsGNIhkN1b88KME8cl/?=
 =?us-ascii?Q?kLjl6o5wNkzz2kHRuIWpFG2ziWSrarNxp3ChId+NyEc0W45NBq+2amLSjB4S?=
 =?us-ascii?Q?9HHdx/P1eW/4T7NJE6qNyWxRG18nECBmVrb1e7kIZVc2gl3YdfcbRzzuANf+?=
 =?us-ascii?Q?boN29xu+iX5bXyggIhXRgYi+2RCTSPOkAU9KcZ1xqbisDNDrssSvfYgYiuzd?=
 =?us-ascii?Q?GKZeC1Ykizkw4drvqX7A37qWH7oFn+oR6JMkVbkQxE06dOLAP79E7Y3QD//A?=
 =?us-ascii?Q?KK7Raja0td078MnKRjlex7S2c4rtLvPueabEwmvypC2HZF+KJaI63+XcdyUm?=
 =?us-ascii?Q?GPuT16aCOfG71JUPPgf9Vq5MQlTw7m8zHZG1e7wEHVbvzMaqxtEpGl7C1Ir7?=
 =?us-ascii?Q?KF/CVGYh63kN5x0YMILRuJEQ4UPc+ZyDlAoDN1PSogyd1OgMHi8sRExUd4SO?=
 =?us-ascii?Q?rrEEhF1AdYfYi++BFNm1xLfshUNi0e2V0tbBEsdOUt8FzSF0vqThhh13rzzg?=
 =?us-ascii?Q?hze4y3XjQ/y5udpfDth/WVRc5n9n+9yLcSdv9x40GYOkg4PKcXK1aIdUVsmK?=
 =?us-ascii?Q?Rwf5h32+NsstRxF5qdPg2gLMfllE2LyL+8WRrwG1jcSBVx+tZcL4jn+S4XC5?=
 =?us-ascii?Q?qhcvHBPjOhtarjxIQEtfYMfCzFc64X5eP4/PEVV8dWINz0AGf8rKl3kDzb3f?=
 =?us-ascii?Q?BWghKloafQR6CP3yLxBG6/L+j9R49pJnGFtGQoCLFjosdmtcqwc4yP3r4iWT?=
 =?us-ascii?Q?Nu88rtCWkartnPcpeoPnfGJUdBDlt6gkj5JuXpC7DZq573HUoJFvLgrQyCM6?=
 =?us-ascii?Q?OtDgRDWJS10YnhtgW0GPLIscY9N/elv8KVgfMTVb4S4O4NnqNK3MC3wMj0VR?=
 =?us-ascii?Q?3zoASh4714hwsyCCVDDxuaYtCSgvjMNfLexIvsGt/YsSwtkPP9EKvdHQ3387?=
 =?us-ascii?Q?0x6hcSewOInKUV3pAa3EPz6Rne0BgXa1hlq1kOKGthi37/qUgNbr89SGazy0?=
 =?us-ascii?Q?Z7d2/2eD0H73mXPn8Y5KiLko6UxHSQPD+nzKEa8kEw00g7oo+7WUyyGTPVkL?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a6af4f-cf29-42f3-46f9-08db584dea72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:27.4405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF4o5RCPdvqGprQlic3kLRHHlkeNDtUqaDiMoUvSkXfVnzkir5n7asj+0vYB1cPavhkVUDqcDlprZ4EX7m2I8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: tq_s1HjDHI-1Pe-Nlj2gLpY8lngXZ_yf
X-Proofpoint-GUID: tq_s1HjDHI-1Pe-Nlj2gLpY8lngXZ_yf
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
index 4c9ecd521b..3724de7edd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -478,18 +478,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATE_TRANSPORT_SOCKET) {
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
@@ -1687,7 +1690,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, &local_err)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
@@ -1703,18 +1706,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATE_TRANSPORT_SOCKET) {
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
         if (!(has_resume && resume)) {
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


