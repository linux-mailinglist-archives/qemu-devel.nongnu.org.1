Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0390723F27
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjq-0001eU-Kb; Tue, 06 Jun 2023 06:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjg-0001b9-Ei
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006QA-PE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567Q9jn006542; Tue, 6 Jun 2023 03:16:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=7g/T7Ky2AAQc5L5NkckbTA9vFxuLlSMOAYHdEVQdTgQ=;
 b=XWIzg0z6h4wttDp/dcx0T+RnHn/hP7ZO0l5GUS4V8vEAvqXSB9kTyU24i24fSiuLP2ZN
 JRh47SZV6DToKVJsqiyNQommPg71ISVVBM6O41HPeiLCHuZVqZ6H5jCNLFjBsRuiiQGE
 zZvLKrd7E/zx/grALuxSaBrt4hptyCbxSe0PvNNZcbPIbeIxm2yTaIi3IdTIPFH1ZDgX
 yhn27MpvKD8OtQj4XQrwno4gloQApXSgZ88FT5z1onueDhSpUh+p+kbrFlhzRFLZujIb
 z6ni/1/nq5oXEeogR2apIq66mGP1nlE+N+q9eW6zkOTtUdbOvBoy2pjycmKzsk+clXp7 Ww== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7ObqLpN4eTy7iG3Ccs5ouhShajce22JCv9rNDeUWJHYHLTL/icf/5Lx7unL1w9XB+4BtJAb0SvbzKnw9BBGMLwiJtsIftJDbdDajCBUps51Vny84yiBP79IWe/jZ76dAunKVNZsg9gto3+77pgsCAAuJmiXoOEzeuthC518zb4TAuIygohau2BFjb47Penk9TLvZipNQk9habAEW86r2W0bE3uxA+JLg2L4E6Qsky0XdZlBNsM4b1/MMPovKLgAOPLT3515TZZ4KXskGDejnz2CjZOwYGXpUuNbMNM3RX+GUodFlSi0jcSP32xEHrCUI0Z55QmjXbXOplrgLuGOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g/T7Ky2AAQc5L5NkckbTA9vFxuLlSMOAYHdEVQdTgQ=;
 b=UOVGM6ZG0udmJa3Z4yeQicCCxQkMQ2gdZH03+tNs9lQUqAbT6s/Bm2ZuPN+B+jssNiWpfOnK6dcfqCETXFqNLmln2zafHBAbvd+qbA9/qecWWP+oMOmOU3QmqgYAQuyWSBQJDqjEYL3KV2DCR33FBRGR9Lj3b97oITOwf3Hfe26liP8jWlsXhJ0KDApYjIOlH8WeP4+Gb0LRBnjhgAg9O20Qdzz9CENrlAMqDBfVIAhu87sCfRriEMLDu1xWfWnda1keXTo4/0w7E8wXmdloLDMzbJcbyJG1GQ13BF64KKXzmbUAjL6N2GWpmpkhyLvfwy2xvpwzYnLFaLwPpz7S/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g/T7Ky2AAQc5L5NkckbTA9vFxuLlSMOAYHdEVQdTgQ=;
 b=HY+6291T1tp/Uk11RBIfGoTZYQmLTbsS9CEpFZZGIUL+IRKucW88vPM68/Bd+dABNO6Hl3dW0MACdhbAvStX2kNmo13RVctTzSZiMLhUhaMKeHta7i8wqOYwTRcyaspAWQ5J0woNJyGP6eXHEYYV9eDxdPHItxvNe1E9AsaKLU6nS9Rxjc+NdHisIkYu62J0HVdwsmaGyRNQL4Vmq5WwhMtgTBcSOPWgDFUliMQQgZvvQiO6L69TZwPeF84hgmaJUI9ATeHjYIACvs6rtWRIu7ZvU1KCuNnelxQAqW2CqJOy5IJtvk/TtjTVh7n2A3WSeXiYeHPopCpmryhHogxY+Q==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:12 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:12 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 5/9] migration: convert exec backend to accept
 MigrateAddress struct.
