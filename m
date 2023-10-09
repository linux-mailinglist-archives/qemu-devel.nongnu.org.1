Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF74D7BE306
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNp-0004Tv-Fy; Mon, 09 Oct 2023 10:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNe-0003ux-70
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNO-000343-Hs
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:09 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DAJOP028050; Mon, 9 Oct 2023 07:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=vYb7vSAHnZ8jyjb93ujXuS7A8+FGhO2ozMJfCyfCU
 ck=; b=ntG/QjJrkLFls0vUQlTsFpS107lse/c+OoDheVZLQLoKGbaz20TClLDmM
 mAhxes6SiDsRBWnHE3CFEOVYrS3X9hGRS/4sLOfZHzIj4FTIZliDdBpLhy00GC6n
 mqKVprfu+5i++cJTY1m+9rZ3PyKAskiscrltlpAPbzR7F+2d5t3sr/d8b32o0i/d
 36LtnztZqOBxq0QSwArU/8fANJJ8z/9EaZpm3Qr2QGPCIrfARGMKRTGIZTA1Mz5K
 ER3HmV9WY1m9wm+mRP5SioSuTVJ7z5GPM0aRHTMIYzbNpVlIG2+mXKOTvjEKRaSX
 DvJHwA6lKyThem41GeBuxlZgxds+Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02tkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMJJfeXMySh0cSACd9aGmbToheNRASLBvfxKPltd7eX+BMObeacKGZITabrWHy5y3YhRo9IhRpPuMeGgFLRnA8RsgNfGVdlAR6hSbDfb9I9BbMtQQOwxZIng8B7umcKfs2d/nbMMZugMgFJPqNUffXba4psp9ItGkA7SYAc6Pz3i2i8Wpw2vQR4U3dKjBOCFejBMUVFaHiijFN5JdEr1FaTC9JwnfXj06MRNDGBKB4QOnuVuP8tfep7zf6BkJBbocyL2Aaks5s4p6ZZOu6Vh8zuZYR2DVOtlDkvM9eUrGQAWK9Vw0DFmnbaZHVDJyeQyyc/QFnKFGVJa40mBvC0FjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYb7vSAHnZ8jyjb93ujXuS7A8+FGhO2ozMJfCyfCUck=;
 b=Rh/VVjDeYudHhBjjOR+yTiICjXnjZwNgNfmwaP1erig2KuWlntgwbxRVe+04CyqBXElkP/WZddkqJxrnJvNRhH8XgLr/Z35YooIkKzxQaBeAayuUQr5kGqlSeXRZBq4SEIUbWmxHgeurgTI1VR/7RitgCBIeOzQICqicPXALWZaJYSnb0WGOCfGZFq5OtYAL/+KlDJflIkgAS3CUJYMBUtU/GDrEvGvPx3x5C3XOi8r51peAL1OyKOKYF4g38VL7APjTIzukCXG4sp1v3ANk9VB6Sj7xf5wL2p2nkEHUBxYIDzCQF2bUoJ+GegkyI9XDGXXc+v4MRiwPcm1FlGmzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYb7vSAHnZ8jyjb93ujXuS7A8+FGhO2ozMJfCyfCUck=;
 b=ij/zsSU8p68yl+A3Ak0do9djxcEd6X3xcDqJhJ5lA3TKGuX6oVrCZARZ2V5MUU6jK2vcfizoqRvkhDs3URRDtwpaRfEsJ98xZc/Txk5Q4E2+WJLTmFFj9KMTD6yVEMcIiQUnUvJArl8Fzww3TS5JjxLLnYvgDCgk3DoIWmvnQadEdkhjYeHFCx1ZK6Prqc94PHWX3xTZMi2eKQ9Q7g6DdOiHhoB7F2S1e9gmfGZB3E1SWW+A22kqU5eZyHo53n5srAex0pTqKgB0jV0gV7d2KqnoVFNdDJf0sTVveWP2gl/LTQ7FyWGbFjzs3W1RyH8twf9rgPVvn7f0lSr1HiO1hQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:36:43 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:42 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 05/10] migration: convert exec backend to accept
 MigrateAddress.
