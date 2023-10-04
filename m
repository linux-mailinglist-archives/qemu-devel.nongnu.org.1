Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAB47B86D4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5ku-0004pj-Ob; Wed, 04 Oct 2023 13:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5ke-0004NJ-VW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5kb-0001Cy-QR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:33:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32483535e51so128581f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440812; x=1697045612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgqEreWct7MZtVTd4L58i3yyOMJt49ibdnNqLW0cY8Q=;
 b=Txvwlx9jeGOgKHmiXK+GB0yEn+uSjmx0BuJHdvT33FsNUWXSY5ky+YGobL8JoSw4oD
 vIc9MGrXiTyBjBv85kOC68nb3+0jZcDXFSKlQ305SpDjnc9w8gEYc+I+wiX9yh3+0edf
 626Jq36WmumxIzcyfpLj05xEP43s0XEQ3oP5ZddBkE88dpwwS1V17t6Wa7P0gwluWb6P
 h4yQifK6hv/NghHNTSisK2Ggrsp6VWI7DNlDLZ51FMM/OmLDORsiK6LFrkJ6rwi4FuWn
 Yzhd980djhz4kxUghV9S4pLzlVMtn6O0EGrfAnfJRkW+u2JbQROp3ycLDi3yWEeFeK6P
 euig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440812; x=1697045612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgqEreWct7MZtVTd4L58i3yyOMJt49ibdnNqLW0cY8Q=;
 b=A/9b7HujtV4UmddhhvK3qrRh6X8FKvQQe7iWKbffajUV/tR/WGNWBwHo05K41JvVdo
 n4+uZ/8XJEhWOsGbZINmKVOBKwT9cPbj4gG9Xo7vCzTBjZoycQkxEISqXMIrn5cKD4ac
 qCTtpUqvHcLnXwAyirCrCagcKkm5A1kQ9BbQ1DrGv48j8ISgzCI4nlz6bdn+hULINT1Z
 guZWASqCBW6GVV2BP3j3hqBebfT3OCJ/n75BBql2xA02u8DCD+jktNLACWbCqwgsvk6E
 O8jRbIZQ5WzSfdGiwMKLfquTCgeg0Z3DEPL31+rB97+8S3F1HB8XOtrwZf6M8BKwXHeC
 qQYA==
X-Gm-Message-State: AOJu0YwPuBAiUjqWTyoiQfJpQApZimhrP5QFEdPXbTV+bzXOdbd+Q/4R
 tQ2s7eHp6gYzLojTH3fzVKxHKdC/vtTF6gYaZRs=
X-Google-Smtp-Source: AGHT+IH9LIR9lKU2LqSUqfZiKsxIsA94sXQKP0iEePNgfhrz9C+cfdVw8eoMwlMjbnmd9ap0AQkMyw==
X-Received: by 2002:a5d:4d43:0:b0:31c:6420:fff with SMTP id
 a3-20020a5d4d43000000b0031c64200fffmr2622991wru.62.1696440811915; 
 Wed, 04 Oct 2023 10:33:31 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 p9-20020adfcc89000000b00326028b4dd5sm4471194wrj.113.2023.10.04.10.33.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:33:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/21] qapi: Inline and remove QERR_IO_ERROR definition
Date: Wed,  4 Oct 2023 19:31:48 +0200
Message-ID: <20231004173158.42591-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using:

  $ sed -i -e 's/QERR_IO_ERROR/"An IO error has occurred"/' \
    $(git grep -wl QERR_IO_ERROR)

then manually removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 block/vmdk.c              | 8 ++++----
 blockdev.c                | 2 +-
 dump/win_dump.c           | 4 ++--
 migration/savevm.c        | 4 ++--
 softmmu/cpus.c            | 4 ++--
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index ac727d1c2d..d95c4b84b9 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_IO_ERROR \
-    "An IO error has occurred"
-
 #define QERR_MIGRATION_ACTIVE \
     "There's a migration process in progress"
 
diff --git a/block/vmdk.c b/block/vmdk.c
index e90649c8bf..6779a181f0 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2246,12 +2246,12 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     /* write all the data */
     ret = blk_co_pwrite(blk, 0, sizeof(magic), &magic, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
         goto exit;
     }
     ret = blk_co_pwrite(blk, sizeof(magic), sizeof(header), &header, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
         goto exit;
     }
 
@@ -2271,7 +2271,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
         goto exit;
     }
 
@@ -2283,7 +2283,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     ret = blk_co_pwrite(blk, le64_to_cpu(header.gd_offset) * BDRV_SECTOR_SIZE,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
     }
 
     ret = 0;
diff --git a/blockdev.c b/blockdev.c
index ed90365329..228cebf9a2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1433,7 +1433,7 @@ static void external_snapshot_action(TransactionAction *action,
 
     if (!bdrv_is_read_only(state->old_bs)) {
         if (bdrv_flush(state->old_bs)) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "An IO error has occurred");
             goto out;
         }
     }
diff --git a/dump/win_dump.c b/dump/win_dump.c
index b7bfaff379..0115a609e0 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -67,7 +67,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
         l = qemu_write_full(fd, buf, len);
         cpu_physical_memory_unmap(buf, addr, false, len);
         if (l != len) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "An IO error has occurred");
             return 0;
         }
 
@@ -459,7 +459,7 @@ void create_win_dump(DumpState *s, Error **errp)
 
     s->written_size = qemu_write_full(s->fd, h, hdr_size);
     if (s->written_size != hdr_size) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
         goto out_restore;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..41c7f39ef5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3099,7 +3099,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     object_unref(OBJECT(ioc));
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
     } else {
         /* libxl calls the QMP command "stop" before calling
          * "xen-save-devices-state" and in case of migration failure, libxl
@@ -3148,7 +3148,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     ret = qemu_loadvm_state(f);
     qemu_fclose(f);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg(errp, "An IO error has occurred");
     }
     migration_incoming_state_destroy();
 }
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 7fc70f9166..f7c743b0ce 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -773,7 +773,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
             goto exit;
         }
         if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "An IO error has occurred");
             goto exit;
         }
         addr += l;
@@ -803,7 +803,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
             l = size;
         cpu_physical_memory_read(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
-            error_setg(errp, QERR_IO_ERROR);
+            error_setg(errp, "An IO error has occurred");
             goto exit;
         }
         addr += l;
-- 
2.41.0


