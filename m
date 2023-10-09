Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D847BE301
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNS-0003K5-50; Mon, 09 Oct 2023 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNP-0003Hn-7C
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNH-00033s-Sh
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:54 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399C13qa029860; Mon, 9 Oct 2023 07:36:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=bsWBSXmTl1Yolggc2d/gWdriopPvrWC5pOZnYIvIn
 7g=; b=rhHvgqfky5rh1E+kuOzEDaEB4d8jQF5BvKuC7cT2pnIbzvMZ+DH1K4bGk
 44s2nN9CS20yv1hADM7wgOe4TMmlCrFDmyBvfh4tfdaohbu93zgeWHm4/lRXopLM
 FWFWksC07SGjuYGl6GslfhP4ceCUktRDy2nYx+zjoKhWrNpwfOd7hNdoiWQmOuQT
 NlCKavo0Z+uN0qd65ZtpbUNZOtlZ9CGEDvUzyHYp+v4ScMb53M6BHkcb6fMdppe7
 4q2Jdguhg55mOpj3dfviCvJ2V1YC/gar3vX29BBDDaCZIOg0ohfibmanDfqi2aoh
 lTfvS6RqzH/apWIzvX6Ea9wMVAZXw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02tk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh53Vrm7Is8QkUcEpclH8of4J55ACt3GwpOfb0wtoAYuq4AC5jgvL9VuUXfNW/fx/Cp2PGoGyJyD0JUGi02xCfG5tHK3d90lmA628axHosGjyo0kHugaQRm66SjxcOiervJq6bnlmvOrhaz/lyfKCQlhctjQSyj0wfYvTVgIZUScOa8bYGFBCyY/qjej1CBPatl45mkOuTW+mZt2jE8hP7kz4l/sQq1s7BZRf0lS6FMatrGC6OWiMcSAIgKLCr2K1QDcMUQan4Bhve5VhZ/BOzSu7gitynNo3mLZ9Fmj1CjIFxKXRlDfv1YgMZ/kyQeI9ckDekBi6GxSsqMEDXC30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsWBSXmTl1Yolggc2d/gWdriopPvrWC5pOZnYIvIn7g=;
 b=VZvc1SYK499vKldpJzhP0+KHXeD5lW4DzIYQR7HKDN6/e3A2lpsYaXGPBqnPhFt3//KX1QMpIn6Ncz3tYbmYCAUCOE9uOmrbjBmzMqrx7+VPAtwx/qsJoOQA8qDL0lk71aSaTl6JCH/GqjZ+9B1eHvtS9wRP14KeEn8lSABeZdibB3ZOJkqQyBXwZLgWiGd3HK6/LsxUrQyutTUpAmNNS4wNiLaJ3bJYEH0VXYcyceKVGGYpHKhtkZ+5yzY4kAJFyuVLqdJvq1qpu4jncguMAwJW6gUwXRTcJzlWKEVSRt4kTZtSMMdJqfsWGTo5JojUSGW21wVnhq1+PURSxHf4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsWBSXmTl1Yolggc2d/gWdriopPvrWC5pOZnYIvIn7g=;
 b=do3A9DzZktgqLRqnWBN7ah9CM55Mn1Li64bs19Swb7+B8RaHsbGAcQ1pRelOR6O1f7DIQFQ7SUOLLXVjEf/zlvM3oG2bXfl1dAmyhO9/sg5hdN2FRKLuLGjCPJOXtRBOOtpk2aO4ELlpYgWBs+Blq4O4+fMYMFY0BLbcq5eJNzyewto4gKUfdBPDZZCl8WMvY5iz6OVosi2vdyIoij9JgBoR/xD7DDJYJx5GKq4ZObdp5rRe6knr/StxnM8poOYs8h/tvzdPa665Y8/n18dmlkff3ja8QneUHu6hNfY/bm4j29hz4ZOjknqexMEa7NdIynMJESKJRFVhff8B3dca4Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:36:40 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:40 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 04/10] migration: convert rdma backend to accept
 MigrateAddress
