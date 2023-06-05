Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F9723115
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcQ-0001kr-5b; Mon, 05 Jun 2023 16:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcO-0001k7-O4
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcM-0003jW-Us
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so1323097b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996153; x=1688588153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcmNUB/rD8+RMTN7CuMT/6LH8d8g+czDKBZHxrJ+ObQ=;
 b=m+Wq5v2SkSBrJOLUngK/AWCHuYUBdfeQdJu2ZWYKY7nxNrIAtdsek5XQtHwIa0ZrDW
 0Icmm7gv7DfrpnFES7pu6taHWDWCzWUdR0JfT0+A3uPa5e8n52uS69Ys0agP8XSKx45N
 dCkdzlRWwQjkjNLNkJcVRrjeuChgxE8fYT9aN1enyS5NMpzu70ozDqGbwYn93SLJ1sfv
 rSrZKxFtiAWZQQcm2TkK+N/prBqvgEf1h2Mz5vFTBgm2gc3aA+rAX7Pij0eCTpINCtqi
 Xw6XOI17vhdGAkogv8Bnpj++7xNf58yEkZZdggV+EN2o5HScxRj8Vl9n1SBlvUg9abi1
 z5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996153; x=1688588153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcmNUB/rD8+RMTN7CuMT/6LH8d8g+czDKBZHxrJ+ObQ=;
 b=YD/2XkPUcrYVRFKXdkKf8v22bfFVC3Pua22cRsJzHQRZ/zKpEakqVjXC6/MeMZ+JqK
 InF1pW21wwQHmTYFRw1oisdB7tWSO24htZmengt8qaPRR4NJoKjMkaSGTlIFsoUeY5bt
 8WL8VntAnIIya9Ka+bTR4uOdP8lF3194SE5j10sqPDJOI45gSdWiyLmtbjh70aW6lIEk
 8WTldRIzn9uss9D8KVuH2WlEOd3ODulGA22wTR1NoNfMDvA9v+DSqYga+uTJCdX16is7
 e1J8fIY6ZlZrmkzz6JY+9i2RuMNT8uRcz3io0Jc2/vhBHMwV8wVwQ45Qf335qC6wR7+k
 omBQ==
X-Gm-Message-State: AC+VfDyS02h3t9Q8fSwvN5HZ6DtHsE/qTSsx9FrJh+XA/satCcTv9Gju
 wsiGgsQvsTPI76C1i77QE5OUKNkC8bVMABw7rCM=
X-Google-Smtp-Source: ACHHUZ5CRkPLjBmOkdm3EJB1eheSPv3XrvTfI9nvGSNmvb9wSDPHMSCQwRt2LiiDZBLBCU2ZC7gH0Q==
X-Received: by 2002:a05:6a00:22cd:b0:656:6d18:3d83 with SMTP id
 f13-20020a056a0022cd00b006566d183d83mr952836pfj.7.1685996153521; 
 Mon, 05 Jun 2023 13:15:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/52] tcg/s390x: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Mon,  5 Jun 2023 13:14:59 -0700
Message-Id: <20230605201548.1596865-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

All uses replaced with TCGContext.addr_type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 503126cd66..2795242b60 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1745,6 +1745,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addr_reg, MemOpIdx oi,
                                            bool is_ld)
 {
+    TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
     MemOp s_bits = opc & MO_SIZE;
@@ -1786,7 +1787,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
     } else {
         tcg_out_insn(s, RX, LA, TCG_REG_R0, addr_reg, TCG_REG_NONE, a_off);
-        tgen_andi(s, TCG_TYPE_TL, TCG_REG_R0, tlb_mask);
+        tgen_andi(s, addr_type, TCG_REG_R0, tlb_mask);
     }
 
     if (is_ld) {
@@ -1794,7 +1795,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     } else {
         ofs = offsetof(CPUTLBEntry, addr_write);
     }
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
     } else {
         tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
@@ -1807,7 +1808,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, RXY, LG, h->index, TCG_TMP0, TCG_REG_NONE,
                  offsetof(CPUTLBEntry, addend));
 
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_insn(s, RRE, ALGFR, h->index, addr_reg);
         h->base = TCG_REG_NONE;
     } else {
@@ -1830,7 +1831,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     }
 
     h->base = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
+    if (addr_type == TCG_TYPE_I32) {
         tcg_out_ext32u(s, TCG_TMP0, addr_reg);
         h->base = TCG_TMP0;
     }
-- 
2.34.1


