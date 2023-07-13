Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65865751F59
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1B-0002WO-WB; Thu, 13 Jul 2023 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0s-0002TI-2j
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0l-0003aS-TW
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:30 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4rFZ9023249; Thu, 13 Jul 2023 03:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=vQMgQPExDq68RDt/jOd1usP0Vvzl8hMoEBNkVFMbI
 O0=; b=tqExd2sCnIzG5xRTDEeh04nQ9K6/9SmZq7nJgp0BxNjr04VRfQl9FpG1g
 VEKYGy5j0CsCUalGrovhFnDZ9d5ERVPT4BGM+3rrs1QqHASvSYYyfF8SNfSTGR3G
 PhVx/Zc8XbpIQaH6j0KWCgreIVilkMkx0lU3E9nCDuPeZno048XlIRTs8yWIJnpl
 dpVuYqnrW6h9oROdxwKnPqz821H/7JRt2heuOz1yqZvtdYr0TswTTBJrX6tXUKTz
 vipoT75IxXKym3VldNGf3k+rIEyBLOZXqzxVIiJaEO+nDEfesdhDraW1yi6OZMKP
 8SAi1DU/GX2DZQUEHexAbC/eZhdZw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3srsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4L0F9k2iDa1hrcwA45x/kJeVV6AHPgCwLJ5pDvaEQBjS9cEHjYMcwEulfRm23yik7eVLppyq4FL8yc3T9tgJLwrR5Rf0vaQjSjxAAWSrBdyVz95h/05nRQAI5v8OCywzxgZkrE8n5T4HVtWplIKe1ANH9J5K3nbKQv11Ww7k6ZrjRxX7QsceWdAduWCwdyferlx+jS4yTJ5TDjIBAtH9avrHYtaPJrK9rgTfWjjJGPEvTmwnHZ0h68TUEGapKhKZe6VjPhCuJBv48pnKtzfxXTaFT79MWHkQ8R8tl4kUvBOVMZuVP/gnSrfjmEhL2vE2O6aIxHbntKK3P1ZMIH4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQMgQPExDq68RDt/jOd1usP0Vvzl8hMoEBNkVFMbIO0=;
 b=KgT5JkHq6uwMIcb2+/IINOwLJbO8757azki6xfCc5rliqPC/B7HuRdi68JSeRhPqMumtZakEv30Mdohgp2H/vKd7Sg0NIxV0RYzt2ZvmtRwBTrrxcxEJpEzOJk3SDHfGX2c4GAFPfcLhihtYbw4qHe+vn2IdK/GsmRTeWY/ZuYJRKmfM3+ZULocmWBKT9WINT4NeIgwtRA2gBkqmAh6OAlmRRTQtgU9BN3oi9v7BPYDTqnSv8vbRw50gRDE+uEkS0A5JtrMukZ6VxHP1J9bLzrhR2VTI6hhdBmOS4FticoP47/48ikQOrYjFU9ponK+zCMXcS3kNQ2ryQzhTLL2t0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQMgQPExDq68RDt/jOd1usP0Vvzl8hMoEBNkVFMbIO0=;
 b=doct2xPnavbXIFxoO5pH2ztiKSd//qSQWkll8iVNW1B9HJrbs9Did+h22mICUEdtT/sY979H2Hpge9mcsTLDOQvOZYfHpUw5SywTHVu/TV1z0hXkGDWtjzA3hKMw6sp/djIT+geYQqHiL3geU6Ptj9LoTF6WO5rJmv1CE27IgpkWXcsjrUA1VkvuWtV3f6r20ClqquKzfrtHwx3rqcC0htTdCGTn/lQNuoj/rJzsOz8GpJ+LN3/kQZZO1zzBe7UaxsJbJ/CV7jz549x3ntjmgI3/v7HGJ+8H6DzybcEhmcLdry8bmgSZtadJa1AGH1S4uQulCIcKW092fwQXoTG21g==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:22 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:22 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 2/9] migration: convert migration 'uri' into
 'MigrateAddress'
