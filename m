Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218697E340C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CUt-0006a3-9Q; Mon, 06 Nov 2023 22:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUq-0006Wr-JY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:20 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CUi-00025A-Hd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:11:20 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b9390d6bd3so4890797a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326669; x=1699931469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kd6/eT9J299b8JKalao90u4vBcVmHm6G2kVANEbq6n8=;
 b=lSoMuNf4Kf4csjnzWA7Hz32AsJMqIS/T5EpNmBgb7LMYfdf1WSfuhb+L168DRbZWoi
 GzzvSlvpht2nG7FPdDpzgwE216DBeonyb5QZ+kxAMg2gIVwGrbquxEw9SE0ITXVdNAvV
 dHSgcal4xWdtMb4pUJgGa8t0US0/yJHPOCi85QwK9q/5/r/CqJmr8PnW42r8r5JJmrPb
 6sYuTA6ZlNjYDL6bKn+niar0DOOK4/KhyTLbpFTkWIH6FTfiYpRXhd3b7S51T40PsR+B
 GPDgKKrHr7Td9RITU5RWX9l609s2dG025Fs5M6HThCTTRLMMenADq/JHxRLHQpjiCJuJ
 Rt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326669; x=1699931469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kd6/eT9J299b8JKalao90u4vBcVmHm6G2kVANEbq6n8=;
 b=WDTcUW+kXeLWNx4StFfACJZEst2WLqdU3BICXrO5wPoy2ymcatBfErgE9UCy4nSWcN
 siwpxY4wEY50h707hkarEGxah4vaBZm7yAtCDO57EplN+q2cpQ9rMi06HVjwF+sJrgF+
 u/vdXH5WNKdh8zF0A5BlxGfhjSnR/QQC9P/PJwgELodc9HjVGtHsla4jx7CUxyMSCY0t
 QnXYIYuoi2oEoHGJFrZiDtWgs6pckiBi9xklnA/lK0C91AecP2Zp2i7xp0XDY1Czb48e
 8hUwTOi6CBlMpwxbzmX6oHT30ZIFL6D8jLpKDNGueobqZa03kSwjLTYzVc3kBomOGBBd
 0hgQ==
X-Gm-Message-State: AOJu0YwMCQIjSxA927T5pk/za2CyP5Vuf9aFeyJ9KIwaU32wXrWf0e84
 2FG11YqulYsGYgciTWQnilw1f+q+YAGS5v/p2G4=
X-Google-Smtp-Source: AGHT+IFAPF8Oo/Z47Az8vadRUXQvx6r2dxuwShRxLoxIWZ4zbtZPe7/dR1r80sck16r00W+SMGW2KA==
X-Received: by 2002:a17:90a:c70d:b0:280:37a0:69d4 with SMTP id
 o13-20020a17090ac70d00b0028037a069d4mr1884574pjt.19.1699326669210; 
 Mon, 06 Nov 2023 19:11:09 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gw13-20020a17090b0a4d00b0026f4bb8b2casm6246253pjb.6.2023.11.06.19.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:11:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 81/85] target/hppa: Improve interrupt logging
Date: Mon,  6 Nov 2023 19:04:03 -0800
Message-Id: <20231107030407.8979-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 54875442e7..467ee7daf5 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -258,14 +258,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             snprintf(unknown, sizeof(unknown), "unknown %d", i);
             name = unknown;
         }
-        qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
-                 " -> " TARGET_FMT_lx " " TARGET_FMT_lx "\n",
-                 ++count, name,
-                 hppa_form_gva(env, env->iasq_f, env->iaoq_f),
-                 hppa_form_gva(env, env->iasq_b, env->iaoq_b),
-                 env->iaoq_f,
-                 hppa_form_gva(env, (uint64_t)env->cr[CR_ISR] << 32,
-                               env->cr[CR_IOR]));
+        qemu_log("INT %6d: %s @ " TARGET_FMT_lx ":" TARGET_FMT_lx
+                 " for " TARGET_FMT_lx ":" TARGET_FMT_lx "\n",
+                 ++count, name, env->cr[CR_IIASQ], env->cr[CR_IIAOQ],
+                 env->cr[CR_ISR], env->cr[CR_IOR]);
     }
     cs->exception_index = -1;
 }
-- 
2.34.1


