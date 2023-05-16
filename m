Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88F7057B9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yl-0006iU-4o; Tue, 16 May 2023 15:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yj-0006hp-GN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yg-0002jW-UI
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-643a6f993a7so9345404b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266126; x=1686858126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEsWAFpnCMYNqvb5yhVEEwYFWaIpTnBv29asu3C8fXA=;
 b=BDwoJPT3tJA8LuDQMGq7qGKQjQ5oLt3zrE1kSuzeEbI8De+ckLxl9kASJIzQSMVm7b
 wQ++4sOO5VpmuI4fez5wyQBXmdy0e7NOCfakw6hhMQNmzIAPmAWeFCTSi9+eKESFWsR/
 CTjMrdaSgG8/iARFPSQVJo7TbDMSorliKJUwFX3x22uamqsHHmQBFfCq/6vt+XGkcIJF
 rXGp+w4iIhVXOrqUpANJvEt7VDZ0mgT+FdS0EzVo9F0KY328wLiorpAtuoZDiA4Fao7N
 7oNQizi5/vAr7kmXG8GfEsMtSO7ESxiKZ8KVJ1XXpMlR8shZUZa2hTfvz2oCLgZsl+eZ
 nPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266126; x=1686858126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEsWAFpnCMYNqvb5yhVEEwYFWaIpTnBv29asu3C8fXA=;
 b=Et9Aa05dwT0ZK5xYiGAoXQAkdJQgi0fJSwNl3HO40/douB2FUh9IOu16zQHp+RU3lW
 Z7tmYBQXp5XC4IvsGYCJ7Lpiwxlak3HpLylYGb8cv/IwT+H/SGg2LMUaSf8SHdfNcqXV
 n2HmASe3C3b7pgJhDLP9g759FsdNfp0QXytHl2DRk0cIBHThsYqRcRRqRvsy5zGQgs+5
 BfLJTWhEe1DQ6hHKEkbwfrInTjP0q15o0hM5YqSITU6exDyWWu2zGBrMQRYQfe/SyNpM
 t3+tnuzhJzRtnBPwe5+EgqyUxAKPReuSB6TIIrx35axRT8b+ANie8PIaVNlmJt/AWCA0
 kGwQ==
X-Gm-Message-State: AC+VfDy27Gr7kJ9AF4EAzzfiMy+33vLQCL5O/sNhtqrA70OIui0cBhxq
 4wjp1wclvQHRa4qpmPhozHbE3TqQHrSq8zwuN2M=
X-Google-Smtp-Source: ACHHUZ54PTY9eBcovUfDzIKjB7pMjyZLa0BroyWUkOZdrrHbEyriI0TXOpWr/z2+8F4WlL1bNA4gPw==
X-Received: by 2002:a05:6a00:194b:b0:647:f128:c4f5 with SMTP id
 s11-20020a056a00194b00b00647f128c4f5mr31552345pfk.22.1684266126154; 
 Tue, 16 May 2023 12:42:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/80] tcg/s390x: Use full load/store helpers in user-only mode
Date: Tue, 16 May 2023 12:40:46 -0700
Message-Id: <20230516194145.1749305-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 tcg/s390x/tcg-target.c.inc | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 968977be98..de8aed5f77 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1679,7 +1679,6 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg data,
     }
 }
 
-#if defined(CONFIG_SOFTMMU)
 static const TCGLdstHelperParam ldst_helper_param = {
     .ntmp = 1, .tmp = { TCG_TMP0 }
 };
@@ -1716,34 +1715,6 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     tgen_gotoi(s, S390_CC_ALWAYS, lb->raddr);
     return true;
 }
-#else
-static bool tcg_out_fail_alignment(TCGContext *s, TCGLabelQemuLdst *l)
-{
-    if (!patch_reloc(l->label_ptr[0], R_390_PC16DBL,
-                     (intptr_t)tcg_splitwx_to_rx(s->code_ptr), 2)) {
-        return false;
-    }
-
-    tcg_out_mov(s, TCG_TYPE_TL, TCG_REG_R3, l->addrlo_reg);
-    tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
-
-    /* "Tail call" to the helper, with the return address back inline. */
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R14, (uintptr_t)l->raddr);
-    tgen_gotoi(s, S390_CC_ALWAYS, (const void *)(l->is_ld ? helper_unaligned_ld
-                                                 : helper_unaligned_st));
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


