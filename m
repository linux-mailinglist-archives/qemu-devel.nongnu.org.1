Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A313705818
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0dR-000148-5D; Tue, 16 May 2023 15:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000Ll-Eb
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cC-0003lH-EW
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:48 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2533b600d35so58243a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266343; x=1686858343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joEze47TBGXX0770sgjaIGXAA3+n4j9+h7GefAjVJ1s=;
 b=ZBc/Uc7lvnUykiQfXp7OzLqGjzVFcGIdowXxpO0wzpKIVCpmpxb3epYMg3Pua/pTKL
 CqEr99hKM8O7iBrZSq7muMH05QotI4ivaBSZ/Sppbt72xu6SzXf5TJMGgjYVeYkfI9cO
 kAitAC8+I6Gmulnanu8hubq9E0zlzVL9PZR+6VXkDsc7Zq8N6yfPRCvky7lGOLZzBqD9
 6UAf/toWK7GIRX/XXybLoWFQxKWJEcV/IgIxnxayKLVPubNmzcZyBSRslU20wXD6lkGX
 0pr9rU2FtqORlgHKTri2m8bDQnnm7fKFj8I1W1dA5CNDzMEgGnmBfiDj9ruqjyVsKmYG
 qiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266343; x=1686858343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joEze47TBGXX0770sgjaIGXAA3+n4j9+h7GefAjVJ1s=;
 b=SaFDC+7Z0pE0Wbo0uFXqueIJhGrQjBy3BqkhIpJlHJhTxGzNiYo1nrve998WuunKRs
 cHnDZH7qRxT/MukH9/eGqC4mV6iu5I7LO6XCASxAyNeNVGK23sVahsde7DzJ0VGOkxFb
 jX5J61DDJz846JO/o4RvvdAhGdSwED8ykKW+7K5W04uT2U07gu/9dYV2ZCkOsK/hV19R
 OZivfqB4/aPBBq4BgN5BScW75wG9JvchfJlK3eBf419BoQFkXjEZLNpzmxpbjrtbUPUs
 HlhimQBfzxE2jBTyYmcIpRpuhFn61NoA7kKJa9BBWixKO46jVDweyyL2XLLhxVIuhzfd
 1XnA==
X-Gm-Message-State: AC+VfDx4ptlGadp3X6YSlOzLM1JADHPKZdkVhNJyobaz4Sb9FN2CPTQh
 XJFpqY2mUJcrlSa20E2TDJP0tGH5m544z8GfTw0=
X-Google-Smtp-Source: ACHHUZ4mQ1RuLz6gPXv0DbR3jTARZwECXbL4gNYCn4DyXRKhjfIz2fbGu9AIJ4NIC68xVE3duv4F0g==
X-Received: by 2002:a17:90b:2313:b0:253:2dc5:4e12 with SMTP id
 mt19-20020a17090b231300b002532dc54e12mr2463204pjb.46.1684266342887; 
 Tue, 16 May 2023 12:45:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 63/80] tcg: Add addr_type to TCGContext
Date: Tue, 16 May 2023 12:41:28 -0700
Message-Id: <20230516194145.1749305-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

This will enable replacement of TARGET_LONG_BITS within tcg/.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         | 1 +
 accel/tcg/translate-all.c | 2 ++
 tcg/tcg.c                 | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 42a3c05607..b9748fd0c5 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -558,6 +558,7 @@ struct TCGContext {
     int nb_temps;
     int nb_indirects;
     int nb_ops;
+    TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
 
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7b7d9a5fff..99a9d0e34f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -356,6 +356,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_set_page_addr0(tb, phys_pc);
     tb_set_page_addr1(tb, -1);
     tcg_ctx->gen_tb = tb;
+    tcg_ctx->addr_type = TCG_TYPE_TL;
+
  tb_overflow:
 
 #ifdef CONFIG_PROFILER
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 800dcba159..dfe5dde63d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1520,6 +1520,9 @@ void tcg_func_start(TCGContext *s)
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
     QSIMPLEQ_INIT(&s->labels);
+
+    tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
+                     s->addr_type == TCG_TYPE_I64);
 }
 
 static TCGTemp *tcg_temp_alloc(TCGContext *s)
-- 
2.34.1


