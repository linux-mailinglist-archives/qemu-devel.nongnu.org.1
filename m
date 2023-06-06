Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004F723F29
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tk5-0001hy-FR; Tue, 06 Jun 2023 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tju-0001ge-DE
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjr-0006VY-OY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:34 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567sj3H027360; Tue, 6 Jun 2023 03:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=UkJknEcHo18Gfj0NnrrSNtzOM/CHYD5C0N7eRLRIUs4=;
 b=0ARGoYQ9/U1010jBKCJVqVg2eBuvIubVIM7fwgy/VOErST3ydZ2HzACstUok3ALndjBm
 mcuXFqraAZgoyYNzp3EROXmSNuEcpScKsOuMdFloRVR+Dhtn86A8qu9bSK1jIrUQNE6A
 AgMELODNTM465DtDnBrc6BwBpNjGOSN+YnkIw8YVT0MDjzr5R4A6wFAuZAU/49xFrvtF
 +sEiZ1o3Pp+szbhnTfEdtV+vdTUM2srAdzEhC164//k/XmB0iQ8MFISicFsbl39WDWxQ
 bNs6QYWyhew7C4LUh9lo5V/Fgj8ItUmUiCRe9Ih4wVp2IDb3uJAl66hcqDGJ509ykNq8 bg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r01e6d007-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8YUXwXYrYAPpyOdnttegYvJJVtgpvToIn4GpS9aBISYKm4KrEermOaMwCGQlDYZjbHJd2s54j57/36WxIKhEQNTSh1LRgxNvZVBsgoG6DiAdapOcj9BaHp4zmd3sO4A27axBXTJzQTj5DtQWeWxSE5yFKYu8N40RDjegnVUVdu86BX+ggVfdFRqpSwcBKyrAwTQRmYdJ30kurZ+vsSCGtzLkyEGjuvoP79KRA/8u44x7DXm/+0PHlPiOxzHdC7aHhiJYkgcJJHvaz2UVCtLPlgnTMNP+52YKEUVkvdxw4OFrZOXeVpbWp0Pk6qtysa/ok+fgOFwsBKACimdf4z4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkJknEcHo18Gfj0NnrrSNtzOM/CHYD5C0N7eRLRIUs4=;
 b=SASF0EOOL0lneiXYGjZ3pOoy4EvlR0mnAzZZbE84ypojNNzn6hxHQ6Y2hTgSZFX5r9Pyl5n7fB+iV2rFVh0hxmT19KyowBsuuhOuOy35dmWJZfQLPNsZqIio7j+IAJMCKG6qPCoL/Ltdd8YxAOEjfS4WpWFTIsowj2AUaQdqN2CwGe12X02CZ4NuY7itsQyRWXO6n5FJSwKlO8qnEVNCtvyPDfxYrdbR1CcHvQZbf2a2a9x+lgMZKeeb3YxXprHRrhiwe8pDbCSfjmGceWrgRAQy0CZa6nS/KHL5WRoISKLeDPdorM8UPhzA+59udVRxP78skfJFvCIjMRVmUvIsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkJknEcHo18Gfj0NnrrSNtzOM/CHYD5C0N7eRLRIUs4=;
 b=FC+LTds57m5TiwHmSJ+vGLnMMMNlnCgOYPZGlqjK8Mb5M4BK4hzkMkUD0/eSPmzuJFtbJ4ujRXHKyeqMbdV7TGaxaddQLXrg9PNUKkurXmVZWU/sE+cVJRUds0fb+UA1muT075zjkTxbssq6eg7iNc9XQAv170B95izlb8jIuppPH/JD/4xoLLekhB+v/ZJBB2kuGKNIRm4pEJRD57Ndvbkkd0Zzm1FBzOeyJ6ArKbz3KeQhY1jRGlcyR3UK+dt4Sde0EI7QpTEtkK9vZgykyG+1uGynN/nNnyoAxr4h4IIRNXv0tXwrUleDUVTtarMtk9k8CjArpj7K3X4yOVIUJw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA0PR02MB7257.namprd02.prod.outlook.com (2603:10b6:806:db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:15 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:15 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 7/9] migration: modify
 migration_channels_and_uri_compatible() to incorporate newer migration QAPI
 syntax
