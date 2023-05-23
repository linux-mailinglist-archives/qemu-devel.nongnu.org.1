Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6870DA2D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P5F-0001LV-Qt; Tue, 23 May 2023 06:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P58-000174-9Y; Tue, 23 May 2023 06:17:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P56-000290-36; Tue, 23 May 2023 06:17:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00F9C7D07;
 Tue, 23 May 2023 13:15:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4B60F7297;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: (nullmailer pid 85554 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 57/59] block: compile out assert_bdrv_graph_readable()
 by default
Date: Tue, 23 May 2023 13:15:17 +0300
Message-Id: <20230523101536.85424-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

reader_count() is a performance bottleneck because the global
aio_context_list_lock mutex causes thread contention. Put this debugging
assertion behind a new ./configure --enable-debug-graph-lock option and
disable it by default.

The --enable-debug-graph-lock option is also enabled by the more general
--enable-debug option.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230501173443.153062-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 58a2e3f5c37be02dac3086b81bdda9414b931edf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick this one up so the next patch which disables this applies cleanly)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index 454c31e691..259a7a0bde 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -265,7 +265,10 @@ void bdrv_graph_rdunlock_main_loop(void)
 
 void assert_bdrv_graph_readable(void)
 {
+    /* reader_count() is slow due to aio_context_list_lock lock contention */
+#ifdef CONFIG_DEBUG_GRAPH_LOCK
     assert(qemu_in_main_thread() || reader_count());
+#endif
 }
 
 void assert_bdrv_graph_writable(void)
diff --git a/configure b/configure
index 800b5850f4..a62a3e6be9 100755
--- a/configure
+++ b/configure
@@ -806,6 +806,7 @@ for opt do
   --enable-debug)
       # Enable debugging options that aren't excessively noisy
       debug_tcg="yes"
+      meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
       fortify_source="no"
diff --git a/meson.build b/meson.build
index c7e486e087..30447cfaef 100644
--- a/meson.build
+++ b/meson.build
@@ -1956,6 +1956,7 @@ if get_option('debug_stack_usage') and have_coroutine_pool
   have_coroutine_pool = false
 endif
 config_host_data.set10('CONFIG_COROUTINE_POOL', have_coroutine_pool)
+config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_GPROF', get_option('gprof'))
@@ -3837,6 +3838,7 @@ summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
 summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'membarrier':        have_membarrier}
+summary_info += {'debug graph lock':  get_option('debug_graph_lock')}
 summary_info += {'debug stack usage': get_option('debug_stack_usage')}
 summary_info += {'mutex debugging':   get_option('debug_mutex')}
 summary_info += {'memory allocator':  get_option('malloc')}
diff --git a/meson_options.txt b/meson_options.txt
index fc9447d267..bc857fe68b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -311,6 +311,8 @@ option('rng_none', type: 'boolean', value: false,
        description: 'dummy RNG, avoid using /dev/(u)random and getrandom()')
 option('coroutine_pool', type: 'boolean', value: true,
        description: 'coroutine freelist (better performance)')
+option('debug_graph_lock', type: 'boolean', value: false,
+       description: 'graph lock debugging support')
 option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 009fab1515..30e1f25259 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -21,6 +21,8 @@ meson_options_help() {
   printf "%s\n" '                           QEMU'
   printf "%s\n" '  --enable-cfi             Control-Flow Integrity (CFI)'
   printf "%s\n" '  --enable-cfi-debug       Verbose errors in case of CFI violation'
+  printf "%s\n" '  --enable-debug-graph-lock'
+  printf "%s\n" '                           graph lock debugging support'
   printf "%s\n" '  --enable-debug-mutex     mutex debugging support'
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
@@ -249,6 +251,8 @@ _meson_option_parse() {
     --datadir=*) quote_sh "-Ddatadir=$2" ;;
     --enable-dbus-display) printf "%s" -Ddbus_display=enabled ;;
     --disable-dbus-display) printf "%s" -Ddbus_display=disabled ;;
+    --enable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=true ;;
+    --disable-debug-graph-lock) printf "%s" -Ddebug_graph_lock=false ;;
     --enable-debug-mutex) printf "%s" -Ddebug_mutex=true ;;
     --disable-debug-mutex) printf "%s" -Ddebug_mutex=false ;;
     --enable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=true ;;
-- 
2.39.2


