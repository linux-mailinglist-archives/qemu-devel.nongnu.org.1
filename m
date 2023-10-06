Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE17BB624
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinJ-0008Gx-JD; Fri, 06 Oct 2023 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008FB-Ep
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin2-0000JC-6X
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4z5x8Uu4dREQUi7wI/K7/deSe5fP0uIUCLyqAJ6KbM=;
 b=b0xSSwFO/t8bMyrQehKcp3hGURqYAJhSTtZkIUUXq+ao1XYIt2rWSC27LJe4ga0ybq84cx
 87Z+bxcc2AV//8le+ujxXvDoT1vR4psOmBatRnsx5zyUQ3xL1HouCQe7N1l/9ebFoSA8DL
 Wb+bo1iMEiZkUZSQFa06NSum4eoLyBg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-YR28VF1-Mj-ckhqw0Xu7wg-1; Fri, 06 Oct 2023 07:14:38 -0400
X-MC-Unique: YR28VF1-Mj-ckhqw0Xu7wg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae70250ef5so351018966b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590876; x=1697195676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4z5x8Uu4dREQUi7wI/K7/deSe5fP0uIUCLyqAJ6KbM=;
 b=W645sy8b948Ad+q8rTYOga+U01JGlaz1xCKooWElE7GEGQhrF1Rt6COXbve7Da26Wy
 e/300fkHKWoMAcBI5OKcbahe0PKgf1XkfE+lI3OucKLltGRSuNTzApM4yiFyzYtecEI1
 k6KxkO/NcK6donG6KhYWA87DqOxydyPWeSs41RPxWAvXNEUuBQuCznBhybFNNhUnJ6DD
 uFrnSaIaJd4wn25DfIAIKdUj1cutLmNzODOF4zDa4/geCEIpGt5gKTXxzzPPp1fP3Jl+
 3de16XogChKqeoKXGv24mLLmFCL7XSKGOiYaoGXCebn4xQYEWWCumOwkePexGBNk2ix8
 9X9A==
X-Gm-Message-State: AOJu0Yx8IeJNVXcHXUrWrCXz5YRlAzwCmEwy1yXD2oSACV2JeIMzV9xx
 1iX5dFGKFxGVPQf6wi4OQ4CJw7NAJ+ab0RH5av259DkCPvkhrXCU33wTtBcbzb0zkpsf9qzI8Y+
 l9Xw2QiqTEGUXciVlWEWtou69XJlzlYNSC1uezevWGX3yQ7zru1MQoQ1NSUyntkgi4Z4zPTztx3
 c=
X-Received: by 2002:a17:906:8455:b0:9a2:1e14:86b9 with SMTP id
 e21-20020a170906845500b009a21e1486b9mr4230291ejy.0.1696590876239; 
 Fri, 06 Oct 2023 04:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc7VTMooHwElT0J394SoiMCUdgyhX/lrb0nk9OwYbuBrJqUUXSfCQnbOER7z6TGi1M8P84fQ==
X-Received: by 2002:a17:906:8455:b0:9a2:1e14:86b9 with SMTP id
 e21-20020a170906845500b009a21e1486b9mr4230283ejy.0.1696590875920; 
 Fri, 06 Oct 2023 04:14:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a1709064ed900b009b947aacb4bsm2698889ejv.191.2023.10.06.04.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/26] semihosting: Rename softmmu_FOO_user() ->
 uaccess_FOO_user()
Date: Fri,  6 Oct 2023 13:13:58 +0200
Message-ID: <20231006111412.13130-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Add a check in 'softmmu-uaccess.h' that the header is only
include in system emulation, and rename it as 'uaccess.h'.

Rename the API methods:

  - softmmu_[un]lock_user*() -> uaccess_[un]lock_user*()
  - softmmu_strlen_user() -> uaccess_strlen_user().

Update a pair of comments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-9-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../{softmmu-uaccess.h => uaccess.h}          | 24 +++++++++++--------
 semihosting/arm-compat-semi.c                 |  4 ++--
 semihosting/config.c                          |  2 +-
 semihosting/guestfd.c                         |  2 +-
 semihosting/syscalls.c                        |  2 +-
 semihosting/uaccess.c                         | 14 +++++------
 stubs/semihost.c                              |  4 ++--
 target/m68k/m68k-semi.c                       |  2 +-
 target/mips/tcg/sysemu/mips-semi.c            |  2 +-
 target/nios2/nios2-semi.c                     |  2 +-
 10 files changed, 31 insertions(+), 27 deletions(-)
 rename include/semihosting/{softmmu-uaccess.h => uaccess.h} (75%)

diff --git a/include/semihosting/softmmu-uaccess.h b/include/semihosting/uaccess.h
similarity index 75%
rename from include/semihosting/softmmu-uaccess.h
rename to include/semihosting/uaccess.h
index 4f08dfc0986..3963eafc3e2 100644
--- a/include/semihosting/softmmu-uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -7,8 +7,12 @@
  * This code is licensed under the GPL
  */
 
-#ifndef SEMIHOSTING_SOFTMMU_UACCESS_H
-#define SEMIHOSTING_SOFTMMU_UACCESS_H
+#ifndef SEMIHOSTING_UACCESS_H
+#define SEMIHOSTING_UACCESS_H
+
+#ifdef CONFIG_USER_ONLY
+#error Cannot include semihosting/uaccess.h from user emulation
+#endif
 
 #include "cpu.h"
 
