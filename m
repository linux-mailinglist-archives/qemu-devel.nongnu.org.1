Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A772E1D5
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90VO-0005oB-QR; Tue, 13 Jun 2023 05:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90VF-0005lY-Ah
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90V6-0005hT-7w
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5183101690cso5400457a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649182; x=1689241182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn6UViqugu1iPM5CBgyVG1U7YWBaY3WOqVleP4qvVWg=;
 b=R0zb4M9RAEzXPO7CQcnjo+h9pA3mCXQsgY4HVYTWp9uenStcAbDsJL0rhChV09HK6c
 mSe9xV5k6iQ3ldd/Ra103M5Gloi4fMWnW8TWEa0I2n81LJINDg8EdIpxK46bEY1EJikK
 BbYw848lKam6Sbw9Byw9JRmlfcpR6Da2rnLAiZpbq8ndAxKpL/nxBjrVHeGzlJcI/ai8
 TqfL8YQhoBDCNGeteVj8asmCATFxJW1ERdRbCgv+IB1YNRO5A4XOJjPvfiLZtu0Afx2I
 AM13GAhWf1SfRQdc5PRSHwRaY/3uw52EXBzKMwEOVchBQTzGkgJGQ3jLayOfHJPFdiba
 jCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649182; x=1689241182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tn6UViqugu1iPM5CBgyVG1U7YWBaY3WOqVleP4qvVWg=;
 b=bfdCkoiL+CL5kVEmvVUTDZwYoI101W3qsJidSYZwlcyn9YBji7e1cGqkomAWG2DiRT
 17OUUuFm9aPWrq/GJy82sNdtXh0HJOjPRqbKq4Soa8KVV+YSM42o9beiU+/1FzIIkymW
 LT4Rdm8qtNP+S19QOrRjix+/0xIzHUjBP74RIqzyFDOpf2BZhgonbrn5lVzTA0LcHA9f
 754JeciSvpu6oCfD2GYH6iRWglKaaHdhDivRyV6U5gTVHXOCMkvPseqLkd6OddSJeqly
 b3rkYZ70AEGeTn3FLPdd+fSESgVlY4KA2xxd+zzeLucIiVsaU6EI4IWDECTQGysdeTIL
 wkMA==
X-Gm-Message-State: AC+VfDz2Fd7AdIra3+cKXVMnscs9RpPaxIAktBfUmYp2izAkzRr0AqDN
 wKqkqfPvyCMuf2LzTR1Pnx1dyJghJau4h9vJIYmunQ==
X-Google-Smtp-Source: ACHHUZ4TG8QU+j+COk/iolc88umgIiPyq+mfJvhX7537QkTcAXY0VbnJgyJwnWPs/lhftLFIjqK53w==
X-Received: by 2002:a17:906:5d09:b0:978:af9d:c004 with SMTP id
 g9-20020a1709065d0900b00978af9dc004mr10809240ejt.4.1686649182368; 
 Tue, 13 Jun 2023 02:39:42 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 ks9-20020a170906f84900b009786c83d5d6sm6384144ejb.25.2023.06.13.02.39.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/17] exec/memory: Introduce RAM_NAMED_FILE flag
Date: Tue, 13 Jun 2023 11:38:22 +0200
Message-Id: <20230613093822.63750-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Steve Sistare <steven.sistare@oracle.com>

migrate_ignore_shared() is an optimization that avoids copying memory
that is visible and can be mapped on the target.  However, a
memory-backend-ram or a memory-backend-memfd block with the RAM_SHARED
flag set is not migrated when migrate_ignore_shared() is true.  This is
wrong, because the block has no named backing store, and its contents will
be lost.  To fix, ignore shared memory iff it is a named file.  Define a
new flag RAM_NAMED_FILE to distinguish this case.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <1686151116-253260-1-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/migration.json       | 4 ++--
 include/exec/cpu-common.h | 1 +
 include/exec/memory.h     | 3 +++
 backends/hostmem-file.c   | 1 +
 migration/ram.c           | 3 ++-
 softmmu/physmem.c         | 7 ++++++-
 6 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..5bb5ab82a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -465,8 +465,8 @@
 #     block devices (and thus take locks) immediately at the end of
 #     migration.  (since 3.0)
 #
-# @x-ignore-shared: If enabled, QEMU will not migrate shared memory
-#     (since 4.0)
+# @x-ignore-shared: If enabled, QEMU will not migrate shared memory that is
+#     accessible on the destination machine. (since 4.0)
 #
 # @validate-uuid: Send the UUID of the source to allow the destination
 #     to ensure it is the same.  (since 4.2)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e5a55ede5f..87dc9a752c 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -93,6 +93,7 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
 bool qemu_ram_is_migratable(RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_named_file(RAMBlock *rb);
 int qemu_ram_get_fd(RAMBlock *rb);
 
 size_t qemu_ram_pagesize(RAMBlock *block);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c3661b2276..47c2e0221c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -232,6 +232,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM that isn't accessible through normal means. */
 #define RAM_PROTECTED (1 << 8)
 
+/* RAM is an mmap-ed named file */
+#define RAM_NAMED_FILE (1 << 9)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 38ea65bec5..b4335a80e6 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -57,6 +57,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
+    ram_flags |= RAM_NAMED_FILE;
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
                                      backend->size, fb->align, ram_flags,
                                      fb->mem_path, fb->offset, fb->readonly,
diff --git a/migration/ram.c b/migration/ram.c
index 88a6c82e63..5283a75f02 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -197,7 +197,8 @@ static bool postcopy_preempt_active(void)
 bool ramblock_is_ignored(RAMBlock *block)
 {
     return !qemu_ram_is_migratable(block) ||
-           (migrate_ignore_shared() && qemu_ram_is_shared(block));
+           (migrate_ignore_shared() && qemu_ram_is_shared(block)
+                                    && qemu_ram_is_named_file(block));
 }
 
 #undef RAMBLOCK_FOREACH
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 588d0d166b..6bdd944fe8 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1570,6 +1570,11 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
+bool qemu_ram_is_named_file(RAMBlock *rb)
+{
+    return rb->flags & RAM_NAMED_FILE;
+}
+
 int qemu_ram_get_fd(RAMBlock *rb)
 {
     return rb->fd;
@@ -1880,7 +1885,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
-                          RAM_PROTECTED)) == 0);
+                          RAM_PROTECTED | RAM_NAMED_FILE)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
-- 
2.38.1


