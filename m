Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0867E47DB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:09:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QUd-0006nP-Q5; Tue, 07 Nov 2023 13:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUX-0006kn-Uf
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:07:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QUV-00024C-2x
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:07:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso37147745e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699380473; x=1699985273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZRUMwiWEGUH1111nhqAP/d0bCasvHH98Sdsmx1hRdc=;
 b=kwoEUgyRxDMhhs2oNNQqetlD8/53QUwSNXw6IyalvpZeWKCnnVEE/A/r1/a3X9ianO
 ieRb1VYVAX/pH5kZCoIkXQz/3oclFbrr3/qHRGF872QAPNYtIrcR9/LsDyAIluK4nyJs
 Fm+4tFy6mSF+Q5/NFDUorKR0OMQf96clG1xvvAqkuaPrPdGw5wj8Wr7gP/kOvLR+S4Ni
 ID3RNxlUQmoUSDXDWyzmLzL9qELNSsJMojtR6UEQyYy4yLI1bv22jvUqI+juVmxjwh+x
 D79UTzQB6T8B4v/uG7iuJxzoRU1iHRq0EYKuXOpvnUgfLeDuhYLS9Og4cGSJmxNjstXT
 LNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380473; x=1699985273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZRUMwiWEGUH1111nhqAP/d0bCasvHH98Sdsmx1hRdc=;
 b=Ysej+J6Es2SzLN1+P0r/GTJMmQR1p6wAZ6dfW7MTGVhHzlt4nwxMYW0xRTTN8/heB/
 OQmjSrTFM64Bf6/I3xdT6w2kob23J33R9wTkGtCNAPPy6uM7MEwGSCkzTnz2B7Bm0RTJ
 262RaOeHBT9F7KIpc72HtmH2UrwZmoXC/B7bZTmpJ5xcXZVR3L0HWJ1K3lorq2iDP5Xl
 7v8A3QlavsQY11LjxVGs+Ef4TckTdCxQICDAhcWgXZpfUUhzxaG1yla3U9NDdwc+1Eu5
 9NZtvvNmIyWIY/7uTLEJ42JMWPayJjcK1Q/Ur9uxMXl0hiWw9Dg9ebEE6kE4q04NGPEk
 fv0Q==
X-Gm-Message-State: AOJu0YxD+2QbGz8z0epP64C3IXrjegFhfNFH9BE/FNCtShINhVLeE9QA
 PiSU2EmYkf7t2DrZA9GMtucVUw==
X-Google-Smtp-Source: AGHT+IG8AgDGHCxoIxRgpEPr7SjYW7cQ8gCqTveJUNL7nekoOBkka3+DSkPzHHxfIqYVE+w3z8dkGA==
X-Received: by 2002:a05:600c:458e:b0:408:3634:b81e with SMTP id
 r14-20020a05600c458e00b004083634b81emr4309351wmo.13.1699380473564; 
 Tue, 07 Nov 2023 10:07:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004060f0a0fd5sm16618867wms.13.2023.11.07.10.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:07:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 997256573E;
 Tue,  7 Nov 2023 18:07:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v8 2/7] hw/virtio: convert vhost-user-base to async shutdown
Date: Tue,  7 Nov 2023 18:07:47 +0000
Message-Id: <20231107180752.3458672-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107180752.3458672-1-alex.bennee@linaro.org>
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


