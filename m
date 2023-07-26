Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CEA7639C2
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMY-0003rW-QS; Wed, 26 Jul 2023 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLo-0003MM-CR
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLl-00015w-6L
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:52 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32K032511; Wed, 26 Jul 2023 07:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=DKQM8nmKY7bFayiJadfN5KzX6LzU1yqvEnGMcIEVs
 LA=; b=tieVZD7qCvurUJXLJej66LjiYOgBdvxm3s4x0kLwM/am8LVd8zweQdMGF
 MikTyflzG1dqqaRiBrmUJ6AesTfsWOhQzRnDsQoIqGnQS2lZeVqo+J9BKfEdJKHf
 wVQvAMCd1A3UInK7s1tA3kUxBL5AocVV+NAleV3bPKi5RhMs+BGjNS+b1stJcsN1
 zF8wIAWVlFrmGLe+BWNDPecGWkTXXPrQL/9Jt8YOlrl0NRXP3cONpO/PS4mp2NCz
 x6CKAvbEGy8qzTPfIMByn79kWw4LjXVeWgHCVdf8jPw2neCOFj79Xe2eElonvbPW
 tZ268Mt2omchcP33gh+cNVIdNC0sQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJNW08w2uL0WgBzHd7wXDS6I2TMyFWXJFBoHnlaJUG2CtERQwDs9Tvry31ydhqwBUYEInsXTVhHGcUbF2UPOMqKISO42KJTGjxOiJOOltQvDud9q6/CqwvfJlWgS7Fg2yPV7OQN6cj0Dx8uAtcGjU4umMEATEtPuhhDEP3kWcWMLcrUD76WWKqU3Gz7vsmZsfdDKsLoTZf6+HuDURg0DhrnliDtlceWO+wNeON12lGDE0XpLNeiLKjj8SCcxe3TSTMNbdxIHXymYWZuy9SDiZttln/HOdwjxe0kqz6qBbPnDBPKjoHQRY0xjUmKGJs16EoicS+C4PXNTQd5gZLtpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKQM8nmKY7bFayiJadfN5KzX6LzU1yqvEnGMcIEVsLA=;
 b=JefJDUJ9xvA8DEPlmbWIOLKsUlw7WxuIG3cGAJ/SLf0YNdytMOPE5Z57khDoTDhYqVAc227UbYwLtpeKUZ5BXjkL6MaLq4GFr7mQ+2ZEF5wJl4Xz3GW7Zu0sh3K8OWiQ+TCzs1Q53TffMj9jJY+yMvKnmI3AuththL4B3x6mcW14Hy/uMPZoI8hooiCxYVpFT2qqzr5V2LtMXBhFxf4TrO0EmU803fQRdkwswC5jcVpFuXW/5InIVLWHCPq675DPh4Ox8zmsWugwPiDbpRuzZfGAGJ1J22hE748OLK/owEiNCrRUuOPUbGOddfR95Z1Ya6VF/kHOBgLBqh4pL8eHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKQM8nmKY7bFayiJadfN5KzX6LzU1yqvEnGMcIEVsLA=;
 b=eVLFIXXxylUlw9k1fRr3xwoqSfqOp1zZKbyN8eQbQmNifY+O+HA9HyRnpGwMXmU3DmWwOtlahV99LtMw4Ozc4LdnzJZCO6VgCwPepW/Ck8dVtXXJ882j9YJ3KzJuXZHHrot+yqeEeZ1T2bBPtcmPd2RFSUJhvGtJHF6zbsNg3GY/IzFut+2ZPDE5++OyHOMmmn6T4Y9tliKz/J2ludci/iISY770kddQRy9NRbdxSg14OeDcP5YHclxG57k83CCXhJgNIWj71U1mR3uJZJBk/Y8udRFx0vVvvFQ25+1+d+wR0iftuQdFzW1yyepxI/4rZ2h8brIgx9Lv31Y+aOvI2A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:42 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:41 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 01/10] migration: New QAPI type 'MigrateAddress'