Date: Mon,  9 Oct 2023 14:36:09 +0000
Message-Id: <20231009143615.86825-5-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b487f2-bba7-4a96-1e3c-08dbc8d5267d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49IaIdT0AHnhUjdZcgUDDxZChGe5QJ17ej2bJdAm7QmzINuAgZ4/AY1lX52Gzrxz0e0kikVdGimgwBP5li7F2pH7VIiS4oEnqO59KwGfoZNiocXEb+ukNglm+wqnHiVWBad+c+idTgp2I/cVYD2CE0rz4Vz5cEbgSmulwWihuTQSR0qK/jULWi//ZRP76uEeEhULbiXzNrtWFY/t83DLDBLgsFzDufBCcfbEIbsDtni+XjnVHhN7Hh0FMAUt8oVeJwT7zpqFC1t58HFKCGtSKjFZgffCiykDYMKRN9tFT0l+qq3Z/iCAV0R7tVFaCOceIYJh3Hr4yMF275rSuVxLVzcG/rzVEaPf4AtOAVxPgrgpZjw6W1dwW+KGW9K6m6gKRpe4mOCyPR0B9ASFq7nS4OGamsKryx0TrMvwb/ZG5wQLtFxgquV4/t+roEkYKAxG2lfEMk+aTBJBnoIMqiFACoVw9WJ4+M1L2zmTst3vXVO0/JTXkCSM0b6ks8krIccat5QtanNILTW6KoRZpayvJQHwiZmqMRRoLGruVsqOCP6o3q39ACnSw319/CjvpKLa7vrMTKjHBR4gE+ggL0JZDkMbrrXPe70vTFYeIdvSNA2BVBnZFEwXfGh5DpIHp7Rn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(52116002)(6506007)(2616005)(1076003)(107886003)(6512007)(6666004)(86362001)(38100700002)(38350700002)(36756003)(26005)(44832011)(83380400001)(2906002)(6486002)(478600001)(41300700001)(8676002)(316002)(4326008)(8936002)(5660300002)(66476007)(66556008)(66946007)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExSUmZwV2hSS25OZXRlOXBUTlZvSzNiQytqOUMrTmxMSUhodzZ4TUh5b1lo?=
 =?utf-8?B?aFBBWGNnR0cxOG9zamNBcUpYL1M3R2NtOE9xaU12c1ZIK2IvY1JNdmRQb2tD?=
 =?utf-8?B?UkZ4dUxsdWcyU0J6dkUrelZZRWZzakt6TTQ1cy9iY3pkMWdqZW1pcDdXdjg2?=
 =?utf-8?B?UHoxRlhaelQ5Y1c1cnE1b0l3RUxCcWFmUXpPV0ZITVVHKzMwamRnMzBiODA2?=
 =?utf-8?B?d3hiTkJmK0YrRCtjS0JCVmtlWG5TRjNjbGVkczJOVFoxc2c1TkcxR0RURFQz?=
 =?utf-8?B?WHBMdkt0bk5DK1R1Q3FLa3FheklUakd6a2lFNmdUZ1dmdlhQUHRGemt3SURu?=
 =?utf-8?B?NTBRd0RrZU55eWJsVkM1cWJCQXZLSzk2UkFDeTlTRTlyb1BLalpudmNvOGhu?=
 =?utf-8?B?cmtOM0Vla3ovS2NqeG9JZmZRYXpDTHB2OVZMdVovOXJhcVpkNDN5ZURlK1or?=
 =?utf-8?B?UmFSejFJcDFnSHZrZUh3WThxNzBnYWFwbExWSExkY3IyODllTmdYY21iZ3cr?=
 =?utf-8?B?RjRTU3g1am9sZ2xteHY3WjlHWDluS2hTalpQS1RRMTNQUzdKWUZLUUNiQmV4?=
 =?utf-8?B?S1pTNjZ3UEF4TCtybDRxT0h2V2pTbWkrN3QzVko1TldJaWptYndDSGlxcnBa?=
 =?utf-8?B?QmJRZVhJbDZGREd6eGFQekZoam1va1lkRDdTU1RlbFhCVzVZSUVZSzBuZzI4?=
 =?utf-8?B?d29Od21NQnlFZVV2bW5TaDByR0U2QWQwZUk2MXk2bHFzNjFyZkh1N1o3dWIw?=
 =?utf-8?B?bjhVNDk0MzBUeTlYYjBqaXNTT0t3cUplNVhDdklDL1JGSjlEbkg0RTNhN2ZE?=
 =?utf-8?B?dTVlamNPV2JLMncvdmZWVXV2eTIvdWNKNjR0Zlc5RzF3UlYwcVlybnZkZkdz?=
 =?utf-8?B?aW1GelFwWUUyZmRURGtROVRLSFozQnBmR2UvYkVvOWFuNTRjK2RMVHhYVTAx?=
 =?utf-8?B?VVRoYVRObjUycXVmVWNZbWpTYXh4ZFZiZit6bnRkdkhzK2xBdksxYWxQMWtL?=
 =?utf-8?B?TzYwQldrNFhMZnR3eG5GYVlLVTFiaHZBaERWOVZhaEJTcTMxUnlFSFRFODRX?=
 =?utf-8?B?YlE0R3MzVzhWNzNRczF0Y2huMUxpazRiczlsUVcvZzhHTVNwQm9TNUxyZWFX?=
 =?utf-8?B?MlR2RFJvVXhqQ1pYSHhRamZETDV5ZGNLZllWSzdpYnhpRjhGUmYzUndXcE1H?=
 =?utf-8?B?QU5iV21tMkJTQ251UGNkNEVOY1VWNlBvRStrWG5ySzhvd0tXVitJN2k3S2dw?=
 =?utf-8?B?blpyVU51dERZRGhCVkZMYXpIUWZnckR5Y1B3SlZpaTRoUzBNZ0xETU12UDRD?=
 =?utf-8?B?Q1d4bjdmNVZKUkExdWVtV1dRVk5HSFFmRXRqM3E2bFRWdHlZcEZSSWdSRW51?=
 =?utf-8?B?b2V1bDRETTI5ak9TUUs1TkVxQjloVEkwUGVWTjkyZ2JKMzMwZFp3Z0p0YnZq?=
 =?utf-8?B?bXVTTHcvTkZ1aXh6ZzdmZ3BNTFZhaG5McnZFS3RMYys0QVJRbUc4M0pudWtl?=
 =?utf-8?B?ZUl4R2ZtNllnd0o4UGEvai82bHhWOEIxUnpuKzNLQTM2aHdnOFFFeXFSRGRR?=
 =?utf-8?B?Z0pENWJsNlc1RDVuQ2JQWDlaeDBCVVlKVDNQd0M5a0doVHFBeHIvMzl4K09o?=
 =?utf-8?B?aTNBT2I0RlNWTXFDbndyVnJHdUlqQVBwVHkrclRORnJJVUZZTlVHSk9FYkZs?=
 =?utf-8?B?Ulh0SDJJQWdENG00Wk5CYWJjMWVRQkw1ZU9aeHN6YTVtZ2ZoSUtnUjc2V0oz?=
 =?utf-8?B?Rk1XUElSTXdJeDhZb0lxSzFQYzZpSm9iZWpDblpLbmZEWlpvaUdoNjVBR24x?=
 =?utf-8?B?RU5tNU1pY2ZIV2tuV0JoNU5GbFhmbmMyY0cvbXVvcmdhN0lETWpGVU1rRVdz?=
 =?utf-8?B?bjF3L0NsamxsNE85UGY2R2oyQ2xZbXo1NDNMUHJSQTVSTldTRkowRkxzOVRw?=
 =?utf-8?B?NmdJU0NBVnZqZVkwc1NoNk4yRExsbC9CLzE0SDF6RTYwNklDcnJ2WFFWWW9q?=
 =?utf-8?B?NEZTMDNxOEk0c1g3S2FSZXVGWU9aU2QrMDEvY2Nlb2JsaHhSZmpsTWtkSXpl?=
 =?utf-8?B?cnZLR1BBcllnc2VrVitFREIvOEFrUDE4T0kvOExlUWpDUjBpRzJJckpNL2lZ?=
 =?utf-8?Q?OaFfIIVYA3i5+5krxNHStRJtL?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b487f2-bba7-4a96-1e3c-08dbc8d5267d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:40.4064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwcpIZnpEal0RlhZyfdIEkDC8fOTV5C3FHhFOaXYv8xz3tG9KGB9SO3tG0RhWeBwdLXeRmkj4kkqjI1EyheMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735
