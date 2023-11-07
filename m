Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BAF7E3883
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J33-0002ye-GB; Tue, 07 Nov 2023 05:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1z-0001G1-7C
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1v-0002BH-Co
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++r82DcRgaafZbYYvM+lZq8D84ztJ0xCMQ4u0fVv87w=;
 b=dRtjhWCi4ho91SJEviWV9JA94f2y4KMTmZOMUhFUzQIOspo930QghaSeh0AZbY//fp8yfK
 iDENlbV0a6aI+nNU1R2tohZVaOuapjE/0b66uaZ3NId2cMtKyyzvfeZBfnGM2bRVsMJ5VY
 UzA0WPMDXjnh8LEx/SfsLzQ88/ebX28=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-9nKpcX0pPpy1ebyZmF7Zxg-1; Tue, 07 Nov 2023 05:09:53 -0500
X-MC-Unique: 9nKpcX0pPpy1ebyZmF7Zxg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c6f33ee403so50751221fa.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351791; x=1699956591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++r82DcRgaafZbYYvM+lZq8D84ztJ0xCMQ4u0fVv87w=;
 b=D8zoJMjKKB9mPtThLBg30KqgC6jNbVHDk65UB+Ae1Xvz9c8wxFi4ooAYmtV/bix1gs
 104QaqyFWc4sjJm/D0n0RhQNTErzFmKzh9CiDff0Hm2PSQ3+w9v9RHvo+g4TsrYrwe/i
 NGtGlL/L3YnOvkedlp/DVHqRh4Oo16KE1zWKgnzWUEmV4TbC4twkiNQnKD8O7Eg9nS0+
 INGZuAxHMTtG8ClC6m2tvD+8bfrf+ypqldHegg0B1Xh0Oz0Axvn2COkC45gnRwJ+M33N
 c/ygZJHZCCmvH8z0lngzzl/ZyaXdpwT6oobIFIQ27NwlJeEOp5AWyAd5xAAL3PHMc/WS
 GTwQ==
X-Gm-Message-State: AOJu0Yw3WtOzOixkrWMICDg7Xx3jedYdt+zPbdXtyt5XzIhHXhgCkkng
 sOY6qPn4V3JHVx5+F8td6c54IXfjGgqK2f7v1qoMcleAEAVRUfw1c2nbWN57WD1I4qPhs2dWgCl
 TvLRLjWPYF96+xTIWkpUq/Y7yIochGB5mt/YPB67sK+SvF2TGcVpMQHFbglewpO+ofp12
X-Received: by 2002:a2e:b254:0:b0:2c5:fde:e457 with SMTP id
 n20-20020a2eb254000000b002c50fdee457mr24236805ljm.3.1699351790870; 
 Tue, 07 Nov 2023 02:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTzX2KDdyhlAsr0b0DCuvNhpKqYE8CM4Z8klWgqilBx3c791YpTuA+jVoIOuAyUVqti5vXKA==
X-Received: by 2002:a2e:b254:0:b0:2c5:fde:e457 with SMTP id
 n20-20020a2eb254000000b002c50fdee457mr24236784ljm.3.1699351790363; 
 Tue, 07 Nov 2023 02:09:50 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d456f000000b0032fab28e9c9sm1901173wrc.73.2023.11.07.02.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:49 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 05/63] vhost-user: Interface for migration state transfer
Message-ID: <cda83adc62b6108afc8a82d0f54d9a9a861e7aa8.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

Add the interface for transferring the back-end's state during migration
as defined previously in vhost-user.rst.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-6-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h |  24 +++++
 include/hw/virtio/vhost-user.h    |   1 +
 include/hw/virtio/vhost.h         |  78 ++++++++++++++++
 hw/virtio/vhost-user.c            | 146 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  37 ++++++++
 5 files changed, 286 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 96ccc18cd3..a86d103f82 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -26,6 +26,18 @@ typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
 } VhostSetConfigType;
 
