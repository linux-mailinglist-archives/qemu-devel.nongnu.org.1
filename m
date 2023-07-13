Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96C751F5F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1F-0002XN-Bp; Thu, 13 Jul 2023 06:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu11-0002Uh-3f
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0x-0003er-QE
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:42 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4xx67008873; Thu, 13 Jul 2023 03:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=VG5O+g3KxLuipuONUDPb41m5EhcsnGI3640aLEavF
 Pg=; b=xXI8xkRhJ/KNKse2nDk8q8Ik/vWuJX8EL5lRc6DIBoVVLva+S4gSNj7o3
 XPKsqlmot1O5+9i+ikR7aUSZEI5aGtOyB+TYEruXCtPYdoqhy2iFNTjw+ELzvAix
 S1O69paTUMhBtbBtJph+HWtxXfQKAwfS9NYtodWeyIlgfCBDrMweM4aW2AP8Q3j2
 vsoT7n9akPO+qPHWHrdjJLR48ucF5SCy7Owg6rfH9DGS1G2/XtWW4SS4bWwMQVKL
 hE2gSHKWHpwANwnM9/HYuWcQ/achEWRNZVD0yPUdBajTYkO1WRz20koQ/lmJ0zlb
 5hZ5M4h90t9LTDjSuQoB2Md7PAZHQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7uOlKJJW1NJ8QjtgaXsTayl7CodXhzFR6zJOIlk9qeCNUC2v7sSvq6/8EygLz/5ejRFPBxgBQf6emOBJra/g8E/M5iHtcVbAajvsv652S5+62/BHW1odMclXLRyHIBaVexEiibt03GC+fMDF/qxhFLyDCdWp1WzYZQu7EFOcZp9mPY9sJDYD12vp5353yPqdI4cvBvMCC1bdQ9kij2BjB3v9nY5iG/XfNL0iiCRqkxXo/26qdbe6+PQtODNap+QABMiBCHGn8FxrFl7C0AorlElM0aukB/hPIIMoXMnRf3etieCnrYQADBfi3vxGACcrvihjoc+rk+7uMzLFUBpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG5O+g3KxLuipuONUDPb41m5EhcsnGI3640aLEavFPg=;
 b=UuKaCQrMPkHhZ6QhigKBdp9MtVKaNJvtugyfqnCKR2OLpmkQqvhs6wyr8hkh4FQF6yAkNjk8ocAQyyZqD7RMGeEGlRyr2cvxHF+P+6tKIXulYQ2Esz6tSwBaz8QCTi+v8gfLQ7heC4rJ4e3qdltRwThhYVCjxtgcCdI0Z00TYahMZGcDRd0zkufbB6sygeo51m00cYEAiXixJnMp68w6dROPQC0Uy1Jg7/asBAFsY2GFmdQHBUWvSR/jhltvc7Jca0aNvGB153MLiObCx1FoC9AoeNQdO+vv9msWdQ34LeDgPhPXSGYxGmml+I4HwANZpobklKTtKU6dj3Y0BvYHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG5O+g3KxLuipuONUDPb41m5EhcsnGI3640aLEavFPg=;
 b=CRa25eu08BmC2QcMSn6CX2eOxn5h84URSMWxKNTcMrap9dm05cWsqxicRJ00X3m12dpxoF4svNXOAaJldJlkxbuFqUttl5f6JtHFvOGeeXRMfwGXZOwVA24f+eIAd/Z+Izjf5Jstd2mBTQX5jsNt/mAxvJGW6zPeC0fuFYbrPRH/AVz8SE+tZ8NLyf+nX3BCSZIh7piGiDGJqkQMYonVdBvbVbhivlPms28vMQMhOlw134CIJfd/uRAJE/0WrFJRdKESQZdRTLVUVqSuS+JUQLiByfDDnWsIq6os6qg7JU45h7PSb3tD/hJNeS80tIPmw0FKh/5fbz+MzMUYkFfmnQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:34 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:34 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 9/9] migration: Add test case for modified QAPI syntax
