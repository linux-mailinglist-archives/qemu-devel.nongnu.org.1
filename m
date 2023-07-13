Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348B751F67
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1C-0002Wz-Oj; Thu, 13 Jul 2023 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0u-0002TX-Qo
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0r-0003dl-Ro
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:35 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4j2hc018083; Thu, 13 Jul 2023 03:57:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=+iDNvA2e1K6HSuDdQy/NDDeA2YbsLMxKSh8SFl9Xm
 60=; b=jx30hGOIUUD5KuTZu3gZZM/r82TULeeNy9LPv0KAihRFXqs/SbqsosK+Z
 SoMk+2CajmU299deG91gYVaRIq+499QDpZ3k+4eQNsn5/C/Suof+Lw+vgvRjCNtu
 FuQdaMybV7DHy4RVPvRfEL1MBKPDg8ktAapB8SRwnmkQIesFQjjXR8J8dLG+pG7n
 WJPGm671M0RIkm12lZjjTQiJK8wLxzTA6MUAnwU9H25JTCo+De1mT01u6cN8dPgc
 YuO8UUwu9sIAo2MpPGpH5RChWCjcNkPVCxeXg799GFcnZI+CUOrvcN+kL8VpSbpF
 /cIVWp9/PzyAWE61sf4BTo8Asq0hQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcqZPyCWNIftdZFyac773J+bE3Y88BWo2ZcBU/D7rDKGwjRgh8n77QP8rWKCzSwGPf4s5tfYu6lG1GSRXgwlQJc1V6w1f+nUtBWb2dfFYIrcgmCBEcWEWIsk7zJ3Ntj6UzRiTpSum8dVmLy7GkbAQ4EJjuiIbdkxgCAmhgYjItdd9uG2Ioxrm28vcMqLqC3bubqje8fdvTQQP0FoltzQ1168oA4rmeB+c1mX7oT8o89Lq/hibldBBNQ/yzOYJVFqcPdtRbmR48bn1qUe7Zh8Vsm/hI5j/pX6oh5r2R18LC1IkASQJ6o21eBNon38zZfvhodkFPFfJ6p9CeYVFNKUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iDNvA2e1K6HSuDdQy/NDDeA2YbsLMxKSh8SFl9Xm60=;
 b=VWgrlsG1vujbPfU+D6dJrcwrc9XSo4VokryaUGgBAfx/EASMDyqzRjDmLFut9bYAmRy0FOVXYfPf5jXQRX7JJJtk84g0NRdQpL0e2MfH3EF0hD58T1WOv2Z8yLERxx2aroHXPjv3nssSO0kOaMqL3dL91nRdSR8Yv2bHS640wmn84oGg8Q1NqiVzgBZd0HWBEwXmGGuO+9pCteBlG5TVBAtIbzn1igmnMR7qOfJVSXpOIC/lKp11gshOmy0N3sG3Esnp66271MFIer9Mi6LJTE7vDPtB5KzHO6Z0nXc+XO0Zr12oYOU9y/AckkoAtk5eYq9NUB+j1CLnIKLzmPLZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iDNvA2e1K6HSuDdQy/NDDeA2YbsLMxKSh8SFl9Xm60=;
 b=Qtn8qtl9xbw3ZBeOR5cNUH3vB2qNWEzLNzRTKU5rBNOEW0lS1p1QPUgfSPuV+TPOpcq0imOO/Logcp+vsP3OAYDoRs29eUhzRaCV+U/paaHzSZF688MhmUStG6F2evmiyfVc3d/k+D9e6lMpcZxhNlU5hKazVMlQ7RNcQaQtBFpI37rK4JmpymYnEbfLCtjnwpCZQ7B0TlZjz2mwmFVOErEhvjhZAjMctnGPrp/SAPTPlp8YLQRuqWtfrR3KYruhd8OSKzIPFqtNnH/ZF+ABH5T4B+dwGfmrZyaM+2ehMThTvW3MXmvuoBYi98bgEapIsMqG2hbIT67BioV6lQu+XA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:28 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:28 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 6/9] migration: New migrate and migrate-incoming argument
 'channels'
