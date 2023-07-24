Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A175ECA3
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 09:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNq9H-0002mo-Oe; Mon, 24 Jul 2023 03:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qNq96-0002mQ-BS
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:38:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qNq8o-0008Di-Bq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 03:38:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b8b4749013so32493835ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690184157; x=1690788957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qlztDq/CKb91JnaGmc1JrV/AEfrFJEe1DDcUZ8Ogc1M=;
 b=dOGvWkuaBb5NW2SWh+TAqdaGAHSEf9OOiveAeeCRAfQ+LC1vG/+hmZXWvWjdEOCWn+
 jIkbWQxRtGk0HNBLr69odsSm7Mx5IdDhQChkQ/3AJDQ5bWSL0Z0ud0Q03zhMsOlRXJeN
 9Tg7JXCrDX2M2SMf5W6A5Mmws/JOBHBSt6hGfGSkOmzDNNLSUAp+hjoHvuVPeWzwNZ/M
 z7mJx6VB20oOnEWowWQ+DsCSy6tXYwy5ZMf7G5cpGv4YcOUeOJZn7xKHCh2pCjv89PWi
 TEGGK5l8h69jy2ISJqKd4wAkinYjUL8nIxmJcEDEqZijFEc7Ahm2qtjc9hyydKbDJSGA
 8DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690184157; x=1690788957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlztDq/CKb91JnaGmc1JrV/AEfrFJEe1DDcUZ8Ogc1M=;
 b=I4BROq0zikyHzKb31ibB/VKrrL9fWx9iUAFunUqEKKwCDq/s0oK2wXrbayUBuak+2h
 LX95+07++Z/+cf3TsMqt2H9qib4UiDs47itWGe3QIbHcdTVezxGcZL3RQM7eCfaGNzXR
 SMgj0ArkTeuAs1pqOIbjSLt5kRUQhOdKbMxtfd+bVhe1WzlMdqhUiQTp+eqXxzL/RklX
 BYEZk0NNBvPyOznYXUTY2CTcXO8UohWVlWYD12/iOpMjVlRJQ2KLWE6kGiM4fwN9TSpO
 BEZITAVH33yiYfwjwPfT/kqN4x0zLXDdBni+2w5Vg6aF20KJJW3/pLu4jIcFxWM5ktcD
 iF9Q==
X-Gm-Message-State: ABy/qLanX9KFzlJdRqyXLaLxrGhdMWmQ9ej+3JHcKup/udZhV1pEUANb
 v0+29tFIo8gmkDqrzeDhVlkR0w==
X-Google-Smtp-Source: APBJJlHMlc+c0L0Fnu9EBNEKhKEDVvkBbBt3jx1m7KP9yMakwqHo43yK/6x6MZeTr+T6Df+qltlfWQ==
X-Received: by 2002:a17:902:da90:b0:1bb:9c73:1a3d with SMTP id
 j16-20020a170902da9000b001bb9c731a3dmr3724051plx.21.1690184156352; 
 Mon, 24 Jul 2023 00:35:56 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a1709028f8f00b001b8943b37a5sm8129643plo.24.2023.07.24.00.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 00:35:55 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: lifeng1519@gmail.com,
	Li Feng <fengli@smartx.com>
Subject: [PATCH] vhost: fix the fd leak
Date: Mon, 24 Jul 2023 15:35:01 +0800
Message-ID: <20230724073503.2808832-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=fengli@smartx.com; helo=mail-pl1-x62b.google.com
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

When the vhost-user reconnect to the backend, the notifer should be
cleanup. Otherwise, the fd resource will be exhausted.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/virtio/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index abf0d03c8d..e2f6ffb446 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2044,6 +2044,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
     event_notifier_test_and_clear(&vdev->config_notifier);
+    event_notifier_cleanup(
+        &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
     trace_vhost_dev_stop(hdev, vdev->name, vrings);
 
-- 
2.41.0


