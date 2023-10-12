Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9157C711C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLY-0006H0-0n; Thu, 12 Oct 2023 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLH-0006FL-9D
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLC-0003eg-NW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:12 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C8V1QZ011765; Thu, 12 Oct 2023 08:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=DK0oY+2gQPntE/m+PTKpxu35lGkR9z7N492OTm2aM
 VA=; b=C+jokhm23GZ7A013MIdHPYTgFSRFeMlk8fh4dPXrSXT5HjORAcKE3l7uD
 kxmf6iymr5870A7TAKKfjb+o5aiQXrLpEpvNLybBsWBxfTpSPSF9Vg8JHirqaPfs
 /o4bz+sYn+kGqIu7mZ8+Es8pwKXrQ5LgzxYw2yEvNG9bA7y5WEbGNtQXxHGUPYZ4
 FEmZJW4Hpc0euERMPmyTu+LNuXmUwXv5ooN3X+a0x+lwN233wJxnJ6wjD7os2/eQ
 TBsoo8Ap32unmALS4EeoQG0QyE1yh42hBkF8PX+DWks5so5tDpLjKVfzn+qZy7BU
 tmVVT6Pq+R6kEykHMSUqyq8E31wHg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtc3hc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMQtaN/sLzYNYTVTV7k96ikoexuPc21ilMqWRMqrEnzAxHaDCixILwrORC/seSVY6brr0RaGRRRSZw4CVZnYMZbMK45yuedhG3xtOh28hQqVMTZKcbR0ukQtil5VEUi+2NtCL4U1EXHktu1vOKwmv/O2inr6IwjnCx/DYu/p0PhbvAQd1wp2JKBF38KPAM9Tdh4aPfZqb6fyitfke6iW94t0strFROsj8lUquoW4JCbh8tfLZNdu/YCKHDHYw1rcKPk/e/Bk0wfPf7+RwUSIarovirYw/IQPdSn+mmET+FVPjpvPSCbMlQYgLiukNI9unK/LjbH9E4sjZ7ssgIWDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK0oY+2gQPntE/m+PTKpxu35lGkR9z7N492OTm2aMVA=;
 b=PnevWcD/8XjGDXhZtVkAnYLYNBa6NSDKKJ3mQ1VApYPgkf47vAP51/X42iu0VQy+6tW6cxxR62I3SD8J+Pid6V1ljYIbr7POjS6y8Fz3RM7pKuBbcPTzgV4Elk1IXhc7ObiNXODaPNFAzagELuDEYeMxweqQa6N5GaxT8SjtqqgM/nCHx9vqFLuJ2RwGpA04ASjDXR8ThJZHuOoNYWqIpIvpdw+hEBM23a3/oAKe9nfxHXMQx0EvSOJGxSnXZSUlYFslWMAyih/Fjfyev0HHyt+vd8nwoLWVPCgHw1yPYudI69mBKIie/bd6QF0u2rZ52RVEf6+uAE63zkYRPyloUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK0oY+2gQPntE/m+PTKpxu35lGkR9z7N492OTm2aMVA=;
 b=mqUYB9jhI/dWrlOn45iqlIvIdO9KCZ3e4nQ2I90rkOh9B6OiUeVn5OHVTa5CZP9qrONZzbn1NcMReITumQEt3FsGY/b7beQVgb6EUDsbyK1CWrROIoLqJDQE0bhR/EFGxoBozG2Hgl/P4gJpK0+ZIa9vpSNwuO+1J1LusqlAo1Vh/oZu/t0ZG0s1LcELuzbX3Vz1qFwf7tIY4lvpqHQULBkIYngM34Gx8mHXozvJLjr5Xi9di81JUf9/DR8a66t2ynC61qLpalGQ4ablxxN+T7IoWLLtYS+XuDBk2HENwd2X4fL6+k77Tx4O4A/yobWv4WTaW4Phx1aDBtFb/TWzFA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:07 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:07 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Date: Thu, 12 Oct 2023 15:10:44 +0000
