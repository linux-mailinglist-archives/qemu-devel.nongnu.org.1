Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA057416E0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYVU-0007to-O0; Wed, 28 Jun 2023 12:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYD3-0006k4-MJ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:40:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.lonergan@nutanix.com>)
 id 1qEYCy-0002Hb-EB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:39:59 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35SEKA9L024880; Wed, 28 Jun 2023 09:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=aYh5AfEbSLb0tKyGZew8JB6Cib5lFwEpdviHXBqrLDc=;
 b=xXR+vXAwsWg0HHNnTmkIw2VszEq3vkwgsA0+gpMbRmzvTCK7/O5hBRGQyHKveJjCRtmy
 fFJ3zn50UhLZKtbN7prcxkTyL1+2uV5iNlarbFigBizXUZ/QxnuOZBG8fnAkwrzr+2zb
 HAZ5EGA4uf+3K01BCB2BhioPNbPVWDhyBRLxXQVES+pc44O2jumJfPk/IB8xOWR3/2wt
 GI0jJL8QetoXvW5shKhnruOt4D3hbrtETDucp5l0xZsc06SNDVAADNfQgSeDTSbknkN5
 V6TepyGNhceoYRmurtzYPDW7PWr6jXYP7yX2wk9PxqDnamFybb6AMUQ+VYG+hPr9Mhpk ew== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rdvd609ec-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 09:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fThpJOsoYZMItW4580jEKI7/ifS4aGdQc9+yjS6yq3mTzgrBwTV/4zEg3p/ZCqvD/hLc5xE88CXR39cWX6R960JSRi8RY9hmcs26CodyBQOsA4dVIjrVITkq+aMkk63xEF7T/Za1ixWKbrPU+U++KzbAo8J9y7y0M6TogEHFpMiDNo+7FEtcFpKkQixTxRx5N1UeiNHcCV04ZgpCPtpY6By6PYoONITqs3Xr5tMSeLbHly/Xf5shf14BYj0aFt8GbxLYuRV49lYHIR5pafNmW3GSnuL+wTt97tBL8ZSjXaRTfRcCFRKuNQ0yS02SQgHK2fMeHPh2VWWJBfQKWCMq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYh5AfEbSLb0tKyGZew8JB6Cib5lFwEpdviHXBqrLDc=;
 b=EDlGRXjWlD+PKEfa6FJyXiJSb993uUOpxWINsXO4StNsai0u3iS7tTHpFtEUflY45eBUhb6+C+LHdr4sVNcVKVVKwm6XslOTSjmq6g2C9T8/6268MN+8YFo9OIrWFwN73a0A3O4pCdFbViUkhxIb0T+AIN1V8q7428MYitcHNwuRyncCT1p8izC5X2q93AV2c3qxpt1JL7rPnSQ+bqvk3uhcreoE+KQpS6dPRB7kh0Fe5v9sBhptQFM+R++xTzrpaYCvDl3R+Thjx4d8kaTzg4wO2LksZ3G8UUlSu4JcN6Gg/2YQedBEBrJJohxF2GiiRUQKmnU3OGIMZBaDCyHr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYh5AfEbSLb0tKyGZew8JB6Cib5lFwEpdviHXBqrLDc=;
 b=GnpXUwgHtC+fKCgJd9aXmJdjdcv+OisndHkdKWMxr+gVuwYCaNMyd2zHP87a9L6onx2YO+yr3f5v0Z7VIeCWBxolB4tm+onKHsT6HHBoDYKOenL5sywhw4TMILyO3SU6qdGbINA9tDH+pLlU9oFHGMGnJFzu6Pay8oTnMl+xe3dzdVZKAHCU3Y5KmwFWiSOkh3AI2FVH/3F5CYv/0B+uKIkqRjQTDbhytyYq2tj6A41sWDARNv1kp9ZbBtJcYXm7zLmG9V+CcOva/K4FQsGOcM02kF7tkAevkU/ouiVNkM5vXIvLeRVuE8VsAoi1nmKHpwA4xWrx2rOdJATdiJHF5w==
Received: from DM6PR02MB6123.namprd02.prod.outlook.com (2603:10b6:5:1fd::20)
 by PH7PR02MB10061.namprd02.prod.outlook.com (2603:10b6:510:2ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 16:39:44 +0000
Received: from DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93]) by DM6PR02MB6123.namprd02.prod.outlook.com
 ([fe80::4bce:9f20:28bc:8e93%7]) with mapi id 15.20.6544.008; Wed, 28 Jun 2023
 16:39:44 +0000
From: Tom Lonergan <tom.lonergan@nutanix.com>
To: mst@redhat.com
Cc: raphael.norwitz@nutanix.com, qemu-devel@nongnu.org,
 yuanmh12@chinatelecom.cn, Tom Lonergan <tom.lonergan@nutanix.com>
