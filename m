Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4667C9560
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 18:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrhUz-0004wW-99; Sat, 14 Oct 2023 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qrhUx-0004w5-BD
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:28:19 -0400
Received: from mail-pr2fra01on2129.outbound.protection.outlook.com
 ([40.107.12.129] helo=FRA01-PR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qrhUv-0005VR-IN
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 12:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdtlNKXT7K9QCHh+hk2PWAXYcTi4TusCdm2i8WRBY3BNbGlqtJ4JI9pRSLQVt9H51M65n71gC/xW7zug1eJrvI7/as++S03zDR+/XsBYhopmfI7d/uEmkSHnul/Ye/O4yzFV7XHrhRDVBFPUSESup4Hp9gl+gn34GACGMF+06ojrzxPYI/Jxqmox4sDb4mPKuB4LOV/QlA6HASjGPGwAR2D9sdSy3Txi+VsYowYVcZ9fErB4WunD7OwV2vi+8dkIjQYPArI1MApBi64Jbzn0+QGmc8c8qGLbmTjdhCOilFOwqphbcvMmi3FXl9TZ7DSbJflaS8fGNbj3NEoMwEas7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++LHSbMsd8Vjgpa0Cxx4OdCDojsHlKtMDDcnEzD7DCk=;
 b=RENN1ulh29c9HCBrr1Ld2EV7LZ6QDrgLGWDqyCmUYEIHGuirs3UTmuLKIyM49jVsYEpQPq0taCMo7YDqvXsA34P71rLABDvpNBhX7029R/bsjQTypJRC2KPKBIW+DFYowC/7H+SEIc1WiUSxqMkAK0Ir6wKYGCYsd28i3zU++R5UR0nmGkamU7nIK+XMSahcYzVG+UzPCOlldJXoSDGb+ektqjcxc8UiYm8rYqW59zJ/3KRSz1Q0VNbacorl0wznd5XdpYcwTSi+cwnjA7sSsh5n2Y+t8b4ADClHSaiiqEHu4Jl3ketCqIcE3tPgTkDsNHbi++454PhAn3WytSXhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++LHSbMsd8Vjgpa0Cxx4OdCDojsHlKtMDDcnEzD7DCk=;
 b=IHE068RolUgofJ0WBtVysifrRAHsLRjokFl3jgoAloSF1LONGt/volguSpQDG0+wc30DwzoP4umTfuL2yA87aPSoQ0uEgGBdMtkffR465gQwLSfIZaxBshTfMfExy9FOPpODCH2TGdgFqtgLc5uZ0oqWctaHcBDogxkRAAcML0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::14)
 by PR0P264MB2438.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sat, 14 Oct
 2023 16:23:12 +0000
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f]) by PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f%3]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 16:23:12 +0000
From: Vincent Jardin <vincent.jardin@ekinops.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com,
 Vincent Jardin <vincent.jardin@ekinops.com>
