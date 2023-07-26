Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5D763A71
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMK-0003Q5-65; Wed, 26 Jul 2023 10:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLp-0003Md-Qy
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLm-00018S-2m
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32M032511; Wed, 26 Jul 2023 07:18:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=Mcj0Yu6E3uHHH/C0y8c67jmjidYRyXgmwHY0SLWF3
 2w=; b=JqeV46OKdZCvgslNUSEcvpbYGVTkBQkX5nMnjacpR6E517HTgghMGQW9J
 PgrRTXyh/YjHclXca5RTN3Gx8PgzhOjBKXJXhT/wnQ1CXGbdOpmgYheGipc5fNec
 nj+kPDMKcIAUY9iVhgk0eiGAPrRSothJwb5o69nq3eV9UiG9yt4E9Drq4LD8dGZp
 quu7VevIzTNxUCOsCRVEoCEPzLFU8BabBFmSM6YRkX7yDlyy+gAUXdQgTA/ijB10
 OlqjdD8z6XSt8mb41z+9kPJj/KvPYigLMUDc0ABLCJouIB9uwz6/+4UbmopHq7er
 tMM4xWIxe0QPk6rSw285006WIya6Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+CsBUSRUX3SkXRazuZHpNqy6TJfGhSH5nzw2MetVm0jj7O2QYQC6oBxIS2xftd8T7jB0CaRCbMxXtrBN5N06xo+sPh6q8O7tvVHrFcNOo2GqGXX9j2ods0VdecORUQurJJF7/lUSDuKZfVARlOvIPl4uVpF2wcEYlm8iIClWXW1b2Rx9r/CcZa25kW8KO7X0SKiYq/y8OBjwj9jdRvFJviflbwe9n8ilZyI0wWZqucw/f+RYm1yiCcnO2nbSntNyjYhz6F79FNNbaJTiJ2wDjUVlO93y4nAwdZqp2o2ouV7fIU0EkN5dVdhD/Ebc7WVGT2szADq30WfOYmTScZvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mcj0Yu6E3uHHH/C0y8c67jmjidYRyXgmwHY0SLWF32w=;
 b=Ouitrh0l2mX0O+DRqhj1jCaReTlMo1BuCCBRasy9QxTZl0ipUUTJ/V9s9GIUmRIRECYKxN6wCZphsV6/OiaMBaFTKQtfmiP6DK/MavFhBZze1FcHv3971Z6kS5RhBNwD7WwzWJVMAUwzITJtofxadYJBVFY29JRrPZwEpDVqbfe/SJlsREk6ANpSL/7r85UT+sYBtVCweMN6oSu1XZA5zok2q2CiIBxN3PitAVmdz6HCQ08p4nM06oflHpgN7REx3YOzkPcdUY7pKhiELX6rbwPnnnHr1CAssMyVpknvMGQE68tRSo2RWSuRuK3mQ4VHTN6+26nfnYaH0OHMAiCrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcj0Yu6E3uHHH/C0y8c67jmjidYRyXgmwHY0SLWF32w=;
 b=LKl5oABG0GWZPBj4jgoukAlKjxOFQEJhOLh6dYKOeH8nL+H+lKxQTyJUHywBrJoKHTHwcX46135Cj3Sn4TrKDAzgRcsfUSdgvEH5cPRll0EFSHpZ5f+EZygWkaHX2wMehGELcR7OfC7frles4/zR/sWOqyLXOP9sBpvG7KoEbVhdDabE7kcuok6Y4JZAGi0gFbxBI/npP5D+VbE5miOAmsbiEGKtrO8JHXOL2C1BK+/pwLaanexSYhDzBRFVqYVSPEST92M20hE0JFfKzv2et9ZMH7j9ykZFEfGjEZTThVsz/Ie+lFJgtlgAxjxumgzK8XVyZEcBgwEdDb4sgZw0mA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:43 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:43 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Date: Wed, 26 Jul 2023 14:18:25 +0000
