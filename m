Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196EE751F6A
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1A-0002VT-8G; Thu, 13 Jul 2023 06:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0z-0002UT-UH
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0s-0003ds-0u
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D4j2hd018083; Thu, 13 Jul 2023 03:57:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=YzIaJ/bd0koyKDKmNq2mCliBn/iKviX8EN6EEhxhb
 9c=; b=PVbxGdQP5MKhUA3VwpNGshZTyc4b0Jmjyn7m2HlMEqAE8d7A80p7bi/Dz
 lYig159JixtbdxGM98SgFK5AONUX2v3Z0AVdB98U6vJJUzAj6lf1/+mDpaTFB+gG
 +co5wyHDU258UzomIbWtThPKSngch2QqNYVS0YL20PvDEgyFASvigTTl6l25DbcX
 cdN53F2w+/mRxJgjlUmt4/vANFer8W0FZvbHDiMV/bgg2kc2sjpRlX06jmEM9ETA
 XBZ/FxRYuJX4wratDA+d+G7Lm9WsFOhtHk5MScxb7NwoiQzBGTyDe9aAWE7LLW+K
 N9z6QuesITXHJ9yU00RnqCeDvZtaA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3hrmj-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjbB34SG8bTuGEr8W+1oftGkUpM5X99hqUBmAQuPlppM1eiZuB+u4H7ApMZjSl/EHe4J6RDd5eGR+I1BBqoGzX7aRuU1Vy9z1xnhJi5BtLLnDIjBvCMpUKwH3yZjgpvN0A+YE/W6QDiCtUAeqRaPNuGANGP3EoOCaGo0WD/G9wCcW2S1mzqPac/tSBkWUq6QuOSxkXNZsMLvKV/V5DkL1ZSpFo0TeqCOLTKbs5jbs/b/Azyr9kdKg6YS/CdN4WmD+h13UKU4RbMkGs2tX5aienebJ44eSWQyQEc9EDl0ukXrBbrC+fqfpNWDeVB7QSt3Cqiy48A8fmQo5yT4yvQeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzIaJ/bd0koyKDKmNq2mCliBn/iKviX8EN6EEhxhb9c=;
 b=dJPi8Ie5m7xP6yML0MgAf1K961PHl0Oqkxb1n5Vaz9Uh19F4CsqbDBy3x98Fo+2CTM8bUZ4g7Yxtxtf7hU0dJoOz4wKXXU5rOQ9detAaEA59+On596PFE4vExjC05iDfoOF0d2nTKFpqiIjQYuCssCK1HDmK4yx3NGu+h4GxRXk2BcbB/0bUG6SEvrkxND44W3TXcbaQZObPjrSZW3RHHECjrjiuDDWzblJFkxZpwKG5lh9U7N2EcKSpMuOGKt25dxA8g/Ulu+jhAfmXCXE1ijWybazYafxtQmQukL//X5LE7cJhaDpB0H7+vtY9OJu98z+Nsu1fZy35AJAl0XRlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzIaJ/bd0koyKDKmNq2mCliBn/iKviX8EN6EEhxhb9c=;
 b=L+gxYBPg9CHey+cKs8pckO/NBTUHhFuN3yMqMQcJdhKdoN2ZXaKvc+Slnqvmc/bWK6OW+z2KbLTKHn25FgrSlnmErZcrXrEPOYroacWZ0R+NSgMtYnFo+2jQzDmd7pOIvCJawWT7G25ep3D/VdnHpincqn/oengiCwv1AD0u3ukHCYNQ147+NE9pIDLNDrP8aukDpJTvjM1UEo9PqAh322NhIf7JleeTHwkjTDE+gQFwneZDeLLrGislQq+GopGk6+/xstqIQqYWBXz1Wlyrfvw+SDgKCeTK8E+QOczdj3OCy9LJAEQC8Jba13oTgYZ8r4i2KlB8/jgTc8bEWCrQcw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:30 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 7/9] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Date: Thu, 13 Jul 2023 10:57:11 +0000
