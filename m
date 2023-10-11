Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533867C5850
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKQ-000308-3W; Wed, 11 Oct 2023 11:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbK5-0002pc-LS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbK3-0002CJ-Af
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso12169665ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038829; x=1697643629;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbSUUiUjCogeY0CY+1W2SS+7g039FG1VSh7/UySB0M0=;
 b=xK39CVGf82Gky3j9fSQhz4bqgcBxC5nMWjtqXy3YkVxj5vj/WVBDEZw6k1RO7CUtHX
 KsPHOaB1kUWeO3XqBI/2YcE6jtjNXNY2ayXPbLBjUZsB0tvdTJ7RwpcuUWHobUi1GBi6
 zfDsv+uUKySkJXMQM/jDJxozkacEjt5ZO4/8TbCPSicsfMOKGM+ZHXGcELh5i6F0Eny/
 +rCG//gMcg3zH225RNAPRjbN+y2l5PueHabiMIQsg6C0WPKzT0ioq25p3xHTyp5RomE/
 Z1nWuQCtnwg+aAyRb3p7wTyg4XRrF7U9mPhSD0xJ2Dk5KOBaUBzPZUVfFwSQIm/B4hed
 FfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038829; x=1697643629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbSUUiUjCogeY0CY+1W2SS+7g039FG1VSh7/UySB0M0=;
 b=fPf4t6PhiYgKNAm0D04knt2WqOGTx2CoT+u7fm4WpHVGrNMCdldKKE6IzcwdcFqBAr
 s43kPdUO0M3sn0b3T4aYIqto557PXrwKkNveWIdSnCsCq2gzPR90Shq75oxw+qU9x4Xs
 xu50VNSb8ulOqYO/yYb1bJ2b2r+m2vRgQZLlpVfBnL5CUjJsx6fYRDrKe0hWdBsl0oR+
 YXry3hWnCgM6FAlH5yTv9OKMqm9Krr9NTKHt6/vRHoEPNOywSl43sEk9+wbR4qryqYyg
 1k1g+BSIYJj3KFzQ49BHwyx95BNP02exOGsjVurflCdbtg4oz5uL73IhIYSUUrbzl94j
 S6pg==
X-Gm-Message-State: AOJu0YwHNFaMumf+GiF8wt86lCqgWEHiUSp2gIs7rvX1keTEClsA0UiF
 N7iblmiRcbRZj8PMrEdzo8YRabFh8FzeNafajxoNag==
X-Google-Smtp-Source: AGHT+IEDF16AKIKJLWfp3d78E1bCTrVHRP7Jza9m7hQ4usT7vGwY7rw+SlG/m7Mgn4zye00951BtfA==
X-Received: by 2002:a17:902:f54c:b0:1c7:2476:c977 with SMTP id
 h12-20020a170902f54c00b001c72476c977mr22713012plf.33.1697038829590; 
 Wed, 11 Oct 2023 08:40:29 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x20-20020a170902ea9400b001c5076ae6absm13983748plb.126.2023.10.11.08.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 10/11] virtio-net: Do not clear VIRTIO_NET_F_RSS
Date: Thu, 12 Oct 2023 00:39:41 +0900
Message-ID: <20231011153944.39572-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index 20feb20bb1..31a32bdff9 100644
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


