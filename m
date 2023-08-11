Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE36E779494
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUV0A-0006MX-TV; Fri, 11 Aug 2023 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV07-0006KG-Bs
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qUV05-0005EJ-Ey
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:28:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-317798b359aso1905274f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691771311; x=1692376111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lApY/NS9JZkO2TeBB7cMCe3ZjrjnlsHvzNxG3ftYJfw=;
 b=lKs7CX3ClgyXu6jLtFx08RnKuLz4JwNfBbnZOZBkuPd7LGqVNoELNq0oYn0PAjDNyu
 xqPR2xHNpsiLhzhUZZECLY5HFRTmEpddGXV30iSiO4PNBXi8j3S02s6+swRbf/HWia2t
 mUSadxBtcc5HregmOYMIMn27BdgwqJuapORbnMF4tSrXY/AolEwYmYpUI8q/5ou1ezk8
 4CK2xY4Gdozi9t3zQwch8lvNiiBMXw2DAfl0b+iHU6IYD/BD3j6rI/Fu47V8+rtqSV7G
 mS8hUgJ0p4+P2fEmEyogTt3HDcXyGOgl0pS67a/1bUULq0xjldsEASByN2Ey+CAc/Rto
 bODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691771311; x=1692376111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lApY/NS9JZkO2TeBB7cMCe3ZjrjnlsHvzNxG3ftYJfw=;
 b=c7E7xpwJ3qBe1w82jum4MVlXP8MHSLEFYNQaXBIKLL2FPiF73gyuqIcOYkVV4yO1Tt
 LV5Uq3c23hbGq8nZ7itLjmc/BcZYSSoD62Og8nWYuSRNa8ktknisibEoXmVEbchPXkk4
 UzpIOeXJm4YygMLa6GskKy/xBCgvbXCxEfJHgsVIJvXk0qr4KUr5D/UrVQyn4NdoCyEB
 KpOIHfbYqoBJPIDo7wc8QYrQNLjOofPtHXDmdy4S1SgDRkTuwVJAKHqsq+T/CNOCruvh
 6oapoy6pcondfeOBZOAgamnyzKqFChW5utAC+nSTnJZEXM/DdTO8vbKsIODgqU1W3xbu
 2iTw==
X-Gm-Message-State: AOJu0Yz8RKU9WqoXre5l6paQ00oI0wyDy92amdlL4jKO98m2DLfRWasC
 dUMAan/kiSQL/VYhdRrUjBstLQ==
X-Google-Smtp-Source: AGHT+IFANeEiKyvDyoCNijN1+ciKQN+xWK3J6dMfyaOy3hxTu01VnUrW/GGEUlSdzOh+jH8GzdwnDA==
X-Received: by 2002:a5d:4448:0:b0:317:f537:748d with SMTP id
 x8-20020a5d4448000000b00317f537748dmr1534970wrr.64.1691771311580; 
 Fri, 11 Aug 2023 09:28:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a056000005200b00317d2be2e59sm5844590wrx.73.2023.08.11.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:28:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E7E61FFBD;
 Fri, 11 Aug 2023 17:28:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 2/2] linux-user: implement name lookup for dfilter
Date: Fri, 11 Aug 2023 17:28:30 +0100
Message-Id: <20230811162830.2278032-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811162830.2278032-1-alex.bennee@linaro.org>
References: <20230811162830.2278032-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This implements a simple extension to dfilter so we can use pathnames
as a proxy for address ranges such that:

  ./qemu-x86_64 -d page,in_asm,op,op_opt,out_asm \
    --dfilter libnative \
    --native-bypass common-user/native/x86_64-linux-user/libnative.so \
    /usr/bin/tar xvf audacity-sources-3.3.3.tar.gz

will only output debug information for the thing I'm interested in.

There are a couple of things that need fixing before we could merge
but it works well enough for debug:

  - we don't do the PROT_EXEC check because the linker mprotects the
    region after the fact and that requires more plumbing
  - there is no locking in the hot path of qemu_log_in_addr_range(),
    in theory we only expand debug_regions but GArray could move the
    pointer

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/log.h   | 12 ++++++++++++
 linux-user/syscall.c | 31 ++++++++++++++++++++++++++++++-
 util/log.c           | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index df59bfabcd..3dba364b05 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -86,6 +86,18 @@ bool qemu_set_log(int log_flags, Error **errp);
 bool qemu_set_log_filename(const char *filename, Error **errp);
 bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
