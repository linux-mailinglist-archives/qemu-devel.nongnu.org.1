Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E837C711D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLm-0006Vy-45; Thu, 12 Oct 2023 11:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLi-0006PH-5M
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLg-0003hM-C1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:41 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39CAbVNZ017937; Thu, 12 Oct 2023 08:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=QoW/P8p35bgYCjUdJZA4EBFFAEkJQRHt7iq1qi2A0
 R8=; b=GcyMj2FwWXjg7iXuNJl40nMkQdreGtrjeoxGZae0pFKv14OdBj2oBQfFM
 fis/LukT/SGu7p05GQNHeFD4VlOdSEEYC9iMhd0qYgHZccAjHJT/6NE4lMbwXjvW
 TRnAoCwRVD3zyy281R+Pc5ipBxHcjeMcx0+a52xATfntWrIYx3LzNRwD2XBeTS2X
 d62AKsRTqbhFmvwIsYnleZ4L+wIklvwzyW3FfpX1Ql7mdb176QEqzZiQOAS/2pAR
 /G9anFQFuODud7Dpiu2LbkUnaGkIiFdpSYKymCXWtF6K0JCu6Wy4DTwNx2VVLBNs
 v4r8cyMhZlBnlAyH9NrLbb/Mhmztg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv0bhs2-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzxUnTdjSjRk1d2Vl3SBBEic2I+FA6qoD48eqsP+yHOwOB089kIVweUXq44LKgkSwS0rro0wSf2dpGXBIYl8PuoFGmTGDgKFPDerKYzb1I0iFGZIrbryEX3Yr2+LgyGnaZ7M/ZL0X3cU6eN1+iZFYA/CpfhcK4URnQHORJlQy1WHi1h8TPGFUQ8mM4wcLJNfZojyHf+LxIyaMrkbow17YCtuDimGh5PSwyW5l5U63ZnywZ6VbUoZlS0Y0RH+3q5rdB6gIMV43WxArgHidbYpsWKAEKuX57ZNj4nWY6/GxyJ8omh28G19EVmmfNiiPSCLJTljIVBZJIDi/+3t87yKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoW/P8p35bgYCjUdJZA4EBFFAEkJQRHt7iq1qi2A0R8=;
 b=lIPn1eNYxOL89KAO8On7Btw2f2G1aN90qwx+6eNfKS5F92v4nSCBI8OU6kx8UnVKMcuNM/BibFu6StBNFdt2gYSq8Xs8OO8Pr7BsJ7XraFPYdRGmmxv4npm8ch3K3QMV+QHs7iNIITplhGwZq3P0U1jOjTyCj3ivE2/lYQtkRgO4GXEt1SUy0EIJTFhI1qbeBnFqcG7viEfBkv3KG27pl/ak6eEumKfYfY/pq4tz5+MyJ/1uec6B1xZqKUGGwCGTn81untHNpLqqS/oHF7gabyRV6JSNU26PtOUkkZ9gm65loe75KiaISc0zA+coQlQ6RqaVcQE6r8/9NzlpGdkieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoW/P8p35bgYCjUdJZA4EBFFAEkJQRHt7iq1qi2A0R8=;
 b=QP8aJiSzw673QFEmjjMdESxQTukWPAxtiobXIhuxTeiYR0SnEjjhvSqKnxPV+gxmt8U0e/inz3IWiHWp3pgsL4zBpsFnEVZBzjvwKzpblNRGc1yMcZ2Hl9rXVsRdiZOxSr8L/n13a7raeq9hrWMkbI545QHO8HZ5rRgOGngr3OxLytgb0MO1d4yl57LJCwCw0rgWxhaIlvPXtD+DPps3f70XB3ONf0yybm2fdueD9bpceLpE6qE/ug+dUdELugLIEQJjlfsp6utn+1Pi7eyLMf/kGpAObMWXLa+gGVDrBCEPbw5OWHsXKu2sYFG8fpLXP9iPn6bLKMEmm8jIFPq2YA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:33 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:33 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 10/10] migration: modify test_multifd_tcp_none() to use
 new QAPI syntax.
