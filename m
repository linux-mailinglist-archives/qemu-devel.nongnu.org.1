Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A837B7967
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwml-00052V-9M; Wed, 04 Oct 2023 03:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmj-00052I-Ls
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmh-0006LT-QS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393LGSKU032747; Wed, 4 Oct 2023 00:59:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=c6oFabAP+wYuvMZdL/Z+T9S66JD22JQTB27gciVbI
 Mc=; b=nbBKzxNmsNkRLK3th5XS22Unq2wvGElhKqoq5Kx5wzoOnkYPhTCgDJtoP
 EGBkm9zU9hMZvYark2mWpuDzB5BlF0xbOPKu4UlMna/WBNE8BYyLSiq2X9cXiGYR
 k8zH6ecSNPHc50hPnNHkBeIDzikKPBv6dC/76FuV4QTtixYuwJHcIyAC2AmYTrej
 NuJZvohttnEEhlwwFtITPlzt6Z22qTiYzkPixrCERiA2rk5oqSUPqLahmzLDg0up
 XkuESL9bpm2by/1qKXs+VH5lv9akEA7x/6OVDocfQu6QjS1QTaIijQKFJiaX0INv
 zu91x9yg27EWRmi6/Bq5S4lFAEvdw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh77031x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm0/Yl6uNMrhCnSL6sJ1Oh2Au8HJkRf5P223icJXiTZ6i0QvgBDZO/c/dWSgYP11r0TUj/qJWL3kLBPIF14IohQ6r7bZshW8JRdXTYBOteq/TT2lXsEztt/YudK8Ka4Q/m2fw9DB07EXpOBkdAStzegNwzpIxmvAbFrOpsG6WbJiwa6Dge7feNcTRwG37h3hU1lsWZ+OUmZQ/pn/PzV6EvaoqcOQXSxL2qC6LlAM70pjkrm3tSAw7CtS6dAk7uSdPBDhpgKURh3N1lhkM6okc+pxaLLswndcGdhdgaxyFebZScUZ7MgXaZqwxxYWLklue9q5FiG2agbToAtApZkwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6oFabAP+wYuvMZdL/Z+T9S66JD22JQTB27gciVbIMc=;
 b=O1U4LCY9/VA0pQGptR6fnW6h58uZ6roUvt4YGTa2NKFhuPx84C3jXxJaq3xqLDneoToU2YuY68phlM3NOcwuAYYXW020hKQNTrOMggCwKiU1ofZ2d9g7qHCdKVL+6qIXdVFBGJSa7Ou8R1MxWiI63yxWIlXZ1Apel7I1+eTi3puOgk5RvrqoiM3ytjs4R3IKCkI3tFGCMOBOXUj5tsczRMY2DHcscNNIwGKrulc3L35eyv0FTwyAxExIsi6xE1G3YuEmvM1KrMaccoHax8kJIj6LSEom6WoYpKRf9GKhqR6XcVeIsx3BUn9Qmjn/YaM7SXbaiI9eTxk8YnElF8/Htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6oFabAP+wYuvMZdL/Z+T9S66JD22JQTB27gciVbIMc=;
 b=dNaizy8cDrfAsjdLNwbCcb18+jEjz6VkLRZQ+ER1VQgUM2vIqYGEFIt77Kf3oRuVF8XWIe1IhpJbpLmWTABBBvEz8mzgU87GBwPK6qxzcK6dWIazwfBtD2i6KMZ1hjS9obkdOzPMUAX15YFNSK8Iy+BLGvacFTcYEVSHiwp+XE28CXDENy6AvbbdXC1NAPBmuuhAyBxr6qybOLYXDRM170eRM/5d6SlJ+rxtpBZYdubZ9ANAXO8JzzkPp1fQAMFy07yh69dNunz5/ORbvAc9BlTO8wFWlwImrjC+S6kekT9jmOq+7JYsA31QPqtla0ugIt/kOzi4R9MLAhGtZyFebA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:05 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:05 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 04/10] migration: convert rdma backend to accept
 MigrateAddress
