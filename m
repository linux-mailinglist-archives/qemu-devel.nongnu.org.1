Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836887D1AE0
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4aj-00074G-1Z; Sat, 21 Oct 2023 01:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ah-00073w-GA
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:03 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4af-0008Jy-OD
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:03 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e9ac336589so1082081fac.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866320; x=1698471120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=JqViEC0EYu1V826KiMAbbvBls7T6KkCdJKPpmzfHT0gqlxmdA2kLc6myhDFsyA9nIZ
 dQgkTeLi8KGFfZrDhKae0fy83CsvIYROagWIHX2xEpwbTQm4vQWC4HyXI/HKuVkrvRb1
 HkJ37oHnKcyMpnHlIJXOTUJur6M4o9NIsgxGHRncrB8Pp3od0kkJVmrd+TkuRk5o4e8v
 PDrdV2cl1LNsaTwZtO0uEJgeaUAfwnoDDkyz2268E161VGhDEUl4TQRNDX5AHF/njYxG
 bBZC05eSfLgGt0tuD+O1BuJpYA3H4lu82TpPBMg0OdotmYVNbyfIU8a4qvnm8JMeQZDf
 rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866320; x=1698471120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=b8Kbat9eMN3use2EFC83rZYpgAUrm2u3ey/D6Xan7wtktC7YzKJZUmf+L/E2bMTOra
 sBR7pXdRIWcCIdd1Ozs7alR5ITnh6qZmKuNZHUIlryVW129nHfKVJKytZxqb4bioJhkG
 SGHdjytLgcvu1hkuw7NOflFLOK4vitVtyX/FPc08vsafFLoRDypULrRLDOyrZj3tS8L6
 byCtMTsPcy/5FLkpZHtbMdFL7Unvsfe/hUX8ghsKFPCtkjkFb/aptfcE318DybSGIF0A
 oy8/SZgh71yqtj/Sjeab2V8Fg5TX6PTsf6PG9VJ6d27J4f6tVWM1Tlb6SfSzN7r4bLXZ
 dGUg==
X-Gm-Message-State: AOJu0Yy4UdrN5O5r5i46m5Urcdu9SL8FCkxId+ZwcGHejLrzhKfyH5fO
 QjOoS3nWTLx/eaFTT8u/5cLCTgXRQx+XDA/OAzI=
X-Google-Smtp-Source: AGHT+IGs6mcF4AJduCPHs4qvpn6kXpjJkvJRvGG4vzxcC1aQiHI3l1rnA3CP60mEBMp54NRplk68AA==
X-Received: by 2002:a05:6870:219d:b0:1e9:87c0:a849 with SMTP id
 l29-20020a056870219d00b001e987c0a849mr4586031oae.22.1697866320456; 
 Fri, 20 Oct 2023 22:32:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	qemu-stable@nongnu.org
Subject: [PATCH v3 01/90] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Fri, 20 Oct 2023 22:30:29 -0700
Message-Id: <20231021053158.278135-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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


