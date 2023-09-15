Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF97A1AEA
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5KI-0001m3-10; Fri, 15 Sep 2023 05:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5KE-0001ln-2c
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:41:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5KC-0000e4-D7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:41:21 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so2189305a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694770877; x=1695375677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIu2ocilQq5vP7WdRJFP99+NTs9YWbgGeSYR/hElyzM=;
 b=r4NjXcKAN3i2mQymMqEvhpsQofHX6Bg6E8adshWXsZcZfbyoCT3NmzzwPl6RgYkw76
 v8sWud+H8wBoUjlIQiqJ6vJ1dUKWHLeVsO8Mi6LteH/4xYif6LbnGOkM/c9OcsL8hAlM
 8OP4foL9R1JwF0ky2Kvz+7ZwXI2BI31o0rlU9p/neHhfHP2Wzi8iGVNkYVoUnBv9ylzG
 UIX7isJyeOqarO4ReqoS+fyJhQMB21BFatuzgMwj7mYEIw8wocYfe3npSrQ1MKjKfbhg
 bE9uXqLDX910+8E5VUP4B92tu7/FJfEN6kWApj0/NLqn6eptqScf5tIbRuw9BlDUYFg6
 5mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694770877; x=1695375677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIu2ocilQq5vP7WdRJFP99+NTs9YWbgGeSYR/hElyzM=;
 b=PZGZdNCvXVrFIRvQbJ2yb5CyN9Z26P6RT2G/CuSzGGffQ4W2YkW1WZX6zM4886IGBk
 aIuT+ZrIfRb2IhcPaz6IOaE1HrQiFSupMT2VGhxxc5q/rRp7De8YY2dtE+vZNYsNrTID
 uClT+ojzY3oyeVlu1xsuGPTsGtF4NLVoOYmFaVUQX2ExCOMeMTWleB2ODdUuS29TeCOv
 FUgu52w3J3mJh36KNs+PIwylPtcVOMoFcq46ZNw9ssD27Y3/NzHe/DLuNfxoTKJklgWP
 wuym7IIUrIlaKLvTsnQTn82mx56JvCPJiqQVHrOIaP49C57LMWjFVJfninLMgbCTnArK
 jboQ==
X-Gm-Message-State: AOJu0YysRTRYxPjroPQpdZuEPIeClw4Yql3b9zQKmhq+oSV7JZSyYhtM
 24UR/M9/0RpmciaQeOIg0UsdNFEFr9z5DBBEt5Q=
X-Google-Smtp-Source: AGHT+IFwYBtNhrErlqaXDo9hpYT9N+9RMEqEuAlTElPIxs3KZC9inayRbmOtMQ6tBDWODqVuW3ZfQg==
X-Received: by 2002:a50:ed11:0:b0:52c:164:efe4 with SMTP id
 j17-20020a50ed11000000b0052c0164efe4mr888892eds.34.1694770877557; 
 Fri, 15 Sep 2023 02:41:17 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 o7-20020aa7d3c7000000b005233deb30aesm2022015edr.10.2023.09.15.02.41.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 02:41:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6: 2/2] accel/tcg: Track current value of can_do_io in the TB
Date: Fri, 15 Sep 2023 11:41:09 +0200
Message-ID: <20230915094109.82757-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915094109.82757-1-philmd@linaro.org>
References: <20230914174436.1597356-4-richard.henderson@linaro.org>
 <20230915094109.82757-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Simplify translator_io_start by recording the current
known value of can_do_io within DisasContextBase.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230914174436.1597356-4-richard.henderson@linaro.org>
[PMD: Split patch in 2, extracting set_can_do_io() first]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translator.h |  2 ++
 accel/tcg/translator.c    | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 4e17c4f401..9d9e980819 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,6 +72,7 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
+ * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -83,6 +84,7 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
+    int8_t saved_can_do_io;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cebf0a84cc..850d82e26f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,9 +18,12 @@
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
-                   offsetof(ArchCPU, env));
+    if (db->saved_can_do_io != val) {
+        db->saved_can_do_io = val;
+        tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
+                       offsetof(ArchCPU, parent_obj.can_do_io) -
+                       offsetof(ArchCPU, env));
+    }
 }
 
 bool translator_io_start(DisasContextBase *db)
@@ -30,10 +33,6 @@ bool translator_io_start(DisasContextBase *db)
     if (!(cflags & CF_USE_ICOUNT)) {
         return false;
     }
-    if (db->num_insns == db->max_insns && (cflags & CF_LAST_IO)) {
-        /* Already started in translator_loop. */
-        return true;
-    }
 
     set_can_do_io(db, true);
 
@@ -144,6 +143,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
+    db->saved_can_do_io = -1;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
-- 
2.41.0


