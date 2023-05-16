Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C116A7057E2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0ew-00036S-NR; Tue, 16 May 2023 15:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cW-0000ky-A7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cL-0003oX-UN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:03 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-24de9c66559so55532a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266352; x=1686858352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82nL5lFZVOS2kXTw0gpjyfDlKAnjIx0Wv02gro+5+RE=;
 b=eeqtOo+82OyjSkBdnkkqRDvd383Csib7Z6ZCA8sPYYgpeOyhf2cazljsP5uwd6cd0h
 RlruN8EXodMfvM8eytDVpx4jb1U4RRQ928DJgtnAW46zeNE6DAY4KaTLuWR9Ft5OlZMw
 8GKaOoooU42E10BeXM6ogTVSL3tvlNPZ94g7sf1Uyyc48CxpgHL8oZzoioT7cpWQIUew
 44F65ErzK71ZEPetQYIMCTWc1wUjpKfCGCPO6TjOQZAP+/LYrkDOg2loeaa/1aj2UFlh
 LiphLzIopc5+cOzF+/Yy+25nM46SU107Md2v8jtdukKX4SSwq6GX1fnyRzZXZXIeRsGE
 imwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266352; x=1686858352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82nL5lFZVOS2kXTw0gpjyfDlKAnjIx0Wv02gro+5+RE=;
 b=lfiV9a3rN0fqCbjU1Y5jyPdADT7b0pcYzNsiEHlJIufNzN0F+uMmWa/Atxq40fTa18
 y1SKUiqv/UG+LEzO4mgfxxm+BHnTjE8VgKtFL0e78vN22hWhnEpWQVsO5WFfDDNcWnUJ
 wWvDYhia+z85N+Pi16a5PAp/m9tqf1OfYyIaZX5bySbtTQnb4yTmpdIBswnzptAfzpx4
 AD/I1D/vnwfCgam8mVX4VhDIfVsgJ6FLu2/xIWehlXREoM5abRQZjt9cBny1PedRfaXS
 ekN8ZBjFUiLU9DafkqN2VowqcE3E5E0FqnWiJNY7lN4scklA0g8byl0iBnx/W7l/JS4Z
 1G1A==
X-Gm-Message-State: AC+VfDzJ57Et+SGLlGBmtAPnSbhr+Q+Zmyy9DvgxuITGeJtrUJbGjFC0
 PEbjSxZ7HzFXDY2+i2bQBmlUhwD0l49GUkIQn2k=
X-Google-Smtp-Source: ACHHUZ4bEBfElwtdRnsiBHMdQa543V57W7VrJAyvqBd6Stc/Fu/MTocHwegqRf6X58oV9D1PJDcGMw==
X-Received: by 2002:a17:90b:17d0:b0:23d:15d8:1bc3 with SMTP id
 me16-20020a17090b17d000b0023d15d81bc3mr37770884pjb.39.1684266352470; 
 Tue, 16 May 2023 12:45:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 75/80] tcg/loongarch64: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 16 May 2023 12:41:40 -0700
Message-Id: <20230516194145.1749305-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tcg/loongarch64/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 0c4ef72d6f..e5f98845a0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -844,6 +844,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp a_bits;
@@ -874,7 +875,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
     /* Load the tlb comparator and the addend.  */
-    tcg_out_ld(s, TCG_TYPE_TL, TCG_REG_TMP0, TCG_REG_TMP2,
+    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
@@ -888,9 +889,9 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     if (a_bits < s_bits) {
         unsigned a_mask = (1u << a_bits) - 1;
         unsigned s_mask = (1u << s_bits) - 1;
-        tcg_out_addi(s, TCG_TYPE_TL, TCG_REG_TMP1, addr_reg, s_mask - a_mask);
+        tcg_out_addi(s, addr_type, TCG_REG_TMP1, addr_reg, s_mask - a_mask);
     } else {
-        tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_TMP1, addr_reg);
+        tcg_out_mov(s, addr_type, TCG_REG_TMP1, addr_reg);
     }
     tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
                           a_bits, TARGET_PAGE_BITS - 1);
@@ -923,7 +924,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->index = USE_GUEST_BASE ? TCG_GUEST_BASE_REG : TCG_REG_ZERO;
 #endif
 
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         h->base = TCG_REG_TMP0;
         tcg_out_ext32u(s, h->base, addr_reg);
     } else {
-- 
2.34.1


