Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC94B74EE01
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCHf-0001tL-7r; Tue, 11 Jul 2023 08:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHU-0001dW-IA
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCHS-0005RC-Vp
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:15:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso69820175e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077745; x=1691669745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5G3GZnisObOugerwvl7UVGEu2t0avWriP2R6IveebM=;
 b=kge+DJugi3Ip1PTq2RHq6xtcXNCW06cHgoelEoqZBrxLIAIDdLgT0x1I/uAmZt++1f
 GaWx10+CyZYMHh0NB833UgtYxnuYHtkL5KTrOOBAXhH9x1wwsTPUp7eJuZD3Pj5LDI6u
 f5uquS81Rj0Rq85Aii532SjV7k2eMZ5ehJxHEsMtKN2qn7x7h43S1/2ubVyQUaluDJ6p
 Cb0zmMt3wFkfDWnCv19sPDBxHR0iPTBfDfEzn9njUvd+HBl5Gxda6IHaLVurMg1tlynS
 8X13qRsIlcbvS+nHJZ6b/B+2rIntRY0CZOR5cZn/whYc8EAwQxP5BlWDxgwIP9RttZgw
 HYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077745; x=1691669745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5G3GZnisObOugerwvl7UVGEu2t0avWriP2R6IveebM=;
 b=GAHwQ7FFqeE8c8ds7wDJuAO/DbYqNyG/nKGCQVLcLcFfBvB/oLGHgPDsW8pA7wYwW7
 F+mxr0MQEsS9sKLCxtt+v8Gia8moKK3eWkVCFXwS1WQ4fRcYbfDMNmWTFRHXSA3FEguM
 DgzIOrdZAiXteJcUQ895AOFoUVns/Fn5d3Vs01Bx5aiw0wskYecdKNytxMgDz0agFnIF
 kkGsEMkLjW5dNaWtNw83gmPQgCpMHFi7SzQ0PVjGp+IexGUkORFE5mfcRnktR2607rx8
 f4pGnkYu9N1oDSHxMEFTCtiyk4lm8GTS4kkXKIAe3qJz89aNNeeH225qAX1gYZkyiNXg
 K5lg==
X-Gm-Message-State: ABy/qLZSgQ3FnxgqER6dnYpCzpdF/MJqF6yc9ohB9/i99Vx6SB0XX04B
 ELVWxdNYxE6UWowl7Yh4GAelPobzEFnm8G9xea8=
X-Google-Smtp-Source: APBJJlGqayx4zNOvTBPhhYVL46Xrdlxtz3A74TFLOdys7K+PsbAYqNJQUHRfYMq/1G2p6BqMXSKdbA==
X-Received: by 2002:a05:6000:1b0f:b0:313:f68d:acf9 with SMTP id
 f15-20020a0560001b0f00b00313f68dacf9mr18507990wrz.10.1689077745461; 
 Tue, 11 Jul 2023 05:15:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe891000000b003143cdc5949sm2174649wrm.9.2023.07.11.05.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:15:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/16] target/riscv: Expose some 'trigger' prototypes from
 debug.c
Date: Tue, 11 Jul 2023 14:14:46 +0200
Message-Id: <20230711121453.59138-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

We want to extract TCG-specific code from debug.c, but some
functions call get_trigger_type() / do_trigger_action().
Expose these prototypes in "debug.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/debug.h | 4 ++++
 target/riscv/debug.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index c471748d5a..65cd45b8f3 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -147,4 +147,8 @@ void riscv_trigger_init(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
+
+target_ulong get_trigger_type(CPURISCVState *env, target_ulong trigger_index);
+void do_trigger_action(CPURISCVState *env, target_ulong trigger_index);
+
 #endif /* RISCV_DEBUG_H */
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..5676f2c57e 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -88,8 +88,7 @@ static inline target_ulong extract_trigger_type(CPURISCVState *env,
     }
 }
 
-static inline target_ulong get_trigger_type(CPURISCVState *env,
-                                            target_ulong trigger_index)
+target_ulong get_trigger_type(CPURISCVState *env, target_ulong trigger_index)
 {
     return extract_trigger_type(env, env->tdata1[trigger_index]);
 }
@@ -217,7 +216,7 @@ static inline void warn_always_zero_bit(target_ulong val, target_ulong mask,
     }
 }
 
-static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
+void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
-- 
2.38.1


