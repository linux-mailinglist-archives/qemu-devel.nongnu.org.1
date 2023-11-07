Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F17E387B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2p-0002EH-P0; Tue, 07 Nov 2023 05:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J21-0001I1-EL
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1y-0002Bm-9N
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8Dcqs9F1nelYCSSeKsdhkwCix1cnMWXMvvonVw8o4A=;
 b=C5300MQgCVzbqsbWqIF7G5Ca3bzSThsdLcEpIRPh3Kp7PjY31/NVcZTlzo0TICG8jWw7qt
 Qv+0B11Y9e5wRS1mHR6nJCvWweuZgIyCeU+PXf9LycZRapM6F+pEuYNPwiwt5jVBIoG3IT
 wgF5ahusIcB35uBsYfBem8xgpsoKosc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-n69CgskLN4SJMiZ2ZfCK5w-1; Tue, 07 Nov 2023 05:09:56 -0500
X-MC-Unique: n69CgskLN4SJMiZ2ZfCK5w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso34527525e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351794; x=1699956594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8Dcqs9F1nelYCSSeKsdhkwCix1cnMWXMvvonVw8o4A=;
 b=d2ffoiufAp13vMWeYyoCT/Xekvx8EUhdTeadUJz5zEv4UUmRKJ3HA56dQCM7WRQPTs
 Ab/dGFLyVMyoqylWfZfuAEFgsqdrWUUcFWXQFsBFTDwsnhG0F4Lx3TYzzxtTaezcrePd
 jHp4fzo3a7cdKkqBHxbBkTDEQfCl+AMBjo/4Cr3IcxF7UE+ul4vL1BU2KUYNU7KkLG5z
 qMqT9xq4IUfREuR9YcuKww7WKjIo4emsEt+9L7AYIPzpNjF9iFm3cnPRi/zKFYCf6Aou
 a7azWqPauBB4Agc8Begk8IeP/Y2kPgal9Q3cGYolokQQHdZJ5j6o9/C3QL6fRiqU9QMH
 n6Hw==
X-Gm-Message-State: AOJu0Yx5V+jH6DxAvTi6RvxDFv9oXolchgVsq+kzWa3wY1xkLoPI9tYJ
 6CZ7Fy9gpnCuAnCaZvbLjMIysp6NckIjpXTikrovXOUy1+oV7Sz7R3qU1WedHs9HAeGlCPywrPX
 HWvJJQQPBFDWwzt+yFOErACxDVKiWOmjTF0ZFOE85QYbBcSRHSKIG5VbiXIicwxAMv0//
X-Received: by 2002:a5d:64e7:0:b0:32f:996c:8b12 with SMTP id
 g7-20020a5d64e7000000b0032f996c8b12mr16973791wri.66.1699351794045; 
 Tue, 07 Nov 2023 02:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUtPxb4dXGHhzlTpR11yZg6ntA1IcM5no/jiUsoWyvYwa9L/Xnp5nNR4/8ASlkseReUCQ3jw==
X-Received: by 2002:a5d:64e7:0:b0:32f:996c:8b12 with SMTP id
 g7-20020a5d64e7000000b0032f996c8b12mr16973773wri.66.1699351793671; 
 Tue, 07 Nov 2023 02:09:53 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 dk11-20020a0560000b4b00b003197869bcd7sm1912929wrb.13.2023.11.07.02.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:53 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 06/63] vhost: Add high-level state save/load functions
Message-ID: <4a00d5d7f4b65ba99b33d5a0d6f8c563895839ea.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

vhost_save_backend_state() and vhost_load_backend_state() can be used by
vhost front-ends to easily save and load the back-end's state to/from
the migration stream.

