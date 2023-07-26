Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E86E6763954
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMN-0003cF-O4; Wed, 26 Jul 2023 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLr-0003Mi-7D
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLn-00019o-Lv
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:54 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32P032511; Wed, 26 Jul 2023 07:18:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=OlID4Ibyj4SiVXonGdoH4oQKR+o6ogad0oe5tbof+
 pQ=; b=l0bMUEOiQndYAfJ0xWxzHGA/JHrGCfl6Okp8GvrwYDptEgcpoxTc+Oy6f
 tkaV4G/vta5vqHBDayjmPYIV7/dAltPtva5XhTCxQi6T31oGu10MKvDBwfPBPLOO
 OJRpGIMIYiwdti6pVDlKrRIA3vzOdvykv3wrqOIxs94y6g2fohy0sdRpd2US+ueQ
 4ONrH1Ql6fkopPthfwyrCMalcRMx4F2GWUYsweubXcSWuQY60rD6rqv7HaOIcTPa
 /c3YVNaAHcPqRijlgOD+ebbtlANYe6TJX7xMXMUg1w2Antirq4mQjQpioxoYHr4P
 dTS7VzvB7SqjEVWHqMc6blZtWEipA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcxCxW0NN/yvE3HvdU13vue0wb5BvRFy1ZxVJZHrJP2x70M3sXvBkfraAhZW3PDKiL84LMI5XlU61s3BCRHQnwGcYjNIm0hdRsQm4fNOCmcu32dKaXnh/pyFadLS8NKCAVy7EOY/A4VYfusvN/vfB60fwF6yhJEOLPUeEM+16Byt1V3mdt18Zu8MrQQS/caqEhYgo8BSrcsXyqzNY7E/0K5ZYoxvDjcSr73SXU8XpXibOfTwgdkIMy6QL+Np50dsgs1Wa6wlE81oNvtGzJf0xMXf0o77EEskmOkZVSRyli6UUSax+8wkY5cR70CqZX4anM//RhD8dVJKxSxmcJRLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlID4Ibyj4SiVXonGdoH4oQKR+o6ogad0oe5tbof+pQ=;
 b=Vk2DTh+HUFxRTsj6yWXqBoopJewT32qcxT245mK85Fwww4oOyfU2aXERcr/kLgIHPEthXYlWey19+dOsml7XQPdYx9j2LeJLlxEGBkE+BSySnrSa2w7j2b+2HAPNhTcMSFVgiDr6P+fXVMZQX327fLl93rROjtn9XpcoO1C8xtOSqvT7O1lB/KDKYip0OHYF1MkD3B8526MG0EukcSCd2/J5WwOEWsgKDhb0YOBg3arPrExOF5QnrbLbRykP6dGHuGtJuZmWxG+wJG+9yVHyR/oaFuRjyaK7SrE4UiTD8wXSPFMQ9fC1P1qaIVdBDZRL1rkU0obhtmkNVkb32E5QHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlID4Ibyj4SiVXonGdoH4oQKR+o6ogad0oe5tbof+pQ=;
 b=BCaAlrUEL6MZl2PaCFjgrZh/F9M3GYmBf7l2FYkSRfPwkzDZU+2L78EeLdfxSzJ19jU5LuQD2MYZNi+ztYHWv4rGDenhEqDMo/e87WGo4sPrEin9x9ivAebZIPgoTeke0VmmJRMJTTp/K1G5SduNhd0bF0h4/LNyl7HK+sBHizvY0KiMNqUul9KwV/D16BD7kcSVI+xI35wM1LXVVZT4Pw6948OfXQcP0lz6Szmm2lstlQcqfwbHcqiG+QephRIisNRWG3l/ONzba+CjiAbLv9GloHvZ5td7yoDEI/7pbQPHhxmffAAPXdiNLw1SgabNHjB9axZDvsoxH6GN1c8iKQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:48 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:48 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 05/10] migration: convert exec backend to accept
 MigrateAddress.