Date: Mon,  9 Oct 2023 14:36:10 +0000
Message-Id: <20231009143615.86825-6-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f836ff-57b7-4c54-d9ad-08dbc8d527f5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddnn8gPBxX4eCodbE9fOKGk0aGKGy2yoYoQzVCVnlaPWEttgfAWuP6+zPHVNLL704UTwCQh1D3BUoqkTsME6LEayif7CS4Ad/9lVA6glD1BQ6IhVIKUlH5GpRuaJhEQlGmj3RyL1Wtc9Pstx4vfB0hwboXWO/iHZtarNRkW+6j+ijQw9LOvJUFJI+yP6EhLKr3f/gMwQCUYzwjwhe6vBV8lA94jSLT2JShjXLdBOuACLCpdFG68eQ1qvYjYVpgonha1tZMDFQy261tZnmm0qk7pT9DoFeVQMDto+s8dAQIdiTs1S9c7d1zsmFTml1v2UDizFmocXnjqYNBUZ229MpCyRwx9/GO0D/QxKenhRyCr6Wd4s9bLA/0myeCtrqVI3suCEgC4h7T5FWYniMZq3VYcZP5eS0yKdwqzmGsGsk9MgYsq4CS91xddQC4sW9DJaqFLMsAVZEuSzdpjqxmNTzao6wihd+mNv4SH9kMAvRmrAzZku4Fns8H+RnTFHUQF5b/iQLQq/d+sAPus9KlR2gW2qQ5YKuIcSfLUsQBGCOhynUSaPCo7FinEsgM3AXcPJOi54NesENOzpYlAImD3C/e5cLXBbP1eetAKkrRemLeSN4bYWfPNzhyhwX5XmUxxwGkh83TxuLKOK25No9QAZKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(52116002)(6506007)(2616005)(1076003)(107886003)(6512007)(6666004)(86362001)(38100700002)(38350700002)(36756003)(26005)(44832011)(83380400001)(2906002)(6486002)(478600001)(41300700001)(8676002)(316002)(4326008)(8936002)(5660300002)(66476007)(66556008)(66946007)(6916009)(218753002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UNo0Ue06G6goD3t1FszEtaB6SsvG0pas1jDXZvRBK9EnbMamGIRvvjZ21NK?=
 =?us-ascii?Q?yevf1zyqN6BV0f0wGUWqBke5dU24IIdBdeoYg6GatIX0xF5gu0Ztz2Dn9adE?=
 =?us-ascii?Q?nwjFNiIELGQAHzmkPbGSbC3X/ylcx4qsHOlGJG8ieZGa8XAnZY4gQ6In0M0G?=
 =?us-ascii?Q?E3iPqVMVYhnWY7gfPdaYfPO/u7S/52bXFE13s74b7S4uqGghhKgXPIUwzIvZ?=
 =?us-ascii?Q?z0ww5yxnT2rDQbG1OQPhVe4wAiV80otkmG43Veg0AAu2nI/L731IqNiiSi8L?=
 =?us-ascii?Q?E/AdaUcayzMZJ14VwGt8sL1i+kolktDKjGX0CwLS739SP2RT+psVoMjn6Yl9?=
 =?us-ascii?Q?xeMSdkmnKxS5aRTxQ6B8KZEsDStOTGov7RHlXHaJWunzqHFHLK1jbANEmETz?=
 =?us-ascii?Q?IHgItwaMDvlWvis/f2lvPeWZEayAyB4abEwY6CuN+3Sw9j+jpZSBrkKSb9KR?=
 =?us-ascii?Q?KyGn6JGMkQTXBgCeXWau97y+ZNDeN4U2EUyJzi3vZ1snpaoZ54p+Mux0ZZnn?=
 =?us-ascii?Q?qEx+P0WUPn2UCox/jwqiZzj3sssD+FN75mqzCFNXmMyy4KKIbH3VCONKP+L0?=
 =?us-ascii?Q?/7qATs568vV2Y5vI7xwYE9rm6JEZAh7fFNrFGWOke/Op3r7U4r56LYBAP5Bd?=
 =?us-ascii?Q?bTrF5hmpH9sHNuEyZshpslWmPu/gqhrh59XdRbdL60OScGjaHNe7RLIJdNdJ?=
 =?us-ascii?Q?2c6kzB1kGkztdux736vUUd7xGSdt7kibog5hqt5ZGn1ouxyq1iyqWYpJ2ICn?=
 =?us-ascii?Q?77RjU29rjnMUlQVDnsDPFkFwmrM1tQ1ZSIyImDm7oL4Etyi9/zYSWlU9hfqj?=
 =?us-ascii?Q?tK02C+S7/8319VCOGchSISWUeDt1hv3EQASDSQodQfn23vZIMGdCpelvyGTF?=
 =?us-ascii?Q?E4icAvGsX8lk3MJjaNqewyhhLhjmWkoTa+glnCV4KPla8JxalL7yxvZLsHAJ?=
 =?us-ascii?Q?YDT01LaIcGu7lrGK9DzRwsRQf8QIA2TxD0X1q3zRaifCPrA4upMG14vyyhq/?=
 =?us-ascii?Q?HjNrCzJj/xs+/53Cz9Y7ck+z5JxsekPlXtDmC/b+iGLUdq5x5r0gMofdEJZp?=
 =?us-ascii?Q?Y3hXGq3N0l1kCPU67AWak8jLFIrM2CLc0Oj5dwMOqbJuvSXldH6RbV3HwMpW?=
 =?us-ascii?Q?HDsg+AWvf/3PN/NP/W28Gfnspc2NR/2mwKvGdh/ouShALlIS3HNlam0VwClN?=
 =?us-ascii?Q?9cObL+mIpTVBvLDQGP9Z3NkCfGUCEAu489AntfWYRVQLiKfScCYfzvT30q5R?=
 =?us-ascii?Q?RowXQ/el/pe+BZzuN157w6v2uaoRbzjONnL7/nco+zDxap6uMUbdU4yMUsFi?=
 =?us-ascii?Q?wRWqKJlRa5W4AVHRLeT03Y6ln8eovjUIwddfaQbgVZ+s+At5p+KjcDyYw1KD?=
 =?us-ascii?Q?sXgwkmtBiWFOkedvYNVfcq8qGtIPoe9k16yM/WvLUPwDJPbZSrEwfQ9S/H3c?=
 =?us-ascii?Q?MY/VNg1+Pk25U5GHmD8VtY6sdToc01FAsQp7mLju3DfPL3COExhcD7nIVl5U?=
 =?us-ascii?Q?V9WeVF1Nh+R/gYBIumDDGESkwkRBXQcku2dRFLn1G0Wn3W86ruH0nW4QW4Je?=
 =?us-ascii?Q?ispGqH3H4B8Q6MI8OvheFdkKoAfM51WtFuvBmNtM?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f836ff-57b7-4c54-d9ad-08dbc8d527f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:42.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wBJlM4N2gDBA3tIjmj/SJWRC02Kby7FOXDpamFV/1uYkja9jy6MT4Noq7kGEQ1wJzY21vSuzlu/Hm8zkHWy6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735
X-Proofpoint-ORIG-GUID: _7zrL8W9vwm0WEoQmJAcLya1qOoqy70R
X-Proofpoint-GUID: _7zrL8W9vwm0WEoQmJAcLya1qOoqy70R
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      | 73 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c |  8 ++---
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 32f5143dfd..b5361abc75 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,20 +39,51 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
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
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer (&argv),
+                            O_RDWR,
+                            errp));
     if (!ioc) {
         return;
     }
@@ -71,20 +102,22 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
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
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
+
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer (&argv),
+                            O_RDWR,
+                            errp));
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
index ac58b35d44..732fdadb11 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -502,8 +502,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1765,8 +1765,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
-- 
2.22.3


