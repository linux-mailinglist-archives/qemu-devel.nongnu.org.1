Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FE7B795A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwmh-00051S-Lm; Wed, 04 Oct 2023 03:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmf-00050q-4r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmd-0006Hu-AM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:04 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393JT4lS010676; Wed, 4 Oct 2023 00:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT
 9s=; b=B+CMe9HubAOgfuDBPJXGKyfS3W1mQHot5vhXIMuXJn6aNXqc9xvJ4Csb/
 lvXgOV3KR2+Gj1uDuF7lXljt6SoS9b5DDihPkyfiF0TqRyeiYAcxePtmc/p5ZLPg
 g64hBikMg2s8BZZ/04z9WkeRBa7PMUEEa5RMJHA9kSsOvVBzb0yvqCTMVOZw8ZQ/
 jviGglFdkIjR5NQXD1WNJJi7s3xE5v03kiJf/O4Dv1jMD9mZJ4JAdXmIxC9/ErBU
 Fw+0hGZ8lko1qoYKEWiTq5+/du61T70/0s6BxBBlN5c+BRg5xSgP/EUBXaGPbqPg
 8FMgVZSakbFYsqOLdO74AHhSigrrA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh77031s-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuneG/ZuEDIvVFmdlk4Hdpb31qknmN24qQCfnPVe1i5UxAgTCyC04NIsnLncGBXPOndP8dQuWA8MmHfnB8h+7W1N4522uzoaF30JHsPCGo21HBO0RxYJ99yBf5H1Um9hOJCIS+RDj/A2thSkR9TE4YCAzkmJBJ39kuesm1V7DXLz9zNWOarUholyQcsX3hLJRTtm0QBSZ6ahCVDWGnL+FTtFSTFzOXYfNXEVzAAQcq1E3h8ch8J3E1ZCirObj18L5GJMruKN6aX8s06cCBPSqfaIERFBVmz/j1piNsN8vha+erOCDSAvx07RHlD/Jwfpd5PvvH9aA5H9MXHGunZNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT9s=;
 b=QmDlwEbsxT5jMNu5a1H/4wyOZO7OJm4ZokvB3l0TDBPLSzVz+E+Zd9P6cJGD1+IRSyIXh2iAxkjS9K7qEULHu3jOWl45aHtK3MrmJg29qqRvFFBfstTb9JKX1rtoMaGlO0afmiDggKcweaBSPlDjDTKOvp+Z+hPI3KvKns6PFcGp0mBj8XCNF5jfN+MAFuvp50E9ztxaRQoo9cu7uHHmqlyFPO+0jQ8GF8yiK3jaZSJXs5Vnm9PYhKKp/OeZDHDQ/UG4S+bnsXAiicGF2bNStHAVdEc020FrmVAKx7OY7yRLM3Ooa5bwFn6y/Yxeo/4tIU0hWLR+siCNJ830NfEH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdphVivksPcEpzXgwxtfmuc5muVTRJbgLjSKlm3eT9s=;
 b=A7dxpeU5/Ts02zIDsKI8Gc70rvqg/p/MH4blRUp9yTVhj8FzYXkdaAdy4eR1ZjTB4nfSLgla+s6g8/54gB+bO3QStdzUDrDdCPYUZ6wIIJTtJNhhB4oFXnYgHhx7a6bdcH3iH+O14BfgnFSse2d0CAGE0rD/zWAM6zqli7tEUH2sa3uXeGHUR4nMij1hZfg0pANBadqSsg5AilYeohTxo+Be8HTl/E0hIskpqs/t1gEz1G2GD1p01cNOg5pCwt81NkS9DwvvTgkD7Idn15QNv5dYq/fvXNPwtqcFEu44K10m4APOof02drNfzC4b37tDAK4eKPlqOQ8CrtI1bPrLqA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:00 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:00 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 01/10] migration: New QAPI type 'MigrateAddress'