Date: Wed,  4 Oct 2023 07:58:45 +0000
Message-Id: <20231004075851.219173-5-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad309b01-52b5-4482-2270-08dbc4afc77f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/bOCQPlkbz/iXJ3ibCJRKYxWJ47F0r+aRuGwz0aIh/8ZNJ+Qs9305+kmboAuXQ/5hpGyz1HKuKt8DjrLMfXjExcA+MJ1zXZhHnKf6WPp2XByNFhicLvNHcHsm20oF2bupygUJWBNWqfPFPEbLHQ4ArbNwW9vDSJuBaMcdzibu+LjFklvUfSoNG7zeMDKp15yduoVc0Uadl1Q+7lX8PNE6FfBqvh0iomvEjZ8cKcX6m+jHMMCFDPMH8LcHHyDwyDuKp7C8ieIuL+1FEbObaPLbKnXi49tGy0HTQGAhZIofVC+nakzmUePQil96E2kzMmCiIasjdVjua0hHoWsper+oF1+GAvyo8Qg6ws42uLrY0tCvYk/BKZsjQoKGXEljz2W4wi0jIYYsEzsRPc3tLIEg3wyv9jC87IvEDmUiu+KfjY08MtVq3xl5dShjjNZzlDg+h93ZxNDGlCZ6Uu3bnn59eLYQtBbgGMXSEdQpYMbsMGArAft8vyqCI5PvrTyhjQ32kmIZmRXfa2XNdPH7w1iJhmgGsxN5WEfutIhnZlDT/6Q6wwzH1NQ7KlCUDooyMJJ+iM5pa6q+YvuJmC6Nyl0svQUyBwMgdB+k6GH9aFVrdXJrZ+4PaiKjZ4cRJ2IUMC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXV5RjQ1cmdPbExQTEl6dnNQbTAzYnRuRjRMOWI0TVYwenNWMmlnT2ZCRnBj?=
 =?utf-8?B?SEdSczVuVS9RczhRMmZTaW5QYTNIZEFtKzNmQmZSRlRTNEtYZitGbTJuV2tJ?=
 =?utf-8?B?cUY2WFpML2lnc3dRYXFWeVBBeEljUTFZZ3FVM056cWw1ZGJwY2NFWWFCRzdk?=
 =?utf-8?B?dEtMVXArQ2k2ZS9NYVJBS2hOL0dudlJDTmJnS3graFgzQzdqekRZUXVwVXBI?=
 =?utf-8?B?bThGTHRUeEhrdlJQajduLzZWUzdtSDlQWVBmU2tSTzlNNk80dVIwQi9aRGxw?=
 =?utf-8?B?a1JhTkpDUm9TQXRQOWRwcUNPV2dYUTgwYVRVdmc1b0hzRi9lY3I3b0NaejVC?=
 =?utf-8?B?ZkdUTElyWDl3NmUvcE1jaWlCNXJBZ2krQXJ3cjB0YmtPMWJpRTZDWlA1bHU0?=
 =?utf-8?B?ZnEybkg3NGZSV3ppdlZDcjhFNDdtNi9Oc3A4bVI0UlBRWkNvNXFwUlNZeVQz?=
 =?utf-8?B?NktuU012cVdPR1FhbW9KdmVRK2E0NUtmWVBMZTJQMzlxRnFQS2YydVF0S2Nm?=
 =?utf-8?B?Tjdad2ZpSHdQVCsvOHVPYTM2aVZqQ2h1Lzc2RUtHWVNBWWcrYUY0RkVaeXVD?=
 =?utf-8?B?YStvQk13MkFEYVNYVnZvOHlvMWNCUzFNWDl3QmJuQzArRkRtZWtKVDlVRk5Z?=
 =?utf-8?B?NGJTRGpsSnpwNGJOakU3aHgvNGRwdWhqR3F6UnVTdDFOd1piSGI3T21zUnR6?=
 =?utf-8?B?YVpiWEdaWHNBSnkvSnY5K3huK1Y5L2Z2LzVLU0ZDQU1XczlsZnlrd3pLV0FC?=
 =?utf-8?B?R0Ztb1J1UmxmNnF5cUhPK1VjbU9uWGtld3U3cngxU0NuZ2JUQ1lud0Ztb0Y5?=
 =?utf-8?B?K2U0UmQreDlUQ3VSYytxQkExcTR6SU5SQUdLblF2U2J0V09mbGNWbU00WEJs?=
 =?utf-8?B?TnpHeVlMV28vemhsTHRPNXB1N0RudTV1aWYrUG9YQzU0Tlp2Z2RBUnI4ZjZq?=
 =?utf-8?B?dkN6andLbnBGaXdhV0grY0dDRnZQY0hhVUZqQm9JK0N1dzcvTE1ISkp4NHZB?=
 =?utf-8?B?TWZmUWlZZUJWQ0EvZ2JMODBsak1NZWhYNmpOdGpubGM3eXBuQm1lWGUrM0Nh?=
 =?utf-8?B?T2wrZFlVOGd1empRb21oYWNCZFpZUDlHc0twekpGcjVLc1VHdlFqR3l5UFg1?=
 =?utf-8?B?VVpvV2ZZZ0RwMEUwSWVITW9YUXZwS3lya2RFa3ZyOG1rTXNneE1yUHZCaTlm?=
 =?utf-8?B?KzZCQmhyRGNSaFNHRnMrU2J2VWZxVmwwSHJza0ltejdsc0xwY1lseTZhRUty?=
 =?utf-8?B?TVQ4bHp3NDdObkg4eFBuVXgvZ2QrR0s1OGc1NlJsbllxUDlvNDU1NTcwajd5?=
 =?utf-8?B?dEp5OXFhS3o2cmgzWUpjT3R4MHRFeHJPQis5OWhUZGNkYmtnU0N2em9weXh2?=
 =?utf-8?B?aTBoMFhUM29VbTQ4b0lmQ05mZ3o2U25WSWw0emgxS01OWXJrbjV6ZVdpeDRI?=
 =?utf-8?B?Vkp2YlUwWXVPZkNqTWZubjhpVFA0aGJNQkFVbWdEcEdiemYycU9JcEEwYnJm?=
 =?utf-8?B?R3ZCdk5wZDJpM3pKSThJcTBqVTQ1Z0hlb1ZrbUdPTFI2TFJCeUh2NktDc2dQ?=
 =?utf-8?B?MHVydVNiNXQ0dWtqRWZVM3NLMXNxY2pyN2VaVGJTMThzNjVNRDYvR0xYNEh0?=
 =?utf-8?B?a3I0eGROMWRpNjlubjdsTFpEUk1WNTVDVlo1dU1lSW50Y0RVaUFKUGxHYWlB?=
 =?utf-8?B?RjFEa25wTjJ6bjZnckdvK0xyQnlabEYvTzhFdTBoblR2ZnM4cHBDZDY2Tjk4?=
 =?utf-8?B?eHIvSnUvcjRVREJjbGl3VG0zdUJWMGpNNGY5TGtXdWE5NDQ3VkY3Y3RqdXFT?=
 =?utf-8?B?cFdXd1VMang4eVRMZmZPNURNRE84WnBHMnFpMmhVWU8xQjRzcVNiOXN1cDBO?=
 =?utf-8?B?dUc4VXl3aUxBZDBsVUpuTGtLNlkrN3hZc1ZCU3RxdTBRL1Q1ODU1bExFclNw?=
 =?utf-8?B?NEMyRVJ5VzlhbWtvZWZaYUJCV014UENsd29wcE1ncWtMdzVwelRQazNaRDdF?=
 =?utf-8?B?ZW54bkVFMnZEWjQ4MlZZaWVWTi9LNVBhVTRXby8wVFQzU3VIMDVMZE45MUpO?=
 =?utf-8?B?U2JzMm03MFV0RGNCd1BlcW10OW01Slk0am91dFRqdVBJNHZYc3V2OFQyTnZr?=
 =?utf-8?Q?3fEOn71/6YURL8cm5RbMegAY2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad309b01-52b5-4482-2270-08dbc4afc77f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:04.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uBigKuPtdGDxLL5uSMAp3RCJlkdxA/JSasbhN7qm9V8l6r9qkYr5DmCrveVC42XgM8THdqtv7jomXcRWZ3Abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: B7J4qe_bF_9uTxcaAbEtRj5KVF8jPifj
X-Proofpoint-GUID: B7J4qe_bF_9uTxcaAbEtRj5KVF8jPifj
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
index b773f0110f..b41fda6f80 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -497,8 +497,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1758,8 +1758,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
index 7d2726d5b6..8bbf0b4c67 100644
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


