Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1170581C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:58:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eQ-0002nh-Bl; Tue, 16 May 2023 15:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cM-0000SW-9V
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:54 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cJ-0003n5-GM
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:53 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53033a0b473so7584050a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266349; x=1686858349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gd23/Zs47HSFuLNvqC9U/DMCSd+WEyq0LmTxbksagg=;
 b=F2Wlvsb1w8oRpkyCeogTBk4vdxj7xiWr/UpmWDUOLe5PIKSF/VWeeQHt7bmafQgbeC
 zJtRCcX2abZnSzVYYOT16QP6pi4LMbRl9l87OEa+4XB9rAnpkkZlsYWnKArw1BcaL9dz
 J3tVdKBCHdr3Axhin4D8uRomoHIXNIRVL/PuhHVDRVNkGMXVynve5oj8oNJj8BA5V0nD
 0mB33nWRpTE/DmCeKZtbUZ/MZDmslH5lttat5b0k/ETwhDr0xWiFyM7v9JawrYl8HFmt
 P+nDtqAaPkQeTd5XYl7kxngetUe2a4xBuZV6YwRhmYJyWhhV/4feJ2QBF9RcGQL4hCvv
 SMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266349; x=1686858349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gd23/Zs47HSFuLNvqC9U/DMCSd+WEyq0LmTxbksagg=;
 b=Cxagq7eh938SdvAwgUXBVj9j8m/KIn4SuoWfBKZ45lvsAjWvae16noXOXrissONZge
 IxuQc4tHuXxZ969XWO21E6QvND83i3naacSsCRoLIQ5xF7DpLwerRhDpqclfFrXOopFC
 OVL8WQZAdTlNjnJHFhfZgszQulNVlh5BUIYB5Sjcy9voRGavl+estiYQnkupUIY34P7f
 VFU7uvQ24dVCQtEgUdaiBtWf+sxbkqfKBM/+EWMLgxZT9FkAMdeHeh8pqPAwd41I9wpa
 SDgbzPS2motvj5jjp6kfpI4FQlEsmG0YmD8N5wrpYDv2Pk7+fMFWw3R/Ic5+OhyJ3WMU
 l3Gg==
X-Gm-Message-State: AC+VfDygBSQp83BHmwn/J/x8WAvkJnKjotr7oh0JMU/s7gCFA76kK1Au
 /JqcNwmfsgV2kT06+XLAh7X8zU5r0k9UxN/sxyg=
X-Google-Smtp-Source: ACHHUZ7F+ZRo0NDwQP7+eK9K6Y+aHTVsG9MyEYO7ORQACG9JvdaciNT1QZ1Yc6kVu3T5Iz/wTBj8zQ==
X-Received: by 2002:a17:90a:8d16:b0:250:faff:e201 with SMTP id
 c22-20020a17090a8d1600b00250faffe201mr22140072pjo.36.1684266349357; 
 Tue, 16 May 2023 12:45:49 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 71/80] tcg/i386: Remove TARGET_LONG_BITS, TCG_TYPE_TL
Date: Tue, 16 May 2023 12:41:36 -0700
Message-Id: <20230516194145.1749305-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

All uses can be infered from the INDEX_op_qemu_*_a{32,64}_* opcode
being used.  Add a field into TCGLabelQemuLdst to record the usage.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 653e3e10a8..e173853dc4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1975,10 +1975,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrhi_reg = addrhi;
 
     if (TCG_TARGET_REG_BITS == 64) {
-        if (TARGET_LONG_BITS == 64) {
-            ttype = TCG_TYPE_I64;
-            trexw = P_REXW;
-        }
+        ttype = s->addr_type;
+        trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
             if (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32) {
@@ -2023,7 +2021,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->label_ptr[0] = s->code_ptr;
     s->code_ptr += 4;
 
-    if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
+    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I64) {
         /* cmp 4(TCG_REG_L0), addrhi */
         tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, TCG_REG_L0, cmp_ofs + 4);
 
-- 
2.34.1


