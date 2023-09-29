Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7A7B2E9C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EM-0006M7-EJ; Fri, 29 Sep 2023 04:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9EF-0006A8-QO
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:07 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9EB-0005o6-7q
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:06 -0400
Received: from pasha-ThinkPad-X280.intra.ispras.ru (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id BED7C4076742;
 Fri, 29 Sep 2023 08:51:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BED7C4076742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1695977505;
 bh=bSykyvCv+UImIyNEEnq+8pfBQ8xwbQKTxoM4yyTd63M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RwszhbkKS1p288zdamBUfh0UGakwUye0WTfde3pP8J8nq8roUxpdJveWKpmoaQ+Ym
 WebT7koKj85Kled/r90INscd+8aK9ElxOYLiFv+Ca3tSk3llcxVR2SPOcVc86Gsa+U
 lF1PRjkRbZ1E47pFHB6BzXXdNL3rf9pO12qW4TMc=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 jasowang@redhat.com, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 2/3] virtio-net: added replay blocker for guest_announce
Date: Fri, 29 Sep 2023 11:51:20 +0300
Message-Id: <20230929085121.848482-3-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929085121.848482-1-pavel.dovgalyuk@ispras.ru>
References: <20230929085121.848482-1-pavel.dovgalyuk@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch blocks record/replay when guest_announce is enabled,
because this flag breaks loading the snapshots in deterministic
execution mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 hw/net/virtio-net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 50156e8002..eb50b7e030 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3603,6 +3603,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
     }
 
+    if (n->host_features & (1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE)) {
+        replay_add_blocker("-device virtio-net-device,guest_announce=true");
+    }
+
     if (n->net_conf.duplex_str) {
         if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
             n->net_conf.duplex = DUPLEX_HALF;
-- 
2.34.1


