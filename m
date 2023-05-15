Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C8703246
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyahZ-0004x7-Se; Mon, 15 May 2023 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahO-0004uk-NZ
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahJ-0001ss-S8
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684166717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHIz0h3FWaTgMpl3H8preMnJ4gVhxX+URbxC7lRgBb0=;
 b=FJJ8Z6RioD888UbKjIYIOIJB9nFjscETy01ypNjYbnaCWuOCtXFYWFa/seMbu6fH7eyuos
 TX8MLGt9ZgrqrAnx3Hja7iTlk1LtUQOuvQpF2wFLXMDIXBfw0qJ+gcBrStz9iuHOkwKJwW
 lo1hyN7PhQL3CnGuVWqwCULcmSrR9W8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-N9aGrHkHNK-6h93yzg_XdQ-1; Mon, 15 May 2023 12:05:13 -0400
X-MC-Unique: N9aGrHkHNK-6h93yzg_XdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ECA687DC02;
 Mon, 15 May 2023 16:05:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06C5214152F6;
 Mon, 15 May 2023 16:05:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>, Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PULL v2 02/16] block/file-posix: introduce helper functions for
 sysfs attributes
Date: Mon, 15 May 2023 12:04:52 -0400
Message-Id: <20230515160506.1776883-3-stefanha@redhat.com>
In-Reply-To: <20230515160506.1776883-1-stefanha@redhat.com>
References: <20230515160506.1776883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

From: Sam Li <faithilikerun@gmail.com>

Use get_sysfs_str_val() to get the string value of device
zoned model. Then get_sysfs_zoned_model() can convert it to
BlockZoneModel type of QEMU.

Use get_sysfs_long_val() to get the long value of zoned device
information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20230508045533.175575-3-faithilikerun@gmail.com
Message-id: 20230324090605.28361-3-faithilikerun@gmail.com
[Adjust commit message prefix as suggested by Philippe Mathieu-Daudé
<philmd@linaro.org>.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h |   3 +
 block/file-posix.c               | 135 ++++++++++++++++++++++---------
 2 files changed, 100 insertions(+), 38 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 4909876756..c7ca5a83e9 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -862,6 +862,9 @@ typedef struct BlockLimits {
      * an explicit monitor command to load the disk inside the guest).
      */
     bool has_variable_length;
+
+    /* device zone model */
+    BlockZoneModel zoned;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
diff --git a/block/file-posix.c b/block/file-posix.c
index c7b723368e..97c597a2a0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1202,15 +1202,89 @@ static int hdev_get_max_hw_transfer(int fd, struct stat *st)
 #endif
 }
 
-static int hdev_get_max_segments(int fd, struct stat *st)
+/*
+ * Get a sysfs attribute value as character string.
+ */
+#ifdef CONFIG_LINUX
+static int get_sysfs_str_val(struct stat *st, const char *attribute,
+                             char **val) {
+    g_autofree char *sysfspath = NULL;
+    int ret;
+    size_t len;
+
+    if (!S_ISBLK(st->st_mode)) {
+        return -ENOTSUP;
+    }
+
+    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/%s",
+                                major(st->st_rdev), minor(st->st_rdev),
+                                attribute);
+    ret = g_file_get_contents(sysfspath, val, &len, NULL);
+    if (ret == -1) {
+        return -ENOENT;
+    }
+
+    /* The file is ended with '\n' */
+    char *p;
+    p = *val;
+    if (*(p + len - 1) == '\n') {
+        *(p + len - 1) = '\0';
+    }
+    return ret;
+}
+#endif
+
+static int get_sysfs_zoned_model(struct stat *st, BlockZoneModel *zoned)
 {
+    g_autofree char *val = NULL;
+    int ret;
+
+    ret = get_sysfs_str_val(st, "zoned", &val);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (strcmp(val, "host-managed") == 0) {
+        *zoned = BLK_Z_HM;
+    } else if (strcmp(val, "host-aware") == 0) {
+        *zoned = BLK_Z_HA;
+    } else if (strcmp(val, "none") == 0) {
+        *zoned = BLK_Z_NONE;
+    } else {
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
+/*
+ * Get a sysfs attribute value as a long integer.
+ */
 #ifdef CONFIG_LINUX
-    char buf[32];
+static long get_sysfs_long_val(struct stat *st, const char *attribute)
+{
+    g_autofree char *str = NULL;
     const char *end;
-    char *sysfspath = NULL;
+    long val;
+    int ret;
+
+    ret = get_sysfs_str_val(st, attribute, &str);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* The file is ended with '\n', pass 'end' to accept that. */
+    ret = qemu_strtol(str, &end, 10, &val);
+    if (ret == 0 && end && *end == '\0') {
+        ret = val;
+    }
+    return ret;
+}
+#endif
+
+static int hdev_get_max_segments(int fd, struct stat *st)
+{
+#ifdef CONFIG_LINUX
     int ret;
-    int sysfd = -1;
-    long max_segments;
 
     if (S_ISCHR(st->st_mode)) {
         if (ioctl(fd, SG_GET_SG_TABLESIZE, &ret) == 0) {
@@ -1218,44 +1292,27 @@ static int hdev_get_max_segments(int fd, struct stat *st)
         }
         return -ENOTSUP;
     }
-
-    if (!S_ISBLK(st->st_mode)) {
-        return -ENOTSUP;
-    }
-
-    sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
-                                major(st->st_rdev), minor(st->st_rdev));
-    sysfd = open(sysfspath, O_RDONLY);
-    if (sysfd == -1) {
-        ret = -errno;
-        goto out;
-    }
-    ret = RETRY_ON_EINTR(read(sysfd, buf, sizeof(buf) - 1));
-    if (ret < 0) {
-        ret = -errno;
-        goto out;
-    } else if (ret == 0) {
-        ret = -EIO;
-        goto out;
-    }
-    buf[ret] = 0;
-    /* The file is ended with '\n', pass 'end' to accept that. */
-    ret = qemu_strtol(buf, &end, 10, &max_segments);
-    if (ret == 0 && end && *end == '\n') {
-        ret = max_segments;
-    }
-
-out:
-    if (sysfd != -1) {
-        close(sysfd);
-    }
-    g_free(sysfspath);
-    return ret;
+    return get_sysfs_long_val(st, "max_segments");
 #else
     return -ENOTSUP;
 #endif
 }
 
+static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
+                                     Error **errp)
+{
+    BlockZoneModel zoned;
+    int ret;
+
+    bs->bl.zoned = BLK_Z_NONE;
+
+    ret = get_sysfs_zoned_model(st, &zoned);
+    if (ret < 0 || zoned == BLK_Z_NONE) {
+        return;
+    }
+    bs->bl.zoned = zoned;
+}
+
 static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
@@ -1297,6 +1354,8 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
             bs->bl.max_hw_iov = ret;
         }
     }
+
+    raw_refresh_zoned_limits(bs, &st, errp);
 }
 
 static int check_for_dasd(int fd)
-- 
2.40.1


