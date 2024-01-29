Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF783FC7F
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 04:05:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHwf-0003h0-Mf; Sun, 28 Jan 2024 22:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwc-0003bi-Oa
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwZ-0002Zv-Cr
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jIxnbegQmvBVIO27FvAQrkVaPnZTYcNah9sLJ4uqLU=;
 b=FeYl8X5CzfMrsMqDvvcQrG9C2BWe5/8YG1zjjTlbf18WofTwpSTSL+fi5jJhFA1ALVZxFT
 5JQgtxvafNTI1db5qKSeUBrYy0ISmLOQeLH5zKkZYJxQB4KGXWpk4JJZPT3YGi0K/aPxOP
 nrzYCVM2T54R6qGuXp31fj8wxU8ffJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137--Du5DmQhMgm0oRrgyCCQgg-1; Sun, 28 Jan 2024 22:04:15 -0500
X-MC-Unique: -Du5DmQhMgm0oRrgyCCQgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99FFF85A589;
 Mon, 29 Jan 2024 03:04:14 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5246C1121306;
 Mon, 29 Jan 2024 03:04:10 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] userfaultfd: use 1ULL to build ioctl masks
Date: Mon, 29 Jan 2024 11:03:52 +0800
Message-ID: <20240129030405.177100-2-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Paolo Bonzini <pbonzini@redhat.com>

There is no need to use the Linux-internal __u64 type, 1ULL is
guaranteed to be wide enough.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240117160313.175609-1-pbonzini@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c                  | 16 +++++++---------
 subprojects/libvhost-user/libvhost-user.c |  2 +-
 tests/qtest/migration-test.c              |  4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5408e028c6..893ec8fa89 100644
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
index 6684057370..a3b158c671 100644
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
index d3066e119f..7675519cfa 100644
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


