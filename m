Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9F7C7119
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLY-0006IM-Az; Thu, 12 Oct 2023 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLK-0006Fl-Dm
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLH-0003f3-2a
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:16 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C6aYlY010625; Thu, 12 Oct 2023 08:11:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=0RQrFi90qvf16l9cgoqtlDkVaEFsqlVt0Eiz3qAJA
 0U=; b=c+wJeAMtS5KEr3KJy4qvTraaMJAhaXfj5QmesLH5lYbRFskUMpEX+sWHp
 eztfVDiHH9gDKTkg2wiigj+LVS4lIRm+VPU5O0i8kWSlARF7kQMR+Zwo1OYq4mul
 nFAlg5DYdjQGKXKz/v2fFosOSYErXz2iQhsFxJhb2vFkYH3JTV8iUxrFob8hNDwJ
 ZhdgbRS6t2YjLlVWSYMWczJT1IQDRqAXcsXEVzuMCuR7RPrUiI21vro8EI1bq0QE
 mRn2RBuCG6kbGOrVUclibfgC+qMtKVrMF4p5Hyqs0XYR80VLUvM58ke/THL0iS1L
 ayFiVpuRX95AI9JLizQZxXL50/8fQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv0bhrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6ASYtsCkWoGJd+iBigdTz2CxeN5TPEAulURtXDnlUY+71mQ1u4Kb1q9qeCE/M73madxOmXUdaDLapYTJtWC1d0RRBlbwrZqjGattm9H4oXDW6Umu8Ze4km6aqvLM/0eWwqBU4Y8XpDRigGIr3jtCvlvVIbAeZLTqT5lVPwEHGHU5WBk1ahhGqHtSzjgKdHc0i/oHUpPE6YbWtXM3j8GlnNIlCaUXzImIG9R68uMdv64NHqwzoOZeO3Wk/vVRKIoRIqSBM5B7MrfWuD8QtFKgSekmBhdBYuoNLGzpkP1i43VdWex6Jj3UUGZlBtguBG6pCcy5xIxigq81kbzpMTT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RQrFi90qvf16l9cgoqtlDkVaEFsqlVt0Eiz3qAJA0U=;
 b=BxltQQ/oQrYcFqfoutZouKu7YHVftHKDu0FqskB02zLa8hC75LPzbvxTF1bHnMc4dxM//3FT6icfZgwnbN6nKcA04Hn0KAFCGVZ5osEEU2NVIwci4w9cXdmRwbnKscU4XTmWFlOygpx904PVP7Pb1n7bzuN9q1ME78FAeO/fOLNEc5qRo2BpMVr9KtCwLRrr3h7NghuEQWytJ3mFF/L/E0lQkkagkYzp5GNXomqJ2Rz+IpGALbQfG1ciGEByv5yiiyUxdQPWmvW0izg+N29tskWAiIkzC1uXcSw2QsSnYvgxAGA+nzg3eqYiVUaYdy5Nm21KSKO0FKJxdAZGSTPkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RQrFi90qvf16l9cgoqtlDkVaEFsqlVt0Eiz3qAJA0U=;
 b=ZZSZUZukeiIsx+vwav9pGuUejUXR/OXQ4qZvM0IDBXnieOVZLPzl2ZMEsMOg74isli1GmQlFZc6zEPqCakx6HxT+27hx+JskptuMwCAEEdXDPSS0nZQIWVX0HawYF12Vs8/sFouCx3Gm6bikLVyVLn0P/lwTu22gGFyKEoJi2bqBfbaeYtTZm0c7rS70eTw1x9EmWVduujMW1kp55Eikjw1z3RcoYUNLHidlMSGV2mr0WOPJgVjRdcu/bAwLg1gNZnqYaWK9ecLGiGrQm2VZcOm/n7Zwb9N7Cat+mw3+qO+X77LaGcOZd9IFH4lrl5fZIKvXGh3TsgHVydAXT+X1Fw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:10 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:10 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 03/10] migration: convert socket backend to accept
 MigrateAddress
