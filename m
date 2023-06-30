Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD107437CC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9u8-00075Y-73; Fri, 30 Jun 2023 04:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9tw-0006xF-PR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:50 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9tv-0007ns-6M
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6726d5d92afso1001514b3a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688115286; x=1690707286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/vyj3NRZa1WG7OO1XkwYenz6SSrmEcJIYzbyS3qPZ8=;
 b=M3bKKw8CPFCcm6oY7dhCingKOUURtT7tfdpeGUL/yDiiPrGE+IVowQySG2ezfmVWvf
 wFDB9IE+aXetzlDKC5ONH4HRogAtuTjcLg5a88flQectF5gTL9xMYyWfQlbVbN6Fn5WX
 g/s69z/97ca1/yTDpdUZftwSUnvjHrWC0C58JNu4fSNoa9vkBFrGzLKv2VHQibH18Mhh
 eQxHGRtRghYuWYT+pItQcPFDTL9AkVPHyFCF1SZZl06avspwK5D/s2ndgBqtdOcSAvrM
 RDRF/6xcC0Lkau4gzlVfHWCMk6OdPydMD1f4hZnkIT0jB2vsyNQ4sd7yuHZsxoa6se+5
 tq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688115286; x=1690707286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/vyj3NRZa1WG7OO1XkwYenz6SSrmEcJIYzbyS3qPZ8=;
 b=LflR0OqVLtwkGw81Eq+ZQ1E5S1Noq7/S4UhVxW4LfnLPfms3h2n2eGPhMgVnjo68Vt
 YO/ABC8j1Bc8/5Kwhxe/IEOtxPGuidQE2vg81cQHzDAODwgZrdTUwC40EhM9+2/AbWdo
 j28QSHld3NgHfhX1z724TbA0NFREYAZ+NBmE7n01dGKuD7lxvKdpfFc41to5xbBzx7St
 cIG8wpPSwlDNYd6ljyRZyqGIpZkUREKSzmpVritpvKE1Qi1mcCA0XJP3IgRnWUs0QxIt
 fp7Nn0YyLPj1/e3mFMoghZDPWHNAGBVWANpyQ+qFtofhLJFg4Grip6lPVCroj0MADZV6
 rBsQ==
X-Gm-Message-State: AC+VfDzlqWumXZNBdHj+PAvYKHqTuyLxYbC0/LBMTamxjjEzrUIoL/aJ
 ekDz81VgCK/ja7woCwTNo+g=
X-Google-Smtp-Source: ACHHUZ6Sf/wUd5eHPHVBOxxDwZNsGKikA+7YGv9x9zq4tm2cRvYnbBkZ3bTzS7yGo5sVwXqZhaR/Cg==
X-Received: by 2002:a05:6a00:2d8d:b0:67f:6d90:8fb with SMTP id
 fb13-20020a056a002d8d00b0067f6d9008fbmr11061494pfb.13.1688115285650; 
 Fri, 30 Jun 2023 01:54:45 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 g6-20020aa78746000000b006749c22d079sm8188303pfo.167.2023.06.30.01.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:54:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 2/2] vdpa: order vdpa_feature_bits array
Date: Fri, 30 Jun 2023 16:54:36 +0800
Message-Id: <b31f0bce96ad1b66fabeace182cddb41fede9683.1688112025.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688112025.git.yin31149@gmail.com>
References: <cover.1688112025.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

This patch reorganizes the vdpa_feature_bits array
in ascending order based on its value to avoid future duplicates.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v2:
  - resolve conflicts with the master branch

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01585.html

 net/vhost-vdpa.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0479988a79..db7f1241af 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -50,15 +50,12 @@ typedef struct VhostVDPAState {
     bool started;
 } VhostVDPAState;
 
+/* The array is sorted in ascending order based on its value */
 const int vdpa_feature_bits[] = {
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
-    VIRTIO_F_ANY_LAYOUT,
-    VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_GUEST_CSUM,
     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
+    VIRTIO_NET_F_MTU,
     VIRTIO_NET_F_GSO,
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
@@ -69,19 +66,24 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_UFO,
     VIRTIO_NET_F_MRG_RXBUF,
-    VIRTIO_NET_F_MTU,
+    VIRTIO_NET_F_STATUS,
+    VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_NET_F_CTRL_RX,
-    VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_CTRL_VLAN,
-    VIRTIO_NET_F_CTRL_MAC_ADDR,
+    VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_MQ,
-    VIRTIO_NET_F_CTRL_VQ,
+    VIRTIO_NET_F_CTRL_MAC_ADDR,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_VERSION_1,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
-    VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_HASH_REPORT,
-    VIRTIO_NET_F_STATUS,
+    VIRTIO_NET_F_RSS,
+    /* VHOST_INVALID_FEATURE_BIT should always be the last entry */
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
2.25.1


