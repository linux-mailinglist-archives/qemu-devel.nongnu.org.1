Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B271568F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tec-0001CU-91; Tue, 30 May 2023 03:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3teE-0001At-Cz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3te6-0004rf-Pz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685431193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ2nc6r7b3NmHZi94eqye0nGmDPE0Z7Z+GA/fs4fmiM=;
 b=XPFZNnPTOierPJXgk3s1PpVcMLukEFBduwXnWTbnvkHpe/xw/9ayTxMUoH0qL1w3V3Byyc
 56sC+LKNRvDeIAMxVNLe7pawveEixLm6gbHwpHEyG9yefn0li4AResl61zBoYC124Lczqy
 y1QgTFDM0sp/I5y+LrS7DVhkilKE7ec=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-rd6hoUgvPo-dOXmbWBRpxw-1; Tue, 30 May 2023 03:19:52 -0400
X-MC-Unique: rd6hoUgvPo-dOXmbWBRpxw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-626070979faso25038446d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 00:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685431191; x=1688023191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ2nc6r7b3NmHZi94eqye0nGmDPE0Z7Z+GA/fs4fmiM=;
 b=Lqu2SMYiXyrWOKxKvhnm79IAyoKq0slY9j9e330RmsS/hlznKJt1U5/d9Wi/5UyS31
 rs5IDz6hZZ1CzZZhOKKweY+e3nm6k9yeyfHW4KwKkj+IQbMupj+50JFohwVwnVyoMCG4
 a2XmKmmt4DG4ARK8W2eYKwcErqitDNs1AsHHIqVma0Jk8V3CFSS4hYslzdOI0ff1zENN
 5KHBpcvX+NZlHpCTowJuokisojf4HwntmsPFvbcNShNl+6GnV55ZvsYft/jI2Yv7Ce1q
 WI+aa/+Z0S6AYQUI4R4GUVyKUeojN52LdQrKGTAHw6qFLw5nSXtft4/yHmbmv5XXnp7t
 yiTQ==
X-Gm-Message-State: AC+VfDxCgI25EQDX93RKagIjrulwky4b7XNaAYtVDEO8r9HgRu4kb0MS
 DORFIneTL3I9mSM0X/U5td9sYA0EnXf5w02xhTmLSgCXL6vroaCA1cblLSCK9rAbS7qNJ10FwII
 e8wEhchimgzdPxcKGQfqzLs7nVEFatnuzVceSHGlKlS+9435TXDuMXw7JLKX+0GgZPzTqZHatzy
 Y=
X-Received: by 2002:a05:6214:2629:b0:626:1741:f3f3 with SMTP id
 gv9-20020a056214262900b006261741f3f3mr9723806qvb.28.1685431191685; 
 Tue, 30 May 2023 00:19:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53mUrhw0AUElIQdd8XtPJbRCWf1nTQmLwB6EgrqyIA9uA1FUVpep7Vf/DDyTvs+W7XgFJUWQ==
X-Received: by 2002:a05:6214:2629:b0:626:1741:f3f3 with SMTP id
 gv9-20020a056214262900b006261741f3f3mr9723786qvb.28.1685431191350; 
 Tue, 30 May 2023 00:19:51 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 v1-20020a05622a144100b003e302c1f498sm4477508qtx.37.2023.05.30.00.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 00:19:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 1/2] block/blkio: use qemu_open() to support fd passing for
 virtio-blk
Date: Tue, 30 May 2023 09:19:40 +0200
Message-Id: <20230530071941.8954-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530071941.8954-1-sgarzare@redhat.com>
References: <20230530071941.8954-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Some virtio-blk drivers (e.g. virtio-blk-vhost-vdpa) supports the fd
passing. Let's expose this to the user, so the management layer
can pass the file descriptor of an already opened path.

If the libblkio virtio-blk driver supports fd passing, let's always
use qemu_open() to open the `path`, so we can handle fd passing
from the management layer through the "/dev/fdset/N" special path.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - modified commit description
    
    v3:
    - use qemu_open() on `path` to simplify libvirt code [Jonathon]

 block/blkio.c | 53 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 0cdc99a729..6a6f20f923 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -672,25 +672,60 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
 {
     const char *path = qdict_get_try_str(options, "path");
     BDRVBlkioState *s = bs->opaque;
-    int ret;
+    bool fd_supported = false;
+    int fd, ret;
 
     if (!path) {
         error_setg(errp, "missing 'path' option");
         return -EINVAL;
     }
 
-    ret = blkio_set_str(s->blkio, "path", path);
-    qdict_del(options, "path");
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "failed to set path: %s",
-                         blkio_get_error_msg());
-        return ret;
-    }
-
     if (!(flags & BDRV_O_NOCACHE)) {
         error_setg(errp, "cache.direct=off is not supported");
         return -EINVAL;
     }
+
+    if (blkio_get_int(s->blkio, "fd", &fd) == 0) {
+        fd_supported = true;
+    }
+
+    /*
+     * If the libblkio driver supports fd passing, let's always use qemu_open()
+     * to open the `path`, so we can handle fd passing from the management
+     * layer through the "/dev/fdset/N" special path.
+     */
+    if (fd_supported) {
+        int open_flags;
+
+        if (flags & BDRV_O_RDWR) {
+            open_flags = O_RDWR;
+        } else {
+            open_flags = O_RDONLY;
+        }
+
+        fd = qemu_open(path, open_flags, errp);
+        if (fd < 0) {
+            return -EINVAL;
+        }
+
+        ret = blkio_set_int(s->blkio, "fd", fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set fd: %s",
+                             blkio_get_error_msg());
+            qemu_close(fd);
+            return ret;
+        }
+    } else {
+        ret = blkio_set_str(s->blkio, "path", path);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set path: %s",
+                             blkio_get_error_msg());
+            return ret;
+        }
+    }
+
+    qdict_del(options, "path");
+
     return 0;
 }
 
-- 
2.40.1