Date: Thu, 12 Oct 2023 15:10:45 +0000
Message-Id: <20231012151052.154106-4-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cf9b201-c4af-4b63-8309-08dbcb357765
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpOgQu7f6n6UMBpZmCglK8ttMQwyx5eLcWK+Hgz0H8haOnFlu9OLleXi2+6AdHzLe0pnz+Bjbde5BZS49FgnDCbbLP+DytxPo0LdZyXQtIJXUBzk0StEuPov6CzbeJ7KYwXUeeWXnZeK8HwgOru44semYptHCQuRMFzyrveqV2ke6RnfDdLL4OshaTizf0fq4231CKXh78CWeplZsFSn8JsCPdMQ2C7xw9m+DaGcqFPcxFvHbip4qCrZVN9xOmC6YTJsnpm/8fhN7CILoiCUAbAbSTVvHzM9gMDxMIs0zxZF/bg/WRol1V1gcioOfDqeeFGyz4T7b2nCzhBq5/Bo5Cgt2ck6j1SeokbpG2GNZ+3bT+NIINwkrGXgvrf59jfLTTdFBKg5swy3Juh4o26ixCT3hk5r/BFB/CjCZhEJRKuETULnQUuUvemJZeAvfz30/5nKoTIoIJjKHmptyub48ctVVJ2W/z628V9mk4xnNwFormoWR6rfY10l4FNvu8NQtMrBMVGNvGPnEqdoA52PF2Gl48jktZsbOXX3MLUZAEFqZcv7aX7lTDpVhsCzovf7ij5JCG5jwpEy+MVwXhm8jRjUZRacA/aDslpMb5xZ8aI9GRrsaES+R2xO+AkAvOh7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNUb1krZ2FpcEpmSDYzWWxGaXpPdU14bjdxa3ZVbTAwUmY1TkZPZ2piRUNV?=
 =?utf-8?B?emphRlZzSmR2NEJlQVpXMTBib00xLzdvbVR6VEprc0tjbWpFcHB3amI3Yisy?=
 =?utf-8?B?ejBlVDAvRmg3Nk9zWHpIT3Vja2FlQkRkbTdPb0RNRGJPTmhXUUJnQmtwQUJY?=
 =?utf-8?B?bmtmUjh2RXNFSnozUStrVVNUdlpJdWs1dXpGaDBCdlFDU25aZFBUbWNqbHJz?=
 =?utf-8?B?WjZkajVDNkE3VXhhdGhTWjNBcm82d1d1azdXdkdVeG5pRkNVQ3d6K0ZsWXd4?=
 =?utf-8?B?dHBGTDdsaEwyU1J1UmJmQUZhYnhOWFV1SWZWeW51QkVja08rQWNLZnRmYUU4?=
 =?utf-8?B?a2xUMDNZblFhMXhwTVJVWGF3NXVwWXlkNVIzdWNEaEVHS1dZcXQvUjlkSTlZ?=
 =?utf-8?B?TThkb01hZy9RNnJZZ2JSSjJ3dXNnc2RxQWR2K0dENFpBOFhydldlc2c0TjR5?=
 =?utf-8?B?REQ4a2VwRHVVbzcyV2FKUkgxdHBPSHZBUitLTlg1eHgxVExjTGpjOHVZd041?=
 =?utf-8?B?OFl4bHFkZzNFc2ExbStuT1NrZFJ3eWFrRzNMMXVidFlRYUJoSkQzd3lWN01u?=
 =?utf-8?B?bWppRlR6Z3M0Nk5IazhkNHZCYmhPTDhGOWFqWU41b1hmcEI1Qmd4cGFya0o5?=
 =?utf-8?B?SEp1bWtuK1QrdU4vajV4MzV1M2NBY1d4UnFsVHB5NVJlRkNKZTR5dHJnWmtj?=
 =?utf-8?B?NW1lL1lxcXIweWZzRnVhR3BIdUtRYnZONll0bFhHeVFyaGU0bzlKampoUlBp?=
 =?utf-8?B?dmxmd1dJNHd5VFY5bHhaazlDVm5lT3NhUUhTaG9nekxML0FjT1lqZ0plZUVV?=
 =?utf-8?B?VGNWWC93bFFUYzRRcnR5QjlZaldJc0g0cjZTU3d3WTNTcXhUVFFxRW5lbnlo?=
 =?utf-8?B?b2ZOdlp4VldkdDJkMURra3lYQ2VzcVAydVNCdFl0WG53WjM5bFovT0V3TTRl?=
 =?utf-8?B?dy8rS0YzQWl4TFRhRUVUWmoxSzNGaE5Md3d4bk5SUFhja2VUdVdHemh2MnFi?=
 =?utf-8?B?ekptQ0FjWFNBbVZUMDNoaG5kek02dmlFcndpU1EwdnA1OXlSS3BJaUM5ZlFs?=
 =?utf-8?B?N00zZlp4L0svYzl1Z1E5TFlwdENzRm1mTXNseGxyZzROQ0toU2JSdFFvaDF1?=
 =?utf-8?B?NGdoZUVyMVFleUhISWVULzFWMk5MaHM5MUU3MjFaNTZWTUtpMTVXTlZ5Y3l5?=
 =?utf-8?B?TmtpSDVOczlqNkRKblgvc1NBTHcwMWZXdC9aT0k5TFZsZ1cvQmRuK1hwd0U0?=
 =?utf-8?B?b2hPQmUvVmpraDlWMkkvSnI4czBaS1J5cHBLRm1yMkdqM3pQUlk1SkVyTWJw?=
 =?utf-8?B?U1pUQjd6R0kvd1JWeS83bmV6OGhFSjdoZ2p2SWRQUks2WkphS2tndmdWOEl3?=
 =?utf-8?B?K3ZYMlA0OGtJSndBZ3R4V2o1N2pLc01TVHB2ayt3K25yakROWEFnQXFPZ1M3?=
 =?utf-8?B?MTR5dlkzUnNtODFldk00eHEraUJaTkd0RVJyeGZSdUV2NFI3eGJQSVZJTU5h?=
 =?utf-8?B?a2Jkak1lNWJqTVl1Q0hDcy9PSFIzUm5FbXRtOTFRcGpWUi9kZ2tydXVreTIx?=
 =?utf-8?B?T0RReEFXZ0Y5L1ZYYVovMjltNVA4R05VYldzSlBaTDI0ajkrTEtneFdISVE4?=
 =?utf-8?B?YU5qa3NLcWs4U3dPQWs5M1ZhalJvem82bHRpQ2Jqa2wrYmw4RU10L0srMXpZ?=
 =?utf-8?B?ZkhzdkxHUHpTbWlQQ0NtMkF3Nkk2NG9kZW9wcWFFZ0RrMnkxQ0ZDd1lWSUtG?=
 =?utf-8?B?THI5Q1M2alNqanYzdGV1TjJxNjIxMzZ2WkxwdmhMWDUvRHhtN2tJUXFJSXpw?=
 =?utf-8?B?dVBhYklvQVNRT1hoQ3Y1UUZyS1NieVhIN2ZPQi9jUFpNZndlSkVBc0NJdy9I?=
 =?utf-8?B?ZkRxa1NJanVEcUdSd01tNlFOZC9CK0dKbnh3RktoZTBSZFJDMlZSQ2VjVjFh?=
 =?utf-8?B?NXBxdnNtTm8rU0QzYTF0TER6SXB0MHdhU2pwSTIxSG90OWtKb1dwQ0NLZ1VT?=
 =?utf-8?B?T2pKUElZMTZ4cHQyUXAxYVdrWTJFSHhONENJdkExSXhST1JseUIyRkxiRzZm?=
 =?utf-8?B?WDYwZHF0Y2dkRlozT3ZkOUx2TWJCdTRJLzVVcWhzVzlqL2hOQmxHNy9IVmUw?=
 =?utf-8?B?MVc2aUlLNE52T0UwR1lHY0RQV1plOTBmazdNUjRmcXFpSmJqTHBmUEtVRExJ?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf9b201-c4af-4b63-8309-08dbcb357765
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:10.1875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL8woClpVDCPiLy21WdeZ3eUmvwat2grwDfGGRkAbBS2julSO2MpFgbURT21yCUMJ7b+zefgbweVkbJyR0daIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: oux5vW2xt8p248vIjoUdHiwenhz2dTiu
X-Proofpoint-GUID: oux5vW2xt8p248vIjoUdHiwenhz2dTiu
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++------------
 migration/socket.c    | 39 +++++++++------------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2637c76364..66eebfc74a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -492,18 +492,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1761,18 +1764,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -108,19 +110,19 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
@@ -135,18 +137,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +162,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +202,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
-- 
2.22.3


