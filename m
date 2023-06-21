Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19766738488
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxbI-0006wL-NZ; Wed, 21 Jun 2023 09:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxaw-0006vb-5n
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBxat-0000Io-8Y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:09:57 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LBvZp6016036; Wed, 21 Jun 2023 06:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=0a7suu59iKV7rX7K2o3+g6zCLlzwUrLZca2ffDapaZA=;
 b=uMLwqXb6mz3aYiUVJpOOQ52Zw7kglKek2ZpGm8kvtCx1vbYImW4NiIVzSAIKLhZ7x7Kz
 4w5yx5libBjnWBwDBBwDTWnJoYe9gYzgd3VPO73CX2a4DXd9J64YLLCp49Rq7uG6j+do
 +W0xdOeGc8PUY8YSo6wN5qlQ1Azrc4IyVDWKijQH9Qxy9wtMrPoM9FYbijOgTHf3ch+U
 ZmherX5h+5nW27GHXNOC237lqAIjm6SxsFumIMISuMvLJhZw7AJCzS45oOR4bJYxBmNn
 n2YeSEKppW9xqqDiOVyuse+TKTT/tdE2Peydx+juFzzAa3OyI8KWgjJcHNN4HW+0NOWE lw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r995rfcdq-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 06:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm+2FvWQxz7u/qwN/7lcp6TC4qdb/dwZwWz0Sp4aGpFFL5/G3aPqYmDOZKsdtXs604P44ZQQZMfy8KNSuKsGpU4snp1288qi5789U10TA0qhPuh1D8aDZ18WcK75NzQgYGYON6aYIQ0tpvEqNpHHHDdnNEy0I8UBbq9Nqor+vbPUAR3iLBUqtSRKWDVAXJ/bv1FV6i1bfLaEpTu0SmvmCAcGmPXKeALKP6frs1LLK6LL4kivVCTNOa4yR1wh7ERIgkCii0IRu0tOGSaKs8z1v/YkYmmE/EhHSCuuIXHYrmZL1Lu52zL3pATZCpAZaU4SisyuPGv0C5FfL8YTGnHGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a7suu59iKV7rX7K2o3+g6zCLlzwUrLZca2ffDapaZA=;
 b=kgF0jDfpT1t8RMh4i2KH2ZApl6TAykeHeULh1jzv79U66pcm1kT3ivZdgTh1FuphScUdKqT5in4Cz9J/0g54dNZLrYYjI7qUzaEGRve39/pykwFKx2+EwVOC8owMjdkLPVoMYT2XfPHthI+BqbSFBvJSPEGUha3mkX9lHVhB2ybSTI9PVEaIOgZdRYkXbAY6OMHZ33HD49fcMoA22fXj84it1LSuTmcxHdoN6Fbsgv8HLShKVdXhoLnd8lFElXNj2UmHE6V5t7IwEulGA2ZzrLDkMHiYI01gSRasM4tHLu9cQLdyxiavmtwsWjq/0UWQCDmU2XI8OtFTBZm0wpwy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a7suu59iKV7rX7K2o3+g6zCLlzwUrLZca2ffDapaZA=;
 b=byKMMtMRIGywyOkN4PHzG4uakXMPQFTLs1DByXMs/B0sT9W9+kTgG8Url2VnxGO6hy/7CBKbD08RaTBCNKQXQhXk0rRqXpo4NgclO/k4HPobwKpC75DPnXW27hoSBEwlwM3gJN8fgez7ep6+4dZvf/cucql+OdJi01PcdxzISzIB0TElv2oDB2hP3Alphmz9pPC375FYqT4SwCheTxMXcSxUI6DtDp/ddHV+WSRilDsD22aJhOR2fATmR7NAXew+YDmbPwhGlj+iMinwF3lZJEd1xhCyy7KYMemniIOzL6MH4uQpUWxsKmzBYOAOkacj3PZ+JB/HmQ8L2Y6FA/FIHw==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by IA1PR02MB8897.namprd02.prod.outlook.com (2603:10b6:208:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:09:50 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 13:09:50 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v5 2/2] migration: Refactor repeated call of
 yank_unregister_instance
