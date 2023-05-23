Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0D70DEDA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SUj-0000nZ-B5; Tue, 23 May 2023 09:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSd-0005EO-84
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:54:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSb-0003Ad-Kn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso3393964b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850036; x=1687442036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v5+X8dtE6LfSMMjI2gnNlBbQTFJOMR9qw0ZxeW19zPE=;
 b=GXFj6UcZMGR+KV/DlZBqEsMGxJSTa8FyC0Q7WbHOl6WoIYDP/0RCJw5XiOCpeuxyMa
 PKZGjGFVVn7Eg4Fky+VbsTCecjPxX2hbHo/ZZj65X6y3f2skqsrBSpTMnOjR3FuR8W+g
 VCtaEhvZiE2h0xvZqQgov5tUlCuu1ixZ6jua+eIXvuYbuZJJQNdImdoEvXlTSp/EiOg4
 PLgfFFODjNjLnDgSeLiou7U6/g9SpWqLfYzxcl3L0srXvPmKt1rY4WfjZg8zS8Ahu94f
 15OIqDSM388d5HoY0NGFVSenYjptnTUgzyMMi3AP/txKSjUaa2NpjCxFPpcpAsfnVKjo
 NtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850036; x=1687442036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5+X8dtE6LfSMMjI2gnNlBbQTFJOMR9qw0ZxeW19zPE=;
 b=f5QfqZEVuWhp43RYpnhLWrCLRHMNKrGjtnAvAnte+W0egDBKtUHseyK10U9Yybli4j
 JO7IV5KS8lpaF1bnub3EYI9CLahvQKsgSEPc9OOToHpBZdywMjF0+RakrUXamsKFHhev
 gi09a0Dd3cNJjZJ2eSljQHEhYf44p4HiapWnazdZ8aKUvyC88WC/H+gZwHsfOWTUZuVd
 Izwrhmkkw35zFADta5JF/1dakWB5F/CKnS3iBB0t8Hh68Kd1VFo/RFLKKBLhat3cfrCu
 HkNLVCirXUnU+oMp5/+NszEzWXQAZcV8wrItuiqrER9GjHkjw/gK3N2huMJn/bqkFdVP
 eDPg==
X-Gm-Message-State: AC+VfDzJ4Xih893yOaC76mx53BDW9FyLTaSQPmYf88Q0qfqL5JL6HL4O
 6QbH2UAMP4yDpjR9OD97KzFKuH0nhuab6nOSi08=
X-Google-Smtp-Source: ACHHUZ7up5OrB2k2f71H/sWNQfczo3LuNteiaghh6GGR1JXofE/8Dejlw278yWR8EvKoC9WvrJeZtg==
X-Received: by 2002:a05:6a00:2282:b0:63f:18ae:1d5f with SMTP id
 f2-20020a056a00228200b0063f18ae1d5fmr20543890pfe.29.1684850035887; 
 Tue, 23 May 2023 06:53:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 39/52] accel/tcg: Move translator_fake_ldb out of line
Date: Tue, 23 May 2023 06:53:09 -0700
Message-Id: <20230523135322.678948-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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


