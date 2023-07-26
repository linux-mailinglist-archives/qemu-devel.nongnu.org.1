Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4629763B26
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMl-0003v4-HZ; Wed, 26 Jul 2023 10:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM8-0003Vj-8x
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfM2-0001Dm-GL
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:19:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36QBXhfP001667; Wed, 26 Jul 2023 07:19:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=RdgxwxeGbHHnnEjYoUYHgW6WKRbn9x9SsTaVbo11m
 YE=; b=eO20EN1DdH3hZdKC5qGtyRjwTYevN1ovAHbmqUMWWTeNyAy5gzlcyMVsh
 BzhMohGGZFcHfji8dSdtJu7nCecLobqmNb8AJbKenR2Gjj76H1ZN+Na0YHRCvTop
 0YZ6xDmgRD2vvctlUsUKjXgClORxUgAh9GTxyz8SnXxkaDTVDks0F7Aj3NJkvBbD
 T5akomD1DBYhs54reOH9u/oEnNXFWNcii3ZzBtlWAByznM4VmOJPwvjOnsmUt+Jk
 FoFUO7Z9moNF45Jy/NTgohoSfwIYbRbm78kvz8z62PjHa5Z6b7AK/e4wbK8pslKo
 R2wuGq4v9Wj2kZIYYc97ahMmEDIXQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0envfyep-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvuUZ9ROCT+mpieQG+4T/1CNuLcKP1X0lIL/oJoUY6D8V/fJ8iwGM79tp+xpDjpzme7CE3fhe0ATIf/K2OXFh+jBWpB8eUCCXVjNp386aYoXsBOyA4Lh7CjoM/xF2TmQ0lRAFhDUOH9I52ursSaoBD6z1AZOZh95rOs+uBsK9AD291PFv5W5YQA5U+aCgUzlhSaBmbc7AHAy2wo+3YJJjoMdZcQS55AaGX4/dMYxYmLlwi40W7xTqQdBdWXI4sUr1dEoZGV4edaLJbL1q+dnbCUg72fgnBw0nT+B3I5MnpmADeH6nqOxDXRWj9FlTO6Zn3JOfyEfazD6y9AjWSwS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdgxwxeGbHHnnEjYoUYHgW6WKRbn9x9SsTaVbo11mYE=;
 b=ZcyDsEsqsIbfH9Te584VyQ1nFSNgPqac6+HseNQXO4PZBwGBkr93CimJz6yzWmjbm91/FLDHLX3iHKnwFznRBg1af3R3cGSRsb42Ox2d4thCWkT0fYqZxiTP5YnXcGnTAil4V02+ox5fAcaKhpAFahCVL+O12VdWH+Rxttzh11rbmpBSa7atxnevmUWFBjStUdloznO1ZTohCrcietD4b3YvDPiRBxXJxZCeyy26qSQ2FgFy3VDrE1T/1wUlQlx0SFBab0KuGxFxB+OYZ+8s4goDUROctrTTRl8n8HTU9Emk+Izms+rOXjZk8XSniLzjtqCnuL4Docsrl/asYa/huQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdgxwxeGbHHnnEjYoUYHgW6WKRbn9x9SsTaVbo11mYE=;
 b=dWhRbLjzAzzCO0TO7CAZY9b6UrwfcPV9eEWF/dE1vP9+UqnHqI8VdM4WP96x56ocwp3D5zWfM/ibgJ91sEACypTc5ealVsb/5QG1Vu+9TejzdnLoIy3UDfOdvcev39/RoF/ArdSIMen00XClqLvg5sgLWZM/68CVx+aAHcgg3/Mqz5m3F6h63E8PfDcqG1QckLcQMytzRJsj+Ijv6DFfebySMgfeioJKxG1aN+VgEY3ScSyE6nDUQtLRc2Tlhi2fpStdvFTl24V6X9o95voVCl02RZP4g09RXXiumsNbnTlKAbcT56lMJVg3uBKiTlrZCfPWzB5Ba5PBceWkJeh4rw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:57 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:57 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 10/10] migration: modify test_multifd_tcp_none() to use
 new QAPI syntax.
