Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DAA92E91B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 15:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtf4-0001Dq-Ub; Thu, 11 Jul 2024 09:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sRteZ-00010g-HI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sRteU-00042o-AQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720703760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTQXzJR4/IpD9WG7C1QwGdhUCT8j4omODFeZne4VazM=;
 b=LV8BZZNdHjTlgiwP88EXQxjJa9yGFmKb7DMfMvUtfQSudKcHT2MbWhGbbCy7TFUBArRkOk
 qppHYHJ1rcOOv1R8LaVts+K5rJOxbGSnyxZHKdVKJaqcOH8EhOaOs5hTx8grhpsigaO7w0
 8GF5r+YDEY2A+UmaHMfsfZ76ePspRQM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-TT9xXm5WOUu5u1rZ_t-h9A-1; Thu,
 11 Jul 2024 09:14:46 -0400
X-MC-Unique: TT9xXm5WOUu5u1rZ_t-h9A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 971451955BE7; Thu, 11 Jul 2024 13:14:45 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.85])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0166119560AA; Thu, 11 Jul 2024 13:14:38 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 1/2] vhost-user: add a write-read lock
Date: Thu, 11 Jul 2024 18:44:23 +0530
Message-ID: <20240711131424.181615-2-ppandit@redhat.com>
In-Reply-To: <20240711131424.181615-1-ppandit@redhat.com>
References: <20240711131424.181615-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

QEMU threads use vhost_user_write/read calls to send
and receive messages from a vhost-user device. When multiple
threads communicate with the same vhost-user device, they can
receive each other's messages, resulting in an erroneous state.

 vhost_user_read_header:
  700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.
 vhost_device_iotlb_miss:
  700871,700871: Fail to update device iotlb
 vhost_user_postcopy_end:
  700871,700900: Failed to receive reply to postcopy_end
 vhost_user_read_header:
  700871,700871: Failed to read msg header. Flags 0x0 instead of 0x5.

Here fault thread seems to end the postcopy migration while
another thread is starting the vhost-user device.

Add a rw lock to hold for one vhost_user_write/read cycle
and avoid such race conditions.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 hw/virtio/vhost-user.c         | 423 +++++++++++++++++++--------------
 include/hw/virtio/vhost-user.h |   3 +
 2 files changed, 254 insertions(+), 172 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..99881c487f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -24,6 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/uuid.h"
 #include "qemu/sockets.h"
+#include "qemu/lockable.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cryptodev.h"
 #include "migration/postcopy-ram.h"
@@ -433,6 +434,8 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd)
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     int fds[VHOST_USER_MAX_RAM_SLOTS];
     size_t fd_num = 0;
     bool shmfd = virtio_has_feature(dev->protocol_features,
@@ -455,23 +458,25 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
         fds[fd_num++] = log->fd;
     }
 
-    ret = vhost_user_write(dev, &msg, fds, fd_num);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (shmfd) {
-        msg.hdr.size = 0;
-        ret = vhost_user_read(dev, &msg);
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, fds, fd_num);
         if (ret < 0) {
             return ret;
         }
 
-        if (msg.hdr.request != VHOST_USER_SET_LOG_BASE) {
-            error_report("Received unexpected msg type. "
-                         "Expected %d received %d",
-                         VHOST_USER_SET_LOG_BASE, msg.hdr.request);
-            return -EPROTO;
+        if (shmfd) {
+            msg.hdr.size = 0;
+            ret = vhost_user_read(dev, &msg);
+            if (ret < 0) {
+                return ret;
+            }
+
+            if (msg.hdr.request != VHOST_USER_SET_LOG_BASE) {
+                error_report("Received unexpected msg type. "
+                             "Expected %d received %d",
+                             VHOST_USER_SET_LOG_BASE, msg.hdr.request);
+                return -EPROTO;
+            }
         }
     }
 