Date: Wed, 21 Jun 2023 13:09:40 +0000
Message-Id: <20230621130940.178659-3-tejus.gk@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfb1dd82-b215-4eec-5837-08db7258cb26
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqzNXUL2MtkBTOhCj4kdbz7tcZcMHb7G40kn7but3VKJPcsO2bZarFkjYtdJyCOSXjPi+doXksnhdXltd1Npb0nErBCFN4eyyv6C2eZj1UF+l4DDwgoDrdokamXPnmQeXyE3kUTDrJU/8/AVE34lDiWK/gox1N07OcdBIdRpfMH038rZ2BYYLXTCiCINxkMvPg8PVGZOx3W3H1avNt1s4gbE6zAy9JsHZW0q2XciD8R1uG0vXC+Nj0B0LGEhwNyl/In2xHazehJwZfsIZWrMqwF9ZOUiLOPleTrGxquw1BXrjYEaYIMvRqrrMkVK9TfCh56PX88cL/HnQKuXRqwsqBXhVt6YMDR89t7RwlhaZnaZmo9rGtwg2DDIYkrm3CVvAPGRLzxPbT73FJtidi7FLj/9+L3GWUl2PMwrCKjv1KD9Dv6ULUguYD+iXQgd7b1JbAlwVkGQRV4txpN6CRaA1cjAA2OlubcakN8pvssSwbEF5ihm2ZfqaveB8rG80JYyLRtzCg/73ND63PVF66iOFVlhAPaOwqKD9E9+Z5RrHx/0mbp8u9sSkAIpx42klPC7e9D04ZjncorrboyA2aWZmJCTZdCYsyPQ6IS+Ki0rH1Dt7XtfNiDH3Bqe9kIBhiIF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(36756003)(38100700002)(38350700002)(83380400001)(478600001)(6486002)(52116002)(6666004)(316002)(66476007)(4326008)(66946007)(66556008)(2616005)(1076003)(6506007)(8676002)(8936002)(107886003)(41300700001)(6512007)(26005)(6916009)(186003)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNDM2ZRRm9hQXJQUkc3WUd0dENIemJDL3I2L1ovWThxcnBuUnpYSElWMk1a?=
 =?utf-8?B?cTlBaS9VOWw4Rml1MEEyYWtmYkE0bGVnSllMeEpWeTMzbEx3MGxEajRSS3R4?=
 =?utf-8?B?d2Q4akJ2SVJQMXFWVkZZd2FFdXI2ZWl0VFJxVnFkMVp4U3J2TmRXcjFUYkJZ?=
 =?utf-8?B?M0NQSDlyMFlwVmZLTXJJYUluT3V5S3F3YWo3RTZXLzhVdEYwVVFYZHJQc2l5?=
 =?utf-8?B?MzJOZG5PSmM1bGpsc21uMW5PTXpUTURFUktJMUNDZHBnQkVuemNEdjZZOUxi?=
 =?utf-8?B?U0VYbXNaNTAzN3BwU1RCY0hNTjNpNGtlVFpraitzeGNVQWl0UHp2RW1WdTlZ?=
 =?utf-8?B?NlpFcmxhbnhGSWYzanlESm15c0RaVGRJQWd5NVh1bGEydVlZL2hjNTczZ05h?=
 =?utf-8?B?cWJmUE5TQ2l6QUkyM0ZETGZuNkx1QU5NZmUvU3Y3Z3FSRlcvWnIxRUQyNjBX?=
 =?utf-8?B?TWlzeE1kdFVxRzR5VmN4eWw1N3MwWngvdDN5RDVTcTVhQ2F0Ym4yUHMzSjJI?=
 =?utf-8?B?WjAzYzQ0bW1zdk1ZU3daWjdrQitVeW9MZk1sVERpSVQ4ZVBUbFJ4UlhMb2FN?=
 =?utf-8?B?anNObXFtd3FGQnhMQlBneFdCZjQrazd1cWFqbE1mV3NLVy9SU1lXTmpRaVNZ?=
 =?utf-8?B?NmxuUW9qYXhkWHhCTTJOZUZTYlNQUHRndXMzK0xKUmpxaTlNRXp2L29iU0dK?=
 =?utf-8?B?SmZyTDJ1YU1sa0dWMXVRM0JKZ3lTUCtOcGhITEJSR2FDOXpMSUMyQUZBcE5k?=
 =?utf-8?B?TVJoM1cvV0E1QkRpdmJWQVpPc0E3K0JoemNZaEhqQk9TTUJLSUl2UlBtUWVj?=
 =?utf-8?B?WmFoR1l4NWhjZ0ZiaTBVMGVhc2kzbktsT2VQWm1wOUNoK3dTdWZNTk1yMnFl?=
 =?utf-8?B?b0RLNmJ2VzdveFBZTDRRMDdETmhPRDB5TC8xVGlTeG5wQVpSS3daSW5zV2tl?=
 =?utf-8?B?RjhBNUhSbk5nUnl4cmdWMWljVmxPUEVjMUh0dmVLdUVaelZKY2RRWXkrR0tN?=
 =?utf-8?B?TURlRW5Pb1ZnajdEMUZoWjgxTHhTTytDY1VadDlCQUVSWU5tcVQ2bXBZdmFy?=
 =?utf-8?B?T0JRb3J5MDcyOFlSZ2JvVXdZQTBiM3EzKzRtcGx4eHN2M00wbmNwcHFGRWt5?=
 =?utf-8?B?V2NMbW9CRTRsbVNoNWIyRFdIOElGVXJnRXlHdFJwYWF1M1hsNUQvUlhsUWVq?=
 =?utf-8?B?WDNzdDUwczJ0SE8zOHZKMndTcFJzNDBnNUlXZzhOcDJ5bnV3N3pJNThwS1dW?=
 =?utf-8?B?d0dTY3YzZXgvaFJqMXhYeEJzVTNlTlhqU0d0dm9EQkY4MW9QazZMRWlWNDZ3?=
 =?utf-8?B?YUQ0MGlrNWFYTCtqcVlFV09Zdi82aG40V2ovanhFWkN1QTlQdG1zRVBZSDdO?=
 =?utf-8?B?VmJsRTl2K2RMNks3czZiT2RaMzZuL056bjhuazhRVEpxT2NSenIwWGJrYW5O?=
 =?utf-8?B?QU9sVjFBeDBEaFVqbktaTW1sRWI3c1I3Nis0ZlNZZnpOdFZoUXgyTHJ4a2Ns?=
 =?utf-8?B?Tm5zS1JzVnFINlZ4V1dkN2N0NFp1YjFjUk93emd4cU4xdmt2OG5oaURiNm1C?=
 =?utf-8?B?QW5MN2ErbmJuRkkxZWl1enZ6S2ZMVWRXRnozeXk4YXNTUy84K2ZaY0tZVWFt?=
 =?utf-8?B?UjdyMzh5M0tTanViQ2c2eE5kM0dFMUk2UTgrM0REeXRjTXN6b2VCbDA5L2l3?=
 =?utf-8?B?UE9KbjVQWmlWTWk1dGN5b0EybUwzeGlwVUo2WU90bXBkUnhES0tneE5sZ0dP?=
 =?utf-8?B?M3FzeTFSbmVHZnFhRDdjekY4UjJ3dnFvRjVqam1vN3N3UE9qcTlhbWFqR25J?=
 =?utf-8?B?TTZublBGYTd6Z013QWhWSjRRVHFkbmgxVzM5bzlvZStrU1R5TjFCc3N4SE9t?=
 =?utf-8?B?dVFUYlJoUWVkVFVwWk5WR2dxNlFwdHdUVytmbTBETVZubzh4eXpvU3EwMkRP?=
 =?utf-8?B?TFEwSEI3L3BoWlVoVFRVcElPNzRwT3dFLzdSVDZyM0JsdXlIY2U0YVNBK3VN?=
 =?utf-8?B?djZaN0tZZzNiOG1UczNjT3VrbUxPUkxsUGk2aVVDL0lBZjRXNFdodlJwWXZE?=
 =?utf-8?B?MnZtdUdJbVcwMVJnUm4rYmV1c2VzTnVaOWhhSlJsb2F2VVFjQThkMC9zeG5Q?=
 =?utf-8?Q?bE8UqAJN8gQxzKCJ+3fQEiy9r?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1dd82-b215-4eec-5837-08db7258cb26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:09:49.6107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMRt2donil5hm7874E0fZF7nBuK8+PSw19KCFqAptu0xebx9OMla27L3G4TLeF/IhWKS8Y+MSxeyfOnFLuD2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8897
X-Proofpoint-GUID: S4XRv_o3BtufbvHek1uY4qN7__Out0nb
X-Proofpoint-ORIG-GUID: S4XRv_o3BtufbvHek1uY4qN7__Out0nb
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

In the function qmp_migrate(), yank_unregister_instance() gets called
twice which isn't required. Hence, refactoring it so that it gets called
during the local_error cleanup.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/migration.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 64fab2273e..a9186d78ca 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1663,15 +1663,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!(has_resume && resume)) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
-        return;
     }
 
     if (local_err) {
-- 
2.22.3


