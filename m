Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E007E47C7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:05:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QPd-000858-EY; Tue, 07 Nov 2023 13:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPb-00084j-3M
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QPZ-0000db-F7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:02:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40850b244beso45162005e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380168; x=1699984968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZRUMwiWEGUH1111nhqAP/d0bCasvHH98Sdsmx1hRdc=;
 b=Fa5PCKPXL1VSdVK2ytgFmIZHbyQogAr9WI/CA5VWqWjl61+73Bs/bN/szmxWMtnazX
 aj9CYqUW1TOrBzcIjnWk6969E3OcNyHTDrRPgRYX1I8NbuAt0aulDCON9Ajl5d5MW2Fh
 9MYbWkEpsV0FyiUedYYwaJd5lxy0X5ck/qBoYRI8wVqCE4XzqfDnuCg7VZx9N5Ve1F71
 fZyEMU9wekBEAAWWKWTy4U2G9pvqyzM0U4C90WKxsv4UMD4Hjozl0GGm3b4ulS1h+odS
 j+1aujhBFiC5LTCQTuc27uuc9usjlnNBnU9NNvRJFe/fOJg5Eux+8F5hwowWV53TBSyZ
 jCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380168; x=1699984968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZRUMwiWEGUH1111nhqAP/d0bCasvHH98Sdsmx1hRdc=;
 b=qpLY5AX6lqD2opz3clnfKGXlqCotaN7/5JU46JMQCbdMLqeUZEWbuAJuPT3VJZRHhA
 R4e0Q76pm0j9zmv/cyx8W+oOmYgv5BGt75H00PiNUyiU4aUOLFJPVGT9Y3eiEYIm5XOX
 HdkePfKF42p4A3H61SwPDbw9UTk4dWFvpnCfFsPY6/US9s+S7bWEPRlHbOevCya0baTU
 FP2uPo9THbgK50CEl3ZeOfdgp+0AAdoXGLcQf7xQrRDEnzhgRfeOmM+DGjNBFl38z3Dk
 KShB8I6YRcCFP+9YXjynWF9qu/aRD3r2CyXda6wrA5bJ77D+TSTAA3caj1BYlo7di+/M
 XIRQ==
X-Gm-Message-State: AOJu0Yx2oIMbwvL9i70DmmzBvXym3Z6j/YkmEjwbMw8oO8/zKhVaLomm
 8ilp1DRBoZwdJdhye03GYwBDBQ==
X-Google-Smtp-Source: AGHT+IH5Ryzsi9s/1ylT5IsaR8y0tc+oSuQ7xkUfXzGmGXVbCjonk34PYJZKQK1B2eV24Pca0Bsrvg==
X-Received: by 2002:a05:600c:4f92:b0:405:82c0:d9f3 with SMTP id
 n18-20020a05600c4f9200b0040582c0d9f3mr3196022wmq.30.1699380167943; 
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b00407b93d8085sm16656588wmq.27.2023.11.07.10.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:02:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D6DE16573E;
 Tue,  7 Nov 2023 18:02:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, virtio-fs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH v7 2/7] hw/virtio: convert vhost-user-base to async shutdown
Date: Tue,  7 Nov 2023 18:02:41 +0000
Message-Id: <20231107180246.3456598-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180246.3456598-1-alex.bennee@linaro.org>
References: <20231107180246.3456598-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

We are about to convert at least one stubs which was using the async
teardown so lets use it for all the cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/vhost-user-base.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 620fa5cb4a..78cfa9a5bb 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -201,6 +201,8 @@ static int vub_connect(DeviceState *dev)
     return 0;
 }
 
+static void vub_event(void *opaque, QEMUChrEvent event);
+
 static void vub_disconnect(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -211,9 +213,13 @@ static void vub_disconnect(DeviceState *dev)
     }
     vub->connected = false;
 
-    if (vhost_dev_is_started(&vub->vhost_dev)) {
-        vub_stop(vdev);
-    }
+    vub_stop(vdev);
+    vhost_dev_cleanup(&vub->vhost_dev);
+
+    /* Re-instate the event handler for new connections */
+    qemu_chr_fe_set_handlers(&vub->chardev,
+                             NULL, NULL, vub_event,
+                             NULL, dev, NULL, true);
 }
 
 static void vub_event(void *opaque, QEMUChrEvent event)
@@ -230,7 +236,9 @@ static void vub_event(void *opaque, QEMUChrEvent event)
         }
         break;
     case CHR_EVENT_CLOSED:
-        vub_disconnect(dev);
+        /* defer close until later to avoid circular close */
+        vhost_user_async_close(dev, &vub->chardev, &vub->vhost_dev,
+                               vub_disconnect, vub_event);
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
-- 
2.39.2


