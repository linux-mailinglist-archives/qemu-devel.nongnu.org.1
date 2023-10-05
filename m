Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE597B9A58
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJW-0000t7-5u; Wed, 04 Oct 2023 23:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJS-0000oZ-Lm
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJQ-0000qL-Lz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/o+pWUz+EoH/jGO7Kt6c0rJ1UNqPWmD2dEHSCZyKa5w=;
 b=Q498j464aj3q7mR36rMMhPj8NLUCy0ZbO35pNTVZzdLlZw/jMAkDD1I8VI8T9VjAksk/BG
 gFOJ1cL11i+OHuh1fBf0wpvzw9drnYt3x8mAeoamWdoFRDdMsjfg6Pga5Ak+u02xcVdlrE
 15NjP99BophFxCgAfJr91J3T6hAtdbA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Q-go0QmUO_2OrkDrHs21QQ-1; Wed, 04 Oct 2023 23:46:05 -0400
X-MC-Unique: Q-go0QmUO_2OrkDrHs21QQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so385675f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477563; x=1697082363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/o+pWUz+EoH/jGO7Kt6c0rJ1UNqPWmD2dEHSCZyKa5w=;
 b=eRjYPiZVr0wVSpQrNqC/cTMUhr/xrD9WwPpfOrWIYleQ7bDVss4jINFWICj2GJEfhb
 oxbFFekpCbVXJhnNkVqxAiMlhXPdq1VEwcxInB1tx4u9MMICTTSXKNM8q6PXRrnsWr5Y
 tO3hGAKsS5Y4OUGmPq2KeOE9pofcsfw4fiDeq0yzZX9ADC4zAlh4LwA9epJ5oW6Vxv6V
 6DSHZBx0l3wXKo1Zo7UIay5jIX6y7VXC6AIY0W33T6auhezu5hsPNFu/YAokOkxVm5Ci
 tNXntUVW9SpG974ZuLLyi/EBhiJPb4T+0cQonaDYwo/dp/ynqy3ai7Z6Gj1K5MfsmATa
 PRyw==
X-Gm-Message-State: AOJu0Yz7uxjWlTS9ND71nEiv2h1tm8lWOkBBorRS6SDt2rzWhkNADovm
 U9R7EyOUnFKQqskMqR5kIE/u8doeD4Ca9L356FuqSdOpKwzzzjyjOLVD7YRQ10B/+Pf/wzHV8GL
 LoDHrc+lSxcrQokPnXodCn4WgMgRRjGeiZ8qlCunbTtXoVnw/x06xWZ+pTrWPoXtm9b4I
X-Received: by 2002:a5d:4106:0:b0:31a:dc58:cdd9 with SMTP id
 l6-20020a5d4106000000b0031adc58cdd9mr3672855wrp.60.1696477563669; 
 Wed, 04 Oct 2023 20:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgtlHs9eZcYG1Gcd8KfywdWy6VZ2+XUvnsAaBbBcXZU+3hVY16iAfyGZnnG6sy0VvDv40jlA==
X-Received: by 2002:a5d:4106:0:b0:31a:dc58:cdd9 with SMTP id
 l6-20020a5d4106000000b0031adc58cdd9mr3672845wrp.60.1696477563329; 
 Wed, 04 Oct 2023 20:46:03 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 d9-20020adff849000000b0031fbbe347e1sm636885wrq.65.2023.10.04.20.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:46:02 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 53/53] libvhost-user: handle shared_object msg
Message-ID: <ce0f3b032a960726c0dddfb4f81f223215179f26.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Albert Esteve <aesteve@redhat.com>

In the libvhost-user library we need to
handle VHOST_USER_GET_SHARED_OBJECT requests,
and add helper functions to allow sending messages
to interact with the virtio shared objects
hash table.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Message-Id: <20231002065706.94707-5-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.h |  55 +++++++++-
 subprojects/libvhost-user/libvhost-user.c | 120 ++++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index 708370c5f5..b36a42a7ca 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -64,7 +64,8 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
-
+    /* Feature 16 is reserved for VHOST_USER_PROTOCOL_F_STATUS. */
+    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -109,6 +110,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_ADD_MEM_REG = 37,
     VHOST_USER_REM_MEM_REG = 38,
+    VHOST_USER_GET_SHARED_OBJECT = 41,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -119,6 +121,9 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG = 3,
     VHOST_USER_BACKEND_VRING_CALL = 4,
     VHOST_USER_BACKEND_VRING_ERR = 5,
+    VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
+    VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
+    VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
@@ -172,6 +177,12 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+#define UUID_LEN 16
+
+typedef struct VhostUserShared {
+    unsigned char uuid[UUID_LEN];
+} VhostUserShared;
+
 #if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
 # define VU_PACKED __attribute__((gcc_struct, packed))
 #else