Date: Thu, 13 Jul 2023 10:57:10 +0000
Message-Id: <20230713105713.236883-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: a83178d5-02fd-43b0-de51-08db838ff313
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdz9L0NEl+UVciYnSvNLPVrFfeZYDWwELm2xIDtqtLjwyk/BPzpI73Ms8aalUOhAME7Og7jyjd1YePjSXFzbvbHTeNrS3rZKmWCogc/OqbhGEbqfynEQlVm8XiXgWzj9HJS7+u2I5i0GrNfU3aowtcKu4ZuHNRqLH0H/cHFFQOukhIJOCvA4exWoGrYd8DV7Jv9ypoGK4fXXfxpLEECTuLawVmoLP2HojFEn6Ff9Q2R/M1lAiscrxECgr1bRJ8REaBv/iTNOUI7ehv3GWrSiV1i0TuzjYRwP94rwEzaurTbWvSXaaJV2iEuYh47YiK0DiHtGfIWppHR1mWCjS3shD8vuvXprEAj3mStQUoXMx+7pMgtlkfHWgdm13stK/FTUxlj9PdORjyFVAbK3QMQfi7j2t1+IhvZG1De2mzEoyYmfqcxFPRf+1aW+SPk01I9+6FaVSaTateejJWs7x2jWqoahFTI2M1/BOH8QAD3yp17GfD7aMO7O/utx7IwVXttuI00wZbuCvLBkktHa3Tfe/AFspyc1YF6N8C2LfzCogWLmv+gEqL0wjFAMRfJxca+5qPMfSDky6kfxMoblTfFM6S66e8ku/pmunadqdaavwYmL+0/Srun3hyUh0+wwOV4KuvfycwtjzhOQl6275eLlgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MD+GTtZ6hM16WFbvXoEfMKxBxiIbQtM0I1lluqB7PavtfcW632aWuMltsgwl?=
 =?us-ascii?Q?GRzyggfY/8jI8hfalWVAGmSUdj/2+RemasOphPU0Xq6OByKCaQxj0BKY0RRR?=
 =?us-ascii?Q?vY7Lcp0QtU0oykUdc+MZO0ettccLaXn0rBMpo/Jef/RFmlCfvAElRuddRXfk?=
 =?us-ascii?Q?5128q0g40aNzQEvNNxjNeB1Cn7MCl9bhI1Syn5DKLrNVp6QAv5Zh9tTXRgor?=
 =?us-ascii?Q?8xJuEnbDyLIJJV/fWsneIX+LRfAzA0NbOkglDYQcTJUf3L8YMouxOiMIMWfa?=
 =?us-ascii?Q?8W7Y0w7mN3NGBRZgO94gijAq205H+85GYBFTIES6aDVzRiuIQI509fATQREs?=
 =?us-ascii?Q?bHer+L9IfYg1vnKNamiG6ZKBuwa1MGtHZw0pWo7sRHRfr34Gdgmdnh0eKiRZ?=
 =?us-ascii?Q?wphOSMHPQ6hb/5NQKdCODUQfHBeBk6MYgcHIQK/qSKukDrde0bpmrEoKywpN?=
 =?us-ascii?Q?CVr0Hq6ExU4/3X6ZMEGIdDJA82ACkubcpB6CCly8O0YCOufWfCjDn53xtXGq?=
 =?us-ascii?Q?wtExigkEvKbG9j7Kj8TtQ+PtOm+7Um+KnFqjC1LhwEJ7LqzmncIwYnypQJeR?=
 =?us-ascii?Q?3mWxVc/5H/L68B6Qb5P3qIJAWuTgniq/l1rNHMNSiZN1T4zdHiJd+nS8/TQ7?=
 =?us-ascii?Q?zt3+dTMkhkpmGTNc7hblvyOiXazq3KOvGKp8E+KX8/gbZMocrthg4fLIg5GD?=
 =?us-ascii?Q?2POV0yL3+oL6C0bQrdiMX8iho++5A99cqeAcvX24oBzUf6LHMdydQOo7xb95?=
 =?us-ascii?Q?t9KOmec+4ht9vg19Bg1ai5DMu+513wj3zdf7SPcZohEamRHHxhLrajk1u5In?=
 =?us-ascii?Q?5mEvjtGXu8kZLFNUL6G8UUDK1VqXtMAmmGerSz3kZrImhMj09hmk1ET6JEFU?=
 =?us-ascii?Q?YOanLOK1QuVgZdSpdVgskru9oDCc7wkkFJyEG1+msv3fGr+yHMK8ERgtA4eQ?=
 =?us-ascii?Q?PoPZ1zmk9DPtm8KEbkIJ9LsNzgqH+Lb2k3HPvQR6b6jmeXYi9LSiXHOurY9A?=
 =?us-ascii?Q?pPtGEh5lHF5DikU7dRLwAZaa5y16Hc6ZfDbb5mfEW/CS0BMycvwlXLte8js+?=
 =?us-ascii?Q?6CiOuUW0gTyL1rE+p1qZjMNJgYCCEs93R9LyZXadwcr99sHASRlo89RxJutl?=
 =?us-ascii?Q?zaisHloIu0JZo+sP2jzFmm1n6L17BNXMr6gn26a7B4+Hif1HmIV1sqKuy6z1?=
 =?us-ascii?Q?D9GCcQkUsipU3FH3E4A2X2KCz2jU1WBWhW/48tEixMJbqSf13wfCiyJ6wZib?=
 =?us-ascii?Q?GKQo4yo3uV/EVJnjnUi9sQ+usyovNVwweBi0nuFcxYOt2ZSQiG2HkXehuqNA?=
 =?us-ascii?Q?bmr8LbBxQF87b20jq9jdn7qEyOgKF8wFGRkZ10bpd4m2l5etekwC3tWJKFub?=
 =?us-ascii?Q?nvuWVpp9kgrDbtIzjQEL/datkGqFm37d6wn3IbteJI4TNOGksvYIQwId2Wq0?=
 =?us-ascii?Q?qNEjCFjCDrblW+fKa7N8IbkUHl15CVrOW9jslJ1cF54YQwZ4JqJYfXtAjcZR?=
 =?us-ascii?Q?A0DOOmJIQLkSFJpYFbYvRdTYv+cPnXyZXsMUaYJ76XUw3XGUCXfbgMKyol3C?=
 =?us-ascii?Q?l6Al3l+k73SY+9NOjRvnMhDXr4EbMbpLZSTX0YLz0+WZVEIYr5XmHzXniN4Z?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83178d5-02fd-43b0-de51-08db838ff313
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:28.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbiaoleFPYBHNggtZQ8QerhRHnjoKHOOGi6nsbPhxdCccZf9ag26SJDFwRejU8lNsteflDcx8PaBVS4wW/ymEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: n3sfBbMCELE1lAf0-qiULO1y6W7ANK_c
X-Proofpoint-ORIG-GUID: n3sfBbMCELE1lAf0-qiULO1y6W7ANK_c
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

