Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C4C7B796A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwn2-00056n-AY; Wed, 04 Oct 2023 03:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwn0-00056G-4v
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmr-0006Ms-Lv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393N0W4d007255; Wed, 4 Oct 2023 00:59:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=sdwsvwvq8PgFIGU2TYiznDLqOA5CU0N5jhQBbHIPu
 P8=; b=Vwb4p5HJWnQjl0MqEnDIaEWrOJsSdTMIUnMTgsKZcnEbDNBDZA1M4KBWC
 qrr65otVahmQgXLXIU1pJBUL6+9bRwpb2EMaFRd/cPX73sZ7HnH/x0SM0Q+KvX+E
 PO2bUZ1Nj01EsgxFdTPIoaq6wW49QGzI5sccO29VrF8oeyVaWTwL3lotF8KjpJlY
 DQYi+oyBEDxt5RqIfpaY58aeZwn1a6dGA56jEZWqY2g3kOM9vn0nMilyIRp4zWv6
 F/eHPq2hKHfjiL3vMk3h8GYEUcCLcLVJlTGDMdqt24if40ZCNnhws5sK5wnTKLaF
 9HoXJxIbSjDABYhYx/NfetGimFq5g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tejrdeha2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avZ6L9LgbIRR0FIyfxRpkuUtRT1/GJw791uvNNndxzEJD88qDht6jCS2lyfKbqBTuyTymfZH0E0OnLuomG4JQ3XX5ib4RtvHiyxr8FS61AWDq9k1P2ho8323HOMOmNSeV8xJzq+vcSolmrpRNcj8/TCCbk0d6xflm9VJDDBJd/ED8Y6Rh5N7kYhIUODvem79iZ0/gosUC6MEHjHW0evc6HqqqDmZ8W9p6Uf9//aneFAiXcskuRDi6QjiK+xenJNkjZDHl/Iha5mDC3e1TO4MxG5B3b8mrF6QI8YzLAPuS3sskG3kqZGVhyJT/zFnT+QNgVljM4kv25FE+EWcRs8+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdwsvwvq8PgFIGU2TYiznDLqOA5CU0N5jhQBbHIPuP8=;
 b=P+HOVYNCLMlQYoGQ/GnIgWYEO1UBnGIiyuwCUPyTMReNXRCPC/0+JCpPyzV74CdMIyhUM6FXfRTlBwdq0FSKLsx4EwjK7drfMkJ7bbcnhQG2ok0+hwdWxPVSeNfhVxOG+kcRtAFVjyZ3nbQfEjNBUAUx9GJ89NIJo9j9YqsO30e6dpUKYDjnNoNt3Ubnt57/XRBe8sqp9BJvuyeD5SyZAKvFdBipucUeJ6QuVJTfgD2mPsCcuK9CTT6Svp0qjyefPi6YN5r46OgpQ4mrN7dIryh3chn7Pr2ztkvuHvEbuCkZMnNRvIlaIrqng5vzWpZOM/Gi6FOXgOeHN6ZdW2/jqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdwsvwvq8PgFIGU2TYiznDLqOA5CU0N5jhQBbHIPuP8=;
 b=or5+U+rbxC4cpu/dA3aClOl/PJi9DPIajdEt4vC04eg++cBUimM6O2hhAbeFvTpg0jdYrq+tNexk/v9ztBa1QXRvzUvT7rLFICplWZ0idV+cFQUWCPundjOBvs83lPj8khzBFQQAwGJfVbZHA9KVwU5o3PTaGPxXmU/kuv/rUAdZfixFovT/DIKG8h9zgzYZNK5htPuKtscAlVy1ke8TyCgEqXUYMS3c+Ojpivq6+QiGuJKav0vYtoJ8enxHXgLcs8ZMsQTxue8aMo9SlDp3Z7nv9WRoFwN2QBv/5TaqbQLoLPX3KIUpP9muoS/yayyuxLcC/2nMWjR+HKGzTb/N5Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:14 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:14 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 10/10] migration: modify test_multifd_tcp_none() to use
 new QAPI syntax.
