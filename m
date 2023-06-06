Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B83723F20
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjg-0001ai-6q; Tue, 06 Jun 2023 06:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tje-0001aT-LS
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006Mm-M6
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:18 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567WVsi006549; Tue, 6 Jun 2023 03:16:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=doLlW5QKg+3iGve7PXCO+9X7V+IaFgcwPQvlkEes5Ac=;
 b=M6lIMb0VCsO2BSNYrI/xVkCix56M7jY4DgEM90RUVTnx0cMyZQ95faCtwZt+S4IEu1Rq
 8OZKb038R+q1oQ6Q0uN0NoO7JqDf3GzC1OGCnOOOI286JT2Lrxh/2htauE/neOzIKRfg
 GjN4Fx9ctxa7g2pjYDbGSFf4afFXQXuZD64UfX6bKL2iGh9X2Wb5ZuL/FDmmA2Ka4+kM
 wxMCcnawzDeU4nUxhRqI4Rl/3a0QPN04NClhABMOKRcNxua6y26WAtwIBG2rhLqbNuxf
 Dgr+jK7/KnuEsy9EGWbZMQkoMZBmzGss012S4oGJdNy7tcs2m44UUo4ixeRSoqs/Sd0h eQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnCS/NSNDCldmkk4zWpCuSLuJqgyA0R+rvOupEnA8YzuWPFcy2IngXrOyZZ6G5Vimt0Pu27eu4arswk7KOOmkmB18IaRTsduJmZt4mf29ioRFjaUGkNUHH7sabUoUxGH9NKKEDktl6R+WcIpzis8sdarY3UjYnSYGRcGz/09GiWkI8TnQ2/jm41wq+mD5ch18prLcPB9Wxeo1F8YbXVAEzT/SqyYtWYD7oJlNEeQrL9jHtEmbhoqQRxo42dwWc1by8KlOMASkDGYnXKOOOPjekZUNx4U91C3wsigCyfG/nB3bFO0UxjJsPoce3hNYLki9TQu8ads4STcvueVInPxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doLlW5QKg+3iGve7PXCO+9X7V+IaFgcwPQvlkEes5Ac=;
 b=PCKG34VKBvkDOGUTnuwVZX2HX9p9ZTUCCUbYU3LN+D6typ4x6uXTV6eLUDPXuMK6lv4GbeybnfTfudQzSc0CXDoBQ7c1iJwO/2wtSBZr9OT0Cs03WBic8JJHtJDHENgUfpoO1F3N5taZXV59nMr3Kasj2mRU500iEn1e4WcZI+7PfWEn6ESdGqlLjzKgy9dKXqGM6d2Ztm5/h0ETGdU9As3B4xcr9TC1CIxj6SfTqgtGHoxn65+lLtd37Qv5eT3dVfw0Q3mKIJZ7CZUXeOnkNZjiux4Fm6nMWT1jt1g8FdhiTLB7my4QjvkWyre1LgzeU7PT+2F35iSYjim0ou01Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doLlW5QKg+3iGve7PXCO+9X7V+IaFgcwPQvlkEes5Ac=;
 b=eAWESP2Z81oqljFCnMA9aX6XYH5ZamxDeJRQDtHZ1w0+hW5zyyIEUWPpmIF9f/xn3Wzy5J7kefBupsGcDkpJ1n4peThwJvfUnNqA9nBt5PeaXcvqqBce2Hfe+N1iGvCJGb6q11ye5ZcrvuJoNNtpQPfW02YLEXvNRjp7YoTCzjhChf7jc/S80KsyIUfMgeogLbJJ8gywfvQAts//SQHOpzPA0CDBe6nFZf1M0i6YURSHnYx3Ovvlj2fV+CP/gFpwGtl3PmEZVn0w4OProc99/dXmH60vWOMxZqreRjnGhCNgKyUaVkeGseRECbHCIJ8brdzBBoAl95VhLEAAFyme3Q==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:05 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:05 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
