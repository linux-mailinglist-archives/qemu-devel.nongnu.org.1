Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FA7057F5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eJ-0002kN-V8; Tue, 16 May 2023 15:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cK-0000OX-K8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:53 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0003mf-1j
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-52c759b7d45so13442521a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266347; x=1686858347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEmipnomtWF/XOvFu0hq64ZuWqb9TMH4BLWDViQ9M4Q=;
 b=g+w1sMesltXUG7tXcGv+EGEIQRhSNOQCeVSiFrCB6ZgiRX1iZcAZoh7VZdR8aF0ZF5
 Ynuf2898tUuF6NAqL6YNne2NhBY/C+2/F2QzE11BQTRKKhoNvmNPWwe1sZMT8tH851XR
 fxxM6vKy09+cDNLqqRlk72Qm0Hp+3btOg0IVdXza1iBNTPQMJvzHrDDiNfJ7l7OGnrd6
 /nqP2D/zPGlwDz9oWKiIDPYI59UstoRS4P4nAqW6y19jZyg3uA2vRlqTOOk+0x9Dl6mG
 fBU5P1zSZx7vpFPQXEphtcTHWe5F5LkVB4BzY0x0vJdWR2dZSardl9dMeQeNauTP4P5D
 qlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266347; x=1686858347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEmipnomtWF/XOvFu0hq64ZuWqb9TMH4BLWDViQ9M4Q=;
 b=WZAeTq59w3fdJoCSmNgpau5pjwm5BsD2zLezgJ/e7XBPRPa9GZa3xkPDdd09RkInk8
 lyG1nsLU5hf3oy0kvKZ8vGpxseWrNSVf5cwvx5htmQA7Uf2xGF65/YkFFOGzdprS4TEY
 U4/20gbUHvSVHHOwGhI2lpJUM94zS92ycbn4x1F+X1uBxXRQudiWR6ruBCBla5newtIm
 RZtDXbQFSLewiR0nFAI333v73usNdxjYTFbKUNS6Bn+gCCbQLgNSloT8E8CirFPYWFPk
 0+i50Hvw3Fxv/uZVQcNnva1qnt+jEpvNO5D5Ma5qPey24UmWDb9t6cL/8RngLiDWevcA
 qmWQ==
X-Gm-Message-State: AC+VfDydVmVeAIF2HTqdvvsk8E6vurKO1kMCFI+DJiLA1Fpdvowohkam
 sSFhUq9VqcnIO+65kOZv2X2pEJSjoEqs9ToDMFU=
X-Google-Smtp-Source: ACHHUZ4ODS9J3t8m0ux9tiSsOa/4VrKZCKpQjQNTcdRUhc4DsUqNcSG7mK6qgrcIR72w6QlTplRfbQ==
X-Received: by 2002:a17:90b:4b8d:b0:253:27b4:cd4d with SMTP id
 lr13-20020a17090b4b8d00b0025327b4cd4dmr2392078pjb.27.1684266347030; 
 Tue, 16 May 2023 12:45:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 68/80] tcg/i386: Always enable TCG_TARGET_HAS_extr[lh]_i64_i32
Date: Tue, 16 May 2023 12:41:33 -0700
Message-Id: <20230516194145.1749305-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Keep all 32-bit values zero extended in the register, not solely when
addresses are 32 bits.  This eliminates a dependency on TARGET_LONG_BITS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7f69997e30..7ebd6e5135 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -154,9 +154,9 @@ extern bool have_atomic16;
 #define TCG_TARGET_HAS_mulsh_i32        0
 
 #if TCG_TARGET_REG_BITS == 64
-/* Keep target addresses zero-extended in a register.  */
-#define TCG_TARGET_HAS_extrl_i64_i32    (TARGET_LONG_BITS == 32)
-#define TCG_TARGET_HAS_extrh_i64_i32    (TARGET_LONG_BITS == 32)
+/* Keep 32-bit values zero-extended in a register.  */
+#define TCG_TARGET_HAS_extrl_i64_i32    1
+#define TCG_TARGET_HAS_extrh_i64_i32    1
 #define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
-- 
2.34.1


