Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A4842771
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 16:01:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpb2-0000qT-Rf; Tue, 30 Jan 2024 10:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpar-0000pO-6a
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUpao-0008TH-Bf
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:00:08 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e80046246so22490075e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 07:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626804; x=1707231604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7Tw5saUZzmnNQBl5imy1iUGuwf5cjAMj6TuehOa0+w=;
 b=sSbpIcQFveZ+N5fD7I1/el98tAZbt+j4WMezM04jm5WKybB8uMBtwZaMK8i6Zq3imf
 nKsLH6VFPsBGgbpuxjTyVdNY7u/5s/+/4uzftjD0Sg5Y6feCbS8MgHRqBACmb1Rglq2+
 dS9ew7i4jBilsH/54kSqmDl+IltSf9C9Vu+Y6BE58YufcrwG6nM1vxQk05DCiwo+xRWp
 cO7dOhDyY8rIngW2eHOR9yhweM0oNqPpftE03FLunex5c246UkCSbBQYmw9o70dTO542
 XEWLQ9Z7j9nR8Ruwoa8nzCNcoyn5I0JUq/PtuvfdbH29LXJB/L0U2/3LXVe+Qozo8MTN
 bDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626804; x=1707231604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7Tw5saUZzmnNQBl5imy1iUGuwf5cjAMj6TuehOa0+w=;
 b=CBzkkX15RDJ2HkDoBfLZTMuu/b507eyiIVYGP8DfesmkTzxfJctK0ABZg7ycBawzdm
 9qVdjEtlbbkLNaASxTioEr1SpGF0qFI5rpc1fxmln4q/E9NGyR5m64UV9rs7dboKs59V
 vr52k3JZ2fx/hmiovoYg5m7fdkDof7/hlcV5Jo3JZIirPRsa6yE9Wc8+75vft7BI27l7
 eITKH78JUXeyd6W+GrP7krKdVQSbDhJ5TFn7grbhXnw27pvjlFXk8xWNJqOOEU1Zt9+P
 R9Q2rM8HempSUnOAFQccuKlCLAw77Gnl86dlOWDIY4U6fSyLZGqy2xvGfp+lumE8zcLX
 U6iA==
X-Gm-Message-State: AOJu0Yx25ooYoKWh6FY2HYxH1mI7pXBfDP9FipXXxhZoz5CHZjLinMEy
 ZSRZfZjNYM0ISLMWD/7eMv4MNYY0Y41VneVL6a3TgPpi5be+sdkRxfAcJSNwrqrmNBSWzehWcDg
 fEW8=
X-Google-Smtp-Source: AGHT+IFxTWEmXoWL04YQGawW/0qlLCW4Bl2ZzdCXScfxlqiSnFroX/yow9RlJRQC31wWxfqoIEzGvw==
X-Received: by 2002:a05:600c:5250:b0:40e:bf71:f6db with SMTP id
 fc16-20020a05600c525000b0040ebf71f6dbmr1722396wmb.17.1706626804053; 
 Tue, 30 Jan 2024 07:00:04 -0800 (PST)
Received: from localhost.localdomain (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 fa7-20020a05600c518700b0040ec6d7420csm17078648wmb.14.2024.01.30.07.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 07:00:03 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 2/3] virtio-gpu.c: add resource_destroy class method
Date: Tue, 30 Jan 2024 16:59:20 +0200
Message-Id: <b0a86630c4d601f3a269fd7e08cfefc13bd4e219.1706626470.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
References: <cover.1706626470.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
need to do their own bookkeeping (free rutabaga resources that are
associated with the virtio_gpu_simple_resource).

This commit adds a class method so that virtio-gpu-rutabaga can override
it in the next commit.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/virtio/virtio-gpu.h |  3 +++
 hw/display/virtio-gpu.c        | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 584ba2ed73..b28e7ef0d2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -219,6 +219,9 @@ struct VirtIOGPUClass {
     void (*update_cursor_data)(VirtIOGPU *g,
                                struct virtio_gpu_scanout *s,
                                uint32_t resource_id);
+    void (*resource_destroy)(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res,
+                             Error **errp);
 };
 
 struct VirtIOGPUGL {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2b73ae585b..1c1ee230b3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -402,7 +402,8 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 }
 
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
-                                        struct virtio_gpu_simple_resource *res)
+                                        struct virtio_gpu_simple_resource *res,
+                                        Error **errp)
 {
     int i;
 
@@ -438,7 +439,11 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
     }
-    virtio_gpu_resource_destroy(g, res);
+    /*
+     * virtio_gpu_resource_destroy does not set any errors, so pass a NULL errp
+     * to ignore them.
+     */
+    virtio_gpu_resource_destroy(g, res, NULL);
 }
 
 static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
@@ -1488,11 +1493,24 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
     struct virtio_gpu_simple_resource *res, *tmp;
+    uint32_t resource_id;
+    Error *local_err = NULL;
     int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+        resource_id = res->resource_id;
+        vgc->resource_destroy(g, res, &local_err);
+        if (local_err) {
+            error_append_hint(&local_err, "%s: %s resource_destroy"
+                              "for resource_id = %"PRIu32" failed.\n",
+                              __func__, object_get_typename(OBJECT(g)),
+                              resource_id);
+            /* error_report_err frees the error object for us */
+            error_report_err(local_err);
+            local_err = NULL;
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
@@ -1632,6 +1650,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_handle_ctrl;
     vgc->process_cmd = virtio_gpu_simple_process_cmd;
     vgc->update_cursor_data = virtio_gpu_update_cursor_data;
+    vgc->resource_destroy = virtio_gpu_resource_destroy;
     vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;
 
     vdc->realize = virtio_gpu_device_realize;
-- 
γαῖα πυρί μιχθήτω


