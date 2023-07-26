Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BF763953
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMN-0003bP-5M; Wed, 26 Jul 2023 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLp-0003Mc-R8
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLn-00019e-7z
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32O032511; Wed, 26 Jul 2023 07:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=NpW105tcAsd10rmuvnzjL2udmj40wK6pUp3VdTIXN
 X0=; b=MWmYBExKM6pnJTuBZ6iBCyrBE6IItVT6ijzVg0hxfH4F7uTEW5dtFYDEk
 5vsw75AmqlZ5DGDPdZ53od9NdBJ2yuNf8ZwdsoV87rOmSl2ZZU763wvQe7fTR6Tl
 xY/rUVR94csSIAnwA+DOSV2XO2yvmHq2YUfpGaf5tiTyW0+HgtlhzqzRuRKTpuLV
 f11pxJntOv54ZQ802jwsWooqNrEP21vnfT7L/kGg3J0OhUdXoI1yTBDTASE4oVCj
 Q1fsAt1AyxQEGMisa/VbZmMxURSV/yjiZeThV5n7vY1Y7p5z86Y8GHlDZZidc/Xd
 Q+TyzHhVkrBmibxwn0XSHDlLj8jLA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNUCqweAEaavqV06GQV18cN/1kfNjHG3zOoF/KoijxRbZm3o9A0pvpMSCfrefab4+BVx3AL5QQIhi1wl4/8mmh4mB6u0d9492wA69OCrVVtLDxQYhkrT3c88xv1fEIFp1ITicdjpH1mrP0x+xnn+G2gdXnS4dZuafBFynZHuewzCr9Trl1f17mK/G/Ff7xabl6YQtNs0wVTYWaqY3LaOI8E4f9RThwGPgDUP7qNOhnYBeinen0lpoHRIA0suBfMu9x19F3WFoR4lVm9sCF/LnjKFAuv4OBJU0ljLHzLpEWFD0LDRSV/1MyBmZhVZOOpyFyl8xaC6GyiM5lZk2XQ36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpW105tcAsd10rmuvnzjL2udmj40wK6pUp3VdTIXNX0=;
 b=SE7WW5zkuewAhI2EeMyvJr+SlSxl5IjREloBrrd18SHJmLt2stS4ZiiZn6ulQ1i3Pf5RjFpbrJVQio6DeTLgzR16WSxCjmXsJNvh9jVb7kN3YwN6pXms8kU4075caJlOi7//tx+/pE78cpFxP2tLGulyVNnpo95ICvSKpqKCbJZ+RYYrhw6k57tdC+PEcj/7Po1bSDAbX8uV7C8aYNXNIiDQxOnmwvUaHPTQrE3YX0z3aDdG47Uf9JRkgJjeaFL5N6whzAkGwYKj96JqEEZfzVqsLS7mN7yc5vZZv9AUBPgiuDS2vmKDNIfOH8wN4NH17oDDJoqt7vqb5qQXT8RBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpW105tcAsd10rmuvnzjL2udmj40wK6pUp3VdTIXNX0=;
 b=cXIxUC9uBozaNXHd6PK0cPapnMCqxHJUcMF/DJ6EOWWIVoo/hlY89LaCqYeWl0IMGHIlIaYgEXqncckEnBs1ySAOFVZn47X5RlNb8CSX4978uPnT8kG7hPE9/MaXVP+AaOzy9NynfSCMBVgYHViwiZxpJATnhpKdLY9hJuqkdjVB2Dmvxrtbwurq+R6RP/DUZVJC0quYE2LMuu7di8Oy6JHwi4efeQThVuKmeS4f0zfl2P9vQGSUJpQskrdtphYWXY21mJuT6FxRaAF+x920wCyakWsDJCPhH2HkDQ6yM18fIpJNXVnFdcwODv7zFiVvSS0BiUIgUpwxLD7tfGbJdQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:46 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:46 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 04/10] migration: convert rdma backend to accept
 MigrateAddress
