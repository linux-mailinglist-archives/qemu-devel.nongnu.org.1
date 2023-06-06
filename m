Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15D723F28
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tk5-0001hz-LM; Tue, 06 Jun 2023 06:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tju-0001gd-7m
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjs-0006Vx-2r
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:33 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567sj3I027360; Tue, 6 Jun 2023 03:16:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=fOLNY0S9vC4KJRdPt8Wt9uTdytokpM0oJbx9zbU5SBM=;
 b=PZhSjWvu5Gk8NI7KdImF/NZSvfoUlKN5yttbYKawl4uaeh46UxjqI0RFfxiHf3h7JqPG
 oCy/ntSJyLq3LFd3WwKQMxMjqExNvfz7hmlSvyKLP8bRTDNtDMv5juaJ3yTm1KKbgVq7
 q0ILabTApcuDuEWD/UKS44fFeqFCwXZP344vYn6IFav8NMR5Ps/lGcVSeAA+qvy8QQKN
 L9uDnZHtAzFrYjdiB5Y9kmkClq+70lUxy+dCK97k+FZGIZTu5jWrV27TrZBr95C6z9ki
 BVSmNeF69gwcmRcCtA938eThcIVNMUa1wvEP9IyTxj3cyi4fpx/rW6rMKYYlbbxUK7+L cw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3r01e6d007-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdD23Ntxku4NovMzQRV6/nRrTh4GMaEqJRHKRJUQ7JxKo6m1bwcvV7h8IBP/507qbnKNTxTfpjCq48y2QXJY6auTXlsvPjTUSVRqpt4oRKUlEhRvx/g106vSVNdAplDdzWt5oDHIQWjdZqBxD6eHDPfK137ReTFS0d8RJJX3kEHvKoMIsq0crOg7h37PqSdBWhhoLT43JAgJwxem5629lun2aAW1Shep5TZCVBUT03wzWjRU3r1irH82vQy3ZHcNwhB8/O5rQtQjn9Z56gqP9oyboUbLlNcMoWr+QNqtg83LrGHKO1hOu/xJtR8N1Qpy6HMi6ZVxHjdqaYvwhGxIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOLNY0S9vC4KJRdPt8Wt9uTdytokpM0oJbx9zbU5SBM=;
 b=UYSaymJZbMnyNqPryHY0ULSwhXeJpjfHIgjOGy3oKiKatfWom+LRkw7Km+wQ05XRVLoeugsE897NhS7Q8dclpv81KZctE+N408acYZwgSBDb3+ver8m9YLtFrQQoAcqfOHi3Ntub483wdyLGLId5arLNtrvlr2TeGb8FA3ttHhdXC/QRfOMHRQLYeKh4QMoKNUo8Ptrzzi4Tw6OOT3SZgXjHdHQ4RRI/Zmkv1J1ORV71qxRo48f7pcIl4aAHnOhDZhyYEsuE6bkUbWKqec4KmVfJRF4oOUhgpt1l9EM3o77MtwxdCzFR7imJptE4eGxUUI277eJAJGgEpho2LcFWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOLNY0S9vC4KJRdPt8Wt9uTdytokpM0oJbx9zbU5SBM=;
 b=fmPlXlJn0R2rjWJub1qQ+RJleWRuPT3EVdyRRz5RO7g6WLOf4vWQZ4SUtknSrqVSkU9khu/cReRtAdG2ZKiGMDirrawkfkNL4j0Uij1k2FKY8EEdy7T+j3o58QW2SlHoEEwATOSwnsfYlDxt6gfzymdsNMLBF7hzkifsVxPzvnezUseEuqCDS0rv+/xAxKSK6U78rbYBCNvqfPGdVCdf7GHIpLQL/Wg2/fPK6k80v7qUKAPUlhNEzOtMboCW1k1Dxh8IWa18dcv4lziWjwvES6ZdA2bg8YaEfd8NvcL2P7yNZpa7+H5IiIZvZ+iEFw0xjljAke3GWqzuMyYOcSmymw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA0PR02MB7257.namprd02.prod.outlook.com (2603:10b6:806:db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:17 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:17 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 8/9] migration: Introduced MigrateChannelList struct to
 migration code flow.
