Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8870DCEC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RQV-0004kV-E4; Tue, 23 May 2023 08:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQF-0004gQ-6M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQB-0004bT-1p
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:26 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34N8Asth032137; Tue, 23 May 2023 05:46:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=uidLayVHGkqUp/Z9uXDjuOaz/NWr/n1hNkl1famAGHc=;
 b=bAAnfcR1dP5wZelEEWyyFBblAaczpxd46Xjg+FEvOUrK9mBnmr+VmwqQ/b3tDzipwu4p
 npU/2fNakfWm/KZxjENXng0EzYKQan6Fr+SCc7gNrfBpicHL2MaJWwYhZKdiabW8K07n
 PzJCofl1+2X6qv9FCO7UD/imoEdoGiB9LOvkGUOrmcbIvaf04nhm3OoVQDqYCOmj87N6
 kWNbj7ZCL4sWpcenWsbX083TJbwD2kZn1p0Gx0F3mgL8KqzclqNXP0kprNsV/VM7En/y
 ieLH4k5FzZ57ySjoWLeMUJCPE+noGUBRDbT0xFB9sJu9rjiXZ6yiMIAT00mx6eFD5hcD CQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpwhce0bv-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 05:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1vWiJ392I49yM1LzWnXOBlWPnhZlXrVgznmE5sX+OmjdEG2iAYGhDh8/Z5kzO1toUC2DFTkB2XdbJf8I3Hy3AitRD9xRdpnXcBMKXet3cCeGm+Zb3bLB850ZoNUfOcsrwhZZlANtbSw9K7ljwc8cXbUZwuHYO/r2dUk0aDgUO7xb9nfxEf5zj8anwmdmxMtYR6JD0+OPbe/Lki1/UUad0SHTKtZwQyZq0b5FhdFO744zW5HmzuNn8trr5b3hL56i2dbBYBjq7dZW16BvUKFDfIC2pFftXmQlHDB5xkgG9dhsVRQ4ZkYBu8EpNbnJL597LmxghF84+KyHvV9OQzLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uidLayVHGkqUp/Z9uXDjuOaz/NWr/n1hNkl1famAGHc=;
 b=gQ4zCWeruBXpOv2AsSuM1niNixVBqXuWs+CTX6dLclWOOtujbnvof8SG+d73qrFXymJ5N+/XsPAGF3+JPXYklYPze7kpwmwnyXbUmkUBREbfiVxObkEuAMvlk9a4MBDKmL0qxkEgyXkBIP/2b04bAvpa6LB86lqi/OlLEBmaS0SVluVaOijOQTyOn3M0ODFaQZRHWL0fmItS1CDmrSyx2l6AbSVo3LJUuziQM1vOmDmW/OqTWhp+uAgFJm/ZCIZUqaBsE+YHoF+/pgSbcGyi5b6yck8rWlaYy+TPoxde3mDnClyxORZc+7UTF0vUSBdCdBspAY1UhDgNNBX3ZgEffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uidLayVHGkqUp/Z9uXDjuOaz/NWr/n1hNkl1famAGHc=;
 b=y2OoOWfdRjSOWZENvFaNv50no708hwkZbL9Nu0u7GGiR0lTGuo4MQnyrhQtpJY4yth99J1qw0OmYfVB2n0JW50hYjp2azkFLicGZf1PtJjSRfGOhoFtyIZJ3b3pNobuZkTGorwF/PunPAMNYM03VefPvAHKKu6wQ8nyKunmP9ZEUeVp1knGG0K+EEj8pYXd7MQVjPpdlL9rVeeT6UbKr5a5CL09GFx4EAPC0QVUFdNh3HaWovS3fySXL9ugYBG/unuBJ2RmCwxp7ICEBEl9sk6czjlFlcirrlC8sVpua+i5kt1ZLEk9yDtlS3Or1rwSNXphI9vElAlGjM7GxcohlJA==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9516.namprd02.prod.outlook.com (2603:10b6:610:12a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:46:54 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:46:54 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, ahv-india-host@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v4 1/2] migration: Update error description whenever migration
 fails