Date: Wed, 26 Jul 2023 14:18:27 +0000
Message-Id: <20230726141833.50252-5-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: f14cc720-492f-4946-8560-08db8de3397f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns1gewV9ZOPkKFyzMzqaf1QbX+engaqRZqpSjZYbXlqgVk0VjghRHAqI6y77rBbAuKWLT1RA25KEezM1Cq4tLElX0sKegFAW1tdRzdksr389CJ+uPrFary7OFQkSshPXgSRqhQBstIBpmnG4GzB6ltIuE9qOhG3Tdk+t9A84LhtpnkEhK1kzX1Tx+EmRKlwzZ62DSvUb6O5eh5yU/D/HKlTQFuZyIBeZDAaY+qVBJne91PTbSnSFgZxXtWQvEcL93Tyh8DGh2pN2B7U8XaLUxYTQOdJsRiT1kx17r/0dVK1x4jbGdxGmbOoWf49yfovMjujGoUgPMTIHu4TSwqLQ5gETF3f+NZSj9mbAD3S6XPZ6HerALa4FCSmM8WA+uqp2ZI3mw163ntZh4sGEDKFL545pfHcLyJnIrFGd6qba5NR4lpADNyjg7VTlvfXepP4QVnhNFimIapRcghZQygZoU+NndHCfCjZLizI68Dm3dtffEfYh0jIVVEEZpy0vEr6MryEHfX3xVk4CyH5B4cVYrCjdqgF/5SIUQq9178XwhzPlqR2GCVF50B+opBvL27os4q3eNiB+PCH57OTJiLIgFORWPs4c0vQNxhr5BYiXVAlGPWxvQO502kjEf2cDEMy/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVRc1ZDNDl2RzlxclIwVHZqZEtiRm8vRGhpZy83N3JlYndteDFtWUp5Q29a?=
 =?utf-8?B?aEtjMW0wTy9neHEvOUJxY2gzOGVuUGhzVERET1Q1azcxY1lHbjMrRk5MN28w?=
 =?utf-8?B?SmVKSWppbTBxVVBRTUY4cGtPYjVuOEh1OWp6NHpoOXVwdms0SlRKSXlMeE1N?=
 =?utf-8?B?d0xJVnNQNWNuU3NNWDZld285MVVZMXdyNG9vVmI5OFhqN2tKYTk0V29haDBq?=
 =?utf-8?B?UEUySDg5Q0dzc1RyZ29mQnIvY3ZtZHNxQ1oySXJ6Y09EL0tLcC93TXY3bzY1?=
 =?utf-8?B?dGVzOGhRMStIaGJkb0puVUxOSUo0dnlCbVVNQitMVko1TC8zRnY4ZDFwejZD?=
 =?utf-8?B?M3NROU1PL2xFblMzUmVaS1Jxd21vcWZ6dnJpbVBOYng2dUtnZGFXNWxYUkhG?=
 =?utf-8?B?Ym1qUUF2aTYycU1mT0xGZ3UvZXIwa09Ma2FzWVl5QThaQUdUZkRDUDRHMTVE?=
 =?utf-8?B?Q0F6MllkZ1d6TmQzUzRaSk5MQ01vSUdPV1pXMjRDRXJUOGFXbVMydzk2b2dV?=
 =?utf-8?B?eFpLSHIwK3kwSW0wbml4dENaNUJvazhoV09QY1p1ckZTSjZTTEgvNmM5NTdz?=
 =?utf-8?B?d2oyRnNvMGlwL0dXYjFoRUpld0crandMc2lnaVlvRzcvN2hCMDRqc1RLdmZN?=
 =?utf-8?B?YjFsei9BNmljMlJHQVJUM1ZERStuY3B4RENNcjcvVWtBNDB1TGNLOFp6ZzlJ?=
 =?utf-8?B?cFBPSkZOZGtlYWlOY3ZiTzRlZ3AzN1BCK0YzM3pYc1NCMG9sVGp0eHdkQ3hH?=
 =?utf-8?B?T09nZ0lNZjBzek1yQ0Z0VFFVUlRkTFcrTldjcmxyNlJNaDg3UHNEa01lK21B?=
 =?utf-8?B?UkRMeERTMUZwbWZzbFloVkl1Yzh0cFoySTI5Y1FvTlIrSVJ2TzRVendubWNY?=
 =?utf-8?B?Zm1rdVNVWnJVNHlDUmpsNm1FZHU3OE5zK0JqbzZtVlh0bGd1NlBpUWV6cVlB?=
 =?utf-8?B?TUtwclF0UTE4cVFGc2JWR3dDYW1tWTZQRFZ5MFJSQVhhanVzSExOMks1SDB4?=
 =?utf-8?B?R3YvV0gzbG1od2RKZGZNT0MrdjdVUkNndy9KRmxSalBIbit2Y0FvZm5TNDBO?=
 =?utf-8?B?WGJOdldlRFBWRlFuSGlHNG1BZFcxT0p0Z3B0RFlrZUpTQkdoSUZidWJqTnpl?=
 =?utf-8?B?Y3lENXg3Rmo5c3NJSGRrVXJlcExCekd1UThVMGFBNThUdENaUkhURllkY2Vs?=
 =?utf-8?B?a0VUbmo4ME8yeHBNd1YybjZSOXNlVkJBeHRGNFJqZjRUeUxLS0xEUDljMFNy?=
 =?utf-8?B?ZS9iZ3NCckExUHNINCt0dVB4SmlVbXQwVGJDQnJPUjZzTXRhaUJRUmNNenlK?=
 =?utf-8?B?dG9HUVVwME9oRmtsajVlcWs4eWVBNDYxaFZ4ZFBDQm1QSTRKR1FRcjE5TWFk?=
 =?utf-8?B?Y1NqVjc3OXNzOTB1dy9JZm9hWmN6NGpnMWNYZ3l6TGhreE13dkpmM0FEWVNs?=
 =?utf-8?B?cENLdUxwZjBwUHpjQ0RQK09YQ2wzZ3B2R05XcVl1Z2dIVEJYZ3hFLzN2cDM2?=
 =?utf-8?B?OVdxd3RuWGI3aUVNZGNBbzE4UytYQ2hjL2d3Y3dBMVNnTlV6TVBzYy9KZjAz?=
 =?utf-8?B?N1pNakIya013VHc2bDFHVHdJZllXTytRVzkzYjRwc2lqNWhNWGVqd3AwSGJN?=
 =?utf-8?B?WkVLeVY4bnAyeWc2c2NEY3gvQWRNNjJ1U0Z0VEpNcm1FL2JJeklzSjRCNkZ3?=
 =?utf-8?B?bEFib21mT1d5R1RQTFVsWkt0bCtCd1dJMHBja1VoeHhqREdtYjRCWmhtMG9D?=
 =?utf-8?B?dWtocExZT2tQTGdDazhCUW16a1RLOHZCdm9HWGJmcE5qU1ZMK0RwYW9ZV2lp?=
 =?utf-8?B?Ky9PV1dlVzEyQVRzNGVNRFhKTkxsRTNZSHBnSjZiVXZwZVcxMUsxVGowRXBR?=
 =?utf-8?B?NlNvcHA1bGIzTWN2bGF3b2VSL3ExcHBEUVdMd2x6bVoxR2RsdW8ralVpczRN?=
 =?utf-8?B?YkE1dUlMVERUdnZtZGxOUCtSaTJjZlpQZWRHcTQ1YXY0bGFUNlhPRXZ0Rm8v?=
 =?utf-8?B?VjRGaThhWjVGdi9BUVZQZ3NiaDZvU2x5SE1TWFlWR1h1eWlLOEZRdnBFOUln?=
 =?utf-8?B?TFlwOThlZlNrUHZ3bzdpSG9zK3pUMERKQXhRL0lObVB6aEhNRHp4aWJSd0JY?=
 =?utf-8?B?RUUxZjhzMFhFUFpFNTNBZ1A1cjhLL2E4VURYcXVZajRsUEZxWDczdG9tRHBi?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14cc720-492f-4946-8560-08db8de3397f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:46.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KArcYKuv7xFIitI/oAzXpfhklwCYQGi9lwqWXc8v9hULWuMzyPw/NJLHXtMFwKcCIa/FnxuhdEK8ZtTMsOMULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: ihUzrhOq0rKOIJ-a0ljT1eHlmAfVunyH