MigrateChannelList allows to connect accross multiple interfaces.
Add MigrateChannelList struct as argument to migration QAPIs.

We plan to include multiple channels in future, to connnect
multiple interfaces. Hence, we choose 'MigrateChannelList'
as the new argument over 'MigrateChannel' to make migration
QAPIs future proof.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration-hmp-cmds.c |  16 +++--
 migration/migration.c          |  34 ++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..5f04598202 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -423,10 +423,12 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate_incoming(uri, &err);
-
-    hmp_handle_error(mon, err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate_incoming(uri, false, caps, &err);
+    qapi_free_MigrationChannelList(caps);
 }
 
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
@@ -704,9 +706,13 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate(uri, false, caps, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 52e2ec3502..65272ef739 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -465,10 +465,22 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1496,7 +1508,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1514,7 +1527,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1550,7 +1563,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1684,7 +1697,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1693,6 +1707,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index b583642c2d..34ac4e0a82 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1458,6 +1458,34 @@
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress' } }
 
+##
+# @MigrationChannelType:
+#
+# The migration channel-type request options.
+#
+# @main: Main outbound migration channel.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrationChannel:
+#
+# Migration stream channel parameters.
+#
+# @channel-type: Channel type for transfering packet information.
+#
+# @addr: Migration endpoint configuration on destination interface.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationChannel',
+  'data': {
+      'channel-type': 'MigrationChannelType',
+      'addr': 'MigrationAddress' } }
+
 ##
 # @migrate:
 #
@@ -1465,6 +1493,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1489,14 +1520,50 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of
+#    default destination VM. This connection will be bound to default
+#    network.
+#
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 6. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
+           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1507,6 +1574,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1522,13 +1592,46 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 4. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrationChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..d811f3f878 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2651,7 +2651,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.22.3


