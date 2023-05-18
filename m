Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A54157081DA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6S-0004Bi-Ci; Thu, 18 May 2023 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6I-00049f-G0
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6B-0007zD-LL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f4ec041fc3so12595465e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414273; x=1687006273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=589iqNrMeAs79wjrBAvFfcZRoxcqL9gt48lPQfaMb+0=;
 b=hIkirGWRp9ZFmKuVp11x6DGiDPd71dglwQa8B6zlhl/lG6jGXEdZpmDqnjguzv63kQ
 hwu42aWA+cnuCkbmb2SzVq3R9PT+NirNDeuqkUIIgj3U0HqGkdGWeWO04hQ5Xyhnkwyu
 cSDDg3H86SJkx7TUHDMwg28W+r9Cpvk+WjWnuj6kpdx1OCEjied7rd9bUicSerCLuptC
 /ODXW7Em6zcx5tdPEG77laZTEEwkCuDN5NuhPKV8C0cOoc8/XxSfbn4rSknHF0bCdzvs
 QmPtajYU766vovzGf88G4x+ejT+ks+Vu8whXpOwgxivIiNoKP23GDUuBek3w9F4VGD7D
 VFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414273; x=1687006273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=589iqNrMeAs79wjrBAvFfcZRoxcqL9gt48lPQfaMb+0=;
 b=PH+HdK5RtbCcxQuyUo7QxoEQBYQFrdcO1GhwYZP337m9+rkAtHyPLV0VqH6joU4LjE
 roCZ8cMJUJyxgUOg4+2F/rpeWQBy7wnIMPK9nRtImojpkTB5Qg5E+yXVmBp0Q0648WNO
 NplGMH+u8N/VMoz+UpiV+bnZ+PpNxD6ackXY/Zkmo31SlJGkwsGNW+qWDLLdskv8/PMG
 06apPTa6bREeXoS84m5cnJ1cOhTOMH6e9v3yhNNiaq/JRyuBk2PQIxEwr71Nsi6zKU7A
 ny6BvTS49ceFNAclj/2Jf9QaacB8E1RtTqdHnLYGlyRgwFvWiYqPsWtoMaaUEn0OQw8o
 iyaw==
X-Gm-Message-State: AC+VfDynd7ZrIos2HdjIN6LLnLUv+1U5BDSfwFrXrH732x9wPi1Gy8UJ
 SgeDt7CXqNCnBEiTshkTf2/b2z8Td+o4D9i4Jbo=
X-Google-Smtp-Source: ACHHUZ72mTT7TAXZEsv99ce/o2VrQPWXVmA0oqRgImz/+m6flChrN8al8882YzaEWRDVKCp8rW5RVg==
X-Received: by 2002:a7b:c8c4:0:b0:3f4:266d:5901 with SMTP id
 f4-20020a7bc8c4000000b003f4266d5901mr1230877wml.35.1684414272942; 
 Thu, 18 May 2023 05:51:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/29] target/arm: Pull calls to disas_sve() and disas_sme()
 out of legacy decoder
Date: Thu, 18 May 2023 13:50:47 +0100
Message-Id: <20230518125107.146421-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The SVE and SME decode is already done by decodetree.  Pull the calls
to these decoders out of the legacy decoder.  This doesn't change
behaviour because all the patterns in sve.decode and sme.decode
already require the bits that the legacy decoder is decoding to have
the correct values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7862e9dd4e3..1fd6f97b641 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14205,19 +14205,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0x0:
-        if (!extract32(insn, 31, 1) || !disas_sme(s, insn)) {
-            unallocated_encoding(s);
-        }
-        break;
-    case 0x1: case 0x3: /* UNALLOCATED */
-        unallocated_encoding(s);
-        break;
-    case 0x2:
-        if (!disas_sve(s, insn)) {
-            unallocated_encoding(s);
-        }
-        break;
     case 0x8: case 0x9: /* Data processing - immediate */
         disas_data_proc_imm(s, insn);
         break;
@@ -14239,7 +14226,7 @@ static void disas_a64_legacy(DisasContext *s, uint32_t insn)
         disas_data_proc_simd_fp(s, insn);
         break;
     default:
-        assert(FALSE); /* all 15 cases should be handled above */
+        unallocated_encoding(s);
         break;
     }
 }
@@ -14445,8 +14432,9 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         disas_sme_fa64(s, insn);
     }
 
-
-    if (!disas_a64(s, insn)) {
+    if (!disas_a64(s, insn) &&
+        !disas_sme(s, insn) &&
+        !disas_sve(s, insn)) {
         disas_a64_legacy(s, insn);
     }
 
-- 
2.34.1


