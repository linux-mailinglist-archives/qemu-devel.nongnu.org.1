Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C7830A56
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:04:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Nx-0001nn-Nf; Wed, 17 Jan 2024 11:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Nv-0001nM-EQ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:03:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQ8Ns-0007vS-So
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705507398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a2D1wT4ZPp+jHOba56LM2ebhkdAlGG5xI0TGXTETUOc=;
 b=FZsLjRiTUBodmJbic0hE6ZfXtequ/EPgkdhAhnoRf9Ha9hi+k4qg69MwyMr96nfT4zAmCi
 i/dE+7Zcs01M0hXcK5RmzzZTdQsxUM/QAsqSzEauV7HCVbrWM6Ydu7rEBEi+xCSQl8keU+
 gntZxcm7duyT7aH53YbzdD9suuHvjv8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-5dKRKsWlOf2rE_BWN84K_g-1; Wed, 17 Jan 2024 11:03:16 -0500
X-MC-Unique: 5dKRKsWlOf2rE_BWN84K_g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-558fe4c0c46so2621024a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705507395; x=1706112195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2D1wT4ZPp+jHOba56LM2ebhkdAlGG5xI0TGXTETUOc=;
 b=ussmT19f1VLLzQ2jcKsDY1RDQ0qSbLm5oO2s7U4j+H13bWivpwizPYLzhqWLFmxuHQ
 pCCQokXzjVhhpIjl577jP7qUDfFWpY1QM66KhKskWwjHibCOsalcfrGDGtzTMaIo8+2S
 ubviUIkUshypdVQpHDfEdL/B51uKPzDbCFqIXWiGapIRmmSoa2X94JgK383SHP6KiTqw
 ALsIyXdxfi+pr0K2ELD9TkcTbxa5JGjHQxFg1OuJ1yAiZcZalDS8MeOTsLMq301YGhVE
 AwcwBwSv8ODP/U1YRzYip/wGITA4bGzejxF0/jLKhPeGVSr6vKKD0ZhGFQ4hE8psLEPR
 p75Q==
X-Gm-Message-State: AOJu0YxzF6Gy/D18c6fDVU68V/zuCLnhFHB9I+VPAH26dLL87Uc+3Tjw
 vp1OkfY5GcZffslBrESI56sXlFrUMAPWrzqJ2tS7K1+ezp4GGiYrCTN+SUATifO0pfA1LIT04us
 yHt9GMAQ7FTRLyW3jKyHg9W9RhEH3LgNQvcGzc/WzLzc+gIUeaRbu6IiFF/LLB0EZDLo87eEbiZ
 nLFfWrKb8=
X-Received: by 2002:a17:906:1115:b0:a26:97fe:b8cc with SMTP id
 h21-20020a170906111500b00a2697feb8ccmr5040484eja.66.1705507395087; 
 Wed, 17 Jan 2024 08:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1hE7cgU5hYwexLiBThsTZEA2sO9Ddsu5HUeRx++sDM/pAIRgtp64zUfrnpc9aiylBfFCmeA==
X-Received: by 2002:a17:906:1115:b0:a26:97fe:b8cc with SMTP id
 h21-20020a170906111500b00a2697feb8ccmr5040470eja.66.1705507394720; 
 Wed, 17 Jan 2024 08:03:14 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a1709063e8500b00a28badcf367sm7925197ejj.54.2024.01.17.08.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:03:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [PATCH] userfaultfd: use 1ULL to build ioctl masks
Date: Wed, 17 Jan 2024 17:03:13 +0100
Message-ID: <20240117160313.175609-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

There is no need to use the Linux-internal __u64 type, 1ULL is
guaranteed to be wide enough.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/postcopy-ram.c                  | 16 +++++++---------
 subprojects/libvhost-user/libvhost-user.c |  2 +-
 tests/qtest/migration-test.c              |  4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5408e028c63..893ec8fa897 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -102,11 +102,9 @@ void postcopy_thread_create(MigrationIncomingState *mis,
  * are target OS specific.
  */
 #if defined(__linux__)
-
 #include <poll.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
-#include <asm/types.h> /* for __u64 */
 #endif
 
 #if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
@@ -272,8 +270,8 @@ static bool request_ufd_features(int ufd, uint64_t features)
         return false;
     }
 
-    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
-                 (__u64)1 << _UFFDIO_UNREGISTER;
+    ioctl_mask = 1ULL << _UFFDIO_REGISTER |
+                 1ULL << _UFFDIO_UNREGISTER;
     if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
         error_report("Missing userfault features: %" PRIx64,
                      (uint64_t)(~api_struct.ioctls & ioctl_mask));
@@ -462,9 +460,9 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
         goto out;
     }
 
-    feature_mask = (__u64)1 << _UFFDIO_WAKE |
-                   (__u64)1 << _UFFDIO_COPY |
-                   (__u64)1 << _UFFDIO_ZEROPAGE;
+    feature_mask = 1ULL << _UFFDIO_WAKE |
+                   1ULL << _UFFDIO_COPY |
+                   1ULL << _UFFDIO_ZEROPAGE;
     if ((reg_struct.ioctls & feature_mask) != feature_mask) {
         error_setg(errp, "Missing userfault map features: %" PRIx64,
                    (uint64_t)(~reg_struct.ioctls & feature_mask));
@@ -733,11 +731,11 @@ static int ram_block_enable_notify(RAMBlock *rb, void *opaque)
         error_report("%s userfault register: %s", __func__, strerror(errno));
         return -1;
     }
-    if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+    if (!(reg_struct.ioctls & (1ULL << _UFFDIO_COPY))) {
         error_report("%s userfault: Region doesn't support COPY", __func__);
         return -1;
     }
-    if (reg_struct.ioctls & ((__u64)1 << _UFFDIO_ZEROPAGE)) {
+    if (reg_struct.ioctls & (1ULL << _UFFDIO_ZEROPAGE)) {
         qemu_ram_set_uf_zeroable(rb);
     }
 
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 6684057370d..a3b158c6713 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -684,7 +684,7 @@ generate_faults(VuDev *dev) {
                      dev->postcopy_ufd, strerror(errno));
             return false;
         }
-        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+        if (!(reg_struct.ioctls & (1ULL << _UFFDIO_COPY))) {
             vu_panic(dev, "%s Region (%d) doesn't support COPY",
                      __func__, i);
             return false;
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 136e5df06c5..f3f4e8d5aab 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -104,8 +104,8 @@ static bool ufd_version_check(void)
     }
     uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
 
-    ioctl_mask = (__u64)1 << _UFFDIO_REGISTER |
-                 (__u64)1 << _UFFDIO_UNREGISTER;
+    ioctl_mask = 1ULL << _UFFDIO_REGISTER |
+                 1ULL << _UFFDIO_UNREGISTER;
     if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
         g_test_message("Skipping test: Missing userfault feature");
         return false;
-- 
2.43.0