+
+/**
+ * qemu_maybe_append_dfilter_range() - maybe add mapped binary range to dfilter
+ * @path - the full path to the mapped binary
+ * @start - start guest address
+ * @end - end guest address
+ *
+ * This allows *-user to add ranges to the dfilter list after the fact
+ * as binary sections are mapped in.
+ */
+void qemu_maybe_append_dfilter_range(const char *path, uint64_t start, uint64_t end);
+
 bool qemu_log_in_addr_range(uint64_t addr);
 int qemu_str_to_log_mask(const char *str);
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e191163c49..b724ec8df6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6019,6 +6019,18 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
 #define TARGET_MAP_HUGE_1GB 0
 #endif
 
+static char *get_fd_path_mapping(int fd);
+
+static void track_exec_segments(int fd, abi_ulong addr, abi_ulong len, off_t offset)
+{
+    g_autofree char *path = get_fd_path_mapping(fd);
+    if (path) {
+        uint64_t start = addr + offset;
+        uint64_t end = start + len;
+        qemu_maybe_append_dfilter_range(path, start, end);
+    }
+}
+
 static abi_long do_mmap(abi_ulong addr, abi_ulong len, int prot,
                         int target_flags, int fd, off_t offset)
 {
@@ -6045,6 +6057,7 @@ static abi_long do_mmap(abi_ulong addr, abi_ulong len, int prot,
                                | TARGET_MAP_HUGE_1GB
     };
     int host_flags;
+    abi_long map_addr;
 
     switch (target_flags & TARGET_MAP_TYPE) {
     case TARGET_MAP_PRIVATE:
@@ -6071,7 +6084,14 @@ static abi_long do_mmap(abi_ulong addr, abi_ulong len, int prot,
     }
     host_flags |= target_to_host_bitmask(target_flags, mmap_flags_tbl);
 
-    return get_errno(target_mmap(addr, len, prot, host_flags, fd, offset));
+
+    map_addr = target_mmap(addr, len, prot, host_flags, fd, offset);
+    /* Have we successfully mapped an executable segment? */
+    if (map_addr > 0 /* && prot & PROT_EXEC */) {
+        track_exec_segments(fd, map_addr, len, offset);
+    }
+
+    return get_errno(map_addr);
 }
 
 /*
@@ -8571,6 +8591,15 @@ static void fd_tracking_init(void)
     qemu_mutex_init(&fd_tracking_lock);
 }
 
+/* caller owns result */
+static char * get_fd_path_mapping(int fd) {
+    gpointer value;
+    WITH_QEMU_LOCK_GUARD(&fd_tracking_lock) {
+        value = g_hash_table_lookup(fd_path, GINT_TO_POINTER(fd));
+    }
+    return g_strdup(value);
+}
+
 static int do_plain_guest_openat(int dirfd, const char *pathname,
                                  int flags, mode_t mode, bool safe)
 {
diff --git a/util/log.c b/util/log.c
index def88a9402..b4bd20fd72 100644
--- a/util/log.c
+++ b/util/log.c
@@ -48,6 +48,15 @@ int qemu_loglevel;
 static bool log_per_thread;
 static GArray *debug_regions;
 
+static QemuMutex debug_names_lock;
+static GPtrArray *debug_names; /* unresolved named ranges */
+
+__attribute__((constructor))
+static void debug_names_init(void)
+{
+    qemu_mutex_init(&debug_names_lock);
+}
+
 /* Returns true if qemu_log() will really write somewhere. */
 bool qemu_log_enabled(void)
 {
@@ -393,6 +402,8 @@ void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
 
     debug_regions = g_array_sized_new(FALSE, FALSE,
                                       sizeof(Range), g_strv_length(ranges));
+    debug_names = g_ptr_array_new();
+
     for (i = 0; ranges[i]; i++) {
         const char *r = ranges[i];
         const char *range_op, *r2, *e;
@@ -410,7 +421,8 @@ void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
             r2 = range_op ? range_op + 2 : NULL;
         }
         if (!range_op) {
-            error_setg(errp, "Bad range specifier");
+            /* this might be a libname, defer until we map stuff */
+            g_ptr_array_add(debug_names, g_strdup(r));
             goto out;
         }
 
@@ -453,6 +465,28 @@ out:
     g_strfreev(ranges);
 }
 
+void qemu_maybe_append_dfilter_range(const char *path, uint64_t start, uint64_t end)
+{
+    if (!debug_names) {
+        return;
+    }
+
+    WITH_QEMU_LOCK_GUARD(&debug_names_lock) {
+        int i;
+        for (i = 0; i < debug_names->len; i++) {
+            char *name = g_ptr_array_index(debug_names, i);
+
+            if (strstr(path, name) != NULL) {
+                struct Range range;
+                range_set_bounds(&range, start, end);
+                g_array_append_val(debug_regions, range);
+                g_free(g_ptr_array_remove_index(debug_names, i));
+                break;
+            }
+        }
+    }
+}
+
 const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_OUT_ASM, "out_asm",
       "show generated host assembly code for each compiled TB" },
-- 
2.39.2