Message-Id: <20230713105713.236883-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230713105713.236883-1-het.gala@nutanix.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::28) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 71da7d31-32f0-479f-09a4-08db838ff407
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npew5EOX87FD6mM4OAVpQgg7h09k3497x/5Rct3Cn5kZszmEbNj8ozbBT5Q27j0Q8fsHiBodQ/5I4gnKL8Ab8bOLOhR3XWZuKSaFIjugIb6gSvdPX3NUtS+ZjPHT/Q2dfwWRmIvnMrsJT8JHsaoyMapS9keVY8N1+nNcDBELHp0Tx3zYg+9pI7Vu+4tQ/c3gU791wpnBR6TlUu7fIqtKjBp7zU3Km6mtbMwGda0A4jzZY/JSIVxKuTZZqJ1whKsSwDDUmT5PxdSSrwojtNwDZI9/CpZ4JtqcAaTwrx474vkyjXpi3w8I/V1yXB5asn71tgY4jSQFFHhmzCPyCQ29w9owZW8u1RLlRlsszzuWkeotDEwyWnSgkh0yMpPFJdMx+B2JI9ttKTpTOJuHdC/ij6hRXExreADvO98WYE8w6321ygo9MZYGjw0pphW63t3v/HeGBWAZvlIJkQdEjMETUWDcZKnNqn+yf51SizNJa39peHQ95qEGYCoFJKeASgazjSheri99UqNLkdZJFt3DPwVQ9vYS5J2EyHOMVNUUByycynjznyo9n1yXeLKQCHoPzej/6HXTGmAsz7l5u1hNHc4DoS04NaBXlglz3cgBz6pKuUqW6izJ029Tt8IN2Hx+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4YDr9sDeKDPpmfhR301ho6RQkAyUKo2NXSj6D6k3TCZ21auKXX9lzrmOlvL?=
 =?us-ascii?Q?CKZ0IgkhqjBeGECK2aij0UQF1N7kgiSgKYnA47MxDihQgPXkvin0wPOAPPMS?=
 =?us-ascii?Q?gKSNH+jdEirW2QZ+urMs+u9xapdT1+3xeQPsKs9rjvxa/85v2ZMUoTrLYfJw?=
 =?us-ascii?Q?g2A+RSc+PMY2bL/zPc/mZvohUHZlzXVjqZty8AQlx4yzaR1iX+tWifC3mJXK?=
 =?us-ascii?Q?C5zKDROifAPRtZ+QZ40izaVxYZBx7j+2I/omvKOCB+6ugxgj6VnzdbWoiPlv?=
 =?us-ascii?Q?/DM4R4M/AxIGRJ87cRW7nFvNeWKiCDLuW2WigOf6t2NTv+15bCcWQgX4qmq7?=
 =?us-ascii?Q?xLMwOxacFN2yr9yA0IJhcygHyomchmJLYy7GoV7vMJmitAy/Fzi6PL+vkCqx?=
 =?us-ascii?Q?PugH/yAYFKi2pxa3cmG7mbJEK4xLxg9prsOWvB2lMGRKoL+Kjo//f4NjrT38?=
 =?us-ascii?Q?KFsZLjnGDeBm2KHlR3+OIjQIta73u2JD0+KULikVvf4xcC22+7ojTs6ZJ/oD?=
 =?us-ascii?Q?cutJtIkdqRGqKebSA+VHA6ojp6nEmeb1/UNBVaVEpETsr7XRZ89px0NrXcZq?=
 =?us-ascii?Q?ya5zC9Jx7gthnUwbbr11WVwFNUQKd+AhhuwLTCnCWDuYgPIoBsPgH9qmlE4J?=
 =?us-ascii?Q?yC7tmA02Zj87UBttdvQF2wzhUd4HFhSCCbX3W426vc96L11xzP4/5/RpnSKZ?=
 =?us-ascii?Q?hdR0cO0vpxjELooCTn80tuX5N90eGq5US4rR5lUmN/UzP5Q6E+FeprEl+nh1?=
 =?us-ascii?Q?XF95Xp458n1lAWZRkY0ug8/9L9F3FZfVklb0Scw3rVnMHCn9Y6MtWzqNNpfC?=
 =?us-ascii?Q?zFJKbtdOkIcPlDmo3/VJ0Yro3pwaGtc+Yb0NLUM6wVUT+gcIAE5nnKDcR6KJ?=
 =?us-ascii?Q?khNzTXAgtxxGuyuoLqyZn5sCPUOCXxOqrv6/zsrXLIJHqbc8UXc2fiSm2UuH?=
 =?us-ascii?Q?6n52mPaNqrbt3lrxRrQmmXRg6dHubMoAmfeReSJxYL7b/VJtGaXhZPDGz1Ua?=
 =?us-ascii?Q?c4VF8dRGdYqnFCoe/ekK68lIqlbY1em6Yw6/VG1hMEJsAyuIU3/vT0Yv7HPU?=
 =?us-ascii?Q?k91E154UZdCeUkCw3ZpJR/0ipWr5R9/ljxLUetgXSRYq+vFl5SOCHnzCnY6S?=
 =?us-ascii?Q?V/grU/pxcBqKDarCkcQTjXy4teMNNU1iYszfIGxcIYEzt/ahjFJ7SXxIXfM6?=
 =?us-ascii?Q?Tsk0Udk2Nglw/mVraYt7+rpf0N8vb+PH3/JvXMrfSnAGXyTZ3AO51Sl2731s?=
 =?us-ascii?Q?3YgEcSB9udCMgiplhb9l2TZ9XgRCvJy6JhU3bPGSws1o08M4GbLu8lM5EkkW?=
 =?us-ascii?Q?zJKIgHZfDk9IV6u2RSvIcIH9ythjXl6pMO6e5Ya0qvKW23UGBNUIAOqZRqa9?=
 =?us-ascii?Q?+/JAV/7pqXaUByuNqXYHL8nSbQgHucwQGPq089+qf6Cp+mpC9op2YLEzV7b0?=
 =?us-ascii?Q?DJHv/RET1Ca+mIxH9hqqNvTGp34hgfCELhFNksMZdWwYKvt0YF5vJYDhEQ1o?=
 =?us-ascii?Q?MvdOKAS3ek6B5ePL53jJqh7WhWzteQsyFd6oIyW+egst1ZYW82dYg0gLjEiG?=
 =?us-ascii?Q?4ULu+bPr20tLyjLJlfL3dnrbLM4BMmhVfwKbN3ajUT8NS91sy7AsMg1+B2Xh?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71da7d31-32f0-479f-09a4-08db838ff407
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:30.2379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wepgirUx8Uq463AY2jtBoT75O/rwua9xlpIDs0XqXyAhXFAOMyuW8Cqr7zB+hsV/soqIYJxCxMNs0340XRyU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: 5WjpDbZmp5ekBM1EoysFldaVcoAORgim
X-Proofpoint-ORIG-GUID: 5WjpDbZmp5ekBM1EoysFldaVcoAORgim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
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


