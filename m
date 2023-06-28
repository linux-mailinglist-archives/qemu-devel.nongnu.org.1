Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470697409A2
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLt-0003Op-Ni; Wed, 28 Jun 2023 03:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLV-00033m-3e
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLT-0005Ig-Gn
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:08 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313f04ff978so3015026f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936326; x=1690528326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MLLwhPBjVmEi0+udNp6FGHceQgbPjwj+i6jIV9NGNI=;
 b=TpEckxW4V7K+Ttlc8rgCqcwSYgbLo/21tit1oAjnyQlNTbCjoc6rf3/D4R1nWNUHiU
 7jI5acuwYSh1aXVik3PLhgZpidWBbtrx0za4TqFYWquDvHYdTf0J2dOudMPbFv3cdW15
 /nFUdK3RkHaEr7BkxPb0cdxiBh/7+Bf1PDyoSzBf0J/IqtKazbny3x/jHrTVnFhtdQ5i
 biwf6UnKOyNnelcF8PuTMIc/Hg0NqZkEsaGg3mEAaBttvtQ77LHG77kMcAQ/Pxo12DO6
 xjUIibTaHlwM+omFel98No8DywWjHaEkDDqbLkk79pBUtAAxBmSi88KBIasGnK5sVYw6
 Ow3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936326; x=1690528326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MLLwhPBjVmEi0+udNp6FGHceQgbPjwj+i6jIV9NGNI=;
 b=i3gsZwI0Cad6V0MAshVu+olt8QRmBBK6E3hISOf6kcbFNJHpVGATxY1THlJOp1i2+8
 410v7nZqBVku/nr6kF9kG4CS6IRrab81fOnSX32IOBXubOzhgB/cHI6fH0yXcdFv4e7v
 rL/4z+lngf+wx8VTb3Jw/lRRNOM6COAGrYk69tsL2q/3I+hZk1pp8AHlZ42RrqGhZ/IU
 RTRMWapj8d2v+OIg7v2VPDBWlLCiuxCQQELPCxjT9D5EqlFx+5eiuDU2E/nQzsaut8Ks
 uRpsv/cpj1v5MYR2vlrH9NQGH+HP8r94wIth3XUEy6NQyfcfd0yTpy4sVIMQC1VMvWlw
 bLMA==
X-Gm-Message-State: AC+VfDxAc5n8wVEQ9T900Mf+OWMd4izjcNL2LlHgwQ4UAZDP3Rm2CwqR
 rbCwLLX+4S1qE4Fzn0RdjVpRUDmIJKUdjm/7egW93PMI
X-Google-Smtp-Source: ACHHUZ4M92qqCfewVxjvPCJbS60u9EWL9b/yg59WJ4hhfbtyoagacwnne0iPd6oskPVbC0BZrkw1iQ==
X-Received: by 2002:a05:6000:1818:b0:313:fe77:a825 with SMTP id
 m24-20020a056000181800b00313fe77a825mr3467340wrh.13.1687936325753; 
 Wed, 28 Jun 2023 00:12:05 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr in
 gen_goto_tb
Date: Wed, 28 Jun 2023 09:11:55 +0200
Message-Id: <20230628071202.230991-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bad2ec90a0..28d4cdb8b4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -318,10 +318,10 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
         tcg_gen_movi_tl(cpu_npc, npc);
         tcg_gen_exit_tb(s->base.tb, tb_num);
     } else {
-        /* jump to another page: currently not optimized */
+        /* jump to another page: we can use an indirect jump */
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
 }
 
-- 
2.34.1


