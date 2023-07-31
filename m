Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E04276A435
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 00:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQbRW-00013S-Lg; Mon, 31 Jul 2023 18:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRT-00012C-2j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qQbRR-0002Ug-EK
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 18:32:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31783d02093so4600069f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690842760; x=1691447560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iu/VH6iMKuUxxyQPM1EhE4e/T9vxFBVOqC59TnKMtyQ=;
 b=Jmu/m+omskc2AbleBTZ48SoHvBO55LzYQHghrlBuvp0tHmKs1W0BSQNBO/HttM0sky
 phPmZ/opIH4ONfpV0nZXPtAkmHkygyy2UhFi87rVMQ6bhkVxmgXDBjtzlAyXsBEOcAEm
 Iy5e2T32QRTUFC5B2xVXRJXZOpzUy/bixDMFAgADg2HOE3sRk5RpiJNBAPnAH50HTvdN
 d0rv+10LsXom9PQoglHgat7pFsh1aAARhFhrTp+ZJGXLjsAE59Vhz/x2PGDNwTuEoO7P
 k3eXeqwqVi1WyZUiropUQqC2mXyVYcR6I8giK1+DBvdAk9WTpJG7F3aZod2uox8Lc0dk
 hnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690842760; x=1691447560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iu/VH6iMKuUxxyQPM1EhE4e/T9vxFBVOqC59TnKMtyQ=;
 b=RxfAO5Dy0ACz3KHzRmoeEYfN93DU7gdsUfXNk4cgTM7mHIYqY0r7G3VjmrpcMPMshz
 CxRWcuEdRmVssap4QHGOVIM1yLZaTSK6X8Og5AXhBT9jJkN0vJEFV/BvHr/Luqcnf4VN
 6Z8R2RWvxQAwg2GimABKVFLXcS2K5HR8QLIuZUnRlj9DpBI73LC9xjQdA20A6Nz75Cjm
 ShmQrhHdW6EKD3U+lEjdv79Y6TqB7URIOY6u8QyA8dT9BWloBsP3NnPvjfaiJArnEmv4
 XwXjD7rpz/kGKiZuh1hTqUJKpiACJGHvMpMMmDpP0fH3Ftg4oayUMG7GW7aj/SRlFW64
 CaoQ==
X-Gm-Message-State: ABy/qLZEl4kLBzQPDz/XEr16yjeuvyfjRAT4WecqrOQvUavI4h6eAWBO
 bLJKrxJM0g6yu8Sfsdh9yWycMg==
X-Google-Smtp-Source: APBJJlFfaNWID1x7cwHA3j2FAiofWytmWlbV1wTNbuasG+lJuvUHSBZ6aYi4f4Lsqc0/355rgUPrkA==
X-Received: by 2002:a5d:43c3:0:b0:317:734e:3614 with SMTP id
 v3-20020a5d43c3000000b00317734e3614mr774350wrr.39.1690842760009; 
 Mon, 31 Jul 2023 15:32:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a06:c701:46e5:f400:91e1:5f50:afab:4c79])
 by smtp.gmail.com with ESMTPSA id
 x5-20020aa7dac5000000b005223c34259fsm5915088eds.57.2023.07.31.15.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 15:32:39 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org
Cc: yan@daynix.com
Subject: [PATCH v2 3/4] virtio-net: Add USO flags to vhost support.
Date: Tue,  1 Aug 2023 01:31:47 +0300
Message-Id: <20230731223148.1002258-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::434;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrew Melnychenko <andrew@daynix.com>

New features are subject to check with vhost-user and vdpa.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/vhost_net.c | 3 +++
 net/vhost-vdpa.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b958d6363..57427a3997 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -78,6 +78,9 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
+    VIRTIO_NET_F_HOST_USO,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9795306742..1dca37aae2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -75,11 +75,14 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_GUEST_TSO4,
     VIRTIO_NET_F_GUEST_TSO6,
     VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_GUEST_USO4,
+    VIRTIO_NET_F_GUEST_USO6,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_TSO4,
     VIRTIO_NET_F_HOST_TSO6,
     VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_HOST_USO,
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
-- 
2.34.3


