Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC37894EC1
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Apr 2024 11:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraVh-0005sD-OM; Tue, 02 Apr 2024 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraVR-0005rI-57; Tue, 02 Apr 2024 05:32:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rraVF-0004Mz-5t; Tue, 02 Apr 2024 05:32:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC2715B08C;
 Tue,  2 Apr 2024 12:33:40 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DD977A9348;
 Tue,  2 Apr 2024 12:31:57 +0300 (MSK)
Received: (nullmailer pid 2931149 invoked by uid 1000);
 Tue, 02 Apr 2024 09:31:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/4] Fix some typos in documentation (found by codespell)
Date: Tue,  2 Apr 2024 12:31:56 +0300
Message-Id: <20240402093157.2931117-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402093157.2931117-1-mjt@tls.msk.ru>
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/atomics.rst     | 2 +-
 docs/devel/ci-jobs.rst.inc | 2 +-
 docs/devel/clocks.rst      | 2 +-
 docs/system/i386/sgx.rst   | 2 +-
 qapi/qom.json              | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index ff9b5ee30c..b77c6e13e1 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -119,7 +119,7 @@ The only guarantees that you can rely upon in this case are:
   ordinary accesses instead cause data races if they are concurrent with
   other accesses of which at least one is a write.  In order to ensure this,
   the compiler will not optimize accesses out of existence, create unsolicited
-  accesses, or perform other similar optimzations.
+  accesses, or perform other similar optimizations.
 
 - acquire operations will appear to happen, with respect to the other
   components of the system, before all the LOAD or STORE operations
diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index ec33e6ee2b..be06322279 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -115,7 +115,7 @@ CI pipeline.
 QEMU_JOB_SKIPPED
 ~~~~~~~~~~~~~~~~
 
-The job is not reliably successsful in general, so is not
+The job is not reliably successful in general, so is not
 currently suitable to be run by default. Ideally this should
 be a temporary marker until the problems can be addressed, or
 the job permanently removed.
diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index b2d1148cdb..177ee1c90d 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -279,7 +279,7 @@ You can change the multiplier and divider of a clock at runtime,
 so you can use this to model clock controller devices which
 have guest-programmable frequency multipliers or dividers.
 
-Similary to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
+Similarly to ``clock_set()``, ``clock_set_mul_div()`` returns ``true`` if
 the clock state was modified; that is, if the multiplier or the diviser
 or both were changed by the call.
 
diff --git a/docs/system/i386/sgx.rst b/docs/system/i386/sgx.rst
index 0f0a73f758..ab58b29392 100644
--- a/docs/system/i386/sgx.rst
+++ b/docs/system/i386/sgx.rst
@@ -6,7 +6,7 @@ Overview
 
 Intel Software Guard eXtensions (SGX) is a set of instructions and mechanisms
 for memory accesses in order to provide security accesses for sensitive
-applications and data. SGX allows an application to use it's pariticular
+applications and data. SGX allows an application to use its particular
 address space as an *enclave*, which is a protected area provides confidentiality
 and integrity even in the presence of privileged malware. Accesses to the
 enclave memory area from any software not resident in the enclave are prevented,
diff --git a/qapi/qom.json b/qapi/qom.json
index 8d4ca8ed92..85e6b4f84a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -802,7 +802,7 @@
 #
 # @fd: file descriptor name previously passed via 'getfd' command,
 #     which represents a pre-opened /dev/iommu.  This allows the
-#     iommufd object to be shared accross several subsystems (VFIO,
+#     iommufd object to be shared across several subsystems (VFIO,
 #     VDPA, ...), and the file descriptor to be shared with other
 #     process, e.g. DPDK.  (default: QEMU opens /dev/iommu by itself)
 #
-- 
2.39.2