X-Proofpoint-ORIG-GUID: y_LQto1zcIvMOOXbGcqFwyxCT-FQTDle
X-Proofpoint-GUID: y_LQto1zcIvMOOXbGcqFwyxCT-FQTDle
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
index c9961db1c9..ac58b35d44 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -499,8 +499,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1762,8 +1762,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
index cd5e1afe60..ab1b86532b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -319,7 +319,6 @@ typedef struct RDMALocalBlocks {
 typedef struct RDMAContext {
     char *host;
     int port;
-    char *host_port;
 
     RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
 
@@ -2475,9 +2474,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->channel = NULL;
     }
     g_free(rdma->host);
-    g_free(rdma->host_port);
     rdma->host = NULL;
-    rdma->host_port = NULL;
 }
 
 
@@ -2759,28 +2756,17 @@ static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
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
@@ -3368,6 +3354,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                                             .private_data_len = sizeof(cap),
                                          };
     RDMAContext *rdma_return_path = NULL;
+    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
     int ret = -EINVAL;
@@ -3383,13 +3370,16 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -4121,7 +4111,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 }
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp)
+void rdma_start_incoming_migration(InetSocketAddress *host_port,
+                                   Error **errp)
 {
     int ret;
     RDMAContext *rdma;
@@ -4167,13 +4158,12 @@ err:
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