Date: Tue,  6 Jun 2023 10:15:56 +0000
Message-Id: <20230606101557.202060-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 796df2e0-4fec-4e54-869b-08db66771094
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihB8VNNFbnD8s5kNBj81WrQoKg/WYwSC6yJxNG0EtM8/LcRwqnMHhSBiMfN6QOZvZVMW3tkCckDOXVer5eP5TfX0v5lTzK41eu02Q5j3QTdgZ0MQZLjNEhzZZGbKYDUzmX4iqnyPjKQMOJ6cNlgyy9kfqigBeWq0BOm+lH4vGI3nNo+DaP7QwBqA2F3bsYNPgxOGUH5tFSAMFc0gx4JRLAk+mDwQueT9yahc+VO5MwwCfqds8ayVoqrYwH/c+3QPbzuL+eRhhFJX7GjiTIL6njsEZc37PmDtAYZjKgKatZVc/LVXWw+65aVWjEkqq02HPzlyd8gILi95q/AJgBElsDVtWK5J88EkpOAJUDnCkJD4N4REgs9qPe3EHYW0Etisc78A2e4tKCHuCNQhIkuCelwqxOKennlMnyOM0reEduGTVn7tSvRz0WECAc/si/sQv6G3CR6ws8Uo9p1C7STctBJgMTgiGAlyZH7AIJ1htktbM+sGBlklX7y6u8jBlke0Ql+CBtF5QLHISVTRUOaur/D5UjVMKqW48vJUr04McMcBxuT9wvXD0PHrRcYIn3KVKaKG5sQSugKpBoah4DzTtmYj/Fk4qyUJDqkcrwfsG2kHiKLB51VeBzJXZIfTpJxz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(2906002)(44832011)(8936002)(41300700001)(8676002)(5660300002)(316002)(4326008)(66556008)(66476007)(6916009)(66946007)(478600001)(52116002)(36756003)(6486002)(6666004)(107886003)(186003)(86362001)(2616005)(83380400001)(26005)(1076003)(6506007)(6512007)(38350700002)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsraeam1+0iafcHhOGfC9iA/9yf4sNQHRWVftfz3LPJ0JTk+mVljeeruajUe?=
 =?us-ascii?Q?zfSx1rq8egZ4oe5sFGUQizIEPM85HIPkn/35n26pLZa4JFC9Ow4lfQIrTWNC?=
 =?us-ascii?Q?EhkGiyKJuIDiGT5HR0E9c0z+oqBDAqhqWKmo8tzIOO6ZHzLgkxQY+Dk36e1u?=
 =?us-ascii?Q?BltuSWnG9saYTiYP/qlMEPSnU34hNJlU9oowzhDFi7HwF9QmaLoitKvRQMlH?=
 =?us-ascii?Q?GxuxrchEx1L0firTq6ZiGhOtRrWZYpoS8ITWqXN4sXeiBtT0o55b1NaZtCGG?=
 =?us-ascii?Q?AlUSor3pHph5fNSIn4teikLbspuiagSc0T9Dn3vDCwP+vwE+gZTU1Yi7ntcU?=
 =?us-ascii?Q?5PTE4Zr9eruL0UOxdGJULhz7a6ZpUT6gMdgYEUK1ZE8nBqkJvasOM4NqF3vS?=
 =?us-ascii?Q?oqAPoFQpdnUUwGh44D7Puwo+WyLDUu4wU8cNhVjkbnaMFi8c7lOlJre/NBl4?=
 =?us-ascii?Q?Bqab8M0h/O6h47L8NrINyYIZzNOralid5T0/ooZTr2eE/7B1Cy2fEhC4oO0i?=
 =?us-ascii?Q?qjgWuYl3eWvb2SDAb1uA7zwS9K4052jBa/KYjOac+EHzgx/Y1iY19p6/XpXe?=
 =?us-ascii?Q?x63It2Y3/7hocIfkc7dl6McQGMvYXIsgogICQHdyOfG0bRCkentjDn0UUhKu?=
 =?us-ascii?Q?se9XuXYbdzbk0stK2i7zp981RXKWIkynV07HoZMzORsJHYqiyU4UVB52DbGD?=
 =?us-ascii?Q?05fmvuj/cwl1WY2eGs41naBBYdid6JCdKAj+uL2da0zpEbFkW2c0MlTaDmfD?=
 =?us-ascii?Q?bCZ2eWe9PAX5dRJbc51msvnMrN8a+WDZip4K4fSyofy5kphannwVPNJsUS2B?=
 =?us-ascii?Q?a5B4SNC32NqzqyyRvxxQmJTxYmAVY7iqxQlZRCg+2L36I1pJ//RfAj0uwVj0?=
 =?us-ascii?Q?kzg39+icZAGnogpYdPN3zwJNhn3AvVKVUoS0mvIkkDaKIJZAOmKQptjyQ0rX?=
 =?us-ascii?Q?WxjFY1QNQS39pffvviqifSTrABWieXyxhvW1NOa4ikpmV1DFeTpvaFgNvHYl?=
 =?us-ascii?Q?Xp7i6Uq4AdXtboCkRnQDsxJNUr2U+ckC23LcLltL5W26m4Hvn7ErM7N5NOgq?=
 =?us-ascii?Q?O/N058UQIUD27v2hu7eEbRvQVd0a+uQXYq8ywppLhIcCdWLQ3eF3artO2Vi+?=
 =?us-ascii?Q?Raeavl4uB5Qtciz04DSbiYrVegYeCAhGqMcZCSOePZlcU3mPhnseud/5E2Jw?=
 =?us-ascii?Q?CHCeZocxzgnTRJm551Mfc2BmiSoah3xcOs0oMaFA4NMU+5WmcxtcEYTfETJ+?=
 =?us-ascii?Q?Scv147D6Lel3b8939AqwW5A7f5N0I4FeebfqHkbUqYpcYXgHoKVBzV97BA3j?=
 =?us-ascii?Q?6R06rUsFiwB74folh7bC+5LT79d6VXdbzJ/RAZ/po/qxbLRZURjNuEFc5z3h?=
 =?us-ascii?Q?8gS/feeMiN6ThwxBjrL9ohixMSWngoZiKRSMeVMrtDkisDOu5XqXezmEs3cJ?=
 =?us-ascii?Q?wg5BwZcVYYINEBZBPRqJL997TmHk5+aCZ/siuHsF+W9XqoX6VsTDEjaungik?=
 =?us-ascii?Q?KzLmLgKdCoRIrbJwj1lz7XfCjIFJxQFdSk9hBEIL7S5RVSfdkR/DVSXQ6K+2?=
 =?us-ascii?Q?qrG0nCs91KquFouHeCV3Mz9au0RR5XqDFjyFAiZW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796df2e0-4fec-4e54-869b-08db66771094
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:16.9655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+wyq49y13van5ayQIruuUxTEXjVUdx1ZyZomk5AJjbb+LEHd3pKdt4LMV6qYU3H08ArUojdiHPfOudNlB7MNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7257
X-Proofpoint-ORIG-GUID: dAGSU62W9dgMDPI2JKJ6ui4EtsWyFRwh
X-Proofpoint-GUID: dAGSU62W9dgMDPI2JKJ6ui4EtsWyFRwh
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