Date: Thu, 13 Jul 2023 10:57:06 +0000
Message-Id: <20230713105713.236883-3-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4d2336cc-ff80-452d-e50f-08db838fef19
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZjeD5GJ63athOT182GNdvPNaC1+Jb4aEQDGlIGgQFWzBHJ9C7A89qbYPFa629K5N7p54jjokIo5DpbIBnue2+/8N1WdgqZb1HyfaJSyED44adFWAXb0e9114QVYbMLY9+/QjFVZvl/HM/IBacafJQrRQ+VPKr+l7qmBr6V0ZHiQTXDPJIxvuS/1bLOZB+Uej56IReBrZ+luBNtZs1EFlZHw+WtluBRcuEv0D87p1u2HmocANErgMn6Typb29U62Ol3I8/y9udxOY3bKKHG3qCsCkJlTP1ih1pFlgvVtHDfbTwyCGR8r0HTHW5bwF2SUQvKbQc4KzNubQCpDbZbsBVxWm3WHe5jEX3YEpvYpIodA6gbiDdscgigc4Ok5ZyG9X5Ae7S9KChZoKUG9iWYbZE1B/wOnNBniUNSH+EsRGvDEI2s4xeHB9Hnp6KBJBezrJIlgrYi54BRjXZRpe5YXVMykqf3Smv2pCjOxYS6/xMp31ZJ4twZOr6pT50eDpqXZl8XSdPnMjgEfXpINZT3fjxGfdLMK0w3/3dZpWygjFUAV1vsx9mXi0TiJ8v4UI9MNSABQT7lKwv1yQI+i9htlqWL9cEO+HzHJ5GPiSmF7OaXLvGikvJEMmaAYNffmddyu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTUR1iT+7qAy3Er34S//t1o0s+hgwRh/0gEjlvqyoWUG3IkMHcwL8nzu5YRD?=
 =?us-ascii?Q?i+SKqSAp9ExwwVzw1hAhmOKeROabmSb/B8hpDqa5M+SgQmmaDBeuwIvDwv4X?=
 =?us-ascii?Q?NmTxutZZShwsuD7KG/ck5pNf/cFbwWZQNGkNJGZtEY2zDs2RBVfwcPCa8Z4t?=
 =?us-ascii?Q?5b6EEMan9wnO0cvX6VgyYY05410ycr4F4Hx6xgaY4orzSNxT3U3MJgbk6CSe?=
 =?us-ascii?Q?wkIErGyqq+Y9770MxfWh1OX50FHrPswG8IZMBhxuWfGS2V7u0egF6yz19eex?=
 =?us-ascii?Q?t9bFhx0/HjD06Zm11IxtLlDa1lusd/1NFRjvmsOJr1GCKqykoiIrFc9jynuC?=
 =?us-ascii?Q?4Xi5gqE7BKFEkjSXCq0jXml28kw36jQJRmsrQ6vB3H9qO8nnk9kh9EVGpHEF?=
 =?us-ascii?Q?umiBRQ459/3cKE4gR63EeE+Yzo4QyshblqJh4x4W+0KUwY3VripkZyv5YhYq?=
 =?us-ascii?Q?t9sPea0LTxrO2cYiLkYH7szqGBiFMYE1sOmCbFxibdWeCyS4XzmfqDLKurJl?=
 =?us-ascii?Q?ALvdiMxX/4BC2pQgKfptBSt2gZMuDn6OHRk4Rv09+tez4zltkaUgwYZbyyup?=
 =?us-ascii?Q?xFaiAa063Tt7HZq8LKizwsYL5VwzLy9YUUeS4Nh7NeL7Urskb6b0/N7TXLpG?=
 =?us-ascii?Q?vaeHITEKTJuG/eJjIV3bELZ1+8A76U1jB2gM+S98G8yp4vtahp5k0+uRG/x7?=
 =?us-ascii?Q?P1pg5SIwSIKUI6X0gEY1Swl7vmJRG72ctE/w61+NFFDX2oEQu4Nz7pkest/8?=
 =?us-ascii?Q?LorRM75VE88XVgrtoOt6vyxP/cYBWT9hESp4DXvrZPL81MQUFc5Q/DHMhRs9?=
 =?us-ascii?Q?5iUEHzuOh1EgGOdQDhzfyo+JcpSu61nvOhv0h2B2UaYG/QhyFLnCOaOjMEP+?=
 =?us-ascii?Q?cqelLNR16+0esO9bRICOkgW8a58mu8zC917iyH3p4vrYNgaooCZYh9puN2u7?=
 =?us-ascii?Q?NqdFzUAivTKJige6juKNwYzW/lzFFlQG6CgkmnvnOmfOZ7M2vpShXlbVF5fI?=
 =?us-ascii?Q?kQZcPTWUvakKXX91i/yBpCzG7269rlzbB670R1YCVt/fyv7DUs4c4beoEilc?=
 =?us-ascii?Q?wxsOaCpEiuTSXJDpdUcDvjc1CgvZppvw77TELysoUkO/vfgpXoKNMl2aCLHG?=
 =?us-ascii?Q?LyPCVZWo75u8FjZoY+yxerbbSZA1Nzpd0c8hNRS/ZL3nLD8lb1lWrzCLxfNa?=
 =?us-ascii?Q?SlaosM4uVTEVfHu/VK1W6G19IcSv1mPMq/mLQRBaL+mAHtD3wccydA3Yqupw?=
 =?us-ascii?Q?SXzR/2M2h5GFjnp3G+/xzES24OESIGFkXbm3S8SlTb3A3eeFgJ1IePNVNUHS?=
 =?us-ascii?Q?yfoZBjZkrlUFN6LCC7jjm3wcQ4ntv0LwAJuEZXihngRXawsZtUi9cM37ZbMS?=
 =?us-ascii?Q?U3rwyNk9WpqTxw1aL4uyT1bMRgjAPXntOW0hC+7Evhfk6TNhRDXsFb/oWBKR?=
 =?us-ascii?Q?zzkzrSYMJsyu5pNKibQWtXP9B1Q1LL23bVt/89jhhkJLnOQDz+7flil1xqRm?=
 =?us-ascii?Q?FKJkbyuNlzidVUERDmUDeeffj/YYS0OMu15De9HOqGigUaCZg8jEZpm/8J3T?=
 =?us-ascii?Q?5pXceh8xP66vPtb0v8HxTWOfNY6TiZ3tnj2QcXzVWZQuxPjg1qh1fhhYs+3p?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2336cc-ff80-452d-e50f-08db838fef19
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:21.9788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMRhfWrUva+mYL353AkIVy+iKzbySDN72OYGRrbuxRj5njpOQ89DSlyZHf7eO49HQ+UweBUVH/QL2VoB5StloQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-ORIG-GUID: u0UJAatogagt_VWyeoGxzKNvot6elMeQ
X-Proofpoint-GUID: u0UJAatogagt_VWyeoGxzKNvot6elMeQ
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