Subject: [PATCH 1/2] vhost-user: Change one_time to per_device request
Date: Wed, 28 Jun 2023 16:39:26 +0000
Message-Id: <20230628163927.108171-2-tom.lonergan@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230628163927.108171-1-tom.lonergan@nutanix.com>
References: <20230628163927.108171-1-tom.lonergan@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::11) To DM6PR02MB6123.namprd02.prod.outlook.com
 (2603:10b6:5:1fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB6123:EE_|PH7PR02MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 9785e7e0-e1e8-478a-ec7d-08db77f64755
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivjDnqHXeVXnFUZvfbgT+mKLomxHrT3aZVDnUYKANKHPkgl1PC97UbxaSk3Ah2KONuYB/kIsSQ/hhBCWp9FP4Q3ibQvzcSW99cveIvy2CNo6c3zFwvAa4FShN0MeyRcmpzVJR6Y8xyHUUPji/g4uoQ2a3v/9AUVBzX3f8kA+9ymUWnTb9dwXNanWB6kunm4GXTc6C9Cd27eSuORngvv59eCLDXYuvaw7eTAV4NcNwo9eHrrF1OdwWq3fRHKKtBzaMN/gONHpBjN2szvATAxBGCjvfBDdErgTjBkGQjBSnfNDJIcd8LvYyDdQhW6hZSiPeEDNb3L2gIdhUzGOIiQijMx3UZswRWVEe7xMvAG2L12KeAEGeSxMKuSVnuEJHjJAOLClla92k1kaVqQDclmHrFi9pRefrkpbp/wOGuywtUtXTB40ppwWfnmtMo+PYK3tTZQa334upAfGdZc25Vn96nf6dzNXhVVTCIaw2iAaqONxz8eBOzSZn20k0g5lQPhBheymTAeOnE2gOgA6Fjf+U0975InddjjngMigBPeI2gFRZa4W2pahFJ2vBx9DTwDF7TAeRGm3TRl7ndg88BGlNs2+da48zxQSaZMIUHFRalRP/LTceC6x4Z5YhYGX9MZu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6123.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(2906002)(6486002)(6666004)(52116002)(83380400001)(38100700002)(107886003)(186003)(38350700002)(6512007)(2616005)(6506007)(1076003)(86362001)(966005)(41300700001)(478600001)(316002)(4326008)(36756003)(66476007)(66946007)(6916009)(8936002)(66556008)(26005)(44832011)(8676002)(5660300002)(4444003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRXPc7KVntE6Vm/vWDC2qs7+2x1hlBxX995yHty727qfTDR/C7r4oIjs+vYu?=
 =?us-ascii?Q?PYKVnDsdU79t2NzWVp1f46uZszrrR8XdsaTly/UUsaCpXvj8+ktSqy4pJN+Q?=
 =?us-ascii?Q?sUz3cIMuzGkKukiO1niuBE4rkcEzkzKLiwhd4y/wEJ48P8Z5zFxnIGYA1uFV?=
 =?us-ascii?Q?qzzHBdL8ekWGk4mSZkRC72EWAoOuO8w3UkXkHejFX0jZ9eVXW7LERBMopn+v?=
 =?us-ascii?Q?BhHN2P8zJqfqdXwlT6dJCgtkeDM9Kn1HRaL9sZm27vSxSmZ8oTui9loUukEA?=
 =?us-ascii?Q?YCxTJRwOvv8WpZuuwAo/oiOKmCgkxww6iAAUYGDCczXkUmjvFzkuUl6gHfVq?=
 =?us-ascii?Q?/5IbZUJapnQFPwlF6xHdhPseewYTSSwLSfNqHItPxVgMcbVwx1vbJG8Hvy2P?=
 =?us-ascii?Q?6Sjc8X1sY27o5xY19KEu72EmmjLoMhDo3fcr8/ju7dhOORwrlVYeOvRx4frF?=
 =?us-ascii?Q?JcrNlMws41hp7NXS6RUQ4aF7LOvh7GQDQpp5jKjYmZ7QKI+QE/MAQxPkSklA?=
 =?us-ascii?Q?hXZI7i3hat4RAxWhLN+8udYufa2+TQs2J4Fpn+jxyxqGsu3i7sGpOQfdVcfe?=
 =?us-ascii?Q?vbGfJq5bnFWHFuZbMF0NdS89ViBQUhxtytZX90CqD9riL13YRpnXBoK9RcHu?=
 =?us-ascii?Q?e1vIAzvd9Iscl/RQ3c+VnyxgRDolrK0AG4nbiRz2wQwvxpJWInKSKUN4HuFc?=
 =?us-ascii?Q?QsucaknKI8ywmJMLrIads7xTGQNDhj8X3Gqmi6+hNfg5suynmzmRdmmFUpji?=
 =?us-ascii?Q?8NUw12l7pbvfRc4/GqepNYL32KYv2+mEIBUQru657vdJsce/dgnF1pkRYfBn?=
 =?us-ascii?Q?I5wqDkeAHmlQXJKE1vfZgtlLJp5K+1McJOqt2f0lmPR2F0iPGziX9lLkafnH?=
 =?us-ascii?Q?AcLNneH37GV+VFoTpxMVXA0W9+PK+wYyZoN1IhjoApsHo3IWefNiLTg6GFfM?=
 =?us-ascii?Q?IOTMlV/BvehyQvBHP+FsvJ4JIXVxO2NuxTDxisAz0eh/5y5Uz84rhEsZvbc5?=
 =?us-ascii?Q?a5NCn35Xnp+GOTQn6Bxf6JNp5rAgSzyKYK64Ns3b7UQR++m5XoeqnazNcYLJ?=
 =?us-ascii?Q?qizli6b2fZQKoeV6m8kP+CDoaXmom0JzYfLsRtC1CszdDRiDeYYNqGcIr/+E?=
 =?us-ascii?Q?OuVmjciDGwEYtqIKYrqIogEE/wI99+yf+hoyV/gIyus6werCwekVKWx2UYTd?=
 =?us-ascii?Q?H7F9EGdsxmi1Y6nyMft7fDgjf7UDzGOMEKnyYdH2PhYY9B4xj25+zncLKqXm?=
 =?us-ascii?Q?KPCZnU/4mdd1ohi7jHpzmRXqmWlOYL6P3S/LXpJ2sG//mLAfKMZTT22Xw6A1?=
 =?us-ascii?Q?B1up0eaSnHAm+CuNgJF2AdiatXE2fLelvNHazCByoxDp2LGlBLvm15o6opAJ?=
 =?us-ascii?Q?/iJBC/xgUAJTN/YAaS7vG1BcyqWKRlhhG7t7RW5ExWc+3pe91bWXPAXWcTPV?=
 =?us-ascii?Q?f0anWMewCxbZvxnjcBIquxVXs7BZu08aozYZUDyX/1uTjyBsYCmmJoWh2moU?=
 =?us-ascii?Q?s1/r6DuhLe32/k7i+3ihtIAO6WwYMU0lrfjimrHLTKZEJnH6sGtVKIsFPPeL?=
 =?us-ascii?Q?8sF+upqwXvfmVnsSH88RFYCezVKkeAjzsfcPaqDnmFBpPuGDA1r4wflvSMIr?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9785e7e0-e1e8-478a-ec7d-08db77f64755
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6123.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 16:39:44.6790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLgHfhpbP18TQ8j5Sbh4MklnLdc7m9GSc4Op54ZHELUYCHKJC4gGJqgxtFLAo2kPr1NQUjC88waamZOqlkOsyu3Jp/4uhtnKhaCj35JKAIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10061
X-Proofpoint-GUID: m_Bdn1uUCsA-w2oL8PL5jL4j0epEWsj3
X-Proofpoint-ORIG-GUID: m_Bdn1uUCsA-w2oL8PL5jL4j0epEWsj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=tom.lonergan@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Jun 2023 12:59:02 -0400
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

Some devices, like virtio-scsi, consist of one vhost_dev, while others, like
virtio-net, contain multiple vhost_devs. The QEMU vhost-user code has a
concept of one-time messages which is misleading. One-time messages are sent
once per operation on the device, not once for the lifetime of the device.
Therefore, as discussed in [1], vhost_user_one_time_request should be
renamed to vhost_user_per_device_request and the relevant comments updated
to match the real functionality.

[1] https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@kernel.org/

Signed-off-by: Tom Lonergan <tom.lonergan@nutanix.com>
---
 hw/virtio/vhost-user.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c4e0cbd702..65d6299343 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -367,7 +367,7 @@ static int process_message_reply(struct vhost_dev *dev,
     return msg_reply.payload.u64 ? -EIO : 0;
 }
 
-static bool vhost_user_one_time_request(VhostUserRequest request)
+static bool vhost_user_per_device_request(VhostUserRequest request)
 {
     switch (request) {
     case VHOST_USER_SET_OWNER:
@@ -392,11 +392,17 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
     int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
 
     /*
-     * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
-     * we just need send it once in the first time. For later such
-     * request, we just ignore it.
+     * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
+     * while others, like virtio-net, contain multiple vhost_devs. For
+     * operations such as configuring device memory mappings or issuing device
+     * resets, which affect the whole device instead of individual VQs,
+     * vhost-user messages should only be sent once.
+     * 
+     * Devices with multiple vhost_devs are given an associated dev->vq_index
+     * so per_device requests are only sent if vq_index is 0.
      */
-    if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index != 0) {
+    if (vhost_user_per_device_request(msg->hdr.request)
+        && dev->vq_index != 0) {
         msg->hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
         return 0;
     }
@@ -1256,7 +1262,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
         .hdr.flags = VHOST_USER_VERSION,
     };
 
-    if (vhost_user_one_time_request(request) && dev->vq_index != 0) {
+    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
         return 0;
     }
 
-- 
2.22.3


