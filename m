Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB971290E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YyO-0004J0-Fg; Fri, 26 May 2023 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyL-0004IU-AV
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q2YyJ-000699-2E
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685113394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D97XDHvGX08ZAoNvHcSNiEbEzSt6MLx+rWCVCdit0M0=;
 b=ZHuQS5HVpRnHLwQ9HmHDxPb59WuFBPzBeSQ8mvmJ/MoDiU5hstKNUP9xxF8JmzSlAYphWp
 182VG2GTnNJCNXE6AS2AeCGRhozLR0agatrUo9IBQlrP0cVG9oZcwhB6RtaPfRHFVzSz/C
 /07dGtOJH15O8URd+t/eXKmsCmc9oMw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-SMSk8_i2N6eS2ur_FttuPw-1; Fri, 26 May 2023 11:03:12 -0400
X-MC-Unique: SMSk8_i2N6eS2ur_FttuPw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso79198466b.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685113391; x=1687705391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D97XDHvGX08ZAoNvHcSNiEbEzSt6MLx+rWCVCdit0M0=;
 b=XQuiVQ5ao5BYUBDhxJiPv74xyRADBA7mzWkWZ8Z74GRUMD/0b7IJCaa8cYrxD4nGKD
 RV7mEI1ZxftJJj+XldTH5XbXPdRbwM44b01HZIRiRtt5ik5Yc7JFdL/KL5wwgEolg3QP
 wbImh/+YMeoIJB/juuZ2YErhaUsDX7lk2FneEupKudk57k1QC3Kc/XF+bpZRG4QgHHjd
 KaPR0PZoQ19/Txe3hSIh/2NIMLqZ1X6QpHOnbXNunzomYO7b5zc7evUWBJ2bHSCVxFbC
 1COCbojRIGZgxHWpVG8kNNQnRn5M8+I4levnJpIA1bssi0DeIzSaAByfiwZYtc+16Utl
 yKGw==
X-Gm-Message-State: AC+VfDyN2tzp2SOTYfud2Y6dGnSMJe/oZyZ5VlAQMlguu4J+kSTPw3oA
 3nrlE39YYVFm+Q9cS7hwQkCCoPIZFe9pK9fyo+BCOjFTRYevBMYku/StFCGiL6e4gh4koYm8xx3
 az53mXGlNxa4wOJ8iz7k3uPAujLCYLA6bG2Xw0BkubtUByRjtmwKriAbkVZ0uqDFEPrMwv+8kRR
 Y=
X-Received: by 2002:a17:907:3f14:b0:94e:cf72:8147 with SMTP id
 hq20-20020a1709073f1400b0094ecf728147mr2531628ejc.48.1685113391436; 
 Fri, 26 May 2023 08:03:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43SqjUfJxLG6gomGS72TNir6CUA4HfCsRukea2x/7kyM16/EGAoeNYVbmHgAFkfFGRb3p81w==
X-Received: by 2002:a17:907:3f14:b0:94e:cf72:8147 with SMTP id
 hq20-20020a1709073f1400b0094ecf728147mr2531601ejc.48.1685113391185; 
 Fri, 26 May 2023 08:03:11 -0700 (PDT)
Received: from step1.. (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 bl17-20020a170906c25100b0094e4eabb402sm2239995ejb.128.2023.05.26.08.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 08:03:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 1/2] block/blkio: use qemu_open() to support fd passing for
 virtio-blk
Date: Fri, 26 May 2023 17:03:03 +0200
Message-Id: <20230526150304.158206-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526150304.158206-1-sgarzare@redhat.com>
References: <20230526150304.158206-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Some virtio-blk drivers (e.g. virtio-blk-vhost-vdpa) supports the fd
passing. Let's expose this to the user, so the management layer
can pass the file descriptor of an already opened path.

If the libblkio virtio-blk driver supports fd passing, let's always
use qemu_open() to open the `path`, so we can handle fd passing
from the management layer through the "/dev/fdset/N" special path.

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


