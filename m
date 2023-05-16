Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA87057A8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yf-0006fv-RW; Tue, 16 May 2023 15:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yd-0006em-TD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yc-0002o7-9Q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64384c6797eso11570414b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266120; x=1686858120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxeAK+0nBaqYYTLaoVSvaQrIxJ38Tit6zinqkGACFIA=;
 b=NFm9K4dgx5Kc5XkcZQuKi1605ciD7QY8rkhN9cCutaGeWpq5uotC5Xh1VNTNwGwL5S
 XlPJjROa6UV1Uzpwm+ouJ7RYNEfvie9mkyTgetgHIdtEJns1Oa+fspOdjo6lGR8vl53y
 mPm1iLDwNC8uKn4L8opL1G86lDwsiEyERG4JnMUDcnsznF7D/gQmvrOiDPDQFAhYAoeg
 Sl9UkAhPCULWI7Gp0P94w7OG0IgtA5+H+sUIUU/Pw/xB4zd7+xZfkO5dm9Keiz3O6H68
 CkaNkHZW/u/FAktX0QpdnufmOSf8OthnfrGfS6WH2efC5Br2K9WxWSXMD4cCdq+TTYhh
 YEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266120; x=1686858120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxeAK+0nBaqYYTLaoVSvaQrIxJ38Tit6zinqkGACFIA=;
 b=JOE3qdu9d9ft5Dcu5t8MbW+qVX8GzBLK6kXo0J5tl8fgcSRzCjuSycoO/qqlNz5bC9
 crcqengzmT9MWIlhx6r6qGAfGVJN/334mMDN4Ap4msj1QxiQxqFPwZrjWzsxcydJ/ni8
 6H28n+o4TW8UdV2FHrwicx6WUqmVXr8YPJhO3egVV+F7lmxbaW6+wfEbvXnu7HmyFB0/
 FfVWkfhigB1jOWGVNF1hsJpHf1zugZkexAWmqju3vC/w3MrCd4/gIuB20vkWIJNfppQY
 Y/vmgzLI/01nb2wZzs/mogckIP112mSwS8818SWrDvqQDK9FeZ5bj8JjXHj7s7h3UpIg
 y4iw==
X-Gm-Message-State: AC+VfDwYxF7swwygZ5RZwUjuptN16skfgu9A1+7LVPTB0RmjpZ+RY3aX
 rxI9cMWF/IAkThlJkSrMPJ/5osZwTqJ4lK6wHj8=
X-Google-Smtp-Source: ACHHUZ41g9lhWsqaSyW9HrcXZoqOd5z634GR+0wZdXOrs9ACLgr1PSCcoRPULlrqDbQB+FfNHCkHJg==
X-Received: by 2002:a05:6a00:2194:b0:643:b653:3aa with SMTP id
 h20-20020a056a00219400b00643b65303aamr46908229pfi.32.1684266119894; 
 Tue, 16 May 2023 12:41:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/80] tcg/aarch64: Use full load/store helpers in user-only
 mode
Date: Tue, 16 May 2023 12:40:39 -0700
Message-Id: <20230516194145.1749305-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Instead of using helper_unaligned_{ld,st}, use the full load/store helpers.
This will allow the fast path to increase alignment to implement atomicity
while not immediately raising an alignment exception.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index c64606af5b..36d8798bca 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1595,7 +1595,6 @@ typedef struct {
     TCGType index_ext;
 } HostAddress;
 
-#ifdef CONFIG_SOFTMMU
 static const TCGLdstHelperParam ldst_helper_param = {
     .ntmp = 1, .tmp = { TCG_REG_TMP }
 };
@@ -1628,40 +1627,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tcg_out_goto(s, lb->raddr);
     return true;
 }
-#else
-static void tcg_out_adr(TCGContext *s, TCGReg rd, const void *target)
-{
-    ptrdiff_t offset = tcg_pcrel_diff(s, target);
-    tcg_debug_assert(offset == sextract64(offset, 0, 21));
-    tcg_out_insn(s, 3406, ADR, rd, offset);
-}
-
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    if (!reloc_pc19(l->label_ptr[0], tcg_splitwx_to_rx(s->code_ptr))) {
-        return false;
-    }
-
-    tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_X1, l->addrlo_reg);
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_X0, TCG_AREG0);
-
-    /* "Tail call" to the helper, with the return address back inline. */
-    tcg_out_adr(s, TCG_REG_LR, l->raddr);
-    tcg_out_goto_long(s, (const void *)(l->is_ld ? helper_unaligned_ld
-                                        : helper_unaligned_st));
-    return true;
-}
-
-static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
-
-static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    return tcg_out_fail_alignment(s, l);
-}
-#endif /* CONFIG_SOFTMMU */
 
 /*
  * For softmmu, perform the TLB load and compare.
-- 
2.34.1


