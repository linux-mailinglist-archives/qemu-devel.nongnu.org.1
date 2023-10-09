Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FB7BE30E
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNT-0003R5-9W; Mon, 09 Oct 2023 10:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNO-0003HQ-PA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNE-00033X-Qa
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:53 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DB8Lm008843; Mon, 9 Oct 2023 07:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=8f91rP2Bu87ExwoL/rgre/SedVUjER2L6plSwKyqi
 58=; b=csjO4uFu/FuBYg9KHey1y8zsoEE1+G5V2kSTuDJZERhXDUmFnfVKV1U97
 bCYqntCdDff2u5mxNKY7ESSAqiRSFCGAKr/HVeLv2EJaBGfX06Od/6hLug3Bqq16
 onETLWRbKOGfvM2NNIMS8CeMvZMn8OHNPYEGSmC/rEfumms8U290mzsWbmbau4c5
 Sb15k/d+Xv9ZYsgEp890q6HKOHJD0j1mne9LMXKrPirlYoHsFCtL+Y/u19Tu+DSj
 iyoqfS5FvNxpaOHBzGCDrSrdycLRkLfb/Ed5M0VZLOMg7w1XxPIoyUYoZIBftkft
 28g3lAryDDd4J8Sbs38j8xcylXGXA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtt3m-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu6z3znLOhNfZtvHQKdMhFWalfjv2gS/gJEFp2XcbSfwGOwdjmxvLEE/F7mX2vdOC8DRUS+Hmn5l8ghMsyQA2K/cLuR6dXRJSZ+OLz3zWivBdQ25bAFTHDjpkx3yVDn1iNSm51SxMYGid3rrOJ9lsWaiKnGhTZiIDSUWLoIp2fAPdvKTESTpvZa3kdawbqMd+ppfmSGc6uMCZiwUvj9EW51qGbfkMnMNNkUqGVp89hnQaXKjswoeZK8/NCl/NsRuo3IJjIsWs0ncMYYIlxw5RWCKoBEKmRmTkR6cklE6oH0aej0ka6wHc+C4ryQIvK+1DfpJ/CD5+GYAlsf965MYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f91rP2Bu87ExwoL/rgre/SedVUjER2L6plSwKyqi58=;
 b=K4Lv0tI0CmcM1h/gcJnKMQEOC6CiX4B02T2KYHOfCSWl33vfUd3BiVJO5jfYzxTk9uyBXzpTODMJBTFGIhZhXGGrJMnddJL3MgRBzxmWC6ZcWLNoqCWkyTZfJvGa9Ljt3bFDX4AhKoExEVzcXdRxQqS/cjpfCfkiTSAHMHWnA4Ix/UgQUCXE1LkSjPAkVE1rWL3t+8HdhVGb0aR+RdNC0IV7/Z1LUTgne8WZmKGgcEkzhlmVgy3R/8HIaFOZFl+lbTfy4Sw7ZvgSojeLNlDzxNciTcra65lrTgm6v9n0kUwNlGObtBByMfUbfbukEaM6ZLtwOykz8S+88AjLGGjWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f91rP2Bu87ExwoL/rgre/SedVUjER2L6plSwKyqi58=;
 b=fSUC1tAUbG18dyFaSxUOYowlRhDTKoa7k7CTCeRL2I0iPgKEJzRlOLPRIyF//tak0XneZQ4bPYKzdRV5y1snVKs+o/gGB91amiz997aLPCaxVLc7R0ZBhhBvIawFgMskO/1LdEZOH7K96R7rp0xjPUueM2khfnZAu7rB+hZAqEMvOJbrZk7GwU0t/n+vsGkFxVeozZV6KNaJvIVwVXwnIy+svhnHJKkdCPZz1iBYaU6WgpBQA349AjGgwjKOtiaHbM0kSJL/pE2ATbc5so9T09HGWLY6hDWLGBCNE5PoOVclREa9s/8WuVivI646hYojmeNJy7KYsafuE/fl8zzamA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:35 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 03/10] migration: convert socket backend to accept
 MigrateAddress
