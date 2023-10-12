Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CB7C7118
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLa-0006KQ-5s; Thu, 12 Oct 2023 11:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLU-0006He-V1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLK-0003fZ-6N
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:26 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C8kUl2027098; Thu, 12 Oct 2023 08:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=B8CPtB8VFlLv7xK4hwQmmZb5gV0TH5eYMqmt4mrAn
 ug=; b=VyDBhOVyTLAs7wBbWng1qDD/zNcG6mdLcAx4tx+7jZPzYw+WgTLZWEsZS
 CqqE7kGjkI2EEqarsPK23rujvKjvQhS/VIyJkXpzNe44y9fKDijvwUvgSigXjQYh
 9LA/bR1uzbLYpi6dFbz4TcX4erFq7+GGG2zhWJwiIFZDky1RUYvwQyD34UOOKgY+
 MbaHsm+0myF7D/0pbBadU3SHa7/p7Hj/hmhqMnjPRNKZ2w5MiETiy8414U501nMU
 Ae422Eln5lV6SVZP0X0EMJxFkkQyW7I4LY6Jl/sIZpD+gAYIDtXVecjoG8QKa1WA
 iCzJLAemSlnH1T7Hvq3/RrKntIfMg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhu4ujse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSoSvoIXce5eCtMzHq+pM5z4GEoR60P3CnF7mM7fz2/v8PS4WReUynev8pR+H3msZi9PvWcWZxi24kgFnbmv3uPHju6BZhHqQTjk+W7Zbtm1eDQr/JpyKGX939Aw6Pu+E/hFDkfxqLUvBGFXk19EiM4WpCOTVSLUAnlvuGt1uMGAybWiow+N55q0RcSG6yeXh8F4X1ij2hdEZcM6uN104UROTc+Ec1h8iHeycIasX3UqVJmtodn9V9S8fJ4/W5vTk6y8gipPGqJHMsrWmj3yZM8KHH7WhT0PR2/K5wEQZ2S2SUsB5yQgspR4LxAPn9drZ8/H689OvIvopLr24H849A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8CPtB8VFlLv7xK4hwQmmZb5gV0TH5eYMqmt4mrAnug=;
 b=mqITf1v/E9FsNy1rgdMZAQK77UH6q41VCBV7DBQxN+pabfBLU4mFlo1VF5QXqtlQIHaFWeNeWnAKty6y8iTM5mKCQMxkVQvpPeP93PkSSvf2nZ/iSVc/r89yI5F7UW57f8SHAyd0Qsr7/5hcRQ3Ei0gFiu9aUf1In9Rb8cE8meNwv5bHyh3ElHw9Op9iMGe12k8xeFfz+4lgsT4thtMjyzUiMJIfFl/q/vtmM+gnz7B+65hqty7kcEQ3+Hn8/bciZH43IN4lxRId1OVJObRqu5r42wq0dmhbjJBGkeIrnItHApqemSuA7zhsPrkH6AIeKaxabcxrCL0OpIUpHCgHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8CPtB8VFlLv7xK4hwQmmZb5gV0TH5eYMqmt4mrAnug=;
 b=fqDqWXnMnEIbjz6HXvc246OrPdBswD3gHrMGS0FtUq1JgMfU93VzvZNtBPkw9emkq8HFsJFPdjjzzvCFsfUZHDkxOSB55F/L/7g27JzMjq9p5rjkVnv2/67/69S3EUQFEUO3FoIO8Fmbm8NmwtThqFyH1rdH5evul3zyCmVw0SEUTQHJ9HmWV2QcTg9NPQ9AVmVJ05Q4ZzTxQF8IHfckGR9qUeXaahS3kWpB9SbvjNh4TY/GWtUrd0kru7nyP15ufQYyeoGYlKf/8aS6c3XqGVAA4ezFmg2MW+qLjfipV3lSL1lDQKe6gZMkeCWahHGDjc9ZZeAeYpnG4naYW6V/Vg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:13 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:13 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 04/10] migration: convert rdma backend to accept
 MigrateAddress