Date: Wed, 26 Jul 2023 14:18:24 +0000
Message-Id: <20230726141833.50252-2-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0765e3dc-d62a-4109-aa1f-08db8de33627
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Iq971KrgOk1lDiX00loAhkPZkL3b/BP2NueGcw8fEaW+AUd3oXD+VKUjhne6zXK4ViQKymf2Kj8dELnkBvTVGoOydWZL1FLXgkGLOJwTTEZRPSJ9jyhQZPOUpWP8Htye7efDhPTQnMLB8HJ3tytJO/HmY+PMftMZmlyStAmRK59vkC9v3eCK1yobxNs0K6SWQMOBRf8wM/Eni3CuAylBxBPKkNc3MZWPV3EYEdge4+fdWJa4rJwfBojgww3MIiPyFa44t79MWnadvaoRY0QZjLOWFufHLNB5HonB0FSiC7K+J1aINKeBiUAYxb9Ls7nS2pX09PLbnYlL6FH9gZEVrlyt03uRpYl1mcb7zJZsm7LwPXhYpQD8JTcuLXamuMFtHhU/DDeLuG6wMUOxKnrfVK6RxK2A9RVK0WdrX5oaW+uud8wYv4+pSE+fLnEGoYRwVeMraqh96LvphdarE+KO9BZStj3Xt8qsy+qAOhoFRvyiU9Jx3R3sZZMDUSabemJCDoMZAHcJ6Iqhgw1DZEL7dNH7Zvh2tb7c+PFgC1B4nuDpzY6sjlDKGk4b9jzjwjSfKudmqujOAttt1LGxZHV3mi9FyGqS1fYWPvGgFloIfsKtnomRz5jduOJRT/j6dJb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(66899021)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNLOE1KT3NlMFhHYXArczFPbmdJZDN4aUJYNjRQT2dER0cxOHFiV0FZdXph?=
 =?utf-8?B?T01sVHV6dHRlYStVVENOTTBiTE96OVN4Mi8yNGVXQ0lpZi9ES1pITDZDOWtE?=
 =?utf-8?B?ZllHNEpiVldGQzkwMWM4U3Q4ckJiSlVteEhsZ1BBalJoNzhmcllOdGxuWkdt?=
 =?utf-8?B?Z1AydXpIT3FLTTJ0dndtSjU3N0lkNHE3TzkxenVaMStwSHA3U3RQK09QYlU2?=
 =?utf-8?B?cW9sMVFzNDhkRm54aS9Za3dDQkl2d3ZyZmhkUmw3b0hXTmxkTFBVQlgyRDFP?=
 =?utf-8?B?d2RJRUQvM053TGtIdjFRWkIwb2NVLzNKTG1rbW41SU9tdW5zREl4UmZXUjlE?=
 =?utf-8?B?bnhKVVJjNW5uMHoyeXlLWDlHMUcySGRDRkNDTkREOU8xSGdoM0V4Sk53L21z?=
 =?utf-8?B?b0lHZGRNRFh5b2lYTGFMRk5PcTlqQ21VTUQydVRuaFA0RXhyaVZsR244YkE4?=
 =?utf-8?B?VG5NbGU0L3Z5eE0vbUdxYnJ2MVgrRHIvVnBHVFVZMnV2Q3BpYXVub1JOVWw5?=
 =?utf-8?B?VHVQdDFpUWd3QnRNRlZON3ZBY3hRdkY5VkRRTzJVY2VpeXlJMDdYWWlUOGNx?=
 =?utf-8?B?Q1greGgrMHN2T3pmQzlsQVhxNisrWFF6QkFzSFVtLytZblZOdTJERnRyTGFr?=
 =?utf-8?B?bDdpbit6T0lhRU1zZ2VVTEZjT2Qrd0s4UFZTci9Bd1ZxSUE2cHBWdGdwbWpR?=
 =?utf-8?B?Z3NUdjZTdzZEUXdTLzlSTDY5YVUxNTc1blB4UFhnSERFYjZSWVIzNFBiVFZN?=
 =?utf-8?B?T3lrUU5FUitHSkFRRzZPNnJRM0VkSXVuOGVKTkMzNy92RHFCOWRqeXhINGd0?=
 =?utf-8?B?c25abEpWWHdhM3RnaTlUNWp5Tms4M1orMXR0NnNtVHhKOU1kMUJ6T0hqYnE1?=
 =?utf-8?B?ZS9nMTgzanF4ZFFlQzhHUlRVWTZZZzhCRlA5Z2JLQ01HelFVSEJaN1hpRFJQ?=
 =?utf-8?B?M3h3Y2FSY1hMSld4ZHNFTzF5aUpRS1paSnlZc2Y3K3FoTDVKNnhUQVVmczZn?=
 =?utf-8?B?QTRncE9SQmZIaFJpNXZwUVcraVlJQUdjN2hXbCtlcU1XVzlrN2I5TUV2dVhS?=
 =?utf-8?B?bE1UL2hkRFhxS2pCZzRxVUV2U2lGdXl6TVpEMkVpd1dhYUNTMEpLZnJBRGUv?=
 =?utf-8?B?YnFLRm95YWcvRDd3bGwrbTB1NlcySVl6MjJKOFdjNlJ2dkI5MlYzd3AwUWN1?=
 =?utf-8?B?a1NWRkwySitaSExOQSs0UXRQNG5JL2Rub3Q5amVQZi82QUVnQnN2S29zSkJ2?=
 =?utf-8?B?OW1haUhxU1o1NmZlSDRheDhleURlbW5XZzROVmUzZkR0Qk1RQUhQK2FLMTJ3?=
 =?utf-8?B?cGl3bTFuR240OCtTekJubkRPRHErNmdiUkxXaTdNbGZGeUNtL0Y5eG80cjJy?=
 =?utf-8?B?Z3dkSHI4N09JT2oxbVdWMHAwOUhDenBDZ0ZtdXhLRGIzNms5SXRDMC82OEU2?=
 =?utf-8?B?elNINml2a244OXpqSm5tNlBFTmpmcHFZWURsbWE3SXVBaXNUNS9QSzdyYnlT?=
 =?utf-8?B?V0d2elRIa0EveTBhOUZRa1RLYkRIK3RQdk9uQmJMNFhJVXhmNCsxdHpUNFVK?=
 =?utf-8?B?bjgrSncvbGZxZlBiVGdKUnNLU04za2gwUlBXMmE2OC90dXYxZnR6SS9LRXZL?=
 =?utf-8?B?QktwTFI1YVZNd25CTnE1T2tsN000Ny9GSE9WWCtnejdOVWRmTlhvZmVuMVlD?=
 =?utf-8?B?dWM5R0tPV1pSNHhyOEVtOHh4UUU5dlJFMTI2aWlZRkh3ZmxQVlR5d2tTWDJw?=
 =?utf-8?B?SzdkM1BxU1FlWGl5U2IrRktXczdDMk1TYW1OM3BPK3F3SU9WMHh5dHpOMHd5?=
 =?utf-8?B?S2ZwejVIOE8rYU0rRHpWY1R2eFFNKzlvSHR6NGtjNGxGS2tyRytzWnlGY0hy?=
 =?utf-8?B?dllOMXFsT2tBZ0tQTStORzZ0cEdvRVpHbHozSVRtd2d6ZXJKdjlBaENHZ3RM?=
 =?utf-8?B?a2NTRS9lNHluMDFKWHZuT1JBYVJFcFVFQzNvWHRUTXA4QVp1T2VnWi9BTTRF?=
 =?utf-8?B?NThPT1NCVENma2VreVJlWUhhblNIU3pkNDRnOW1WamJNbHBaNGpGL1FucHRY?=
 =?utf-8?B?WGxENVc2QktWenViajhheWl6YXNscmdGYzVqVlVsOC8xVWRZenFHNm1wV3dU?=
 =?utf-8?B?dGJ3ZmRtaDJTK2V5KzdDMUV3eVRuSzY0Q2U5TlV5R2hESGpkNVFLTmVhT3px?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0765e3dc-d62a-4109-aa1f-08db8de33627
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:41.0847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8JaS0hz9w19KnGUyk2VcQ/V7vdkA0mKJ6YG34J6Z3GVXFT+XfRCeTKepzLX0LM/Wt+o5v2LPKtJ54sn7k+18g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: nZ01Li5zGb4ixDiK89kEh9lzJlN-9mFr
X-Proofpoint-ORIG-GUID: nZ01Li5zGb4ixDiK89kEh9lzJlN-9mFr
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
index 2a6565a0f8..6b97ce9633 100644
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
+# Since 8.2
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.2
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.2
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


