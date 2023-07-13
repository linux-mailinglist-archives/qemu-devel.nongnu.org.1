Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D7751F5B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu12-0002TL-Om; Thu, 13 Jul 2023 06:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0o-0002T4-It
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0l-0003aB-6X
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4rtjn028091; Thu, 13 Jul 2023 03:57:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=Kc7k29J7SSu5rkMtqGhCPJpuxRwa2osBLPOGNDHVE
 NM=; b=ZcZXylErv4okc7wnwHGclqgqFq5fDX2Re88C8lIvHD2m665XvcIdNEz+K
 AC8d6e+21hI5lMmUeYwZho7erFgoMZhAnIh7GxA2SSuXGt5C9bfjRoibGYhkBDE/
 cImQuKDCZTDGgbnKEP+C3az3OtF9m/A/IyeEDBDzqJz2/ijODrL4+H8mCWblyP4S
 chFJtdz0LoFxoRcdAGb+46gIdS7S5PzNNlwK242dm44AGcgRTswO6Jj1tuXdPx2r
 J1zsOEORXZ/HPnrLYasqRsK/R9lORH4XCnCB1cCSd6kfjHTlh6RjLIclW/e1y/ed
 C5WI23EsHQlFA6t8ldpUlfFVton0Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb41s42-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL0jXc8/U5puFAcu4qgQl3AxpJLNmbnEZT7chOIi1LyvOLDDyENh0nAq5c3C+EXX5xX3rZoKhclzFVttJtqe9/HF5DnnFg+EFhGJk31BD8dYm9VQjUcHFz3MvVn+w769LstvCDMwXAQsL1OvSlz9LcKSQlxZFkNAibw3nHR4dvoZhSMreQZNkwh+332AKFoNr8t5Fy5dew8EGmztnp6YJn81yLer8NFyUhr9gxC/vLd4oLKn8XRdEbfwH0RSBhr2bAoqpkLSdzG1ZLViKIX1LgQO8wMeJyX/wNjP6i3UwkV+mAMlbuls8OiKneU8nOGJbVt51wXswpyiT2k05MbN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc7k29J7SSu5rkMtqGhCPJpuxRwa2osBLPOGNDHVENM=;
 b=F1vGKKVXz90WudszIQs3Ta74mfg5GuUWD+uQvUfhm6BIZYk6bbkpvWfyOrJEW1NplzwsnJyxhJ0gUWOmTaqm6XMTCwIa7Ub6VdCuJByZJPqe1CtuwVQdrBjFk0GqeHDio3noJiu/UO//ws/wWDyVqm447Tu2gvo4qZ310t8vVqEvXKL2D5gkdAxvxgd4aI26BZ/rve6ONE9zA1V8k9XxnwT1QP+eyF+/udL+AQQPLCwY05Fm/BQb88sCU1lvN+AF2zz0RCp62zroAST+5ijGMhw00AJVH9USorgR+KUJcC+9cL8ao3YiVFTqkJxrk/E/I/ZK3KYhwMH2XLiFJf+LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc7k29J7SSu5rkMtqGhCPJpuxRwa2osBLPOGNDHVENM=;
 b=yMTEcrhryTQgSZ9oESLc5hEfHxintL29oIO6abV01BwE+e1rnX86EcWneJhXQKhuNotar0vMxLe0a/8uERioqVCediWPFMeEDUSPmpg+bWKzni3aMsgfpUY4MRDSvuClQ76+BVqBcU4dCs5GZVd6UJANGd4nXJRmkdeS4E/Kgcj3GQfIUc4U7QI5jqGHk9gmpm8mGtO74zgDweK4LmE3fi/b4bdQBVpzAcmTy9yvkpuRXBC6KGFTzlRV5SSzVkoBDQP8snRWI63thYgEBe5UYx+NDEOeMIRi0DBCDHARC9bVOTP4LUXZkIwDWO6hF+rRIFCPT+60Cz7tPDMMizawrA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:20 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:20 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 1/9] migration: New QAPI type 'MigrateAddress'