Date: Thu, 12 Oct 2023 15:10:46 +0000
Message-Id: <20231012151052.154106-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a0733e-fe6a-4f2b-289b-08dbcb357966
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEHvTDVWgAD90XKbjOcc7Ya+uxMZs4jCvXR9jRZ8hq7qJxxlHnfvvHTcvOpvTDjBBL7B0KiOx89+ZhmxtkPo0JEoWQJ5JGVwD/hVoqtJ3f5IioUEQI0HuiLVlhni5QsENAzIDD/s0KR5RTcw4v0cgdzP6FcMyPoMfkUn0+HIHYexoS3orcGnV5L+XHqtdTp1mXY7h7WmlFSu7UvCgtlO0K65Tpn9ExW7CReDh80rkAisZ714p/NCXTrstumd5UPkiM8X9mAtJZJoc0knEc9AL29Fnx4CouQzbx9YGI1UFn6lckC4bRNgUCI+WUv7z9Qp7bwaUv5wBWIQG56M6GRd4f7fb7hwUwpL1mwabM6yWU6JQM7iee8jMcDBBuGX+B5aryVmHuPBk5zqdfY3+oY0+u7aSKCNS4Rn1ZIan3xVT1y8gdU3niP6rIG8VkMfkD+O3xJCj2Tdu3yP61IZ6yH1xDEBBS9sDp9/iLl1zYcwSAHBU3MobTDUhDKPdxKznaEd2br6Zz7p1i3zV76tMM4dAv0LdVhO0R7TYHxSwNzUv/w45qx+7YeCYZvfEfXhxx8jncvVQQ8JWy4IDCojcCTnbC+8Msyk0Kb2eJ1dYEPtgI2wgCWwb2z96D5sY8uGhQWK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmhFZ3MvSGRPVE1sRkFXSENjODRYVFRid0lUcFB3VEtULzRRSmRYWnNRUTh4?=
 =?utf-8?B?WGwzQjJqdzdvSkE4SVhvbmZSM0dZWG43M3k0M1RoRXN2N1p5TklqYkJ5ZlA3?=
 =?utf-8?B?aVZ1VGRXVTluU1hCSnVsOHVDYnBRdVNIeXhTTHk1N3ZGYkRpVWJOeUVXaXBl?=
 =?utf-8?B?SHJ6aTZqbzlBME9RN3ZaclF6ZVU0VjZjUUlCYlBkaGdkbnFoUlZpaFF3NVFV?=
 =?utf-8?B?SUZzVTFTaXpMQURHa3ZsM2EyM2Q1QjNoZ1dwY0dseUpiaThnOTJHNE1nUTFJ?=
 =?utf-8?B?SEcyNVBvNkJ1amhEczkyTFlFT2t4aklVWmZCY3VIUXYwZ1V2L0l4MjhVY1ZC?=
 =?utf-8?B?dHcwbWpZN3pueFkrYmQza0JnelhSZEh5V0Vjb0wzMGdpc0kyWkU1TnV4L0lY?=
 =?utf-8?B?UGZkT1IxTExoeW8vV0F6cU1WaG5Pa05jaTBNendMQ0JTQmdlVk5HSXlNa1FW?=
 =?utf-8?B?MXd5cFVmVkNOSmJ1NGdmVlNzSjAyS2FQTy9JSzhrQnBKWmMweHMySWM3ZkxK?=
 =?utf-8?B?bElnREI2ZGsvVThhRnhUbHpqb1FLNUN2RDNLdjVTUUFleDJHaEpXRm1FQUZq?=
 =?utf-8?B?Z0ltaDJsTlRMQnhxbjlFeU9taDNkek1WbGovTVVpUTlGdHV2V29DZWRNdEhV?=
 =?utf-8?B?RUNrMUVFZUJ1QUVLRzcwcFBycUFLRURBci9aYktOQ21xbUFvVlpWR29WcjVG?=
 =?utf-8?B?M0s2RDZ4bGlnaDRKM0IwcnVOdDBsMzJBandrcE1mdlZSRVBURkpESEJaemJZ?=
 =?utf-8?B?Y0xkMXJiclBhY1pYSklCSFQ0UWVJUnYwWm9CRU1BNlpQK011R2NPSDVCcm1M?=
 =?utf-8?B?VlJmRXVSNHFMWFllWnhWZ0UzaWl0WnU1SVJieUFCNlZ6QXE1bHBXd0R0NGZk?=
 =?utf-8?B?Y20vQkEzT0FkTmlFY1V1dExNdmltMVRicXNuVzFZTGhmOE5rUDhkUGxwb3g5?=
 =?utf-8?B?OVplNnllVW03bHBLc2VxdmNuQklaeW1PNDZFazZHc2hOVEx2Yi9zUURxWGxw?=
 =?utf-8?B?dWk1cUxvb2RUVU83QXNTeCszYWpFZ1dtOUs0b3FibXE5Q3FDT2tVS29Mcm1X?=
 =?utf-8?B?L1JmVmo0T2J1SkZLNTUyVUFuRFdvUTZoWi9RS25LZ2Z5LzZaTG1PQVRETmF3?=
 =?utf-8?B?d1NmMjVYbjVSeWRHZ3NCTUZOZnJEQ0o0ZlRjVmwwaU1IUHA0MmZ3LzhiN3F0?=
 =?utf-8?B?c1BxN2xwOGIrbXE0Y3JId2V0OW4zYVlkdmI3cVdlMFRrMnJINVlJMlY2SXN2?=
 =?utf-8?B?eDVodC9DMi9BR3daZXFTdU5pMWdTOTZ0eDBKUS9WTi9CMlVFb1NTN0hvWlJN?=
 =?utf-8?B?ejU1K2FBUktyR1pjL1V0c3Zpa2JlaHAxdXZ0MlZUWHFUdjd5V1dxZVBSV2hu?=
 =?utf-8?B?Nk5KWUlNZWQ5NnF6NS9wZk52a3RQY2hvQVc2ekk1U0FqOEVFaUp3TytISnBz?=
 =?utf-8?B?THJJclJ0QWpEcHJZTTVUN090Mmc5UVVlSWlWb1JuZ2orNGhJbHBSd2hsaWI3?=
 =?utf-8?B?SGN6d0dLS1FZWGFDUVVOTE1Jbmg2MkR4WC83SkN6QmRxSjVQVUhyWVRuZVpS?=
 =?utf-8?B?b2RVd0Z3MmxueDFqNCswZEV6UEcvMHJUS3dMendQVUp5RkhZVXBYbjIxQlhV?=
 =?utf-8?B?WUFGNHExL2wvQkhmUWpaVURYMk5FN0NtbjdiRER6QnFZZkViVlYrajQybHhp?=
 =?utf-8?B?VFRhT3VDdGdCanFNVDl6ZkFhemNRSUNjbEZHcUY1bkExWDZFVVh1c1E1UXNw?=
 =?utf-8?B?dUtMRnQvcFlTMWZIcitHOXJyK2Vjb0tzVk9LYVViS1o2UTljRHR0dzFodzI3?=
 =?utf-8?B?T0UyY2NRc1BFU3JjNjlweVUwWDRmUU9iZmFqdE1vcTZlcjk1ZlgvT3k4NEhh?=
 =?utf-8?B?Wk9LckxVVVRudWVMbEFWZmJtV2pYTXhETy85dFYxTDNNVmZWUUxVYnIyMlpv?=
 =?utf-8?B?aTlzTmhubE9hQ2ozYURTSDZFRzk0RXM0WWlwT1V2bGFyc0ExK25hTzgzZVZy?=
 =?utf-8?B?aWVjVWNxNy9LM05GVjJMaDQ2YlY2Skx3bjJxdUFpTnZvNWRWekVKNDFGT0lV?=
 =?utf-8?B?MzhFdldFNWRXalAxcjlSaXVMWWRhL1BJdjhpcCtCalBMM0VFREkxcVd0SUc1?=
 =?utf-8?Q?JHTKnN9RZxP4V2rtLz7W9Jvo7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a0733e-fe6a-4f2b-289b-08dbcb357966
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:13.5284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4L5YLWEHSeWvNlgtOUJQhuTyzd4qbp4W6R+GX91QRwzzXdHwRYAmNC+wUA35dJA9rNnzloyXVnKfNitEqa4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: gMAlKNEQ320EranwnExb_h4Yw4uEgbRP
X-Proofpoint-GUID: gMAlKNEQ320EranwnExb_h4Yw4uEgbRP
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