Message-Id: <20231012151052.154106-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: f8055b9b-8d1b-47bd-671b-08dbcb35756e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLreAVATtq7qZOMSd/17gF3Aj86FPOLRYN1oTQLAHLO5S8hbOdFnQNBw8fzKUX12Rp/aAc2HtjDwc6E7gs+2zlq49P4NPA5tj0naXNFOAvz7JTRADjJou8QKzd8Z92BPGpfy3zR61bnlG9jsZoleqxfKpzkUjLwCWWONan0oDWB7BtCTnKYywqw8LdHRcKo/bZQ2g2iwkYTgpvn/UC+PYNvmYh35QzHY/lp9h0zb/vAV+qa4zfYwjTGaYFItt5gUgdRGpOddDq9tImA42Er4RVRhthfu4Zwwh4kGtB8Mfky0JVEHSOgdFMA6IXt3zkKG5GMZ4hM7DpfNFTedTNK824GzOC9imVNwMtuGAQR26ZI+uj+fnZfaeSc5Sj9Z22+JC1TaEZkVho2szB2e/HdmA/sSGC8SemsLJm6vCjtLRsvI1Zx04u/XrdYkxN3dsH4USwIU9budxlpS6I4RzsvWxWFB/T1+A3SbZlJfCIbvm1ov70XCfWpa5GIJMRgNW4Dcw4JYovwjsT69m8ss9aO976k9236FIT35abhKLI+O20DIZ+GknQ0W6N9VFdJT1kx0HcwmfgNkvrVjAwCzoQ5tI2CuzJnllK5amwaOpxViJs3SIn9gNLBFapYKb5bPEykL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quHZk8iWQgXgDC48lgZoFgWxB+DCl0/Uj090MZI0aLtrt9qhVf1Xbtcl4+Ae?=
 =?us-ascii?Q?LXpZq+7pyset/hFH5k+whanPEHgXesPyEmW+S1w56jzfyGsDyohEbvce/VUB?=
 =?us-ascii?Q?ndN0CXklh+dzLlGCTkj5vKA6GRofsZgPwtZdbTN9rxK6Kcz2ZtOg9LDBZSGb?=
 =?us-ascii?Q?6ysjX0S8GbvURiWC3ZDIJE+gW5zqR8byi0v0NT3vkv47gDBHhnnV+gkkMrZg?=
 =?us-ascii?Q?vRqRKWfy27/smc21O4x+uu8i0ckwb/ONX20x58UElk+FqgZOUbrbtD6A2Ct2?=
 =?us-ascii?Q?WvKf9JRCSS0VLu22dyVJ2Zd0TcXXjK+lG/YfD6kSU7yACyepBtv6pxt7z2mw?=
 =?us-ascii?Q?hyBxsW5OCWuAfn9EO9UiSUgftUeqbuiB8CSPh/oQFj/W3pQoY8JV4pqczIUB?=
 =?us-ascii?Q?jHVy1oChR6DBqyYyMPbUe8zAFph4079Jhys0hF/EZhQPMs9jfq/hecuswa6i?=
 =?us-ascii?Q?/yDPrh2mz+IrWpmRqe4TJE8ZkX1QaEHJtRycs0dusuftrA/qB9ygwLLrQ+Xu?=
 =?us-ascii?Q?IJOx7GgWWCWpjSpLZ5ZZrf4y9c7bUkMFg52itx+ce0gwuBFYEae+ZDtkSpkv?=
 =?us-ascii?Q?4OkcyQwhYycZ4ZkkK4OgY2gr4r9bUXpBDvyXAgOtKNFpD5ZfQlr3NPbgnMUy?=
 =?us-ascii?Q?N34WQ+tLefbgEtHwwoWwKTDtVzR7FcqCflc+YHSZFkWVEncl6ti50vMBk85O?=
 =?us-ascii?Q?P1FSPMezRD8g6tKEBeXvFsoB0eVE2NSM/hil+MMpAH0v91nLXX1m0xsd4Vwc?=
 =?us-ascii?Q?RPlsj//eZ+Mge2PoI+64FSna3Ge6Tw0jCarFej5U2e+1RN6cxtvNoRM/CJY7?=
 =?us-ascii?Q?pvqhlDirmW0g1QnV/VT9a5upjtO3KnjSQYwPpgeqsHDw3dn7cAmJO90OlyRJ?=
 =?us-ascii?Q?31NT6jbB/DSZqwmoFVj8dzv3RT3XivKRL6qNm2FRPgnqwQ/OphHrd6HLiMqR?=
 =?us-ascii?Q?u6esSg9lkQSHwPyZrpyHUOsqtMNWjRq4QAuMq7sMrvVXErNaRrgar2XE6iET?=
 =?us-ascii?Q?DwA2+hFGm3eIKn2CeF7/6IAuYQn5UKLL6H92TaVJa+bZHIBNtQxFgbfLp6gT?=
 =?us-ascii?Q?L4KUqpVZE67uIhsCwBuCbRs+WgXtj5aBdHiBgmEfO7Hc1/f7oYxZ88l47w/M?=
 =?us-ascii?Q?S0EpBKrKE3KrF0ud9m0Gv5yCOrrg4rdTcdyRxNnvl4xAubZo8eF8OvLAoZ8s?=
 =?us-ascii?Q?0tlbdl0e/4oRKvlElkDl8fgxxPhcc0Z8Fvii7iEl1FE3mCbF8JNu+nPqXRCw?=
 =?us-ascii?Q?7ubipA7i7+TW5kBoGi6KA2bx5D7cZSIWdwGehTbywiX4Az6tYeif8xGX7prj?=
 =?us-ascii?Q?slTgqlUlLLViMqz98vnXaSa78mrTrL00NKZ+Iv1Gp36dC+hFCfuuSjf20Fld?=
 =?us-ascii?Q?8jpUYgWQfdS2tFbv1slhsXer2exZn7uSNDyhtj5QAqGHII/3e9oMZz6DPaCJ?=
 =?us-ascii?Q?X1K32O8kWwPMSo5MvCYtoRpkfZqwzpTXa58Jwb9hKyDsv7qnunpcIyNgV6Fs?=
 =?us-ascii?Q?hIMIQ1Xuo7zsMTicmrpGp3Fn4tpqcdDjhLDI7QHuZkonYfwBEpW+4R8jKe2J?=
 =?us-ascii?Q?Vr7dllrqBC4YvGVC7s8FMl/paluPivUWg/DEFNP0gA2TS+awX08xYtrw3xjh?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8055b9b-8d1b-47bd-671b-08dbcb35756e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:06.8813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qMtKsBGhITsGWlzeSxLmCccG7QrKUIW4GiEJ2dCOzq8rAnWbtyZvxNMejuLKPhMwY1dAvlQ8pkcHTf5hALCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-GUID: 6XF-cMUaXtHI-vRMZYjnN8abyfZPHAVg
