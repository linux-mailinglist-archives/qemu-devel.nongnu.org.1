Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F97A0D98
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrY2-0000js-On; Thu, 14 Sep 2023 14:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXx-0000Rf-HH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:37 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXv-0007mg-DR
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:37 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so169822166b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717909; x=1695322709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VXjZwiyUYtQa/HjRyWBFYizJrxQIbdLDkyfozxU6z0=;
 b=W5mcIvqZ505R07GHE8K8McFTzaK5esUE7rYfOXRYZ/vVQoRJDRWtKdj1mojhTW1AsE
 vmKGJQBgSqc7FuTkiNVRGkXZbRUmQQxx3c1/qN++Y4dtQNJ37UZIveCO2FjXQaVLqqt4
 nRL2JDAyEAQc56LHU0cPMCjWaDlsyokxeIs5aGrS7mDm0UiN+kNkK3a5hqVu7bg7wPa/
 nruRIFUtgz7aJ79vd/EqqVjDoz377FaxWsyDJ6PhWYf8waIaVmV9u/iOm7qWl4gdJNnD
 EFy/y760iH1TPG4fMJyXcQelgcJ9rm5p6uupb/3SUwKOAzJkIUfO5AWcJxXYhfc+c+Zf
 3f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717909; x=1695322709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VXjZwiyUYtQa/HjRyWBFYizJrxQIbdLDkyfozxU6z0=;
 b=pzE1upRUOz6oGLHaesmyot0td7cvhgh7tsS2IWDcAKyBnm/DnnFwEKUaKlMap7hXVy
 vO9OJ9NBM5Mvb2i4UerjbLMLAowAjWXoSoWi8gwDELHkdflfJ7nYmbyDjICk64xpibpC
 OQN+kWJNcL3g/X076VFIxwerrLd5EWE/67ptCFd6eDZs5EHIllBY8mmphlAeLproNFRW
 EIMsc0CQVorugeHjnYEIk2v1GoEiO4U3y4KO+oCk8mnhh37sY8b8Qdc6WpRaUXcVvVEk
 iakgkYGTStZTypw3C+tz9X4nupMkxEYiv4/kTgBewXo3YHe/UWF4BUzBuZhT/vg57X8I
 bQbA==
X-Gm-Message-State: AOJu0YykOq7/RxezX/LSr8rwApzI48s0u2/RoKiIhODAvuv7VRvMwDPw
 DNjjzKI3kyZEz9G1Sm/OxZteGP22lYjYs/vugCA=
X-Google-Smtp-Source: AGHT+IGKF40QIV69DWwxTvDyEp8hMpVezuaP1v1XPmkn17+BFPp8vleSTB4JMvDtBjBt/DjOGZzwoQ==
X-Received: by 2002:a17:907:75e5:b0:9a9:ef41:e5c7 with SMTP id
 jz5-20020a17090775e500b009a9ef41e5c7mr4957205ejc.8.1694717909682; 
 Thu, 14 Sep 2023 11:58:29 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a17090690c400b00992b1c93279sm1351396ejw.110.2023.09.14.11.58.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:58:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/11] accel/tcg: Make cpu-exec-common.c a target agnostic unit
Date: Thu, 14 Sep 2023 20:57:17 +0200
Message-ID: <20230914185718.76241-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

cpu_in_serial_context() is not target specific,
move it declaration to "internal-common.h" (which
we include in the 4 source files modified).

Remove the unused "exec/exec-all.h" header from
cpu-exec-common.c.  There is no more target specific
code in this file: make it target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 11 +++++++++++
 accel/tcg/internal-target.h |  9 ---------
 accel/tcg/cpu-exec-common.c |  3 +--
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/tb-maint.c        |  1 +
 accel/tcg/user-exec.c       |  1 +
 accel/tcg/meson.build       |  4 +++-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 5d5247442e..3b2277e6e9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -9,9 +9,20 @@
 #ifndef ACCEL_TCG_INTERNAL_COMMON_H
 #define ACCEL_TCG_INTERNAL_COMMON_H
 
+#include "exec/translation-block.h"
+
 extern int64_t max_delay;
 extern int64_t max_advance;
 
 void dump_exec_info(GString *buf);
 
+/*
+ * Return true if CS is not running in parallel with other cpus, either
+ * because there are no other cpus or we are within an exclusive context.
+ */
+static inline bool cpu_in_serial_context(CPUState *cs)
+{
+    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
+}
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index f9eec1ce28..932bbe4b63 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -90,15 +90,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
     }
 }
 
-/*
- * Return true if CS is not running in parallel with other cpus, either
- * because there are no other cpus or we are within an exclusive context.
- */
-static inline bool cpu_in_serial_context(CPUState *cs)
-{
-    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
-}
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 55980417b4..b6cc387482 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,9 +20,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
-#include "exec/exec-all.h"
 #include "qemu/plugin.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 bool tcg_allowed;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a912d746a9..400d9ee0d0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,6 +35,7 @@
 #include "exec/translate-all.h"
 #include "trace.h"
 #include "tb-hash.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 85cf51445d..b194f8f065 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -29,6 +29,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f925dd0305..5bf2761bf4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,6 +29,7 @@
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
 #include "tcg/tcg-ldst.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 __thread uintptr_t helper_retaddr;
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 4633a34d28..8783edd06e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,7 +1,9 @@
 tcg_ss = ss.source_set()
+common_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cpu-exec-common.c',
+))
 tcg_ss.add(files(
   'tcg-all.c',
-  'cpu-exec-common.c',
   'cpu-exec.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
-- 
2.41.0


