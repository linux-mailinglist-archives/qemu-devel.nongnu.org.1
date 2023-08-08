Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96F77374C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzt-0001PX-L4; Mon, 07 Aug 2023 23:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzr-0001NZ-4S
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzp-0006ac-KV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso4098654b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463776; x=1692068576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfIP5tcDs8OviC0N81Mxzhk3p0beETYinc+feTbvQW0=;
 b=NBZq6U3WPaeS59sHrT8JZG+IX4ZN628sKtQweWvB/KVDPd8aECblcN6YfosewUxTdN
 hktUfcf29KyiURkrXTmffqB6LUMGNrvHZO6v2xKAdQOAnkBU2ESUZK3FW1mYd7WjK1Sx
 KtsrErlgHkQEvZvK2dUAC/plJiKXQQ9Iz4bp5oV9Ay92Fzza07//ob6B+J3fiPul3KMN
 qQN5fnPabEuqF2jE8NriIAZfTdRYCJBZJ/nFk/7zUiLRRZR+kLsqZ++8Gp/p/Yby+ASS
 2KzivUdsHCNUk3s3xZqduxbzs+MSLZW087u7qoDANpGLtn0jP4d2TwEaJwcZqOuwc3dw
 qE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463776; x=1692068576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfIP5tcDs8OviC0N81Mxzhk3p0beETYinc+feTbvQW0=;
 b=ae8MY/kmvlH6DwZvo5FNuIF8yzx8rZAeDr5E0SxNbUOHloKALZpbVT2gzn/hQG7Sbp
 cPBeX/fGLUPre+8i7DqKNnReLcFGB6Pog0cicNGEUzbbBzljg8A5BroZKvWR11TIaFpE
 /H7tx/GhmhKPifsn+BfnuXtHae7984HEXDLJw0KrR3axFFaCzs34ZMtF30TFu99mMUKy
 3ZFFPlbolePRpUyeAk8y65EBRxVSiQjHYp1o67ERMXB73GMhEM7ixMZFXm3mQYXxM01w
 f20OJQ6fMbmgmCO7qM4TGSLcyPxvON341VdZ21eFooVi/xjuaSX23EEU5fA1H/ViAL6i
 TJhw==
X-Gm-Message-State: AOJu0Yz9g04MVbtEtCJ0BnrOYxZBcbHO0EDW+wRh6nP+Y4utYaCwGtW7
 +BcGpWXUYnlc61hEPaBUQaKTg+guznLeKd9Wd5c=
X-Google-Smtp-Source: AGHT+IGr0B9gM4DnKWE6hxq+HHOzJDUlsrru5BmGg6v0dDpPveymzEreRP+6ClZFoaJKSM+viW9PSA==
X-Received: by 2002:a05:6a20:440a:b0:133:38cb:2b93 with SMTP id
 ce10-20020a056a20440a00b0013338cb2b93mr11346174pzb.9.1691463776330; 
 Mon, 07 Aug 2023 20:02:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 5/7] tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
Date: Mon,  7 Aug 2023 20:02:48 -0700
Message-Id: <20230808030250.50602-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808030250.50602-1-richard.henderson@linaro.org>
References: <20230808030250.50602-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The prefixed instructions have a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b3b2e9874d..01ca5c9f39 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1195,6 +1195,18 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     /*
      * Otherwise we must load the value from the constant pool.
      */
+
+    if (have_isa_3_10) {
+        if (type == TCG_TYPE_V64) {
+            tcg_out_8ls_d(s, PLXSD, ret & 31, 0, 0, 1);
+            new_pool_label(s, val, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        } else {
+            tcg_out_8ls_d(s, PLXV, ret & 31, 0, 0, 1);
+            new_pool_l2(s, R_PPC64_PCREL34, s->code_ptr - 2, 0, val, val);
+        }
+        return;
+    }
+
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = tcg_tbrel_diff(s, NULL);
-- 
2.34.1


