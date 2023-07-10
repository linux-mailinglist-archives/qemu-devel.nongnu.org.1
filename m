Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56974D579
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0G-0008P9-RP; Mon, 10 Jul 2023 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0C-0008Mh-92
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0A-0000nw-LH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:28 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6fhdO002035; Mon, 10 Jul 2023 05:28:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=PZMOLbucO1Z63YRw1BrTgRFraVE6zRGEtvM8yL47G
 6E=; b=xbsqlTMSEN7OWQ0kbobz0H7g3Q7UV71C50jAX80GaTbrMv0jTHyGKA150
 SjOkDG2IH3A43uGuV2iDE5SMFXev2GVWFPdMLvLmKVdhwdolpqG0s3OUKVOxnOgJ
 VJevR3//zUQDPdRIz0sA2fTlCGFfJJO574vdFHUmayVaMYcJXsoZdIeoKTXtJZfm
 a6IhKBaqj4ijvLXCd3ZXmmBHTWAcNZw9TEb5aS7W4pyl41Gc9rXQqeY7YQuTH3QH
 rXFluG2E3WusRegwRnDDfMFvyCXpmPCOv88NOpI3X3q79WCpY1Bzvj14N1ojhQ/Q
 52TMgY6VjyPKW7OoRxhyI3iQ7iO5w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq5b5b2tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPix4d/sDTy9u3uUVA22iq1uR6S+/wsjjwXWtDUFNFpAXV8ssDGFTJEYbPMVP9I05FHiw9ozrfAytzvq7qhd7Ydy13y4Cl8dOcysyYdb6uZESSjhbCvh6RvBb/L9T6iawd4aHdninCI1z8mfTx3zCxrEYvUwb9HftZKZkGa8X5GFd9N84SWxIgY6CQnW49k5OpwR1vFnvDtYvQ2IlkdWBNHljf9Lc+HokPqtxh3vhxF6tIreOnq5kBp2KFEMUtnEm6/2AWz1D4BYy3S6oaat+GYEXJdi1OgyaNPFRWiW2GGFPYtfhh1l+NpJpk+q3ilJnen/XAqzln8NDmXvGmSzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZMOLbucO1Z63YRw1BrTgRFraVE6zRGEtvM8yL47G6E=;
 b=J3xYodHpa0vwOmRPAeT3CMWOpWnqk3cXNPwBxi8YTdcmQjN/KSVzofctEPwfyxejfvbxWMc9nmUjXSbbGIZjVwU9zjWvXRrPZ7TAcFy1vaYzGS8FAcCpqXhu1HdNTrJfI7kkFJtMNaxUmwaWd8dMhBvEehLR5ixa6JN3QvvzNggxUMSu/QM+j/OSRM5Elvx5tYXur7Hyr2vq6XhFjjXZlhCgWoIM6L6n6W9nZDUmfiScKwh9z+UWYM2lKpXAlJPbY/K+Inymhy8Jqpi4OBcC03JMYe4LPX2e9YkPiF0zHwfrJ9AgTgE9jdxzfIDVxlIpF8CS+oiNyNP0PU2aaIdEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZMOLbucO1Z63YRw1BrTgRFraVE6zRGEtvM8yL47G6E=;
 b=FSxGrrqQqNqFUMvyepIHn70IpVFPReXi02J96fygRJ8ouxuBFghV9T79+q47ynp0UKvrpMHU0IvoKtjmSboQW1kwPKN2WenFhTa25Wi1JFQ0sCTRPS7vE3r8E3IpSequ+Dh0sdIkcFgwusGYVg+LjlBsmevgnqbEEaCl/Yk5q47Q85SUajFRWeB70IyzgcoPiCpsXlKcukOtt8SZXsEv6QIwcR0sLmiVGCHirp3NFW27E/EZ/zPyVwf+rBBsM+mkWlumwYFqqjd6BrGR2RRvkrW60W9qLJN0+DWGCjoC3JVOszJAqIM/snmUrPxsPIAOpdIw188avWJMQ4U6lD84jw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CYYPR02MB9688.namprd02.prod.outlook.com (2603:10b6:930:c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 12:28:24 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 9/9] migration: adding test case for modified QAPI syntax
