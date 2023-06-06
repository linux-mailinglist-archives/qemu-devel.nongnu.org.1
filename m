Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9D723F21
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tk3-0001gG-NN; Tue, 06 Jun 2023 06:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjo-0001e9-Rn
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjh-0006So-Ac
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:22 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567WVsp006549; Tue, 6 Jun 2023 03:16:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=eydsa4hC0jOC2V+eZqnR8wCdR56OPO80b+vFC6rbpg8=;
 b=Cho+EdCMKNGVKK+X9dkI2SwOeiIuIfnexO8N7imYERHNHARMAsHoEsl1hL8r7li+eHq0
 F+ShspvkLZsuLmNV4nELCFpFTBYVprBKh7Au4r56r4CivKnz7NsiIlNIgzR2WrHWZ4RW
 E96LJqDfloXJGQr6FsOyLe72beL7YiQ/MGeJ/JhY330HMPLvM8QnJdgKBv9RqZCUrPN5
 Br1OjDkqjqW+mhDlBPlCO9Z/VRWMBsh4O0FJu8rFBjjH0kU2/50X7yIdojCdeSaw3d3P
 PNoNB7+mehiMnE4HZ6vzubrDu0ZH9MZo5aBpYJhxeiL4LeA40LoOeIJp7V6ntz7wvnPc rQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAxpE7Fjp7GAuBavVzOwSR55ctULSusbdYx2aPNPmuIEamiYGTFg7ggVL1jY6NZhOoLqH4bZ36xCo3Mjz7kU7chZBRNN8z1Ux3koOJBZX6VeuSIlHS1PZCYpRWHdMAcZhVCkcalniyGcS6PUypt44q6nL+mK4Dh++gDmDAsTGS8F5NPtO1XX6/4EF7Pj/5ux/Bzh68KnYlhaZXrwzB/aXJGIP5JUQ+5cQxD/P7jZ0IoOBG3DVH+BLVw4TYgzClmJKw5LQopoxI6+XpzQk5A7bDbhzxF/dbbwpZZjSSBb5VxKhiJB8vwnFJbLzRVYHE0Sgv5b8mUuMj30oGNqqhbAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eydsa4hC0jOC2V+eZqnR8wCdR56OPO80b+vFC6rbpg8=;
 b=fI+H8Lzq4eI+7cedeVeC8ziAD3svrw+yDVNirQe8Gx1O9FsTq4zaAN9S7NxrtF2ZIXkaATNWyYl5VIqOUi2NUQ4pcoo9UCOMh2XdmD8ZKrmdO2NPs5UzgtQwCftY2CYwOdNDfMsztaiGbOQoM57syC2cRG2mzPjjLU69pOeMozmPxVibn3ZTtsuXNYnbtCoOb/BeaDkh6wieUmGRS1c6q7NrWhKh80lxbythRIE1SP3RKQhB6n8jks7sCFhx88jYt8xCfgCKbm/8PV2MDGni0tE0Gg5wMmKWLNMp8Tz16FCSoYbVqfmOdRvKXeI8B212L8XuPzjzU0gv+idGvM+oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eydsa4hC0jOC2V+eZqnR8wCdR56OPO80b+vFC6rbpg8=;
 b=WFxj8Yo8mjGNZTrMNSVvL5xYY51JQknBUmM2McombTyQSQFZiNXM/LoWzT7DVYV0efrQzN2S9147z9r7kpMXLC+jXY7Y+VYT4untxSRKNWt8iRzezKegN3h9gTq6Pq2bVpyNg6YqSg1Wp9q1CUpsTHlluUh41h9RNAGjRqnWylTqufRbo70Btk4kQ5o6HLGfXFHf79ZYnuAH4sOPM1l6wMUNNRGfBpg9x1ivBjiYuEj2/TEY6JKKVQdH5aZFLWsg+a0IdSj8dCnt4PWOXIosza94UK290PTYY/F6rwQUxsSD26OYYQ946RPc2AM12oxInK/9VKFPVlcR8ZCgq1vR5A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:18 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:18 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 9/9] migration: adding test case for modified QAPI syntax