Date: Thu, 13 Jul 2023 10:57:05 +0000
Message-Id: <20230713105713.236883-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230713105713.236883-1-het.gala@nutanix.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a22388c8-6367-4a3b-0997-08db838fee16
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoOItqmdLvXHdUX5j1oIbutw5kgMJu3yesJBoiKo9ChvV3IC9u2XcuaCp6EHGs11+Rw791JQ33dHYyh1JVfwidJrCNffV6JOICBi7uCKH9yMxwnbx2fsPfTHZ96j6xcC4KVKaEmZtNITBarNsyfzsNwv8CCdKmLazI7GD74OjLX9xgKEUqPo+/0GeRkH9gHkYNZT7KKzcCVcrW3LaNEYd3Jp+EndKZJvmDM5BCA8cmLLWGm9nOoiUG37lrb3wVZ8hRwgHIUgIwrlkOPJdVgm13GPYqTgCDKu9jobt0RrkXUJxyKj2lBDlj4a0f46wfeWqJXoov+NL+XAbIoit8Rd+l+2opW6qY2UvUzELdeosIrZFmC2flhaH6JTvLKdLYbdPmWHDxZGyUaa9e+MEO5V5paZEboV8uu+f33zru+AitZNU2hr6DRgPjODFL2NB3MdMoJrCcw3nLiXfvqCXQj6busa/NBCW9eQEg2iMifWzVBGEj8IUOD+zq6H1lfE1T3q6FDQfnGC9EAi5mYH2PA+Iv816kwT7fDIuiFu/JwT+81Ww/vRPJXHFh8H9TOuvIvhimPNo+NQLgF1szxaEUwwObmG7uXA3/LsCzf9ZPBh2xbPxdiYGrTrDS9dSUvpe/kU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(66899021)(107886003)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tVdDhpRXRMN1BUQ2pVVk41dzBBSWhIc056a2FyajZ6emMya3YzVDlZbWZL?=
 =?utf-8?B?WFdYczVFNU82UGdCOXhPMUs3S0tPY28rSG1BaUVPMDNZOCtPWW9oVVRlbGo3?=
 =?utf-8?B?dXFEQ003a3JTTGhIRlhMZk4rakV3N3hQNUlGMEM2ZmdaWmo1bTVieDdCd0k2?=
 =?utf-8?B?elBON01YQ25oNU5oaVJFQlkyY3oyTU9yTENobm9uZmdHUkFZVzdlbEZTbEVK?=
 =?utf-8?B?YXhmNmxWU3V0QUNvc3k3YThDcnNZVjdSY1R5T1R3S01heG50R08yazVlM25K?=
 =?utf-8?B?a3pMWUZsc3ZmNnRjZW9PbFdPTXBIKytCbGV1V1dQTTc5SXlRdUNuSkhnNk1N?=
 =?utf-8?B?Q2dwdWJmcHZnRmdvc09MZWV0L0QzYjRwNCtVdGd3RkFHVTgyWlFXRXBqMEgr?=
 =?utf-8?B?MTE3V0FBV0d3ZVRQNm9TMjJSOStTaXBNY1M5ZWw4cE90RHVsMG8wbG1vOW9r?=
 =?utf-8?B?d0NtTHhKUzJidEs3cVBGbk42bmxjM0pXQ0ZWanNVcThLWjZ4ZkhVOEN2U0py?=
 =?utf-8?B?VlJtRmpzWE40cWJneWE5dHMySGNYdUZScktpU3JFVms0N1lwMWxtQWhiSm9u?=
 =?utf-8?B?QzdJWEh0eDZWZmt2YUdlMVdXZmxOVnFCcHdqd1hWaGQreEhaeXY1NFlXNytZ?=
 =?utf-8?B?REZuT1RqUnp0VHlDQmVHZVhlOG9TZUxpN2tEWml0UmczQnVtd0pkSWZWRThT?=
 =?utf-8?B?V2NPc1RjOWpPVXkwUDBQU1kvaWtoQW94Vkd3VU9SOVZmV3NxbG9Kayt2YXFo?=
 =?utf-8?B?WHNxajVNV2EyS3hOQmJRUlo3ZlloWDFLQlEyOVRiN3NzY3FldmpUM29aYXJw?=
 =?utf-8?B?NXM4MmxXaHJlbU9SZTN5Ny9wQmxmSER4TlRxU0RjRjNoVldSR1JOdGo0MXlF?=
 =?utf-8?B?QkhGdC9IcVZwVU56aVdJWFNFWHBSQkFta1pSaU9lWlluUCtzZW1FeHpOYml3?=
 =?utf-8?B?MSs2N2hySFFqcDdiSFBNVHVLNkxlTkVrelhQTHFsRzY1U3JKeVU0NnBoWjlS?=
 =?utf-8?B?YXF3RVkyOVdaWExOaGJMY3BOOVVyVCtxZ1NXa01LMkk5NVBLRlZkYWVDbC9P?=
 =?utf-8?B?UmlJN0hlWGZWUEtUKzZrQVp0UWxkdzB0NXk4bElTZUJjSDcyT0RSQi9zU1RR?=
 =?utf-8?B?QjRLUnE2THlJczl3U2VETEc1ZU80clVIc1JSd1NkcEczSGVnZ3JVckpKQVBX?=
 =?utf-8?B?RWczYXRTUEdlek5jamlqd21taURnZ21kY0h5cmtWQXNXS2kza2RYUGYyblQ1?=
 =?utf-8?B?OUlPd09MVjRZdUQwSnVDcjZlSkJ1WVlGWE9Cd0Q2azhUeFEzVUl4amNzY3RC?=
 =?utf-8?B?WDZLd0RlUWZRcG1UNFB0T2dWZGtqYTFtQVZVWlJMa1o0VWZUWGNFS1h5U3V2?=
 =?utf-8?B?S0dieTBBU2lUZ0gxR2J3enJSWk5iQmR4RDJiUXB2UTIvQk5Fbk9zWHg0QlZo?=
 =?utf-8?B?cisyV1REY1V3eG1VMDVuY3YwVllBeGx6RmpPdGpaMnBNYXBCbkpSTkhsL3oz?=
 =?utf-8?B?ODFKNE56dTFFeHhYaXEwTllRZFlvYU82dCsvN3c1dGREdFRkMGRpMnBhb1ZG?=
 =?utf-8?B?VkxRYkM2OExzMUFOOFM2Zzg4ZlNTcDFkSUV2d1dwQVpRKzcxWlIwdWljL2NT?=
 =?utf-8?B?SHk3dU9XVXJlVXBLOExEZjZKQlhqcklHUldmZm9wZTltSk0yRDA1ZWtkdmNj?=
 =?utf-8?B?RlBXaEtBUU1xdElsa0lOWFdnbko2RUp0d2lmQ1VWM3RZQVZzYnltSDNmSk9l?=
 =?utf-8?B?bjdUL2RSbGxDazRwbVZ0UWVidW9iNzdsNnBFd1RaZTVMb3o2ZVhOMWd2YzRJ?=
 =?utf-8?B?YmhVaEoxL0lCUGJNZmtCTXFiTTN2UCtWK2VGWWZ3Zkt0dDlHZ1d4aXRMVnVH?=
 =?utf-8?B?M2pWL3FoQ0tTL2V1dmxrY1l1THZaRUxCbHlMQ0Y4VjIyWStFYVlBVzVwRnhN?=
 =?utf-8?B?VUtPeVdabWdDdyt0YlQ1VEY1RFBkeThsWk1iTlVGaklud0kwZG9OQWdCdjRa?=
 =?utf-8?B?blFjRGVLSXJCcGdDNjdpc3ZnSk42N3h6OFIvbmVjUkNQa2ZoaXFvSGdnZXNi?=
 =?utf-8?B?R244aTRWOVNYYzFBUHBkMXU2SnlacU5jUWYyTitYaFo4N0lXYUlaODJCZ2Jw?=
 =?utf-8?Q?1PjuqU+/lotXUCKmkI1kQIvV6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22388c8-6367-4a3b-0997-08db838fee16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:20.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrNB6UEXtG4UqshfxVzUoNnEpEFDozrdonUagpebwbx2+a6Ct3tAp3L4kyesPGyEI4eAr3A/PJxX6c8+lAuVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-ORIG-GUID: M6wYZ8CnXIfkAe6MqYptAZojSKaWgOrT
X-Proofpoint-GUID: M6wYZ8CnXIfkAe6MqYptAZojSKaWgOrT
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

This patch introduces well defined MigrateAddress struct
and its related child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI
- 'uri' is of type string. The current implementation follows
double encoding scheme for fetching migration parameters like
'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double
encoding of QAPI arguments, as Qemu should be able to directly
use the QAPI arguments without any level of encoding.

Note: this commit only adds the type, and actual uses comes
in later commits.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..b583642c2d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1417,6 +1417,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrationAddressType:
+#
+# The migration stream transport mechanisms.
+#
+# @socket: Migrate via socket.
+#
+# @exec: Direct the migration stream to another process.
+#
+# @rdma: Migrate via RDMA.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.1
+##
+{ 'union': 'MigrationAddress',
+  'base': { 'transport' : 'MigrationAddressType'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrationExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.22.3


