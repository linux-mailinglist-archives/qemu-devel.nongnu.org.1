Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16136738487
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxbI-0006vz-Fg; Wed, 21 Jun 2023 09:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxav-0006vM-0P
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxas-0000Ie-Qp
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:56 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LBvZp5016036; Wed, 21 Jun 2023 06:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=paCUBhbUMNWDZYh1zZiN71w1Giy3EYP5vM0Afk+0nOo=;
 b=Nduk0DezFsQIzkS0eEn4FSepNSJm9HPmKFswDhIe/jrFGj/f+I/sKIcfyDsqO05NHgzP
 pGBt0vHU9nZMyly8CRNeufcE7yHGWv22oxjpYLpHi18stIRvQDggQuWO569RTtle62/R
 /uEk8iSTY3ky5tXKCgKTJW4sDj5Bo+r6nToSnaXHVdPcaiy1LXwYE66jPgOkodcA41zP
 NB7ykN7ympYKn4eapUk/F9AJ7+1cydwgaX4iu1w83G1N0GtoJsQhZRrFs8lFTpMLVMb4
 HLwjPL8TMcYJSjrOFwgTlW7sj+TEKv7zCO69mvFL1By01E/8OH7lr4DzD8gm2zX8pRjI FA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r995rfcdq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 06:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQNa88cKwUdSguUgkhWHXjX7yf6fCPncLxuJSQLaXiVp04DavHBk8k/dBpI5L9ILkmwxZf5ZXZMK+drzK4b6kaLQy2nqabDzdRr+tRBzA2vPmAuIhof3yIcJuApKyCMPZ/r4MMBg9pRXX5cJOk38xLWRFzRkTR/6tilLHaJa0oiDJTsHE/J4iQNQfeILJZx7EtEL6QxOpq0t4cPOkjTZnBnotDTzNyX5xaNhWS+cF0vgAjTQA7dw5F9X/7Np2Jj6ccGOgSgeW4ch1pBJ6qXudYCOb9d+inl1bI3S61fHEZRt+JaO/jh+F5jIf1zvc7JYWnp3xNR4IqoG1u+J4uv2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCUBhbUMNWDZYh1zZiN71w1Giy3EYP5vM0Afk+0nOo=;
 b=h/O/PJ265EyYeCoKl6Ulaq7nGGrD35Yrn2+5xoqHZ/bl0qSacY9X1gX7OQuksE2BwwYQiZtxPz8dP/1PcXCGnb8C/gASjF8g9DyfE8o6dqcu1X1QBpytY9fgZW9hTa5ume4bQDaVewkKhIOEVAc55oXn3IwReFml5tqZpSXF/eF3Rn/4gumRQq7XV8BRoenU37uFBFGR4FT74fhQDbHeuTfTcvQFx7TNLrahU8D8puagKOZUwMp5aNemeqIrCLYFVyEI0vx1S1f2LYuZ/fge07vfO1p2MvcHkp+T3janTiDAR7K0id8ZKM+g/4vZzdGiXGLJ7ujTkfEh+wFYR3oqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paCUBhbUMNWDZYh1zZiN71w1Giy3EYP5vM0Afk+0nOo=;
 b=t15/AAATRuGoWVgCDT9cwotO95I/sRv9H6YGln8jnlRF1HMDg48E7ZzBfCBBz1c19AnVDq7jjREphnC156Zp+5LZLnANaPmvTN+U1+lgIYcRqe9MYL4EBEGMr0OvacEE10UgIAd2dDSbmpQ7JtHN86tPupI06DnlZdzOJeSw016GQX3NaOUnxJZ4e3ZBErZq6xAg8+x1uyjA0L7WSprCWlQHN/3Wgh8vDOyiLFboj1lHuHWV56ySwYZ2e6obyTehSU9gWvhimtA+q3xMbYLZKV9pUGBLX+KeFpxGJ6OsgG1rRo9m5Cl/B1bhaLSqgAcQ7s1fD/xW3D1Pc7ZUACZOew==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by IA1PR02MB8897.namprd02.prod.outlook.com (2603:10b6:208:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:09:49 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 13:09:49 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 1/2] migration: Update error description whenever migration
 fails