Date: Wed,  4 Oct 2023 07:58:42 +0000
Message-Id: <20231004075851.219173-2-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20cb6efa-103a-4f86-94da-08dbc4afc4b8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: At9ZXcn+FjE3bfIJdXLQN3V6hR6GGtj/vl3Tuse+pXMw4bjCH0oN2g4LSum9iqW+7Bk6TvJTbh+c03ISdIzrKooV0G/OdXFzhlv8wYxdvnQJBg0Pi0/pWLXiNxx1ID9CCfZ0vTDNiLjkqjWvHyjRLNkdD2Ql6BD41Lld63U5/TTb0mFm9BkrFxxI/nKKHyPhjjro38w/8TA0x9SaBPpc6xoUJlqKtNVcUS3OGde0qfj+U4gT3ub83GTRz3MIf8fGZsdySnuO/B9r6rbuzBAOeXz4ATeVBSzwS/8Rkvq9xLkJ3y/tNwTPCceM69/0VOHcqOJDip8TpKrNRIO+R7zStxG2PcheEGyNI2/3bxbH51wmkunUBKNxbVF6n1My4YS59bRlQRc0i0Oh7IULPpe+lJ+mjjMkdacRNUgVZ+RJJVurStohf+0/gEJ9SWzJJKUGsJHlHc3CHeJmCiCTQ3fKBuQpsHrBsSlzsMV8B5NT+Rwmy3MZfBDFSJryp9mbc5W9NEuBhYMr6wvGMDieCZ7N/384qcbnye3u8vYjZ1FbFdtJarxwLj/dw/PI6+TlNzCAy3ZPgKOvyrmH9kIo5nZ6xnshLkzAm/ErMd3Rip7zt+C6FjSUE6mkzqqgZyaHHdDV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(66899024)(2906002)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWc0NVBxMVdFOGVSVXNHRVV5SWlzeTJJK3dWOGloUjdzQjZZRFRaSzM2L21r?=
 =?utf-8?B?T0NCLzFlZk4xTkY1REV4RURvK2lQRE80RVNNWmU3Q0xWMHdESy91aWFVQ01t?=
 =?utf-8?B?VDJnbkRBMUZhOXpqUEZZdDZOZ3d5RG8zR3hMdmVoTW5iUVJEa2ROVVNweFRO?=
 =?utf-8?B?MjNBLzF6a2poWUJOdkxXbFhURlNwdHZsSm93ZWNnNUVQMFJzQVh6SUJTcUw5?=
 =?utf-8?B?WElTcmZSNXpMaTdCaHQ2ZUF6ZVpjYld3eDk5cnRjWU1JbHZtYXNVekpoWDl0?=
 =?utf-8?B?aWwrTFU3cnRaL0puMEtqRnQ4WEhLU3pkNi9ydThZV3hTa3dqVWVnOVlndGZZ?=
 =?utf-8?B?ZGpGZm1tOWcyajVlZ0h3T0tVM1ZtbExLdTl2aFVLNnVlbThINFcvWll4SHFo?=
 =?utf-8?B?K0dHZUFoUk9YamFhL3k3UFlQZ3ZqdGxiUCtoM2tWSWRRNTlISEIyb1Y1R1A0?=
 =?utf-8?B?bGlzcERXNlZPcnUwc2JmRjdCNFRBMHhkd3FaTXUydFNHVVZpZmlabmJpM3BT?=
 =?utf-8?B?OXVCbjJPUGNLRGwvTGRzbEh0UlVpdkdnR05pL1FCbTdrZzB1NkJ4clg4bjMy?=
 =?utf-8?B?dWtQZ2pVejlrUkRFVGtuS2RLaE9hSVQ2VzJyb3JTbmVZWjFJdnRhSVNYbFE3?=
 =?utf-8?B?amFqQnRHbVplRkNTeGtuUWJ3RlZCRXVXMjNxcXZsQ1RrRVVNaXVPKzBtNWV0?=
 =?utf-8?B?SEFtRkJ3WW12M2ZzU1pmaG1qYll0YWdYeVRKSDg4R0tHSUhKV3JBUGRiakNP?=
 =?utf-8?B?YlNoWVV6ZTFvaGFudXMxZ2hJVzdPbE1Ea2d3ajYvaGkyR1U1TTkwZzZ6WWZq?=
 =?utf-8?B?cWtYQUF1TEU5MmFUVFdRcFRhdHRlQXdNMWRDbEhGRjZoSXhUNTZGRCthVTVx?=
 =?utf-8?B?V3RqMm5JbVdHckM4bzgrTTJUcGNzZ2Q1UHJIZmRCbmFuelJWOVpBakh2RUVK?=
 =?utf-8?B?dUhKdXIzWGRBNWY0WEQzVXJSMVNTbTVvZzZMOFdnWUFWVm1WcU8yK0ZGa1Zt?=
 =?utf-8?B?eXpPdzZhV2dMdjhIelFEcllkYkhDVkpGSDZmVFNSNk5aL0NGTVYzOXJFUkdC?=
 =?utf-8?B?b2gxalR6MW4xVG9lUVJSYndCd1hHOENwNWc4RXlFc1ZNYWc1dEUxaUZiUTNY?=
 =?utf-8?B?MXYzQ2FmazdzQVJRd2JjMGZXTFVBRE5iQ1duelUvbjczMlpxWW03QzdjWFpX?=
 =?utf-8?B?cFZBa00vVHNuaXJSMklCbGJ2VXJ6c3krUlVFQkEzUm1WbjhPYWNhQU0zZHhG?=
 =?utf-8?B?bG1lNXN6L3BvQXJFcGsyYlJRTnZzNGwxOFE5djZuWFJmWElndWpBZWxHRmlS?=
 =?utf-8?B?cHkwbVpjdys3dWVZdVRQVHRoSEYrRzdyTjdMbWVobS9uNmVHY2JJanRkVlNa?=
 =?utf-8?B?T2tBb1pZNTA5eVFaOW1QNlFaeDVCdkZ6UFlIeEJ6bDV1aTBUR3FuN1ozVlY2?=
 =?utf-8?B?WWhCQWFidDNOWHc4MFlvc29zY0tGUmx0U0ZJdHZZWVl1QWxKTncrOFdxeGt4?=
 =?utf-8?B?dFdqMHZySnNBY2RGTWRXemxJbjk3a0ptM3ZOMUNmaW9sRHk1M2xpZWJiVHlo?=
 =?utf-8?B?eVFpS1VSbndVcmdRMDBPRkxzc0hHdEJEQlY3c1ljaW9DTFY0YTlkTmdwWlVh?=
 =?utf-8?B?QzUxbXFkMDhXcVQrc2taTFpjU0dYUitKaVIrWEFTWUpqc3ZyelR5UkdpWEhl?=
 =?utf-8?B?THYvWGZwTHEwVVFBc1BjcCtZS1ZsQ0FZZ2ljRUpobnYzY2pFa3hmVU5LdENy?=
 =?utf-8?B?b2tNUXFGT2RJYXNEcmpmbENKTm1VMllsWE1zN21nSWZIWkYwMDllOUpPTEJj?=
 =?utf-8?B?N0pDd1A2MWdKWFhocFp6N0VWUHZZWlN5ZUFtTzd6blo3UXV2M3N1c2RjOEFP?=
 =?utf-8?B?UGdRSFFvVmRJYndsNE15b3RNV3ZZQUNlTFphK3lTVjNWV2JQVE9DS0pnRXFP?=
 =?utf-8?B?WkRld1VmdFRoM3k1Zis3OUtvY2lQRWcxWFlFaHZvWXVyVlFieVh4NWFqR3l4?=
 =?utf-8?B?c0xKMHRSM0FxckpDbnRNV2tBanBIOEdEYkttbUpldlNQdDR6ZktIL0RPMkhQ?=
 =?utf-8?B?SGNWS1Y2dy9TZzk4dDlHanBXWDR4dzd3QXRZSUljMTN2UC9jQjZQUHF2S09L?=
 =?utf-8?Q?ujZ7FMloC/GvsYT1TgdnmXwWr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cb6efa-103a-4f86-94da-08dbc4afc4b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:00.3102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLkUtkfQpQYOx14XxzTiEI8BbLxgHxtTt6DOjOJ/R4e+7iyG/nqzEMJYfJzuCS0FZblt4+5sXJQXLFUpxmD8jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: g0KlTxBfsw3CcRoxUm7OPm5ec1WVxIkZ
X-Proofpoint-GUID: g0KlTxBfsw3CcRoxUm7OPm5ec1WVxIkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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
index 8843e74b59..4e4c39a9bd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1478,6 +1478,47 @@
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