Message-Id: <20230726141833.50252-3-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8359548-6feb-474f-fe1c-08db8de33702
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUlr4c+Y7eWaqqTE4B7Ob5s3VqcrfRTcswRqL7MZCT6FV9MaFT83PFbg2I4YGUEgwDWuPQemPh2Jb4VwbF7/gAfCK2WIlKKKh3pKzphL5PXUuVqL4Z+pZfpqqC34ijnOoXXoh2t1sbv+vfToaBGbV6ulIb1vy9Z3Y0jgX70St2I3ykB2abneiZchPpU9bkMMKaGoQX/YMXIaDYgzTZWjvwdYsE/dONkB67viPuutBCfy0AHgDiyDGuTwUPyp9TSWPRpyoFqjbuuZqW4kP47x7eZFJhhOuqlDwtHaPGP3WfiLrYoRmn5ZWJ5d0EqxKA71OR0QwVA1cgy8kYRP1sf3aAsvtMbR6CxAgTH0zf77Ux4St1cKZm2vCmIH1QoUqxkqnW1i1Tawu8RTmMzVraTa8QuRQrAUnVwvrb+5jyVnW7OX2MWo3BHy6kpYHzxIWom456w9AjOHE5YQxRCvA3513TpsPcYrh87eb1wa+9wgqjj4aXvsJ96xg0SJFJsm3bwkj1SiXZ1uh9K3vuLm/qraHehAAFSwWPvNpo/YjvTgDzNhLSHg95YYeecPHOd0E9TJkpqBKgOTkShiABQ7XQnzUx50LOscZiYCRRD05V6iZ7ZLbu99Ej03rNR5xc09OTQv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhBRlEyeVAyOHYvQUVialNqREhiZTNSZ1BNZ2w1S1BSd3BJMm1sWm1xN29L?=
 =?utf-8?B?RXU4OFhPYU5nenV5MHZnMFgvb2tIVjBLcjdzVzE0dlBwbjd0dkRlWHhkRVBJ?=
 =?utf-8?B?VkI1TWRqdWxyUjVoY2hpQnhGN1E3b3l0d0UvR0tINzF4YTNEMzNxTUtEeEtC?=
 =?utf-8?B?clVKaEZKbmo4Vzc5TEZ5Z2xDUjB3MEpjcWlTN2VYODg3R0tUMjVGYVFsZGEz?=
 =?utf-8?B?QUN3OHlaOFY4NFF4LzNBeURLZWpvTkY2RWxPcEF2dFVjQnBIVW5TNk1LL3pm?=
 =?utf-8?B?eTZlUEQxeG1HNVdjQlpNckwxOUovdU5rYUVtaG56UC9zKzdkUnlqdjRWcnZN?=
 =?utf-8?B?ZkQvcldGVkxMQzd4WE1mQTdkdFlJVFM0bmltTGdzOXF0MVJzbEtmNFRVdk50?=
 =?utf-8?B?OHplSDRwT3owbVBGaUlTditjNEJhWEhwdU9iOVNxT3J4ODZ5d1dLK2R3Y2ZV?=
 =?utf-8?B?SmpHNjFyejBkbW9iVjEzM1JHZnl4UU1vRjZkRVRjbU9ENm4zb0gxL1pmd21v?=
 =?utf-8?B?ditlTXllUUQ0cWpLc0o1Uk1hQjhhUE1WbUhnNitZUmpITjZBK0puL0JnSENh?=
 =?utf-8?B?dmY1OUlRSHJZV2pBakNkNEMyWDdiUEJ2aUZhVTJRamoyb0RTbmU5SFJZcTNV?=
 =?utf-8?B?cGo5dTlPTkFyNVNuNFVzc2xHSEFUOThYUDl1bG5IRnR3ejZTT3FnSFFYcE4v?=
 =?utf-8?B?WjN5NEFBRlVRZmhNVW9rMUt3U0JocldpWWtGK2RzUkVyaU1OR243R3lQV0xM?=
 =?utf-8?B?SmdEN082SDR4RE80VnpwSWlnN1daZjh1SFBkS08wTEV4b1ZmYi9SZ1pvNmZq?=
 =?utf-8?B?MjNwZnhLQ3pobGUvRkd2V0Q0dDdZd2Y2bGRBVXA3aEIrUmlUUEk2UkJDMTRk?=
 =?utf-8?B?cXhOQy8rWE1aajBHa0w4VTR5dFViN0Q1NmNGdkk5QVRLVXlMRVowQjRHTWsw?=
 =?utf-8?B?WHJIQ3JvSlB3eTJrUC9GMzI2YTByWXVMWXR5VUZNWHZvMkRSNTlQdUNYZ0Vy?=
 =?utf-8?B?OGR5ek9mY2x0YXdNcFRFRHVFTUhiTUJJeDh3NDVzSWc3eEtTWXVpekxVOTcw?=
 =?utf-8?B?TGZCK0wwd1k3dUtvMWNCNkt5YzRJYUhoYWhhVE5ZZWhQbVQ4anJyWHVnRGJr?=
 =?utf-8?B?NjNuMUw5OTBvc3g4Q0RFaXo5NHNmc1dGYVlLamQ2Qi85R1ZNcDRsanlNWHZv?=
 =?utf-8?B?Z3dUaTBlRnkzaVZNS2VTZnZZOXk1VzNwSUlvT0VJS0JpYkYwamhmaXBPTkVD?=
 =?utf-8?B?c2FJV2ErUndCOGRVbVNoWGNMTnVNNEF3WkVsNFFRUjBrSW40SXhEU2dQMU9j?=
 =?utf-8?B?c2dJWHUrd0dLQ1Y0MGk4aUs4Tmp4dGhvajQ0RWN3eG5yckFpdHUvTTdsTXVG?=
 =?utf-8?B?eWZUR2VOVFlMRVR5anc5VnFXM0U1YThMeDBDVFNBZmtxQXRtdlovVEIvVFJZ?=
 =?utf-8?B?V2M3a1JHZ2ttVWlSTG9NTHN6ekFudStkZExDS1E2NTdrOGQyK25wWFhVVUpB?=
 =?utf-8?B?dTNQaU9IeVRVc01wQVE4SUhNUURqU1J0UEZ3L2xlZVMwZlZ1Q3ZOSU1DUEhn?=
 =?utf-8?B?Vy9mYS9DMjJLbi8xZ2VBMDFnb0wwd2lnTXZMNi9McUZRNkFWUmhQWXJ4eWJE?=
 =?utf-8?B?MGE3SUlLU2NFbE5KREdPSHV5MXpwWjNNVk9aVU9zUnQ5ekVwdXE4cnF2bkFW?=
 =?utf-8?B?QVQvbTFmUHRmU0hZWGhMb2dyWmZrejBzVnFLUHowTSsyTUtZQkE2RC83RERo?=
 =?utf-8?B?NGNNamk3SXU2dWNLVjdlV0hUaWRiMVBwWFNONm8xb1RWL2RZWWFLZUorL2Qx?=
 =?utf-8?B?Y2UrRXNaaTJBNGUySG02bHk5L3JGM25uSE10K2RFdzErRmF6M2xvbHUyNnhr?=
 =?utf-8?B?NFVYTG9PT3ljMVIyeExzSDRXcmFlU0VIMURRZEVRSFVHT1V6MVBnUVBWb21z?=
 =?utf-8?B?YllYZ0RpK0k5cG5DTGxVSXdIaitqMUFxTG5zSTc4SDRnWlk1anprS01wNDA0?=
 =?utf-8?B?Zkt5Y2dqTEV2YldYTm11QnhUZjhWbHZIQ2VOUkFQVFdpUDFWMkJVUnlBaG1s?=
 =?utf-8?B?bWc3WnBtbkJiZXYvUnZWd1JGbis3VDVHRjFKckdoRlBkZGs3TkUwK3JkUGkx?=
 =?utf-8?B?anlSSjBLM2p0aU9TMEpacEJZYzJEWituejh4TDI4T2dBbUpzQVh0dGVJdXU4?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8359548-6feb-474f-fe1c-08db8de33702
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:42.7868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpsKvIm3K1f5C1hR/7c036WqcpNQUlpLW/VvJ50kC1gzuQYULcPLr6eogy09ZEeGExIrI3fLD2vqBPAhMBDSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: XQr5b2S6LAWfG1UmUp12rgmKhMONuCHe
X-Proofpoint-ORIG-GUID: XQr5b2S6LAWfG1UmUp12rgmKhMONuCHe
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

