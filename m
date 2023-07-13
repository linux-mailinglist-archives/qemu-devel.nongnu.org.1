Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC67751F69
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu17-0002VE-5T; Thu, 13 Jul 2023 06:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0u-0002TY-Qz
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0q-0003bn-KW
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36D4o1SJ012615; Thu, 13 Jul 2023 03:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJB
 JQ=; b=GFbRtiBBKMZAD0ixu0iZk6/lwoDBw6LCgefQrgyXU2+SUMbwbN+oxGl2R
 4OPBHDD6m98Q0dU4YsaJZ8ZjfbglTyO3sa66Qjnte8kXeZLDePgTyFHvcLOfWdGy
 Yc72F5qzCIDfC7EkGulCUMW6xeXcuIu832K436FKXB2d+bF3yGfpZl0udGGABlQh
 EQFnQP3fFdsKFDCzaD3clDbcWp1ghaTnW3paJhoWtRGUqeleEkoTBMQcuvuLs6rT
 jtZC9TKAoCJN8QrBAEgLQ+g93Fp2EvbBLq8ePLwxgNw82q/WMaTsneXooRyZyn1J
 xtdiPJNA5iH/1tbQGjCF4rqe5HcWQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geRJWC9Z9smCgxVyFIje3klR/kiypAg+/p8K4LifavnF15xjfPXkethPrdMAUH3eATnnQCMp/bAKq2CY222+vwqQGRQcZva+ur4TrGORZIGDYRpOL7y3mVo0qUqNYB7ma3qVIRpjDbbvSY/isRtQG0fmOg3h4D+Wzn9S7TW7J5CavTC53cHDFtEUPL652CTUDuVS3vDsCxFrQZ6/mPl2rpfyreizNHPIXiGVKr08fgPWaBhdBS5gcyG6wIj3qy9gYICnzC69RG+UQM/Qs5IOBDreHl2HdL36BUgtiJTOiIIBJlGLq6BrGjCuPbIAAXtBxX1ZQcp8EVmI2w6Xzso9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJBJQ=;
 b=eZrIOrKcdZr6c+/Kz3XtfCDhOeSUR1xF5PVxLpAoiDAmFgs9iB2/DamVzJsq8bvAVGXJSmN1BugO2SNlCQK/fnIXgr9qVQ3QuSSzxEFSl2DagyRe/LRVS51LjAPy8w7UQPzHluLcWtq4J1486+vNJ3PXZuUhzb/cAbqEgRtT9nzu3whAIF2Dlt4TkVCRppEvjmnuK32Z/8RF6ejlv4Bpl9zKrPdAXZZFJzDuYe4Q2FwT2BM4pICd3epnwQYJ98vlX3xABvxXRTYid1I9qVNPL74yjO2OcpT27ALyMBYV4HCYf/FVeobdJgOcThjfdxp7PfSm7853mV8CGsES+nsIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJBJQ=;
 b=KHrh0Pk61rGpRhUs08X5W4Maay8HVkbML8PifoKuQ8UBYxMPy16VCLqKBkO4Hy2wdQtKyVHgQqzK/dujG/umDMXk9gn+FU/jGD7KRmKxrNyTas9htptU9nvyPcYA5O/zLKUkYuCHRrskVH5z3bcqfrJ3yAwrjT8omfz8qV+4Up4KJkz36LfE/etmQ8WO5wvfnx8XP9QOWQpJHdjm7fuqVt5OHG8TqimCtEL454SoR5TGxpVWG4ZYnYwF15Q2ZN8bermHy2phCRJaJiBuDJYL51Vk/ts3irqMsfsOV/UCo9gPU1wMDeP4CADxbWdvSc6ZcEwAnq2FJvNrygbpPCDpew==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:27 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:27 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 5/9] migration: convert exec backend to accept
 MigrateAddress.
