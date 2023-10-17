Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91077CBB25
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK8-00009E-RM; Tue, 17 Oct 2023 02:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK6-0008U9-Oh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK4-0003qq-C1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so4225574b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523175; x=1698127975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yW51VE5CRrwGfkK0WrmE1TMHk4AA7avR7njSl04uAkA=;
 b=OFoVZe/b/JJwufABKikW0yx9O84zJa6AxWSgK7oeoqVVr+VhrdMUHzG8wHC+JvB80G
 vNS7haDrMf4a0Q/CXRElzi99obfQ7CprpgpdOYRRFHJQaDoJEkGgrBwUtK2yhbCQRxNf
 Xd2ud17h/XoFeTt2g9FJNUW569lDo4lmOlefaUul00eZacHb9lMhFdC1Lp7tJQOkMVt1
 uHXaBmdRX2lir9OEoFihlGhzJmqeja1+ZNdvkKiiHMLRte8A7pfmGnJzMoaIRtBG3xGx
 dC82zGkRYqOTPNVA5jfc8k6HNqCP8487pEkATPoPH+EqjSy9nkvmyuDq8mlcgLtP89Fa
 dNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523175; x=1698127975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW51VE5CRrwGfkK0WrmE1TMHk4AA7avR7njSl04uAkA=;
 b=uHqW8G8e0y5iGWYZ89+vOY/5WtYDNW6hg0MZe1tbN145mbOjR86cuyaGu3CCYY29qM
 +y/OtVX654g2VkCnmjTy3JvPV6F7HXA34pgUFzmcfB6i37ndgITNg8BbFoJaXyDa9rsE
 rWvEfjmR2bZm5Mr8weXptJj8TbK+gq92d8OpjQstXcdH4KYlPwpYslhgYRniudbVZnj0
 Dtd4cjH+arVwZRJBArxfP1IPHTW1ztTgDfsCDz/67MaQsjqrp1Kb7ShC1NtLtbF/WFDf
 FZ7RgPf7BWt+9tqpbO2X9LKq2UV/CfRcpw8RBHdvkDBZwEZSdNLGU7a8KbLUvOwc4RE3
 S8VQ==
X-Gm-Message-State: AOJu0YxuFTinOCLkgw6aNQRuZ3ifTpmemvCzihoM6CsfBd+NcqIbyECD
 BE3IViUdZaaoT7iQYx0/5DsAMzuyULXeTSJ3VwY=
X-Google-Smtp-Source: AGHT+IF5JE+b2BjWaqXM6A7+jRlJUY7urNsxz4WCxHGnWjmrEfVf3+XjSQ2p0YxeWWjwiIm+KGvycQ==
X-Received: by 2002:a05:6a21:a582:b0:173:3ef3:236a with SMTP id
 gd2-20020a056a21a58200b001733ef3236amr1366629pzc.21.1697523174972; 
 Mon, 16 Oct 2023 23:12:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 11/90] target/sparc: Move CALL to decodetree
Date: Mon, 16 Oct 2023 23:11:25 -0700
Message-Id: <20231017061244.681584-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9eb2b7e52f..377f133595 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3041,6 +3041,20 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = dc->pc + a->i * 4;
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+
+    if (unlikely(AM_CHECK(dc))) {
+        target &= 0xffffffffULL;
+    }
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3146,23 +3160,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             break;
         }
         break;
-    case 1:                     /*CALL*/
-        {
-            target_long target = GET_FIELDs(insn, 2, 31) << 2;
-            TCGv o7 = gen_dest_gpr(dc, 15);
-
-            tcg_gen_movi_tl(o7, dc->pc);
-            gen_store_gpr(dc, 15, o7);
-            target += dc->pc;
-            gen_mov_pc_npc(dc);
-#ifdef TARGET_SPARC64
-            if (unlikely(AM_CHECK(dc))) {
-                target &= 0xffffffffULL;
-            }
-#endif
-            dc->npc = target;
-        }
-        goto jmp_insn;
+    case 1:
+        g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
             unsigned int xop = GET_FIELD(insn, 7, 12);
-- 
2.34.1