Date: Wed, 26 Jul 2023 14:18:28 +0000
Message-Id: <20230726141833.50252-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: ce48b021-abb0-4fca-750a-08db8de33a77
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kEjv/qtEt8bxY1XTth9309NLpyUV+uWRZoP2dGb2z1mIm0kg4XDxyUadjKJrmxtThnoOXz24BnL2oJhmPA80svYDtarSmxtlJrP2vAmzfJjoBVQkryxGXGEJiE+4t0T89D5b2x4cDl5INNPA2SDZLHJbnBJOc7A/yHrzhV2iIOdR+McBDrj0vxSNNhGqwtuFiNNSiKHLDicIUE//0pZpc6IVTWJNYcqgnQFmkDto11w4Z9SH5Z4YisgR5sPi7V+P33AD66iQRquk//QskHPTIvdQtVesW2FmlxXAuXRHJRyIHGoC+SGYlNsr/AIRICOz6Q5jEEMlh7Uh0FEWrCDNU/ej4i4fXtiWKtJu0gXma8sj7ifSZZj8aabT27lqiS3JHqoLhsH09npmbpoWnsZU01WM8kqeQtBt/SadqFWsmn+nDwKgnwZEgMfjLWG/U5+hhucPI8bMHhOKYNlLzCig0LWTAHSe/P0SXbO2Bor2aDnLkTX36ALCgQ91x96B8qKs3Lt9M+h3UqL3Vib7Gq1kyNPwmpIquieYE1cZHUl7lQSI4r/nevrA4XhSIGkXHogj6InP45RZndYqTMRqBX2nsjEmxhI/lA12hpMzurrdvDgO1qHLpYpMmKZmNxQUBXcQ+Sr8iH2PGAhx9Jr5gvyfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002)(218753002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBzV1hpUTA4SnBOTEJkY3FkZGl4eWZtTVg4VHcybnhmVzRWajgzUFNEdTVa?=
 =?utf-8?B?TzIvSmZQbk9SOEYzaDlJWGRXSTc1ZVFRRDN5T2lyQStwbXVkMGxWRkx0Qjdw?=
 =?utf-8?B?b1dRRjc2K3BPUFY5eDJoZWxiTVhWN2pyOHlZNjBCMG1HMGNQdy9TZzhQNHJF?=
 =?utf-8?B?NTZLUzVxNVhlS2dPRFV3czhPdFpkSFRVeW10c1lkekpRemsyR3ZjTjQ0VzNs?=
 =?utf-8?B?NGJmVnlMaVpldHpBdWpXRGhCc0E5UnVoNTJOa2lNcENmd01lZWdoRk9yRmlD?=
 =?utf-8?B?Sm5nOVlFUUpEUUxxM0FYTFhGcGI1SGZ4UjFsR2VMUG5xbThNdm8rRURhdTY2?=
 =?utf-8?B?R0NHWFVCZCtzZDNSUHBKcVNqYzRVZXU1Z2JyaWhoVXZ3dUFzVEVGMXZqUnE0?=
 =?utf-8?B?cFhCMm03dDdtM05JdTgzcC9aVEF3WFZ0YWFGY2VGUXAyaHJhVUJwRWN0SjFS?=
 =?utf-8?B?bmNRVDBDdEdJZUNXRzdYWnBaMGw2bEtjc2JXeW1hRUZwdjRkbDk3UUZZQXcx?=
 =?utf-8?B?SkdXRzZwckZPRDRzRDdPNjd5eW56bjlIUktkRW4yMTA0V3R3emxzWkFvT29O?=
 =?utf-8?B?aWpIZ0tGSHVtUm43dW45UCtwWkMzb2hyQlpXeHpGaWVyTndCeWNLU0pHQzRn?=
 =?utf-8?B?UTNQVmV4bEdISnpDb2pBbmx3cFgyQlB6RmFLeGh1VVk1NUlXTnA5YnluSFVm?=
 =?utf-8?B?MURocnF2N28rdUZrcEcwZ1dxNWJUa1lmK0ZQUXF5Q3ZteHpJUTFiall2R3NW?=
 =?utf-8?B?QTRkT3pvSStQVE1kdU40aDZzclJHYmYrNnNzSmpWK29YeS9GYzBBK0k0Skty?=
 =?utf-8?B?bklVMVhXZDh5a3lNOGJCYllzMW5PQVFZVTh4S0F4SDFuWjFKeXE0QmJ6ZWZE?=
 =?utf-8?B?MStWNlhaWktPay9QdjR5QzV3L3pYRjQ0UldIdVdwcjdPMG9CdTVnbEhQY2FX?=
 =?utf-8?B?SGIxdjYyVjQ2SUFoWmVQM2Rtc1dCU2Voelg4L0VBc1hXMzU4VldhZEZYRm9L?=
 =?utf-8?B?UFI1bEV0a1FoSnAzeGN1LzVwY3ZGUEtya3UydFJzQUVpbUFxSU1ySUxwTWxp?=
 =?utf-8?B?bFpHdzRpdEkyZ0xMOWkrSjRpSXFYNk5IM051SGtHeFI2QmMwamtHTEhRN2xr?=
 =?utf-8?B?dXF4ejJNbURjekxEL0JZQk54TkdTTGI5TU1WREhjZ0szQlVUQWxyOWd4WVh0?=
 =?utf-8?B?MjN5Nk1FZWE5UmV2cTU5eUtkbVEyOUtwQ2RWc0twZk1OZ1U2ZVJtazI0VllB?=
 =?utf-8?B?bkl1U2dhVkxzVEdqeHhzci9ieDZlWWVidXFVRDdRdklrRWtIWlp2OFkwWmo5?=
 =?utf-8?B?c3ZRaDNGU0Q5KzM5blZ1WWIwNEZCakErdWFFZGU2TE5lMjVldmdYbkF5ZGcv?=
 =?utf-8?B?ZUtWY2pFSmhnaS9TR3gwUU1jRkVRVmNWNEZ0YUxhRFVDVkVoQWhZQ1lKTk10?=
 =?utf-8?B?Yk93SlFIaGRsb1lvcWlGOWlaVDNpRlpGQWo5b3Jsd2JrVWw0R0FTRmMxckFT?=
 =?utf-8?B?bThObVVCeEVDT004blNuSGUvdExPYnh3QUpwWWNUODZDbitIY1Q4UGtGRFhy?=
 =?utf-8?B?RDUyMDY5UURQcTYycUIyN3dmM1dtdmRRWkx4WFJueTNrT3NZbEJlMXpxaXZ0?=
 =?utf-8?B?OWRCSi9pazR5MDZlVXNSVHZQN3duMksyS2VkUTVMZytkYlBPbkovUzJDVUV4?=
 =?utf-8?B?c2tIT3hqVjQyRW9PdzhFUnpENkUxTE9GZWkwc0haMWNHR2pqcjdja0VwaFhq?=
 =?utf-8?B?c2RwamxyNWdOSWtSR0FhZUo2ZVJGNWQvWEZ4YTV6TzdtRXJiZ0Z6TU9rMEow?=
 =?utf-8?B?VlVuUWxBZXN1ZS9nM0JvYlFOa1IyYmZrZ3ZXamNkOXBpYU1XY1plZHdOd2VO?=
 =?utf-8?B?cERoY2I5UnZFZThYeGhLQnEyYmhsb0dVN2RENlRkL05zWDRqRGF0Rjl3NGtD?=
 =?utf-8?B?NTAwQ0xYS3JJbzBFS1JKYkJqQlZnWHp6cXJNcDZDbm5nK3RtbmFBa1B1Y3Zn?=
 =?utf-8?B?QnNsOGJzYUN4ZHFvR2Fiekd0dVRaUEN6OStKY21hZkZlMFNWZ0dEc0UvQVJS?=
 =?utf-8?B?TUJ4bjB6M0hsQjZRNkpJWmNvMENXdDJhOEc2N2cyaVdkbkllUldFanFFQkRx?=
 =?utf-8?B?ZVRJMHVvYUYwZDkvNlAra1JtR2Jna2grT01OZEg0U1JTOWlRNytMVGZCWG5B?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce48b021-abb0-4fca-750a-08db8de33a77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:48.2830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ojhi8NZukL7ouJ2ShHUKHh2KWIAUueNvAeIVDMBt9JYCZX/jO/LuXhIJ6cZjErx6l7PDEr+itqNj6TQoow4z2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: kr06CB5Z1DoYuF1JtlXVVgv1pbkVNitT
X-Proofpoint-ORIG-GUID: kr06CB5Z1DoYuF1JtlXVVgv1pbkVNitT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/exec.c      | 71 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++---
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 32f5143dfd..8bc321c66b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,20 +39,50 @@ const char *exec_get_cmd_path(void)
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
@@ -71,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
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
index 8012f93f1b..f37b388876 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -468,7 +468,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -494,8 +493,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1693,7 +1692,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1731,8 +1729,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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