Integrated MigrateChannelList with all transport backends (socket, exec
and rdma) for both source and destination migration code flow.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
 migration/socket.c    |  5 ++-
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 98b797679b..9a0aec3ecb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -425,9 +425,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = &addrs->u.socket;
     InetSocketAddress *isock = &addrs->u.rdma;
@@ -463,7 +464,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addrs;
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addrs;
+    *channel = val;
     return true;
 }
 
@@ -471,7 +474,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -481,20 +485,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+        addrs = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addrs, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addrs->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addrs->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -503,11 +516,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addrs->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addrs->u.rdma, errp);
+ #endif
+    } else if (addrs->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addrs->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1699,7 +1712,8 @@ void qmp_migrate(const char *uri, bool has_channels,
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -1709,14 +1723,23 @@ void qmp_migrate(const char *uri, bool has_channels,
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+        addrs = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addrs, errp)) {
         return;
     }
 
@@ -1732,8 +1755,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addrs->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addrs->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1742,11 +1765,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addrs->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addrs->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addrs->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addrs->u.exec.args, &local_err);
     } else {
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
diff --git a/migration/socket.c b/migration/socket.c
index 8e7430b266..98e3ea1514 100644
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
@@ -114,12 +116,13 @@ void socket_start_outgoing_migration(MigrationState *s,
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
-- 
2.22.3


