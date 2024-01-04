Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64924824A13
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 22:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUyR-0006un-RP; Thu, 04 Jan 2024 16:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyN-0006td-IK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:51 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLUyL-0007RO-Pk
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:09:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso787992f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704402588; x=1705007388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZD8gKWnWBsgVd7TCyN00x3s8+apLf0F3UjlTxysTxrM=;
 b=E3A6MIaPkEyMw46IRgs6QAdxWIDnWKd0gC5hD1HjuZ8kbXg8vFx7RI3vYdFBdlk18h
 aBOY6S4YaYN28Vf+t/Z6Q60mwPyDnZgPiHS5y1tkfrX3gHcKBVeZu+HALfWYezaxJYQP
 GhtWcNnfT4IE3GEtR9zGPTreVChIeMmQOxamMD6DdEEDT8K5FIdMBpVfrkRNzc9nW2A/
 LQ03ejYTe4233klTsfnE3yQheNTavORGKJqwcJMEZQMPv6Ihz2jJ3rXjZB6qsJ00b4ga
 9tp4vxkzq07hA8bSUt8yleNhIuyO0mQEWWTbhqKmkrxOYCMyrXy2AhxWoaSQwNtIDhbd
 8uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704402588; x=1705007388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD8gKWnWBsgVd7TCyN00x3s8+apLf0F3UjlTxysTxrM=;
 b=ajnOMLl+0+1Rp8CZHKRI26HRnoMfsCGvT8r7CXx0q1wEkfHd0O5a21aWnPYQalmNUD
 FjWlCVqmQQ01i0U5l1hs/SlodsRR+eyojhjrn5GX2a9fUhSJYvD2G7fBqaGpq/l5zLp2
 a/4mTckd0oz0/Ir5k9Eis5qsw+x9TqEaZw098oFarKi4i1+HDs8Y5j+8uRGjyB4UOuhf
 OWqW9GOyUGHsTWd0FzYdQ8sQiIKweWUq/qxa07nwxF5uLxbcJ9lKML+KNUEejPlVviwX
 tuzjJItUaww0xBGLvNC199ANpjlyNakRTJm8r4aNf61oLOjkq513Ec5jLzEhnQiBXDut
 9LlQ==
X-Gm-Message-State: AOJu0YzqUSLAOsrRDsW25D5CMk0DEPbgqiRITGopaDzcMoS3tXlzlnmp
 tVYbXaX1itsJluxGmDLFnGCYGRkFADjG6Q==
X-Google-Smtp-Source: AGHT+IHec9hGvTLZvafyymrIPDdgf3CAb+/8qfFekXThAHYDy/VVXH+8xdLJMHkNSPOPpz8vSyhFmg==
X-Received: by 2002:adf:fad0:0:b0:337:404d:4e9f with SMTP id
 a16-20020adffad0000000b00337404d4e9fmr609500wrs.79.1704402588522; 
 Thu, 04 Jan 2024 13:09:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c11-20020a5d414b000000b00336aa190139sm109726wrq.5.2024.01.04.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:09:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46D3B5F933;
 Thu,  4 Jan 2024 21:09:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jason Wang <jasowang@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v9 02/11] hw/virtio: convert vhost-user-base to async shutdown
Date: Thu,  4 Jan 2024 21:09:36 +0000
Message-Id: <20240104210945.1223134-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104210945.1223134-1-alex.bennee@linaro.org>
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
index 620fa5cb4a4..78cfa9a5bbc 100644
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


