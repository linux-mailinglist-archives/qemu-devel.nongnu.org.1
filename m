Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A493E7CB98F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPY-0007gW-Jh; Tue, 17 Oct 2023 00:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPW-0007g4-O0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPV-0004PX-6B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso3026404b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515822; x=1698120622;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ty1IxybyhWNHXp/JE5BsEZCNvT/kUKSyTE1Sr2v4muQ=;
 b=YQH626E9J1m1s1XnR9VMkwlc/WHv2YgZMcLkwtHVL3RS3Pm4RpazVfEHUlLUYdz5mC
 G5c3trbBKqDkOLrjNUaIgLe8XJYF6H5xKZMag3besj21nAu+v6bEbnAO/HBOe0B8Ob1g
 4FAAp4R+Qv1ckj/0ujdDDdXetwBnYc2sK05Ud0lyVcfL8OlJqsbk+v5ubcWEmSlLgfN4
 5Bcrh7ASt9wa4+uck3kPTcisz+N6KS6EeN48GIO3QLsAPxTpw7LKknCl4xGcb3q0b8Sf
 cOrYaNExmbFpQysTedtpmHBByOclqPSH1V6WWhPW2QUTBr0cO0NsRoCPlkVwhRQCTfH8
 QXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515822; x=1698120622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ty1IxybyhWNHXp/JE5BsEZCNvT/kUKSyTE1Sr2v4muQ=;
 b=AFcWi3DHNl6EU7SihdaEvGzHSpSaFTbnH4ZZguBAsCiM86+2xeU7dQA+6gsSukoXnv
 G95+bp0/r5EpESOs5NAZ5le3Z2ZXEVx0plgc8bBCblSh3qi0BISG5b+ZETpat5lOF7sr
 koPrQIYNDiWKchpb0IlD+UZZsQwJajRnin/Uxvdi3Mshk0f2GAgpRZlHaxSSEWSoMy9J
 /Tnw1TO9al7Hc4dZ4jB0AoWn/+32DRO5hof9VQZUPH1W1x24UVl0Tfq2ZATH0vmudgl2
 wxlGuVR1GctGF3yl0N+rR+EH25Ehv77euZI29/ILu12WcqhyTslYHCM4OaRtBivjnCXH
 68tg==
X-Gm-Message-State: AOJu0YymOxgCdFNJ823J9D9qZ5/9ZoTspnj23FwrA2VuqpARcKv5hbf6
 pX5D/we06REMUYapllg1HcSAjugH+7278U6ioeVM1Q==
X-Google-Smtp-Source: AGHT+IEbZIJ1vnoKupXyRh7UePw4yKJXK8uGMWWRtVtJDsefo+Ll3s5hXNvK7nct+++IpKLIvTWqcA==
X-Received: by 2002:a05:6a00:984:b0:6be:18a9:8f60 with SMTP id
 u4-20020a056a00098400b006be18a98f60mr1069120pfg.16.1697515822512; 
 Mon, 16 Oct 2023 21:10:22 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 z21-20020aa79f95000000b0069323619f69sm359862pfr.143.2023.10.16.21.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 13/21] virtio-net: Do not clear VIRTIO_NET_F_RSS
Date: Tue, 17 Oct 2023 13:09:19 +0900
Message-ID: <20231017040932.62997-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
index 6eb206f297..20df40442d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -776,9 +776,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
-- 
2.42.0