Date: Wed, 26 Jul 2023 14:18:33 +0000
Message-Id: <20230726141833.50252-11-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74920a2e-4258-41a6-7b71-08db8de33fec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMSRqPJIh3tqzTsXxZquwuVqa/NbswpY4k/MApmXSDgE0Ru0i0vf3FSWTVFDweXIHf1ZdCcfr/QsUirv2m8RJCXyys2wWDzzvDQwcD27b5cNCbG2Kz8p1xvt3CNRppOgC6bh+w+rQ9WitE9Mjp/hM9jt2tr8uXHJq329egWGjYGuuIikDSGETr1bCxAdkwzsEzqmjptxJgQxNzra0RjZ3NPA3FWPlifoZsAb/G0NdNHFbnKNhKl7xFSfbbEk27MhfxzPJXuruv/uHkcfhVZjd4aBH7jrv5K3IQ5pB5RTfHtygLJPW39KgRvOdUDZlsTbUO0SFopD37qw3c+bBbOX4F329jPqU4u+qoCdsLSWafZ8dHwUQZeRlUp2JTUG4/ZJmM+FOc3wWNKgyJrb58JLKI84dRSvXqBlV0urk1giyltAHV8bCDJc46BqNI5cxlaT0xljqiXtDjGz74oEzCWUGpHqn+N5pYggCWC+lf9BJR5gC158Uf3vNkbOOjhvgr9Nk6f27EtGq8zGCEtUVSZjNkKaE/BsuEa1PPdmwJrhmS2CabTALZmm2bGloRxbyq2/g8EJDmqQfD2YP1zrv16NWchd4UqO8EqpvCbaqmi4NaJPZgOKTRzYUw8S5FunH/BK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(4744005)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdIelBaMkw4V2dubURHMnhFbW1UdFFibXFXNkVzVHVLVHNLcEF2S0JQY2w4?=
 =?utf-8?B?TUhyMW83V0ZxWmRIOThRT2dLMDJSKyt5RjZBMXlXODBJeFdSS0VNU1E3THEw?=
 =?utf-8?B?TUt2eFJsWEIrdk51d0FSemxDZnQ3YlcyUW9zVEtXZ1lZcXNuZUpjNTdvMmtP?=
 =?utf-8?B?RE0yRHcyb1NoMU9TSFI3R3Jpd0ZDczh2QldXcnUyZmE2UVVGTDUrWmRKdWpy?=
 =?utf-8?B?SWcxV3ZwYWdYY3hQS1lIRGZTbHJpZ2NGWTFqbklzUnNpQVRPMFJ0K0hRRzVV?=
 =?utf-8?B?UnNXRlhPSXZvRytxTDVZemJsaFpPTHE5RkFEdmV2OW9wZXZXaDBvR0NsMDk4?=
 =?utf-8?B?c09nMXNWOFpJcHVuZVp6ZlgzVzNldWdDTU1oWVN1OWRBQVkvcityMVdvU1Jp?=
 =?utf-8?B?UHpIcHVqaVhuSm1MNHYzenk2SWZPckdWQmxubUFxZ1I2ZDJNdkFhRkFONCtN?=
 =?utf-8?B?aitQNmNINUpIdmk2MElzbTY2OFZHaXRPc3lXc1hBYjVncUhyMGtOQkplK3BO?=
 =?utf-8?B?VGVwQmJhcWp4Y0pEUDZWYjN4UEtoMWM2ZVBEZFUrekdxVXlncFZXMFlmNkZz?=
 =?utf-8?B?ZTV1YlpPUmVXOHZ4V1JZak1Pd3ZxWmVraUlyV3daZnRhdmF3NXZxYWd2OVhu?=
 =?utf-8?B?R25zeWk4Qm5uNkhwM3Y0bWhLV1RMV2F0QWtaeUNJYmF6eHBMRFBvNUpRM3VI?=
 =?utf-8?B?bW1iNVg5bEFXdnFOcHZqd3lDdFMwNHFRZnFoZElNdDVZUHhNM3VXS1hDeklm?=
 =?utf-8?B?TS9WNW8vNXJPQk4xMkJiSzFJdjZqWHNCWHQzMUQySG1jeGVoTmlBNW5UZHRG?=
 =?utf-8?B?Tk9FOGt6YmNPR0xteVNibUdnYnRndTFzYjZqM0tLdk5wblRRRTFyUTNqS3lU?=
 =?utf-8?B?c3hzWng4ZUFrSWVZbml4VWZpM3l3MmlRMk5tZHpNNXQvOFNGT2pQcXIrdDZV?=
 =?utf-8?B?WkNoTWlySENDZ0JSVVpLWlcvSnZTZTNsWmQ1bkZESzgvaVZVc2Nwcno1YS93?=
 =?utf-8?B?bjRvZmNvK0tWTi9PalBBM3ZoWDFxTnkxSXAxMmd5Z1BvLytGNTIrWW1Td0k4?=
 =?utf-8?B?RGtaRUFEcnBRYStGMFgxUUhDeEpOTmE4Vk5BNmZmYTlNYm1ZSUx4L29CZEhy?=
 =?utf-8?B?NHNreDJmTjQ2STRsNW5TOUZwWGZaNU5LcDhIWEQ5YXJFQThnSEFXVDZIeW96?=
 =?utf-8?B?R2ZIMVMzaVYzUzIvWUlTWVo5OG8vbng1NURQaEs5Z2lFNFMxbC84aVBXaElS?=
 =?utf-8?B?ODUrSCtpcGhRK2JRR1Q0RXdvYVBTalc2RFR6ODQ3alU5NlNtdUlIVWlKc3g3?=
 =?utf-8?B?Z0kvU1R6NDBNQmpyWURDUUhaWmkrc1B5RkxMVy9XZ2tQOUpFa3U0R0lKSUdN?=
 =?utf-8?B?eDdJU1Bid2dMc1U1bjUyT0l5dUR5endqdTJKRTNsZGFUd0ROSmFjMFdUcG81?=
 =?utf-8?B?TEZBbEw3cXluYWRPakJRSmNlWGljclNOU21ONjVmY1FJbjZyd1BqdWZMMHVH?=
 =?utf-8?B?MURSY0Q5dzU5aEIxb0ZaTHBmQmpLdnBnVVVETTFTU2tvV0I5N2ZkL1p1aWRN?=
 =?utf-8?B?ZUVTcjVHN0ZqM0pSMnVFT3Z0RUZ6ZFR2M3AyYWhidGw4UWFrOGVGM1BDWWxS?=
 =?utf-8?B?d3RBNmtJcGduWnZQRDZhYnVmSmlzM29MQ2pRMStMTU1SVjVSaFNJTHB1eFFt?=
 =?utf-8?B?bzJLTE5rZFo3SmJpLzB1cEhVbmlwSjcycERYdFhNYTJ0Z1VZN0pOMk1uTXB2?=
 =?utf-8?B?K3RjTms1T1l1SG9waFFNank1VlF1UGp4YUhTeTd3b2dVQk9YV3JURTNKTHJ3?=
 =?utf-8?B?a2NCbEVaK2VIeFMxYTRZeVlIV3ljRGdhdnkxUmM1WCtxU05FR3dpcVZpWXJs?=
 =?utf-8?B?RTNTV1N3b29iT25TMGt0M3FaTnNvaFlVQTRXQkU5cm81SFZrL2V4ZEJBRkxB?=
 =?utf-8?B?dWlodDlHODhBVlRpWkpRSW91bStpODRkSURWL1N6VE1YOGZkTXU3cjVwTE5z?=
 =?utf-8?B?K01zKzRpVjIxaXVmdUtwcEVDQUMySXRCZDFrNDBwQ1E0aG5tV0puZjdiRHgv?=
 =?utf-8?B?dUkrbG9NWUJvczV6dFE0eVRQNmJEeFFlajQ4ZXpOamRBUUNDYWFYemJ3S09a?=
 =?utf-8?B?enZsMjhRcDVlT3lRdkl4VUN5WUcycVYwd0pHSlA2aEhrMVBKR3Y3MXFVeTM2?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74920a2e-4258-41a6-7b71-08db8de33fec
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:57.4513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMOzxEzHr0YKhSSq5xONh6SPZYSyyS5qmIWHGP+tH/j0o+skMawiPzyOGsEse2mIzprK4sJm2Px2YKm/bU3Pbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: kiTKG2aC5K7ooBym4mnJmNuEkXgRTVkB
X-Proofpoint-ORIG-GUID: kiTKG2aC5K7ooBym4mnJmNuEkXgRTVkB
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

modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e256da1216..376fad8311 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2185,7 +2185,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 
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


