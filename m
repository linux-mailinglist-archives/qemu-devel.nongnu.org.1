Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7D751F58
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJu1F-0002Xp-NW; Thu, 13 Jul 2023 06:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu11-0002Ui-4B
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qJu0u-0003ed-Ik
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:57:42 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36D7nigq006214; Thu, 13 Jul 2023 03:57:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=PNpno2H7w77Gi1b/qcAPoywJ8n+HTwoAYGyORr67w
 oI=; b=ZBZ8dx9uwayKwqTv/y4p3omfvlf6KVIGZq6jS5z49IdXDXzDOFSwrOgBO
 JBkNTK76GBp+KlyA2Z/7GdaB5DRFdWmjhSP1DKUyCZg7wnkXJVNjAGJT6wyhnkKI
 UK/vrzQM3weoJagv/1n+6nta5v13RNPq1rifvnVVKL+OEASOH8ObWev8qAFEJ41I
 zDiLTUozu27nsYE/wKLB4UypkGO8rZKRcu6NNc6jTSZUrZf794UPetm/SL6WVcEI
 DjAZBZblvHMe6EN8IEBeLFtGHgGc5cg8Iwg9PRe2YvuCEeRtKqi6+CK5sPMOoYxt
 yh92oWGQN9OQ2uCQXoS2ZIjQhGpFQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rsyb3srss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 03:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4WFqnUl631qoWElkUe1JOTQ3LDekl0RNVprto+pamHPdjVDJPj9EZ71I4KI9+HvoCewRNkgEM0eZ/XiriSJlhrQUf/4ncW5eeXVjpxr2sezLWBVVlpvwI8U5wsTxA3/1W+2pCFP7+sNHfdHPXt+TwQe+w0bSQvNfv5QwBgBqOd8w/fCVkfStDXXy6HzqZxdCnDt7zY4qHSwl32sZcX2v01M/xE2wzHwngjy7IbM7tLqR8V2q98Dc6p1aYWJlgCbChoJ7mLJ5ay7Tm/xDPbqnKjCKH+/mFd2tnWV7Uxijs9KAKbjh9Qm+roaTRnkvdRhRuITdklZjA7k23aEaMU40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNpno2H7w77Gi1b/qcAPoywJ8n+HTwoAYGyORr67woI=;
 b=Uny9lanH7Ox5mO2yvejk/jdOA/T+aiYCc+ngGtff/StOLrl4W955gPSJ17Ht1on0jj7o6o6f30q2lbxzH9OgByTfMJcxDx5cao/5pujz9efY/30Y7SIv2Q+R+1IdXcAN9aHKwhOMoHwkolSrNcsPE9pCvCm4Kn0J0DufOU4751AxcLwo6nCEpw3+EP6HFh5t3z0w+fVoH+vexe6ofcx1byd10mBsU2+RdDAnD0W0u4/bcPZaaOONknneTDJaRdqzhf13KVGlTtUIHwLnR7BgzLT9+gw6FUTm5FhymMJGcHwKaxDoVGxX7v8JiX76mJYWK4GI4QIvWFPQfyzd6hPm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNpno2H7w77Gi1b/qcAPoywJ8n+HTwoAYGyORr67woI=;
 b=nigXnil89tVFGHXI+ZpH/a5+J29lu74JrEBuWpBk6zUYTb5IXpw/guGF7GSR+VUu7qnDNs2oR+XQbw7ulJlYDCFdKn4Q+xLVxArmgPoq9AmKJTjcFqezB6DSMP1s4gkmLJxC+F1GHOm9pyjYCzyMNQG7u629kIrIj7bN4+4ar/XNtgNsiPQ1vWmiKKI4bYoJClLgmAUn27Iw8XCLu+hnkCIqx7HotAZLasqT7unIFlK2VfZhUq8uS0o+h7YFce+ogjN5agE8NhsuWxIbPrfaPkMf5kLSikFQ6kd0RXgI4BBr4N28Pif3ypQAyQhO9lNq0hE6LmaZPSYK5Igc1iO6vA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 10:57:32 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:57:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v8 8/9] migration: Implement MigrateChannelList to migration
 flow.