Date: Thu, 13 Jul 2023 10:57:09 +0000
Message-Id: <20230713105713.236883-6-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf5d6381-fd65-4085-ee5f-08db838ff21b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQsd1GrDiBjd8hhdt5qLDU9BXxUtsuzjv1mEVHMxlLoA3AnYqCiA7GH6yvVOA61hnsDZfQuDp+mV8EIxUbEIm17jMAiDgfyFHfhKjejEJg/IWAcxAPw91yi8F7woJs6nY2mPWteQd/bVF1n6q/aInjx/SVElBhT6YePFZ7UWKbjBs17N56NMk6Qcq9jtH4f7tBOXOJRWIIsGNdDTbARwAyia4VVlvIPie0nxfGhEiZLFZAuJfymDzNCivszkrcDB6jOKNAQLRlszTkSGVCL3TuNc60Y4IahDYbJ1xLfkfBxpXEiTGBQI0sRL0tqJ3wKCCoaicjapr3VGAPVgJ4iYHQwR5krfQfNg05/WyYpq5ltOhI3QtQFVkNMquM1R67ZudBkab0o7ZmmhuGRMTzbtbuFoyh047tj7BVpf/PrII8/HMRMAjBwV3mPuhDlDt7mH/83WRYDFSVCC+BR/b9F2iUfGlrCRxCk3bXNK3Kqm3y4089VE9t5vi4QdAnXPZoHw4E7DkuSZQ+Hk2yAqd0U8CqBfEIDzMQEGk4FFWebKerL0bFNI0rpZa/iCTxk7S2Q0u1SPNCqlyqy7J9ewU2Alub3XeFBGCUuBypgL9WTFkz50ZGcq1bmy4k43SPrOCkx+8DlyARVUzOtNDnhyPNTleQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001)(218753002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1OrV9YsO9BrtoppEvFssV7/xjCs5n7JB+vj4JdFafK4z0dqMySont/WNHXx?=
 =?us-ascii?Q?6XcgXW0gH4VaMZujAyLfGf76BJi0HLFqPWKt+iYeqFRGC3Dw3IWiQ41TNush?=
 =?us-ascii?Q?87FwN4E8oc7nc0CvqJGMa8YiSxNH4KR/tfe1mLYjC7zeEWQJsp1Tvt6KCX6/?=
 =?us-ascii?Q?gvp2y8Cpm40BtTf17oECXzvKEF+G9+9Y8zPsDlmUNDMiC0tEJbVcKzSJ5aN4?=
 =?us-ascii?Q?z/QsJ7laW3uvOP1SkwI3JvqvguDDoe9VMvIgOgD2iuB9Tn+Qb9eQ7jzyyWV+?=
 =?us-ascii?Q?xd1PX1yIwVCz8mVTvBNPITuiRompwHyxav6i2uSOnrAqTc2fH+DHyXBepZZU?=
 =?us-ascii?Q?pm/l68PMLjfvvF4VLnqDY4VrGAl5cbZNTLl/RLdUUSCMDAjWjtdNM0ocSa4y?=
 =?us-ascii?Q?Z6iJEB9s43aj6j00/Y/Ldxt7go0BrejqbKoiAYNx27/3a8ihmXRucoBCtNhV?=
 =?us-ascii?Q?PtOacR5dLfE7BXd10OR5vxrFI+WFKoNyh68cC2fQvWMcILWs1hJ8E1TTTJT7?=
 =?us-ascii?Q?vi4//C/cwtEha/+FCA2mK9o7llUMhc96s4lMji48UMm/Cu4y5KMzssHM4x1M?=
 =?us-ascii?Q?U4daVglk7HxYI2ygncDEtC2/OS7DCeMyPiysb9nGuM8C4Cdp0RhqT03AY4EM?=
 =?us-ascii?Q?rffSZL34HXl0L0VImz4AT67jE5AJSW8Se0qXSUutD5zzjMDFmBRd2Yx8ylJO?=
 =?us-ascii?Q?09kNLJs1hifV2f4KR8wtHEQnsPcRnVNMR/zpeASzVdYol2Sreu7b2/EbNQPu?=
 =?us-ascii?Q?hywZ7QYhLmD32EaACszbGaI0d4fRZRxpucU8jjRtZolyUaopeRUP79wmB5jS?=
 =?us-ascii?Q?CwtNvdKRpgLryi0MQAumJvIc9V6BGoePaaj7QfgY+nn8mrbwcPf8pCepii19?=
 =?us-ascii?Q?/12ZsRt3TGaU37min4jN2Y6Sdv3gNhizfb2FBKduqt1bTQ/5yAY5LHoLOY/V?=
 =?us-ascii?Q?HLr3I1icn3HzgLli2WA/H8W6m2ag0UXJYHtrFEmLuC+AjuFR4Ji83HoNCGtg?=
 =?us-ascii?Q?3axlTRVy40LUNm2zJFNHPUIS2x616GpdFFOSQQDsVuPa5fNCrA4+F12j+eiL?=
 =?us-ascii?Q?Hqe4x5rDpg5LnEelUtR4vsQHpQOSkAqAjuyySWbbrAOHDyLgszFxrnnpCd3D?=
 =?us-ascii?Q?uYwxRB/rvydYJRxJmmHcqeX7ZlgLBCn3Dsd9bCgqKP/bmIELHyqOthGAkzXE?=
 =?us-ascii?Q?wKFmLBpwYGBnaGqiUs76j4PSFyAaw2YhvafjQ9ksVm4Js7YcxT9y45O9ABxa?=
 =?us-ascii?Q?AfJ0VeKeVDibytpTqN1swPQmylJWKURgRNjHYNdzhiFM5A7JT4d2c39JJSrg?=
 =?us-ascii?Q?+Gs5kRwLDm7dsclsOyBncAlC3nqharxDFq6vC5d8OQtIu4DeEXnJisTGZrTr?=
 =?us-ascii?Q?Xye34dRn9+OWUcdWrTcQNvfjxl2jHa1R5W3jNmM05MxvV8TuwWlQxCkm4mOX?=
 =?us-ascii?Q?Hi6zHcYU+X+BTy8ATTp2ney+zIxwrGpl2fDzzT40Hwz1RpMQM9JYZalF6SJ/?=
 =?us-ascii?Q?kNAGcxCZESc29G6o0ieM2tZE/GuK0LF/PoYHTotvfiilhNyLJ9c7PT4U3vh/?=
 =?us-ascii?Q?xj/clrJvpeRk3E+AanM+WglB1fSaeSX/o0Hh1ryKgE70BJBI4r5fWqAvOFgY?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d6381-fd65-4085-ee5f-08db838ff21b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:27.0246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuqSRBx9MnG1wcdXz/vPc5N9qEXwyep7G7JENV8OBOYKE/Gi2L8rQYHaympM6gqr4HuRwa8W9xtLNxXzCAv+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-ORIG-GUID: zdYXxB9Od0Ahmpru0E3QvWfDEjTPCRqo
X-Proofpoint-GUID: zdYXxB9Od0Ahmpru0E3QvWfDEjTPCRqo
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
index 2f5bd5df6b..52e2ec3502 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -467,7 +467,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -493,8 +492,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1692,7 +1691,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1730,8 +1728,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-- 
2.22.3


