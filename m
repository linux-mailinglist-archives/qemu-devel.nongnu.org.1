Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40A735BBC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGL-0001Ps-T9; Mon, 19 Jun 2023 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFg-0000Yz-7H
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFd-0005EN-1l
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5193c97ecbbso3753504a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190227; x=1689782227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH3Dc3MYnhR8X77zbXMGBO+f7H+t3l8LmCN8dybEbDo=;
 b=P8TSQ4FEMknDpQxKe4swMqWz5HUWBIt4I1TLSKldHv4bPiA+bFLyWXoUaCjj1bNwFk
 AIJKic/4JS3Dnc1wuQxzga6eC6dDboxoxQU3ZS8lVP2CNlYzk34Docpb0WRpCvJIpkRs
 oQZRw9Iyw95mXxHiSzvmE24dccBg6t0x18wXTihH1NyIW0xfZ1zW+2EBvBeN4kzdf76o
 d6NDULLDcOnE+3yGAfMsKmvjOZoHvpg39k0rLWQhvRInYW2+7hn8RQPxdglLRF8VKqqA
 HL86l4rafPva6KbuRYEkE3NYv0ZTuhmyhEhFEk0VUb7zsOwWVGAo6fSAQ1+A0FTogZvx
 IBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190227; x=1689782227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QH3Dc3MYnhR8X77zbXMGBO+f7H+t3l8LmCN8dybEbDo=;
 b=Fs13gRnkcHGnsvk9mS464KejrLP3ZVhI1wAvc4fSOeZkMcK3Rfc+n+dfU/vg9rHdKY
 IYGYdqwlvMP5UkwvVy3VXtcCNKZ0fI1GG4PI5T+xQtXyV82Ts1TepQW8TuoSbGm4WfDx
 RKiUtXuLJfOKPN0+3+HfIhk7PhaKtsyJTpGzsGhnK42q7c6hykEsbdXkgiu+CLyZJ5vH
 Mz4gLz7i/WX9TzR/5v2OKXy1MYWVsqFnrnWl26vuc0qy9WORkKomkOPX3EE7w6q4rlMX
 IBU+6M4cGI1ta5CLJ6rrkIEN2RQsQeyVB6qyVm/igxn6gF6FhKWq1RGbY15OdIxk9WaZ
 YLsQ==
X-Gm-Message-State: AC+VfDyEN42ra8a9yl7yS3vTNVvxhbzzy/Bn+MrFxzcXN3S7rAAMrYvS
 UyJC5rWz/r9ayaXg/uRYNuJi6g7qHeDlal2sdN4LsQ==
X-Google-Smtp-Source: ACHHUZ4TRjWBVBRr0toEhN5iup/g3mMxXZIMfNcu5LkaJsY75+yRPpSG7ba9MqgDydCLfcixGwOQ6Q==
X-Received: by 2002:a05:6402:da:b0:518:7415:3b61 with SMTP id
 i26-20020a05640200da00b0051874153b61mr5386724edu.23.1687190227276; 
 Mon, 19 Jun 2023 08:57:07 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 o8-20020aa7d3c8000000b0051a575c76e6sm1726632edr.43.2023.06.19.08.57.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 27/34] target/arm/tcg: Reduce 'helper-a64.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:55:03 +0200
Message-Id: <20230619155510.80991-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of including helper-a64.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h            | 4 ----
 target/arm/tcg/helper-a64.c    | 4 ++++
 target/arm/tcg/sve_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c | 6 ++++++
 target/arm/tcg/vec_helper.c    | 5 ++++-
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 159ed9664f..aae2a38407 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -110,7 +110,3 @@ DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
-
-#ifdef TARGET_AARCH64
-#include "tcg/helper-a64.h.inc"
-#endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 6312238676..782b6b6e94 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -35,6 +35,10 @@
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
 uint64_t HELPER(udiv64)(uint64_t num, uint64_t den)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 79a42af591..64f744bf6a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
@@ -37,6 +36,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
  * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a3d4265f85..73697f0cc9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -58,6 +58,12 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 99f81df9e1..dcfb3cfc96 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
@@ -41,6 +40,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-a64.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