Because we do not know the full state size ahead of time,
vhost_save_backend_state() simply reads the data in 1 MB chunks, and
writes each chunk consecutively into the migration stream, prefixed by
its length.  EOF is indicated by a 0-length chunk.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-7-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost.h |  35 +++++++
 hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b6ee6da6ce..05d7204a08 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -429,4 +429,39 @@ int vhost_set_device_state_fd(struct vhost_dev *dev,
  */
 int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
 
+/**
+ * vhost_save_backend_state(): High-level function to receive a vhost
+ * back-end's state, and save it in @f.  Uses
+ * `vhost_set_device_state_fd()` to get the data from the back-end, and
+ * stores it in consecutive chunks that are each prefixed by their
+ * respective length (be32).  The end is marked by a 0-length chunk.
+ *
+ * Must only be called while the device and all its vrings are stopped
+ * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
+ *
+ * @dev: The vhost device from which to save the state
+ * @f: Migration stream in which to save the state
+ * @errp: Potential error message
+ *
+ * Returns 0 on success, and -errno otherwise.
+ */
+int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+
+/**
+ * vhost_load_backend_state(): High-level function to load a vhost
+ * back-end's state from @f, and send it over to the back-end.  Reads
+ * the data from @f in the format used by `vhost_save_state()`, and uses
+ * `vhost_set_device_state_fd()` to transfer it to the back-end.
+ *
+ * Must only be called while the device and all its vrings are stopped
+ * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
+ *
+ * @dev: The vhost device to which to send the sate
+ * @f: Migration stream from which to load the state
+ * @errp: Potential error message
+ *
+ * Returns 0 on success, and -errno otherwise.
+ */
+int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
+
 #endif
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4db9dbfd64..2c9ac79468 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2196,3 +2196,207 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
                "vhost transport does not support migration state transfer");
     return -ENOSYS;
 }
