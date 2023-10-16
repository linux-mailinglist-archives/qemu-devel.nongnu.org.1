Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4C7C9FA4
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8f-0003sD-EI; Mon, 16 Oct 2023 02:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8d-0003s2-EH
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8b-0005RE-SU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25xnsEqSHxpQ4CTPcOTT4GIh5JKkdRZwjXwxTddW8Dk=;
 b=hwXFR3gbGkyp62tqNWI0sa4oziCiaW1PUifLwhjKKl3zXIeBBxlIK43lJfnkjAKZ9K8lYg
 z2qoY+wTRDGwOBloXWn2jDqnWAoPUPFDLhSnEsQwr69qeIBCNd52MB+DQLtQFAQsuGoxzy
 t8cuPlERXmJtkJMZCA5RUnz1FHKkXdk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-FuTLjjV5OMOmRAj85SzfAQ-1; Mon, 16 Oct 2023 02:31:34 -0400
X-MC-Unique: FuTLjjV5OMOmRAj85SzfAQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso10614566b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437893; x=1698042693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25xnsEqSHxpQ4CTPcOTT4GIh5JKkdRZwjXwxTddW8Dk=;
 b=TuTxPDS2PBNLo66xb3etHTGwZdYpmAmtSqWwv9e46FwZIquQoRADAtKpRuRW8LfL2E
 F/Z272reh8zyJeVk0tx4aSZX7SYc5i1SDNL8ApAj0H+MiYWv8AsLzD4i3jugbiTCFzq2
 yt66w1yLDL8Dhu/hJGt3rw/JJMrbzIx+IYDfG5GMxLK97HQceZDs33mqLMbMes4XGL/0
 M30Norivm7aDzho6h1jWktbX/tVrevFznBEFIiskDB6t7QSPdS5gDHr2V3yGUvEN8wWM
 bjMicCpvyQrF2wG56wwHFa2or2xGQJAYxYsDBhn2jUWCX3JgxaC0sg9DHUca0uWzZBL1
 9RGg==
X-Gm-Message-State: AOJu0YyojZglTn1HaVpw3Fn9ZnbzMqQa0zEtjt83BYhBcLDKL2Bj2KPL
 l/g+deJh46xV8fdzmqpjvYAOvz/c0Szj7UDtcUPXqtDydPsAQj/yGtYu+RNPXr0ph5H9hhjleqv
 38L2pCQJDuBpfJnKdb5TE+249Ic9FJXVfinZPx9gm68dZ4Mr0rWRJRCRx1Do2aHuh66rALDRSo8
 8=
X-Received: by 2002:a17:907:1c25:b0:9bf:b022:dc7 with SMTP id
 nc37-20020a1709071c2500b009bfb0220dc7mr3454970ejc.48.1697437893202; 
 Sun, 15 Oct 2023 23:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8tKni1vr2zCfqttKutAzJ1AP4uu50K61MdWYWMHWAwqXGmfUwW49yml/h+9/Qh+zJLvgW5w==
X-Received: by 2002:a17:907:1c25:b0:9bf:b022:dc7 with SMTP id
 nc37-20020a1709071c2500b009bfb0220dc7mr3454942ejc.48.1697437892608; 
 Sun, 15 Oct 2023 23:31:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a17090651c200b0099cb0a7098dsm3478724ejk.19.2023.10.15.23.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/17] meson: do not use set10
Date: Mon, 16 Oct 2023 08:31:12 +0200
Message-ID: <20231016063127.161204-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make all items of config-host.h consistent.  To keep the --disable-coroutine-pool
code visible to the compiler, mutuate the IS_ENABLED() macro from Linux.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/compiler.h     | 15 +++++++++++++++
 meson.build                 |  2 +-
 tests/unit/test-coroutine.c |  2 +-
 util/qemu-coroutine.c       |  4 ++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 1109482a000..c797f0d4572 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -212,4 +212,19 @@
 # define QEMU_USED
 #endif
 
+/*
+ * Ugly CPP trick that is like "defined FOO", but also works in C
+ * code.  Useful to replace #ifdef with "if" statements; assumes
+ * the symbol was defined with Meson's "config.set()", so it is empty
+ * if defined.
+ */
+#define IS_ENABLED(x)                  IS_EMPTY(x)
+
+#define IS_EMPTY_JUNK_                 junk,
+#define IS_EMPTY(value)                IS_EMPTY_(IS_EMPTY_JUNK_##value)
+
+/* Expands to either SECOND_ARG(junk, 1, 0) or SECOND_ARG(IS_EMPTY_JUNK_CONFIG_FOO 1, 0)  */
+#define SECOND_ARG(first, second, ...) second
+#define IS_EMPTY_(junk_maybecomma)     SECOND_ARG(junk_maybecomma 1, 0)
+
 #endif /* COMPILER_H */
diff --git a/meson.build b/meson.build
index bd65a111aa8..010d2c649c2 100644
--- a/meson.build
+++ b/meson.build
@@ -2194,7 +2194,7 @@ if get_option('debug_stack_usage') and have_coroutine_pool
   message('Disabling coroutine pool to measure stack usage')
   have_coroutine_pool = false
 endif
-config_host_data.set10('CONFIG_COROUTINE_POOL', have_coroutine_pool)
+config_host_data.set('CONFIG_COROUTINE_POOL', have_coroutine_pool)
 config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
diff --git a/tests/unit/test-coroutine.c b/tests/unit/test-coroutine.c
index b0d21d673a0..a2563647e74 100644
--- a/tests/unit/test-coroutine.c
+++ b/tests/unit/test-coroutine.c
@@ -645,7 +645,7 @@ int main(int argc, char **argv)
      * with a sentinel value.  If there is no freelist this would legitimately
      * crash, so skip it.
      */
-    if (CONFIG_COROUTINE_POOL) {
+    if (IS_ENABLED(CONFIG_COROUTINE_POOL)) {
         g_test_add_func("/basic/no-dangling-access", test_no_dangling_access);
     }
 
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 17a88f65053..5fd2dbaf8bb 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -57,7 +57,7 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
 {
     Coroutine *co = NULL;
 
-    if (CONFIG_COROUTINE_POOL) {
+    if (IS_ENABLED(CONFIG_COROUTINE_POOL)) {
         CoroutineQSList *alloc_pool = get_ptr_alloc_pool();
 
         co = QSLIST_FIRST(alloc_pool);
@@ -99,7 +99,7 @@ static void coroutine_delete(Coroutine *co)
 {
     co->caller = NULL;
 
-    if (CONFIG_COROUTINE_POOL) {
+    if (IS_ENABLED(CONFIG_COROUTINE_POOL)) {
         if (release_pool_size < qatomic_read(&pool_max_size) * 2) {
             QSLIST_INSERT_HEAD_ATOMIC(&release_pool, co, pool_next);
             qatomic_inc(&release_pool_size);
-- 
2.41.0


