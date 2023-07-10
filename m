Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59B74D577
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0G-0008On-7K; Mon, 10 Jul 2023 08:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq0A-0008Ko-Ai
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq07-0000mR-Oi
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:26 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ABqv49006326; Mon, 10 Jul 2023 05:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=zXyVC4Y3WmZTc1xA1KhZ2ngdIUGTw3rghvjXnLFgC
 x4=; b=myQH4cQ1eFmEEBkGqeEcU5dczYeS6Sf4E/Ifa+vP54hOePKVNWCC7dqiF
 75WTMU0Dw1VdRiCUgj9Nf2m1utRrbM655DjkQIHktl0UnfK8aDX5ttIHkqjlqYCw
 3uT8fy4KQQdwOIRBVUokA7TZtxIKzowRnZkvEuCedhAuDxtZ2MzkciGN/2iMihW5
 8AxovLYC9UXk2sU0H8fnFJk6UWDVKukbQRaF+kP4RaX/17AoawYOvs1x+ZRGWKdo
 HFGkGXHZMyzVQoeWwgP30yB6vM7GhZe/QrZ42Rt1Qkcjr8PVYMqIBCIvDH+IXF2L
 +zpdjEEkH5B6p0KWetn+KSFnh83Gg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7butu5x-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXLAU5Ihv2YxN2wOuty1HxLbrcUaw5Z0j1eCxCPMQYw2CwJzaTOSQLNF5oznm9KHNShowL1/Jlk92q8J7mT7jJdR6moLsnBF7vutQQXpJBc4rk6+i7wXM31S6uwCyuZexHSWXIjwNKGbabzamUEhdCO7WC1Fl4s8w/L+NgwGl51r3j9ciJ7IabSBZmnge5hfIX6zVMaqxniOaQcxUKd6njXvLaK2lx2LM05YYbc35dNrQWb+vIatkMd0ZhX1gqy7GlbNiQRjaIiJe6yibTj/E2GC7s3jY29Kxr2FXl/nmN5Ac63nVHTrN6bMGFoUkHr+U3o95g9UtO7szxfpv3Ph3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXyVC4Y3WmZTc1xA1KhZ2ngdIUGTw3rghvjXnLFgCx4=;
 b=L6BrPxU3Wmr56J5lH0QxIrapV8k1zQRje4VT+yzxiZ8xdwidwAQ6RDXq2uNcjQ3qAGfcNolsgE5taxY/sCdnw050cO/iY2dNoSu0SPypQDiTgY4Df4eNew3hFAaYJY+vrDCqw/nwOl0XbUIELIIVEl7qZ6En1/BjYZxlNtymBOOXcX0B35cxKFk6Pxfm9YK/GAruvmNb3T5vDrG64hc7sErVDiwlQ7zTEpSWwY5ZCLlGShxxfhVQ4PzggDlfzv5OJpNWVGwiqDt09UMNskKEqg2x7LBvwCOpHG2vLxMsN/+O+/8y5z66yjhnAZrNCwSzeN0tdgEYsrWAwvW/CTEBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXyVC4Y3WmZTc1xA1KhZ2ngdIUGTw3rghvjXnLFgCx4=;
 b=wu6mRxoivOC31qCWaVRPevaHTGhaOTiu54ruNzSJ485WRVyZf23OaDSaIW443yVUg3V7RDHZrGLylMgi58clydzihJyeZve4g0IbZZJ5j7UCtk9r5mHcwhKiOj271ESRHuskl7cUsekjyFpVYixzkTKMKpxJViBGA+VZwwN70jQpO2hTlXvv/SeqlbGe2M5CRgiuV/NNHIIZKMsNuZ46xMf14/ct04SqR1b1PvcDDiTCzeoQIqd2hWw13G2lBkGF8MkLrK7YWmg7sNrWR+QcjIyD6IgKRQV4RS34oatd9phr4La7b3s2RKMBM0IjqKFeqG84cnemf7A5N6+GM8n6BA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CYYPR02MB9688.namprd02.prod.outlook.com (2603:10b6:930:c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 12:28:20 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:20 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 7/9] migration: modify
 migration_channels_and_uri_compatible() to incorporate new migration QAPI
 syntax
