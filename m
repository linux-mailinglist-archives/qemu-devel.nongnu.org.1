Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D207B7956
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwn0-000560-Cl; Wed, 04 Oct 2023 03:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmy-00055d-JN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwml-0006MO-8f
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:24 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393Kj15t026467; Wed, 4 Oct 2023 00:59:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=SlDNdWpkBG/zIBO7IKoz82ydiJrHWoRrvG33lIeyL
 o8=; b=ONHee3KxR7W8xnM1lWd0FHItEIzIePJG8lrsGivGax2p3cvtOms6iAnA3
 /lOYBdpPcLBtuVm311wVUesX6xlmvyBjc++xzy6auFP2r4PBsFIog3/d4MBw6dPq
 dpssPe3ED439QMdWbWDFiXYETZG7oRfHJiAvcr60MDF60+BXt+nGIogItNBscfeS
 1/rWoqxSm6wlzbdrNvmyBaJIhuSp2tRSAXZm3zGjkY37DFWR5d9mVl/gemtlkRui
 1gTuwIo29aztq9eS+7R6voEJuLH1wYA2OPqecAmcGq0KKBnNaAjwVoGrs5sofztB
 laxg9XDZwP+ssIu7FAEPUbuTIT+FA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rpr8m-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYiicbxaXpmMJ9uGuZG8xAQbqFnh1ap5Mpe6u60uyOcwMDPn3D2IylceI+OIWQYK66PrcW2lN01CxleoB9lh5SLzUX1BMkAnLutjXrURmZIDukIs1xLy+cMh0Gr0yRRtT4B+eyy+6mbLRuTUW4JXyxAO19NRtXpWvDuG562v8TjnETgmYMRJPsAVjbob6PXiNvzef7GOX2S1jC+i2fJ6zavsS8Ijop/uFDXhCDmMVH3zQLeG1xBMMV7dT/bd+L8lYaY2nEI7/2GuJ1qFApE5gZ0DJ6hV6H7BCobEEc+2jSzf6LmPXbNFf6N8ffpN3WrdGiJ7keJ3XKJ0ki7PDRxFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlDNdWpkBG/zIBO7IKoz82ydiJrHWoRrvG33lIeyLo8=;
 b=gxFz5C1adSiP02l9CPd2yxTqPtpdPQkURYP0DlN474naCZa1fRBmqgnm9HB8t79BCtUDob6Gx3n/Mql+q0OErMQ8cwYD4iSd55IWMmbIap4hNBPvlnxxJ2z1pVz3bkllcSj/Fm9xNODaqFz9Z8Mr7ji9vQJXRa3GAt/lL4BEG5DSDsVUS14uc0o2vWd77d2+oSeluJgAPVi59hfU1eMVa2TNeMlRMj/tlXmEqeuSYR6UBVnWG9RCY7YBibaIqKR4NDyPtexVoTFASRpz9mAbsCihz7asHxGW/ZKYsMAsoOPKW1SiYiLk7E7ADxtcQJ2s14vfnYh+LwlK0f6gF+ihhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlDNdWpkBG/zIBO7IKoz82ydiJrHWoRrvG33lIeyLo8=;
 b=SD5cyABFmLvJOOlgjGwEKrROpfEhou0LH8LZyygHtgf0wRkD1DoGjEyyLQGAiBb2kBJxqL9MZZHO0T/Izh0KSQrXrunvWxwchW8MIBQOzTwJQ3chL+0MGRPTGohnqfiHxsS267AmuIv8xWh/9DKNJGppWCBy1DQZUxfsBBt+KGSzhM2lcCpe6lN9shonOwGY3UgeuhhgHri/qTodrdwMUQQIEwES29MX3+i3UxSE7BfudataCW9SY0qLmIeVq+honk6D78M+X4ZFGiF1hpm9F1/rSWymvFgF0GUGQ/MV+BI0iUndHxCRKyTY+cZb/b7oK/T+/s6yYYg9WXiKCG/KyQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:08 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:08 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