Date: Tue,  6 Jun 2023 10:15:55 +0000
Message-Id: <20230606101557.202060-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230606101557.202060-1-het.gala@nutanix.com>
References: <20230606101557.202060-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA0PR02MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: f5784f99-04e3-475a-5b45-08db66770fa1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkPv76qKdrF6IGIZdWVuVQ1m4k8aYwEWrj8pI3uKtVKTAlw6An35OqYnlX3PWWwV+dPCJtKUDT9ZgL64GOf/ITem4TQ2gwDiCVrfGM0PFFJAljp947d5yV1VdMUqc/5BCIlBgWaG8bnA19p2z/S4VxMwEO1ZkHhgSlcERIWf+OxSi6syDUxYnr1ofmJOPqhVRFuqsw3YjlcT2nQ+wKW4THG+Mzvdqf2r0RpBit7ybDoGCIZ6bwEZokEVUnMbDqk6TgrV0Fh5eskNBTyX973m5j20hCtXbAHfCnimfRtSHYFptTR1vrGYVv/lucqvnBYLgW4BuAQL/fgA+9oxYJ/fe9eDHjedzmhLc8L6H96yMOZSXNpEyuqZl+j1OfIG9PFJwKT9X3bnTouBJ4vzwv52TnnfFIUvi9csQfqA5YmRN4WoL+fvvGogIERsmcGxR01Yeomgv8RQnMciWhlnj/Dnp4HuOVFagLvlVl0DfBl4maoNcNkwLsMnDJgj+/4vl/TMi5yJ+5au8EOZcxtOhBZUt4XQ3nC1DL8JLDQnTZuYGGjr4GucVk+1GFNiUNTSqe6oUVEmWrWIz5fnoxOtwEyZ754btxbcgIWCYD8NuCWhUxSy0BZMIyGwP3fLmxY4oaNd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(2906002)(44832011)(8936002)(41300700001)(8676002)(5660300002)(316002)(4326008)(66556008)(66476007)(6916009)(66946007)(478600001)(52116002)(36756003)(6486002)(6666004)(107886003)(186003)(86362001)(2616005)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QybFACEMhXpa/sb/XEFmMWWBmMrBTHoIIt+sDYY7tnRjHPw4ZMpk1+ToC9YG?=
 =?us-ascii?Q?NvLzRp4JR+Gok49+XWF7DlrkKKaAJBm1CT55luII4Wqb8vd9Fx3eEBpDOyU5?=
 =?us-ascii?Q?qVSO4D3jCJEJvZ3gL6sxo5/wa9iOQ3wOKF2EmgPtMAz40l2lamtr8LX+2HWF?=
 =?us-ascii?Q?+bcvkGEpdeUGhhImvwJmFZDfpA8l4j0blGx//IgX2t2/poRD/3kR4Kgofw+v?=
 =?us-ascii?Q?BzaOLqzFEusx1U38fiPvWevMN09BbpIVPQPvFCbZ9kAB64D1sbvDarfX1MbY?=
 =?us-ascii?Q?SajpdDYoqM4XJ4Bk+1q6Nu0xM+wpxottO4fm7KlfC8lICQ8HVsow+uCg6rIv?=
 =?us-ascii?Q?UV5wlykIPVzHEmNRCMLHnyQHmlh4htvkihsmnpgtC9Ab2od2TG5TuwqrK3QW?=
 =?us-ascii?Q?zd9iV2pOJ2eF0CWOcO+za4HQ8lem2vvXFzKp0j0Wu61yYjEpuoYHBm96TaUm?=
 =?us-ascii?Q?RPdxGmudC3XmBBUfVXhl8/re32SmuYOLar4w2iKaXd1vL5WHoyEmkm8+o2SO?=
 =?us-ascii?Q?SfdCmDqWo9CixyARXYRz35lRq8iYDHUJhjlNwi0+e0ZCPBRCMn8eLF8djhJE?=
 =?us-ascii?Q?ttL/gsYX27ik5U3Oagt7Xmu4Zz4DCB7XKrWelZoZfwqv+WwM1a4e45/X57rV?=
 =?us-ascii?Q?n9uyb+NWYZk3F3pt+3yJDjuUnHJpKzaK069U9sF1/wlzLcyR9wClEA4wnONB?=
 =?us-ascii?Q?ao16W/kEMY9cPiHvS8OXGscSRSP3HNEQx6k72/Fgqyys21e1dmnxZO8OVc5V?=
 =?us-ascii?Q?Ib6ogpBaRCa4Dkxr6pbZkmjA/nZKh3V1dqsPR2qVAMg+K7PUTqlPotR8U+Ls?=
 =?us-ascii?Q?wDMXkcViASc3smZYPePwE/WXP99tmKBsiwdNvqvlE6ch5RzM4Ew8WtYKf+58?=
 =?us-ascii?Q?x6yZHuh8Yt/uVNt8a2LGq3sULLB418ATX2qztqux+E/pl3N5n1khRPUkoqe2?=
 =?us-ascii?Q?WuKcMw10BHwl2A3ivPc9TRv/ULdt9mTSHlAh0U+BlVULfrfxjbb3kOv7oenw?=
 =?us-ascii?Q?AE5Ry4PBHiiwfmghn6HXm3uR2tV28RWGv2IPR2jC0GwQhLgut8GdUsGP07Kl?=
 =?us-ascii?Q?Crlw1r1xR9BMYm64zV01VboJhJPxg7yhhG27vsOsdDNtHzufjufhcZPydRSj?=
 =?us-ascii?Q?MExqSH2VPN/xfkc6zgCKDou1nzEINPD1VdFbFWNL++VopDFwh0WpIkwdwdk8?=
 =?us-ascii?Q?uU4eLWtGWe/OqmAE1pKslYyupqUrfEtZMIosFEEQHAY3zPGf916SmcmFO7Ix?=
 =?us-ascii?Q?guWWx+S5mBDtJI1bNSI/DWlflsv6JGu5+NFR1s9DG5ETBVc9V9ixLpaB1igs?=
 =?us-ascii?Q?43buQhc9144oxuI7xRUGbzqJcWpK8/32ZvYkWX8UJ3Zf3bmHKWjSinOOND7X?=
 =?us-ascii?Q?bdCks80oMQv/intBCd9/bH2fQmqbjhv1SmXViWVcrXJv01UQMwqtemAL0s+k?=
 =?us-ascii?Q?zCOx8FskTteJo+BFYxldAIIy0JzO3FK65cTMyjol3gsZhnLBEPHz+niN5tnk?=
 =?us-ascii?Q?rpslJyKh6thZa6Y54oqVSHWv947jHNnyoMBfg9PubNn8kCbICF9sD0RIrg8R?=
 =?us-ascii?Q?hni94hVs9jGq4P5zxMihmcdo1BENi9WDp7NzuRhM3fW7O3c12Yw+ulN1W9ei?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5784f99-04e3-475a-5b45-08db66770fa1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:15.3811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDzBAi8O3y6iZ2xi8C5DybEocl1zF3ADz2omWTnxsjGl1hbFjDFiX53uVz+hOD3oPzskyLQLTrVtFWXTWbNY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7257
X-Proofpoint-ORIG-GUID: RER9xy5uYW2RYpgzVnnp3i0UetZ5AO0_
X-Proofpoint-GUID: RER9xy5uYW2RYpgzVnnp3i0UetZ5AO0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
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
uri syntax. It needs it to be run when using the mordern MigrateCHannel
QAPI syntax too.

After URI -> 'MigrateChannel' object conversion,
migration_channels_and_uri_compatible() ->
migration_channels_and_transport_compatible() passes object as argument
and checks for valid transport mechanism.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a5ca9e0e27..98b797679b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -103,17 +103,20 @@ static bool migration_needs_multiple_sockets(void)
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
+migration_channels_and_transport_compatible(MigrationAddress *addrs,
+                                            Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        !uri_supports_multi_channels(uri)) {
+        (addrs->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
+        !transport_supports_multi_channels(&addrs->u.socket)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
@@ -480,12 +483,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
 
@@ -1708,12 +1711,12 @@ void qmp_migrate(const char *uri, bool has_channels,
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


