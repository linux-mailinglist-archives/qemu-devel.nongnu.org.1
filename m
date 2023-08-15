Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542777D3CD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Av-00059D-PR; Tue, 15 Aug 2023 15:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0At-00057Z-1G
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Aq-00014m-Os
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6887918ed20so321727b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129471; x=1692734271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2a12Z19iXsASCqZDsR31Txy9HCN36MK3mWzwcxfOs68=;
 b=glcOeLGmS1pANxTeXrZnAv2hfWb/QJxbm0ypXqKLAgXseZrAvGMGO7xMVDDXpWFnT8
 QWHyLes3m5Jihh4dDG8BgtsLQZpXy4hcvYREl3ROHly6OMcb38Uvd5QuwgLg6AoJepqv
 VUL05eMencyEeDfr1bKVEacIDVOKvqKaWwh0OZZH2CkGyz7FUigbADIjAWpdOeb/epWZ
 67Bml6Q0Kcpu4f+DUUMA7GlJ9IozEk2ArRoywDzmFUcKZrjtX2KS7Rps1gvGKo/Zn+CP
 ksiAyC576xdQQVkLPGDS4wDCwebb2W6Gk5N5nqx/y4t8cTtjUU5ub64pJuBTPcrsrBAl
 jNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129471; x=1692734271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2a12Z19iXsASCqZDsR31Txy9HCN36MK3mWzwcxfOs68=;
 b=T+skLMNrG18QYRzpUhYKTWACNddErYAl3n181iDzO3AZx2brcgc9PL4R4ITZvHWc4C
 0I4VWFg5HzaTOylPn8Asxeh7BpYFtCpNiSVaDvfI3t+OcE0UsKl+lmV7N4YrlTnYvOUm
 PHvBZwyDY3qkk/7EWRusnQdt/RudWoLb/M8f/WuPNywnfaR4l0mZvAaIJMn3QlgSgeO7
 YwYy5rcXwFESApD0nLQ2a4lIjpS0EL3rW/zXviTlYPTo2eWXgW1wvVgMSoggQiBGHn5/
 igfUet7sLbbk5BUKrORCcc5ewND3qTz5gUlBVcxXevoTLHiTVOb3VxJPpPjeGfsCfcYk
 dPBw==
X-Gm-Message-State: AOJu0Yy6E6WbhEu40Nd7aMwUUcq4z4zD37vUClKTBnOYGSsBpOjWH6Mj
 gZ4cksm14WSSRy3+nj/p1wM5uLb+qfsfu5dSy/M=
X-Google-Smtp-Source: AGHT+IEhybxdv4IEQf/HGShZ7x99/DkHed6uKyJln8jaAkszcM0ffnEHdlBzJjuQrY9hBgzpiPtH2w==
X-Received: by 2002:a05:6a20:42a0:b0:129:d944:2e65 with SMTP id
 o32-20020a056a2042a000b00129d9442e65mr20044110pzj.13.1692129471107; 
 Tue, 15 Aug 2023 12:57:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 08/14] tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
Date: Tue, 15 Aug 2023 12:57:35 -0700
Message-Id: <20230815195741.8325-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index a5c1891eb6..b7d1b4f1bb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2548,6 +2548,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
 static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
+    int16_t lo;
 
     /* Direct branch will be patched by tb_target_set_jmp_target. */
     set_jmp_insn_offset(s, which);
@@ -2557,9 +2558,15 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
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


