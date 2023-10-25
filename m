Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B77D7230
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:20:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhWq-0002Xp-Tf; Wed, 25 Oct 2023 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1qvhWo-0002XA-Ih
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:18:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1qvhWn-0001lZ-00
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:18:46 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso9083155ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698254323; x=1698859123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oziu0b/58XNG4oLsAK1xwSryTw0y+7AfpE+oCSmUvUQ=;
 b=CvkfKz2JmOudi8iIuel2vY18aMyshjMTHZCVW0/lV1upiHDYf+mTc+yGYdmC5lY1gi
 pvxI4Sfcjabfahx8sW1eNrAptmwkqdS8yGmpLLacX3OauVN+py16+8RMJZXgdYNrA9fv
 v7M79dUZYV531RSZolNFlkFMwpOhT5phA4QH66Lj77qxlCHMudfyR003mBS45RXADFA+
 iiSjDRAJl9nvbtuIikrvHfo1lkDTah2X/6kgjQB8+CNHNI1AZ3spppXm9CUdU9mT+MC2
 B0NFgaJvgd8MQS0cv29YeMVyCaBh24ct3yHuF93655t/4hGQ39uZUGfqFREc2FUiomPR
 n4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698254323; x=1698859123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oziu0b/58XNG4oLsAK1xwSryTw0y+7AfpE+oCSmUvUQ=;
 b=ID1ksotGAXsG3s214aTssVHOqwpBukC0DL+4YUjfWXuqEnKrItn+GgZ3yFsWcI2qxL
 rAXzSajnd2Iw0hcA5ayIL0+79Ec7iciYVNNzMygIiBK/REPv6DuVuxDxY38RusbJQz10
 XeJ+h2dmql4S1GMwhTEUMSg9WWiQMN3xnibITjy147v06TiCa2qEKs+FQVIZM2TKzvP5
 iR6hqeXeyOTJ6Dh+GLhcPQ8Dh4759Y0mEL8qUxRZZIgQBVXceGKBv3s+boch74/RaGJK
 7l1Cbf3gL3FQoROFwp0UPcHh8kfZAuI5T+hAtVNNH/Wl6sUQXf7kaMYnDGHaeuZy1ECe
 ewpA==
X-Gm-Message-State: AOJu0Yzj+rXTdWT3HUHJyKGytdUCxZE/107SA/cDynOkRXQun/AW+xcK
 z0gSnAOJyEHQLgS/x2K9JqgmWQ==
X-Google-Smtp-Source: AGHT+IFLmU2MySXhafih6gZUBhIYQLLZuEBih5xigsUQUWyf1QYYVn8pGHl5i0Pdq33TB27cmmpirg==
X-Received: by 2002:a17:903:2306:b0:1b8:a67f:1c15 with SMTP id
 d6-20020a170903230600b001b8a67f1c15mr356982plh.25.1698254322668; 
 Wed, 25 Oct 2023 10:18:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:60a2:aa5c:7b32:6823])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a17090264c200b001c5fa48b9a0sm9736901pli.33.2023.10.25.10.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 10:18:42 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: mst@redhat.com
Cc: viresh.kumar@linaro.org,
	lulu@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] virtio: rng: Check notifier helpers for VIRTIO_CONFIG_IRQ_IDX
Date: Wed, 25 Oct 2023 11:18:41 -0600
Message-Id: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Since the driver doesn't support interrupts, we must return early when
index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
did for "91208dd297f2 virtio: i2c: Check notifier helpers for
VIRTIO_CONFIG_IRQ_IDX".

Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/virtio/vhost-user-rng.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
index 201a39e220c5..62142b717f73 100644
--- a/hw/virtio/vhost-user-rng.c
+++ b/hw/virtio/vhost-user-rng.c
@@ -129,6 +129,14 @@ static void vu_rng_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
 {
     VHostUserRNG *rng = VHOST_USER_RNG(vdev);
 
+    /*
+     * We don't support interrupts, return early if index is set to
+     * VIRTIO_CONFIG_IRQ_IDX.
+     */
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return;
+    }
+
     vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
 }
 
@@ -136,6 +144,14 @@ static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
 {
     VHostUserRNG *rng = VHOST_USER_RNG(vdev);
 
+    /*
+     * We don't support interrupts, return early if index is set to
+     * VIRTIO_CONFIG_IRQ_IDX.
+     */
+    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
+        return false;
+    }
+
     return vhost_virtqueue_pending(&rng->vhost_dev, idx);
 }
 
-- 
2.34.1


