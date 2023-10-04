Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5124C7B7965
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwn4-00057Z-8N; Wed, 04 Oct 2023 03:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwn2-000575-DN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmn-0006MW-0K
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:28 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3943QcFf008519; Wed, 4 Oct 2023 00:59:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=I5bVtNtwqHFqWlEPif4/mT7sfe032SRa5RQijey0d
 +w=; b=O2fSMMGuJhmgfOxo3OVIJuBr8Y94acqoICyuz9mmG28U668aVhZbY2b0o
 pxFPxX1Bwj0AdW8C7pvSHE+pO56Dg5NnC4qYrPn6uWS5sSQ1RoLWPp5q/wkOWbfd
 yCNbsXHdmwOufn0U5sFdSR667jvjiF1qeNfMRfyqNTis5E/uOzNQh70kZmqBELuk
 U0GrA9pLlGo8AmHE7TCjWooajO6CcuJlZSJ8/5p7ido9WRS4G7a4Cb7pRKdQQxst
 qAnCdJGWvkzeDK7fir/5MjId3wRRGqd0SMkOK+tCg1WpwkwbEsz7t919gQexqKfu
 BNuDUwa8Z3YR1kFd5z9u0H72H7DAA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rpr8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7t71wu1fKDjlag+j1hKBn30q8KAHT1FPCVJJBgPJWCGWju4hgJ1diQ1NI/rTGbdkl60XDschhovwKUnRwuUIdcdyIAdQeR9hRkBXJH62B8O49ChB3Txkfw0vy1zUHOX96EVz2GNRGlTQgbC2kNmzK8Hs4HD1/C8V5OZIVS35nDV9PIpH1Phu3AHRn7cREo42pg0mdcM3J9TRV2crBmz7nluKZjcksv3iesm5NOZvuCpy1OJXKrRjf5iglS6mtWKWS8nfiAITVpD/kFyQFJFTMikLVgwG0vds4iDDGzZR4JenHJsU8XlNnAnqCr51OSjp5pbd6CNU7L23TtzrgdNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5bVtNtwqHFqWlEPif4/mT7sfe032SRa5RQijey0d+w=;
 b=H6eUEhSStWFXJFwLzc8neTAh8TtFH3A52xmvG6dxsm8Xh7IWGHczRRcI+Gulue7fHFfYKFvulv3eq9BnKdJUoLHgzeqYHQYXAxlzPYAnq0Dw98mgT/tMsXy8BQtgJ3D8ti8A2fG2/zgZfY16aH8QTyXwN5tuWWU08SmTSSGQPIPW8FJU5mIBasj1suZOd93mbFrNZEY7wKZj35vm6D55ktBz9pjeKbMPSO1mBKebF5bhi7/pEIlcxaa72jT4xcjv0rnEzJKSzVww+SBcwGI7uLOphiGUa7XfANnrUjvTEZF67rSJQwnLkZ/O0gCVcvDfhGPheVkhVhamDgpTTkiwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5bVtNtwqHFqWlEPif4/mT7sfe032SRa5RQijey0d+w=;
 b=dl1BtOiH3Ff/3gnXRyBG5157XrKQFAiEV5PAS+dVWxDljZaMyNBjZ5VBOBKWA/3QtJ59RaB7AradBtF33KJTjDybosIVNvwpD1iQjOR1TLWLgjTrO2zBHXXUpaP6mTzzCpi0nvXBf3CDjRdJyAyqr2wwMJDuqAIxcy9zgBbjGlAHEcU8CV+1OsYj73UMj/kj59R6oAhR3RglEl+jWjs4Itpy76/DsAuVdewfnBM6+otdG+eM7MkvzolvtBkNQVDUVHG07PmoT8ydy2/QksUBD5HqtElRQLLdikyjeVRITduBld98p8qGlXiLgAsmwlWuul9Caqgej+3iNURkIyAz3Q==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:09 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:09 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 07/10] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Date: Wed,  4 Oct 2023 07:58:48 +0000
