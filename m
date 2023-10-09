Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FDE7BE300
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNT-0003S9-Bz; Mon, 09 Oct 2023 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNP-0003IS-Ol
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprND-00033T-LT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:52 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DB8Ll008843; Mon, 9 Oct 2023 07:36:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=VENpbSfQammIpGTwojJEVr1BWe+P+5Phz2sU5bf8L
 is=; b=H7iLe/ePdoRfeB7UCgSVyVJYvgWw6qAHfv8j2sjq6zY+na703rErytvkc
 M/e3LvylhLkXsvWfoWHs1DgGCuD8sk7saCf4Va2iiMBwBVvJTHXwrp/fjDdlX/f4
 YZz5s2/6ffkR9tcWHEINgi2GztcM0+RyklVo+Qlj+laDWvLvt9TFWTUKG70CXxl/
 BYeBLvEGd84kJiVHL4Nb73hisDweYXFnzaZoMNAZFjqVvRzsu+wf4vLkQS8BE/0r
 Cw6wDgS24RnkLvYrl92fMBjubHRYti7xZiCnuBDvjkBmvI50CnVkdwXnKSXXkfzX
 XATe3fWE0mZr7rktcczaC8yYwpl2g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtt3m-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7Ewn9QHUoe/zzeB1JYvwjEoiWJt1xvI+XX1BT1gBVwh1NzB2smUsrBb91A+tx4amelMe8nMTi7LcmVD6nOhsP+kUNHTZmDV1Yzt3oC1jNNM++kKsZSQk9djsAB51hAdrPe3qJeVqUsWJRXeZSRoDMN3uCQkXDEUi59nUXQZ8CeY7U97j3mWLtFrgw2VVN2IMwg0R+u/oLneyJGn/2QGrOlHOmB3kA3/i8FOUwJ/UhN38HTtDliLEvPpqjeIX5i0TpAZVfYrEK7AJOMapT4fBymyxvo7coqIjNX+vrrow6f+KxAK8TzeT3sVl1ao/54tTVmrXTMoQlOa6lZDvuyseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VENpbSfQammIpGTwojJEVr1BWe+P+5Phz2sU5bf8Lis=;
 b=NbzVk1/BfE1ONIb7icny+LpPySgLrqYLABDtxNFEtMftR51Oeskq9F3NLPBphaQwdu3jLFYPKsYV6mCG4raubtjQSW8yLBR7ApKNHtLYuux2BAbNiCTGJzCZyvJcnh2uvzcvx/gloQqAqNCwVMFQX6Iy9p3JFCIkY55YZQDcXbW+t9n03eCtDlaQ6EnlNfBp2F9HQB15EUlm8wC0MjMOhnAK0AeYaww/aPhXgh19yDQE5+jAetfLDZ6LO2FuhqYcwo6gQp16NB5fb82NOhjmqkvQP+taXZwK2nf9HGVhNQJs4QnAII+m1urrd3/EpbvvfBjG4U5UWnUsewmMQsOMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VENpbSfQammIpGTwojJEVr1BWe+P+5Phz2sU5bf8Lis=;
 b=ZXjMo9cvhb97E+Cb6XqMKTdUg7ostJq8vjEqIYQumqHJXWI4gKfk0Rk2oOknqjf7BYfVN1bTOnIagO2vGxPbSz5j0DUouNQCI5fKeW5cW95BL5xQ1N37iQVu9dUddij2Pk//2mjdSPmb8qxD683ELjZsAJmrzezevpSn6OXnG9XoFrBZkiYV8dNUo6TyO1NaXzQ0zU0oiLyTQ9Nh6At/k8OUGfSiX7MggbrFiXgr1OYpld/BQ+kmmHMkmUfi+IwbyObkLDCl+NzB1XuQErpBP21m6rpItDb5XlIY1rcqtENmHY6ou1WYpJJP+xbAfQitDPuFykGey0NJyv0h9gbbrA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Date: Mon,  9 Oct 2023 14:36:07 +0000
