Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA070DE77
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST4-0006Nx-Q0; Tue, 23 May 2023 09:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-0004u8-Mi
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSG-00032f-5U
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so3629462b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850015; x=1687442015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lLJ+OrJ6ZDoNmYA/4Pv3PzTB4pxZ5PUcgKGyl5lAA2g=;
 b=GlIsUA+NU9ZEZb0DZUO1pCi/doCaxMSUFRG9+qdRouYauJ7B5AcHv+G9y0LZyyvvuz
 LlSBVJggCpYHih3N2HJjoN+wGfAGVVOpOCWaLqZpuJjzsh2EelnLPLtZ7QJlO7aGwk0m
 4qoPAY+az/PITqoPqvEJLDBuo3vPeZLDZAma7rpXWZBGyTHaSa69OIZV9DMUa27ewaVo
 9alFtEpxc8GfpM/DwLMpWUkLYo8EFQt4prvI+EpOvsaTyPo872AEVBTerhFDswZEyMbZ
 eJgRcZjrRbgM0pENu2/H+mwIY1f/Pfc4gIJuB94iVOJOaVQguja/sLnfV5zzbA4lVhKX
 F/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850015; x=1687442015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLJ+OrJ6ZDoNmYA/4Pv3PzTB4pxZ5PUcgKGyl5lAA2g=;
 b=CnCeuGpBsB2PskmRQrNXvHpr9hFtMIvsXSfWWKEqA4ILUvPljaoIuMBCv6QFlzSYB3
 Et2pubyzd4JnrHku0b+5DOnS2T3fz+D4jzg5qcEGFxtt0lLyI5OE5R+Qmywi+R8XlUtr
 cw3S+GMFL61pXw5+69a1j55Imr6vnCwvACCK2Uzl39iuiWf4DhlbfLHMlPwATexFjMZE
 yj7AkONnBWx0o6Qen+GUCi5aCk91ZfxE3tpTueRs+gYwcQKRo4Radf6KizZhN4/1RH2W
 myluyU126wSZTyX8t/o9N1G7Vf+wLpU9hVQlTqRoXF/56NmkqQ3dZOI8HlVC47vgoJOo
 UDtA==
X-Gm-Message-State: AC+VfDxWM1FfvLVSf2sISuqIoMZX9YT7cibcTbWFrdEclLAnlWphgh5i
 SpRj96wkwKxPc0o2qjaXlcGiPzBaMpk0BhuB9TQ=
X-Google-Smtp-Source: ACHHUZ5hqoENwVVEYeuWXw8jBRXuA6A6hpj656dTGTC0jxvhM1LL+HtJaOwcCCWJTwbMfMuiZ25wVQ==
X-Received: by 2002:a05:6a21:329a:b0:10b:4f58:3fef with SMTP id
 yt26-20020a056a21329a00b0010b4f583fefmr8923085pzb.2.1684850014820; 
 Tue, 23 May 2023 06:53:34 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/52] target/arm: Fix test of TCG_OVERSIZED_GUEST
Date: Tue, 23 May 2023 06:52:43 -0700
Message-Id: <20230523135322.678948-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The symbol is always defined, even if to 0.
We wanted to test for TCG_OVERSIZED_GUEST == 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 69c05cd9da..b0d2a05403 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -418,6 +418,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
+#ifdef TARGET_AARCH64
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -473,7 +474,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
      * we know that TCG_OVERSIZED_GUEST is set, which means that we are
      * running in round-robin mode and could only race with dma i/o.
      */
-#ifndef TCG_OVERSIZED_GUEST
+#if !TCG_OVERSIZED_GUEST
 # error "Unexpected configuration"
 #endif
     bool locked = qemu_mutex_iothread_locked();
@@ -497,6 +498,10 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 #endif
 
     return cur_val;
+#else
+    /* AArch32 does not have FEAT_HADFS. */
+    g_assert_not_reached();
+#endif
 }
 
 static bool get_level1_table_address(CPUARMState *env, ARMMMUIdx mmu_idx,
-- 
2.34.1