This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
string containing migration connection related information
and stores them inside well defined 'MigrateAddress' struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/exec.c      |  1 -
 migration/exec.h      |  4 ++++
 migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/migration/exec.c b/migration/exec.c
index 2bf882bbe1..32f5143dfd 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -27,7 +27,6 @@
 #include "qemu/cutils.h"
 
 #ifdef WIN32
-const char *exec_get_cmd_path(void);
 const char *exec_get_cmd_path(void)
 {
     g_autofree char *detected_path = g_new(char, MAX_PATH);
diff --git a/migration/exec.h b/migration/exec.h
index b210ffde7a..736cd71028 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -19,6 +19,10 @@
 
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
+
+#ifdef WIN32
+const char *exec_get_cmd_path(void);
+#endif
 void exec_start_incoming_migration(const char *host_port, Error **errp);
 
 void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..5b3be767f0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -421,15 +422,64 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
+    SocketAddress *saddr = &addr->u.socket;
+    InetSocketAddress *isock = &addr->u.rdma;
+    strList **tail = &addr->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+        QAPI_LIST_APPEND(tail, g_strdup("/c"));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
+        QAPI_LIST_APPEND(tail, g_strdup("-c"));
+#endif
+        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
+    } else if (strstart(uri, "rdma:", NULL)) {
+        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
+            qapi_free_InetSocketAddress(isock);
+            return false;
+        }
+        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+        saddr = socket_parse(uri, errp);
+        if (!saddr) {
+            qapi_free_SocketAddress(saddr);
+            return false;
+        }
+    } else {
+        error_setg(errp, "unknown migration protocol: %s", uri);
+        return false;
+    }
+
+    *channel = addr;
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
@@ -1641,12 +1691,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (!migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          resume_requested, errp)) {
-- 
2.22.3