Date: Mon,  9 Oct 2023 14:36:08 +0000
Message-Id: <20231009143615.86825-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 749ba89d-b7b9-4fb2-080c-08dbc8d523cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSxKVe6z+q7ZUHnPjJzgYsWgRGpO9M07gF+zFpp+PSEydXToXQYS37JAb1ahzxzFNE+Q3E5qZjK1sGK6VQrioqznPT2evee6BQoWCL7W8EvW9ldyJS00ejt7RyEMSRGz+AlDhlCMPb9xz5tQ5NHXE/NnHv8sm6UvnCD83qkFDEa7K8do+m77Qbz+DmG82r91RVb2Q/yU/mQAj5gKknP12qEq7BOOKn2us+6Z1AWydqeq3dGyzEmE0nJ90bO3MUgUpaJEslZ00oUwN4XAr0eGTCnGwZVt0P0vyZ2fXsohHKM9y0B/WbGxkVE+2iMy8cO2SvoJC1bXKzvaYDENF0xUCQwEj8SU7JHJNjG8nAiwcYlLhmyAZqUgDwP/ZTzmiHBUoNn09ttlOkmAdNIlbYWnnppGLHu/m/LqmT46DMz/SboRw8sP4EO+7lfoxn5xRgO843hbJOwI6ZWDOs0q2HB35BndK9Flgonr76EfVNr1nEhOkguRozdZ06sX4KEilebTVcVRdlrUqL9KnW1PyvL40eVT5FKIpBODmJrDI8bBx5rMiJ3EY1f//MLLMngCIftT3f8CQ7yyefGK040ijtavJwdLO2Hm2+c8f5pXuVEiRuKbCEU3KIJPNekNR1PRpvgk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NXb1R4Ymp5MkIrYkRFMkNFWmgwZTdKbWdxazUyYllER2JmRHRBNlFDQjhB?=
 =?utf-8?B?azk5WVVYUUF4TmVrMHdUa2ZKdDVLbjNCeDZ5TkgvRFAyU2xIS0ZYUEZSaC9I?=
 =?utf-8?B?OC9VLzhTdEJaRVVNemxLS01JUmFUcXNidU5iUGRvdFE0SEY5SFNtTCtIR3Nt?=
 =?utf-8?B?WUFLeDlaTGxPaDF4MHpaaWRlNVJUeTVLV3pPeGY0cWhwUnU4WmtZbFlVcVJt?=
 =?utf-8?B?Y0FJM1dEZ0czV2NwbFpUVTcvSjAxbS9NM0ZjaDd2VHRLUGJxUmpiUnp0aUw3?=
 =?utf-8?B?Vm5NaU9MVkI0cmZpZ1dOYmwvVllCN2dpbWVBV1BqQWxKaXFSamdIWm5kbEp0?=
 =?utf-8?B?WllHSkZWRitrUmlRaU02bVdoYThMWG4yNlpSNlI1dWd3RVcwRS80L1ovQWpE?=
 =?utf-8?B?ekpQYlh2eE0wbWZiS1dCUnZiWUxEQWx4bUJxSE5MNUdEeVUyb1JONGgzVHhp?=
 =?utf-8?B?dWFBUjdzUGsxaUErOWUzcm5IVTlMdGVnRTdXOE9YbEdGTFB6dnhjOVA5a0J3?=
 =?utf-8?B?K0h5RjFiSUx2ZU1pSjJYM3o2M1d1WnVQQ0lKRUxMc3hkeHREcy9jN1hYQ094?=
 =?utf-8?B?S3lqTzhIWW1wWUU4WVRWRE9vRThTMW91Q1R4NS9QY05YbENUNy83Tjc2WWJ4?=
 =?utf-8?B?YjJqTmZCZitKd01tb1p2eVVnT2V2NG1KNnVjVUd5SGFZL0NjRHdIVFV6aER6?=
 =?utf-8?B?T0gwak9qSjAxMlQ3UXB0STIzYy9qYXFaalpRcTBGOTAzN202MDIwR05jdnhJ?=
 =?utf-8?B?VjhTQStBblc3SVYwVVFRQ3FYekhXZVUzcUUzbjVwVUNkNUJQVFRMRmNqVXBy?=
 =?utf-8?B?UmJyemNMOFJWaHVVc01aaDlaSlFYQTdaenVSeWkwU2tlS0h0dnF4NFBVWEEy?=
 =?utf-8?B?MnJSTnJwQmVIVDJpak1QOFZzT1RabTczcWlOWmE0YS80Y1ZOTEo1dFE4WUlJ?=
 =?utf-8?B?TW5nWkNXTGhGRGZYTHE0cDVsZ29CS3FJLzEzRnNmeFVHSDA3WVV1QlFmU09h?=
 =?utf-8?B?UWJCMEZBVTd1MDRTenk1QjVEaktwVDVXbWk2R3hzRTJXeVk1RUd6SnZnR0I3?=
 =?utf-8?B?MXlMZElseS90bkVOYi82K2RZdDlUQ1cvN1h0eUlDNDBpR3BOaTNIVlJPVVFM?=
 =?utf-8?B?eDMyV3dEWWZ1WFY0TmZIYXQwTVkyRGFQaVptUC8rQm0wOE02L1RKcDI2ZHRS?=
 =?utf-8?B?TGo5UjRwaDJ2djVWVTF0QUZ0SnlQVDBOcGFCemxVUWFMeFlWN2YwVjQ5dkh0?=
 =?utf-8?B?TFVyVmJuRXRJVUNvSXFrdU0zdWxkMmVDTUxHdkF6RUlVSTM1b2pYVzdXYzho?=
 =?utf-8?B?RHRJeks1NEt1QUZmRDEweEhEaDlqVHBYYjdpR29jQXQ5MjRvSzlKUXlTYWk4?=
 =?utf-8?B?RFNjTUNQUXozQUFua21kYlRVK3l5WXN5Vmw3SXkyRmVDYjdnUm84S2U1alJB?=
 =?utf-8?B?OEJ3di9UYXhYN2ZOVS9NRk1LeWIvbmZ0L3prTnpic3BwVmRHZFVYcWJ0cHh3?=
 =?utf-8?B?RWdzcGF5ZjlGbGRUdVRvU0ZzMmVJN2ZwcFBIWUx0NksxYlpNUXJUWU5pS1BO?=
 =?utf-8?B?KzdIL0Zyc09BT3paQVMxandZcFAyUVVKK0pJZ0trV2haOVhHM2RpQ3BjdVBa?=
 =?utf-8?B?UTE0eVBjNnhRekZucUdUamx0cjgrLzUyQVhsOGI1a0k4SnJGRzNsUU4xcnQw?=
 =?utf-8?B?M3gzTzlYdTk3TEQwVkJVNFJJNU1JemNCOHBTNjRDR0dUVUtxdG5ZY0VjaWJX?=
 =?utf-8?B?UWp5a1liMTZGVnBWOGhoek5TYjhEcFJ0UlNndkhETlpGR2hrMEIrVGhDTVQy?=
 =?utf-8?B?cHVZcVc1bDc3dFBSV0xranlXUzhGRzl6cFFKMGQzb3d3MVJ4dFVmL1NucWhu?=
 =?utf-8?B?Zjk4T0RFSjNwNU9oVmREZk0rY0E5Rmd5UGhlOUl0ejA5SkZDajc3SytnN0JV?=
 =?utf-8?B?UzAybndjaWtFdHNyUHlwRmowSE1iY2hlTHZWSDRxS1dpRVRmN0I1eUdnMG1r?=
 =?utf-8?B?SmxQMy9JSzdNVStleEt4NEY3TDFNWXlYS0VqL2JTUFRibUZFNThpSkU3dlVk?=
 =?utf-8?B?T1A1RkgzZHdYNytGN0k0cUwwSDJXTkl3UmdVNXFhQ3pwektycVFzSXFWUi80?=
 =?utf-8?Q?9fZXK4sCPVzvobhfrLY8RRfwV?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749ba89d-b7b9-4fb2-080c-08dbc8d523cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:35.8482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IU/GnwBzPY8QcLdKZT+G9lCf6pS27pts/KISgaJYYl/P34CY8hFSLZI0227rYuV7UVhPkB1U+fLvATg06vJslg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-GUID: _E-Z0VxVKQjcBAqw7xzhgnNpCEJAjxz2
X-Proofpoint-ORIG-GUID: _E-Z0VxVKQjcBAqw7xzhgnNpCEJAjxz2
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++------------
 migration/socket.c    | 39 +++++++++------------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 89fa074e8c..c9961db1c9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -489,18 +489,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1749,18 +1752,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -108,19 +110,19 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
@@ -135,18 +137,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +162,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +202,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
-- 
2.22.3


