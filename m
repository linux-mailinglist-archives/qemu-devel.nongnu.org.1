Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C0E771366
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaL-0003l6-7x; Sat, 05 Aug 2023 23:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaI-0003kM-SI
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaH-0007bh-98
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:38 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso1796283a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293056; x=1691897856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33FWwcFvaizWH4t629x3Vf1EkBPMJLEp9WeUHM35B6g=;
 b=WPpUy4EwFwNvDV+VkrdZ76quH0WEYXHbkeIB4O1qZmLG0v/PyV0msYQHYEFI1BPsfX
 Sw9Fqru5r5fpFqbxd++Eiug27pEmbEUYs65lAChW1xqEN3C+m+EbsV+RHxpeBkUDYy/4
 EER8NqwBCA5Ad75/Pqj1R71+7ARj8eftUKugZ7fzUjPApZX+pCmneDZbL42081GyP3g0
 ByHzKrKAx3N3o41ZqFlw+IeLMDTL9xXooq0SIlJpPkGfTBkiA/vetXm9TP5LVwPQcluD
 iz8PGOtGWYR9MkE/j9hmvkShzq3mj7MYiTpsXsSUtnw3w9iuv+FoiD4i8bhFURGbDxkk
 E+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293056; x=1691897856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33FWwcFvaizWH4t629x3Vf1EkBPMJLEp9WeUHM35B6g=;
 b=L7+R65djpS7u3ykdNB72yks5BciWTD1m+4KgMWP0Z+bDKcq0XNJfGy/cfYR0kZBV01
 cYmIXmiT8mYOdHkT7EapuENh+VR55KC7i+hkQexZkx16D+U4uf/HVA1dpP6IZzuBQIiw
 kPGYI5HodSJWXYfJiuQT6eOd4Uya7HPb4ea8hVYIZ8TCg2+IT+z1pm2Y8R2S+9nIm2Ps
 se4/64nUCKgk8EZff3n1WDwceVcAJ1yE10iiA0AHLEQDqtBOGQlpbnZ6qNR9psTNUiu9
 x0ZZzeCukGwnKFt05gMccn3WkYei5RZyH+5z2ksRhQPOGvJ7mEyv+dMvCqXP/eZlEz9b
 avhA==
X-Gm-Message-State: AOJu0Yzd17/s+3XiFu9/crdl8d9WdQ7e43t2l+6sL23W1aZYA65SQkiR
 YvcUIG0cybRK+HsyGobiqVlILELuYHKPo4vkZZE=
X-Google-Smtp-Source: AGHT+IH0rtyieOuEfZNszhjwib4GeOV8yDlgZfBdRcr5wFhfR4FRuVSZpWbQ2OEY4yf5B9+pIWY37g==
X-Received: by 2002:a17:90a:5302:b0:268:2746:5c07 with SMTP id
 x2-20020a17090a530200b0026827465c07mr4474172pjh.43.1691293056103; 
 Sat, 05 Aug 2023 20:37:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nathan Egge <negge@xiph.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 24/24] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Date: Sat,  5 Aug 2023 20:37:15 -0700
Message-Id: <20230806033715.244648-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

From: Nathan Egge <negge@xiph.org>

Set V bit for hwcap if misa is set.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1793
Signed-off-by: Nathan Egge <negge@xiph.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230803131424.40744-1-negge@xiph.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 51591a1d94..c9e176a9f6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1710,7 +1710,8 @@ static uint32_t get_elf_hwcap(void)
 #define MISA_BIT(EXT) (1 << (EXT - 'A'))
     RISCVCPU *cpu = RISCV_CPU(thread_cpu);
     uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
-                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C');
+                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
+                    | MISA_BIT('V');
 
     return cpu->env.misa_ext & mask;
 #undef MISA_BIT
-- 
2.34.1


