Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9872C7E5F77
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 21:49:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0pSy-00087w-It; Wed, 08 Nov 2023 15:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0pSv-00087j-TN
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:47:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0pSh-0001qS-EK
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 15:47:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc5b6d6228so559175ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 12:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699476460; x=1700081260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=scT+sRR1RlfBaEkZGKgXcul/nvcA1boNQHmxmdbMth4=;
 b=I2LqSYPe6X5oVONGfGDuOm7X8wrZgP9TKVKz4tUKCIxhNHW3nqfVwwubkgccsqLueD
 jtc0NE6xOhINfz1htUuJgScyKb8i1I5Y6GZMH62ADLZNMmX/H+BLj15xF4E/e8YT99kZ
 2XBIiR9suAWHzXLX9V6DIO5NH7Js5KAhMGy+fR4qQ595I4jxhfFvdXa9UBUu/PzR9bH+
 sukoYbrYXSAOlmmRyrCir1NpSrizpA0QELK2sgJlYSeRJQC3FA9zXfTRm2Dzn7L5oY/2
 rPhMjZEn42jdFXFdIqrhjaoDOCL4mm99QY8gHvmICPKjDM6YPT9Gf3AemGf2nTnESIIS
 Ihqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699476460; x=1700081260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=scT+sRR1RlfBaEkZGKgXcul/nvcA1boNQHmxmdbMth4=;
 b=JuV8em2OCvVFQ+3xi0jECl+ADoIjq9EZKsA+WmWmLxKGxcX0dKlDJ4bQXmigO8tkR/
 2GrVa0stqlS8Wb253TKHKmhvi0KNn91SSQeoAgLV6COqACZLdHtwz9zkFWJOaGt8Gqch
 oQq7vn4bhSPDo6lw/A1v5c/2X7+RKQ80czeYDpxNbyC4+rbNZhKWZ479uAGHq2FDG1cz
 AALWuAQBLth2xwOodcGENsA8gGDJIysF0/OS9pE4wA2cBXakuGztF1eXgr+eVCCVgXdp
 mcysiSniqXeMixZOzqOtquziKhPvKkFB1vmzSJEeAjhXnh9hkqmtFXRHsc1Yk5WhSbTi
 bm9Q==
X-Gm-Message-State: AOJu0Ywyw7Wg5RcyzxWSQpNCDBYjn3OXFj3rWk0HxbONJOb/385af191
 EcU7EemhA7W4MtGsihJQvv40PG6KJtW9YZC+ZQc=
X-Google-Smtp-Source: AGHT+IEb7Uj3JZoNE297+mVcMk1l+31lnXz/LqYY+8+MQ1ImGafOMV674T7QbJKtE4oMTklN1nVQwQ==
X-Received: by 2002:a17:902:ea05:b0:1c9:e4f2:a39d with SMTP id
 s5-20020a170902ea0500b001c9e4f2a39dmr4002341plg.49.1699476460374; 
 Wed, 08 Nov 2023 12:47:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s16-20020a170902ea1000b001bb0eebd90asm2113527plg.245.2023.11.08.12.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 12:47:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH for-8.2] target/sparc: Fix RETURN
Date: Wed,  8 Nov 2023 12:47:39 -0800
Message-Id: <20231108204739.279972-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Perform window restore before pc update. Required in order
to recognize any window underflow trap with the current pc.

Fixes: 86b82fe021f4 ("target/sparc: Move JMPL, RETT, RETURN to decodetree")
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6fc333a6b8..9387299559 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4096,12 +4096,12 @@ TRANS(RETT, 32, do_add_special, a, do_rett)
 static bool do_return(DisasContext *dc, int rd, TCGv src)
 {
     gen_check_align(dc, src, 3);
+    gen_helper_restore(tcg_env);
 
     gen_mov_pc_npc(dc);
     tcg_gen_mov_tl(cpu_npc, src);
     gen_address_mask(dc, cpu_npc);
 
-    gen_helper_restore(tcg_env);
     dc->npc = DYNAMIC_PC_LOOKUP;
     return true;
 }
-- 
2.34.1


