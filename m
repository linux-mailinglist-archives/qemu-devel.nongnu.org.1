Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8DC7A1C3A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 12:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh61l-000722-AK; Fri, 15 Sep 2023 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61D-0006cd-TX
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh61B-0002nc-E5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 06:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694773542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzce+XPdZ3BiWGqajalU9GNFiQuTbGCKrobaq4PB8Dc=;
 b=IiZ4GbKC1pkzK49rKBnMH/IZbXqbdFLVtgKRq1SuxxVffut5qDPK5A9eHsTyw+0aFYBGRA
 C3CzogDTlw5wFA9q4/7nGupDm4s1Eqdgj0/lkiXC95y+KB6p1c+hxcORGTFcZWIXX0dFMt
 PRUTQj2wv+uyW5hiEkOxU9bzBtlz/90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-jEIO9i1BNGqfoZOBDlTFkg-1; Fri, 15 Sep 2023 06:25:41 -0400
X-MC-Unique: jEIO9i1BNGqfoZOBDlTFkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A95E85A5A8
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:25:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D5F409AFC1;
 Fri, 15 Sep 2023 10:25:40 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH v3 4/5] vhost: Add high-level state save/load functions
Date: Fri, 15 Sep 2023 12:25:29 +0200
Message-ID: <20230915102531.55894-5-hreitz@redhat.com>
In-Reply-To: <20230915102531.55894-1-hreitz@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

vhost_save_backend_state() and vhost_load_backend_state() can be used by
vhost front-ends to easily save and load the back-end's state to/from
the migration stream.

Because we do not know the full state size ahead of time,
vhost_save_backend_state() simply reads the data in 1 MB chunks, and
writes each chunk consecutively into the migration stream, prefixed by
its length.  EOF is indicated by a 0-length chunk.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/hw/virtio/vhost.h |  35 +++++++
 hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f4e19aae8b..28066ceda1 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -417,4 +417,39 @@ int vhost_set_device_state_fd(struct vhost_dev *dev,
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
index 6d34abec96..164bd930d3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2124,3 +2124,207 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
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
2.41.0


