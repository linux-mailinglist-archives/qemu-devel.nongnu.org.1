Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00627B795B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwmi-00051s-ML; Wed, 04 Oct 2023 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmh-00051T-91
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmf-0006IG-Eq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:07 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3941oatD003447; Wed, 4 Oct 2023 00:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=fLO6hk3Roz9vgt2MaQo+AnpyTmcwF5smrc9idFflU
 pE=; b=Li/W4ANHlRx0VbpExoimXQw3SDb57uozxc3999jGp7tZ96LkQiJUwETuJ
 HW3jhphCNgRVW/7JcUtj8rhlYKjJPvhtUEANYx4nvK9g8HEn++EZrCFbQ/PAClWb
 Nj+ecN4kMvyOdqhacocBAJC5pdzKio8gYpskX1ofNg3uILpjxhCWjAH7o8MhgNMV
 ec+n7x70/xt8tZx8FhwHTQZbTjddPfzMbIYo42MgCM0MeUw6suuC9B2mIm7ErHbB
 4imhtX8unxh6DRzDuQVjDN092s6fIZrob8omxWCKBsGPgkSPYz6UjpTGG47Uq9HG
 STYn1CLJtAsDcX6IVFRrjdtmEiuIw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3teh77031v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyRxTVk4PTeNAlLB7+pnu+lMjMUXfwyibyKtM7I8XZ46WAWmRYrmVqjwl1GBojykfkhysM3wojbVdcuyf1alhgANmB76INs6Tg5OkPpOp42UuXN84YYN/FEzYkDn/HTCGWURFmtUMux2sXV6d7g85F9C3bWapR6rkM0r0bkMOBr4x5E1Hm/tS3KRbXuwBfMEbDXUAkWMjHxg2mWzeRScM2rPPKtVTagsXTklW+V8Rrp7sreQGFvQtNVfXFRVH33YcRSysH4vBNqH5r4tsHGT7jUZ24xgmiamIkhxcamsD2O4OQlFXAuxu6k8qXPmqczI0+/zM3Id7IvTgaulWYWEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLO6hk3Roz9vgt2MaQo+AnpyTmcwF5smrc9idFflUpE=;
 b=frp9NHXgGM68Vqt4oNYAnEfy5WNqoX5nA89h3Jekb9ZJldjYoWcJcbnaXc7hHxorehrjiZw2Y14I0tS010foq+7wuAG/3CHk6C4jl70/0uEnGfT0UIZikQzhlh1VUbvO6GYmF4fddmLmLDrw40I7czkl90ZzFJzQzxBUiD17RIqlMxwrnrG5TAgaC9WUFPhDe2Iby+M99KqurGIqC4iAtM6GsDZrPueNGZPOkoPp0kUQRtxUe3YQOpCwx2Ua185T0Z7MdSOA3NtBLDElnRRxE3/vlaVWBQSNfQvKRqSXyPCkgVNdn/+KPCjcD/iwNb2/5b99lyidnl+nu8jGXc0bnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLO6hk3Roz9vgt2MaQo+AnpyTmcwF5smrc9idFflUpE=;
 b=v1Ltlos6J9BGdbXNT+B+1oQgiw8DiechdXkE9L8mBs4cPi/8/18SXytYI1QBY1RO+n3aePnY3WMDGV0I4/woAHw4DCBznDnn3wgJglaLh03tq8qJbt11yXjUM6OmzfMVDhi3eX2V6IjMRTkNGyg902ZocCZpM2zVSC0wzT5WtCOiZdz4rKc/6qNWZGtrWgElSPNxP3/NGoXIVIgD+/iYQmctrOxbiFKmwIFs1iFGjka4ZEyWtmFBq4odMRVtwiSJGf+ktLtBXYhS8jd9kJqF7a027aNGF7RCwHhRQ9RNJVbAF7l7dh+ifkbZ0oGTa6siWh9gQ5uEdKSMpMTPThEF/A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:01 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:01 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Date: Wed,  4 Oct 2023 07:58:43 +0000
