Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAD70581D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eD-0001TE-1G; Tue, 16 May 2023 15:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cS-0000eb-An
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cL-0003oD-30
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ae408f4d1aso537285ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266352; x=1686858352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+EtsvBcKcdpaXvTeCONOLhtSa///+bxez6Y/ftYRpI=;
 b=FJWpNgHkoWISN7pRa9ZCsVVMwhUx2VBqy6yoyr69K+WPWPzlHCK24wIBo61rrEGw35
 AfSXktII/mP9yRqZIOyggUx+6hZM98hKW1JH0t6FGUAmLm5ZcWIDCzMAC1ptnuN0vSTO
 8c9vvtmypCr6pV8DFY5trbbdbaZBscEAi37iDTORtHUgJXEuhYBQIyLGtsur9+1a7QDQ
 liIgvNQX8uJF9cRyCT89G/E8ur1McU6LW7P8h8boX42s7mFyVSkKYgIag1cnr9bJrjNQ
 soph7ecTIXtqLrNgON78F+uGmX5EGJBBxBukDyefNLgreK1WHejqeqvhhcXR5tofyXWR
 UwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266352; x=1686858352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+EtsvBcKcdpaXvTeCONOLhtSa///+bxez6Y/ftYRpI=;
 b=JXEBe/0TIt0UvpZoR9tV9yi/zanIwuyc0DFKF9RE6B7MZKn10cRx8GRAtrPsJXWoB2
 VxVf4QspZZRqspTMfF2at2+E4a/YIxrBFp0V+5CW63Z9gfQqNgAcy+bxKLH8HU3pcM0Y
 DjUKuTZ/ka+3PWAMa6vnqjyix/VJzQDIFvW+e18+wns3BF8h5GsmIIAe7pdbQNyC/Khi
 1u+j+jX+6WfGurbQGekewZ1w3uRqU30ee2FzNiJR4/0M91Qdx40lISbPIhEFb7ErzIki
 2boUS+VLSDZt7cUptd7oB41RmX6LI0w7xtaoNyUdf2G5cjta25jlMWuE8O/hnLyyLnWD
 Qp8w==
X-Gm-Message-State: AC+VfDzDjXp572vHw6oQPtng7rXDLDURGfDHjjyFz3XJ2AnZL8URLXit
 PgOiGUeryUhx/xNDNgxjVAMmFayXjfmfK6aZEK0=
X-Google-Smtp-Source: ACHHUZ5KQNtLX7VmIUjB3cYjCJ4TIcP4Iui5eK8WSgFGe16oLIjL1y4RprK8nXp7MoTBJX7DstvH5w==
X-Received: by 2002:a17:902:ba86:b0:1a6:bd5c:649d with SMTP id
 k6-20020a170902ba8600b001a6bd5c649dmr35650024pls.56.1684266351738; 
 Tue, 16 May 2023 12:45:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 74/80] tcg/aarch64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 16 May 2023 12:41:39 -0700
Message-Id: <20230516194145.1749305-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All uses replaced with TCGContext.addr_type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8d78838796..41838f8170 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1661,7 +1661,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
-    TCGType addr_type = TARGET_LONG_BITS == 64 ? TCG_TYPE_I64 : TCG_TYPE_I32;
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp s_bits = opc & MO_SIZE;
@@ -1705,7 +1705,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
 
     /* Load the tlb comparator into X0, and the fast path addend into X1.  */
-    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_X0, TCG_REG_X1,
+    tcg_out_ld(s, addr_type, TCG_REG_X0, TCG_REG_X1,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, TCG_REG_X1,
@@ -1719,18 +1719,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     if (a_mask >= s_mask) {
         x3 = addr_reg;
     } else {
-        tcg_out_insn(s, 3401, ADDI, TARGET_LONG_BITS == 64,
+        tcg_out_insn(s, 3401, ADDI, addr_type,
                      TCG_REG_X3, addr_reg, s_mask - a_mask);
         x3 = TCG_REG_X3;
     }
     compare_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
 
     /* Store the page mask part of the address into X3.  */
-    tcg_out_logicali(s, I3404_ANDI, TARGET_LONG_BITS == 64,
-                     TCG_REG_X3, x3, compare_mask);
+    tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_X3, x3, compare_mask);
 
     /* Perform the address comparison. */
-    tcg_out_cmp(s, TARGET_LONG_BITS == 64, TCG_REG_X0, TCG_REG_X3, 0);
+    tcg_out_cmp(s, addr_type, TCG_REG_X0, TCG_REG_X3, 0);
 
     /* If not equal, we jump to the slow path. */
     ldst->label_ptr[0] = s->code_ptr;
-- 
2.34.1