Date: Wed,  4 Oct 2023 07:58:51 +0000
Message-Id: <20231004075851.219173-11-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 402cb357-aa72-4451-ee7f-08dbc4afcd1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW04mcVAkXVE8Tb2dPY/cS8mIi77+bcsGnv/oi+Hmhu8sHhXfP5wOYkLLYPOhpBpgbXG1X+OHNmlylOVYQfHbgjMq1x4BJoq3P+b0V0EKmQWFOk4TPIAD2itEnlpLiUxLmbBQvZ4fZhxiuuzxNmCxlgDa5xc8ARoSPD9h8kTGEkPXBrvUxCG1AW+wWTrGr8reEErJuxQYgmllCFLg36nNQnA0+93x3VNvdUo9pfQl8jBbDWN0rEIbGmnOhnC4WxAGPJSJOfbFFfiRDagSrIAyKHFpAcTgyrO6dUajG+qxjRAHgwW52BHyOXiQ4UMPfrnJID5ZOLNwhOfHYP78MgJW+KWsY1hw84UHdz7o59Qw45Q5u5gPfKRjoHeiiCkvVN3mznPcfVLtPePXSJ/wI+f34fCrG7pSM+OE/utQjGmddkDLjXkZnrfxnSTVFEAv8MQB0YFxOdO8szo3OYTPV/9JBsnwhlpaonRt0uv2YxSYq1kHVTMe+JmROxmOkoNuFBW9Xe5Ke5oqnfddXrWF3FX2vatBvH6jB98xE9/9dgnoc9OIRLnHobok8ft5fc2ffDxvf85n742LtZE789eMSf6gxmIMQVJJkMq8qLUOPdE3LmZpsgC+X21MQzBALWdBOci
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(4744005)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2Z4aWZXTVk4bkZScUhmMWtDaHdMN3NtVnZoVDJBNDBPY0cxS1VZbDNVSndK?=
 =?utf-8?B?ZlR2OTluY2VSbjhJTnphdEtrK2YvVHJaUGlUcGFGZWVubFM3Y1B6OER2Y3dk?=
 =?utf-8?B?KytwUzFTaklZNURVRzc1Wk9ieHB2ZWM0aFdLSlFYNVNOS0NWbjY5QkUySkF5?=
 =?utf-8?B?OUJwaDk4emJvMEwwcTRjdmIrTngxUkRZemU1SXJ0M1lWRUN4NjdqZDFLa2RZ?=
 =?utf-8?B?VGhCY2NlVGd2MXJaNjRscmV2WXNKbWFmVVNveUViUFAvVXpSeVcyeHpRZEJp?=
 =?utf-8?B?K09aUlFSK29vMVVoUVRnWDlWc1hwcmNXdTUxcnFGMEQ3TFdtSUFwOUFVbzlt?=
 =?utf-8?B?TVJkTDNaRDJ1WlRtSkUwQkNrNFYrbWYwTGN2RFBMYnpVTGt2WFVHNmZEOU1a?=
 =?utf-8?B?M2JNSVgraVlTUUl2cFR3T2NYcElWY2dqWGVwZXUyeTErV2MvbUVsYmx5aFRq?=
 =?utf-8?B?WVJ5Y0JQR096OVhWaklFeWFEMXVvckJEeE9oRUF4YnZBRGJ1U0ZVZm40Nm5z?=
 =?utf-8?B?N1hVbTJ5cWFNVFBwNVVZRy9Zem1sVVF0SXFUSmN5NEwzMWhvVGhiUEpzK2Zk?=
 =?utf-8?B?VVd6cTdZOGNjMmIrcmUvY3pZT3NKelhCSlo2c2YwMmhLZ3RzK3BqUWJCNzdn?=
 =?utf-8?B?U3hEOHMxK01qMFVIV3pNQm9ocGRSUy9DakZXdk5rQnk5R0VuWGV1TStqaTd6?=
 =?utf-8?B?aDdsc3hHOUtDM0RFSWFwZ0NBR0RLWHJoRkErakFOWCtIeGJvbEFGdWVOVUZS?=
 =?utf-8?B?VkZtRExjbURGcTBFM2l2RHE2R1BtdGRPT3N4enhpY1lDUDBMOFFqUGxrdUpl?=
 =?utf-8?B?Zmw3cWFScUVGSk1teDdaYmNIQTdJVEJRWnVuNytHd05QNThBM0N6enBHU0ND?=
 =?utf-8?B?OTg1bVZINlI4UVdmUnBCRTROWU5OcFhGbk93YzViL0xqWTBFcktCN0l0djVy?=
 =?utf-8?B?K3RPV2MzdDUzdThNMGxvMFYydDlidU01WUlZREcrV3JlYlRkNXRGdkpMeFI4?=
 =?utf-8?B?c2pxVFFpSm9CeFJCQ1lRKzdrTnppWUhIOGMxakNCb1Fid0V2dFRZMERGeXE3?=
 =?utf-8?B?S3EzNTV1Mmc3YUk1ejBoM3ZFc2xOSmRDSGtkdVZwWU9VY0ZKTHNrUmRic1ZX?=
 =?utf-8?B?a1llZWFacVovbGJzQ1kvUjdVVThHeUJhSkRDT3pGSHZOekQyWTA2bGliQUNo?=
 =?utf-8?B?UWx6Z0l2N0g0cnNaK25ZZ3piRzZraE54QVFYZTBrN2w0QTdZN2FtSzF3azVT?=
 =?utf-8?B?K2c0LzNTTWpRUnJRRUJHMk5JUW56SjA2ZWZUVjZnbmFKN3RnK2FWVGdXRWpo?=
 =?utf-8?B?NUkxdEJQVGMyUzErNDMvYk9PV0Z0eHBuNzNEdXJJZmRoYnQ4b1hleDBrR0hS?=
 =?utf-8?B?U2loSzdiREZScWs5aW91UWJOY1BxWjJNUGJEZlMyK3RrOCs2Q21vTTFuK09k?=
 =?utf-8?B?SzI4QmlXVFJPNHhPa08zRjBsQW5leFJ0cWtsQkVwbWJqT25MVjd1YXRMUmM0?=
 =?utf-8?B?NU5uWk4yNnhvUjN6UUZ6QVdlUDNoZXB3dGpsZ3NRd1dnMVJjWWQ4RHFJVkZk?=
 =?utf-8?B?bXFRUExNVTFMem41dFNTU2JXZEFpdmJRZmJuc0l6K0E4QVR2L3N0WDJjaHpa?=
 =?utf-8?B?V2NRbm9aK29OUVF5MVZzMEI2TUFhMEVHeWFLOEx2SlJvamFKLzhtMDRWMmcx?=
 =?utf-8?B?cjBLRFJaRDdaSnUwdGUxSXBrbVBJWkM0dmhUQ0pBaDkzVE82ZEo1dmxETnMr?=
 =?utf-8?B?aVFRWXhGOU9HNG4rYVloYjZsZE5PY3d2bWNnc2FYN1NxUHFZazBVSlAzekQr?=
 =?utf-8?B?d04vQUlqKzNhNm1jTm9oUkVjWjFvWW0rVUltNy80UDRlZzRyZDNobmpCZ2Yw?=
 =?utf-8?B?RHNsajJDV1luZmNwNjJZblVXRkVMQmt3dFdjaWJiaERyNHAyOHpSbVo5cEpC?=
 =?utf-8?B?VnNEbTJ1Szk3OTFRNkZxcGtnTHJvNUZNaVNRUTlnbTNHdE5hbzBNU3lGUkJR?=
 =?utf-8?B?Q3RkbWtyVGk1b3pvSFB6Ukxab3JyTHh1cnBwUFdaTWdPMjA0TlFyelg1bTc5?=
 =?utf-8?B?Q1VISTZuNWxjK0JYcFJPbUZlUGd4d28va0pUUHBDbm1CaWg3KzBTVmZNZEhx?=
 =?utf-8?B?UzRld0xtQ2xoWDlIRlRhbnZ3ZC9UeHJCZmIrZjNOZGg2c01JSzhmU1hSVUYx?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402cb357-aa72-4451-ee7f-08dbc4afcd1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:14.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqe6BM8EB1DLmoMMa1OOdZtLyIc/NI/qF16nqg/MMBLvVp+FF+afl/NhNsj2SPqUFm+A11QqR0wbifFr45OS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-GUID: 88etrBOE_zbsFe9EeVAH3Gt3N6qQ3NkY
X-Proofpoint-ORIG-GUID: 88etrBOE_zbsFe9EeVAH3Gt3N6qQ3NkY
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

modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 46f1c275a2..246cab6451 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2205,7 +2205,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+                             "  'arguments': { "
+                             "      'channels': [ { 'channeltype': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
 
     return NULL;
 }
-- 
2.22.3