This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
string containing migration connection related information
and stores them inside well defined 'MigrateAddress' struct.

Misc: limit line width in exec.c to 80 char recommended by Qemu.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      |  4 ++--
 migration/exec.h      |  4 ++++
 migration/migration.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 2bf882bbe1..c4a3293246 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -27,7 +27,6 @@
 #include "qemu/cutils.h"
 
 #ifdef WIN32
-const char *exec_get_cmd_path(void);
 const char *exec_get_cmd_path(void)
 {
     g_autofree char *detected_path = g_new(char, MAX_PATH);
@@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+void exec_start_outgoing_migration(MigrationState *s, const char *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
diff --git a/migration/exec.h b/migration/exec.h
index b210ffde7a..736cd71028 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -19,6 +19,10 @@
 
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
+
+#ifdef WIN32
+const char *exec_get_cmd_path(void);
+#endif
 void exec_start_incoming_migration(const char *host_port, Error **errp);
 
 void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..af2ec50061 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -421,15 +422,63 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
+    SocketAddress *saddr = &addr->u.socket;
+    InetSocketAddress *isock = &addr->u.rdma;
+    strList **tail = &addr->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
+#endif
+        QAPI_LIST_APPEND(tail, g_strdup("-c"));
+        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
+    } else if (strstart(uri, "rdma:", NULL)) {
+        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
+            qapi_free_InetSocketAddress(isock);
+            return false;
+        }
+        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+        saddr = socket_parse(uri, errp);
+        if (!saddr) {
+            qapi_free_SocketAddress(saddr);
+            return false;
+        }
+    } else {
+        error_setg(errp, "unknown migration protocol: %s", uri);
+        return false;
+    }
+
+    *channel = addr;
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
@@ -1641,12 +1690,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (!migrate_uri_parse(uri, &channel, &local_err)) {
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          resume_requested, errp)) {
-- 
2.22.3


