Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD97AB327
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgdg-000429-CX; Fri, 22 Sep 2023 09:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjgde-00041j-4P
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjgdc-00057Y-Ik
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695390967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh6znVjqbbgha2BgBXdOLwLuTvWFz0PP3wJpgGCaos8=;
 b=LnoILxcXZLGnMQTTdhYbVYjrQuxOCM3o3eJHF6BBfUo1Shb+mpz8tA6vVTnv1aTNw97TVv
 M8A0KDOI2DduQyxRW2MLpVGi6iyp5TsUk3CHZ5hGyZjEuWcg2JyjTZJy6EBa6z+OdaEXZX
 xlTcuP5vUGoeGlfb0XHQTUpS1JKnTtk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-T5f4sQ9gMvyCXWm9EiQ3fw-1; Fri, 22 Sep 2023 09:56:01 -0400
X-MC-Unique: T5f4sQ9gMvyCXWm9EiQ3fw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3253E811E8F;
 Fri, 22 Sep 2023 13:56:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 000CE40C6EC1;
 Fri, 22 Sep 2023 13:55:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/2] osdep: set _FORTIFY_SOURCE=2 when optimization is enabled
Date: Fri, 22 Sep 2023 14:55:55 +0100
Message-ID: <20230922135555.241809-3-berrange@redhat.com>
In-Reply-To: <20230922135555.241809-1-berrange@redhat.com>
References: <20230922135555.241809-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
---
 include/qemu/osdep.h         |  4 ++++
 meson.build                  | 10 ----------
 util/coroutine-sigaltstack.c |  4 ++--
 util/coroutine-ucontext.c    |  4 ++--
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 2897720fac..b317649d13 100644
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
diff --git a/meson.build b/meson.build
index f426861d90..4947ae48b3 100644
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