Message-Id: <20231004075851.219173-8-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce49a536-f24f-4ca1-2673-08dbc4afca3c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mir6Fw75W8udhhizQCc2aKVD6elJT1ksgKr4aADPdr1PNitZnjFgLIDkt5ZLUyT3G3iQbKCRQg1nA/7eSNoaoJup2aGAkIh5nPqwfKdKDCUqyvZ8B0wAd6HJIhxaeTmsueGpNrzsjy2r4YBzofVhheC774x/3xranwr5WMtlp2kUA6RiL1x9ZEhP5j8E4dxftVL9B0NoMyZ0TeaqR6kiud4cDI+mHK0NLrc5zoe3UHshNC0BBZTo8nst7EmnAeLz7AbyfqbKHSVBi0RU4Mqm6isKVaeRdzrfOGtGHWvptu+i3MpTjfTiBSr712d+75AKeOXdZlkxSb6ERi4vO/dU/15egStugm8AqCvpxHF39gztzBPmLA+W8ah3stLl2SMqoZtr7+69xfcMbpZebWERY97e/30rB9iVYB6l+//QwvMfPTPXWQGldeDuclmp8GA2z/i8VmO4aQ+85A0RZzXAUVbXovoWOAQWxXdTbd5lCGkLn58Q+Y46VzGQnscEbnPfPmH56IJKygjz60g13rPfxSYAetupR6Y/7I2BMABrR9P5pvF94PWfX+oIUEE6AN3QhYhJ7SQx68sz3vvSIIaQyUYhS6KZ3SAeoO6cGqZMLUccjTNne4jgwKWeNMEOvexZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29rOXMwT1FQTmdGb3Y3cGc2SnM5RWhSUmQ2RkljcTRpSkNCV1luU1BTMWxP?=
 =?utf-8?B?dk8zbFIzOWtiVHRqNHd0RVZSWmtxREtmSXFuR0FvaFkzcTdDUG9Oci9rV1Y3?=
 =?utf-8?B?UU5TaithTHdMdjgwcmJhc1cvUWZYV1B0RUFCaHhLdktOcTZ5d3JQeUFhTGQ3?=
 =?utf-8?B?OXFwYUpBWGRranBydFk2empzaGIvTitjem5FVzZqd1ZGbWllakhHTUUrWnJa?=
 =?utf-8?B?bjFkZ2JmaDVSL0JVOE55cWhvMDQ1N1lORWtHMkhtWHpWaEdOZ0ppWTR1NzZU?=
 =?utf-8?B?eFNtZGNRVnBvU3VwZDF1WVBCeTcwNitudGdUTytHcXMxUnNlTUlKTnR3bnF4?=
 =?utf-8?B?L0srUkNacEd3eng1N1UwUnZiQjRvRVNCUndPN0tySW81VjA0a25PQXVZaWN4?=
 =?utf-8?B?LyszYXhNaGRiOExHaWpYTksxamRzMzZwQ3RySkFpSzFNakxmcVNiWS9mSXo0?=
 =?utf-8?B?SnNaZ0treVNQUkhYbXB4cVR5Rkx0d3luKzFiNUdPblZDS0hlOXRaVnM0QnVn?=
 =?utf-8?B?MXByN3FVcEFxYUNKRDBUZG5qQ1llTnMwVEJoczRDQVBDalVkOXJ1SDRBUkoy?=
 =?utf-8?B?T2VTWTljU3RIZ0Fhc2k5eVNudGZHZVFXdWoydkF3U3IrazNlMlFFeGZtWG5O?=
 =?utf-8?B?RGpGbisvak5JQmtOUm5KZE81Z2YxK3BURHBoMHFIQ2ovaUFoZjJLZFpoOVlF?=
 =?utf-8?B?Q1l0bjZFQUZ0d3hrWDRPNGFFWjVodjB4Z2M4VUlIUU0wdmZIcXVvUkxnSlFa?=
 =?utf-8?B?STNqMGIyTFRhY2ZiTEdSMnZBU1NNNGZwR1N2VisrN0RES0oxT0VRa2NoV3cw?=
 =?utf-8?B?NUEwd1ZvMlhabStqSng3MW1yOW5jdkRzNFVyRUF1UUlvWnZ6aVM1M2pEZ2s5?=
 =?utf-8?B?OHJHVGwvdkZKRkhRUFBXQVIybXdBeHJyS2RjUkg1UHhERW82K0FkZHg4cFFU?=
 =?utf-8?B?Z2lINEJnT25CUStFdnJVZXJKRlZSRG9qODR0TzdKUHJZYUNDWVhnVzhHZ1g0?=
 =?utf-8?B?OHN0TElXbWxab1FLLzFyQWVEbzIwWUhwenJyc1hjNHVVaXNiQ3h5WGE0alYv?=
 =?utf-8?B?eW9RbkdxYXdpdStKbWoxNDZJQzk0aDZWZzZxSDdrUFkzaWtPOGRJUkNyd2JW?=
 =?utf-8?B?dFRCZFNJSkJ0aDlibXFNR1BRd3lndC9wUUIwbVdFZ3h4eUlCTXZTQUVLWEV5?=
 =?utf-8?B?eW4yNE10WmJ3cjlPMlRLZjVpR2NIMFpSQ2hUQVF6dkZnVHhlTUZzeUowTzA2?=
 =?utf-8?B?ckpYVDZUZS9iZW5pUVVVSzM4bzNZSktvcXFTcmNvM1RMRnB2Rmk0L0M0TkVy?=
 =?utf-8?B?dk0xNWlvenB3b01pcGtPcTFQKzg0eERyRnBOTEYyeDhSOE5PNmVSSjlFaWQ1?=
 =?utf-8?B?M0wzUjQrUys1dDh6WDFQQ2FaYjZmcm8zK2RTRjRJc0ZqWnQ2SkFzWThjWDV0?=
 =?utf-8?B?c0JJdkhwWnNMV1hONFpJRitselJuR1lNNkRiMHZUeU1QOGxNK1VJMit6Q2FW?=
 =?utf-8?B?VHd2SExmakdOT0M0MkxsS3pGRkNuMTZmYkRRVURNQWUrOVA4OEkzU3B1ZENj?=
 =?utf-8?B?RkRQSVJ3MWpGdzg4NEFlNGNZcHhWWFdtVVViTmdkTys4aHlKbUlmbzJ0eDBx?=
 =?utf-8?B?aXdUT1g1c0hsbk9YMWF0bnNUVGlRQmkxTjIySE1iMTJyL05lZ0MwYUpXSjR4?=
 =?utf-8?B?VGtqQ2JpU1d4blg4V1gwL3pmYm9mRU5ieEcxSzdrelhoL0psampzTHoxKzdu?=
 =?utf-8?B?Rml5N3hJQUh1ZzloenNITGY4QU8ybjRLelZ2UmVXWm44aXNiSHdBVEhZRHY5?=
 =?utf-8?B?QllWQlRQeUJPZkpzc2tDZERyOTNXNkIxb2N4Zk4xNElOZzcyWTVhWnlwbE5L?=
 =?utf-8?B?TFFEbUlrUUhNUEE2cFdGVFBVV2Q3RVhRZmhwV0tlQUR3VHJUU1RybTJoeHN5?=
 =?utf-8?B?aWo3T1BDYkFXQ3lPNVZFa3F5UTJZQ0pLWUVzaHRuc09pRG1rQlBwSElWYXFN?=
 =?utf-8?B?TWcyREwxN1U0UlhUOERGZFlTZXQ4bHdHano4OEdCQzFmZHhhcDZPNUllVnRt?=
 =?utf-8?B?NkpuU1hYN3kwNlR2NVgxNjJIeUo3SVNFY3EvS0NoT0ZDbEVEMXpESTZvUGVk?=
 =?utf-8?Q?sS1G7SfQPZytt63nC7NN5HHg7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce49a536-f24f-4ca1-2673-08dbc4afca3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:09.5569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4fbQqt8kENJb794cD00M/j759fVLjqT7twSiOr1nshGDvLiNY91FqP+2VkzV6sPSCcjOVrr0bZc8mmhgYD7Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: dtYckEwRBbdFKysxtMwSV4PeoHbqX4G1
X-Proofpoint-GUID: dtYckEwRBbdFKysxtMwSV4PeoHbqX4G1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 825bf70e7a..6f948988ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -106,17 +106,20 @@ static bool migration_needs_multiple_sockets(void)
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
@@ -499,12 +502,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
 
@@ -1770,12 +1773,12 @@ void qmp_migrate(const char *uri, bool has_channels,
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


