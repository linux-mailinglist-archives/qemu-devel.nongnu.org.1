Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E68736610
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh5-0003pH-Or; Tue, 20 Jun 2023 04:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgx-0003nC-7m
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:26 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgu-00065n-BO
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-986d871a9beso570000166b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249578; x=1689841578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqGgOkt5DlDOa0sDWBCeSGba/OHMB4venmdJ5cMC57o=;
 b=CBIIhq5c4Sc0YgqspcVfnExTewAe8ErzVMsuAzxxaHMSN29W+alzF7GNbPnnkCxQg2
 cwbySKWqs5lSPTTQv7YF3D0b7TcDxMwI7tbpJC1ZhQE8r4RPCg1RIO/vtkbQc4tomHl3
 2Qq124eskCUTrSvUCAP/OYEja8Ymm5Oqye1/yYeIAv5ljLILN7quPDUyKkGts/tYX0zU
 iPccjKe/C+ZZxcat7cfxpbOcwcAywNyC+FrBAweWUD+VoIwhfvLywuoAfCE3xcPhrspz
 ReJmhJA8+7SsnqpdYblWq7x/BVXYnLlITDxZ+hpgGt7XvB7opAc0b0ODeXHBtp3EwtuD
 SyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249578; x=1689841578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqGgOkt5DlDOa0sDWBCeSGba/OHMB4venmdJ5cMC57o=;
 b=Ruv6QD8q+tFey7VsaDsoSjXoWxvcxnhg4gY0ZAK3PNRiX7oSfwfOJu2p6Z11z3fva1
 HZRSaEf2ZE6//VfOMVZa4nbJN/XQZF5Ybjp7nYiEKy3KDMzFkv/7N7sz9zrT2aIH7jR6
 PDXyAU3t50bKxYS2dhsD4sj/rVYPuxXTQq3Hd9F6aQoXsNYkV+rTfTMHoTgK/v/m3Mis
 /ZmR/8mgsHQNyhDoIvzu1Kwo7xc+SwGYjvEyi3hAXDHP1St3OnU5cx6THQ8RoaBuAFGw
 wxejwfz9PGAdiSy5xvXuFv+nwOONd0OIWVpgycjFHnXl95Yl0d3Le+R1lvBBtIwGcTjM
 ESUQ==
X-Gm-Message-State: AC+VfDwYg7ELI3qRk581nE5qszxay+5HlohibCZsYv8DOfpVYtd4QR1m
 FlWURyMhKSyxv+5FcF9Wf1q0BNXMh4ZsHAoG8tZx0aGh
X-Google-Smtp-Source: ACHHUZ7/EcPkxA6hcGJFA1IAG/+1hfQHhnpoS/ZASgcwAy8u+gPYFJnhk7RQ+hKK2eO4/wcEl9d9YA==
X-Received: by 2002:a17:907:6e1f:b0:988:eb17:d052 with SMTP id
 sd31-20020a1709076e1f00b00988eb17d052mr2593454ejc.56.1687249577698; 
 Tue, 20 Jun 2023 01:26:17 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/16] target/i386: Simplify i386_tr_init_disas_context()
Date: Tue, 20 Jun 2023 10:25:59 +0200
Message-Id: <20230620082611.770620-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since cpu_mmu_index() is well-defined for user-only,
we can remove the surrounding #ifdef'ry entirely.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230613133347.82210-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a6..08c4cab73f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6914,10 +6914,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cc_op_dirty = false;
     dc->popl_esp_hack = 0;
     /* select memory access functions */
-    dc->mem_index = 0;
-#ifdef CONFIG_SOFTMMU
     dc->mem_index = cpu_mmu_index(env, false);
-#endif
     dc->cpuid_features = env->features[FEAT_1_EDX];
     dc->cpuid_ext_features = env->features[FEAT_1_ECX];
     dc->cpuid_ext2_features = env->features[FEAT_8000_0001_EDX];
-- 
2.34.1