Date: Thu, 13 Jul 2023 10:57:13 +0000
Message-Id: <20230713105713.236883-10-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90337ac4-3681-4180-70c7-08db838ff61f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHcfx2JKqk8W5v3qAYLlKx6pqFzrW7Af/Mr8/FnshBSsnBZLiwRWDDM3xrtaVXK1PaSnkRVPnJCMEMiaWn1As6z1bMFvSieWhSUL020Q1rAQO7jKi1/KE/VXxyHq4HirqZzSOp32wXlubTRIBd9m/sgjtbQatkh2V+QyvO4ojSqS1ir5Mgc+M8q0A1+zdG79/MUyteVtwcplSYq6pfw15Xo4sRm9lhb00BfEM9Yknj0qG1X6qAoV7AxBokPvmQE7NoWgST+aU7tMrU+iSH1BfUXT+wdgbDrW75HoFR5Bn6tkOJI9hA9hpE8Z/9UZGXswacR//ainj29Q9B2SmhFRZKCrSPzC7xyP5fPra6Xu8DQTnz2FXePxn1SleRnjET+hCGLVLSVD7vor4zmncGVZkI1zHDAFLgSeS32lWCztm3MlgGLpHKlqBGKdFuMzwvksDd7Vb/hJLXS++Z7kaX8UaiWd9ZE3s1QmKGKbw6bQio6Fb7vv97CbKB+3y4CsHiTHOlELs6c7gXhErlyZOM0zBlQa6wJ7Oyxrxhpw7TW/Ds0qXBmnIhRwMtqorL2MA8PiKDQiT/4o6QZZZsRzJ4GZnzlRjSHWscfRD1M9U/0J7JOmoVh3iSutsX8Dz1ES7PZm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?satuC1nbP57CGOPSGJ0/0+RhcbKZ4w6v+Pp4PY/W82yNVB4P0gLEVSi9p03b?=
 =?us-ascii?Q?RTla2rkLixSfp4j+HcVl9TWRybYwS2G3gGiR8MxMaqk6o/XePRuk+NowcaY7?=
 =?us-ascii?Q?8amLjw5jY7wdjoo3pa+M59VN/LxKiHXnZcMkZa3R7ycuusWg1HGF6QOCRkid?=
 =?us-ascii?Q?svIoIw/Mtq6Gpk9LV5UxAPwbZxvne7zjMWq4gM1SBOi2GLebop3IZ1lrC9D5?=
 =?us-ascii?Q?aKGgG2uHgpJzrGL3juHSKXCPd3TN2YCxElPrpbnUYg9501Vqzz2MGAHUJIfn?=
 =?us-ascii?Q?feux7OYZvjuN9seproJq6ugXkq7ZyKdQtGRMEX12PPazGtB7Abu9LuQZB3UT?=
 =?us-ascii?Q?Fv9Ltt92SQuHr2VGuGgeUrISStAT1rQwu2jKTI4UjbBAvJ0Q+34pC2O/Q8sT?=
 =?us-ascii?Q?EwmgdOLwalSeLIZzZ5Z6ci8iVjGo2C+WL+7DQYu8xRkLYof+n21RoOeayHtR?=
 =?us-ascii?Q?7Y78GTEANcwPRGVoeVyW4cKxjOhnRbiOVpY4D+w0Vc6HB+7cfTUq84FQl3Xl?=
 =?us-ascii?Q?0s4I8miEOOxuggSDf46YrEtS2SjUrr2ZVhJhJCnl3BezwknaMqcxHSW3jjwr?=
 =?us-ascii?Q?BO4louvIsfiHhcOlsEBxS0KTniKXS49kt5MJBm51K60PJXFqdsbXeCONHw0M?=
 =?us-ascii?Q?82NM79zfbvUqID1MueeW0h5KDSsnIxENo45tbdTBSDHaNlYdRcqLwwJePnhr?=
 =?us-ascii?Q?IMiN3x2+lT0VNudYiMqfDtEqISgvEe2kqyB0zTuCZKoMX+hXwxvi+/+u+4L0?=
 =?us-ascii?Q?JWRbmwKmkWEG0Tb85q3qXKJzPQBf2hD3XzZQrV/5KkFrSLFOFV5D8wi4+gPK?=
 =?us-ascii?Q?yP+8qblp01libj4GyfKkuJZzKTQTnU/b6kFhVMeILf0u2MYd1Kxnq9/Hsbyc?=
 =?us-ascii?Q?BVwyA4gOkI21Al8AfF9IKqzb09tv7m0ReWCPFsDzBmELwKNnhrsidS75ScoB?=
 =?us-ascii?Q?PhfDBhNvxIY1UNxyrJqfPTPx84j764kyxZPVv3+C5aB0DEdijqTYOaaX9yqS?=
 =?us-ascii?Q?jxQT2vI65o4zouRXFCWYdC5uNjbwIkON2391LsfVjMqRGUOLoEB3qIybfny6?=
 =?us-ascii?Q?9k0E8Gje7ibfvhpk8LS+z4ig4iteZrGH8QAGDxJb/nnAjj47k1kIg/QY++i5?=
 =?us-ascii?Q?neSW5PJqDk7Ku2aNQtpvENNiy1QlD3+lNAB/0Sge8VXfNjZpLGfdDu0u/NG+?=
 =?us-ascii?Q?JG6FQaxf/xDZOJ1faF5I4IJAOAWc3H56MzmyMFHCOAIm7nlm3AMv9H6QXong?=
 =?us-ascii?Q?MqSCwLlHSbeXaBsa2nBpY8hAXLuDxfS1jQfYYjqauTBDkd3pHvY15rimWGQM?=
 =?us-ascii?Q?DIuaPnUKnNi+l2VVAnSAqMISnTO8D0RAY10fOkFSSXIupgZFwDctCcCLiDUQ?=
 =?us-ascii?Q?4KDH2NuataN5A6eHJPvkzrycX5Z9EKcCTYxS+QORUMkxwxg2cXb/q+xI3QnQ?=
 =?us-ascii?Q?8sIgsuSVhrEu/pHOgCCfR0Vbej+/zAKT5xXI1+96tc72f2Ps4EXsDpyoZQce?=
 =?us-ascii?Q?tt4m2+TyAsLDsGuN2dmgLmE0D0Qvzwz3zyB3xs8ZcVERsYqkaW0dLswla5t7?=
 =?us-ascii?Q?mIFpgtDAru03ktPqmhBTzxRjJuIqcOINEE/F8vA7ZK+Dif97rtriUpJWaHcG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90337ac4-3681-4180-70c7-08db838ff61f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:33.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNB8QZUieOwsRu3P9sq2KXvoi8KMSNZH0vyy5X89JXI/SW1IuF7XIjw+mTHTQnAZVAThGiagVlkBE0eWZFdkBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: VLPYvWvP2vlfSeIzICskvDiFD7UER_VT
X-Proofpoint-ORIG-GUID: VLPYvWvP2vlfSeIzICskvDiFD7UER_VT
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

Add multifd tcp common test case for new QAPI syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index efa8c729db..786e6bbe8b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2190,6 +2190,32 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
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
@@ -2197,6 +2223,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
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
@@ -2228,6 +2262,15 @@ static void test_multifd_tcp_none(void)
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
@@ -2916,6 +2959,8 @@ int main(int argc, char **argv)
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


