Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99C7A0DAC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrY1-0000mD-26; Thu, 14 Sep 2023 14:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXy-0000aw-Pp
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:38 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXh-0007jL-V2
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:58:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso166936366b.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717897; x=1695322697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8/rRDkqjHLNiQmWwYh6x6u6ajkv9cBUtG5tp1iGRHE=;
 b=avRAShtgPYzb8lrsiYEXtqGaamTUo5OPDxSen32lR2UTRkUUcKaNk/MEOLxF5Q2g+R
 MBzdkrbY2vhcWliC9kX0aLs7c3rohagPjqrJBBjDdW8l5/oJzRo5MGKozHQnAYUnUmkL
 bHbCZ2JEhvw3IJDo3U3hTpnsuYxOYo18GBNBb/TfpEuXuEi7GTFadt0vGydIOZ02SdRi
 9sClU+1v0Srk7atVVEB2c5OMafH4i/uvyhBCYRy2Cgw+3nKkRahGLNcq1gFksqVKaHw4
 g6CXED5SVYZa2jdHo6+TnMezBHpnRAKZaptL2YCEHDe1T37NirWO6fQk99q9E1Wc6nrT
 NWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717897; x=1695322697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8/rRDkqjHLNiQmWwYh6x6u6ajkv9cBUtG5tp1iGRHE=;
 b=WlDU7drf/Ef1acvjKYRHtMyoEMLSxwUjnuvQCYCMOn2yjhywNc02C1IHir72xt7ABI
 Z/kbtlDwvr0AfpVJZgnfnouG7XXkl2XFji0luW8q5W0C1Y3M+B3ygVcuHx+2BAkswMWY
 B0ff2SjVnTx0isjfvxWk9Oe7yA7g+3pB43OcE25AyYbCvkik9KRbhHuTN8H467RgRDtf
 LvdY4rip5Rsr47dLW6E1qhBcj4QkSSeBuPvIIlszTuvsG/xrKU60AYflaIMSbcT79yg5
 4t2YRe4ZropvcYofNyvW/aL8KPUHotJ2zaAWD5jtkA9ML1f6jlLjMVLhpBEm6RloUWV0
 FHlg==
X-Gm-Message-State: AOJu0YyvpFsiGDuy1wYa8hvTItD9W8xP5Xs4nARWKHHBRueggjFE9Xuc
 TbuEJHd5BADk8e8ViQYOFE1Sg3i9RGWjUwkrJ78=
X-Google-Smtp-Source: AGHT+IG/XpvEcRog6FuOJv2pRpZKwamHI/xgWOUk2v23W3koz2iNfzjLlyVU3tRLDGFR4EJrXqFk+g==
X-Received: by 2002:a17:906:5a5f:b0:9aa:20b2:35e7 with SMTP id
 my31-20020a1709065a5f00b009aa20b235e7mr5174112ejc.9.1694717897323; 
 Thu, 14 Sep 2023 11:58:17 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 qx15-20020a170906fccf00b009a5f1d15644sm1360132ejb.119.2023.09.14.11.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:58:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/11] accel/tcg: Make monitor.c a target-agnostic unit
Date: Thu, 14 Sep 2023 20:57:15 +0200
Message-ID: <20230914185718.76241-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Move target-agnostic declarations from "internal-target.h"
to a new "internal-common.h" header.
monitor.c now don't include target specific headers and can
be compiled once in system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 17 +++++++++++++++++
 accel/tcg/internal-target.h |  5 -----
 accel/tcg/cpu-exec.c        |  1 +
 accel/tcg/monitor.c         |  2 +-
 accel/tcg/translate-all.c   |  1 +
 accel/tcg/meson.build       |  3 +++
 6 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 accel/tcg/internal-common.h

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
new file mode 100644
index 0000000000..5d5247442e
--- /dev/null
+++ b/accel/tcg/internal-common.h
@@ -0,0 +1,17 @@
+/*
+ * Internal execution defines for qemu (target agnostic)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_INTERNAL_COMMON_H
+#define ACCEL_TCG_INTERNAL_COMMON_H
+
+extern int64_t max_delay;
+extern int64_t max_advance;
+
+void dump_exec_info(GString *buf);
+
+#endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 4ce3b29056..f9eec1ce28 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -99,11 +99,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
-extern int64_t max_delay;
-extern int64_t max_advance;
-
-void dump_exec_info(GString *buf);
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f5625e047a..95dd8a30cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -42,6 +42,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 /* -icount align implementation. */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 30724fdb98..caf1189e0b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,7 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6c09b7f50d..8cb6ad3511 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 8ace783707..0fb03bd7d3 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,6 +20,9 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
+))
+
+system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
 ))
 
-- 
2.41.0


