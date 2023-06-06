Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D097723F2B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjp-0001eR-S9; Tue, 06 Jun 2023 06:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjg-0001b8-EJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006Nf-RX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567WVsl006549; Tue, 6 Jun 2023 03:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=EZ6U/hzp0czYTtKNuGxn7rm5UWUAtByvFgaypzH72yw=;
 b=zV7bSHJF+DvN/aIE8wPAGFrNSVUEK8y/cQO4aWNn67Udg/2p6DFnAiWlqATNn0ElelI0
 latuTDFfDac/s2ibNQNQ3rYh5JWsdmSPGQS9sWajuMrWc5Kyy10M6yj/Bax4X6q/ZiNY
 h0Li6+yuDwMozUVUngLIDUlnQy3CGuzBqbFVTpsOR1+UdgQNGE2IgOyKGl69mpH2d60p
 YAyiM1O1oPlqDMKIYRNMM6hTlRlPYFgzh+9OrdWubIFW95fkHcL4RH0J2MEpI1lTqKBP
 FxpCdCpZGkV9SgoH2ddBB90SHcFeZCpC2Wc+g5SJCzfkt5IuFB5VMtrQqJ9R4MfDd0QW OQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmd-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3u8K+iC/5R8ApkxS8kQpa9A4l3bclnD2p8vwvY805l8Z+2nNPeEvA5fXhp36FYgGlmSQbozXS9ARIRB0VXGKZgotU7yXlX9O38alds2zbZFJDbGhgVXRUEkqGJL0aRlJ95lgtjEEVp7muGwGueeB2ex1VAV+XqRBRE9n9TMe0HjzfHJmzkwgHwU3qTiaXVEphLVTxWb0sHmnoSIXUg09GXE+GbSpuSS76QZmYdw39H7OpQk5mNstNDF6aKp2D4O8N0aZmvZepm0FWO50M7+hucU+5QhaK70zgf37UWf+hY1QpUhQSICtsisTWY9IHy+6sUgHKednS34kcwwU3sQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ6U/hzp0czYTtKNuGxn7rm5UWUAtByvFgaypzH72yw=;
 b=FOwT06JuPYAJNLrR5DPEzh9hOL5MZaFlVNGGx1HSfOeYJCP4Q2A3AqRj2ntdftuJpqk2NX9MgYoJGfn2gAc3v8NFSzDPr5sHvWiMfgZ7xVh/Aa1lEL9tqvwV1bO4XZlOwoi7tdLwEgdVkaZFRJ30YtoqOJHUBPFRAP1rC/38Ci6vhSBzZUj2DIZO8jkgqckmL3V8z86CFFeHyM2Els7AB7BTrZyUN5NLo5gxsIfr4tLi/ny06T5UaDJV+oDmXxsph6BEPZvu2u0+hKtL/lmWnT2juTU4OujHIkKKOZsknF5UxISGdQxrfm9eNMN8rEtS3Z3amx2+g6zLMlnlCUALng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ6U/hzp0czYTtKNuGxn7rm5UWUAtByvFgaypzH72yw=;
 b=Gv1WdSTrpN2DcFPjMeg6nLMpaLXwrfFkHyChj46Mx4FmWlUIMixaBMyef25pxwkrt7KCI7JulA22uN2Z6EisY73w1fjZcY3wqoPk/Dn5zQtjxBv2SQqpfokcR1LPFcy6lzkkSgjsBolMvDBknpN7ttPW/f53rpihwybSxk04NwI4R7Fb5Z4VKKcUnlkI+dVnBCb6s6ZuYByKWYta9VEB+P1mEHctofynr/Y5PQoNMTd7kS0U8+bvxFcH4Fvee+3ACfLHwHBlFl/llJikXGHw52c7OdrQY2F88YTPl2tCzH/Kehu0fIZcuoug1MOKVrhO5U4ZmoDQD98jDn5Q7yvi9g==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:08 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:08 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 3/9] migration: convert socket backend to accept
 MigrateAddress struct
