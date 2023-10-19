Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A847CFB79
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:43:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCd-00030N-KP; Thu, 19 Oct 2023 09:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBr-0001sM-NT
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBk-0001Du-SE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3856292f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722546; x=1698327346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lqB1Xmtdz/E0jdyC0rVkWpk74xBjeEcGHTFzp7iJZ4U=;
 b=URtkvWB0tMZ2SgqOaE3JCcebPY9hqHIOtuQqvp7CkqKTut1KMv+2U1H8gfeJOXmg4p
 eChCR4FKQ9lGRDQMC6cc5hgX2oB7Z09rzOhXh3bxjqiYO1cEaD0RPvMSLA+G4ePr7iXF
 4T4UppnWVm8b/w/pgKflZ+tE+o+gDVdi4lgh8eztA9AeoFduk9svoMIJrEx3gIbE6DEB
 mD7ZxWeflgQeF5V/xE0NqyutGZvr5+mFhIzUfQTlq1iEGggW+XqCtgGIbdryTJegBao8
 H4qkzAcJzwFLcoZ2wcdbNMocrsf1Joha0+Od7fXaw39LOqZGT/vweCGKKjTsmenHnZCK
 cWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722546; x=1698327346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqB1Xmtdz/E0jdyC0rVkWpk74xBjeEcGHTFzp7iJZ4U=;
 b=ltfM66IPo+1V6OlM20NiK/xiVl64s8XQHK7NNbvjYY/bHqzFjtYBbtZavhvLUbUpN9
 6E+CpkxBmsn96JBL90hTyZD9MswRgnPABJ66/cCbN+0U1ZC9Ib6YEdBbTQ65/zdc0QFv
 HqXNJbPyrHCdB3WTU9Yz3MxecYlgahXOozLpNG3vpTaa5atU/auObjIGfWwus8NNEoK4
 DvmeRkIwYa7GY8J5txX0zZTPYA4xs/V0ebaXSDWe9GvJAq1TUgQOOvFlqF0Qr5EkziIo
 daCVMOqNkJupS5xagXJwtgENScPI7MfQ5y06RlhSJGlOxu/hYNzSIysNAZvPM2vWK+W+
 mK6Q==
X-Gm-Message-State: AOJu0Yx338qz+0UIfyjr94RvugYycsHc6/qe4/XEbI5emaXKzGA2d+bx
 PbL0muWrSUtgQAWtdam+UxzzEFZOcRLaNlt1nbs=
X-Google-Smtp-Source: AGHT+IG92CVRT2B2BL+/S1sTzGahwlyexYIJMBP2DS2RCZAqXV+lXUGKVc791M3tIOvKyXPzavIIIA==
X-Received: by 2002:adf:ee08:0:b0:32d:8830:edb with SMTP id
 y8-20020adfee08000000b0032d88300edbmr1561827wrn.38.1697722545748; 
 Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] target/arm: Permit T32 LDM with single register
Date: Thu, 19 Oct 2023 14:35:28 +0100
Message-Id: <20231019133537.2114929-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

For the Thumb T32 encoding of LDM, if only a single register is
specified in the register list this instruction is UNPREDICTABLE,
with the following choices:
 * instruction UNDEFs
 * instruction is a NOP
 * instruction loads a single register
 * instruction loads an unspecified set of registers

Currently we choose to UNDEF (a behaviour chosen in commit
4b222545dbf30 in 2019; previously we treated it as "load the
specified single register").

Unfortunately there is real world code out there (which shipped in at
least Android 11, 12 and 13) which incorrectly uses this
UNPREDICTABLE insn on the assumption that it does a single register
load, which is (presumably) what it happens to do on real hardware,
and is also what it does on the equivalent A32 encoding.

Revert to the pre-4b222545dbf30 behaviour of not UNDEFing
for this T32 encoding.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1799
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230927101853.39288-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 48927fbb8ce..b3660173d1d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7882,7 +7882,7 @@ static void op_addr_block_post(DisasContext *s, arg_ldst_block *a,
     }
 }
 
-static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
+static bool op_stm(DisasContext *s, arg_ldst_block *a)
 {
     int i, j, n, list, mem_idx;
     bool user = a->u;
@@ -7899,7 +7899,14 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 
     list = a->list;
     n = ctpop16(list);
-    if (n < min_n || a->rn == 15) {
+    /*
+     * This is UNPREDICTABLE for n < 1 in all encodings, and we choose
+     * to UNDEF. In the T32 STM encoding n == 1 is also UNPREDICTABLE,
+     * but hardware treats it like the A32 version and implements the
+     * single-register-store, and some in-the-wild (buggy) software
+     * assumes that, so we don't UNDEF on that case.
+     */
+    if (n < 1 || a->rn == 15) {
         unallocated_encoding(s);
         return true;
     }
@@ -7935,8 +7942,7 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 
 static bool trans_STM(DisasContext *s, arg_ldst_block *a)
 {
-    /* BitCount(list) < 1 is UNPREDICTABLE */
-    return op_stm(s, a, 1);
+    return op_stm(s, a);
 }
 
 static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
@@ -7946,11 +7952,10 @@ static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    /* BitCount(list) < 2 is UNPREDICTABLE */
-    return op_stm(s, a, 2);
+    return op_stm(s, a);
 }
 
-static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
+static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 {
     int i, j, n, list, mem_idx;
     bool loaded_base;
@@ -7979,7 +7984,14 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
 
     list = a->list;
     n = ctpop16(list);
-    if (n < min_n || a->rn == 15) {
+    /*
+     * This is UNPREDICTABLE for n < 1 in all encodings, and we choose
+     * to UNDEF. In the T32 LDM encoding n == 1 is also UNPREDICTABLE,
+     * but hardware treats it like the A32 version and implements the
+     * single-register-load, and some in-the-wild (buggy) software
+     * assumes that, so we don't UNDEF on that case.
+     */
+    if (n < 1 || a->rn == 15) {
         unallocated_encoding(s);
         return true;
     }
@@ -8045,8 +8057,7 @@ static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    /* BitCount(list) < 1 is UNPREDICTABLE */
-    return do_ldm(s, a, 1);
+    return do_ldm(s, a);
 }
 
 static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
@@ -8056,16 +8067,14 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    /* BitCount(list) < 2 is UNPREDICTABLE */
-    return do_ldm(s, a, 2);
+    return do_ldm(s, a);
 }
 
 static bool trans_LDM_t16(DisasContext *s, arg_ldst_block *a)
 {
     /* Writeback is conditional on the base register not being loaded.  */
     a->w = !(a->list & (1 << a->rn));
-    /* BitCount(list) < 1 is UNPREDICTABLE */
-    return do_ldm(s, a, 1);
+    return do_ldm(s, a);
 }
 
 static bool trans_CLRM(DisasContext *s, arg_CLRM *a)
-- 
2.34.1


