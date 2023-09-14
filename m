Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2C7A0D9A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXn-0008GS-2x; Thu, 14 Sep 2023 14:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXc-0008Dj-HQ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:16 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXZ-0007hx-DL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:15 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-502e6d632b6so1820060e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717891; x=1695322691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6XhQZvVBgWC3+5NPxxq2ysGkpZ/RJnJQOM81+rYNCU=;
 b=edF1e7CcdB8GQiaqS08m0eSaRV+oIC9431bmr6LlW5PrBliLA11KGDzluloDPejeDw
 npxKc7RRaDlY+ORzJizuKwyGehvLZ/T5vYq3MbUY9+M70/1cpNX+l1cfnHGfEmVOcFHW
 WQc689ufhgZnWy6ws+QxGbhIA2meNxoxkXRLFv5vdg4mf67SxfXwPK2rDZU5nIezbpcM
 FeKWEAyyNoypqC0vbkRsgt/l1LAIAPrEaiCKbvqnjleVI2Z3DLGaMWwR+3ZX9j3jmQf4
 ezlbYO328CzxAH8lHOeXnpSZ6hCgbShpKj+f61mEl8Mp7zahskhMWfh6i2xRLZbtzsDZ
 hUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717891; x=1695322691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6XhQZvVBgWC3+5NPxxq2ysGkpZ/RJnJQOM81+rYNCU=;
 b=Il33jqw6/V1NUW210s0H7fkL/b/2xDfXpYoCzZR0pxG3YG9ENozXk7xH6oLSopyPK2
 Z6ZExclhq+D3UwkjZiHUVmJtFMOUqDcrqqt50nUXGp7ern6/JLnT3f8kgdfy8HrhNBfG
 RMAZhifAwftEREueIQHQJ5frQqI9FWS8Nb25rhlRRksZ0aIIE/sbKcJx/3dOX/PMUI6p
 SYAypsWP1+lsAThFQ6peDhr49S55CRd40hNITfBSvmelff30PMAoDWEXF4rYTQjX0Gea
 zq57rP2lg4xeTqiyoVY4TBvLVGBeDPX4viIhv5w3P2S3uTsrNJ7QB9nlvMQHgB9LMdCb
 HkPw==
X-Gm-Message-State: AOJu0YyfkQx7dg8XZ+/qHm3Q68DRoUwlAYJz2/uIBVwPmuJU2AWNCwEp
 9oHt9KGqzyP9MvpRzI3kGakszEcRoV/ii4dtEWo=
X-Google-Smtp-Source: AGHT+IHC34KyrCVfawNGi1ABBB1sIvfem2FX8Jyt9TTVwAukqyD6G7zNvyZsmiqk2z47qQ8qTlaivg==
X-Received: by 2002:a05:6512:1151:b0:4f8:74b5:b4ec with SMTP id
 m17-20020a056512115100b004f874b5b4ecmr6051126lfg.41.1694717890738; 
 Thu, 14 Sep 2023 11:58:10 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a1709063f9100b0099cbfee34e3sm1370102ejj.196.2023.09.14.11.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/11] accel/tcg: Rename target-specific 'internal.h' ->
 'internal-target.h'
Date: Thu, 14 Sep 2023 20:57:14 +0200
Message-ID: <20230914185718.76241-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

accel/tcg/internal.h contains target specific declarations.
Unit files including it become "target tainted": they can not
be compiled as target agnostic. Rename using the '-target'
suffix to make this explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/{internal.h => internal-target.h} | 6 +++---
 accel/tcg/cpu-exec-common.c                 | 2 +-
 accel/tcg/cpu-exec.c                        | 2 +-
 accel/tcg/cputlb.c                          | 2 +-
 accel/tcg/monitor.c                         | 2 +-
 accel/tcg/tb-maint.c                        | 2 +-
 accel/tcg/tcg-all.c                         | 2 +-
 accel/tcg/translate-all.c                   | 2 +-
 accel/tcg/translator.c                      | 2 +-
 accel/tcg/user-exec.c                       | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)
 rename accel/tcg/{internal.h => internal-target.h} (96%)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal-target.h
similarity index 96%
rename from accel/tcg/internal.h
rename to accel/tcg/internal-target.h
index cd6b9eb7f0..4ce3b29056 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal-target.h
@@ -1,13 +1,13 @@
 /*
- * Internal execution defines for qemu
+ * Internal execution defines for qemu (target specific)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef ACCEL_TCG_INTERNAL_H
-#define ACCEL_TCG_INTERNAL_H
+#ifndef ACCEL_TCG_INTERNAL_TARGET_H
+#define ACCEL_TCG_INTERNAL_TARGET_H
 
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 8ac2af4d0c..55980417b4 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -22,7 +22,7 @@
 #include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "qemu/plugin.h"
-#include "internal.h"
+#include "internal-target.h"
 
 bool tcg_allowed;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0e7eeef001..f5625e047a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -42,7 +42,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 31e34700ea..a912d746a9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,7 +35,7 @@
 #include "exec/translate-all.h"
 #include "trace.h"
 #include "tb-hash.h"
-#include "internal.h"
+#include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index d48de23999..30724fdb98 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,7 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal.h"
+#include "internal-target.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 32ae8af61c..85cf51445d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -29,7 +29,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 03dfd67e9e..b32e0b80ec 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,7 +38,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #endif
-#include "internal.h"
+#include "internal-target.h"
 
 struct TCGState {
     AccelState parent_obj;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83e07b830f..6c09b7f50d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,7 +61,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index d9fcb4cbe8..65219b52eb 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,7 +14,7 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
-#include "internal.h"
+#include "internal-target.h"
 
 static void gen_io_start(void)
 {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 17f9aff0cf..f925dd0305 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,7 +29,7 @@
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
 #include "tcg/tcg-ldst.h"
-#include "internal.h"
+#include "internal-target.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.41.0


