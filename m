Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6527D2706
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtT-0007C2-9t; Sun, 22 Oct 2023 19:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtF-00076L-H0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:50 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtC-0006jA-B3
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:48 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1dd1714b9b6so2101355fac.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017384; x=1698622184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaiE1/bSeMZ+5UImRCGkx6jDgHWHLGDLQF46mh2/Gqw=;
 b=GT9g9s9VlhGQ9bFCgxEPhI7F0IzufaBXisp0JIQZR6gqT0S9K4tNMfZQHZ/5aphu6x
 b2aOsMYva+CIV6liSy1vahx6nxAVScfWmstxkuAQMyXepeDgRCc4Ax4Eg6NQs/OfnA5A
 uoqA+hWYHSbD1auiHBMjizyLEduPHr/RQq4nsmZAGimrkILlf35wYmV4jKnezoK7nENd
 BqJsOvpEQ80Zb54RXvZLRf6OHECh2+rZ4lOuh/hr5ftDtjMGthyEwKiAzlHjVbBkKmD1
 EPUnuIB5eJEFhLeXHoGs0v2JSDvdoKK/zejT6SrrgeuLVEc7wO7uYRYytQ0rx5BiXvEG
 hmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017384; x=1698622184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HaiE1/bSeMZ+5UImRCGkx6jDgHWHLGDLQF46mh2/Gqw=;
 b=ipQrKe0rAnj0h3ade7jeSvWy81KEgrky/oyeU58/L8ELnoHwIpioS9jfn+m/T8dQu+
 oiFl05KefcGLyUsB8tEiV1HhnqSPC+hBX4o0ewkqVWHQRgJjcjZBxC6SE6vvYJnzADms
 BJNSFi8/3pwMvyKgxEHUe5iwzOwg4cshiD9+0SLUk/CKsNZNLCbZKaUEJgfXGGSz9lak
 5pn0PiL0Szb+85Kdz4tZuiOL0QMexZ+KYD/CL11GBkeWJ1EIZbCw9adD7fsHGGnVFuxY
 ZbCR/muv3i/LM/g61AzReZEw48LHuOxXITN14TStH2AGqfd/QSFG6ny1FPMuXK5KGyKD
 5+WA==
X-Gm-Message-State: AOJu0YxOvdxSrdeNAV+v8RzZxp/wxcmies7Y46Z5Owz0+7Qa1v3EvqsW
 Ou5tMhh/SMQXbW6eQZnXRzGjqWq0ryTclcCiSIQ=
X-Google-Smtp-Source: AGHT+IE6YJqj50WIDYXsA4ApvKcKhDh6K9vJG4Z9n93M1ECe2brxA+Xd+WqupjwbrM4caLn25Asi+A==
X-Received: by 2002:a05:6871:459b:b0:1e9:90ec:140 with SMTP id
 nl27-20020a056871459b00b001e990ec0140mr10249294oab.58.1698017384523; 
 Sun, 22 Oct 2023 16:29:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 12/94] target/sparc: Move CALL to decodetree
Date: Sun, 22 Oct 2023 16:28:10 -0700
Message-Id: <20231022232932.80507-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9eb2b7e52f..7ef4c6d4f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -285,6 +285,11 @@ static void gen_address_mask(DisasContext *dc, TCGv addr)
     }
 }
 
+static target_ulong address_mask_i(DisasContext *dc, target_ulong addr)
+{
+    return AM_CHECK(dc) ? (uint32_t)addr : addr;
+}
+
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
@@ -3041,6 +3046,16 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3146,23 +3161,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


