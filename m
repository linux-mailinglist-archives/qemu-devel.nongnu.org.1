Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC837230F6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GdB-00029l-Dd; Mon, 05 Jun 2023 16:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcs-0001xk-Fw
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcq-0003nm-LD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-650c8cb68aeso3084716b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996182; x=1688588182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rPTbSJPGH0y4Jg73winpnz5u/arUPeju4H53hE/UCY=;
 b=tIG85YixUtxsTJ/6bY1XfZ/jlwG1I2G6pBtjeUjgPfux6qxf0UfYMPfB8+bS7+j+cS
 er5TrZq9nLmieAM9/12Mhxbo3oLUzQBwnBoUzknbdE89OzQmYnNUZSKyoTsaEusqk1vE
 3WUDiwleU6CRWiXaMOdo/kXvscrI123TSx+0BY+P0B1ZC4aJ8mZtCaaW3aI8mrIclRDG
 HHhyhJdGCqZz6mEnSKN2+8arVt4CU6+md/oWJCciIOwYwf5NnKcKui46XBlZ+w2XDK+/
 zXBD1mb6ZFUnxvwKF1GkoD/VKVxJOlUYURyUcHUAYlb4QLXM7dEYLK1mq0GU7JfL++g+
 tIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996182; x=1688588182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rPTbSJPGH0y4Jg73winpnz5u/arUPeju4H53hE/UCY=;
 b=RDFQI9pGMeIULGClxjQV0F9ufDHx67E/sJIrues7Azv0xfGqI5DnQRQ+1J8klx63nC
 4t2u74+aAfKjyKX65bKEHLHWrBsRrauCy8vkpxq+i37ngi8t2Q8KtMwJbuKEI0sTYQtr
 Vn6aVV+kedGpTGNYMgoCAQQ/hpAFN8+WZW38dS9oO53mZuJunubTeplUe2HPbuY+FWGs
 +/Ja/QYiKpD0EpE+gXjbE8Bj4/RSIhqnpxTxaIanpsXwFvu5WmX4BTALJeSSHpTKL9UW
 AC2vEIAXNkpq3npEHQ5uv7twIF4Yuww0DaVMgO8pCYj4/nY2cyUz9ujVrXENewhVLUxQ
 Nsig==
X-Gm-Message-State: AC+VfDzX90Uzywk25zP/Jfac/PS5U9puUKYGh6ojRcBRk2uV/h4OcB6z
 HXj+3uo/OsYnxw5vbltx54IftF2aqNsZJz92ujs=
X-Google-Smtp-Source: ACHHUZ4c1kT9pylDGW8OsRWHBDuQAsHA9xZ+sA7+41PyL4IbcYxHjFi6bGYa+67Hb97nAcID6fXYug==
X-Received: by 2002:a05:6a20:e18f:b0:114:7236:9777 with SMTP id
 ks15-20020a056a20e18f00b0011472369777mr129779pzb.21.1685996182679; 
 Mon, 05 Jun 2023 13:16:22 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/52] accel/tcg: Move translator_fake_ldb out of line
Date: Mon,  5 Jun 2023 13:15:34 -0700
Message-Id: <20230605201548.1596865-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