Date: Mon, 10 Jul 2023 12:27:48 +0000
Message-Id: <20230710122750.69194-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230710122750.69194-1-het.gala@nutanix.com>
References: <20230710122750.69194-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CYYPR02MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a90143-38ef-4357-62c5-08db8141256a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBZ+SK6Mx8o9Y3O+yKzWlatTu5S18QDrV6AcKBrRQakss3SVTA7fDz4W1CS6xVBO4U5SQ5sqiv7Ge/WEN5VdB2X87we6FNdkuft/uV8WGz6SX6SS1bNP800434wq5yA8HQcoQaCjd3n7cR9BnyhflPbaEokb6+hYPDUac0bNV73QLyS0ctF+zmIbg5Bsg0CG9GLZEOzpbvnpPa19c10b4qH1xypCLYC9uDQvQeqnBPsXzKwb/7D1k+f5Be3nFCB1KMjacQSACVKiOK2xnLR6ZAT3E8GFzUuKzX9JLeBO+D8VzQVNqlzftvUKWm21C+cTOTN9BQd7qH9JexkrZAm10CNiCYuUfexYd5wnJ0Z+ht0+55LJhAcGCwSfME1eDkKYrw/LY8LfUvy+vlI6CltQdywzPitiTEsJpbnAT8sQ7vZDfVv2B2nAn4ARNQ8iq2LGPOhdt9Kg1x3mtBS2HVYgP90EOMgck7rYBiOD4GBOVWDOpp25g4XQr3fYSi75uG+UVeEmpPD1HvwdAbtTCN7BjItdnaabcYdG1eX0ZtPCxejAaMMjeVoEFDZFKccfXLSIxJjLpOdZ+V1S+zM+Zzr2aR7qgHenYCvkveRct7uoOR7cHVxDMnh83yslUSEb4L3c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66946007)(66476007)(4326008)(66556008)(6916009)(186003)(2616005)(86362001)(26005)(1076003)(6506007)(107886003)(38350700002)(83380400001)(38100700002)(478600001)(52116002)(6512007)(6666004)(6486002)(2906002)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mGwhIRVY5q/Nk39OV17CloDkF2POQtcjH+av2zZrrN9ZbKpEJEzcww1DztZO?=
 =?us-ascii?Q?a2VBWnDd63UZznXP9s8KbDUBFPPeG4v9mIwKBTdVmBo5jWpGIAPt1kHQwAZp?=
 =?us-ascii?Q?RMGK22NZGE00RVSD9yac2YEQEmlJ/UU+SCbSn/E9Ned9Dij128OzsW34k3I8?=
 =?us-ascii?Q?oBiLRofa6jyJmJPGrv2VRwQdgg5Ql+xeTXFR1M/Dcv8er90zOalao+dkGhHv?=
 =?us-ascii?Q?MmJGN3pVI7KEmgeg5HX/VTtLXXPJ1oVIHDPvtA11gpXYWS6ZCSUUMeRJ54Z4?=
 =?us-ascii?Q?vBamxK/87IbKCq7djd910bqBMhPTAEq8uH2LMSXcmt8DZRBZvu+NjlzpWTze?=
 =?us-ascii?Q?FdCBYoCxF34wTErodjPegDyLGqHij/C/nrcykpihHjWmf0oXD7DDRJbvkYO+?=
 =?us-ascii?Q?oraob5uf2cAQhaj81/iGCrgfm7nxKpzqmnsvgbFPgrNIqEERZSt4Rnvp60HG?=
 =?us-ascii?Q?GdhHy4SnOjA6rG9NYFS37z39irD1hDDgBAdNXOOccaudm7xb3HUmP3MQAH/Z?=
 =?us-ascii?Q?+pI6sAJSt0rTH9brkDlwUtintUUVLqsFNr3C2hF8yV7n+FZLv//dU6PGtlsP?=
 =?us-ascii?Q?YRrYZPMY+KBK5P94qF0Tj8MA9Y1wzmdR+49koRZGUN+9ZFG8qmenwGNQaKHh?=
 =?us-ascii?Q?ZH6k2Vde83PzAXn1605hFtHR54e4FCy0pUs0peX5CjGTvETSpk/8Fnu4vLFX?=
 =?us-ascii?Q?jPQCNuKG6EvyX6wZ18GIO8Yn9u0enohmzsAb38X3T/yIVxd0g3KcPgktGkZ+?=
 =?us-ascii?Q?a4Dl06CsWz4IiswCEAlhJD4boFX3ChZfyMp49kHW8JS9PLGhmhWVShUvp7kz?=
 =?us-ascii?Q?QgvMq2M03velZmfIn4PjYQB54rnhXxTPX7zURT+ojezfQEWz+OxprGkpYHxb?=
 =?us-ascii?Q?WNWyRqo63Xm6z01GUlKaoRX38hpGSney0dORjbfWvvPAGQxBqhrkjb9y8rFz?=
 =?us-ascii?Q?Yt10EoMBZn1Z4d1anUSkKBSk8W0TbwcbZtjc/HGlRC4Swq60VAEsFiRFl2bd?=
 =?us-ascii?Q?FLvbgyEUm2S+oH9UWgsi+jMQoVqeAQE9RMvLCG/EL+pn/cq1EuAlBbhntnAR?=
 =?us-ascii?Q?bdnpxN4wC2G8xLNUyFkaQxyk2cw9M3QNhZPL4s0FOZXA8I4tbjHVswqhkcpG?=
 =?us-ascii?Q?/ZqlKOCogvuJm5zdHGqyTZ8zLkBmf0HShybR42ghsdHROB80PfHI1BRohUHX?=
 =?us-ascii?Q?8wcpAxiQeAPRSb/woxHRmGHYoagvQTy74s9WybWv9Gh/wrwFUDJROZJpQ54b?=
 =?us-ascii?Q?rxJivIgFKhPnJKXo4dv3jPH33hKrdbCd7iBjyb10COeX5iN+rDAV/TBoy3tE?=
 =?us-ascii?Q?c6j89n9BueIG0ZM0XylBFsNbqf3P6r7VTErEe6/S9/dcLZvfAkVn5Fw1sgy2?=
 =?us-ascii?Q?b22XDE/SjdcPDro+IEZ8twwvujgNhgwmNFM2wE1+4D2uvEUzMJWCBHalfPiS?=
 =?us-ascii?Q?/y44JH+tyBytdt+kWu1PotWEeu5NIOnBj0CRkPVPPntkfhoW0H/z2VGI3kDf?=
 =?us-ascii?Q?6u6uUJkMVJZYDT9kimINLuUyedxS+/eCqpP/7b1+leJpsxHIE/2LMMo66gIk?=
 =?us-ascii?Q?OgFg13gGONplojpfVNMSdrGnd1nLOlXVy2Y7TNJmcRPoZmmogj+kPI5vUv55?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a90143-38ef-4357-62c5-08db8141256a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:20.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ6zOFid1Ow0zeQKxlYfie2RXvgBWc1Br+uLbk5lpaoKfzoRGD2U5KlJ+jlhzO0bP2VJ0ZJ0ItLEFDHEIfQqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9688
X-Proofpoint-GUID: RHSY9IwYpHf1jTcVk9FsyMXr0PBdcUZU
X-Proofpoint-ORIG-GUID: RHSY9IwYpHf1jTcVk9FsyMXr0PBdcUZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
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
index 65272ef739..62894952ca 100644
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
@@ -481,12 +484,12 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
 
@@ -1717,12 +1720,12 @@ void qmp_migrate(const char *uri, bool has_channels,
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


