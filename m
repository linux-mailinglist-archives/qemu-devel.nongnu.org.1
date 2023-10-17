Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4277CBAC0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdJz-0008Lj-61; Tue, 17 Oct 2023 02:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJx-0008LC-VX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJw-0003oP-AG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso35851135ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523167; x=1698127967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=yu6Zx0A43Xp+hfqLSHTsuXOcFUWFi2FJmueWd+N6O3cg9GkYlXApZlzmarJZTDVcD+
 AfYrZ24vichmLs9SWdYl2ajmDS6fcZKH4T456XCBBhCSkC4zBbUpHprcbQyGZuPlIgIu
 5FT5M51JIik2w0WyYDXWShXQo6xK9DhjkEu676JrgmW38SNybQqaeftR7LUZc072eW/R
 y8zln6goEBO1Ca/CG7W8/k2qZizsn4CTkvcOhO5B4PMer737bLnHEMnYkZkVgA2DSyfs
 7YsbhNBUxTrlDhRsEHv/Up1SckPrOF6aJHW24qqDRViUNuB6aOWKAw4kAKnrl4ajUDfs
 i2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523167; x=1698127967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=m617pr9/VUNUAW394nnWJijx89X4iem00+8ymP6DnA7oPuU5m7Zs5ZlmXdxmEkDQfp
 OPtLpRPdHLo6Ud+4hglYmf2ARaoVHiIruFRkSqm8CI81dCg5g09nR8ju4idi++wtcnft
 TpfaoI7C4PgVSGSZcag1Q+oSK2V8lkt4VqwPlc2TFpTaraV8LbexnbOhpWWLjzLrbD0n
 ol8rlzLNv/5K9i21aITww09cHuMYES+MG35fiIaMvu6BxBI0nTKWh6fxyJPzBGHGV/fa
 3OC1+MSE2Ak4Uh7pzihWjae5KBLT49Qb7cFhmVqJSOQIbf8I7Hkd5Qjrtx+LsBq5br/8
 govA==
X-Gm-Message-State: AOJu0YwvBUDT7upgfyHweIlwWo1UrQ7J3Mt8N+6+AaqRPo13Py+ar8Mf
 6dzOVN3T6Pc2QdZ40rjSzI8Dxvn+1qRR0P+Hw5I=
X-Google-Smtp-Source: AGHT+IH6qThosRgXcnk0XkFB3fpZ+DRS8RWIOTK8FGKrx26ePiwF3XT6YFUcnLVtttPeJ6YMqUadFw==
X-Received: by 2002:a17:903:228e:b0:1ca:86a9:cace with SMTP id
 b14-20020a170903228e00b001ca86a9cacemr1479119plh.2.1697523166547; 
 Mon, 16 Oct 2023 23:12:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	qemu-stable@nongnu.org
Subject: [PATCH v2 01/90] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Mon, 16 Oct 2023 23:11:15 -0700
Message-Id: <20231017061244.681584-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Fixes: 633c42834c7 ("target/sparc: Introduce DYNAMIC_PC_LOOKUP")
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


