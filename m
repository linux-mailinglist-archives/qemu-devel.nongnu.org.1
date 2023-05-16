Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84170581B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Ys-0006m6-Va; Tue, 16 May 2023 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yq-0006lF-TR
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yp-0002su-8a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:16 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so8218593b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266134; x=1686858134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qhfCxW8nZ+AIzOPAndxpM5sZuukyWLZqrgdNp4ChwI=;
 b=zMKX732xEa5SPswvvFk1EloHDtswzovT+7ivlvjr0R7evVBzi6cVTqOUmT6+BpEKfS
 ubmh674OUeyGVPX2rh1KXHOi0bXjm4yMoWlFOqHNd8ZIqOu8f6sJp6/YLNaad2wuzzPa
 O5i1mm0fUnjLYmAvQdpEkmQLuc768o8R+v/qaYMHZxef/8XPRlFa1jEO1OjVofmuSQAZ
 2y/tCMQpIhMQk5NupOp5IlN9LYjHpVJuWGv260skCRjFgPaJNXWElboPyVL9MtQo/Yir
 8X3q0qjAvuzI1l5pGMpFTi3l7jtn9J/yJdjT2iQcawcuB7nAPqAc667FC+PNOHU/N7EF
 Jx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266134; x=1686858134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qhfCxW8nZ+AIzOPAndxpM5sZuukyWLZqrgdNp4ChwI=;
 b=Dru8Wk6EKt0GXAER2rpC8mvxKQ7xmCQWFvfYni+sQLPeeoxyNM8Y7hrIt2MGy/ycLS
 5g3L5/TTrkmNEKyH7ybi+XcU/psaPFDh5RdQUn0pxKTbWIrGwf9NhqKwqwwJizTQfop0
 RE5qj/c+DTw1QMJwHQlHwHupgJL0LYHU53PXho661qQPXJ4346li9R9h3aN7++aSwrw1
 BjoBjB3EV6UnW5FoaQ6LY8FDRDajrQztNewopMhbN4tHC2pBne9JtPeo7TSKFMIHHGjD
 4/F56JpDraZhC26SKzrgHjDoal0FleoD5F5byp/f4bUFBMRiLpqKnVWcFzYYIObFJhnF
 Szgg==
X-Gm-Message-State: AC+VfDzVGNF5vaW7Uct/lDvUlRdyOG9crdVcJBdC/lRKdZArqZ7ZoLWV
 UyaLurIXAiMmKC3vnmaxJAua1QzHlWQv+l+cpNo=
X-Google-Smtp-Source: ACHHUZ6+MdhcYZyEr14zfKZTMldJ4ZQEJq7n3mQ4YK43wVOQE983cERQ6QqGI0LzkAjqS2kXqxBddQ==
X-Received: by 2002:a05:6a00:b45:b0:63d:3c39:ecc2 with SMTP id
 p5-20020a056a000b4500b0063d3c39ecc2mr46827241pfo.12.1684266134012; 
 Tue, 16 May 2023 12:42:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/80] tcg/loongarch64: Support softmmu unaligned accesses
Date: Tue, 16 May 2023 12:40:55 -0700
Message-Id: <20230516194145.1749305-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Test the final byte of an unaligned access.
Use BSTRINS.D to clear the range of bits, rather than AND.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 33d8e67513..7d0165349d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -848,7 +848,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
     int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
-    tcg_target_long compare_mask;
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
@@ -872,14 +871,20 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
                offsetof(CPUTLBEntry, addend));
 
-    /* We don't support unaligned accesses.  */
+    /*
+     * For aligned accesses, we check the first byte and include the alignment
+     * bits within the address.  For unaligned access, we check that we don't
+     * cross pages using the address of the last byte of the access.
+     */
     if (a_bits < s_bits) {
-        a_bits = s_bits;
+        unsigned a_mask = (1u << a_bits) - 1;
+        unsigned s_mask = (1u << s_bits) - 1;
+        tcg_out_addi(s, TCG_TYPE_TL, TCG_REG_TMP1, addr_reg, s_mask - a_mask);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_TMP1, addr_reg);
     }
-    /* Clear the non-page, non-alignment bits from the address.  */
-    compare_mask = (tcg_target_long)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
-    tcg_out_movi(s, TCG_TYPE_TL, TCG_REG_TMP1, compare_mask);
-    tcg_out_opc_and(s, TCG_REG_TMP1, TCG_REG_TMP1, addr_reg);
+    tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
+                          a_bits, TARGET_PAGE_BITS - 1);
 
     /* Compare masked address with the TLB entry.  */
     ldst->label_ptr[0] = s->code_ptr;
-- 
2.34.1


