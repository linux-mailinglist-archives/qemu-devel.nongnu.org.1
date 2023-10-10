Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E88EC7BF128
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yY-00049W-Pw; Mon, 09 Oct 2023 23:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yX-00048a-8C
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:00:01 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yV-0007z1-P0
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:00:01 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27ce00abfc3so365879a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906798; x=1697511598;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZJMBYYnCWEwvRg2gfLk3cTIM7Y+WdKEHdFL7B88ioM=;
 b=3d2CPZAcpPxbU96ujux7D/YJVrESLVwYy99w8HBdTt8/zIROkYLizvEY3IZCNqZe3g
 h507B4e/8x20HJ6clFyZ1C2OvFCz3IFTopYFwxszjvLvD7DeqO6lvxW0gZK8MSdkLfZG
 F4bk5s83EwEhKoiWGYe9rbY0tEUA6l+5T7UOoMW9dYCryPi0WycIOYEpoOplyLJRjNtO
 N+a/BGL7/GjJx63srXqyTnI4L3/P1jI6XSJfIrj1njjc7WPHYGh/z7jupB4v57FNiDmP
 Eb3JnKbL5HR//vGVxFSUCTAiNm+yRq7v1NOeRP1beyvk3GYKA7vF3i1T2hu11TrgFdA0
 0etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906798; x=1697511598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZJMBYYnCWEwvRg2gfLk3cTIM7Y+WdKEHdFL7B88ioM=;
 b=sELvDbvVS8snRru6yA4d/v29lwrm2QKYG8/k5kQ2r1ia+qt4UMMFrNWl90FWpaRHaW
 T+vcxKUajIhpnQ3JEasOJ9ZXXkuiOYq5QUjYef73IDkVN2htCLkdQJwMYQx25jinN85e
 9Dwr2OlpQBBgpp8GUlj4KzrinkoeOiI2PtNTHJj6DHzT+YnOgA+79BICWIMfWTwuhEWa
 6KOzcp7RVicxfmorjWv1YxZbqnz1YTS+r8tyAWhNwmz5Aj2yXN+wwbIeEnSZ8xQKjq3r
 UcyciGWyM/HEIRwH8ySf7Z7dZnwUcgSSzT5Kgr0mEV6nZsjCltFat/b9kAUMXuMpG1y1
 CVFQ==
X-Gm-Message-State: AOJu0YyAIxpz+CZG3w/eKnVtqk9n6B7NycGtsGdhv12yb02FeZDTSsk+
 1DiVtJF79KnIrB+sJuguJbuhXD9qXguI6g25Qdw6Sw==
X-Google-Smtp-Source: AGHT+IEsFO9EqmcyGkhltgMMMeG8XXm1UDTTZLOV4ADeUseqAuRsNx05QLhQQeqgmuwepoTAHeXIzA==
X-Received: by 2002:a17:90b:3e8c:b0:276:ae8f:2456 with SMTP id
 rj12-20020a17090b3e8c00b00276ae8f2456mr12835210pjb.3.1696906797919; 
 Mon, 09 Oct 2023 19:59:57 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 o12-20020a17090a3d4c00b0027782f611d1sm11915111pjf.36.2023.10.09.19.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 6/7] virtio-net: Do not clear VIRTIO_NET_F_RSS
Date: Tue, 10 Oct 2023 11:59:20 +0900
Message-ID: <20231010025924.14593-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Even if eBPF is not available, virtio-net can perform RSS on the
user-space if vhost is disabled although such a configuration results in
a warning. If vhost is enabled, the configuration will be rejected when
realizing the device. Therefore, VIRTIO_NET_F_RSS should not be cleared
even if eBPF is not loaded.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 05f9abdbcd..3bb4bf136d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -775,9 +775,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
-- 
2.42.0


