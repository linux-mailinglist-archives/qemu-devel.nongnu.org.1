Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0474DA04
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvi-0005uj-7Q; Mon, 10 Jul 2023 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvV-0005nm-Ao
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvI-0004nD-54
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-314417861b9so4699180f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003334; x=1691595334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKWNeoNsx/2Bubdm0GX5BfFMkN3cqqCetF/HK2T9c0w=;
 b=rqCoGiZpI4oisj7FdN/P6Pm6psogPLWGKfNE+QfmXGA6uns8bkHBwl9nUUc7Slpoux
 REs3/Y/tHGGUIV+GKSrXZygLL22svBBmvZkICCzTUBMDW7ay24vp4zi2zSHT6gYaUtAl
 SlzIMHB5KsNOvlOohboHl7kwRCJIGofIdkMuGWnXw5tR735M3U9hDfYXGsA5UvsOf9/y
 HDkatK5aMg0f/ZRqh6y5/4DV0rQtdCDbIgq/MB4M5h/skqpFWG/+3Bu1c0OFDwVyaKR9
 YQP1UG8GnC5dtKmAch3dCV8FVxsfMYlgTM2qCA69dNIyF2SYYLTZnTkIbPjOC0zbFt6q
 yGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003334; x=1691595334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKWNeoNsx/2Bubdm0GX5BfFMkN3cqqCetF/HK2T9c0w=;
 b=HMM+rS7hb2g+zcbahWiYFqocA36qp+779Rkx27dc/L1I+0u5d/ocr1HuhymMu3JmAl
 rhPzRrpCzSMfEAlru+9WYsGBH/cSqd68WCV4pfk8rcUM1VRXOEccChp/d5AVb4z5HFYQ
 ZdJ59HuByRFxzv7K6ZQyUTz5uggOCZkHJAvAp/uK6Tsk8qUywCw+uv7A6iOkQCPvTBlz
 njf25NnNsMFOXSfLXToFHqSTiMvjOFc9UHKI3xPlynRBKqWNbZ1OVMMqxizYuS8gngdS
 RpTmy+b8JdYQd+3ISYjDcEpuyTgIHKOFm6LVuXHiuR0mP0KYjCSDrypQll5LhDxHSrRz
 sakw==
X-Gm-Message-State: ABy/qLbjVz+zE3VzWB2QvMuwmhJtP77vm5V2rxkWJ6WNM7dLekqXXVcb
 Vy8379lEU3BA/DOQW+GHU0t0Mw==
X-Google-Smtp-Source: APBJJlGw9qM9SK6bYMSM1ND6J2LqwWR16CpdvsLdUAHazLEO0aNrfGRuIcc3OQBVySEfIWjCVDBZeA==
X-Received: by 2002:a5d:674b:0:b0:312:8e63:71c with SMTP id
 l11-20020a5d674b000000b003128e63071cmr12803306wrw.32.1689003334661; 
 Mon, 10 Jul 2023 08:35:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a056000137800b00314172ba213sm11948883wrz.108.2023.07.10.08.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E7A201FFBB;
 Mon, 10 Jul 2023 16:35:23 +0100 (BST)
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
Subject: [RFC PATCH v3 15/20] hw/virtio: move vhost_user_init earlier
Date: Mon, 10 Jul 2023 16:35:17 +0100
Message-Id: <20230710153522.3469097-16-alex.bennee@linaro.org>
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

In preparation for getting the details of the VirtIO device directly
from the vhost-user daemon we should connect once we have validated
the chardev. We will actually move the connection in the next patch to
keep the changes small and bisectable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost-user-device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
index 2b028cae08..d787f52364 100644
--- a/hw/virtio/vhost-user-device.c
+++ b/hw/virtio/vhost-user-device.c
@@ -250,6 +250,10 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
+        return;
+    }
+
     if (!vub->virtio_id) {
         error_setg(errp, "vhost-user-device: need to define device id");
         return;
@@ -268,10 +272,6 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         vub->vhost_user.supports_config = true;
     }
 
-    if (!vhost_user_init(&vub->vhost_user, &vub->chardev, errp)) {
-        return;
-    }
-
     virtio_init(vdev, vub->virtio_id, vub->config_size);
 
     /*
-- 
2.39.2