@@ -664,6 +669,7 @@ static int send_remove_regions(struct vhost_dev *dev,
                                bool reply_supported)
 {
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     struct vhost_memory_region *shadow_reg;
     int i, fd, shadow_reg_idx, ret;
     ram_addr_t offset;
@@ -685,16 +691,18 @@ static int send_remove_regions(struct vhost_dev *dev,
             vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
             msg->payload.mem_reg.region = region_buffer;
 
-            ret = vhost_user_write(dev, msg, NULL, 0);
-            if (ret < 0) {
-                return ret;
-            }
-
-            if (reply_supported) {
-                ret = process_message_reply(dev, msg);
-                if (ret) {
+            WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+                ret = vhost_user_write(dev, msg, NULL, 0);
+                if (ret < 0) {
                     return ret;
                 }
+
+                if (reply_supported) {
+                    ret = process_message_reply(dev, msg);
+                    if (ret) {
+                        return ret;
+                    }
+                }
             }
         }
 
@@ -725,6 +733,9 @@ static int send_add_regions(struct vhost_dev *dev,
     VhostUserMsg msg_reply;
     VhostUserMemoryRegion region_buffer;
 
+    struct VhostUserState *us = u->user;
+    QEMU_LOCK_GUARD(&us->vhost_user_rw_lock);
+
     for (i = 0; i < nr_add_reg; i++) {
         reg = add_reg[i].region;
         reg_idx = add_reg[i].reg_idx;
@@ -893,6 +904,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
                                              bool config_mem_slots)
 {
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     VhostUserMsg msg_reply;
@@ -926,14 +938,16 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
             return ret;
         }
 
-        ret = vhost_user_write(dev, &msg, fds, fd_num);
-        if (ret < 0) {
-            return ret;
-        }
+        WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+            ret = vhost_user_write(dev, &msg, fds, fd_num);
+            if (ret < 0) {
+                return ret;
+            }
 
-        ret = vhost_user_read(dev, &msg_reply);
-        if (ret < 0) {
-            return ret;
+            ret = vhost_user_read(dev, &msg_reply);
+            if (ret < 0) {
+                return ret;
+            }
         }
 
         if (msg_reply.hdr.request != VHOST_USER_SET_MEM_TABLE) {
@@ -1005,6 +1019,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
@@ -1044,13 +1059,15 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
             return ret;
         }
 
-        ret = vhost_user_write(dev, &msg, fds, fd_num);
-        if (ret < 0) {
-            return ret;
-        }
+        WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+            ret = vhost_user_write(dev, &msg, fds, fd_num);
+            if (ret < 0) {
+                return ret;
+            }
 
-        if (reply_supported) {
-            return process_message_reply(dev, &msg);
+            if (reply_supported) {
+                return process_message_reply(dev, &msg);
+            }
         }
     }
 
@@ -1080,6 +1097,8 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
 static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
 {
     int ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     VhostUserMsg msg = {
         .hdr.request = request,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1089,14 +1108,16 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
         return 0;
     }
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (msg.hdr.request != request) {
@@ -1129,6 +1150,8 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
                                  bool wait_for_reply)
 {
     int ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
 
     if (wait_for_reply) {
         bool reply_supported = virtio_has_feature(dev->protocol_features,
@@ -1138,25 +1161,27 @@ static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
         }
     }
 
-    ret = vhost_user_write(dev, msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    if (wait_for_reply) {
-        uint64_t dummy;
+        if (wait_for_reply) {
+            uint64_t dummy;
 
-        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-            return process_message_reply(dev, msg);
-        }
+            if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+                return process_message_reply(dev, msg);
+            }
 
-       /*
-        * We need to wait for a reply but the backend does not
-        * support replies for the command we just sent.
-        * Send VHOST_USER_GET_FEATURES which makes all backends
-        * send a reply.
-        */
-        return vhost_user_get_features(dev, &dummy);
+           /*
+            * We need to wait for a reply but the backend does not
+            * support replies for the command we just sent.
+            * Send VHOST_USER_GET_FEATURES which makes all backends
+            * send a reply.
+            */
+            return vhost_user_get_features(dev, &dummy);
+        }
     }
 
     return 0;
@@ -1277,20 +1302,23 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         .hdr.size = sizeof(msg.payload.state),
     };
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
 
     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
     if (n) {
         vhost_user_host_notifier_remove(n, dev->vdev);
     }
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_GET_VRING_BASE) {
@@ -1661,6 +1689,7 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
                                  int *dmabuf_fd)
 {
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     CharBackend *chr = u->user->chr;
     int ret;
     VhostUserMsg msg = {
@@ -1669,14 +1698,16 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
     };
     memcpy(msg.payload.object.uuid, uuid, sizeof(msg.payload.object.uuid));
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_GET_SHARED_OBJECT) {
@@ -1858,6 +1889,7 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
         .hdr.flags = VHOST_USER_VERSION,
     };
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     int sv[2], ret = 0;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
@@ -1889,15 +1921,16 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    ret = vhost_user_write(dev, &msg, &sv[1], 1);
-    if (ret) {
-        goto out;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, &sv[1], 1);
+        if (ret) {
+            goto out;
+        }
 
-    if (reply_supported) {
-        ret = process_message_reply(dev, &msg);
+        if (reply_supported) {
+            ret = process_message_reply(dev, &msg);
+        }
     }
-
 out:
     close(sv[1]);
     if (ret) {
@@ -1985,6 +2018,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
 {
 #ifdef CONFIG_LINUX
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     CharBackend *chr = u->user->chr;
     int ufd;
     int ret;
@@ -1993,16 +2027,18 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         .hdr.flags = VHOST_USER_VERSION,
     };
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_setg(errp, "Failed to send postcopy_advise to vhost");
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_setg(errp, "Failed to send postcopy_advise to vhost");
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        error_setg(errp, "Failed to get postcopy_advise reply from vhost");
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            error_setg(errp, "Failed to get postcopy_advise reply from vhost");
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_POSTCOPY_ADVISE) {
@@ -2051,16 +2087,19 @@ static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
 
     trace_vhost_user_postcopy_listen();
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_setg(errp, "Failed to send postcopy_listen to vhost");
-        return ret;
-    }
+    struct VhostUserState *us = u->user;
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_setg(errp, "Failed to send postcopy_listen to vhost");
+            return ret;
+        }
 
