Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A597C99DA
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 17:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs3QO-0004qW-TB; Sun, 15 Oct 2023 11:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qs3QJ-0004q7-1S
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:52:59 -0400
Received: from mail-mr2fra01on20713.outbound.protection.outlook.com
 ([2a01:111:f400:7e19::713]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qs3QH-0008M1-36
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLHgpBRKhCFrEMGYhc4ofURN3izeYK0l1AskVYqJNiJy8IDUioX6YC4fPVkl8/3nd0wxnHBxImFO6B9Q1Wngrn07U9+OJTPsIrgvDFtGUMEGdlH1owKioZejnn9Vd8iP7adxR/PyVOJT7MGc0ydb2aRlIVa0kWnVzJ+jzMYKvLTuAaxO+stFI43o/yvmCD4tiCe0i8d/hGvDVv7lk4tuzSK3uQbbjtQric+Vv9xtbB9lKcEZJqXZBEdS0V2aBiAxJLUTt2Yem443mlVNbwpA3auno+NDCLXyIojeUXuwAJ6HIQcrwDp7n4ZMkZfwwnsX/fvyPuXw7kFkh8GNIMhPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dcq5UgmjJhpofX2aV1W14WRQX05yqy/g8ajJ9y5xT44=;
 b=cG8bESPnn8pRatOQh3+5CD8vm1xXJL6372+83UGzD1nRgX5OE/3P9oESy9eLTwls78T4cwt6+yOn747/0/L6u2+K2KfGymK5E53GIRQtdc/qY2kVlFUXZns84FK0qGe/+w2k+QafdCnX0JX4SIsQSQ45qp/WLSKGH+ETFD3mQCvTJJ4n7ECesyc/UzYu7N+w3edRwelQZSdXyafvgsD9i6QrkhtGA106zd4CnLB1+egvDpiwBv3JfgfsrLFbzp7zsndZyMOF16SsgafLZNsbLz4O2eKGtriHU1wTSYIMOc6bMNAK0sWgdBo68f1yQ0r+FN69bAOPOm2ttkhaO+fttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcq5UgmjJhpofX2aV1W14WRQX05yqy/g8ajJ9y5xT44=;
 b=D8RD8xYuBQxmIZ4qTKDEufuYX3c7OuEsz5jz82WuRW3rjf6qeVgjfWeqTouolT7BnyQaXOvduGdmNE4ZoRDVYmsAmaLRSoPwRJukNs5kb5+70DU07MDiTHF6HIHtYtta25BzKHE4/pWUQ+j6OAfDjRZdhltGIvbohyg8kwUuoGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::14)
 by PR0P264MB2439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 15:52:36 +0000
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f]) by PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f%3]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 15:52:36 +0000
From: Vincent Jardin <vincent.jardin@ekinops.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com,
 Vincent Jardin <vincent.jardin@ekinops.com>