Date: Wed,  4 Oct 2023 07:58:47 +0000
Message-Id: <20231004075851.219173-7-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231004075851.219173-1-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 86153627-5814-4f43-3f3c-08dbc4afc957
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wEWN3kxMtsr/OMJc/xL8Vqb/ZQI8Uvr3cg5FFW5NrFwCBohK3OlOLtAxZcAN584iju+9Sffgl50UAnLigegK3/f68F2RjT+ZiX90C30OuN84wnofvzxdIVReVxA4SGHKvzngCY4kCBPyq7TgWquUcBEP/k/qnVl2Q629WBrwLOK2eBUmAwGDPlQtNHGOQFKqNPtbLzI20ht20BF3R12cDn6G0LM+oWosyHubvIlYBweKAk0W3HkckQpdIisu1UF9lmuYRSSvQtYOVK6jnrOZr4tzdPLeeluplOZgz1DjtbBT9wK/svrt6KRBmlL9Cte5eJGtS3RIo1mPr19GihIABj7Q0b6fqf86xYIgtDRjLxmOcry+JsAewMWWkSiNvuw4CrFB064D5O9bSKcClY0ueloRbYHhZOISceothTwUdV3usUtHHq4w8mKxZX3motlxnS1TP0OGTdMisP8xv7FUicAv2IhA8s44H/6VudxEgFRldr91BVcoFZJyUOG0tuXen3gTijUqIuTmEjbpSjhYge7Tu7gE3HJzeRZ80futWAhEMdhld7WS5ERElVTYZ6Ioctwmq+AhX5wUjmBQINvQHDyjnWvQkpoitF7UQ8DV5QLuLWsdq3Fi2+uPCwcRrIeLDtafeZsMTQk4WVpKqq1IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRJR1o2RUdvOU02R3JGWGlHREsrYllkVGZMcVpQY0doZVhEcUM3MDRLV2lS?=
 =?utf-8?B?S2ZxVTNqZGNPbHh5M2Y0R1NCZkdGeHh4eFAzaWF2QjdEZDFSbUI1dFpkWDdZ?=
 =?utf-8?B?M2xxU1YvT3hWK1h2bEdpVkxWbVdSZ0dGMkNpYlhOOEVBWlRhQlB1WGNNUTdo?=
 =?utf-8?B?QXB2blU2NUZmZGVtaGppN0JWbks3cTJIaXp3YlNZSFRoZDVnY3h0SjJpQWpJ?=
 =?utf-8?B?RldyeEp3MnZ0T0hXQTNYU3VUNUJ2UU1YVk1DVTNyTFQ0UldSUVVOY0RtT2Rh?=
 =?utf-8?B?V3VDNEFQc2VGRU9GUlhISzBuTy9saVpKQUIrNUY5QURnZ0tmMy9qbDlXTVBR?=
 =?utf-8?B?RWR5c3lLVUFsSGZmT3lqeHRtMzNiaDlDVG9xWStyK2VYVDRBQWYrNERRalVO?=
 =?utf-8?B?di9LVWNSemxpSjdGZHRLUUErM3pURFk3MEp1OUVDLzFPR2pMei9UemdranBi?=
 =?utf-8?B?VStyNkdGN2ZVME11TDNDbnNma0VFaHFrS1hMVkFBdTh0R0t5VCt3a3gxNzJJ?=
 =?utf-8?B?a2RINVdJbE5SU0pSb0xKbHRXYUFXWnh4ZjF2RWhMSFlmWHJYVlh2N3g2L0gw?=
 =?utf-8?B?M2JWQVNiY2ZBRkdlN2pOMjBBZWVsa0lqaFNTV0dPck91TUtMRjA4MFd3VHBo?=
 =?utf-8?B?V2xQelNTNUsyMGVOMkFnVXJMMUFBQUpTUlJmRGlJb0tXZmhhVlBtK3ZaKzRC?=
 =?utf-8?B?NGFzajI2d0V5WXFSVjRhSkk5Qk1jQldERWxUTldMNmxCK2cvNXFiOHVQMzVD?=
 =?utf-8?B?MUdWbkg5QlRFYlZGS1M4L3BCeUZPSk5NY05MaXAyQzRGK1lMRE16RkwrSTZh?=
 =?utf-8?B?UU4vK0lEMDlCTHFRNVJqYTIweTZHcXl6UmZCTmlROWMzb3VJajk3eGgrM2N0?=
 =?utf-8?B?ajRkbENJWFRORVc5c3hrTGphczZDRmZKbzJwZnlic1hoa2tVZmFXd1NIUTFI?=
 =?utf-8?B?MVZsdjc5ZHVDOVFZeFhuaVFQODVsV2RBWnRtNzFqNGhrTmdHMHN5Qy9HWWpB?=
 =?utf-8?B?eGs1QlBsVWpCMjF3UjdZZ1NKWHFETi9YZVVRSnkzcytxcXY2TFBiQklMZGdr?=
 =?utf-8?B?TFhXZXRPWWlOazc4bnNDQXVpb2Q1SmpHR3BESC9pVm5vWlV6MS9mMWJpa3Ur?=
 =?utf-8?B?TW1wKzJNRnNSWmNYNm8wNHFhV2YrQjUyVkpUSGFlZkhTUWQ3UEhWNnNwTFFL?=
 =?utf-8?B?YmZob0RKNk5UNm0ySDZhNHZ5Q1JMaVRLbHlGZXZkdExtOStaSFJGWDlNdzNI?=
 =?utf-8?B?UkV5am10RlE3ZDNIaWc2bHhwYkQ2Vi83M09ILy85c3RFN0I1Z3pEemdGQm1M?=
 =?utf-8?B?ZWFXRGdaVnZiL0JieldQbDdia1NkTWxwelZneUU1d1gyQkZwUTNCV2V5S0dX?=
 =?utf-8?B?VldqditPbk1SZTBvTE9qemR4SXNsMUtaaHhzZWJnKzBEQ284SGRpV3RMMm1z?=
 =?utf-8?B?YWorcVVGZGtwRFRtUzFQbmROaU9hcVdJQlE0ck9KaXhGSjRLQ1ZkVjg1YzZk?=
 =?utf-8?B?K3NDWlFlc3QxN09hbGtDVUNYODY2czdYSE0xZWN0TnVRNFBsU1lFTDlmMDFy?=
 =?utf-8?B?dk96QVhnNzdVOXhpNmtFSU5BZXNnVndNZnVtZVVCeWR3Y3Q2amt6MkxVYnZj?=
 =?utf-8?B?anRySnptYkc5SUtiQU5jeGR2a05DbjJTRnRpK0s5Si96WlBlSlRpdVVPWjcr?=
 =?utf-8?B?eGpZMlBNOHUvaWpTNlBaNGJZZW12VW1DdDNSdGtMTFF2a3dWTnI2aWVtREpF?=
 =?utf-8?B?SzRsLzlDdGRidkNKUWdTYTZYVkJZdFBscGRialE4czQxK1hyR0JOREd0a3VD?=
 =?utf-8?B?ZlJhQU8rWUVzU1Fyak5JZ1RpTGlWbFlyMnJWUHZxcVBEQVJYaFZDSWwwa1NG?=
 =?utf-8?B?ZDRMcTdOUHVleDFzTFF5akdnRVhvR3pBbUxNWWMvRkM0UG44TmFmYlFIZEZS?=
 =?utf-8?B?NDhSZ1Bub0RKbnlpRmswd1owTVRjSnpEVTdaNDJ3M2F2aWxVeW5ZdkRsclJh?=
 =?utf-8?B?b1ZaaEZyZXFnNUlTc2x1d2Y3WjloQXBFeHlHMlN0N0ZUOFJhRDRRU3NPUjB6?=
 =?utf-8?B?RnVrVGZuazVCa1BoTE8vcG1ac3dBZHRqd3Ryc2F3MzFuSU1iNjg3Y2ZueGlx?=
 =?utf-8?Q?8GxaVGlI/ljsCnkd2seIx2mxD?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86153627-5814-4f43-3f3c-08dbc4afc957
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:08.0670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqMOYyjMcwaetHIaYK5UC591w5YvJ8+hIqckmipMsfUgDeXyZ1TKrUYUqwrsTKnEcqnP4veTA2yVPeD8H5JHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: Ab4y1qwN3-iqxnxLj3whW50dLqj7HXuF
X-Proofpoint-GUID: Ab4y1qwN3-iqxnxLj3whW50dLqj7HXuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

