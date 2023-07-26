Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF357763A9B
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMP-0003kX-7u; Wed, 26 Jul 2023 10:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLt-0003Nf-PD
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLs-0001Bz-25
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDA2t7003674; Wed, 26 Jul 2023 07:18:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=DroMgIIs1Plyl/97uQxKwblK2nl2ndcV7NeEK7PMd
 tI=; b=zrmgRHik6cpTOSbmxCGz5/rUFZQ3Fukt/3S3r9DCeqsPqv+fxEgLJvCmP
 8627VR0Se9EQ+n/0NgmXlfaZ1Xv1lJEK71YQpnrg+sKZWQC5Cl+NzYL5TAHNNUEb
 dOYu6w5bBiCIR+J9VECUbNiQu1042Vbf8YWE6htIBv+FpnyZ43p8UehPrr4C33eY
 QoD6Czy/zaEyXMssGRsxnmjIV16b18m281hxL2bwlhjG03PrSJsGsp8pEyhcz9HN
 gUqu9qeh44SIXT51JFG8qEdJ8B1PUhpC0rIMz3Mb05ZKIBJmI+XyKQOYCb7ekGtT
 RkAujYWc0YS1RphMRz1+iX0qhKWVg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0e6dfyrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjrwmUZAE7A/jH6zaZpqlbpczzgZuJA4U5u2yHxvtuYFure+ANGnWDGPh9H87IWH/p+j5R+vcfPCAVVWD/al5lpf4f+L6rMB33ZD3YmnhYiqBcHeUjpPfGPHMMmm45ilRXCoys0MG3WLFs+9c4MVK82pF/EN6xXPTyUcPDknAYuaq39sqORzNSmdevzyZ/lHJ2L2bYbH0Rfs3DvCKBuf6rEENPKY+KXjJ5NnNCgaGCtQEUGpSt4jA0b8T1sca1Nr8O5i8j6pOCvEuD2Icg30yGcQeq8Hnv4lCF5oJPs5ABvpkH/i58PTT1E23mZclTNSbI5mQAgCJUWY7j9Tehhm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DroMgIIs1Plyl/97uQxKwblK2nl2ndcV7NeEK7PMdtI=;
 b=K8AHufyvdS2tCzYf7JGznTO/B9Oqk1pX3RreGfOBi7y2jSUMNrYSdSURIoDNsEN5oVG4M6A2XTetJX0qmYVn1De4T2yWkdjF+YipC47/AEHE23Rz9bC/GsJLP4yK/c9Q0IFUPKrx3gJ/2aALNflW+5CrQ68/EPPWIJI/mxTI9xbxmo9gP2kbC81QUWkiOb4Sz5u8T1zyoQHOrxNyr0ajCAGc8Y3yT+8i228V/vWeBMb3u6JlLXTC4GAI9garj9Fy7ai/WDCXqGvJJaU+v7EI+0F7aX5KNu9EmmOlijMgmO0yE607qx0ZUhnlo3ctw70fPWxDtF9i/7iHOcooStAiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DroMgIIs1Plyl/97uQxKwblK2nl2ndcV7NeEK7PMdtI=;
 b=F21I+RZYGaW0G0vYgkwZvrYBXl52ybKChKGXSzb+51GP+FmuDjifS70v6CmMD0JpVeolOMwUSrBROxl8bajY5Gn2pW/u0MGlmmh05pTTeUzgOcCam9FP+i7khrr0+h8dYcCV4XFQocThF2rFqrBTASibOTYdv2v4D8ge4h0KgDlMgQvTMWtBchTpNr94f8Ne4zt0u9HziVItpYgGhf5VWOnKTcQh4dOT8vGxrlYrjs3zgNG6IrcHx3pAIVgU7mCK6BwpXLwjkh0KXqNNW1EKW1qYXB6AQbSbXF06e4mNbYWi0SjuAjkbknZ5QeoyESBX2TaEz1kix2FVlyXNxglF8Q==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:52 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:52 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 07/10] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Date: Wed, 26 Jul 2023 14:18:30 +0000