+
+int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
+{
+    /* Maximum chunk size in which to transfer the state */
+    const size_t chunk_size = 1 * 1024 * 1024;
+    g_autofree void *transfer_buf = NULL;
+    g_autoptr(GError) g_err = NULL;
+    int pipe_fds[2], read_fd = -1, write_fd = -1, reply_fd = -1;
+    int ret;
+
+    /* [0] for reading (our end), [1] for writing (back-end's end) */
+    if (!g_unix_open_pipe(pipe_fds, FD_CLOEXEC, &g_err)) {
+        error_setg(errp, "Failed to set up state transfer pipe: %s",
+                   g_err->message);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    read_fd = pipe_fds[0];
+    write_fd = pipe_fds[1];
+
+    /*
+     * VHOST_TRANSFER_STATE_PHASE_STOPPED means the device must be stopped.
+     * Ideally, it is suspended, but SUSPEND/RESUME currently do not exist for
+     * vhost-user, so just check that it is stopped at all.
+     */
+    assert(!dev->started);
+
+    /* Transfer ownership of write_fd to the back-end */
+    ret = vhost_set_device_state_fd(dev,
+                                    VHOST_TRANSFER_STATE_DIRECTION_SAVE,
+                                    VHOST_TRANSFER_STATE_PHASE_STOPPED,
+                                    write_fd,
+                                    &reply_fd,
+                                    errp);
+    if (ret < 0) {
+        error_prepend(errp, "Failed to initiate state transfer: ");
+        goto fail;
+    }
+
+    /* If the back-end wishes to use a different pipe, switch over */
+    if (reply_fd >= 0) {
+        close(read_fd);
+        read_fd = reply_fd;
+    }
+
+    transfer_buf = g_malloc(chunk_size);
+
+    while (true) {
+        ssize_t read_ret;
+
+        read_ret = RETRY_ON_EINTR(read(read_fd, transfer_buf, chunk_size));
+        if (read_ret < 0) {
+            ret = -errno;
+            error_setg_errno(errp, -ret, "Failed to receive state");
+            goto fail;
+        }
+
+        assert(read_ret <= chunk_size);
+        qemu_put_be32(f, read_ret);
+
+        if (read_ret == 0) {
+            /* EOF */
+            break;
+        }
+
+        qemu_put_buffer(f, transfer_buf, read_ret);
+    }
+
+    /*
+     * Back-end will not really care, but be clean and close our end of the pipe
+     * before inquiring the back-end about whether transfer was successful
+     */
+    close(read_fd);
+    read_fd = -1;
+
+    /* Also, verify that the device is still stopped */
+    assert(!dev->started);
+
+    ret = vhost_check_device_state(dev, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = 0;
+fail:
+    if (read_fd >= 0) {
+        close(read_fd);
+    }
+
+    return ret;
+}
+
+int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
+{
+    size_t transfer_buf_size = 0;
+    g_autofree void *transfer_buf = NULL;
+    g_autoptr(GError) g_err = NULL;
+    int pipe_fds[2], read_fd = -1, write_fd = -1, reply_fd = -1;
+    int ret;
+
+    /* [0] for reading (back-end's end), [1] for writing (our end) */
+    if (!g_unix_open_pipe(pipe_fds, FD_CLOEXEC, &g_err)) {
+        error_setg(errp, "Failed to set up state transfer pipe: %s",
+                   g_err->message);
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    read_fd = pipe_fds[0];
+    write_fd = pipe_fds[1];
+
+    /*
+     * VHOST_TRANSFER_STATE_PHASE_STOPPED means the device must be stopped.
+     * Ideally, it is suspended, but SUSPEND/RESUME currently do not exist for
+     * vhost-user, so just check that it is stopped at all.
+     */
+    assert(!dev->started);
+
+    /* Transfer ownership of read_fd to the back-end */
+    ret = vhost_set_device_state_fd(dev,
+                                    VHOST_TRANSFER_STATE_DIRECTION_LOAD,
+                                    VHOST_TRANSFER_STATE_PHASE_STOPPED,
+                                    read_fd,
+                                    &reply_fd,
+                                    errp);
+    if (ret < 0) {
+        error_prepend(errp, "Failed to initiate state transfer: ");
+        goto fail;
+    }
+
+    /* If the back-end wishes to use a different pipe, switch over */
+    if (reply_fd >= 0) {
+        close(write_fd);
+        write_fd = reply_fd;
+    }
+
+    while (true) {
+        size_t this_chunk_size = qemu_get_be32(f);
+        ssize_t write_ret;
+        const uint8_t *transfer_pointer;
+
+        if (this_chunk_size == 0) {
+            /* End of state */
+            break;
+        }
+
+        if (transfer_buf_size < this_chunk_size) {
+            transfer_buf = g_realloc(transfer_buf, this_chunk_size);
+            transfer_buf_size = this_chunk_size;
+        }
+
+        if (qemu_get_buffer(f, transfer_buf, this_chunk_size) <
+                this_chunk_size)
+        {
+            error_setg(errp, "Failed to read state");
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        transfer_pointer = transfer_buf;
+        while (this_chunk_size > 0) {
+            write_ret = RETRY_ON_EINTR(
+                write(write_fd, transfer_pointer, this_chunk_size)
+            );
+            if (write_ret < 0) {
+                ret = -errno;
+                error_setg_errno(errp, -ret, "Failed to send state");
+                goto fail;
+            } else if (write_ret == 0) {
+                error_setg(errp, "Failed to send state: Connection is closed");
+                ret = -ECONNRESET;
+                goto fail;
+            }
+
+            assert(write_ret <= this_chunk_size);
+            this_chunk_size -= write_ret;
+            transfer_pointer += write_ret;
+        }
+    }
+
+    /*
+     * Close our end, thus ending transfer, before inquiring the back-end about
+     * whether transfer was successful
+     */
+    close(write_fd);
+    write_fd = -1;
+
+    /* Also, verify that the device is still stopped */
+    assert(!dev->started);
+
+    ret = vhost_check_device_state(dev, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = 0;
+fail:
+    if (write_fd >= 0) {
+        close(write_fd);
+    }
+
+    return ret;
+}
-- 
MST