Subject: [RFC v2] net/vhost-user.c : enforce link up
Date: Sun, 15 Oct 2023 17:51:47 +0200
Message-Id: <20231015155147.25952-1-vincent.jardin@ekinops.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::35) To PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1P264MB2295:EE_|PR0P264MB2439:EE_
X-MS-Office365-Filtering-Correlation-Id: a33e17fa-9f3c-423a-984a-08dbcd96c0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwH/Y9WP8L/EkXvis00mz1Oq+uIMbBSZXXv0mPBUAZgifvYbiUtc/weqOl6DVy681p0La5JcwF0OuREjypz4J2AD2enIC/Ew+QbEDpBGN0FDd7AAvSQkZYpI289+K7S6Yk/S9ACunEW7tIrGRqYt1VJtWmoN7AnEId7NXLdpo2WcztzLvStu+RAvyi58rc6fVn7MQsRucUFewrk5Z75/B1sUTsivfUx69GeQFme3UnUR9JwrH6YRXVh57oPoCZmOwLbt5gnPimNtSxuK7TjodbgLdGSbRghZzmy5ZSm+QcfH7gd5wrcZ/ttoBp7tuDjX3qXuR4BcG3OoGXqKlo2VWQ+TqG2JlJ2vbiLOl6kI7RxC+c2OCb+6qby5J/ah8E25XQ/snDMeUfLR5lS2P5mB1/nL/SHAXcwNrsiVgr4QEx7aosMRH6S3XhpeqJP6gH0CPyrZiCjo56jwfXRGdBPdCmFqtNAaJcOH25h1eIDWJoNSbmNW04kyYsDiLHSsrmzYO5AsWrndQgF/irbpg4h2C8BtqS6RiKr95RCQi2LJSRWc/MBTv/eB0RFmeOBHpanNC+IIrxPo4pGAtJdS7b2Bcp0+8ILjHj1MLBx+Ul0jycFz07F0gJqqKLXdy44WFGSGblNp97JSBkwCm++YKxcqLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39840400004)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(36756003)(66476007)(44832011)(8936002)(4326008)(8676002)(41300700001)(5660300002)(83380400001)(66556008)(66946007)(316002)(6916009)(1076003)(2906002)(6506007)(6666004)(6512007)(38350700005)(478600001)(52116002)(26005)(2616005)(107886003)(6486002)(38100700002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWYF/i67peKtwtf5E5ZgvpVMBB18H2LYuq5pY2WdcRKp+b5KFzV9Pnz7ECKs?=
 =?us-ascii?Q?/S5Ru/I/tks3FwC95zq1G0A8sLbHTP3TTO1ejiMXKgG22TSi0rG8/HzHCzwu?=
 =?us-ascii?Q?YxfVot+2y9hOx4yYk/LKEBrnvGNrt1cSN4oKa/KKtjuqKwatFQeYjPe23rYJ?=
 =?us-ascii?Q?Dnzo4GfT24z9TL01yI4J79PQ/pZ0B/GwDvs9BMaxR2KRRcGlNIHdvutFUm63?=
 =?us-ascii?Q?PWHwKWp4YzXHM0Jruhvu10kLvs9lfLMgyodtP4rtvkryBVTxOR8rzBiSh6n4?=
 =?us-ascii?Q?GMASTOKP3dbAvsFZezVIL4Zl0K+grdSJzKomA+onrotKxND+mhOj1sOat3Az?=
 =?us-ascii?Q?gxQLNJnXbuKL7th+2/v12HeXcj0M0tb0SlJlOV0EGKFDwy7aViY2pu791e8F?=
 =?us-ascii?Q?eXkBiQVsnMFwaes6hJQDa32rq1f5prslAH/4A7Lb1kD3f1PLNj/dj21i6vSV?=
 =?us-ascii?Q?/3PvPvGJnxOygMSfesGlw2+mj0NgzPnmn4Nijeh2/rT7TnuQPh17l9ENpqzu?=
 =?us-ascii?Q?9QwnZnQEMSWm/bI5yF/8EobPhn3NSuFuj82QAG5uLBnId2jOI/vxeL2u3VMy?=
 =?us-ascii?Q?DDeIpp8JvCxsHTrGOwSphcdy3Yaomi66qyyF62ZGHggkJHjjnSN29nvwraIJ?=
 =?us-ascii?Q?gDUxdJYeudFLsNIL6wrsk/Fd6Zz7C5AIyr6IjUDFKSavCjdk31dfDWeaNRf8?=
 =?us-ascii?Q?0MJahK4y/Uu14PEMWBa0a1HpBGyRVZLy9PPwdtN3GzdL5grLusAvoxHX4unx?=
 =?us-ascii?Q?38v2uZh3PQZHwStpIuR5+eaidByX3kl/NvJ9TctYbvkzEka3pWkMh/eql9sJ?=
 =?us-ascii?Q?UFSRXa8RtAQMYQHJQVt6jW3MSvzi1dC6jGh1yRR4+/VLnNyBhqbCDqA1tWZ7?=
 =?us-ascii?Q?q0rzKZTcwhmXSk2Zp01zXMPku1vjva9clML53/9StFE0alPqavl8A8hdurze?=
 =?us-ascii?Q?h4iQa0mBw4Ja23Ay0R0xR5g0/B33wCrQToozMUtDwEEhZydSmQPBdXNJYoLD?=
 =?us-ascii?Q?RFCYxjDkdrKcyFaCKJV63kc9EKOP6CoRseMrA98l/AyEWl5vE8Rbk4o26Ecn?=
 =?us-ascii?Q?5djQW2FCUuF2bvvLUfsQhirvM1d6w8h21HzH1rQiHLVoTpF+LKp0Hw8yZ4Di?=
 =?us-ascii?Q?JtZBvBHp2dxJONbXNY8c/y/A1/JHITeNPWXlehBE8k1Uf4OT1g2pQvyuaCa8?=
 =?us-ascii?Q?a/6BrBrL+ZYUenRaDg/CklzmS9oRKqQA99wOy8XH7RfEkfkatD4qL68I8DM5?=
 =?us-ascii?Q?YTu5rRufCZxLELDw9N7VjQUiwHB0+7HH/WC7czsXU1I3u0CvYTKLqy14aw27?=
 =?us-ascii?Q?1EgP1Y2OqhwyBYLofHKA46eGYP6GjAk9EV7gkGLAhFyW2lhjEz0VlTfUFyjw?=
 =?us-ascii?Q?45o+SqWxr2P1q2z2ojqvUY4GB5nj04WPCnnCL2oE6puhxZ0jzpishxRVoTHD?=
 =?us-ascii?Q?UHv+kqveslMSyOoMF6kwcKUKG6DrGRpM8z3VDC+Im1GllMUME1GqS3CPPqgq?=
 =?us-ascii?Q?nYk3YU1/AY+nc2ro7OkzkFov2Kh6csIx6HQiFWOb8KYd/T2y4W3NwIqlTNtw?=
 =?us-ascii?Q?QUw7flonLcogC+xIId6TB7aKieHYSrdyzYwEEK+V4qflttSbwwyhGq+HMkzp?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33e17fa-9f3c-423a-984a-08dbcd96c0cb
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 15:52:36.7394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s/k19+Z4xLke/inpFZitOKVLni3yowSE70puWFE4Be/rYKZ436utqDudF9xbyAu7zfHJsB+lsiAowjwy0zxEoP/qfG3Q6AOy/Bti3QZMto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2439
Received-SPF: pass client-ip=2a01:111:f400:7e19::713;
 envelope-from=vincent.jardin@ekinops.com;
 helo=FRA01-MR2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do never set the link down when the vhost-user socket is disconnected.

XXX: currently, it cannot work. It is a reply commit to the former
one that was a RFC on virtio-net. Don't use it.
I do not understand how to get NetdevVhostUserOptions yet.

Signed-off-by: Vincent Jardin <vincent.jardin@ekinops.com>
---
 net/vhost-user.c | 4 ++++
 qapi/net.json    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 12555518e8..a30cce9a78 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -251,6 +251,7 @@ static void chr_closed_bh(void *opaque)
     NetVhostUserState *s;
     Error *err = NULL;
     int queues, i;
+    const NetdevVhostUserOptions *vhost_user_opts = NULL;
 
     queues = qemu_find_net_clients_except(name, ncs,
                                           NET_CLIENT_DRIVER_NIC,
@@ -263,6 +264,9 @@ static void chr_closed_bh(void *opaque)
         vhost_user_save_acked_features(ncs[i]);
     }
 
+    /* TODO how to get vhost_user_opts ? from the name ? or from ncs ? */
+
+    if (vhost_user_opts->has_linkup && !vhost_user_opts->linkup)
     qmp_set_link(name, false, &err);
 
     qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
diff --git a/qapi/net.json b/qapi/net.json
index 8095b68fa8..c170f1b7b2 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -480,6 +480,7 @@
   'data': {
     'chardev':        'str',
     '*vhostforce':    'bool',
+    '*linkup':        'bool',
     '*queues':        'int' } }
 
 ##
-- 
2.34.1


