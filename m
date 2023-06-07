Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AA725E57
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6s30-00070b-JW; Wed, 07 Jun 2023 08:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2y-0006zz-DT
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:52 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q6s2w-00037z-TA
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:13:52 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2562cc85d3dso5903522a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686140029; x=1688732029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYE+hrjafe8dBGkpId9YQg5DNbVTDjZnJ3U5uCLPmto=;
 b=BSAhbMQmNXYhRkvKGnc+8Gnj+hmGDQgHw6toFypAYGSPu79DLoN0cGOqQaAjkzw3uP
 HWAS0v8bVaK4KMjdy3A3LbukPNFKCspSytRMml85UtUutuTEBplLvT3RcZEN87LRkrBE
 X/AiKd5TXaeqGSAEZd1Kkw1B/57VAmel8zq8bKRen6CmOuIcw4+PvZKZLuhhDlEhgCpX
 f38w6pfqYNA9bnp3ZPN26zh0MsneeLg/60UY1WkJKpInjzw+LfFfMyEtBC22xQktNhoQ
 LnuBUZgET41daP7MgsKY8rHEgA8aBRkdEG3nOH4od/7bn0Qogm4EWobwUv/hagNp+aKr
 p+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686140029; x=1688732029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYE+hrjafe8dBGkpId9YQg5DNbVTDjZnJ3U5uCLPmto=;
 b=Aq5HVcjZa49kqTb6is8SZbG0jPG8xC5cYAl3VSq7JZE42d/00VRSaFZpAPevUnySlJ
 qLUmHIyeiASh8FRmxkJ1YjwaZU3RNthLZOZmFj95rNFaf9ELn5aKGEEI/SJ0N72jIAIc
 ZfQdtB3VS7kJZ6kxVB/YS46lDQX25y8M4Om12xzJ9ATAaPiTYcbbfZ5pD3jk6ipX0C+6
 Lh5whBIkWz4e+NrHbSOeOeJPS48JC21fN86cn3HT8OeQCzQis9zK3wBHcLVCyxW21Q49
 6Dun9xCnBrDDlVD10oIqNAmPdJUsvIeGGuuLp4bgnZKXdRsv4/KWgOXrqlUp/Bpn9e4B
 5zwA==
X-Gm-Message-State: AC+VfDwdbDBVMGXV93GWLd/xqxd3EM/pZSv9zv5xOi5sjNcoiP5faJx2
 AXrKX3eJrln1LGdKDqj1NeM=
X-Google-Smtp-Source: ACHHUZ5T+yx2bnV1q/nryTGSEMxbK2lnLK9TDHRW1Tas4/h73jdCFXTjQk7w5MUWqI6B0wNTAyF0gA==
X-Received: by 2002:a17:90a:4302:b0:259:343:8e74 with SMTP id
 q2-20020a17090a430200b0025903438e74mr4640633pjg.7.1686140029166; 
 Wed, 07 Jun 2023 05:13:49 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 m8-20020a17090a4d8800b00259a750fc89sm1238096pjh.33.2023.06.07.05.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:13:48 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 2/2] vdpa: order vdpa_feature_bits array
Date: Wed,  7 Jun 2023 20:12:18 +0800
Message-Id: <38d3ca3e9fdb9600c611ec24a09e14e1735674a9.1686137925.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686137925.git.yin31149@gmail.com>
References: <cover.1686137925.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102c.google.com
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
 net/vhost-vdpa.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d90c8e2796..87c5e6a700 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -47,13 +47,9 @@ typedef struct VhostVDPAState {
 } VhostVDPAState;
 
 const int vdpa_feature_bits[] = {
-    VIRTIO_F_NOTIFY_ON_EMPTY,
-    VIRTIO_RING_F_INDIRECT_DESC,
-    VIRTIO_RING_F_EVENT_IDX,
-    VIRTIO_F_ANY_LAYOUT,
-    VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_CSUM,
     VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_MTU,
     VIRTIO_NET_F_GSO,
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
@@ -64,19 +60,24 @@ const int vdpa_feature_bits[] = {
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