@@ -42,18 +46,18 @@
 
 #define put_user_ual(arg, p) put_user_u32(arg, p)
 
-void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
+void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy);
-#define lock_user(type, p, len, copy) softmmu_lock_user(env, p, len, copy)
+#define lock_user(type, p, len, copy) uaccess_lock_user(env, p, len, copy)
 
-char *softmmu_lock_user_string(CPUArchState *env, target_ulong addr);
-#define lock_user_string(p) softmmu_lock_user_string(env, p)
+char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr);
+#define lock_user_string(p) uaccess_lock_user_string(env, p)
 
-void softmmu_unlock_user(CPUArchState *env, void *p,
+void uaccess_unlock_user(CPUArchState *env, void *p,
                          target_ulong addr, target_ulong len);
-#define unlock_user(s, args, len) softmmu_unlock_user(env, s, args, len)
+#define unlock_user(s, args, len) uaccess_unlock_user(env, s, args, len)
 
-ssize_t softmmu_strlen_user(CPUArchState *env, target_ulong addr);
-#define target_strlen(p) softmmu_strlen_user(env, p)
+ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr);
+#define target_strlen(p) uaccess_strlen_user(env, p)
 
 #endif /* SEMIHOSTING_SOFTMMU_UACCESS_H */
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 564fe17f75c..bb43f012652 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -202,13 +202,13 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
  * The semihosting API has no concept of its errno being thread-safe,
  * as the API design predates SMP CPUs and was intended as a simple
  * real-hardware set of debug functionality. For QEMU, we make the
- * errno be per-thread in linux-user mode; in softmmu it is a simple
+ * errno be per-thread in linux-user mode; in system-mode it is a simple
  * global, and we assume that the guest takes care of avoiding any races.
  */
 #ifndef CONFIG_USER_ONLY
 static target_ulong syscall_err;
 
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #endif
 
 static inline uint32_t get_swi_errno(CPUState *cs)
diff --git a/semihosting/config.c b/semihosting/config.c
index 8ca569735d0..61e4016fc5f 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -12,7 +12,7 @@
  * linux-user targets. However in that use case no configuration of
  * the outputs and command lines is supported.
  *
- * The config module is common to all softmmu targets however as vl.c
+ * The config module is common to all system targets however as vl.c
  * needs to link against the helpers.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index acb86b50ddc..955c2efbd0c 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -15,7 +15,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #include CONFIG_DEVICES
 #endif
 
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index d27574a1e2b..4060211d196 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -15,7 +15,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #endif
 
 
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 7505eb6d1ba..5d889f92638 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -9,9 +9,9 @@
 
 #include "qemu/osdep.h"
 #include "exec/exec-all.h"
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 
-void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
+void *uaccess_lock_user(CPUArchState *env, target_ulong addr,
                         target_ulong len, bool copy)
 {
     void *p = malloc(len);
@@ -24,7 +24,7 @@ void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
     return p;
 }
 
-ssize_t softmmu_strlen_user(CPUArchState *env, target_ulong addr)
+ssize_t uaccess_strlen_user(CPUArchState *env, target_ulong addr)
 {
     int mmu_idx = cpu_mmu_index(env, false);
     size_t len = 0;
@@ -72,16 +72,16 @@ ssize_t softmmu_strlen_user(CPUArchState *env, target_ulong addr)
     }
 }
 
-char *softmmu_lock_user_string(CPUArchState *env, target_ulong addr)
+char *uaccess_lock_user_string(CPUArchState *env, target_ulong addr)
 {
-    ssize_t len = softmmu_strlen_user(env, addr);
+    ssize_t len = uaccess_strlen_user(env, addr);
     if (len < 0) {
         return NULL;
     }
-    return softmmu_lock_user(env, addr, len + 1, true);
+    return uaccess_lock_user(env, addr, len + 1, true);
 }
 
-void softmmu_unlock_user(CPUArchState *env, void *p,
+void uaccess_unlock_user(CPUArchState *env, void *p,
                          target_ulong addr, target_ulong len)
 {
     if (len) {
diff --git a/stubs/semihost.c b/stubs/semihost.c
index aad7a703532..9343d385d79 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -1,9 +1,9 @@
 /*
- * Semihosting Stubs for SoftMMU
+ * Semihosting Stubs for system emulation
  *
  * Copyright (c) 2019 Linaro Ltd
  *
- * Stubs for SoftMMU targets that don't actually do semihosting.
+ * Stubs for system targets that don't actually do semihosting.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 80cd8d70dbb..b4ffb70f8b7 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -27,7 +27,7 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/helpers.h"
 #include "semihosting/syscalls.h"
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
 
diff --git a/target/mips/tcg/sysemu/mips-semi.c b/target/mips/tcg/sysemu/mips-semi.c
index f3735df7b9e..cc084eb1a24 100644
--- a/target/mips/tcg/sysemu/mips-semi.c
+++ b/target/mips/tcg/sysemu/mips-semi.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/helpers.h"
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
 #include "semihosting/syscalls.h"
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index 9d0241c758f..0b84fcb6b62 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -26,7 +26,7 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/helpers.h"
 #include "semihosting/syscalls.h"
-#include "semihosting/softmmu-uaccess.h"
+#include "semihosting/uaccess.h"
 #include "qemu/log.h"
 
 #define HOSTED_EXIT  0
-- 
2.41.0


