Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF797738E2B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dn-0000Io-85; Wed, 21 Jun 2023 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dk-0000Hj-Jm
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:20 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Di-00075T-Tx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:20 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f883420152so3704792e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370777; x=1689962777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrouPtyhJiYuyIvkzLvAJvXI56s/AHokLRqYC3TVm+0=;
 b=C+mHtpmA9owjLQW/pJMoiRnC9XF2BgAmurPVC9cidxIYSnKAJw5lgFwzYqLZRi8s3E
 gS0mj0JjteTjZtoSPj3f2EXXslxbUNgFsnadiMZuimYKWq3JJ3SsF5u5QfovVvrjMwRm
 wOlN39CZmQ8mLw/rC4FN9jJsJZRdmJW8FaycZTCHUm+h+Va0eCZxkzBgMfg1iOupO7UL
 bSv7cPSk1ig23y0gZjTkbI649L75h2DHj0afnCepKiQXqEoLWU9B4qytt3xhAPJ0wHZm
 GWjg7TzfXA38AXO7RwdCaBtpNHdRJhVw4Y246cdiRYRciwJJTYOiqiWq/dd5J5N7Vz01
 T2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370777; x=1689962777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrouPtyhJiYuyIvkzLvAJvXI56s/AHokLRqYC3TVm+0=;
 b=GKwbsFdXnF/ZwE+sKksKkC4SjAXvR9XV3OZ8p6UIiQCzBOdmLMGoe8KlefwRXojYD1
 W74NaZPgjtO6TVWEOqLx/qCC1KO7MZNrS3aUaHEfclJ4Y6iLnh8UxTrPq5sIi+d8rbuM
 Qv2dDUu2S3ORa3EGV5wRpQ6OhyTgs7X8b9WCAEaAWRUabxzftkVDqE1lo07JwinDqWQz
 HYOjgey8E+6xVcY3apnRGY8M9Pm8fBDbwYCsYYzzsnqxnPt5ycIM/26xN50pGk41aF6E
 7VsWp4Xi6xkYqvR1XaY845TWrs5H9vLIHZUPWBbZkC/OksoxK9TDRL5YhQu+vVyRpVTU
 7y8w==
X-Gm-Message-State: AC+VfDzI1UtMil1oU9NUNg/78bCQr1+1yB47WkSDxUOz6scB5SkrPIOc
 129Mn9Ni7TJKRjgWs5mSQFwOGCVAFgnArbqwebxQyUJ2
X-Google-Smtp-Source: ACHHUZ5TcRpfJ7J8YuszWBvoMVfx12kEpx3WUX49SloYzTdY6WKGu2SmUz9OENZu5S2BffC06lrVHA==
X-Received: by 2002:a19:6547:0:b0:4f8:7807:a612 with SMTP id
 c7-20020a196547000000b004f87807a612mr4167223lfj.61.1687370777007; 
 Wed, 21 Jun 2023 11:06:17 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 7/8] target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
Date: Wed, 21 Jun 2023 20:06:06 +0200
Message-Id: <20230621180607.1516336-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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

After the register window unwind, this is for a plain indirect
branch with no further side effects.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9ed235d26d..ab7054d4eb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5029,7 +5029,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 gen_mov_pc_npc(dc);
                 gen_check_align(cpu_tmp0, 3);
                 tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                dc->npc = DYNAMIC_PC;
+                dc->npc = DYNAMIC_PC_LOOKUP;
                 goto jmp_insn;
 #endif
             } else {
-- 
2.34.1