MigrateChannelList allows to connect accross multiple interfaces.
Add MigrateChannelList struct as argument to migration QAPIs.

We plan to include multiple channels in future, to connnect
multiple interfaces. Hence, we choose 'MigrateChannelList'
as the new argument over 'MigrateChannel' to make migration
QAPIs future proof.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration-hmp-cmds.c |   6 +-
 migration/migration.c          |  56 +++++++++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..a2e6a5c51e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -442,7 +442,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
-    qmp_migrate_incoming(uri, &err);
+    qmp_migrate_incoming(uri, false, NULL, &err);
 
     hmp_handle_error(mon, err);
 }
@@ -731,8 +731,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index ebe14b9c38..825bf70e7a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -472,10 +472,33 @@ static bool migrate_uri_parse(const char *uri,
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
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1530,7 +1553,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1548,7 +1572,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1584,7 +1608,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1715,7 +1739,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1724,6 +1749,27 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 4e4c39a9bd..7b84c04617 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1519,6 +1519,34 @@
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
@@ -1526,6 +1554,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1550,14 +1581,50 @@
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
@@ -1568,6 +1635,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1583,13 +1653,46 @@
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
index 98e071e63b..99ab0d3a51 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2690,7 +2690,7 @@ void qmp_x_exit_preconfig(Error **errp)
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


