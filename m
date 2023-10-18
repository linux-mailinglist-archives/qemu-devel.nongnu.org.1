Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E83FA7CD681
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1ut-0001lL-NW; Wed, 18 Oct 2023 04:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1up-0001gX-A0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1un-0003eb-IY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25xnsEqSHxpQ4CTPcOTT4GIh5JKkdRZwjXwxTddW8Dk=;
 b=PSs565E5OxeTxfGXtJgLeIExF3Vi28ZwvFwaO1dC95ga0TtCXiIY2hSzh8sYmYUhVc6O0r
 FWa5pQ3N4v8+Xn/xcNRBDmGAbj9vz+zmONhFWsauQu2qfoPxuduTSAfbier+1AYoUbOyRh
 vr8higgrA8l/KMzrBiqVT0T4FBoNM6A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Pi68u2BjPwG309KdPyGJKQ-1; Wed, 18 Oct 2023 04:28:26 -0400
X-MC-Unique: Pi68u2BjPwG309KdPyGJKQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e119e615aso7186034a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617705; x=1698222505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25xnsEqSHxpQ4CTPcOTT4GIh5JKkdRZwjXwxTddW8Dk=;
 b=IhzIkUj36esShXcaql8SdQl1oRH8cIThUHK1lJLh62Lf2pRhyxZ3y2CWyeSSO2er4t
 7bIadt/19as4Y9bhvtwuAm0vgjUBnQ03oNVXm+Q31DAFh3IO5Ng4V8XoJHQb5fC3iEtd
 N0C7Mvqx169RA3Pw143HAJOcsEmdvGqZZt6R4JHQYZUlfghjxDOgQpJWjOEI8eiKnJJ1
 yFHHov94GarGYhoXiUJ0LrgKSN0/VWMijAvG8c/QDyBGoXZaDCWoKvKbMhtgiU9Ko4Me
 LGJq9flCyt5krIRnuxyGZu0JXkdipsjw8g5mhfnJGtnR1dYQZuyeEzn/BnsQhIaVtmYe
 C0Kw==
X-Gm-Message-State: AOJu0YwwxYuHUlQ+xZO7wvIAvcV/ZrFCOux/+us7HngjlpB6qc98XEbc
 ZPCfZwV75Zez7b8VDAZ9SVWSs6IF3gKJNI/a3Dpqn+EzEskX+xfyBLiaLUIk1zqY/ydM3efjuZr
 josrVosIUwEV+4vCDYzTsZyqVyNq+M1dJjCdkMmcUgj96mi9wtgw2+jWvW5nZwq37Pv1GViutRn
 g=
X-Received: by 2002:a50:cc4a:0:b0:530:8942:e830 with SMTP id
 n10-20020a50cc4a000000b005308942e830mr3866265edi.2.1697617705426; 
 Wed, 18 Oct 2023 01:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMnk2aoiGtvXDTWxPx40051Zd3JOqUPvP8xQV1GRonrQhtFxrPXtHnITs5fKjLURAVVT7fbQ==
X-Received: by 2002:a50:cc4a:0:b0:530:8942:e830 with SMTP id
 n10-20020a50cc4a000000b005308942e830mr3866249edi.2.1697617705039; 
 Wed, 18 Oct 2023 01:28:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bx18-20020a0564020b5200b0053d9cb67248sm2380498edb.18.2023.10.18.01.28.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] meson: do not use set10
Date: Wed, 18 Oct 2023 10:27:36 +0200
Message-ID: <20231018082752.322306-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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