X-Proofpoint-ORIG-GUID: 6XF-cMUaXtHI-vRMZYjnN8abyfZPHAVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
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

This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
string containing migration connection related information
and stores them inside well defined 'MigrateAddress' struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      |  1 -
 migration/exec.h      |  4 ++++
 migration/migration.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/migration/exec.c b/migration/exec.c
index 2bf882bbe1..32f5143dfd 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -27,7 +27,6 @@
 #include "qemu/cutils.h"
 
 #ifdef WIN32
-const char *exec_get_cmd_path(void);
 const char *exec_get_cmd_path(void)
 {
     g_autofree char *detected_path = g_new(char, MAX_PATH);
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
index 1c6c81ad49..2637c76364 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -66,6 +66,7 @@
 #include "sysemu/qtest.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -428,9 +429,55 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
+    SocketAddress *saddr = NULL;
+    InetSocketAddress *isock = &addr->u.rdma;
+    strList **tail = &addr->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+        QAPI_LIST_APPEND(tail, g_strdup("/c"));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
+        QAPI_LIST_APPEND(tail, g_strdup("-c"));
+#endif
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
+            return false;
+        }
+        addr->u.socket.type = saddr->type;
+        addr->u.socket.u = saddr->u;
+    } else {
+        error_setg(errp, "unknown migration protocol: %s", uri);
+        return false;
+    }
+
+    *channel = g_steal_pointer(&addr);
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     /* URI is not suitable for migration? */
@@ -438,6 +485,10 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
         return;
     }
 
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
@@ -1686,12 +1737,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = NULL;
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (!migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          resume_requested, errp)) {
-- 
2.22.3


