Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3477174E5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4H-0007bz-4p; Wed, 31 May 2023 00:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D46-0007NV-06
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:02 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D44-0006IL-7n
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:01 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6af7d6f6f41so2394886a34.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505839; x=1688097839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v5+X8dtE6LfSMMjI2gnNlBbQTFJOMR9qw0ZxeW19zPE=;
 b=oiHuwtZiV0tKBCnBHdQ8QiM5x3S98W84A3Rck6yn4KRcivVLnOolxxvsPQRggerv/c
 A4WeRH1uSPkrFdBMznQjRqneATqDtlkeBiuFA/U7qQ4Pd81b3WDF+l8y9mBn9smC6y/T
 f6uT5In8dBg6sykSXgU2mh6x+O8AnGC9jKSRm+p1l/GU4nSbxEU7tvMrFN+IjHLejupX
 KrUlKgWr4Kdo8FjoCCLaCA9L4MS9sZIyITQXP4QO53FJZxfrC88B+PQNr5QUWY/ewsh1
 nJwjO//U8aFajQj7oeIieLECqF4pexQFbGBYQ/9pEhDOTLA4McwuDsSOpPvrqY6tV4Sx
 PXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505839; x=1688097839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5+X8dtE6LfSMMjI2gnNlBbQTFJOMR9qw0ZxeW19zPE=;
 b=C55Kq42hi9wdR1fJbKOEu98js6b0qhRCVoN52GsJ8UAaAqwprfnezS8erLqbR/I03I
 T/ACHbC5OTPGi/OAF+jxg2zSM6ybsTibwuR1k87tpDILxS/LR521yHbBq+C6BfrZ+RHB
 WKVIxI2ZtiNIybCWFMS5vjTFG9asZ/zDKDiIAVvOqNXe0rluIU12EqHqolZKx0SYPR88
 VmOGh7UcH6T1vnEbQqsgIPOu0FGzT6EYwNWuQdiyFiWYC4eJ/P6NhjK502zwnU4RpbEa
 uxbcU0tJGRD9ksvoyPPdsYKjnF4P9InCNgjqS2ZxMrW/f4QKrCXAGT/rNer6/Gzq+JPJ
 qjvg==
X-Gm-Message-State: AC+VfDyUjWDJh0qkjK1SBS0G+dAQ8ihMc/8xAgRhusZXBAbyXWHAHmKb
 1iDbXtYiLFIEhUN16OeEcpyDDxhrrdwePsnM0Pc=
X-Google-Smtp-Source: ACHHUZ5cUYa9WMNA0O5ZnMxbYWmwtRYlIalpMICUWCJVkiGpC/6RU4XI+N8h16ieBMqOFxi5kfdafA==
X-Received: by 2002:a9d:7396:0:b0:6af:9c49:c66d with SMTP id
 j22-20020a9d7396000000b006af9c49c66dmr977719otk.18.1685505839065; 
 Tue, 30 May 2023 21:03:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 36/48] accel/tcg: Move translator_fake_ldb out of line
Date: Tue, 30 May 2023 21:03:18 -0700
Message-Id: <20230531040330.8950-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is used by exactly one host in extraordinary circumstances.
This means that translator.h need not include plugin-gen.h;
translator.c already includes plugin-gen.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 8 +-------
 accel/tcg/translator.c    | 5 +++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index c1a1203789..228002a623 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -22,7 +22,6 @@
 #include "qemu/bswap.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-#include "exec/plugin-gen.h"
 #include "exec/translate-all.h"
 #include "tcg/tcg.h"
 
@@ -229,12 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-
-static inline void translator_fake_ldb(uint8_t insn8, abi_ptr pc)
-{
-    plugin_insn_append(pc, &insn8, sizeof(insn8));
-}
-
+void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
 
 /*
  * Return whether addr is on the same page as where disassembly started.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 7a130e706e..60a613c99d 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -345,3 +345,8 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, abi_ptr pc)
     plugin_insn_append(pc, &plug, sizeof(ret));
     return ret;
 }
+
+void translator_fake_ldb(uint8_t insn8, abi_ptr pc)
+{
+    plugin_insn_append(pc, &insn8, sizeof(insn8));
+}
-- 
2.34.1