Subject: [RFC] virtio: enforce link up
Date: Sat, 14 Oct 2023 18:22:34 +0200
Message-Id: <20231014162234.153808-1-vincent.jardin@ekinops.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0345.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::13) To PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1b6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1P264MB2295:EE_|PR0P264MB2438:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc679ce-5a6f-4cf8-ddf8-08dbccd1dc4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5wtH50BgN+vKfCq4xpa675+wf2tLyVQcY/lDMqUAeBBAk/ArWywbwncXOINQTpXQDG+6L/3m8+cZ5ftUA4rHUNcgvgKRaRWPsBrFrArGYGlLskVBNC31Rw0OUj38s88i2QseXnbNNaX+JoqqBAN2qsLHJIiP2njx+XlJsqbDwISsbDQsKedDNGB1lqOq0FWunp0LU6KqvPj84dnVVTKNOrgSBxxAw2aeJIXASDYONByaU9CGNdReZgrpe6uUvrQ6+9hO6oTZ5rT7OGiTIIpgIwlSTq9ScR4E6o8g47mRJeOLJHy1/W60Z2EPSfWlZ+gj8HDYXlU3yxFN7qnRn+07hfBQyan7MzrVmf1sWPp5nYZmyIOWMHAln0Jzn99iTd3xCiBII5+34S/ZnA54a3aKiweHvTApsx1A+1pqvIczeCi/1X1NrLed/oOjOZTQmdt1fcA+8ugWSeEGUq+/lNnvs81HuZxNo5GPIqjL2SCcfwCBJLiAg1iQeXqQLUoDRicqprA8cZZ1pAdm1vfCZKaORxJ4PYrTJ+pSO2o/NvdHvl3N13W8wXpj5wplFcINE10tM2HhfqD7BrcBiBkf9myWyg9zO2SJ0g/cIumzNqkY8anFsqHDq+keZbDM4SaaIx+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(396003)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(86362001)(36756003)(316002)(38100700002)(66556008)(66476007)(1076003)(41300700001)(2616005)(107886003)(52116002)(66946007)(6916009)(26005)(38350700005)(6666004)(6486002)(6512007)(6506007)(478600001)(5660300002)(44832011)(4326008)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZbzwxib4jOa0EC2QPvBQxqzUNK8EGZ33dLaaj4g+B4492LjNnXWEoDALhER?=
 =?us-ascii?Q?CjC0EPEbWZIbrqfA2hteOE0HHV1bQgbQqilkCBq77nJ2i4tA44ILmynE3PPM?=
 =?us-ascii?Q?b1QMvMDt8up027Nf1P/+Sp8zgMVEY6DWMeODj834JRz4xnFDDYedN07jvcbF?=
 =?us-ascii?Q?OXSe52W1kgFmdjI676haLVhkXIX0DpmY+sShNl3Z0b5DkPNFYEqkiGmmSW1W?=
 =?us-ascii?Q?eXymvlgFu/gbnM7zG7gSNFmxW+84UvOIYTGoojaYn/sPDXC12zRJWgzY/sXY?=
 =?us-ascii?Q?Cie4/CYg+cGjKio+Cg4Ta6HiOwPCnraCbuFVFaWD25bqmXESw0a1WxwcaXhq?=
 =?us-ascii?Q?mYRCBMjgbXPwRhSLI6BwDVNhC1EG+qAK/dhG5tMoZEquWaBERx98aqvunxfO?=
 =?us-ascii?Q?rKZ4u7edYDw7FK1I0eWyMPJZ0DP1r626H97dGQIgOp6Q8uFcmDx6xZtSLX9W?=
 =?us-ascii?Q?Ug0pMkzDFuXBXnOVaa0VGT1ZBifbTn3UNMNPsam4j1wpj7AYJiKurLvAA8Xj?=
 =?us-ascii?Q?opV5xB/zg60Q5QMHmwNJK93fYV+SWH0rrjPF0s/3MiM8v65eRWajDJewv2ul?=
 =?us-ascii?Q?J7uILOF0k0Mu1fZEHWuPRj5iufhWO9LKe+u92nppP2dicZLil7wrjjAB51gD?=
 =?us-ascii?Q?vY+Xb8j2FZdhNEDwf6QYh4BAGIbfArJ1HVQnKKzPEWy5Fh/BlWZARlk6yhZK?=
 =?us-ascii?Q?9Rrf96r6ob7gGpIPxX3wiAAAJGXgW4tV9S6r80K9YyHP/Q5LdpuHKYOF78vJ?=
 =?us-ascii?Q?ndGnBixF50XbkK0vCsaPxpEIHI63dFvrs+uami1l+bLge5k4ZDA21e+jDoVJ?=
 =?us-ascii?Q?n1AeO0LhesSvkktlbm/niVR0nxKkKXYBSDBgbx2SF0JrnFWbtOXW4l1YTb+H?=
 =?us-ascii?Q?4gfwK2CClnSIBIMhgsDDc7UQxW8x4n2awG8ES/enekf8gucvMjj6xG3qf86a?=
 =?us-ascii?Q?keqjBHYFolsXdoRmsBfkBDPCwO9y9eZ72uzQB8E7ySfCPgdp+7oZAb/mO97z?=
 =?us-ascii?Q?XKD9t7lyO1gQlbj5+cckSsRuUIk7RIhJVnugXjQp+7xwkg15/pUBZuzEEyYU?=
 =?us-ascii?Q?ePggNjWrBDyFlfQyw1wfi3MrFZhwr3WOhhtITWmNTD8k0AGxLigP73Ujm6V0?=
 =?us-ascii?Q?4b8skPBz3xvgu2vchl8y/3gWGBRxV5stsfvaCi5Sc1Vq7xblL1HTYDxP7GF1?=
 =?us-ascii?Q?DlRzifYpAL+M1LngvDViUQLIV2Hw+d5/GZswkVoxoajqv7Ty5FiSrqD68dLi?=
 =?us-ascii?Q?IxbF6OaJN89DBSXxPTsGV/GuGSEpQXjTqXYkmHr/ntDl7Swtv5Rz88MJ3c9N?=
 =?us-ascii?Q?rB40JUMIQIBOmWcTwKpxEDu483a4FDE3NCiFzrBVVxeWWdIPOMN04BpjLNVk?=
 =?us-ascii?Q?DEoeK+7WsXMcGTICAvfhMAA1pbcy/48ItDXeD/GYG6/LytHNN0B50al24kJy?=
 =?us-ascii?Q?L3OyAVNCeFhKtf6Om2YH0foy3NlYW6YjT03UPPxjxzDP1vVUlp6KbACCihxM?=
 =?us-ascii?Q?QEeDp8+GAG6iRsLr3he4K4gRAI77Dw5w8YGjU/Ge6B3/BVL9tKujXQBVVjta?=
 =?us-ascii?Q?APZsEgIbK0i6PLUxpto3JvH1DtbyLkZYdMdjwdz21o43gR1eIZcps8opF6D1?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc679ce-5a6f-4cf8-ddf8-08dbccd1dc4d
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 16:23:12.0362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPWi+e9ZPOcIYjBOMv+YujDoCcMpqA69BsHvNTRnwct7gfxz02w49B9PbM1ZoedWN/0BESG+IJe0TtfiiYI56DV8ryTpDTapCh7IxY6aTnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2438
Received-SPF: pass client-ip=40.107.12.129;
 envelope-from=vincent.jardin@ekinops.com;
 helo=FRA01-PR2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Using interface's settings, let's enforce an always on link up.