Date: Tue,  6 Jun 2023 10:15:51 +0000
Message-Id: <20230606101557.202060-4-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c55358-9f5c-4192-4fb9-08db66770b94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EM3bRP7HYEJGb7fWxkIN1TeQRp5oXe6HwvHl7HZdxSK/j0/Lto1kt1xfmiGnLweLGJqoa6oVTYrL+CXbouiA2B+BPPxeHOtEWGx6FXg+dM3g/GERTlJh+4pl+ZjSQOYyBV6Yws9ws6bMOuPHC1WXYtjyjOn5qYIXJ7DkNuLym2xgVnIaP+1SD0MKp91IG3y/MLuysfPzI0t7hT3k09wCMI1b9tGhYZIy8GIYEalWZTO7ZRy7aHNdmDRbKvlsqk3KMX8HuYLmZio0sBcfZnOodOxizctTJfxkJ7sUG/YCzJa1083vNmTfZJMy8e1LmJhkM760etQV94tmMC6JwccAEsAgpZIyj0Vnlq2Wc/VCNzypsRdqbc4aUJSoaZ70O6JUjfS5ym2aHtk3j6NsEtOvzjvecgWKeo0pVpPEr1AVnO0igDVfGaD/yxu/Ky8zwd9aIxdhCCR003jyzfgOr6ksjb3oBC+Fw5Bf2PJnDegtiIcCQ2t/ulWLIS/HV1XaDQ1T1ZkfZSo5BOE5/jLzoXF8+caG3CnTUB168uOWipgXKalyWiL7cEICeQyCX7ksZpSs903dIXe9B8qHQGyGbBT8kciZ+Rw5TcXA3npb35+0mptPm0JbWSe3ZJKISA9E59sl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6krHFlJ4wPX5SIbGdSga1Sjya0nsg5eLdfhh/A7/PjRRpGfY+IY/xpE2EcHV?=
 =?us-ascii?Q?5kkeWDyRGqivR+jdbQf9NMHDVanP9c0RWwl7kXETNi9a+g9tW/6agtm0R/7e?=
 =?us-ascii?Q?1HhEwHUxy/x+hNVu6YADYLrJdB0O1SOGVsLNTKOoezPITL1Sl79EiBgQYTNQ?=
 =?us-ascii?Q?Qokx6Syq9ikU/C52aY4K5FvKPhETMhgba8JptoIG7MoLpczze9PT7Wm5X+JV?=
 =?us-ascii?Q?cmTQrpVwFOEIduaezGyegBHHhT7+k/wue05Jt06FCZkJGIQSHqEGWvHE/j4E?=
 =?us-ascii?Q?h75qJqf1YoI8hW6DB5+YzsOvd3NrG+Zs0bzcJFiCKRCGp96Wl7AkPVUy3DX4?=
 =?us-ascii?Q?IQOVe6E23GRIEJyDMV14hOcw2H3j6U0o1DyizJOCZK44p8kAaMi/RH5WNsPQ?=
 =?us-ascii?Q?o+4gHRIq67Baa298zJCkqHTuSrb99Le2HegI3zWw1xaZtkIXLZ1wON/3cWYU?=
 =?us-ascii?Q?R9ndt6SCa4Runs/Co5SGfzsX/LsuXo2NOBsjTP6MNPBEZsFqx4+zc7Nit2nq?=
 =?us-ascii?Q?E9ufr2MXA9w+9jxy0xRg+Zpe7YZSJG6Mf0SseaFmzAQIuWJAfcQb09fzKl8t?=
 =?us-ascii?Q?xzBWLk4H8EggyMXi2a+iaxuR2OkVHK7SNjiyNXbEEhPGyPCkaS1Rv9nhU7AO?=
 =?us-ascii?Q?PcN3SyFFcEattbLiBvZ6fhW2tRB8QlaOD7qL/BUPzRZRJpY3u9VAzhuKslyA?=
 =?us-ascii?Q?FByQB8OegErxHHVxA5Y3Sd9D0+j358LtHcqnSJH3cV5Z4YPnIwY2UuPwaqQC?=
 =?us-ascii?Q?CWycsmctrVwaIjWLrjQuAlqFUobunUEnCiIF1aqurQEyf5NXGsPaCJ52YJPS?=
 =?us-ascii?Q?Hc/14nhHrA3KyygcwBYM05asXK6obMyOm3/EeAXaCmNHqiasup4uhEw8kBbJ?=
 =?us-ascii?Q?niwH/ayc0YPX3p/C2smsQUfgQ0IaCqT4Eip7bHgavOHYPn2YIjrvvKWcvLm4?=
 =?us-ascii?Q?QFLz2rxX6Jtvk+msa0dLaFXDN9VOVNcQaAf2kac4UCxGv/GRSqhq41jHWV4E?=
 =?us-ascii?Q?MnXxodMt8W6zAolPj59oDl/z4Gxdrv6Ylwlk86i9sUaIbVoVJb6jPXPcbvZQ?=
 =?us-ascii?Q?QOV+iJwu5b9VWNN/jO/wCXl/Gv1drWHUTVPyBBoCudFRQQ9WfgJ/gbHmj1q5?=
 =?us-ascii?Q?eht8itdDqV2NrSG738y51MAryx9QFXnPqF8IEYUSqJ1qyiIW2ncC48/RJVVJ?=
 =?us-ascii?Q?mZ6xibdzjtFI3Ahm6lDxTJtwiV0TG/e2uQwXaFzbWSV+M2/yhqdmRsgEBFp5?=
 =?us-ascii?Q?g2sl+ELONTezwYU5cQwv9xnrJCDTvtujYDYYKKmqFCT08dUKEciyFb0B4+nw?=
 =?us-ascii?Q?sscde4YH/3E/4yFqtdvcy9Gxu8SlPsmRBEk85anWuXkwIO29Lz/SJxjrSJ8n?=
 =?us-ascii?Q?IpfGkxMnzBtIIKg9TMzkRC64aKC9Zz2KQXPSekqwRb9//WUHD4FZoPc7ivHR?=
 =?us-ascii?Q?G7fkXErRJma7eEQaRxOOYOzcwwDYj/FXm88qVMAyrQUAK8S8Z7BittSJwMAU?=
 =?us-ascii?Q?D8zJvpIg1U0kNgHnEjkldfZTdjGA6Pifph7wylwDf453vAchaJUQ95d9k4/P?=
 =?us-ascii?Q?hBNF1VPbyWI7CcAUQlMdcwGJPb/+rD6R4gprTVviapgvGZtLQJjmELJx46cO?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c55358-9f5c-4192-4fb9-08db66770b94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:08.5853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6kmseGpw1aLsN0+Gu0o3NvuZvjEiTO2jkD+kVdaxnSatKut3oIVwQqJML8irAiunHWWru6T2yj8OjvNoiwbuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: C9QD92m0PkM74vfXfzXoW7K9KC6YyiRh
X-Proofpoint-GUID: C9QD92m0PkM74vfXfzXoW7K9KC6YyiRh
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 32 +++++++++++++++++++-------------
 migration/socket.c    | 34 +++++-----------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0eb25bb5a4..0554536b7f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -479,18 +479,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
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
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1688,7 +1691,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
-    if (!migrate_uri_parse(uri, &channel, &local_err)) {
+    if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
@@ -1704,18 +1707,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..8e7430b266 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -108,10 +108,9 @@ out:
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
@@ -135,18 +134,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
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
@@ -172,9 +159,8 @@ socket_incoming_migration_end(void *opaque)
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
@@ -213,13 +199,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
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