Date: Wed, 21 Jun 2023 13:09:39 +0000
Message-Id: <20230621130940.178659-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230621130940.178659-1-tejus.gk@nutanix.com>
References: <20230621130940.178659-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::16) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|IA1PR02MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a385b7-017d-448a-22c5-08db7258cace
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzIBWLa2sPs1fSl6xr5o5Omy3DrStkDa5lEvfOrmxfPUOlMhoyguEPXezrjqmj+j8KFdgitx74W8GlDqKULyH2M2A2BfuKIDmqVE0BOTmFs+IjTPLlkFuEM8MY2a/j+tCivVi7bUHUNMeUcsX/BSAdps88XYeqskI6q9TQAlMT9AwiwQNS80ykBGKR3Xga9eIyL9Swht4WfJAlj9Gd8cUbR14olWpvxdWt+rVXEGHF5WAbS0AKBTJuCfLstgS+CLFA337k0fCYd43T1/99xaXYmPDKx6Cj2MTh+IgchcDjPrI0fbNyu95jZJ9eaU2JUGrhgQG0MMJA7M4BXVgnVTMKhIQrQ4oPuzwqyiXuv5H1nlAbk6nybJmd62Ee6kkShxKBgbsnj0ysAw6D6+NboTS333NcQv/5O/s90i5oRZ4jey8DAt4vBMM0SdxKWQ0odFwDjgRSgdUSdDCFprCwn4W2yLBLRPOFecyMLND/uD+GarCJ5u78dcAWVFGcU6Mucs+TQEWziVwmXMTHTynY4BisC3jnpfS7paebu3Vqv5pbm/kIU+1EMne2moNbIdSXJ9KPct4wkUD/1o73D9DhEGzCQcfXClvKcxY3xV2TGNfew4o9JRTzzB4J8ft1sKA+Qa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(36756003)(38100700002)(38350700002)(83380400001)(478600001)(6486002)(52116002)(6666004)(316002)(66476007)(4326008)(66946007)(66556008)(2616005)(1076003)(6506007)(8676002)(8936002)(107886003)(41300700001)(6512007)(26005)(6916009)(186003)(2906002)(5660300002)(15650500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHk5ZGhkLzBDYlNtY0cyS0NadkM5cjB6OXZPOGNHeXAwODIvUXlNaEVoNXJa?=
 =?utf-8?B?VjJXNG5VbUJ3WCszSVREbDR6K1UrSlY0Tmh3QjNDOWxEV09jS0J2OHRWZjlk?=
 =?utf-8?B?SHVXb1pUcEwwWnl2L05KcGVNRkU0eHpzUnFRR1RiUVNjdlRoU05xei9pOEFz?=
 =?utf-8?B?NXQrQzBTOE5lM0ZoYitGeDRqMzVHbWIxRy9lUnRvMC9YMmJBRmYzRnNnU21V?=
 =?utf-8?B?eCtjWmdhRlYrd1JCUzd6SVczOFRscXhEeFFFdDhhSitSUTlrQWtIY2ZlU25E?=
 =?utf-8?B?RGhnb3dYSitScmFaaTgrYTlPS3M3TFlzV2FRNThHano0bFVYWWNqanRLZ1dR?=
 =?utf-8?B?MGxDbWxiOXhrL2laTVc3UktOejhucG9Ld0l2K1orWUMveEVtMnRjNWQ0U0RC?=
 =?utf-8?B?aXlUbXRzNlQvdlkraFMraXVLbFJCQlBVSnR3S1pwRVdpYll1YnBuWnZ4akhE?=
 =?utf-8?B?cSs4MzVLc0lRV05SdEVzRUFmYWR0VjJhSHMybk5oQXlWZGVWbUFIZ1NMdkR5?=
 =?utf-8?B?Z3NjdERqaXVkOUZoVDh6eGJJQmRPYjIrSWJRM1pjSnluaVBITlE4aDU1Q2Ey?=
 =?utf-8?B?R1NnYUd4ckt1MmMwQzk2c0YxWWRkS05MNkJMaFVIMHd3SnlUbVdCUTlvZlhl?=
 =?utf-8?B?M2ZJVExIQVhlUmd2SDZlSk1jaXRudjRBNyttOTNKTE9WeklFMEF3L0NPQUxB?=
 =?utf-8?B?M25Tc1lrQXQ2Vm9qZmhEQUF5QjZScCtWb1hpNlExWmhkVWNBRHFjVGRhdGg0?=
 =?utf-8?B?SjFkaUtqTXJBbWRVTlRvbVdRUHZVQ3hnL1RuUHg2SmJPVzE2Z0toWk5vRmxy?=
 =?utf-8?B?cFlvWUxoMVBCdEtMaHMwTHU5VW85NXg3dDYzSStVcno5OVp0Qm1JczlZREZu?=
 =?utf-8?B?c2Yrd1BScG8vbkRhbnRPUnJ4Vk5XdU9MZ1MzdTl0VkprUDF3bVJ2M1Z1NmtV?=
 =?utf-8?B?aTlOa0pYU0N0OW1GekROTldabjN5cXRZUmJIbHVHOVcxQTJKaEw2UzNrTEtM?=
 =?utf-8?B?aFFld2QydG9lSGI2K2UwaXFpRmpKNUpZV3o0bFVFT0J4V0h3NmRZVzg5TERP?=
 =?utf-8?B?cTBoYUdHYi9yUnB6NXd0eWh3S0JhZ1JTUUNkZFZHcktjRlorYmNRMjhiSGh5?=
 =?utf-8?B?L2hwb0ZJVHp6MWMxbWRWdFZhQjVreDJ6dVppVzk0SVdnWWlwNUd1ZU1QVWpa?=
 =?utf-8?B?NWkwVVN1emRuNFIxK2gvOWRvYmsycmg1eHN6LzBERCtkOWk0SHVrWldrUlZv?=
 =?utf-8?B?T2svV0NQbUJzWGtjRXBpZkkvUzZ5VDdEWThtdytERnJFWFlOM2FVdUVhcmFO?=
 =?utf-8?B?RWdMempDZmJYMDFKU1d0cTYraEo2SzROeWN5Q2tSblpSelJNalNDNVFSeG93?=
 =?utf-8?B?WGlZNzB3WENhTVJzSDZ6NXRweE9FUnl0VUc0R0JneThNWVZiTVZkc2pra3E3?=
 =?utf-8?B?MTVOUmEyV01tYm53QnRnN2tKZnUrZUl6LzhHcE12UE1lTldTdkFTdUZ4YWFp?=
 =?utf-8?B?M29pZEp3UVp5UHZOT29aMzUxYVA1b3RpNzUzV2ZEaDZ5SGJIYUtsenI3dnlJ?=
 =?utf-8?B?YjhyLzl3UjQrNWQ5WnhOZkRzUC9YNWZ0em9sMHhWbXQra2tId3BmdDlXc250?=
 =?utf-8?B?VFpLeklVR1FXWE5Sak9qK0FOR045Q1F3aklkVnVDNE5hV0FmdjAwVkM5Qk52?=
 =?utf-8?B?dDFSa3BHZDIzTnVYY1pYTUR6MkVTYkJHSHUvSXFMVmFQNThUVXpCM2hxRDFE?=
 =?utf-8?B?ZDA3bHlES09ybDZRejJaTnA2ZndQcUtTeWgrWnZjQ1REMjVzYWdRaS9leU85?=
 =?utf-8?B?cVY5YjQyTzhTTUJFelJuZFBwd1MwcnZlcXhYb3c3QzRkRkhzQ1hPQmh2bDF1?=
 =?utf-8?B?QXA2NDNtMFVWZUk3UEV3RGdDQUdSQlkrbHcwc0RQNTRLNFRDRW5yREZwL2Vh?=
 =?utf-8?B?ZEpGVUYyOU9rcnpqYWJGeWhOb2lvRVpUSFNKbEM5NEg0MmE4MzJudHRhZ2g0?=
 =?utf-8?B?RldoQmZLUVJzKzRpdlcrK01TckxTRTV0RTR4MUJWUGppUC9SYjhlQnpMVE45?=
 =?utf-8?B?Ty9NM1RkYzVWdmRKSVpTRWZzbklpYTlMelBJejMyRURna1lLSnJRUkRtTWlG?=
 =?utf-8?Q?G10OoZoc7OtHoiaRit1Zlp6l+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a385b7-017d-448a-22c5-08db7258cace
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:09:48.9466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHQWH8sN8mY4lfRPAOUfM0JumDTn/HXSHnCLUI6uEfTF+V5ebt7QR9MScfv/es/Z2TLjFor4k5p/U8Ra6fM1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8897
X-Proofpoint-GUID: LoBXr7WQFwhtO0bCb9Y7hKVAwpra--nz
X-Proofpoint-ORIG-GUID: LoBXr7WQFwhtO0bCb9Y7hKVAwpra--nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
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

There are places in migration.c where the migration is marked failed with
MIGRATION_STATUS_FAILED, but the failure reason is never updated. Hence
libvirt doesn't know why the migration failed when it queries for it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/migration.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea..64fab2273e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1666,7 +1666,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
@@ -2053,7 +2053,7 @@ migration_wait_main_channel(MigrationState *ms)
  * Switch from normal iteration to postcopy
  * Returns non-0 on error
  */
-static int postcopy_start(MigrationState *ms)
+static int postcopy_start(MigrationState *ms, Error **errp)
 {
     int ret;
     QIOChannelBuffer *bioc;
@@ -2163,7 +2163,7 @@ static int postcopy_start(MigrationState *ms)
      */
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored (pre package)");
+        error_setg(errp, "postcopy_start: Migration stream errored (pre package)");
         goto fail_closefb;
     }
 
@@ -2200,7 +2200,7 @@ static int postcopy_start(MigrationState *ms)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored");
+        error_setg(errp, "postcopy_start: Migration stream errored");
         migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                               MIGRATION_STATUS_FAILED);
     }
@@ -2707,6 +2707,7 @@ typedef enum {
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
+    Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
@@ -2729,8 +2730,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     /* Still a significant amount to transfer */
     if (!in_postcopy && must_precopy <= s->threshold_size &&
         qatomic_read(&s->start_postcopy)) {
-        if (postcopy_start(s)) {
-            error_report("%s: postcopy failed to start", __func__);
+        if (postcopy_start(s, &local_err)) {
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
         }
         return MIG_ITERATE_SKIP;
     }
@@ -3221,8 +3223,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s, !resume)) {
-            error_report("Unable to open return-path for postcopy");
+            error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
             migrate_fd_cleanup(s);
             return;
         }
@@ -3246,6 +3250,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
+        migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-- 
2.22.3