-    ret = process_message_reply(dev, &msg);
-    if (ret) {
-        error_setg(errp, "Failed to receive reply to postcopy_listen");
-        return ret;
+        ret = process_message_reply(dev, &msg);
+        if (ret) {
+            error_setg(errp, "Failed to receive reply to postcopy_listen");
+            return ret;
+        }
     }
 
     return 0;
@@ -2077,19 +2116,22 @@ static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
     };
     int ret;
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
 
     trace_vhost_user_postcopy_end_entry();
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_setg(errp, "Failed to send postcopy_end to vhost");
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_setg(errp, "Failed to send postcopy_end to vhost");
+            return ret;
+        }
 
-    ret = process_message_reply(dev, &msg);
-    if (ret) {
-        error_setg(errp, "Failed to receive reply to postcopy_end");
-        return ret;
+        ret = process_message_reply(dev, &msg);
+        if (ret) {
+            error_setg(errp, "Failed to receive reply to postcopy_end");
+            return ret;
+        }
     }
     postcopy_unregister_shared_ufd(&u->postcopy_fd);
     close(u->postcopy_fd.fd);
@@ -2359,6 +2401,8 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
     int ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
 
     if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MTU))) {
         return 0;
@@ -2372,14 +2416,16 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    /* If reply_ack supported, backend has to ack specified MTU is valid */
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
+        /* If reply_ack supported, backend has to ack specified MTU is valid */
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
     }
 
     return 0;
@@ -2396,12 +2442,19 @@ static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
         .payload.iotlb = *imsg,
     };
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
+
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
+
+        ret = process_message_reply(dev, &msg);
     }
 
-    return process_message_reply(dev, &msg);
+    return ret;
 }
 
 