Message-Id: <20231004075851.219173-3-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 956a8589-b8c1-49d0-05b6-08dbc4afc5a7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fF8hmporsD126NtWOeat5COla4SudvdiLSYwM4CIDMryrGox4BhOv4BKpIdDjyJd/JYUzi/nISOLwO9JeWqak+WHW3lJUe3V1qrI9506w0x00m09glaaeFmGXhz5WW14gTIE6x4+ORdDaCscgln7J5rST7nuhQxxaNl5gRRy2pwP4ATprv6jpp0bW8xMKiYqT33HTggu9c3x3Bf07NlNzuE1Xdfw0A2/pGP7g9B9QkU6fJUCWxcY9+S0yfC0yObFEdWbQM0Mn0/tGf1un99or8Nq321DBJ6mHKSjYkjVC1sd7pBojqFmIaWnsxA08KoudtwXpGBG5vEcDBa4M3Izk9vy8MBObYyKCZQwRcVBnEHf2D/2ZZHbzCoHQKHCNFOWgap0uSN0/vIovYKGOR9m10fIt91RShTj/BsUUnzi4AclZIrJ5nKV+pF0lQ1+zA9tshPzBqexYh+SdmjkbukaZlcmQ7DrDQ/XuzgxnKrvQO/vZaz9fU0IyQmVzEj8Cl21pjBHDg4Pdm/TXYvmRY1mP59OeAEM93rUq0ZK+jlGP3QwzysiCFE3ebr0pIBugUSykkHP6Z+VzvqhKYu5iquLYPQ2eZcZwzBnFgPKAp3Y0XPPJEiyvbIFAIq38GxPRt+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c04rNkduN01MSVIrL2tmcVV6RElyUlJPYXVGZjdZd2FSbktLZnRPWUdKMkk0?=
 =?utf-8?B?UzRIRnplNHVvNFBsLzVMOUpMNmRyYUplZlQyNTg5aXFrNFp3V0M5bEVUUjNu?=
 =?utf-8?B?QlZMa1JFZ0U5SEdaTlBKcHdIUE9HamlpWGVmOXZYTHBGUEd0N2svNmhUb3hz?=
 =?utf-8?B?elZOazBZZ2dsUFhKS0d2cVZ3eGNhQ0o4c3VQVGpoU0R1Y0tXbUR0WmM3Tzd1?=
 =?utf-8?B?SmpmbXFsaE84cE1QTEcwOXlvNlozZHMvTWt2N1Q2SGRvbFI2THp0MVdoaFBF?=
 =?utf-8?B?WHYzcnlVVklXQjRoQnp6REdxcUxWbVRDQ2ZiMXhyVFNPU3FFY014QU9pM3J2?=
 =?utf-8?B?MjBLeTllSGNTQm11djRpMHF3eE1FZ2E5SEJhY01aZkZCZFVKWHRYbHRWRTl6?=
 =?utf-8?B?WndBMHltMUsrbE5ocGNLTktiVmZQZmJwcEpzaytRSWliT3NxSXZKbG1QeHZj?=
 =?utf-8?B?VWdpdkxDc1V2OHpxRzhVY1c0Y3ZjRE9IUEpxTk5IMEFtOGlyeUViNWJ3eWI4?=
 =?utf-8?B?Zi9OUnd5TGJBc09nR0NpYlpLeEFxSVR2QkNWOHhZOEJNQXBtVnN3NjNxWkJl?=
 =?utf-8?B?TUZnYkJvZmJKQUZlTnozWXhQUmdUSXFSM2R6NWhQTmJLekN1bTVsVDgrKzFD?=
 =?utf-8?B?cTZRRW0vdlVwMjFTZm0wd0JHWTJ3aE1sUnZYN01pNGw4SEJMQzFFaUl4enVZ?=
 =?utf-8?B?bHJ2amUvTzQxTTlGbGpFRWVhTlVyc1JjaXNRMHg5VXpWWlZsUVk5WmZhcXMv?=
 =?utf-8?B?L0NQbVNlWTY3bnZrbVhWTDFORTgxbktPTktoWUJGWC8zK3NvN2JuZ0dGRXZI?=
 =?utf-8?B?TkZ5Zkl0U0g3SHl3TE5RLys4NHhBdTB0aTVGaHNyeUlrc0dlNnZwYkFLaEZ1?=
 =?utf-8?B?MXdQcnRJYW5hcnRjNmpXb0J4ci9XVUtvNDVjcjVpQUo4ZG1ZOGRHQVNWa3Jj?=
 =?utf-8?B?NzFIbVBwbDFwYllHOE8wYkFMNEhoa0crMWpycHRqVUhCbE1nT281NkFvRFZq?=
 =?utf-8?B?anlITmFoems4emQwelh3bi9PWjNKMEFXak91b2t0bjQ5SGIxZXkzNTZkR1Zy?=
 =?utf-8?B?endibUhML2NoaGw0TWQzRmRPeXQwdWxsdEtFUUhVd2UzcFRNTktrVENsWGU3?=
 =?utf-8?B?K3Z1WmllNkNXMXQwdHdRcWk0MENuWGlEaXFDcEFIQnpkcnZkaDgrVkdMN1RS?=
 =?utf-8?B?cm81cVhUQ1NXYWRBVm9TUGhFU2hZRnIwSGhqYWt3ZGJIeDQyb3NkWHpRc2du?=
 =?utf-8?B?MUM3MW9jNW5WTWhRcEVJMm80WU1sZENqMDJFZ3d4RkJnMVV3eEtYU1JPNnZN?=
 =?utf-8?B?RXdWdDZrWTJ5S3A3UDFhdGtuMVVpcm9qaC9Pam43VVpEem9jQVNBVVUxWDNq?=
 =?utf-8?B?b2t4NHQ1MGdncE5EQkVYR0dXNENwaVdoZG9QWHo4RWhrOEN2K0hlcWFGSG5I?=
 =?utf-8?B?QXc2aXF2dzFKT0JIdzFLK1prdERyTUNVTFRXYUo3WEoxMFVBai8xRi9rMjdt?=
 =?utf-8?B?L1AwNVRRNldsd1pxT3BiRGxiN3ArOEg1ajJGOTh4eDdGaHFWbVRrYUt6VFFQ?=
 =?utf-8?B?K3R1TTBFMHJ4QUZJaGhneTBWeCtLU2VmWFkzY0dEeGcwU1lnd0tqZUZaTXdG?=
 =?utf-8?B?NE00TWlLWE5ielpyN3FHN2JOczc0bkVWNjdaYS9UWnNtRHUzZ25nUDlVd0Js?=
 =?utf-8?B?ZGR6MHFUR1M4c2NST0MvN1RYZjk3a285Vm1qWUJFRVVmc2Zsb1l2TVdQWExY?=
 =?utf-8?B?eTE2YzdzNXU4aElvQURYWEdWZlJCZ0d4OW81Q2dsT2NTSXlrVGRDeDNKdEtU?=
 =?utf-8?B?SERiYnJ1SVV0N2NneW5wSHp4ektQWlVtaTFYVk9jaTczZjd3TW5HUDY4K1Vx?=
 =?utf-8?B?dURheGhkQWI0SUF4N0VMejVMSXZLMkgwSlZzNVRnZUtPbU55cmNBbjluc2Ju?=
 =?utf-8?B?MWRwWFc1ZmdsNmVqazRWWkFpMEJKMW5LRk5lZUZ4MDlIMDc2aGlLbEhNNUV0?=
 =?utf-8?B?c3Q1M1RDVkJURFVZcTA3Z09pcXplU1RqbExVY01OLzNLdnBIQlRhSDFLOGk4?=
 =?utf-8?B?Tm5mUkd3VGJLZmFMV2hrNE8xaXFFSXBRS3lNeXFoRTJkQktWOW5jLzFtS0pH?=
 =?utf-8?Q?wM6F+2CdRGvMG/gcTs/RkeYTY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a8589-b8c1-49d0-05b6-08dbc4afc5a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:01.8623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRJtg0c7NpNrDeqLzn2tO3BVMYNh16QiL+REQjjLEadCXS5/P9ITTV7JNQXealGsYxLDEJJE913AnL6BYN2nWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: HzRDUnkURFhqGB5QnAyk_QJ1G_wewo7h
X-Proofpoint-GUID: HzRDUnkURFhqGB5QnAyk_QJ1G_wewo7h
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
index 6d3cf5d5cd..dcbd509d56 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -65,6 +65,7 @@
 #include "sysemu/qtest.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
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
@@ -1671,12 +1721,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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


