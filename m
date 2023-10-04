Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5677B8169
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2K8-0001MX-5e; Wed, 04 Oct 2023 09:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qo2Jl-00016z-9H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qo2Jj-0002l6-17
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWV/tvDVk1+vI6vym39HRl05fNQbRu5m5k/nN/gmDUw=;
 b=V4RT32dr3aE/HO4OT1SyRQfvFVV5z0gogxFgcDr2UtUpvFhicrflC6/AHL236iJukvWfXk
 0l1eUBi0lfTRFjQ23/dusr3Fxg2rr2TzdtfUsV2DqIodz4SReQuWK/0L8rf9rwbUtMNQVS
 sSabG5zXneCCo8s5w1xSLnCWEvc1UJM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524--z0Q3eACOvGs-tRrlgAAqQ-1; Wed, 04 Oct 2023 09:53:21 -0400
X-MC-Unique: -z0Q3eACOvGs-tRrlgAAqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3982810D46;
 Wed,  4 Oct 2023 13:53:21 +0000 (UTC)
Received: from localhost (unknown [10.39.194.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94D17492B16;
 Wed,  4 Oct 2023 13:53:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 1/1] osdep: set _FORTIFY_SOURCE=2 when optimization is enabled
Date: Wed,  4 Oct 2023 09:53:17 -0400
Message-ID: <20231004135317.1254548-2-stefanha@redhat.com>
In-Reply-To: <20231004135317.1254548-1-stefanha@redhat.com>
References: <20231004135317.1254548-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Currently we set _FORTIFY_SOURCE=2 as a compiler argument when the
meson 'optimization' setting is non-zero, the compiler is GCC and
the target is Linux.

While the default QEMU optimization level is 2, user could override
this by setting CFLAGS="-O0" or --extra-cflags="-O0" when running
configure and this won't be reflected in the meson 'optimization'
setting. As a result we try to enable _FORTIFY_SOURCE=2 and then the
user gets compile errors as it only works with optimization.

Rather than trying to improve detection in meson, it is simpler to
just check the __OPTIMIZE__ define from osdep.h.

The comment about being incompatible with clang appears to be
outdated, as compilation works fine without excluding clang.

In the coroutine code we must set _FORTIFY_SOURCE=0 to stop the
logic in osdep.h then enabling it.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20231003091549.223020-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build                  | 10 ----------
 include/qemu/osdep.h         |  4 ++++
 util/coroutine-sigaltstack.c |  4 ++--
 util/coroutine-ucontext.c    |  4 ++--
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index 21a1bc03f8..20ceeb8158 100644
--- a/meson.build
+++ b/meson.build
@@ -479,16 +479,6 @@ if 'cpp' in all_languages
   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
 endif
 
-# clang does not support glibc + FORTIFY_SOURCE (is it still true?)
-if get_option('optimization') != '0' and targetos == 'linux'
-  if cc.get_id() == 'gcc'
-    qemu_cflags += ['-U_FORTIFY_SOURCE', '-D_FORTIFY_SOURCE=2']
-  endif
-  if 'cpp' in all_languages and cxx.get_id() == 'gcc'
-    qemu_cxxflags += ['-U_FORTIFY_SOURCE', '-D_FORTIFY_SOURCE=2']
-  endif
-endif
-
 add_project_arguments(qemu_cflags, native: false, language: 'c')
 add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
 if 'cpp' in all_languages
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 18b940db75..475a1c62ff 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -27,6 +27,10 @@
 #ifndef QEMU_OSDEP_H
 #define QEMU_OSDEP_H
 
+#if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE__ && defined __linux__
+# define _FORTIFY_SOURCE 2
+#endif
+
 #include "config-host.h"
 #ifdef NEED_CPU_H
 #include CONFIG_TARGET
diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
index e2690c5f41..037d6416c4 100644
--- a/util/coroutine-sigaltstack.c
+++ b/util/coroutine-sigaltstack.c
@@ -22,9 +22,9 @@
  */
 
 /* XXX Is there a nicer way to disable glibc's stack check for longjmp? */
-#ifdef _FORTIFY_SOURCE
 #undef _FORTIFY_SOURCE
-#endif
+#define _FORTIFY_SOURCE 0
+
 #include "qemu/osdep.h"
 #include <pthread.h>
 #include "qemu/coroutine_int.h"
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index ddc98fb4f8..7b304c79d9 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -19,9 +19,9 @@
  */
 
 /* XXX Is there a nicer way to disable glibc's stack check for longjmp? */
-#ifdef _FORTIFY_SOURCE
 #undef _FORTIFY_SOURCE
-#endif
+#define _FORTIFY_SOURCE 0
+
 #include "qemu/osdep.h"
 #include <ucontext.h>
 #include "qemu/coroutine_int.h"
-- 
2.41.0


