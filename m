Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B997093FE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwh4-0000Bg-CG; Fri, 19 May 2023 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwh1-0000A0-1m
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgz-0008S7-7g
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J50Jod031984; Fri, 19 May 2023 02:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=XtTp3GLHb6VPeCAKCjNOD5FusDvZRctVCIVx+o5tH8A=;
 b=jYZs8VhbFUvzZ9OhIgK9POwD7gb9oahuasFwvKSE9iqRjkCk4aPeZKMLSJpQAhIIQ87G
 wPdRVz9XEZzm/j08JkZFt1B+izsxphGSWL7AgPeSZcltnMNLcw3EHf6Mlcydt0odv5vQ
 Vjt6xDiKu5ce0EXXaFzMmuSBJWdx+XoURa7lKBEB8ztW8nF2oiH2k46bVs9lua0BdOKr
 5sbPt9F1LR5gW4umL96HQIYiArJgjmTnrvf8phLeFf8uVTcIPw4ss7zackCtrvufdRb8
 y5DLU/CYYgNnK9uRJBSypfAb6zlLXe0Ss4lpEmQimEz8qeNqOSOpjjtBvxP/bYQw0v1d OQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw4fna3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg+QU86Ae30bh38Bql3pd8l1UFdD0TAm8ZIGDemgJYOB+exwfhb1tdujhAsmwFVzkU5i1y1ddnnT/HgQVfxe5pgcsjRPTEMW3B4qjERjjMpCqYSJ49dR0UFdqcEMZgWqM/7Rgx+3Oy/ShF/+WnDfglZ4oliP89M4hYbtqhpTodMVn9FbRLy1eGEUhRL8urhzbLDb3iVAJDIj6KIBhyNvwBkBK0d323El0y4zjpGrgZQCcIwHYINbX+h8rhoxUf8ILkPAfBA9GmtUiJmM/b+OkFCdyt4BQkar+PzeuO5ulEZrcOk/OjsyTWWmBwuSURWijHaYUZPO8jFoHd108Hjfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtTp3GLHb6VPeCAKCjNOD5FusDvZRctVCIVx+o5tH8A=;
 b=EuyjyNX1jsqC1dmrQWW2o3XqF0dIuDbIForJuXYClh2AAD97KvBpawTCSuZGLwg4cW4bI9W46/XjVvSEamagVrdCCCOBDe150jt4yEJFM3134p0fKZ8XdNgJg0TyoXQItofMbJBSuU+/IaBoeDnOd2jfpoTLO519SCoMXE7hMio4WYlBNuk55uE6hI87arxKP3WyDr1WbspA6jG3PNJhb4lX2SGwcVaB2nHoOyCS69E/WaJQPqvAqSBwyGPHXFsWyXkcVtazFOhK5NiaOyFbQscnHexqAv1/Dppdke6o7Ewr9lHHH3Lkp/5JQ54tJ8TZMTp8x1CoCMAxg4yxxWvZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtTp3GLHb6VPeCAKCjNOD5FusDvZRctVCIVx+o5tH8A=;
 b=s7cX26giNV5qZ8AbkbCmkRQlTMsWXNisPZQGKqNxANJuzRJpP5NlEIl1O2RqdbkhDPqz6fRDXQsMZ/wEOAHVBV4MvV0EakneWXFoo5sqAolkrH4sgYPLB2luX9xenBnzhPShTAfRPux54CgfmPjxZDKb0XnZZtJn2wmvQRns2n9xNZUbRUtMUCyfVcg+2vij6X7TlG1jpouRaSkm8pret8yWX4y6ajQdT5jNl4jCwxb9mF13pUAT48LGiAXk2myeyEODXv/D7Chy4d8eDgEVu8TpDS/N3zurcTRvMHhSrtj/P0jhYL9vStkpnGRWQG+n1WPiLeMeIIQEvpf8zLgbZQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:30 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 5/9] migration: convert exec backend to accept
 MigrateAddress struct.