Message-Id: <20231009143615.86825-3-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 429bfe30-b5b7-4684-2a08-08dbc8d52192
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFCQKwOmjm88GHlW/59hh+Y28CgCsu0r/wuvM8cvtUP2X4thK/9fkmN5E4yMfHNFErBeLYO+0tvJKXVp5Alneui+EZXCAJH0fllaXlZcHVR2I4jCfJKF8l/H5vw3SIOnZF5J4iub1utMh+9cIYPWfOLqycu0pcJc6cIOC/CiYOMlCuw4TYkA7KmP+xe3i6glvB0yeWjhJoJcV6bZXGBQMG4/7mh8yvlwDzp76uPP/N6wSVl8OJ1QG5YWzAbnrLFS4TKoL4PxTiF/BAuE7aPk7G3wDaoQ52TghFN8gt1Fe/Jp6VM8bh07VkKGwjGWD6W2NnBS9geAY+r7nE35HrR9XoIQF6LuwaoBbZMTSoCqi9qpF0DVJeJ/56TDZvYm18vGjgPqOjuQnQsttr/a+DbjpAt99UzRSX8JGZgZQljPyRAKCOFR6dj2Ih3WJsYvgby5EiI4eLtwxEww5OXz1YkRxltHiQJtY6y0HNfjXheE/Yd+l618PjK8gl0guVfIVt/AzjUD430LHeGnCtrM0RELGfcignFbNhz0lSrkk8u4AkAu+KOJ/R72QW90CPyhgqNX3EUIw+0IZcKIXdrMqre//CN/XmjgDGze/q6n7PGuk2J6LnBpJp/5KvskqDZKo9Cd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVTyfH1KdUZtS5OxtsSgqtl3RKdoeti7ANRAMTM2w4XwHl8mxQFOd5fQio7u?=
 =?us-ascii?Q?5ZCtz6M9Crtzoyt19gQIKBLbbIKuMvtaiKWAC9gDPer7N3+awwutEr5oF6+h?=
 =?us-ascii?Q?lpzaJMviLp5wPaZC2VjP441KQzloyDstx3ToyaexcnUOKIxA2CiExVNfGff2?=
 =?us-ascii?Q?tNnFqTovUzB6F8HD9aSJoPaYLVyLpPGS7AB1TOLF1byGmmsPyAJQfhxJ4iFW?=
 =?us-ascii?Q?n0k0Ai7Z5gVdv/iagZlA6M6+XTYM7THKd9R7xMl6olS5epHnKSXBSnaqcetp?=
 =?us-ascii?Q?G6PvuISIO43E3/HtnUegYD3J4HyMjvb3Q4FW+O6Ct4OBahtWYJrP57RrmPbS?=
 =?us-ascii?Q?qQPVelU9H3Ya3PoB8+8Xj4fj3eHPrTVaM6pcbvKf5ZOIMamkSX/F+LCVOvty?=
 =?us-ascii?Q?lBCkjZq92WrhbI/AVxK/QYLK6BpzmQDUxZNrJVSmdTsxtB2seSh+e+d7rGGr?=
 =?us-ascii?Q?U7xUOBqO5y3K23RVyE2Z6bqULHRTo1SAjKmsNSECPo+WD8OHqCZBxOYlJGuE?=
 =?us-ascii?Q?rAfbk58DCnEoxt1hScwT1WqjIXaz8NGRPRVBkEgj4acSQelsmjJ4PfxpKtNW?=
 =?us-ascii?Q?jePZTZpTpF4ZFhnYMM1jcWsB16uUPeRLTSJNOQJpO6MPz2lX6A3k2d4zSMAJ?=
 =?us-ascii?Q?D5UsHaNZtGueVVZ7nred+PKxXHUKvWO3UqPCYY5RFW7huiwsPdeKeapxEKp+?=
 =?us-ascii?Q?VwcZ2h46xOhJaJgEvpZcIKL6jVOLUTI7gu015n5FLtsfQAv3m2zEH9qvZLq/?=
 =?us-ascii?Q?55PAl+CMSqkf+B6+9luNPsyt9WcP9NuaZhm9F5Y6IHOdiZ3k0JpCSlRuEUlw?=
 =?us-ascii?Q?iZOhBmzVwc0Yih1VG5O9kadw/610emRVxCAfsmC/Rf6V9DfSHH218Ty7sqZ7?=
 =?us-ascii?Q?TDQWY0U72N0TfHzhnvMQ/C78TyKQWu0LzSY/fTs75H4eOekg0708LPW+3vkJ?=
 =?us-ascii?Q?/FuenFDRpHOvKiKghep+vVXWO0Mqxw4uDI11g3FOjlamMR9+Z0ib6S9AScqN?=
 =?us-ascii?Q?QkvuHLDN3vDRPnEq0lSwNYsydew2irj8JEaqkQALqTq03O3YK53iqkWfr7cW?=
 =?us-ascii?Q?gF00Np40gtQCFI5o2hILdslQy5UxTlXsvEh05aZlNRDFqmaWZ3pSbNZVuqn3?=
 =?us-ascii?Q?6qghzWe5H4MK8T3luRfi3nXQ0KQOIWnoeNrj5GqKZ2nLh9vs0cUAqLCf5oFW?=
 =?us-ascii?Q?+NtVZnwuvsKWnzuobqxJXpbZhJOkJIccgFycDKQjqD1q1+/b5v+t5zQNo0k5?=
 =?us-ascii?Q?PIj3mJtX3FowCva8gVxJfxkvzxsXZyUNmc4csPMoylLNxlBkMOAuFuISmiAJ?=
 =?us-ascii?Q?yuNfRDpltQSBK+5heOzbdLoWZZJNCtSThlGIae2jecADaLCnmef9zD5RTe5w?=
 =?us-ascii?Q?/FkrSLn2VA4LO2XNnP4/IqJ67Y9J+awvThNiEazQ4Fm4GrpzLqC0WGeUw2+2?=
 =?us-ascii?Q?2Ur9/ewH08F0g7fgc2flwQlij52DaiHDuOmw1BV+eakurjIMsUEQaK42n+lN?=
 =?us-ascii?Q?ucJ7BQPsL1Mv6BAcK5QPavTKhqyWqT02YzzTzqUa7O78XvIKCoyldx9NSQwh?=
 =?us-ascii?Q?svFH31mfRFh+aOwrHzscZZSwrfMCOAx9qq7+Dj+j?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429bfe30-b5b7-4684-2a08-08dbc8d52192
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:32.1192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j1TAPMSoXV0BnLcF0zm75Zf0IHguQRhipbtEPpZx6vfbVeoQ5slefTshcsvTQC/WWs5sZfQciUsVRMLzur/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-GUID: oKrsl-y2d7ho-B1JPqxVpkA_SvYNHSzQ
X-Proofpoint-ORIG-GUID: oKrsl-y2d7ho-B1JPqxVpkA_SvYNHSzQ
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
index 585d3c8f55..89fa074e8c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -66,6 +66,7 @@
 #include "sysemu/qtest.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -428,15 +429,65 @@ void migrate_add_address(SocketAddress *address)
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
@@ -1674,12 +1725,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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


