Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C33DE79853C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDk-0006zG-OB; Fri, 08 Sep 2023 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDg-0006xs-03; Fri, 08 Sep 2023 05:56:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDc-0006Tp-2Z; Fri, 08 Sep 2023 05:56:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F774200CA;
 Fri,  8 Sep 2023 12:56:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 54DF526910;
 Fri,  8 Sep 2023 12:55:56 +0300 (MSK)
Received: (nullmailer pid 275946 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/23] trace-events: Fix the name of the tracing.rst file
Date: Fri,  8 Sep 2023 12:54:59 +0300
Message-Id: <20230908095520.275866-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

The file has been converted to .rst a while ago - make sure that the
references in the trace-events files are pointing to the right location
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 bsd-user/trace-events         | 2 +-
 ebpf/trace-events             | 2 +-
 hw/nubus/trace-events         | 2 +-
 target/s390x/kvm/trace-events | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/trace-events b/bsd-user/trace-events
index 843896f627..2c1cb66726 100644
--- a/bsd-user/trace-events
+++ b/bsd-user/trace-events
@@ -1,4 +1,4 @@
-# See docs/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # bsd-user/signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
diff --git a/ebpf/trace-events b/ebpf/trace-events
index 411b1e2be3..b3ad1a35f2 100644
--- a/ebpf/trace-events
+++ b/ebpf/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # ebpf-rss.c
 ebpf_error(const char *s1, const char *s2) "error in %s: %s"
diff --git a/hw/nubus/trace-events b/hw/nubus/trace-events
index e31833d694..9259d66725 100644
--- a/hw/nubus/trace-events
+++ b/hw/nubus/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # nubus-bus.c
 nubus_slot_read(uint64_t addr, int size) "reading unassigned addr 0x%"PRIx64 " size %d"
diff --git a/target/s390x/kvm/trace-events b/target/s390x/kvm/trace-events
index 818f1a37a1..cdf2c4f8f2 100644
--- a/target/s390x/kvm/trace-events
+++ b/target/s390x/kvm/trace-events
@@ -1,4 +1,4 @@
-# See docs/devel/tracing.txt for syntax documentation.
+# See docs/devel/tracing.rst for syntax documentation.
 
 # kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
-- 
2.39.2


