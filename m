Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E757A1AEB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5KC-0001lR-Qh; Fri, 15 Sep 2023 05:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5K7-0001kA-MY
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:41:15 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5K6-0000d1-0m
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:41:15 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a9d82d73f9so237306166b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694770872; x=1695375672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKB6i1a2Yf+Z+ixpNmbbmyHoSOgE6srsg9geAh24tEo=;
 b=NhAz04SUeTyUKiLhH++IXVolxZ5v5/GSpRC2MRGvAQBv22aSDLcMp1mtlWShnlG0Uf
 RcTwLnul59EPyfpOpdSWfq8xJV8/NWLNElc8mocRw8i3TNPywMHvgYXOBiw8gLKo60iL
 lkLe4DKiaxn2KJtvjTjvp6p59vENw3KUVNfoKPaJUinEN9UY6aASok8wUVPrpssnZV8u
 0KL9wV5fABIAAQZ0n53v49z4tGFUFlj2Sxl1XWbakl9jYJeuXBO59eJVqXiSEu2hzJDw
 b8eezZA1f7DgqytegSVE6ClJUVse2S7inb0RK683UlhdmQBrBnBcv+KLun8nTM683FEe
 WGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694770872; x=1695375672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKB6i1a2Yf+Z+ixpNmbbmyHoSOgE6srsg9geAh24tEo=;
 b=weynLDz0cnjqhco6yPLKYmu2CO8TR///pE9o2s/4Itap7WHsuuSjhXLYIWMili1rsT
 ok+NppBLH8lopEUiu8EKqvrL611fGX215g8RoVwF97wVfqa4iBMkRCJvFljUfKjF4uvj
 jt4n6jaOyxJAVcQtmfdblfACV6Xlb2b/hrhrmVRiuA9QdajkNmtb4LR3X80HQ+a/m8ya
 rpuMiVy3N4ykYwUii3lGMsGSSgiiw5Eiy9DJkVwAgybyBGLmTD6AfZ3NzavbYOTEjE14
 v8OLpOZ6OOe72y1dDcEEKniOusyQZh2DX8LytgXUYmrc1KtoRe3AQpMyM9FZ6rqnKcQp
 xPAQ==
X-Gm-Message-State: AOJu0Yw9qHTLy34rJT+mMZJvkMvEYQBSoGSUtyWaWtWECfsX8nKQBmij
 2ZJNigAgiTmo5iAUqDjdrVxVp996qhx1HPJYAuw=
X-Google-Smtp-Source: AGHT+IHMua0kXMs+CT6573NXMVTjtIFyMEqAxnfXet5wx6RqT8IZFtyFSqAZONgxfdz+rbP0L5Lc1w==
X-Received: by 2002:a17:906:15b:b0:9a1:a134:8cb4 with SMTP id
 27-20020a170906015b00b009a1a1348cb4mr927969ejh.32.1694770871969; 
 Fri, 15 Sep 2023 02:41:11 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090655cf00b00997d7aa59fasm2211850ejp.14.2023.09.15.02.41.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 02:41:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6: 1/2] accel/tcg: Refactor gen_io_start() as set_can_do_io()
Date: Fri, 15 Sep 2023 11:41:08 +0200
Message-ID: <20230915094109.82757-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914174436.1597356-4-richard.henderson@linaro.org>
References: <20230914174436.1597356-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230914174436.1597356-4-richard.henderson@linaro.org>
[PMD: Split patch in 2, extracting set_can_do_io() first]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translator.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index b6ab9f3d33..cebf0a84cc 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,9 +16,9 @@
 #include "tcg/tcg-op-common.h"
 #include "internal.h"
 
-static void gen_io_start(void)
+static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
+    tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
                    offsetof(ArchCPU, parent_obj.can_do_io) -
                    offsetof(ArchCPU, env));
 }
@@ -35,7 +35,7 @@ bool translator_io_start(DisasContextBase *db)
         return true;
     }
 
-    gen_io_start();
+    set_can_do_io(db, true);
 
     /*
      * Ensure that this instruction will be the last in the TB.
@@ -47,7 +47,7 @@ bool translator_io_start(DisasContextBase *db)
     return true;
 }
 
-static TCGOp *gen_tb_start(uint32_t cflags)
+static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 {
     TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
@@ -91,12 +91,9 @@ static TCGOp *gen_tb_start(uint32_t cflags)
          * cpu->can_do_io is cleared automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
          * -icount, plus it would be very easy to forget doing it in the
-         * translator. Doing it here means we don't need a gen_io_end() to
-         * go with gen_io_start().
+         * translator.
          */
-        tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
-                       offsetof(ArchCPU, env));
+        set_can_do_io(db, false);
     }
 
     return icount_start_insn;
@@ -154,7 +151,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
     /* Start translating.  */
-    icount_start_insn = gen_tb_start(cflags);
+    icount_start_insn = gen_tb_start(db, cflags);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
@@ -181,7 +178,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
            the next instruction.  */
         if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
             /* Accept I/O on the last instruction.  */
-            gen_io_start();
+            set_can_do_io(db, true);
         }
         ops->translate_insn(db, cpu);
 
-- 
2.41.0