Message-Id: <20230726141833.50252-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ab9df7-f821-4456-3fdd-08db8de33c73
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGRo2w8aw6PuMwuhD/30ir638w/x5HxMrSSr+iUW5S1lWTlii/MRdo16HqEdcMbiQqNXwp1YwrPE08WtnUEIDy6W8Qsvw4QHLHRcIqXIN3K4xqwdwlb/xFQhkFgG+3/+AKEvlpKON5g6Ux6lPaAAmCeCcpWr+QM+gsOGeSqEsr/Q5bMY3PXoY/7fb0SooOikj1p3AeNDjvZDkL2exB03GyMQ/yTvguZRpBTDz1g4cLtLWl5uS0ZgsOADDSLIjo3qdrjEKR1zwmZh4g+YQxvsEdxVCOwh4hWCA7nA9uuB+9eSLjEHbHjUsUBW8Y1TT9kpY9629RDgH/lr/Rlo9ncniefXFouI8/mVQHi20Umah8nqwcRXUxYnHOiTYidUZNfxintia4gr3/8PcxPtC1QXPbSetrhLBR7xA5svUkUg7sVI+lGC9TaVWJd8Bd8eBLf8LmruXTXke+u8u6WGdi5SIfxddKaEEnwJo+/q2w+9iL+ofpApUg7LYMvvEjkQAXiCCNRbqbPc+BXA93RG6gaLG5M2e8oPtVQYwKz0RZR2Rfw1HZgc4MEAzwIhgpfLNKi60t5tJ2F697IiDzrXqeNxbZ1sEeSroYdl42EmljpjiVSYfwOKgzXJvdXFnA3K17ud
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhvN09Jc1BxRE9wSWxBUjdZVnk3ODRRMFFyVDhZTXVKcFZabklWTjhSZk5u?=
 =?utf-8?B?M1BTQkx0WDNscUU0NU5iUTcxK0lJOGEzcVFORFBISmpQeDhSbGI5VlhnRDVa?=
 =?utf-8?B?SWlNVitiT1gvVjM0N3lCOGdjcStMUjNCNnAyeFBHUFBMMFFOTmlWTHdYcm9G?=
 =?utf-8?B?SzFHcTBWSzRrNTdhc2tGU0FsTVJRNGNWa25iMnJLQytPTE50ZzZhaHNiTTVZ?=
 =?utf-8?B?NGlkbllwQUZETUJ5UjFybUp4ZU95bzIzaS9WZzZCc2hDT1JTRGUxNjBYS1FV?=
 =?utf-8?B?T29tUDRGWS85NFQwR3JoWGpkOTRvM2JQRWpTbFgrUHMxRUZQZ0JzSjdKZDdO?=
 =?utf-8?B?czJjekplaXY5RklXQnExbFJKRWUycXFJWlpRL3VvR3cwM2kzQjBxL3BGOVFh?=
 =?utf-8?B?Y1JNVXFRYTdHUGQzNXlTZnhDWGJUcWl5M1AzNDBsclhOQmhnNGZmUjhKbjFH?=
 =?utf-8?B?NG1DRnhpc1ZMNFBJZGQzMjcrL3hFbzBQWUhzUjNzRE1McnVNMEU1dmlJU29p?=
 =?utf-8?B?VktrSTFwNEJmT1FSRnppYWR1NkowQkZEeHJmOFN5VDhrRXdkT2Y1RXFVb0h3?=
 =?utf-8?B?VDA4cHBEVWgzVUlONTVmbjhDajBkUlc1cldSdDkzdUE5d1drQ3JLaXB2empU?=
 =?utf-8?B?QVlpOHp6bTVKMU0vMUZtTmhJcjFpbXljMWxFbmVzd2ROanNXc253Z3M2cVFE?=
 =?utf-8?B?cXNzSm02UXdkRStsTUN2N1NZTzZ6dThMeDUvL2xUNzRiMGxlalIvR1N5U0pD?=
 =?utf-8?B?MnN2SWFxb1dTMi9lUk9jZWlSRmNtdjI1V09BUFM2WnFXeG9VR21sc2tvYjh5?=
 =?utf-8?B?NlplbklCZm5UbXJOZjdpcmhCc1JkcjdrdDhZUTRmN044ZWliNEFnQUdsck5B?=
 =?utf-8?B?dlU0WWZjMHhZemR1Zjhjdy9XOTRmZjFkU2RaMSs1YVJoMnkzRVlEL2FPdXNI?=
 =?utf-8?B?VmgvdTFTZHVoS254dnpmQVozV01DTkJXTUo4MmFxS2hzcXY4WjAzalFWdjA1?=
 =?utf-8?B?bStrVlNUQ2RFc2xIc1dXM0Y4cStoSEZOMUw1UVErMUt5YWhzMXkrTXRURS9G?=
 =?utf-8?B?eFZLRHVERG1laGdNSk5ndkFFcWhhUmI4U1N1YlJ4bEllMUg4SXZYYVZHYml5?=
 =?utf-8?B?NEhEN2hmZjA3RXJHNW9Ta3ZXeWtFeEFTUml5bDBLSWttZXR2cHFJQW9UZTEy?=
 =?utf-8?B?bHRxcmRWa2gyVWpFT3N1VHFMOWs0VUdtcHl0ZVdXb0F5SDBxelcrLy9xMzJy?=
 =?utf-8?B?MXFReE9PUkVnSGtLendJTEI5WHRZbHcrR3VGQ1p5c2xuZWNPUElIalhKTHRZ?=
 =?utf-8?B?eHVtcmtRV1BwR2c3VDJSTlB1WkYxUzBkcVJjMGpGcVM5dGJjdEpPaDZOcGFq?=
 =?utf-8?B?MGxXQlNxeTdqSWxXS0dTNVZPTWlyZXpDTkFGcm52TjMrdkpqc1k4MHdrNkZh?=
 =?utf-8?B?WkJ2aWE0TUN6cVplMVR5TWlHWVg5MFhENVJYMVdBY1NhaXJReERueE01Vllw?=
 =?utf-8?B?bE1rS0xFdHRvc2NQVXp1TW4rMGZkb0V3SWZ3NjdRemMwSkYxbXJ2S2I3MG1a?=
 =?utf-8?B?ZDJJNy9udlVJU0xkQ1JBc0ZYZXd5MXRUanhMOWRDV3l2YnhNL2FBSjdibklO?=
 =?utf-8?B?bERXM3JiSGFsTzQ3SjUvVXdQK29FZjJqVlhuamJBbnBqTlJCZWZtaGptejNT?=
 =?utf-8?B?ZElEYmhFcWwyTEUyVGg2eGlicm5HYmhyM2JONHB0ZjVqYW80YVZDaC82bVNw?=
 =?utf-8?B?RWQ1L2pPcXNwZlF0TlNzQzRCS3dYSElGQ0MxaUVGUFdqVWhwRTBiV0FxblB5?=
 =?utf-8?B?V0YrNHZCL015ZEhhd3ZHaytSZHdhL0ZaUDF3a2plVlJJU05yeVNSby9lU1M4?=
 =?utf-8?B?N0hrYTYrUDlQc3kxeHpYRGRJMG9jNW84VkoyQ1Q5NFgrNmdSeUh3VE4raUZr?=
 =?utf-8?B?RWdBMEpJOE16VExRem5OQURFaXZseGxtQko1TjlrVjRQNVpvU0xhM1Q4MU1K?=
 =?utf-8?B?Wm5ucE5lN1F5TDQrS0ZLclIrUE9xd3phSTZTbXBpdy9oVEtKc3BTWU9hQzRQ?=
 =?utf-8?B?UmEzT1l2T3dMc0dnZUpuY1BGRDJuWmZZVWNqYXpFOVAxZDdHTnJmNDFYZUFv?=
 =?utf-8?B?WXc1UnE2UGJkUmY4ZGRuNlZkZUoyalh3dXlOcDBIaGY2WSt4cmRveVphcFg4?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ab9df7-f821-4456-3fdd-08db8de33c73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:52.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQ7hh8p9asmQs5yrGlPPRpjBAh3Z0+1jPeJ3Lb4hRy8sE46RHX/ImCDmwBm7prMNmukYh8JOuByr0WuTXayWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: DGLFepSkHKPhG7YcIbpuj3VPGRpkKQML
X-Proofpoint-ORIG-GUID: DGLFepSkHKPhG7YcIbpuj3VPGRpkKQML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
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

migration_channels_and_uri_compatible() check for transport mechanism
suitable for multifd migration gets executed when the caller calls old
uri syntax. It needs it to be run when using the modern MigrateChannel
QAPI syntax too.

After URI -> 'MigrateChannel' :
migration_channels_and_uri_compatible() ->
migration_channels_and_transport_compatible() passes object as argument
and check for valid transport mechanism.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index be8cdf0fa5..5720c8ed4c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -104,17 +104,20 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool uri_supports_multi_channels(const char *uri)
+static bool transport_supports_multi_channels(SocketAddress *saddr)
 {
-    return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
-           strstart(uri, "vsock:", NULL);
+    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
 }
 
 static bool
-migration_channels_and_uri_compatible(const char *uri, Error **errp)
+migration_channels_and_transport_compatible(MigrationAddress *addr,
+                                            Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        !uri_supports_multi_channels(uri)) {
+        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
+        !transport_supports_multi_channels(&addr->u.socket)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
@@ -493,12 +496,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
@@ -1740,12 +1743,12 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, errp)) {
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
         return;
     }
 
-- 
2.22.3