X-Proofpoint-ORIG-GUID: ihUzrhOq0rKOIJ-a0ljT1eHlmAfVunyH
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

RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
accept new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for RDMA connection into well defined InetSocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c |  8 ++++----
 migration/rdma.c      | 34 ++++++++++++----------------------
 migration/rdma.h      |  6 ++++--
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c4bcf8bbd7..8012f93f1b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -491,8 +491,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
@@ -1728,8 +1728,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (strstart(uri, "rdma:", &p)) {
-        rdma_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
diff --git a/migration/rdma.c b/migration/rdma.c
index dd1c039e6c..4d64fae492 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -319,7 +319,6 @@ typedef struct RDMALocalBlocks {
 typedef struct RDMAContext {
     char *host;
     int port;
-    char *host_port;
 
     RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
 
@@ -2455,9 +2454,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->channel = NULL;
     }
     g_free(rdma->host);
-    g_free(rdma->host_port);
     rdma->host = NULL;
-    rdma->host_port = NULL;
 }
 
 
@@ -2739,28 +2736,17 @@ static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
     rdma_return_path->is_return_path = true;
 }
 
-static void *qemu_rdma_data_init(const char *host_port, Error **errp)
+static void *qemu_rdma_data_init(InetSocketAddress *saddr, Error **errp)
 {
     RDMAContext *rdma = NULL;
-    InetSocketAddress *addr;
 
-    if (host_port) {
+    if (saddr) {
         rdma = g_new0(RDMAContext, 1);
         rdma->current_index = -1;
         rdma->current_chunk = -1;
 
-        addr = g_new(InetSocketAddress, 1);
-        if (!inet_parse(addr, host_port, NULL)) {
-            rdma->port = atoi(addr->port);
-            rdma->host = g_strdup(addr->host);
-            rdma->host_port = g_strdup(host_port);
-        } else {
-            ERROR(errp, "bad RDMA migration address '%s'", host_port);
-            g_free(rdma);
-            rdma = NULL;
-        }
-
-        qapi_free_InetSocketAddress(addr);
+        rdma->host = g_strdup(saddr->host);
+        rdma->port = atoi(saddr->port);
     }
 
     return rdma;
@@ -3359,6 +3345,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                                             .private_data_len = sizeof(cap),
                                          };
     RDMAContext *rdma_return_path = NULL;
+    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
     int ret = -EINVAL;
@@ -3374,13 +3361,16 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
+    isock->host = rdma->host;
+    isock->port = g_strdup_printf("%d", rdma->port);
+
     /*
      * initialize the RDMAContext for return path for postcopy after first
      * connection request reached.
      */
     if ((migrate_postcopy() || migrate_return_path())
         && !rdma->is_return_path) {
-        rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
+        rdma_return_path = qemu_rdma_data_init(isock, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
             goto err_rdma_dest_wait;
@@ -4113,7 +4103,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 }
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp)
+void rdma_start_incoming_migration(InetSocketAddress *host_port,
+                                   Error **errp)
 {
     int ret;
     RDMAContext *rdma;
@@ -4159,13 +4150,12 @@ err:
     error_propagate(errp, local_err);
     if (rdma) {
         g_free(rdma->host);
-        g_free(rdma->host_port);
     }
     g_free(rdma);
 }
 
 void rdma_start_outgoing_migration(void *opaque,
-                            const char *host_port, Error **errp)
+                            InetSocketAddress *host_port, Error **errp)
 {
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
diff --git a/migration/rdma.h b/migration/rdma.h
index de2ba09dc5..ee89296555 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -14,12 +14,14 @@
  *
  */
 
+#include "qemu/sockets.h"
+
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
 
-void rdma_start_outgoing_migration(void *opaque, const char *host_port,
+void rdma_start_outgoing_migration(void *opaque, InetSocketAddress *host_port,
                                    Error **errp);
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp);
+void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 
 #endif
-- 
2.22.3