Date: Tue, 23 May 2023 12:46:37 +0000
Message-Id: <20230523124638.16270-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230523124638.16270-1-tejus.gk@nutanix.com>
References: <20230523124638.16270-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH3PR02MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: fac7d472-5be7-41d5-478e-08db5b8bc8e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIIcBN8Hjy47UmKo6TGXKMI4swnzJn+vvGs3eI/O3oNBJ34F0KIu5OU1e4Zaz+3IrJd5j9hS1Qk6FSinnHRfjIUlWDoQZ0qUb6O8qCwXJbEMmnNRokvh1HqdDrPX5jRiWNVXpfH8G1iuiHf3Qd5/OWmwJ/ZMQfcHXZymMgLya+rDcphx4Co3YSSK4My5RfSE6aNJIEAQRKr79+ak8F7zw3x3PhxtzAxL0KQVtGmDrw6ch4Y4N2MGxlwHOYNdgqkYj3gsqD0IvlIHOKbkT+NZRMK0dQvULrNfbq4MhJzHCk1ni9McG59Q1KIl4d9RjqRA0SZVFq4xsppNOOBa395zeM/KWJmAwtzXl72LRCUHRefR8uxghW3LbsBDzdWXLIETV+ucQjSKW1A1FS7kO0rQ/5fiUlOaaz5VhXT1XuoBpQuOO/o2jCIfg5JZWmup1rpOeNfRp6bIDsYEmQftdZheYSVmbOdbu7+piJENWrzOJo+Z0Mbyv06WV3GyZBEzdQhF7X1yf0HREwwuGXA+/ym+xB42H7AdapXtw3p1sXdW/bP9H3pdgXNhwwlHd6qSmiE16cZiXB+LarhnkFORSelk9RZxgaSWTxTH5pXZIoAAl4Y9HmXG7YeeIeH3HOH2DeB0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(52116002)(8676002)(8936002)(5660300002)(86362001)(6506007)(26005)(1076003)(6512007)(83380400001)(2616005)(2906002)(36756003)(186003)(107886003)(15650500001)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(478600001)(38350700002)(38100700002)(6486002)(41300700001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlwVzJaazVQVGUzYWxZdkxLZHR6cDhhZDNaT09yNnBaRXRnK3BmN2FuRGtR?=
 =?utf-8?B?NitML2tkYmRGUGcwOHpCZjBLM0NwVEZQM0JYTVUzMVRLcGM4YVhidTVoenNz?=
 =?utf-8?B?MGszMUFiSExUOWFNcGhEcXdpUjZTYXErT2F4UHJnUndQUlB1T0IybnJrdTQ5?=
 =?utf-8?B?R0YrcG1tL3N3YjRmL04rdThOZ3kyd2hLazhwUEd0NGZ6REF0S1NBVWtIeWlL?=
 =?utf-8?B?STVnamk3VVlVaTlJUkcwWm5kMHROMkF1aTBrODJ6a1pVYThTZURmeU1jMDNF?=
 =?utf-8?B?cFhxMTY2NTZraFFCOUNaUktQK255L0lmN1NBVHFBeGhUZk9zOWh5R1FMeTJO?=
 =?utf-8?B?VFBsNyt5VnJDb3E4K2dETVh5NUpxZEJoTmFHZkhqK25jT010WVozTGs5dlJQ?=
 =?utf-8?B?Uk9OeE04NUw0WW9OQytWcGp1a0ZqaWNvZ3BXVkptcS9BSFdCRVZSRXZxVU94?=
 =?utf-8?B?eGVkS0N2ODExZTJCUUY0T2YrUERnWFE4TkFuOS9BK0pZTit1OFF6alpIMDh5?=
 =?utf-8?B?TmtzWnJhT3V4V2hoQ0VHalF0Z3BwVEFrcjk3a0RQb0F5Sk9SYjlsZDkxN3pn?=
 =?utf-8?B?aTZIeXo3WURFc0N1TFN0VVh2Y1VCWktNVDFDdDlXeERIMVpmUjV3VFlJRml6?=
 =?utf-8?B?YW1hREhrS1hSUERNVzZnbjE1VEVFaVVpU1Btbm5qZTQ2M0ZGbzhHWUNGUEE1?=
 =?utf-8?B?SFg4bW8wTkR1eEJZOWo5YnJ4Mk5BYUtjdFY4dHJHTTJFcjZGMlQ0UWViVUJV?=
 =?utf-8?B?aGcvTVNNemJKbEZmb1Y3U2lCUnU2YmlzZnc1dFBZNXVCa1NIRk1QOHRUNEI0?=
 =?utf-8?B?cmFLQkVpU3JhWEhwOGNPbHI3aGc5WUVWQWhuOEVqYnBFV2plZ3FhWloxQ1NT?=
 =?utf-8?B?TXdjM1hoSy9yMm5WSWNuU2EyN2wxazNVM0owSGFyUEZGTUx2UHdUVjFIL0o4?=
 =?utf-8?B?RUxYSityK21Oa3FkWjZYK3dOQkNkRlRhYkR3TW5RdHdabmozZGJNUFpYMVRh?=
 =?utf-8?B?bktnTllScll2bFVWdnFpMldHSVJIbjhkZk1oZFhDOU5ESG50a0JwL0pnRFFS?=
 =?utf-8?B?VmZqQlpIOGpyaTgwRG1LdTVWVzRpbnlOVlYvcmZRTjlyaFZVTWFjdi9XTHJE?=
 =?utf-8?B?SU5aQTFUTm5oejlCYXZocHFybHRMS21TMmI0c2oweVBvdVhZRWs3ZnYyNFlu?=
 =?utf-8?B?c01uYUFKK25Scko3dUswNWtLNmorNVlhc1hMekhQYkxpMHBNNXp4Y1c3aHgy?=
 =?utf-8?B?NEFVWjFxS3hpZkRpTERDNld0eGN3MmFXY2lGM1J5OGZLNHRzSXdtSWM4QkU3?=
 =?utf-8?B?clNwV3BaNUlGeVcxT3lJdmhQaXgxV2J2MWF3dUxGQ0MzcUFhOWRDMjdmR01o?=
 =?utf-8?B?b3p4WnhMdXZIMlpwbm5VK0NHZERSVEZKVVZJOGhKcHNuT0hrZWpReW5mL1Y5?=
 =?utf-8?B?U25rUFY3bSs0dnlheC95Z2dLQXZKY0RRSDgveUFoUGtMbHBnaGMzRGRyVkhP?=
 =?utf-8?B?dUZ3ZmdmeW5mVUJsRm1SQ1l1ajJlMlNRcEptNytRZm13c1Z1V2ljV1FOOFI5?=
 =?utf-8?B?eTNpYjF1SGxLUjhidVIyNnFQdFgwaTFleCs3b0tMelNVUlc0YU1YZWFSZW03?=
 =?utf-8?B?Yk1NRDUvR1ZlbXBSWHJ1RHVRM0NRekE3dElQdnVLSjJ5WWNkMnhLUzhIRWFP?=
 =?utf-8?B?SXhSTlJiQ3lzMWVyYkViY2dQb2o3Tjc4UlRWdUJIMWxXSktPeWoxL3JQd3RV?=
 =?utf-8?B?NjBCUkJ0dzY3Nk90QmxKcDFNbjM4Y2hoQTZXTEVYVDBQdXR6Z2VZT1BHNU9B?=
 =?utf-8?B?TFR6NnRVV3V0Uk8zaVdralpISFNrMkdtWGhWamdKWjR5WHArTWE2eFp2V0dr?=
 =?utf-8?B?MGRHNmw5WWl2cituZGNsMkxvelV5ZDZKd3BiSlBYNlV6TzQ2b2U1QzRuZVRI?=
 =?utf-8?B?TkFLRW91bVpOZmluUmo5UU9ReFExamErMjBMU2ZuTWZxZ01WTEdJVGxjK3ZS?=
 =?utf-8?B?SjhPYjQxdUcxUzkxei9iUkJ2dGtjZDdYelRqOVFnMmNjMGdiMlRqTnZTNGVp?=
 =?utf-8?B?eENPb3h3eit6b0thMVlPU051K2U2MjhLb0IwTHR2cEdvRm9vcExuTzhyWllv?=
 =?utf-8?Q?qb3ETOI09mb9Ybhm5AO6Vf8QY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac7d472-5be7-41d5-478e-08db5b8bc8e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:46:53.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g755RU6WxttdNhY5YqIhGeklvQ9ut6ZUw85OuJF5ASDnpizC5PRYCCS/MLxJUDnaOAJXiZBshv3GSoBfZ1nbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9516
X-Proofpoint-ORIG-GUID: haVZtxdNvJ1xxJ6rUJnINYUxyP1a8YBv
X-Proofpoint-GUID: haVZtxdNvJ1xxJ6rUJnINYUxyP1a8YBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_08,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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
index 5de7f734b9..161d4e9a71 100644
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
@@ -2714,6 +2714,7 @@ typedef enum {
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
+    Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
@@ -2736,8 +2737,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
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
@@ -3223,8 +3225,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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
@@ -3248,6 +3252,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
+        migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-- 
2.22.3