Signed-off-by: Vincent Jardin <vincent.jardin@ekinops.com>
---
 hw/net/virtio-net.c            | 8 ++++++++
 include/hw/virtio/virtio-net.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 29e33ea5ed..e731b4fdea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -78,6 +78,9 @@
    tso/gso/gro 'off'. */
 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
 
+/* force always link up */
+#define VIRTIO_NET_LINK_UP false
+
 #define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
                                          VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
                                          VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
@@ -447,6 +450,9 @@ static void virtio_net_set_link_status(NetClientState *nc)
     else
         n->status |= VIRTIO_NET_S_LINK_UP;
 
+    if (n->net_conf.link_up)
+        n->status |= VIRTIO_NET_S_LINK_UP;
+
     if (n->status != old_status)
         virtio_notify_config(vdev);
 
@@ -3947,6 +3953,8 @@ static Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BOOL("link_up", VirtIONet, net_conf.link_up,
+                       VIRTIO_NET_LINK_UP),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f01f0..385bebab34 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -56,6 +56,7 @@ typedef struct virtio_net_conf
     char *duplex_str;
     uint8_t duplex;
     char *primary_id_str;
+    bool link_up; /* if set enforce link up, never down */
 } virtio_net_conf;
 
 /* Coalesced packets type & status */
@@ -180,6 +181,7 @@ struct VirtIONet {
     size_t guest_hdr_len;
     uint64_t host_features;
     uint32_t rsc_timeout;
+    uint32_t link_up; /* if set enforce link up, never down */
     uint8_t rsc4_enabled;
     uint8_t rsc6_enabled;
     uint8_t has_ufo;
-- 
2.34.1