+typedef enum VhostDeviceStateDirection {
+    /* Transfer state from back-end (device) to front-end */
+    VHOST_TRANSFER_STATE_DIRECTION_SAVE = 0,
+    /* Transfer state from front-end to back-end (device) */
+    VHOST_TRANSFER_STATE_DIRECTION_LOAD = 1,
+} VhostDeviceStateDirection;
+
+typedef enum VhostDeviceStatePhase {
+    /* The device (and all its vrings) is stopped */
+    VHOST_TRANSFER_STATE_PHASE_STOPPED = 0,
+} VhostDeviceStatePhase;
+
 struct vhost_inflight;
 struct vhost_dev;
 struct vhost_log;
@@ -129,6 +141,15 @@ typedef int (*vhost_set_config_call_op)(struct vhost_dev *dev,
 
 typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
 
+typedef bool (*vhost_supports_device_state_op)(struct vhost_dev *dev);
+typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
+                                            VhostDeviceStateDirection direction,
+                                            VhostDeviceStatePhase phase,
+                                            int fd,
+                                            int *reply_fd,
+                                            Error **errp);
+typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -176,6 +197,9 @@ typedef struct VhostOps {
     vhost_force_iommu_op vhost_force_iommu;
     vhost_set_config_call_op vhost_set_config_call;
     vhost_reset_status_op vhost_reset_status;
+    vhost_supports_device_state_op vhost_supports_device_state;
+    vhost_set_device_state_fd_op vhost_set_device_state_fd;
+    vhost_check_device_state_op vhost_check_device_state;
 } VhostOps;
 
 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 20b69d8e85..d7c09ffd34 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -31,6 +31,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_STATUS = 16,
     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
+    VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 5e8183f64a..b6ee6da6ce 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -351,4 +351,82 @@ static inline int vhost_reset_device(struct vhost_dev *hdev)
 }
 #endif /* CONFIG_VHOST */
 
+/**
+ * vhost_supports_device_state(): Checks whether the back-end supports
+ * transferring internal device state for the purpose of migration.
+ * Support for this feature is required for vhost_set_device_state_fd()
+ * and vhost_check_device_state().
+ *
+ * @dev: The vhost device
+ *
+ * Returns true if the device supports these commands, and false if it
+ * does not.
+ */
+bool vhost_supports_device_state(struct vhost_dev *dev);
+
+/**
+ * vhost_set_device_state_fd(): Begin transfer of internal state from/to
+ * the back-end for the purpose of migration.  Data is to be transferred
+ * over a pipe according to @direction and @phase.  The sending end must
+ * only write to the pipe, and the receiving end must only read from it.
+ * Once the sending end is done, it closes its FD.  The receiving end
+ * must take this as the end-of-transfer signal and close its FD, too.
+ *
+ * @fd is the back-end's end of the pipe: The write FD for SAVE, and the
+ * read FD for LOAD.  This function transfers ownership of @fd to the
+ * back-end, i.e. closes it in the front-end.
+ *
+ * The back-end may optionally reply with an FD of its own, if this
+ * improves efficiency on its end.  In this case, the returned FD is
+ * stored in *reply_fd.  The back-end will discard the FD sent to it,
+ * and the front-end must use *reply_fd for transferring state to/from
+ * the back-end.
+ *
+ * @dev: The vhost device
+ * @direction: The direction in which the state is to be transferred.
+ *             For outgoing migrations, this is SAVE, and data is read
+ *             from the back-end and stored by the front-end in the
+ *             migration stream.
+ *             For incoming migrations, this is LOAD, and data is read
+ *             by the front-end from the migration stream and sent to
+ *             the back-end to restore the saved state.
+ * @phase: Which migration phase we are in.  Currently, there is only
+ *         STOPPED (device and all vrings are stopped), in the future,
+ *         more phases such as PRE_COPY or POST_COPY may be added.
+ * @fd: Back-end's end of the pipe through which to transfer state; note
+ *      that ownership is transferred to the back-end, so this function
+ *      closes @fd in the front-end.
+ * @reply_fd: If the back-end wishes to use a different pipe for state
+ *            transfer, this will contain an FD for the front-end to
+ *            use.  Otherwise, -1 is stored here.
+ * @errp: Potential error description
+ *
+ * Returns 0 on success, and -errno on failure.
+ */
+int vhost_set_device_state_fd(struct vhost_dev *dev,
+                              VhostDeviceStateDirection direction,
+                              VhostDeviceStatePhase phase,
+                              int fd,
+                              int *reply_fd,
+                              Error **errp);
+
+/**
+ * vhost_set_device_state_fd(): After transferring state from/to the
+ * back-end via vhost_set_device_state_fd(), i.e. once the sending end
+ * has closed the pipe, inquire the back-end to report any potential
+ * errors that have occurred on its side.  This allows to sense errors
+ * like:
+ * - During outgoing migration, when the source side had already started
+ *   to produce its state, something went wrong and it failed to finish
+ * - During incoming migration, when the received state is somehow
+ *   invalid and cannot be processed by the back-end
+ *
+ * @dev: The vhost device
+ * @errp: Potential error description
+ *
+ * Returns 0 when the back-end reports successful state transfer and
+ * processing, and -errno when an error occurred somewhere.
+ */
+int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
+
 #endif
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7b42ae8aae..f214df804b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -103,6 +103,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
     VHOST_USER_GET_SHARED_OBJECT = 41,
