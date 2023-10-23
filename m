Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078D7D3EB9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQz-0005Xn-Eh; Mon, 23 Oct 2023 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQt-0005Uv-TE
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:44 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQn-00085V-TC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:42 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3574f99d260so13874505ab.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084817; x=1698689617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=SNmNGQrN2g5O35Es58hxTzmOLL9q2hKtJA0yIwINGZ2l0ovBLQPGFm45yygM5XJuxC
 845d7CINs+EX2B8iWes8TCWMfGJ9yb6HlJFCreSzKjIpL6wQLb6ga0EEZ6yAsFhVhR+C
 l4HLIfmjumx0lOPmTgmGIaRzzvVD9H8DAK9Ouw8ZcRVHAb71X+yKNh51u+9cWdZhzB/n
 tf8M8zhAIRwN+hNffxmkO9HbRDz/AspF4y+ZDTEDSIYYU6Sxqpqw4d/5iN2kFeS5clv8
 kSzSBdlyy43rxNCaK5r5oHttULYtF4G2jKurDrliBt1honO4y3hMeqRRqt+pueca35z7
 jMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084817; x=1698689617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6ypWKYmP3E0vSS+zdR/mRhAnNRJOT7ENlr0UKfEKr4=;
 b=q+58CLdO07+risDag70Tepy2Q73qLRiFkDM2iMDhh4G8AFPBYwnT/g3leyEBmetm57
 4aBiwHNjeFjthA4KH6VLQVAVK1AVJiJuw6JPP/nKgpYeiFvTD2dPzgfV5ytVKK0gxBVr
 tX9NkOUkkp6vdxD4VVXT9Udib9Q8TP41vWe9qCI4E40MjSQiV761+PEAt6WsItXKNuCr
 0OOVpx00/MoPDRes0RpuKRxk+uBI3HdZxoHWucHbYkrYI5jJHxmNdBa90QjA2AkUdavD
 FGHnSEFkP+ouBi7dKTCXkBjK2ZWM+h/ZtRUUY/X4hFzGKwiEBEtFe07VUI1QVpD5Xv3D
 d5RA==
X-Gm-Message-State: AOJu0Yx1zurbVXbhW9XnJvpGf57WQxQEq1JqTS21eivTfERr5IRDOq0g
 XaZI8jq9H4AM8mzOG0day14Ektq/A/buBNAL6Vc=
X-Google-Smtp-Source: AGHT+IFlxnPyU3U5+5KGGqbtqkuODatPTkYq856PXRC/Sladmc11dbzTaUjARe7S0WqEHy46nxbmiw==
X-Received: by 2002:a92:c248:0:b0:351:b22:af5c with SMTP id
 k8-20020a92c248000000b003510b22af5cmr12775741ilo.32.1698084816853; 
 Mon, 23 Oct 2023 11:13:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/38] tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
Date: Mon, 23 Oct 2023 11:12:58 -0700
Message-Id: <20231023181329.171490-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 720f92ff33..6337b1e8be 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2593,6 +2593,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
+    int16_t lo;
 
     /* Direct branch will be patched by tb_target_set_jmp_target. */
     set_jmp_insn_offset(s, which);
@@ -2602,9 +2603,15 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (USE_REG_TB) {
         ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
+    } else if (have_isa_3_00) {
+        ptrdiff_t offset = tcg_pcrel_diff(s, (void *)ptr) - 4;
+        lo = offset;
+        tcg_out_addpcis(s, TCG_REG_TMP1, offset - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
+        lo = ptr;
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - lo);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, lo);
     }
 
     tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-- 
2.34.1