RDMA based transport backend for 'migrate'/'migrate-incoming' QAPIs
accept new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for RDMA connection into well defined InetSocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c |  8 ++++----
 migration/rdma.c      | 33 +++++++++++----------------------
 migration/rdma.h      |  6 ++++--
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 66eebfc74a..03b6deb45a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -502,8 +502,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
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
@@ -1774,8 +1774,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
index f6fc226c9b..db8ef110c3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -289,7 +289,6 @@ typedef struct RDMALocalBlocks {
 typedef struct RDMAContext {
     char *host;
     int port;
-    char *host_port;
 
     RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
 
@@ -2444,9 +2443,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
         rdma->channel = NULL;
     }
     g_free(rdma->host);
-    g_free(rdma->host_port);
     rdma->host = NULL;
-    rdma->host_port = NULL;
 }
 
 
@@ -2739,28 +2736,16 @@ static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
     rdma_return_path->is_return_path = true;
 }
 
-static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
+static RDMAContext *qemu_rdma_data_init(InetSocketAddress *saddr, Error **errp)
 {
     RDMAContext *rdma = NULL;
-    InetSocketAddress *addr;
 
     rdma = g_new0(RDMAContext, 1);
     rdma->current_index = -1;
     rdma->current_chunk = -1;
 
-    addr = g_new(InetSocketAddress, 1);
-    if (!inet_parse(addr, host_port, NULL)) {
-        rdma->port = atoi(addr->port);
-        rdma->host = g_strdup(addr->host);
-        rdma->host_port = g_strdup(host_port);
-    } else {
-        error_setg(errp, "RDMA ERROR: bad RDMA migration address '%s'",
-                   host_port);
-        g_free(rdma);
-        rdma = NULL;
-    }
-
-    qapi_free_InetSocketAddress(addr);
+    rdma->host = g_strdup(saddr->host);
+    rdma->port = atoi(saddr->port);
     return rdma;
 }
 
@@ -3359,6 +3344,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                                             .private_data_len = sizeof(cap),
                                          };
     RDMAContext *rdma_return_path = NULL;
+    g_autoptr(InetSocketAddress) isock = g_new0(InetSocketAddress, 1);
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
     int ret;
@@ -3374,13 +3360,16 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -4111,7 +4100,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 }
 
-void rdma_start_incoming_migration(const char *host_port, Error **errp)
+void rdma_start_incoming_migration(InetSocketAddress *host_port,
+                                   Error **errp)
 {
     int ret;
     RDMAContext *rdma;
@@ -4154,13 +4144,12 @@ cleanup_rdma:
 err:
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