+    VHOST_USER_SET_DEVICE_STATE_FD = 42,
+    VHOST_USER_CHECK_DEVICE_STATE = 43,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -201,6 +203,12 @@ typedef struct {
     uint32_t size; /* the following payload size */
 } QEMU_PACKED VhostUserHeader;
 
+/* Request payload of VHOST_USER_SET_DEVICE_STATE_FD */
+typedef struct VhostUserTransferDeviceState {
+    uint32_t direction;
+    uint32_t phase;
+} VhostUserTransferDeviceState;
+
 typedef union {
 #define VHOST_USER_VRING_IDX_MASK   (0xff)
 #define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
@@ -216,6 +224,7 @@ typedef union {
         VhostUserVringArea area;
         VhostUserInflight inflight;
         VhostUserShared object;
+        VhostUserTransferDeviceState transfer_state;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
@@ -2855,6 +2864,140 @@ static void vhost_user_reset_status(struct vhost_dev *dev)
     }
 }
 
+static bool vhost_user_supports_device_state(struct vhost_dev *dev)
+{
+    return virtio_has_feature(dev->protocol_features,
+                              VHOST_USER_PROTOCOL_F_DEVICE_STATE);
+}
+
+static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
+                                          VhostDeviceStateDirection direction,
+                                          VhostDeviceStatePhase phase,
+                                          int fd,
+                                          int *reply_fd,
+                                          Error **errp)
+{
+    int ret;
+    struct vhost_user *vu = dev->opaque;
+    VhostUserMsg msg = {
+        .hdr = {
+            .request = VHOST_USER_SET_DEVICE_STATE_FD,
+            .flags = VHOST_USER_VERSION,
+            .size = sizeof(msg.payload.transfer_state),
+        },
+        .payload.transfer_state = {
+            .direction = direction,
+            .phase = phase,
+        },
+    };
+
+    *reply_fd = -1;
+
+    if (!vhost_user_supports_device_state(dev)) {
+        close(fd);
+        error_setg(errp, "Back-end does not support migration state transfer");
+        return -ENOTSUP;
+    }
+
+    ret = vhost_user_write(dev, &msg, &fd, 1);
+    close(fd);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to send SET_DEVICE_STATE_FD message");
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to receive SET_DEVICE_STATE_FD reply");
+        return ret;
+    }
+
+    if (msg.hdr.request != VHOST_USER_SET_DEVICE_STATE_FD) {
+        error_setg(errp,
+                   "Received unexpected message type, expected %d, received %d",
+                   VHOST_USER_SET_DEVICE_STATE_FD, msg.hdr.request);
+        return -EPROTO;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.u64)) {
+        error_setg(errp,
+                   "Received bad message size, expected %zu, received %" PRIu32,
+                   sizeof(msg.payload.u64), msg.hdr.size);
+        return -EPROTO;
+    }
+
+    if ((msg.payload.u64 & 0xff) != 0) {
+        error_setg(errp, "Back-end did not accept migration state transfer");
+        return -EIO;
+    }
+
+    if (!(msg.payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
+        *reply_fd = qemu_chr_fe_get_msgfd(vu->user->chr);
+        if (*reply_fd < 0) {
+            error_setg(errp,
+                       "Failed to get back-end-provided transfer pipe FD");
+            *reply_fd = -1;
+            return -EIO;
+        }
+    }
+
+    return 0;
+}
+
+static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
+{
+    int ret;
+    VhostUserMsg msg = {
+        .hdr = {
+            .request = VHOST_USER_CHECK_DEVICE_STATE,
+            .flags = VHOST_USER_VERSION,
+            .size = 0,
+        },
+    };
+
+    if (!vhost_user_supports_device_state(dev)) {
+        error_setg(errp, "Back-end does not support migration state transfer");
+        return -ENOTSUP;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to send CHECK_DEVICE_STATE message");
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Failed to receive CHECK_DEVICE_STATE reply");
+        return ret;
+    }
+
+    if (msg.hdr.request != VHOST_USER_CHECK_DEVICE_STATE) {
+        error_setg(errp,
+                   "Received unexpected message type, expected %d, received %d",
+                   VHOST_USER_CHECK_DEVICE_STATE, msg.hdr.request);
+        return -EPROTO;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.u64)) {
+        error_setg(errp,
+                   "Received bad message size, expected %zu, received %" PRIu32,
+                   sizeof(msg.payload.u64), msg.hdr.size);
+        return -EPROTO;
+    }
+
+    if (msg.payload.u64 != 0) {
+        error_setg(errp, "Back-end failed to process its internal state");
+        return -EIO;
+    }
+
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -2890,4 +3033,7 @@ const VhostOps user_ops = {
         .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
         .vhost_dev_start = vhost_user_dev_start,
         .vhost_reset_status = vhost_user_reset_status,
+        .vhost_supports_device_state = vhost_user_supports_device_state,
+        .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
+        .vhost_check_device_state = vhost_user_check_device_state,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9c9ae7109e..4db9dbfd64 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2159,3 +2159,40 @@ int vhost_reset_device(struct vhost_dev *hdev)
 
     return -ENOSYS;
 }
+
+bool vhost_supports_device_state(struct vhost_dev *dev)
+{
+    if (dev->vhost_ops->vhost_supports_device_state) {
+        return dev->vhost_ops->vhost_supports_device_state(dev);
+    }
+
+    return false;
+}
+
+int vhost_set_device_state_fd(struct vhost_dev *dev,
+                              VhostDeviceStateDirection direction,
+                              VhostDeviceStatePhase phase,
+                              int fd,
+                              int *reply_fd,
+                              Error **errp)
+{
+    if (dev->vhost_ops->vhost_set_device_state_fd) {
+        return dev->vhost_ops->vhost_set_device_state_fd(dev, direction, phase,
+                                                         fd, reply_fd, errp);
+    }
+
+    error_setg(errp,
+               "vhost transport does not support migration state transfer");
+    return -ENOSYS;
+}
+
+int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
+{
+    if (dev->vhost_ops->vhost_check_device_state) {
+        return dev->vhost_ops->vhost_check_device_state(dev, errp);
+    }
+
+    error_setg(errp,
+               "vhost transport does not support migration state transfer");
+    return -ENOSYS;
+}
-- 
MST


