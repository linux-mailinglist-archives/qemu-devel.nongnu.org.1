Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BFB72331F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Icy-0008LJ-3A; Mon, 05 Jun 2023 18:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Icv-0008KI-PP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Ict-000602-Go
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:24:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so4311945f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686003873; x=1688595873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7qE+XF1sdC5qKTLQBPA7J0xIVj1iHbCF/ZSK/gcraw=;
 b=TkiOyJWvy3drsZuKtR3vKHprfSuGo0NZQHJKgB/5PIEzC3gKiRx+RCaJuBjBkv2Wz2
 jUaSJz9HpBTLxHrlCEy+JJAsYQd+voXJdLD4vYSSX28BeI2SzhBMU9b5oH6hYkYAooPl
 Gq7a6idcPbtQHnSpqocTfSdiIZyu0FLiYKqyojX0oX4fDNOC8eFoW8zxXJ0tPEnsVKQV
 3KjERfYQhEXhbaWIncID/h1n3Ntn0sctR71FuOyvMTAWxZorMyc4JnCkrRPJR6uAUXdz
 yrhrLyzUW1OarRKrAW7mDzb/MnZ1uB6e/H/OtkM8GS1FmTtwU/Wd/htlXYRhDTYb1bWw
 A5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686003873; x=1688595873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7qE+XF1sdC5qKTLQBPA7J0xIVj1iHbCF/ZSK/gcraw=;
 b=LuMNS4kPy9r4d1byrIzIYlH8wVecvKKiZQOIY+R2xPajfO1lnasX5fz3G69YVr9k3O
 eRXZvdGq/h4iq9IhFEcpmvZ/DCDCQGbmu5fha6fuo7UkutXWwikAvfzaBJFYz4tgT4d9
 65aLMeMf0vYpT7prIMafstJ0j0thJWzz6e7y6x6T8b/LEnLeSaNHUfHCZaPxVQ7NVnkm
 b/dyZmtE75ZEMaENwoo9o3mCO422BfGZFlWB0PMlQqBKa58/r4VMx2/mb9wMr/tJS/xh
 sxJ0Orx2swQIvd+LBpKk1qm234BmmDiy6Rp45E7mii1r43dFmJ1eIdJrbaL9ZFRvloTu
 jPjA==
X-Gm-Message-State: AC+VfDyel6Y/wR7FL3YhvapM48XCDYCn4MH4jO7fAupRouGl/ykQsC1C
 777jXi3IlAejekgVYCIExcq6xgzZ2cCv90G6x48=
X-Google-Smtp-Source: ACHHUZ4FVKtshHeXy8xSUhySjci2Rf84Ng8DD/izGVrrfqSLuPui+NcZwVpgCIOLxjdirlntrzCApg==
X-Received: by 2002:adf:fccb:0:b0:30c:2bbf:bf75 with SMTP id
 f11-20020adffccb000000b0030c2bbfbf75mr159034wrs.26.1686003873750; 
 Mon, 05 Jun 2023 15:24:33 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4cc1000000b002fda1b12a0bsm10850321wrt.2.2023.06.05.15.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 15:24:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 2/9] target/i386: Check for USER_ONLY definition
 instead of SOFTMMU one
Date: Tue,  6 Jun 2023 00:24:13 +0200
Message-Id: <20230605222420.14776-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605222420.14776-1-philmd@linaro.org>
References: <20230605222420.14776-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a6..750253e679 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6915,7 +6915,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->popl_esp_hack = 0;
     /* select memory access functions */
     dc->mem_index = 0;
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     dc->mem_index = cpu_mmu_index(env, false);
 #endif
     dc->cpuid_features = env->features[FEAT_1_EDX];
-- 
2.38.1