Date: Thu, 12 Oct 2023 15:10:52 +0000
Message-Id: <20231012151052.154106-11-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc50b6c-7c20-4a52-1f68-08dbcb358520
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmMtsJwIGUc6fpYy15mOlsIwrnBFmtQgzJRUZ3YlDh/lMyWm30qEaFoh2VCBMU+yiPZYc18XqptZ11nsVUaZPIBe2RszdzREafEphMOE/NT9EG/53xcGg7dH8Ak1RvmuGS8A/7Ad1/FyN4lYiBW95QHAQQfNh7Syzpi+qtT0yHJsqDgcA3PCY8WKeg6AeCH/DZVOhPXaZ8Q7TBlnCOS3KuyDVXLboQz60wVPbKeNg7gZz6ziBJxtBXMFQe6u1fQasAspjM7C6wo0pGWJqkdUl+9y0DXfg/OxHw0vsX/vPhN3kGK/QGaGL5wPgGuupb9F8UTtvB1+DfnsMH6b6bSkYvpVpiPENyjka2wxrdMSNesHmwMbPd4C0BOYb/B7kHXynwrfan66KCqxRFcn37yqRgSqfNXqKzLr9e9IIwSUJOqz6GlOElN01jVlj1WOGgB3uS4/0KB1IEHEE42PWhURslN9WmmfJ8o5bwtS5Nfvxl/TkErKBXJ4nMYLybJoWK3cfrlsYWckqQLFRLua/VSr1L0pYobGWs9mHg4EbllbKxVEum+aQmSMxLX6lYaQ3O00dW3MGvM2WvvD/KufVl06IqwGbi/254aUqagUHFFaWPyZfMyWe1hyC9VjWIdBOUfc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(4744005)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pFFRCuLQ8tZT5eEcOYWxGX9rwIbxIBjKSIGrflOmznRMNBqXnK4SrfIOVAtL?=
 =?us-ascii?Q?cnycIlsDLDcxijGtOOb8gNbwpUT8J3BR9F3PXdxhZ6iNH6B0MZ+TS++XxAzk?=
 =?us-ascii?Q?+ctay14ycXDDCrHwsHT9fWucg/h/p3gNPES76ybQ3xZSiHeTCbR+A1fw9rkX?=
 =?us-ascii?Q?v6JCVD2HBagHJYkKK146qU0o+O/mcg0/50VAWdfQeT3Qn+wvgQIPgBYqvTzA?=
 =?us-ascii?Q?RlRGgFuUX7CoiydKaAWCRA87N02nU4Pb96DlqU0+/QqmJDRMpKznGKzoehwL?=
 =?us-ascii?Q?Y5SAL8b/8cIGCpHFwd92ompmji4Jj4dP+JVrCQyH0Ewg0h/JocR0SFsNSwUe?=
 =?us-ascii?Q?ZfW5o9o2omJDh/scZfQhiT5Dp2Lbwl7Uib42bQw1WGPsjBnet47jMx63SCnl?=
 =?us-ascii?Q?YPotuJ/rWoiR2nXkwShGzpxfrHmm5cjYWLMFePI3GDLKE0xmSMRKMqVi/0OU?=
 =?us-ascii?Q?4hH7XK9TQSUzELlJH3FJ8t7CvC/m7Zq+irFB20CTFdAeXjpTGubw/FJP794o?=
 =?us-ascii?Q?mby169fYAvF8/l9IEGxUqqO24WkdTpdRuEpQ1pgALl0Ao39uA+6Ob393S9N+?=
 =?us-ascii?Q?3qqyHN30iznEwPBfw9v4oBJiR2L+4RqoSOWIFE4o2DpmRQ5q3IZNWpGJu/RS?=
 =?us-ascii?Q?1DPFRXiTjxtB3Skg4xQczYZQDVi3hjPeDGLA16vyJ2NT1/Z08AcG6RMoZ+Sh?=
 =?us-ascii?Q?hhZmQyCJhTzJfi79S21e+nSJk94eyakBg6/cqxUidymBZEO5AlIw0wtuWgXF?=
 =?us-ascii?Q?D6ce4hHwwgShTraxdkcNbEfTzFD19CRBM2kANGWmuurTKaSO43HOJIyPyKMR?=
 =?us-ascii?Q?XCgzNuR37lrHqMYWIXZq8JOtGnXhVfnZufWXZNdrp6Htkfw9IzvqRuN1qz0c?=
 =?us-ascii?Q?uYElxzpVDbQg8TKQovTi41AJQaWL4mwWzjh4EG0/uRrN42ouzKNce5u+hgRq?=
 =?us-ascii?Q?TlKXznLpzNAYC+h22IUkG0vYF887uinomyAaAm751vncfqfdiIgSDPivEIs6?=
 =?us-ascii?Q?Wk/AV2lTCCVyaNNetcqkJ718ObZPMDAdhqpdbER6Pr5Xw0cvpdYS3yisbUV+?=
 =?us-ascii?Q?ymAgrxADxlWNJ4IJ3wDBE5S84L9CmuY+B50eWUorKe5qmWtfAXQ4owjPq7Y6?=
 =?us-ascii?Q?z9lkAhJu2/vB5aZC0okUOyytjebLeCNctzCCjvSBW1i2eYtrFNbi4izrzuBr?=
 =?us-ascii?Q?jJ+xNfX950X4NMbxrqPn3Zdo7CWh79icrreXZJRG1OHHS3Lzj3d7I6cFgpzd?=
 =?us-ascii?Q?3ukgQm85/HYAKSAlqFnMB6Rbjjq6rXKTjWYgeUBOQMDrsUVdX+6ROf05q3Zs?=
 =?us-ascii?Q?Am07AFvNGxh4xsaYUpUVK3Ji1oWkb0BOis7yhtGGmsUqSTPhqidxjlHhVZNb?=
 =?us-ascii?Q?Uq4KkX2ZzLEWC6Gat8LgRMng/At8tYc/Oa/b0pmnJWd6tn1B/fayU45qCW7s?=
 =?us-ascii?Q?FG5rMCVOhMor09AYkcGMaZAyk80JY5qUs1gMGnWABk2YcNjU4Ga8zVACniIM?=
 =?us-ascii?Q?0Se7BZi9aKKfURRSpnWoKKh4aN/NILYEi7ziHja0ZcaVURZOOyj66jIqVujX?=
 =?us-ascii?Q?FOnlOlz/wuTFjFNoGk+xp7MAGKnQah2lEISqPVCpFM0mSgWUSpzRJrc+Y9PP?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc50b6c-7c20-4a52-1f68-08dbcb358520
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:33.2797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJxpkV8QtPgd0f5kiOJ6oesn+X4HlzTUTybxKml8nuJySLSUAoJKICCTYwyXtbn712lsZK1IBhumxzdjn//Nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: S4n_nS9cnA_wlfYdqkyjPoDgDrPzyUb2
X-Proofpoint-GUID: S4n_nS9cnA_wlfYdqkyjPoDgDrPzyUb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
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

modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8eb2053dbb..274e03db43 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1277,7 +1277,12 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.22.3