Date: Fri, 19 May 2023 09:46:13 +0000
Message-Id: <20230519094617.7078-6-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 920530f9-9c79-4399-b188-08db584dec4c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fhEu1X0Y4iwJr3twLrKuLpfw3cT8lC7DWAJ0IcdPNHUGqksJF2beU4Ir1Jod3PE4SfCX8GQ9PrwhXDazNrgpBFXdddZbj6ZbkaIrL00xAxkDWxKGnSWJ4c0oxsNO7vJPKlErMXC51LC2CPySkQ0yDFTfWkjqjXouH+mQ5lM98nSbqnL8rxeM8b+c3Ai0mptaKl64WlAmiQ0N5+gTCc34HwZO7b/Puz2JIqGVQhzrl+AYolxioPFe8FxZRhx8axzWcKwBh76iRMoYrEgyds+su3kwCjrTUKUrojU6sY/V0i56a251McO/nnngjvR/+jEUVcLPkRsQH63oEdJycRIShxisc1lkGcAutQqgPUrhyOkX2MChNJDhQ7dj2Q+kIm9SgsLREQfpHAUkIXTgjlbRGJjLSINGFqdZehLPO9GTv0VpoReJ6FPw2ccPJ04uGxvJoFAqWaoUmtXXCAexOgvpmgom+MCcBiMFMSz6BScK47esLHOcbstArV4aIX1HGWcAfal0ncoStCN3NRGMIylgnaxzogE2DePykV4Al1AcbGiudIZOtQSKQ7dL/170ze0G+xMEB5HTh8PYny1+JNrUd3kb6l92ZPPYZUOJrd2UZhPs1jPN7K/tVoZLNMtnzC+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ne4FZSN/qJvU0SzdDtQNl2P5FctXQO0vC+4wJGF2AnCPXqT0cB/xSC/tQ9Sz?=
 =?us-ascii?Q?ELhvre5WhDDYnc7v8XJ3xfuJ00bZD6nTwK+BpWyfE+gue2wPqEYnPLcLZLma?=
 =?us-ascii?Q?ktSg3TnxWsLlOfgCTrM8yZygaWOB968H6dD+dU59MUxTvH41hLqky0l3Jh3N?=
 =?us-ascii?Q?kicpM5V0bE2HaUennYd2YgKg89iM2wYi//2e0QZteUJnhe+rMiRDSOSce7Ji?=
 =?us-ascii?Q?//1UZSp7JmLnZXMklCu4UYsbV14s4krbMO/uZc6tlPTFsEty0uAuFRCn3j+y?=
 =?us-ascii?Q?dDw15pqDp5BD0xMA1Q8xAvMQ3aa+LcTapnFHYB/6gMtes6amilGpurTPnANZ?=
 =?us-ascii?Q?ozVn/prKe2UmREXtvIjZG+JcMHpxWHTtIUWp0Zt6AChYUey5hum3B3p60+S+?=
 =?us-ascii?Q?y9JmpCrH944kz2ZCvEahqhIvzgwFuYgR9VxCpgFFECrxlCJpqTzdqtuPcbrj?=
 =?us-ascii?Q?ivZe/kABcSf9iviUqgihnOZF2IQ9saU0qtK1vbKzCiJj1+u+HuxyWJs3lQyM?=
 =?us-ascii?Q?iVcbmYSagfkQchUgAAq6avv4N896BdsphWZ31QeZU60J9JTi6ue1Ro8NQdvl?=
 =?us-ascii?Q?LAsZhv8htf9D0zsvWrYdyGFTRn3dF3bfCT4S9THyXWlxzYNhViPWBkoPp9nn?=
 =?us-ascii?Q?yrVJIoBbIjofmgPwYUiQrPl2m6wWx3QdOOQ8ChQ1ERnpkbQx+wvr/WWdiVoM?=
 =?us-ascii?Q?HTNWuvO2jUaNVhpJMx/tRbFEzTK8zcyp8HuII/+u2SLm/iT4CLzzxqkwTMRG?=
 =?us-ascii?Q?htkOx7Ppnvrm0ZyI+GfQPRBdOvCPo55s0mvDkXxqo60KY/dCM1EeeTp7slae?=
 =?us-ascii?Q?eSxPQ0lS+voMyN9nUt7ajg1SFpCMZYrQHGW/RmKTiiCfJ22aReXn9B33Lj/h?=
 =?us-ascii?Q?nrJ2fwB+uUR9KeNO1TLEdOXCNvSem0/axIMTp+XHQk0RvYog+0ih1jSpbUeE?=
 =?us-ascii?Q?nPlSYLtJJRuDu2sPg1f1lXJ0o4rdJE1taIvX3Ga17VaH5T7+Reau1kA1V8r6?=
 =?us-ascii?Q?uWJY/9t2dmvrZOK99ZRRWL3Rsuf+ZZlsm02UDmb+JFC9SwxOr5/S7maQj/X4?=
 =?us-ascii?Q?QPrvfAY47HTkBBzv2PDJM61n6FvL1Mfl8Qiu1ex6tKPjFxtgH+SqHbFzyuNn?=
 =?us-ascii?Q?1b7X1RBaWHu4WG5iPuRt1gADWLbRHNZ2L9ApOb2/YhDurLvYci6IxR+XaJYA?=
 =?us-ascii?Q?XylF9WfbiXh4xuaL/eAbKqac58S6va8AaM4DYfurVW9V4WmzDVp+heHKeZ7e?=
 =?us-ascii?Q?5hIpHxyl3ZgFkRTuKM8uRRifoSnu6ly8Ae4pwkV0Z92Y0uz5ABPyWYAe4SVy?=
 =?us-ascii?Q?60Lh5My5YCW02G4iH+KRInc5Ylkcqrr3ufYQfc9xncP0zf18xYdt0Dq5D2UT?=
 =?us-ascii?Q?vRvwvhfS5bsvK5cTg34pBZa+bDESn2H/OAgWh2GuMvlNiOVb9ZAuc8WJ0FmJ?=
 =?us-ascii?Q?vjWf+bCLW4kmuiThf8duaVLJE5CP8NAh39OmZvju9yN0/rxD+mdvJSyT2k2V?=
 =?us-ascii?Q?o5Hg1aknp76m5hvNsnzDv9meEbPLhUcywqt4zPDF3ktGSrQN7mXOWn7BvaYB?=
 =?us-ascii?Q?MnS9lJ2Bb9uo4AnvTAa1BYZYsBT2fBgqqOOhhFg3rPF8+ksNHiTgtJ/ZJO0q?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920530f9-9c79-4399-b188-08db584dec4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:30.5261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6cfvjtavLrVHuD7EAiPNpu3ZvSh/rCdaGi1qbS7LyPJZyP9MEfcQtsrz+tpdVX5FG7eKNSPxRgMeV4W8gtN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: ejfaiZONexIkTLxpDxbR53liJklXW57V
X-Proofpoint-GUID: ejfaiZONexIkTLxpDxbR53liJklXW57V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      | 60 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++-----
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index c4a3293246..a4f02b207f 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,19 +39,47 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command,
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem->next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst->next) {
+        argv[i++] = lst->value;
+    }
+
+    argv[i] = NULL;
+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn((const char * const*) argv,
                                                     O_RDWR,
                                                     errp));
     if (!ioc) {
@@ -72,18 +100,18 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
+
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn((const char * const*) argv,
                                                     O_RDWR,
                                                     errp));
     if (!ioc) {
diff --git a/migration/exec.h b/migration/exec.h
index 736cd71028..3107f205e3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,8 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+void exec_start_incoming_migration(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
                                    Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index b7c72fafc9..0a6ab9229b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -465,7 +465,6 @@ static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -491,8 +490,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATE_TRANSPORT_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1682,7 +1681,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1719,8 +1717,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATE_TRANSPORT_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-- 
2.22.3