Date: Tue,  6 Jun 2023 10:15:57 +0000
Message-Id: <20230606101557.202060-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230606101557.202060-1-het.gala@nutanix.com>
References: <20230606101557.202060-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1618edfc-b6f8-4443-641a-08db66771179
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+QDcOJc0i2isC8ZmNW/zVrmfcroyh56lBy10j46wkqz5NxZyfwuG5oMCw1BchsSU2wnp2y4MV283uk81eJja+ymFMiFUhsyy78zIcrxefVfysq215+SwNboqVSdizXy74hnZwxCOyZyFhajJ9t3rZ1dYzPKgx0UAFIQyPW46QDWum6twcRDeh4FQKI2dl90xeBD9qNug2YKvUlJvGfSXHb1bxkgLMIWSlCUz+hfbwmxYR2UPjjx5pLd1i4SU6k0gNyLepnZ/q5F1Wgx5KVi3VgNZ0SmzoavtM+2Dbr5z8Uq9YMHnoIG2EbzOhlhoDTQk7XOS7QpPtkm+pLoOco5W4DFSYXzDNANcB8s+fIHWDFKlTqiXOn7RxPI4AzCCAM9ZKs0CsAzFHoTuWPJ8OB+3SX674uVXU05cEv0s7oNLV7K5iYDVZ90Nf+VRUl9jFm0/DBuCMusJlrJM4+QQZsU0zFnz3fFr5Rv20S1HvcpkKLQ/NZ1DZJc9Gx+89yhA9fmzEa8yTuWnM93z2WRG94cGPpJeHri73/QVA8dA8k/trzQlFydKE2PS+A9fhkgMyGYAg2lJKipp6vQGSOmkFZAQQJTIGvmZ6QcKI+fiPzgVYbLDeX3RVtGTlC2uuxH3G90
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxGW2+Jj5lLRprsNWESut972m7v4Uz4QtTLXHp3k8mFVdqAV4uWHTRggzf+i?=
 =?us-ascii?Q?NM5DIl2tV8jAcHI2Ddpj5NHAk3CIw+xBL7stkK2/KHvUq9Y6uO4Ut8hivnOb?=
 =?us-ascii?Q?HEK+RovSwlJRr9N6u1M6VFlL/wqx8lmuWiRk/cy4rvL1CE755IQHykWn29Qs?=
 =?us-ascii?Q?kgninQHlHkqWFeBKfOMPDfSMMU9vnmR5ibqVozC3a5/ToAbuhgTVd/7VkstR?=
 =?us-ascii?Q?SdcffAg4rQVe7hxUeEmvJDC6PWGKcJWZZWknWeZpk80Pp9cDWfIHSojwQTK7?=
 =?us-ascii?Q?w1lG8NMe+LGRktcmct4wZQPLk5OWo0F0Mopxc8YL+Hp2VoWQjJdu8MaenLPi?=
 =?us-ascii?Q?k1bcg3ru1fXxGgpQnIn+lwEk841rFhj87S0schfQeaxz/coIyTEO1257wjSU?=
 =?us-ascii?Q?1gV5T9v9LpAFT0y2hpBX3fC4EnVllv63SCm4UrqPlG0XKOG7sGnjWHYsFZla?=
 =?us-ascii?Q?wok0i6B3DnMwOJbKO/lh99xL3zzlw+aiMJmKLYXuOxKdLfniUBpjCv6SnIN0?=
 =?us-ascii?Q?o9TsWZveeqxjDjYwKbsLpKluKwt+A+7JzHeo2znwZIpce8K/2EVabu4NNDRA?=
 =?us-ascii?Q?SksHvkW6f25t9UkyhwmqrsEsmaAMI6FbnTUftFwcW/pOUyPDWSZT6i3GUxnw?=
 =?us-ascii?Q?N0EI39imEIa1srkOh8DteqV7ymE7TgYt+fgPlLrWm2D5P/bASK4fkLBmMHBy?=
 =?us-ascii?Q?2wR5aqb436dEiW17Rce33qRw35Qu+GrBJ9RRRiWUVk7FeZ6gRtzGO+CD1HVg?=
 =?us-ascii?Q?eRSV2kwsdS1PX8WyxVIAVT38zhJk7XCouATTk0pohA1YDkw1PiViLzaixVk1?=
 =?us-ascii?Q?1SuMA6KLYdkkpI1nF4GKK03uIRaMbYlzIxTTAVrpBHKUclDdJTQ9X9zSZOI+?=
 =?us-ascii?Q?C1Rsx0h4hiz087M+f73AoCyTmZfypsv8jkJprLTt8zEMTIM1kzWyrnL4ZXUH?=
 =?us-ascii?Q?jUMnXpkfoDOHN1M3oebSRFOHx6L58QNDLW7C8wKcyL4+zMOYsRM8TEXJGHho?=
 =?us-ascii?Q?M1lCMcq28Axiivcqp2ZAiTNfqBBIaD0hY2OVy0br6bzgDUp3HZvJ6mefiijt?=
 =?us-ascii?Q?1qlUMbBI6qnOf7aodyKSZxB8qfodGO/B/xamFz7xhaopGfg9FG75JSYrlhCu?=
 =?us-ascii?Q?WwXxtm3UNaDsBc0jNZoZrrwIuA/BRHVOF9SG9AMQefIrytlna8V5eqmxWQGa?=
 =?us-ascii?Q?OEs7LLkhwBC34tZ7YEcQKduhLnXeenQ7wivTVTatFiDGwUiUUBn+D3MokWYb?=
 =?us-ascii?Q?anZSVunDI69N6mVIKeThroqNv+BF/KadU+P3yzB7s8Ss4R7OxLibM2hs3B9B?=
 =?us-ascii?Q?ckX7vuHSSdV+/VBgWzlq5hWHZnrU//aKrj846V4avEJQC8yvbNO0fkQnfH2v?=
 =?us-ascii?Q?At4JJWKpZRQuAXmZLpXQiDvPTqvuNk5BY7y7A79JzNJb36v0wimBPFXtFTVS?=
 =?us-ascii?Q?xm4GieWgXZb4veDj0QhjVKF9+1bn3CiH2ldYno69sRLsvecH3aR14aJWSPRY?=
 =?us-ascii?Q?ros5pvrFwJKxGTcCeu2/N1YN0SfJLhfEGABwQZd2/8X5xMKn7iC0ONozO2A9?=
 =?us-ascii?Q?FeUjAi5LZ2O9ujDsDhHPdlM/SwqtTgxrMIDcVYCY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1618edfc-b6f8-4443-641a-08db66771179
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:18.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGVnpMDyCQQPPLDQRpYPwJR0feydXLgqDK0N5UGbhjQuAG6adyGqevb792g+DcGGTgYCpRIdMthfnIEloJh2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: ig1uTxnJ2HB3_q_f7JxLIDJ3WN_fn3pd
X-Proofpoint-GUID: ig1uTxnJ2HB3_q_f7JxLIDJ3WN_fn3pd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
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

Adding multifd tcp common test case for modified QAPI syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..310484f6d5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2059,6 +2059,32 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     return NULL;
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_new_syntax_common(QTestState *from,
+                                                         QTestState *to,
+                                                         const char *method)
+{
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_parameter_str(from, "multifd-compression", method);
+    migrate_set_parameter_str(to, "multifd-compression", method);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    /* Start incoming migration from the 1st socket */
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { "
+                             "      'channels': [ { 'channeltype': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
+
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_start(QTestState *from,
                                        QTestState *to)
@@ -2066,6 +2092,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_new_syntax_start(QTestState *from,
+                                                  QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_new_syntax_common(from,
+                                                              to, "none");
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2097,6 +2131,15 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_new_syntax_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_new_syntax_start,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -2778,6 +2821,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
+    qtest_add_func("/migration/multifd/tcp/plain/none",
+                   test_multifd_tcp_new_syntax_none);
     /*
      * This test is flaky and sometimes fails in CI and otherwise:
      * don't run unless user opts in via environment variable.
-- 
2.22.3


