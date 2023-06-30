Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A6743CAE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE5P-00006R-38; Fri, 30 Jun 2023 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5H-0008Jd-F0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:49 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5F-0003YE-Ou
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-55b12286476so1095977a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688131364; x=1690723364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+10pK3jsTYW1WCPIup4C/1EWfB9z1pijxAEzc/XV9s=;
 b=nGmxeZW68Ll+wdcQDaJ0qFAtBWkC4GlWB2uYbY/UgiyxzLAkT9IGFeRK6ztJ8rSf77
 Z6uyHSbDl8SEsEtLXpdxrfNbEirqq7Z/JJIZiP0+kwOJUojyAaMILw/ETXfW0Q6HloxF
 7d9AHapaic0b9PVQSh0G8XR0f0/9J298Zem+eI7W4AT9oYX2WNoqF7PGlZn2j34tZ5Ww
 RhV2yeG30t4A4WxbTyoJxSrCxwQcgcdRO7t16Bx2X/y1HtIU7Ptn66/NApRTEPo4DaSj
 FovjjJ6W98iV6upT59Lwu6j1m7vInWOJFRRIn76N6lYS5l/XHF6jFTIrGHdon4vi4ASI
 /yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131364; x=1690723364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+10pK3jsTYW1WCPIup4C/1EWfB9z1pijxAEzc/XV9s=;
 b=WZt90oQ2aJ7NWnDEubsosnER0JLvSauFRsuKrtGzxQCVygH1GSnguM+q60uOLlZWyk
 lW/Ef0XJFhnmDmT2JrlM8sCZitgXzGGxoawXofUwNSNHtCZz3YGeYMdvDN6WQuahA5dL
 jMEeTyMghC+zV0SpcyyWTDh5i2JDsz/gC9BeAGzBBvNxCzlV1H7ZLJ0gZ8HMtjv7d2Lk
 xL8xHp/EMsNm6eQ/xlChkLxiWnJU2L42HDUZRVRpAouKttzF/2KtU+Bd4oBVCizKH8TL
 LNvA7xeP3t6mobCwBIWWrQW1EMBJbhbqyJ1xB1H0z9KTXNdkF100rzn4UlVB8/ThqPbj
 xqHg==
X-Gm-Message-State: ABy/qLbtWUpyHsiNOQzePj1rtQ8rCvhuSVzC3YglEIHnWFVSUhRIr51Y
 aPSs/z9Cu8dHTx5LW109fWo=
X-Google-Smtp-Source: APBJJlF4TF7BeOEv4sWYEtV3+p76C3hTnzirHA3470DQx9OFWPdmHy5rLuTF18SFuq2KstuT5ba70g==
X-Received: by 2002:a17:90a:e60f:b0:262:e742:f40a with SMTP id
 j15-20020a17090ae60f00b00262e742f40amr1657184pjy.44.1688131363931; 
 Fri, 30 Jun 2023 06:22:43 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020a17090a3e0f00b002638e5d2986sm282963pjc.17.2023.06.30.06.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:43 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, philmd@linaro.org
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/2] vdpa: Sort vdpa_feature_bits array alphabetically
Date: Fri, 30 Jun 2023 21:21:48 +0800
Message-Id: <07632fb387d8eafb7ad76dd07e321658e0f40842.1688130570.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688130570.git.yin31149@gmail.com>
References: <cover.1688130570.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52e.google.com
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

This patch sorts the vdpa_feature_bits array
alphabetically in ascending order to avoid future duplicates.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v3:
  - sort array alphabetically suggested by Philippe

v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06766.html
   - resolve conflicts with the master branch

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01585.html

 net/vhost-vdpa.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0479988a79..c0e93ce568 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -50,38 +50,45 @@ typedef struct VhostVDPAState {
     bool started;
 } VhostVDPAState;
 
+/*
+ * The array is sorted alphabetically in ascending order,
+ * with the exception of VHOST_INVALID_FEATURE_BIT,
+ * which should always be the last entry.
+ */
 const int vdpa_feature_bits[] = {
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_F_RING_RESET,
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_CSUM,
-    VIRTIO_NET_F_GUEST_CSUM,
     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
+    VIRTIO_NET_F_CTRL_MAC_ADDR,
+    VIRTIO_NET_F_CTRL_RX,
+    VIRTIO_NET_F_CTRL_RX_EXTRA,
+    VIRTIO_NET_F_CTRL_VLAN,
+    VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GUEST_ECN,
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
-    VIRTIO_NET_F_GUEST_ECN,
     VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_TSO4,
     VIRTIO_NET_F_HOST_TSO6,
-    VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
-    VIRTIO_NET_F_CTRL_RX,
-    VIRTIO_NET_F_CTRL_RX_EXTRA,
-    VIRTIO_NET_F_CTRL_VLAN,
-    VIRTIO_NET_F_CTRL_MAC_ADDR,
-    VIRTIO_NET_F_MQ,
-    VIRTIO_NET_F_CTRL_VQ,
-    VIRTIO_F_IOMMU_PLATFORM,
-    VIRTIO_F_RING_PACKED,
-    VIRTIO_F_RING_RESET,
     VIRTIO_NET_F_RSS,
-    VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_STATUS,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_RING_F_INDIRECT_DESC,
+
+    /* VHOST_INVALID_FEATURE_BIT should always be the last entry */
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
2.25.1