Date: Tue,  6 Jun 2023 10:15:53 +0000
Message-Id: <20230606101557.202060-6-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6b93295-c0f1-4765-f229-08db66770da7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhZJEraxZYdpJpFWB5YDlTQIUqdm3k5pEjzXBBbymwyuFVAgMoVu1hpkVTFBs7s4Ll5cjttFCQ1+YIhVKNmeQ7StsdwvcDT2Bzt+HXeGWmKYAzOFO3HXM4Jrhaxw7JSvW6VDw7TKQXTCQG67o/j485tLFTpeNvNrkcMEK11K32n3NH1kh2WppvJRqTdjjIKBwZPdngBg/cgeoXbjh1tQZt56SQhZa5L2PVDH6WmKWiO9e747CFt7YPhuCsiRitl41HeQplnv3ECr2bCLBhO7zBK+x1oKOlpyRywxMMyPlWRxl/dglJtLLRYjkbqTkh0u+vaZaeCR4XFKws+mGTNSxKhPEr8O+2yz6d79EMtfuLu3pNJNfxmCgZka2oxzDSD7kU2UB93/0Eg2cHiwB8+jkbIys/DuafvmONP1pbHQyAcywDDAglZ8/5VPZGtusVEG7s1KQ/46W8uhADJmByki+jNPeEtbtFl4PlUYUEa4PPS6I9j8S+y2fbbomqqb0ennSnDT6F2C7g2TcZIegosBGXb2OLc0K936KR0sjws1qByvmWSzaElE7sN0cRkzq0FnzgcDyYTxxDWS2oNG0cSWLJwyUC+LXLLw6yl8L6DG7k8bWdyyWN/G8orPZ1D8RPzm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CmFEziEvJvgJVgqfRmSyVzeS+6Za/3ZkLIAkExtr+O6d19YdM1Iep0gWpd9?=
 =?us-ascii?Q?v/9s9z9XdIxLfaZH5SXpUKFycLq8qmTv8hxAo9X+CcN0L5Ea2S4JefNOaotY?=
 =?us-ascii?Q?J6fOGrbUyKQqnDNmqc2CUsSDMVujMUDlA9U6D2KWCa2/ds7PoQgfngJkHzzh?=
 =?us-ascii?Q?EyyjPrpoKy1ohVM1E5fMgLWGrIJyDl4wxj6J6XZ6VbU7m1fu7bskM1N4DDy7?=
 =?us-ascii?Q?4Q9yES1LDzpNMSIHh3pY2Qg2tQwwkCtJ3G/4puTD7cxq79LEQqNqMGnVa8Hl?=
 =?us-ascii?Q?RSzg3CJ0dEQPuUO3GT6wonl4JQ/0Ma5/uY4agbw4SyjCkpwIwxWfz6JdxqoN?=
 =?us-ascii?Q?KuY3JBMYEeqEirBnuJ/U1bIchCKMbeqi78z4njI1QlwfMnC8fVKemDV5wzqO?=
 =?us-ascii?Q?47nL5LoLCodjdbjacHHGGVBuRnM2N4g6KeOtPCdv9sjKiGLwy0CRfbfNhjOR?=
 =?us-ascii?Q?wi5skWg7UCoZPmFv1nqkQ2flyGXYzYK1sx4HQmy8AlODyx7PIUHNwkGnBUTP?=
 =?us-ascii?Q?dITYtvXpw51lFpH7kBZIioBqVn0j4BaB+1oeYODee1of1N9KrnGLbnjGMTfw?=
 =?us-ascii?Q?BQ+cFAeiV7Fk1oyCDomR8amMHQEIMDh1WPFstDgpWuniuSFDgQZE2I77ji4H?=
 =?us-ascii?Q?FfN3ZUtC42cLYp66tr9dfiInG2E2rS2rF2y5OtfPFQBeGl0P/a3a8+JMU+3a?=
 =?us-ascii?Q?u0YITiHak6GdVW7NLKcARLu8uuwTaLUrj4K9m3/3ba38bxhTpfmmtBPIyGs/?=
 =?us-ascii?Q?KyFTkGI57+EA0ncX0EbQvcub5JNwJjFo2KczUIQOA2oWDOSUnniYIzwK1ghb?=
 =?us-ascii?Q?LOufB25qDkWFOy0RynBOYQFCnGtqKjJL4f6hE7rN1BEzMPiAQ6sreot9C2if?=
 =?us-ascii?Q?3ywiYEE1gwUYp5pr/bkdvXHvsJy7jRpW2Sio1IuOw8W3oVmDetzOvK6cpB7r?=
 =?us-ascii?Q?vio7yGFOZt7k3O+CaEccKmy0YEA0p75vpkw6AwawN8XRNhzymxTngq7/lcCW?=
 =?us-ascii?Q?0ttpD9daoXR9p5SVHfSY/ZHLBKxSd5R3Zs+PltxBjkw1O8/zeA8LdHitUfMA?=
 =?us-ascii?Q?dPFR5OGPM9GCAy7MVZsc2tXUAHej+aHkqhYIq/Raf1/PHpxhAr2+MNFdOMhJ?=
 =?us-ascii?Q?NL2UQUWMaZKWF5gaS4p3qYuh17fqNXgZTtDPsuJZblgDukXo/CtkdJ2xhnw7?=
 =?us-ascii?Q?sBPeioGMkBuC2BtovABg+SngAhajygiMa5OBHveZijLd05JMT1Icvg245O9D?=
 =?us-ascii?Q?O6OFVIRW+neXbfhSLGW/p0jBvMZb3DIxTC1d8JKtn/Uv0HCQcsG+vh2ToqUX?=
 =?us-ascii?Q?H6CT9NHDQP0B/jAHymqMa2CvKtVysULdCsp6J8kUoCrnQgIF8aACnKJzPN35?=
 =?us-ascii?Q?uI5Ctv5Dwv9HgMy6RlOgezz5kGRUpM4kGPin4scgKjGBoo8eNghbLJW5A5oA?=
 =?us-ascii?Q?criszYtdK30O/LeocJR1wQkB/xnXZKU81EVCefBHhmdcsu3N/CES7mUjhBQu?=
 =?us-ascii?Q?EPNyUWpMb6D/zCBVo+/XdsQUHjeVQ2hxebopmsniCyrICBUOT5zycjH7pVgN?=
 =?us-ascii?Q?bgWIsTu1KLI3JjozIFiRghtl0mJ+ltA2+upw7hSnX3Vo92UbgKMnPfL3qUUQ?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b93295-c0f1-4765-f229-08db66770da7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:12.0945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0N3p0iF6L2seWyiDbVNGEQDp0M1EHMyZjmHXlHYF9kTA5KaDFeoqJyc5CAK4o6SiPlzEYxEv1S5zD7Fx9AXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: dZ-fvQ-NxKjr7Gr8ajN383tdVmlEH9uZ
X-Proofpoint-GUID: dZ-fvQ-NxKjr7Gr8ajN383tdVmlEH9uZ
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      | 70 ++++++++++++++++++++++++++++++-------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++----
 3 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index c4a3293246..8bc321c66b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,21 +39,50 @@ const char *exec_get_cmd_path(void)
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
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
@@ -72,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
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
-                                                    O_RDWR,
-                                                    errp));
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
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
index ff020656fb..f482de5df3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -466,7 +466,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -492,8 +491,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1683,7 +1682,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1720,8 +1718,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-- 
2.22.3


