Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C717C9C8D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 01:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsATm-0002di-Bf; Sun, 15 Oct 2023 19:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsATk-0002dW-II
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 19:25:00 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsATj-0005gn-0R
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 19:25:00 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5815818406dso2389425eaf.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697412296; x=1698017096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHMmoRhH2a0rAqziBzM1rxgQxf2Qkq/OtKN8QQ1juq8=;
 b=MSFNqD7Yw5H8Cz2q9nxIHT1KLbjccpJncMtoTLTff/iGAbxOtOdXR2b0yC/gWEk10C
 0CU2xeqxQe8+d5HhsNiTIqSLO8w/ZJpoFM8VCE9rOTpbqwmBLswWQOSm7c8wPS8GNcV8
 YYOrh2QS+ttMfyplzRtZHwhEGbLZF6URfqOiHPzV0lfgvAZ0d1UQ6lxVnUrNYlUQVARb
 OwkMJgPjk2oTcLZ3qmaOfPysAgAJrpxrxZQrgJR7cKv3TIMubIkope8ZSeCNRZymgXvn
 xxkSE+nzp1vYhidRuRLrnrs0mX3kQ9KAEztNK9Xkb26eYQT1MUlefAH3B3d/FxnR0HZn
 kUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697412296; x=1698017096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHMmoRhH2a0rAqziBzM1rxgQxf2Qkq/OtKN8QQ1juq8=;
 b=PBDORgLc83SQF607ocdZPpbE6781edOiKUbh9IFEG/CZQGU1atCDOaRvpFgofqijpZ
 k1fL9bAmeikKTJ3on1ZFtDK/5ckweFs85V8q9uPDF7f7rfTRLpVL6NRA1E1zeNkk8pt3
 bIADxqNBMAIzsMpT9wFF/XYc17VNwZoEp0vrO+VHcwBJGExcyBFo2zioPcCDXHIdNpPp
 p/d8BJz12nnv32Q3orEeP4KwnUi912VrVmMfob+K6mvZCgPBSqd3PxcjpOm8ZMiZ1/MG
 88CkGRoT3QYjn4rbmGryR/emiSV0Mra/pMsHzZvC9OV3UneNWr+YKs/kz7XCFJf8RoaW
 Z94Q==
X-Gm-Message-State: AOJu0YzdV+VL8nWnqpMFVqNfH+XzM3+F1VaycybC9MQPhwSJvqQyI027
 vHmZnyFia4nkieX0Vfy8QBJb4jiubh59npwQPTw=
X-Google-Smtp-Source: AGHT+IGPEwZJE+svEVXnstJsoDSjO4NxAyHE2vLN9Ct96v/J6aLgZ5MfFe6v4+bs5KUv9JdibnbeAQ==
X-Received: by 2002:a05:6808:20aa:b0:39c:59e2:dd79 with SMTP id
 s42-20020a05680820aa00b0039c59e2dd79mr43053825oiw.36.1697412296316; 
 Sun, 15 Oct 2023 16:24:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 cp17-20020a17090afb9100b00274922d4b38sm3484310pjb.27.2023.10.15.16.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Sun, 15 Oct 2023 16:24:54 -0700
Message-Id: <20231015232454.391788-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

With pairs of jmp+rett, pc == DYNAMIC_PC_LOOKUP and
npc == DYNAMIC_PC.  Make sure that we exit for interrupts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Mark, I wonder if this will cure some of your lost interrupt issues.
Spotted while looking at issues from the JMPL+RETT+RETURN patch.

r~
---
 target/sparc/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..8fabed28fd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5654,10 +5654,10 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
 
+        may_lookup = true;
         if (dc->pc & 3) {
             switch (dc->pc) {
             case DYNAMIC_PC_LOOKUP:
-                may_lookup = true;
                 break;
             case DYNAMIC_PC:
                 may_lookup = false;
@@ -5667,10 +5667,24 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             }
         } else {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-            may_lookup = true;
         }
 
-        save_npc(dc);
+        if (dc->npc & 3) {
+            switch (dc->npc) {
+            case JUMP_PC:
+                gen_generic_branch(dc);
+                break;
+            case DYNAMIC_PC:
+                may_lookup = false;
+                break;
+            case DYNAMIC_PC_LOOKUP:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_gen_movi_tl(cpu_npc, dc->npc);
+        }
         if (may_lookup) {
             tcg_gen_lookup_and_goto_ptr();
         } else {
-- 
2.34.1


