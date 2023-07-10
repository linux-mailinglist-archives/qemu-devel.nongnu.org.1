Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CA74D9F9
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvW-0005lp-9I; Mon, 10 Jul 2023 11:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvP-0005l2-IP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:43 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvG-0004lT-5h
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:43 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso5484246f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003329; x=1691595329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4Dz/cKQcjk2Q/25bTqazNT9L0/TcrBA5Nkd7fUVra8=;
 b=IQ6KxQRuWoZTFUkZL8wqDIz4YT5YYYlpRTK64s4+asCrYQkq5sXvq0jbS4LgRX+juo
 FtY4+9d3ucFJRqycocNYzmkhe4UgUBGlsz3IrUIOp0FByx1E9dRL0/zMBv+TcbnnJReW
 tQjCnWQqFqJR2PF0iIBVAb7oWo9T8iWebaIaek0j3O3PolB/hK7o0uSDLJk5cX1Hd9Ui
 wjUTkyz46AX11puBd1fk3BeKwLDm8YLQLeSp7imUg4gwcmcCan+Ke0NUqy19t5G1D/7Q
 TG73nLUjtZpcj4x+O2BS3mK1qixN6ydz9YwDwJ8lWw9nC7Bp8SUjREKhknKybzAN/DNp
 9uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003329; x=1691595329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4Dz/cKQcjk2Q/25bTqazNT9L0/TcrBA5Nkd7fUVra8=;
 b=bDjlhL02SVRa9lKQVLWpwvGy2u0Yctr5DvvhusPe8WUmIrjAmt9XVXZBLiYCk+jP3B
 szAwLePCIlNDciYIHe6K1fM92a/9lCMyw87HIF9/vHZyMqNpXSQwJ9u+BQmFp/iJO0lV
 yWJSRT4wDx443iK2v0GmBnd/Napyo5r1E8icA8PR8njIkRpAwcyalkusevuGEo/PxSsm
 o0ZTXO/TMlXq2fqOAsdW5qdMHzoLqIaXfPwzdU3T0MAfy/TB3K8LmjIm+CSA1X3sSwKJ
 /adk/Lxi57OqSm4kLr9iokZfWfPCtTcPAmyj2Yaw44O/4MMngJzBv7ydUnjdGqn3T05x
 ialQ==
X-Gm-Message-State: ABy/qLZaLlV5DACgtIglXll+z/3g0c0R2zYF1klWrnQuJ7wAW4CgE/0H
 epsDeuKGeawImIs0VJjOiq+0Zg==
X-Google-Smtp-Source: APBJJlGyE8NadaMb5lf7uq7Fyt7eMqn7be03+L0hlAqNUn42AmB973J3q8ym4y5ZSWGt6AihPC2DtQ==
X-Received: by 2002:a5d:6d4f:0:b0:314:3c8f:d267 with SMTP id
 k15-20020a5d6d4f000000b003143c8fd267mr14974373wri.45.1689003328955; 
 Mon, 10 Jul 2023 08:35:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k6-20020adfd846000000b00314315071bbsm12040337wrl.38.2023.07.10.08.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A5DE91FFBF;
 Mon, 10 Jul 2023 16:35:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 04/20] include/hw/virtio: document virtio_notify_config
Date: Mon, 10 Jul 2023 16:35:06 +0100
Message-Id: <20230710153522.3469097-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/virtio.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0492d26900..0671989383 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -276,6 +276,13 @@ extern const VMStateInfo virtio_vmstate_info;
 
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
 
+/**
+ * virtio_notify_config() - signal a change to device config
+ * @vdev: the virtio device
+ *
+ * Assuming the virtio device is up (VIRTIO_CONFIG_S_DRIVER_OK) this
+ * will trigger a guest interrupt and update the config version.
+ */
 void virtio_notify_config(VirtIODevice *vdev);
 
 bool virtio_queue_get_notification(VirtQueue *vq);
-- 
2.39.2


