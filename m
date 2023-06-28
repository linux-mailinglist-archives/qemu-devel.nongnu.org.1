Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C67409A0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLq-0003EH-N3; Wed, 28 Jun 2023 03:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLZ-000356-JF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLW-0005JK-A4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa99742bd1so29472425e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936328; x=1690528328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06/nfmzpqd2IPJxz2rAclG7vHC61gjlvdFyJU1ybC5w=;
 b=ktVNqF8VQ4MWRKF8UkgYecYKGJh50m21cgzD6gX5vIW1w/xGjbTB84VGFLu+KDAWTU
 gJnyEED1XfMMgmpAXclQqX4YEITjjBJubXbJ33QeBYzkyYj+bto6gO6iB0QgnQEVELhP
 kn9v206DB1qu3KNF7H59cF+DBUa+pxcL82Q/r3YqMxEAfsAgQhcc2IECUo2Xl+WTa/Ip
 yeEvKIT4S9uIcYoCbKrMJUWLSX2cusS8lYgl0LyI5ooK1iLQZdqyNeiUta7DgbwGPb2l
 857XXkP9wNaDzOVEBqWoqhROANEYXeLWbB7eKnA3w1h/yF1sGhWuzSkKXZQ4x5VmJqIC
 KeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936328; x=1690528328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06/nfmzpqd2IPJxz2rAclG7vHC61gjlvdFyJU1ybC5w=;
 b=ZQOt6FZZRp4L2F49lcYRkwSIdok7/Gqa9VaYbm5Y0A7P2DC29ewwFD5IXmUv35o9yN
 ALmKbDoA0+NQ4Vqq4Glx+FZw4/KSg0qYBWrDqo5XjkOeMuJP1CK6wK+ErxSusjXucVHF
 UvOdh3lQ3oH3tmrosWK5fbpdSZn0VkU8KOkzG+9Cg2jaMLXkJdsOwwUsmhg3aIeonyLQ
 JvWGxJrC9y4FwLmNEqK02EcYmPcYH9hv+74H6eF0a07q+kDtT33l3DhZ5yANDlQezsbU
 qt4DMPBBMs6H4zNAb0P0BqKT0UEhD3Spgve//FfW/lQ+lj/IK5uQUJH02ZnVlHaifucn
 SWCQ==
X-Gm-Message-State: AC+VfDynfRMFj2NaTkb7/8hFVmnVL62wONgHUoGwlqdEJR2BAuJ+I/JO
 1nDMZ6gdWrA1kkgOgEwomi6xoUuVEGJIW2dHFwkSWdpy
X-Google-Smtp-Source: ACHHUZ5R4t9OStfL+HTtZpZo+QY+mm9WyPM7rkvQpoetpBGSrC6XM7R0Ii2dCTXU1pm3KrHqh/SLKw==
X-Received: by 2002:adf:dc8c:0:b0:313:f86f:2858 with SMTP id
 r12-20020adfdc8c000000b00313f86f2858mr4563178wrj.2.1687936328527; 
 Wed, 28 Jun 2023 00:12:08 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/8] target/sparc: Use DYNAMIC_PC_LOOKUP for conditional
 branches
Date: Wed, 28 Jun 2023 09:11:59 +0200
Message-Id: <20230628071202.230991-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

When resolving JUMP_PC, we know this is for a plain branch
with no other side effects.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 75aa1a138e..d7b569d910 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -941,7 +941,7 @@ static void flush_cond(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
-        dc->npc = DYNAMIC_PC;
+        dc->npc = DYNAMIC_PC_LOOKUP;
     }
 }
 
@@ -951,7 +951,7 @@ static void save_npc(DisasContext *dc)
         switch (dc->npc) {
         case JUMP_PC:
             gen_generic_branch(dc);
-            dc->npc = DYNAMIC_PC;
+            dc->npc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
@@ -997,7 +997,7 @@ static void gen_mov_pc_npc(DisasContext *dc)
         case JUMP_PC:
             gen_generic_branch(dc);
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
-            dc->pc = DYNAMIC_PC;
+            dc->pc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
-- 
2.34.1