Date: Thu, 13 Jul 2023 10:57:12 +0000
Message-Id: <20230713105713.236883-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 610a6566-8e25-4128-a7e3-08db838ff52e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8f7DQ9NBRK8jOC1sArRCRLsGfl/XinDL6Ev+1Szmn3clMlM/RTSY+Erp/h7IOQwIcjwcVLvcG6plstmVvXpZvi9blu0jfYhxsujmISy2r4NWoD+5tinvHSCPb1b5jr7Qszi2ptZNUPilCqjN6EZbDKfaNw676WkbQUfCkvXTdi6Ril+mA8oTuOUM9lR5c5h0gpaQXNlOwo4YQmCh2qxEPCttYnMFEZAx42oH7j6woMS0WISAKaEvPvhPxU3g9QQS6fSYLGEmR78bkC5weMNjVjxCubUX+p1X5Be8OSxkwCXpcVfsUaLecuUqNTX09ONz/8svK3KfcYsk9ePGNqIgBVt/+2jb84xQNMAnSaLYcdmsLk8zbYm789mRTT1bQalROjl67D5IIor7e7gCrSfP5H+5ct6N7/lUbQk75v7y2lSOYLeeH+gMcSyTCUKPJKLIWnOhh4iwosq1b7zY0VSWjEdpJG4GwX8YTq/q6HmKw85Dj+u1GRD0hRbtdjaD1eqGIvhaEdR5yQk/4vdl8RWNY64u7yWgwn16f4vOVAP/4cx3MRgLBdblA5b/h9zeZxQjCn3O3Fd+/gDBt6GWhr4rSeCnKlAPm8JmP/LSCS4h8Pn0Zh5YWbqusTTZqMiJPBC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8936002)(66556008)(8676002)(4326008)(41300700001)(316002)(66476007)(2906002)(6916009)(66946007)(6666004)(6486002)(6512007)(52116002)(1076003)(6506007)(26005)(186003)(107886003)(83380400001)(2616005)(36756003)(86362001)(38350700002)(38100700002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HT785WlV8o0Kq/EUXiVUg60ek4WYXQwRA64hz+SFMG/MOlqz0xegq9a0iMpZ?=
 =?us-ascii?Q?Sk4J1xkcg4niGw17deRwF7V64jsBoQeXx/ZRyqWGYAoZjcWUlMQHIMhtdw3c?=
 =?us-ascii?Q?ub7ePaqMby12DRS0+kGEcPfJaVbYQ0jFGBO2NCHmEAD5N4xvl7ji1VTC4gYq?=
 =?us-ascii?Q?lUz+KuyD/tzZwBfn5uBvwPwq02F3XtBlHRs9CMoR493WLFAyznPDN8zO/fLh?=
 =?us-ascii?Q?s3bqriXUBQ2U7XxqeGaHDTSvzujPkjur8IVg67yPPMohpAYVfLa7TBCDjLDA?=
 =?us-ascii?Q?Mq1wgvY6EhNF61t3O0dzei7l8pUny4MUFalPz5pV21quu+qpZ7VAw/GijKNG?=
 =?us-ascii?Q?n/yp/vLcA7MVI56NmSzLS6tevsjxKtv2Spk14g0gMq2LmOqWvWxUd1ockxuD?=
 =?us-ascii?Q?YDrXQ/VRYA1B9M31ak9VF8uqh1kOEuj3xI8KxYVrqgzfDkxpThQD5Rn24FWb?=
 =?us-ascii?Q?IXhvGvwElEaA9cIfSyV7/Ya5+Er7EJEh6WEKGFX7bCSWeg6W5DAdnkNYkUGG?=
 =?us-ascii?Q?ezFXuMvqo66f/zwHt7ShpZpWpdXqwJzAgta4WTS6S06pfo1dNcm42MvgT2QU?=
 =?us-ascii?Q?J9rZly9p4F2K/krCYIxRq2CXlk/M9fC+z9Wfx7Q1ZevSMk3TwDNSbfV2Ja99?=
 =?us-ascii?Q?ywiKw/RWXVKb8r2fCZUB/8k0ptZ2bc9zHfZ0CjyviX+PV9WEHjaFvKasLVjF?=
 =?us-ascii?Q?rDkrUUH0EO2ClLWVLa3VzvGZ7ZBgAK9ESkNAcvUmPdv8zI45q71MKXfhqhoo?=
 =?us-ascii?Q?0sD8hqamEbSr+9amV3eNe1Su4Fj6aVbECidXDCbGRnG0J2CNz0n/AKYcSFOQ?=
 =?us-ascii?Q?n14ILpPU7aQIxOePkOkdkhW32VUyJ5sYhZTZFLPQpBCIe53sG7NxzA/UP+wr?=
 =?us-ascii?Q?vleTYb0X4X/5XzagEZ2kIEw1E2vjEaeW3Tr49R/+Gck0cIm9zcRf4RD+WI1M?=
 =?us-ascii?Q?ui3sEUqMwEwZKMXqDqO305/9kJOFMmRXtowr1WdsqTWc5R19dSSgagA8Td33?=
 =?us-ascii?Q?+WcskR1tjoY/A8+Do/ogyNH0kCgyTfef8UbsfzL6CHlj7FQySMpSJEz/Hhgo?=
 =?us-ascii?Q?X4/SUGyuLk17YRhk8Zl1EIdhySp+erusAMZbwJ4v5wPZCN8FJq3kFf0bJdzN?=
 =?us-ascii?Q?TbzLQa0Sj2nqmyOt69UwXFUdkCjr2adz93OhzNWZcYgCuvej4kMiyyHIga4O?=
 =?us-ascii?Q?UfUjEXajFHkUh9TPxvYNLkDq5n6swF+j7NrRcQjwn9OSAaZ3g8EA3wsOsoXP?=
 =?us-ascii?Q?V0eDd5+HdYp6M4Z49Xm/LxPp8acLwMmN2FB0K+b6qGst11SO4RqNEt9wH4vw?=
 =?us-ascii?Q?U32FfsrfRiCVQEwN6r21IQQU+0xSw1h8fmm2rGEY6MQmrRjC5Z90hyuDOug6?=
 =?us-ascii?Q?nKIBwHFx5kj/zJmz2hkDEvKOTvOq6ptC+UWeF8cQtFFMJm7qVsl9gWwgPbtR?=
 =?us-ascii?Q?bN9KUHDNjFfeQzCh2iunURQ0NMDpm5MIuBlbXdHJKH8fRNlFAWKFl4AQbBc7?=
 =?us-ascii?Q?p284fYAzXuVkqsM/5P2cFLD+1w9z759o090oyzJ4A5vDNPYPral8abGdZa3R?=
 =?us-ascii?Q?kTg/e20/4pDedA0ubIDs3makaGIpOz0JP4L6+190PBI9JMLVv94h0XIV657W?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a6566-8e25-4128-a7e3-08db838ff52e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:57:32.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYsRexAxTd+7xum/+IgXxzupDXBIdNoRdwqQNC5qjbNDRxWGnqjTK1I5oq/zRX1+chohWsmAeKx1vI+4gFlvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-ORIG-GUID: Yw7tcZcVZDEW626bwLCf6Mi4MbSyckjx
X-Proofpoint-GUID: Yw7tcZcVZDEW626bwLCf6Mi4MbSyckjx
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
 migration/socket.c    |  5 ++-
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 62894952ca..43c7e4b525 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -426,9 +426,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = &addr->u.socket;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -464,7 +465,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = addr;
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    *channel = val;
     return true;
 }
 
@@ -472,7 +475,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -482,20 +486,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
+        addr = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -504,11 +517,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+ #endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1708,7 +1721,8 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
 
     /*
      * Having preliminary checks for uri and channel
@@ -1718,14 +1732,23 @@ void qmp_migrate(const char *uri, bool has_channels,
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
+        addr = channel->addr;
+    } else {
+        /* caller uses the old URI syntax */
+        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1742,8 +1765,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1752,11 +1775,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else {
         if (!resume_requested) {
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


