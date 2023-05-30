Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CF716D26
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zt-0000s2-Dm; Tue, 30 May 2023 15:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZW-0000kf-RM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZV-0000sH-D9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d577071a6so5632288b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473192; x=1688065192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRUS/B+lej6ghv4TKHMjTIjQnBzjJiFZ+pCmPDNBTdA=;
 b=mjhx9WFjfV5cNMTRqD6D84+JeNCnrRWJa9x5TCjd+UIXpM9XHWMsDuT87YDk7JOEhd
 DTfVI5KMBRJxzyXi6qRlLqkK+3e5VF4W2i/sKo6LOZ3u2Jl3/0Zcw8JfMPRrpbrU+n/o
 ao/qSv4hDiNV29fkQVqMCLQdi695tgZsd0iyDcMz0Q05NS0Pju8OF+kb+qEVUxusfJHV
 L2VIOmOeZlnWflkgEX6D1W3kNX+bPoYK2W4iHPoQSV2t1ptKjAg1ZCiIIP55kcK3ptFq
 bFFq7bY+k+bvZivW6WiVRg4ZM2uMKyClqeMDZcP2H38sad9XdohyiUwqJwTnlUJErkKm
 x5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473192; x=1688065192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRUS/B+lej6ghv4TKHMjTIjQnBzjJiFZ+pCmPDNBTdA=;
 b=I3Xe/rYtc7czTzQqV3+Ef4+9gEj9iCZGN5j6I7LIrPBSl7toR3/c4TLW8Dq+NY3bOt
 lTLZbXnTw7hwT0Xy4KQwyKZXAc2FFOhFAk9HIAOaib+96oFKW81V5lXf2Y7oZUgHNqj6
 pgDBh7Jcziag2EdWwZMQTJicpwbHMaByRf0XGMhm6nxnAybamnx0jmIdJe4AL9AEdlhO
 5QM3T63R3iXZx/4fgyRZyIrsJyKjOQoiSjFFMR986JJmTeivQLh158xZkbNRLfLzkwpz
 enj/KQe/Z63rV2XtNrUSOmk7uxqHjdCGEetSEJSe1+kuPQWjSHs+ekx881hgKGHWThnv
 T++g==
X-Gm-Message-State: AC+VfDzrOJFB/H+wWf+k1yWraLysN44IMCvOPLFmXbF+wjrcFUmMekkE
 3jRWPqyNDNHKu86xVmLFFFXEgyR6UMHPUq16e20=
X-Google-Smtp-Source: ACHHUZ7isF+VEONPFPQBpDT9P2OK+0soHN66yE2kXi7H8gfr77HQI3y3Th9D5iJefTQDJzFrUGjgZQ==
X-Received: by 2002:a05:6a20:a386:b0:10c:dd4f:faa9 with SMTP id
 w6-20020a056a20a38600b0010cdd4ffaa9mr2750980pzk.14.1685473191835; 
 Tue, 30 May 2023 11:59:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/27] tcg: Fix register move type in tcg_out_ld_helper_ret
Date: Tue, 30 May 2023 11:59:23 -0700
Message-Id: <20230530185949.410208-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The first move was incorrectly using TCG_TYPE_I32 while the second
move was correctly using TCG_TYPE_REG.  This prevents a 64-bit host
from moving all 128-bits of the return value.

Fixes: ebebea53ef8 ("tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/tcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ac30d484f5..2352ca4ade 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5736,8 +5736,8 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
     mov[0].dst = ldst->datalo_reg;
     mov[0].src =
         tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
-    mov[0].dst_type = TCG_TYPE_I32;
-    mov[0].src_type = TCG_TYPE_I32;
+    mov[0].dst_type = TCG_TYPE_REG;
+    mov[0].src_type = TCG_TYPE_REG;
     mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
 
     mov[1].dst = ldst->datahi_reg;
-- 
2.34.1