Date: Mon, 10 Jul 2023 12:27:50 +0000
Message-Id: <20230710122750.69194-10-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CYYPR02MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 3316cf9b-8e96-408e-676b-08db81412780
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJKbOk8lO/j+7Z2MFJHyRdrAKRWesE95pl+WHhDkqvcDIjJKeDr27t/elDb53smrtKwP/egXVlD+uAQHRJzdGk2BCwUgtGqA7VGsDHCHIRXgdmPPCk27oFhdYI1cxsBYULS2eJq12DNtTy6IrkrCofHoapgw0eed8bOgyb9UYntBRVy4ckgr9Je20LKtbZ4rJPN+7VItzTYObrJKrXw8fyCDGKoxtXLzSCJktKi/SqN1uAiMQXlmZzp1N0knw85Yio4OQFecMNgWtAVm5aYcjgqfCkKrSWUROOSsVbuhi+0Yge2z/xRmhkVgPQ1WMWEaWR0MWJT67CTE+b1h30wSe+wEIy6Rac7RvU94T4k5Zs1bTS6SxjIWJ0ubeZnAPgJvpFd7/sh0w18y68wJfjjM0x0RjiYdmhuEy16VJZha4AHZF3gl6COFUtCdzGAcsCKMYwm5hhqCpZ5unmmTc4wqX3OhOo5zuZVfSrh/nkXZEYmdzlE3xT5il+Fg+cQWmx3lvS9ATV5LKiGisw4srw4U9+x8mSjl9du+vBNgcVgyOJ7+H7E7dhDkmtmFp7jsVm0gZbvxvK4ESeVrY2cAn+V2w6YlPdne8904vsBJrz96SUROU5wKfZF11FfvTjt5LaU/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66946007)(66476007)(4326008)(66556008)(6916009)(186003)(2616005)(86362001)(26005)(1076003)(6506007)(107886003)(38350700002)(38100700002)(478600001)(52116002)(6512007)(6666004)(6486002)(2906002)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7hSM7YRCT6zvEdFo6eJ2fsGWXECUmJFNWMvDtRvVvXpKlrCnY/pqVX4Rdg+H?=
 =?us-ascii?Q?ZPvjAUtjSjQR1MZQdvLXlyRFrwGD+X9PhxqUTzOBUkfRB8lxISrsjKC66gr+?=
 =?us-ascii?Q?QGISVdEe0+LQcU/hCyEKUz6QhEtEv0GYfNd3rbHegDX9grwcPaQXkA4jEPe0?=
 =?us-ascii?Q?r8QQ7ckPELqFmY1OvSyUW+lANl3D1FJqhhlF9hJ8NPFJRKUIGfMpEc90oJrB?=
 =?us-ascii?Q?wDiaxff4sTlnIctNw7arA7ow6jWTbaxNR7haKbG4+JMDsUFc0uC8yosVv8Qu?=
 =?us-ascii?Q?8MMH+twefGzszcOJ9NOoSgNEy+9JvmSaRUQBypX3Wq+LvJyfE1RO146nHSd6?=
 =?us-ascii?Q?By1v5crtdQKBBqD+/zwfq8vLNyFGjnVGNzhj5Z9QvAjrbgDgIADvu7uL4O1N?=
 =?us-ascii?Q?JE0tanmd+N+O/160CJGeG1991J1CporyD4T6ZBPCA/8VyD5WbenG+Wka3xlm?=
 =?us-ascii?Q?6VB6B2E3DKJUC93iWDk7Y9y/lHqVgvOODqpN501LMhhRYNLUhmoBVQDtq0zS?=
 =?us-ascii?Q?6dQlsGNhmugeq4amTRrrO2+swuWBhUv3QWfK/SHrV/Tqf25414/eSSJv3U34?=
 =?us-ascii?Q?PC9Dmp38re8W6K5QhYWMiaFK02uq0yw8REWNg0aJtrTZlOSRNj2C/mbOIF1w?=
 =?us-ascii?Q?OXEpTIC1xFV110cne2npda7p3xlp/2pfIWHGTLNyurfd6DfvBmMZBDi80i4b?=
 =?us-ascii?Q?kJp2zfwqNddgo7d0kD5VB82Y2vRVcghjJLcLASAsiERu1zq+INlltNnqU9kp?=
 =?us-ascii?Q?7j/1WgaKhjMirlwe0QfcYuaIwcjPStB+ly3vLCdzAEC3x7zv0VpbNWapfk+Q?=
 =?us-ascii?Q?kliAy9pruycU8e72mfjPz1q4hqq5mEn+Qd0iYyhrJhh+9QFGTLJCXAgsQICn?=
 =?us-ascii?Q?cvWfu/mPF4++f+S2Qaa/si+rETKUM+fEPhpqZKIvmliA30GMvsH0rWfXSYe3?=
 =?us-ascii?Q?dWV7yV5Bi2A7mCDOmGNVNaOAzmrm19u/EgqJnxjVrCmaG9F2xqJESKgT/qmH?=
 =?us-ascii?Q?aCPRenfHTeUKI3J4R7hHvnGG+q9lRdJZPgWa2XEkYHDiTJEGDfy1Jf0SdHYL?=
 =?us-ascii?Q?Ysj11LG5IIJp/xdml6+zvMPyi3MgIt/bPf+gWqBfVN5ZpJdC8M7AiEWnU+BA?=
 =?us-ascii?Q?vEHXxhAhLxIjdJLlT0zjFtsUVh5X4gIyCtGdOj/3soHpeLdPOqFa5YDgiZeB?=
 =?us-ascii?Q?5RsBWAC6NsutXqEnOGz6TdZLTRZ048IeJjRHeTrH7qIO763DR0h4JZNPinKp?=
 =?us-ascii?Q?oEOOhb74Aswqto9NUmPh0I43+CjD1tDKG+5QUua0czKBKkRgUYb0/uRPNz/P?=
 =?us-ascii?Q?t90MuozyITFdOUW3hQ/HwqGvfhJcQk3XJ0n7ZpGuJQx7f3PC/7PprLdiOtbj?=
 =?us-ascii?Q?IBB9H3eCztWYOKtUJC8KCj4nL9lV77fCr38qsO8PnRr+gQ8fhv7PUlRB1iJ7?=
 =?us-ascii?Q?jGtLHpvaakNpdVr9BVUHLnfXCOOArs1tahpbqJD5gzwpMxrw1UUYJCywuTbF?=
 =?us-ascii?Q?uc/aEnDjGdJH6KyuaHZremRpdsZscy5X0DKnF/8wXKBo6yC5jCcqaBglQCr2?=
 =?us-ascii?Q?fZY0NFKnAsEKXHtHwxfzEs+HfzKeaHF5HkW+TIbRiSNa4C0AXgBpToYTCoEP?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3316cf9b-8e96-408e-676b-08db81412780
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:23.9858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq86Ck47bXO4TODJ+LqdICbfzPzUNvJIBr4nR/AAUxleF4EWaqqVzIifyEgK9cswH8chLjEsT9ZT6IQEWIjNfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9688
X-Proofpoint-ORIG-GUID: 4yhIp3RDY0ywZ2fGU-TePI8fQP0rjj4X
X-Proofpoint-GUID: 4yhIp3RDY0ywZ2fGU-TePI8fQP0rjj4X
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

Adding multifd tcp common test case for modified QAPI syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b9cc194100..5a876d67e0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2086,6 +2086,32 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
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
@@ -2093,6 +2119,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
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
@@ -2124,6 +2158,15 @@ static void test_multifd_tcp_none(void)
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
@@ -2809,6 +2852,8 @@ int main(int argc, char **argv)
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