Date: Tue,  6 Jun 2023 10:15:49 +0000
Message-Id: <20230606101557.202060-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230606101557.202060-1-het.gala@nutanix.com>
References: <20230606101557.202060-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2ed190-072f-4a7e-0b75-08db667709c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJgCZBmNd6bRCMOR+J4Lug+2NN0Rw8CInFRmw+Y/7Cv4QeyPkE8t6B4JnM066T9dgOPbge1bJZRof+PMEKvzLPiSf8nVybEsRolAQfdc1bgDaKJiiu7vCmhiIfvk7x3anKi2u+qU7j56RPuVwDH3HdpsckBfjNhMPqlGbe0RkVEmKX82zzWs90PyniXcJQod1CN/JB1FLlRJCPmUIuF7ULkK4jSPsGqSMkHhKhnGLcVIO9Zj5aGG04X9rXmMFx/vghg6uzm/1FwfUfjN6frIubwPDIiCWU0ibc8UWnBYHQJn0NJ96RwwFrRvY+xQTzwilps2Ttj8/ALj8cZd5IKL9eCYQtU1/GI9cB4r+yll6e29a5Feqg0z0y947taB6IIx54VV54elYw973pGEAMgdFEZzRWF/9tpzdMd3/jlCIxhIejh72rU/Zhz8ErP8rMLHG7u96TtvpNAqnK+Bx3DKNl9StJO2ZtG3GJH3748AmSY+0z8WsnppLSDrcKApYU4W2QBtOy5SFbp2TWPVZenFNAA9DV9tW5GKjcmqhYygqi1aCtKBT/9YR+spSsoUVaRP93DugXWiThQqHUkcBsBdRWF7cie8sd/wA/W7xkj8+HJbnMhUtdNtBQMaPBk2d257
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003)(66899021);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVdTZUYxcDJGQjJWdUFRbUdVdXExR0tRVjBEQkRWWXQ4cXBRZ2xna3c0QWZy?=
 =?utf-8?B?UkRZZTNIS3p6Y2dlRVhRb0UzUVZ3YnVkbjJGSkVpWG1HUmpjeUN1ZlJnYTlz?=
 =?utf-8?B?NjJVVnU4dHZyL2V0VkxuWHd0dFUraXpyK1J2OGJIdFZ1OWNybHp2aWlsbEJn?=
 =?utf-8?B?MnRsalA2ZGM3R0p4RHJSdCtuVktlNE05VVJtUHZHT1AvNlNYRDg5cVM0azR3?=
 =?utf-8?B?SVNoQnFPQ25JUDBEbThrbFBUVnNJSVFXeHpDY3pOclpzd1MyRVg0UDRWNk8x?=
 =?utf-8?B?Zjg2V0tsVU82UVNTVW5yRmowRk5mWk5peVJ6eDBmNjlGekJPYUs1RVUzUCtx?=
 =?utf-8?B?L1IzQmplckhCYjAzMjFUcEdYVUdIeDVYcmYzWHRBSEk1TmJIVWJGN2xlaUhM?=
 =?utf-8?B?ZW04bTRlMWJmVkMwK1VudW8vbk9HN2hJV2VjNGZBTTdCcTBXU3k0d3FSaHpC?=
 =?utf-8?B?eFNwRjJ6MDVwRytpbHVaSGlHdG9GZEVlSk9qKzdoL1JIQmNCMWYyQ0hrYnRP?=
 =?utf-8?B?MmlwMjhDaFZpSXV1WXhncjlEOEpjSVRFakZGWHkrVEZySE54SkcxT2JoRkR1?=
 =?utf-8?B?WWFWbTFGTURXY0dBMENtVE13T2lxOVRjeldNU1c5OXFiZGg0Z2tiNzYvQW9L?=
 =?utf-8?B?TFpaUXFtOHluanFXYUt3dGNuYzBUUnUrS3NFb0ZDSHVham4rWUExdWVaVWdD?=
 =?utf-8?B?cjVNdDVrbEEzRE5tdDRVbDNUam5MZis5WFZIQmdnUlBMRmdNTjFlN0dQTDNy?=
 =?utf-8?B?WWlOVkhFWmx1MEp0M0dIUVhFb2VRNXNsd1RUazgxeHVWL0dzdlBtaUZ4T29U?=
 =?utf-8?B?Si9DcnFBRjJEK0xEUXFUaGk2bm5kUjRYSGZ6NUd3SUV4ZllIaUF5ckYwbklT?=
 =?utf-8?B?SjdMeGFqTlJDQksyd3FTRkpQOE5wL251dlJKcDhqeUE2cFNSSUk2dityaDZF?=
 =?utf-8?B?dXZnTVoxb2c1cVlUZ2psNGdqK2NjcTF0YVBKSURHa0NvSUxMRmJMQjBScTVh?=
 =?utf-8?B?NFpBa1k0dmhIMUh1KzhZdnN1NFlxb2FSbjEycWJuSGRnMW5ZbjdxdnB6V1RD?=
 =?utf-8?B?TWczTWlja2lSQjFtTlYyYU01Tngrd2JXVjc2WXpTSkNadytIQVIvSVptSjM4?=
 =?utf-8?B?RWZsRUpMQmlZTUhoSDFWTmdRNTV3UHpndTVWb0t5cnlueUQxM0p2VGM2Uk04?=
 =?utf-8?B?QUpucHJqQVM5S3E2U3p3N3JWUlpJUzE4R2JHVENsZkJPWSs2bDFZZDZ4UjFm?=
 =?utf-8?B?aDQvckl0RDVONnFvSXF2d2R5OTR6STUzdUhPRGF1L2lldG80NE5DV0JhcC9F?=
 =?utf-8?B?UU1Ic1h2YTE5UUppcStQaEhUZmhBcmZULyswZzdkbnZyK1ArTVk4eHNWL0Zu?=
 =?utf-8?B?T05oblNGRlRveHFvNEw5QUYzUE9Zd2JaNk1FeE5hKzY3elo1TFVlYUtxZExj?=
 =?utf-8?B?TGVHNkRjanN6TEJuNlh1Y3hOaDZvSDl2RVRQdG5zTWI1ZWg5b1FST0FBYzdx?=
 =?utf-8?B?dlVwSVh6MjlRZGdZWW1NRXlBR3hsd1VBU1B1bmlLTGRzd2RSekxocGNsdDh1?=
 =?utf-8?B?MkZFMW1iWld4c3JyTjhMY2VjZCtNeGY5cmNEdVhEcHhLb2o1NE10K2tQZkZM?=
 =?utf-8?B?MHVNVncycGRyREJ3ZHRCRWpWck9nSXovK1dGUzA3QzRQUnhTamw2cmxOaFlS?=
 =?utf-8?B?b1pqVWgwR0IwVFlUdUQvYUhTc000WjJGU3dUdlFPdjdNNk5yb1FkQ2lwbVp2?=
 =?utf-8?B?QytHS203S3BkZHZWYksydWlvZHJnQTZvWmxhZzBxTERhYWVSaHhTbDJDcS9h?=
 =?utf-8?B?OFMyMEVINmd6VlhqeUc0Y1FaQ3BsVGx4YUx6R3dVRCtBd0NCUzNJVnFwRmN1?=
 =?utf-8?B?eUJlaGx3UEhLMHFUMUh3T3ZZenQwdGg1K2xlZW11Tk1Na2lTcWZvK2pudkJ1?=
 =?utf-8?B?RDd5c0tzN3NKaDY1YmpSK3R1Z3Vka1VjYWwrM2V5c0tveHB2a1lEenlFM1E4?=
 =?utf-8?B?WUlPK0NHMTZVVnRTWGhyQTd2d25hdW1PVlRoVmhoaWdhWk1zRkFNditDZHQw?=
 =?utf-8?B?eXpZczFUbVNwUlFiRWdNK3o1V0ErbnJaQzQrcHc3KzNRdjdCM09tWTUyZFRK?=
 =?utf-8?B?cWNaU2FoaGhBYlNhSXR6cjMyNmZtSXhPWTZ5dlVHQlpTMmJUdjY1ME1WZk9H?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2ed190-072f-4a7e-0b75-08db667709c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:05.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lTY6ZweOgDDSr6YJfAxnyEuFeZwA4jHx4ylSU0/NropOVVMlffbSYbUKK/OCBeFOw6364oRGAeeB3Mbb7oPVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: U38SbbwATXjfz3ykzVVaRQgrgKPyK0mr
X-Proofpoint-GUID: U38SbbwATXjfz3ykzVVaRQgrgKPyK0mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
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

This patch introduces well defined MigrateAddress struct and its related
child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
is of string type. The current migration flow follows double encoding
scheme for  fetching migration parameters such as 'uri' and this is
not an ideal design.

Motive for intoducing struct level design is to prevent double encoding
of QAPI arguments, as Qemu should be able to directly use the QAPI
arguments without any level of encoding.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/migration.json | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..e61d25eba2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1407,6 +1407,51 @@
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
+# Since 8.1
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: list of commands for migraton stream execution to a file.
+#
+# Notes:
+#
+# 1. @args[0] needs to be the path to the new program.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.1
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