@@ -199,6 +210,7 @@ typedef struct VhostUserMsg {
         VhostUserConfig config;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserShared object;
     } payload;
 
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
@@ -232,6 +244,7 @@ typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
 typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
                                  uint32_t offset, uint32_t size,
                                  uint32_t flags);
+typedef int (*vu_get_shared_object_cb) (VuDev *dev, const unsigned char *uuid);
 
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
@@ -258,6 +271,8 @@ typedef struct VuDevIface {
     vu_get_config_cb get_config;
     /* set the config space of the device */
     vu_set_config_cb set_config;
+    /* get virtio shared object from the underlying vhost implementation. */
+    vu_get_shared_object_cb get_shared_object;
 } VuDevIface;
 
 typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
@@ -541,6 +556,44 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
 bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
                                 int size, int offset);
 
+/**
+ * vu_lookup_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ * @dmabuf_fd: output dma-buf file descriptor
+ *
+ * Lookup for a virtio shared object (i.e., dma-buf fd) associated with the
+ * received UUID. Result, if found, is stored in the dmabuf_fd argument.
+ *
+ * Returns: whether the virtio object was found.
+ */
+bool vu_lookup_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
+                             int *dmabuf_fd);
+
+/**
+ * vu_add_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ *
+ * Registers this back-end as the exporter for the object associated with
+ * the received UUID.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
+
+/**
+ * vu_rm_shared_object:
+ * @dev: a VuDev context
+ * @uuid: UUID of the shared object
+ *
+ * Removes a shared object entry (i.e., back-end entry) associated with the
+ * received UUID key from the hash table.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN]);
+
 /**
  * vu_queue_set_notification:
  * @dev: a VuDev context
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 49b57c7ef4..051a611da3 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -161,6 +161,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_ADD_MEM_REG),
         REQ(VHOST_USER_REM_MEM_REG),
+        REQ(VHOST_USER_GET_SHARED_OBJECT),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -901,6 +902,24 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     return false;
 }
 
+static bool
+vu_get_shared_object(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd_num = 0;
+    int dmabuf_fd = -1;
+    if (dev->iface->get_shared_object) {
+        dmabuf_fd = dev->iface->get_shared_object(
+            dev, &vmsg->payload.object.uuid[0]);
+    }
+    if (dmabuf_fd != -1) {
+        DPRINT("dmabuf_fd found for requested UUID\n");
+        vmsg->fds[fd_num++] = dmabuf_fd;
+    }
+    vmsg->fd_num = fd_num;
+
+    return true;
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1404,6 +1423,105 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
     return vu_process_message_reply(dev, &vmsg);
 }
 
+bool
+vu_lookup_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN],
+                        int *dmabuf_fd)
+{
+    bool result = false;
+    VhostUserMsg msg_reply;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, &msg)) {
+        goto out;
+    }
+
+    if (!vu_message_read_default(dev, dev->backend_fd, &msg_reply)) {
+        goto out;
+    }
+
+    if (msg_reply.request != msg.request) {
+        DPRINT("Received unexpected msg type. Expected %d, received %d",
+               msg.request, msg_reply.request);
+        goto out;
+    }
+
+    if (msg_reply.fd_num != 1) {
+        DPRINT("Received unexpected number of fds. Expected 1, received %d",
+               msg_reply.fd_num);
+        goto out;
+    }
+
+    *dmabuf_fd = msg_reply.fds[0];
+    result = *dmabuf_fd > 0 && msg_reply.payload.u64 == 0;
+out:
+    pthread_mutex_unlock(&dev->backend_mutex);
+
+    return result;
+}
+
+static bool
+vu_send_message(VuDev *dev, VhostUserMsg *vmsg)
+{
+    bool result = false;
+    pthread_mutex_lock(&dev->backend_mutex);
+    if (!vu_message_write(dev, dev->backend_fd, vmsg)) {
+        goto out;
+    }
+
+    result = true;
+out:
+    pthread_mutex_unlock(&dev->backend_mutex);
+
+    return result;
+}
+
+bool
+vu_add_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_ADD,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    return vu_send_message(dev, &msg);
+}
+
+bool
+vu_rm_shared_object(VuDev *dev, unsigned char uuid[UUID_LEN])
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE,
+        .size = sizeof(msg.payload.object),
+        .flags = VHOST_USER_VERSION,
+    };
+
+    memcpy(msg.payload.object.uuid, uuid, sizeof(uuid[0]) * UUID_LEN);
+
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SHARED_OBJECT)) {
+        return false;
+    }
+
+    return vu_send_message(dev, &msg);
+}
+
 static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1944,6 +2062,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_add_mem_reg(dev, vmsg);
     case VHOST_USER_REM_MEM_REG:
         return vu_rem_mem_reg(dev, vmsg);
+    case VHOST_USER_GET_SHARED_OBJECT:
+        return vu_get_shared_object(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
-- 
MST