@@ -2414,6 +2467,8 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
                                  uint32_t config_len, Error **errp)
 {
     int ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_GET_CONFIG,
         .hdr.flags = VHOST_USER_VERSION,
@@ -2430,16 +2485,19 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
 
     msg.payload.config.offset = 0;
     msg.payload.config.size = config_len;
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "vhost_get_config failed");
-        return ret;
-    }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "vhost_get_config failed");
-        return ret;
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "vhost_get_config failed");
+            return ret;
+        }
+
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "vhost_get_config failed");
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_GET_CONFIG) {
@@ -2464,6 +2522,8 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
 {
     int ret;
     uint8_t *p;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
@@ -2492,13 +2552,15 @@ static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *data,
     p = msg.payload.config.region;
     memcpy(p, data, size);
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
     }
 
     return 0;
@@ -2509,6 +2571,8 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
                                             uint64_t *session_id)
 {
     int ret;
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     bool crypto_session = virtio_has_feature(dev->protocol_features,
                                        VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
     CryptoDevBackendSessionInfo *backend_info = session_info;
@@ -2572,18 +2636,21 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
 
     msg.payload.session.op_code = backend_info->op_code;
     msg.payload.session.session_id = backend_info->session_id;
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_report("vhost_user_write() return %d, create session failed",
-                     ret);
-        return ret;
-    }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        error_report("vhost_user_read() return %d, create session failed",
-                     ret);
-        return ret;
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_report("vhost_user_write() return %d, create session failed",
+                         ret);
+            return ret;
+        }
+
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            error_report("vhost_user_read() return %d, create session failed",
+                         ret);
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_CREATE_CRYPTO_SESSION) {
@@ -2648,6 +2715,7 @@ static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
     int fd;
     int ret;
     struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     CharBackend *chr = u->user->chr;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_GET_INFLIGHT_FD,
@@ -2662,14 +2730,16 @@ static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
         return 0;
     }
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_GET_INFLIGHT_FD) {
@@ -2757,6 +2827,7 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
     user->memory_slots = 0;
     user->notifiers = g_ptr_array_new_full(VIRTIO_QUEUE_MAX / 4,
                                            &vhost_user_state_destroy);
+    qemu_mutex_init(&user->vhost_user_rw_lock);
     return true;
 }
 
@@ -2769,6 +2840,7 @@ void vhost_user_cleanup(VhostUserState *user)
     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
     memory_region_transaction_commit();
     user->chr = NULL;
+    qemu_mutex_destroy(&user->vhost_user_rw_lock);
 }
 
 
@@ -2882,6 +2954,7 @@ static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
 {
     int ret;
     struct vhost_user *vu = dev->opaque;
+    struct VhostUserState *us = vu->user;
     VhostUserMsg msg = {
         .hdr = {
             .request = VHOST_USER_SET_DEVICE_STATE_FD,
@@ -2902,19 +2975,21 @@ static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
         return -ENOTSUP;
     }
 
-    ret = vhost_user_write(dev, &msg, &fd, 1);
-    close(fd);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "Failed to send SET_DEVICE_STATE_FD message");
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, &fd, 1);
+        close(fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to send SET_DEVICE_STATE_FD message");
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "Failed to receive SET_DEVICE_STATE_FD reply");
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to receive SET_DEVICE_STATE_FD reply");
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_SET_DEVICE_STATE_FD) {
@@ -2951,6 +3026,8 @@ static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
 
 static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
 {
+    struct vhost_user *u = dev->opaque;
+    struct VhostUserState *us = u->user;
     int ret;
     VhostUserMsg msg = {
         .hdr = {
@@ -2965,18 +3042,20 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
         return -ENOTSUP;
     }
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "Failed to send CHECK_DEVICE_STATE message");
-        return ret;
-    }
+    WITH_QEMU_LOCK_GUARD(&us->vhost_user_rw_lock) {
+        ret = vhost_user_write(dev, &msg, NULL, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to send CHECK_DEVICE_STATE message");
+            return ret;
+        }
 
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret,
-                         "Failed to receive CHECK_DEVICE_STATE reply");
-        return ret;
+        ret = vhost_user_read(dev, &msg);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to receive CHECK_DEVICE_STATE reply");
+            return ret;
+        }
     }
 
     if (msg.hdr.request != VHOST_USER_CHECK_DEVICE_STATE) {
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 324cd8663a..387ab6da2e 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -67,6 +67,9 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
+
+    /* Hold lock for vhost_user_write/read cycle */
+    QemuMutex vhost_user_rw_lock;
 } VhostUserState;
 
 /**
-- 
2.45.2


