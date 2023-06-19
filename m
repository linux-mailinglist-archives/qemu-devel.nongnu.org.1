Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EC735970
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnM-0004Fz-J9; Mon, 19 Jun 2023 10:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnG-0004E4-Li
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnD-0000kl-FO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f90bff0f27so12017835e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184621; x=1689776621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pwqG4bOndCwR7WWKOm2/D1bdEjIJvQWtHJFzguX9raY=;
 b=wgMAUfaq3czt70PcOIIf0zuUDTpaGVvWHb2rTR92yNK5umgGeahY2ube/nakNCj+kF
 B1RyNPF1T+o3xvxGJwJv4XPuDSqtNtjFXL8HC+cbS8mqHFehzUYBmYGPy1IQkJFiRFDO
 zg4eWXCXG6Apa+GxWfT+D7p8ukViSSCxt/kCzz+wjYPX2JOCuZ0BOex6JS4YrGa9C4bw
 3i5sze2VlCm0EhBgkxGHARd9c6OY4+9wotF9bt1tgQ+1x7P6fAI+ESp9kOT4zwUb9V6F
 h8cUUaH+yWASvGUvwAnGUiLRNyql18DPjwGDcy/SJoEADXQhE9cTLe9BRLx/4FsWlnJt
 7GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184621; x=1689776621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwqG4bOndCwR7WWKOm2/D1bdEjIJvQWtHJFzguX9raY=;
 b=QR3sAgIhnWflHl5QqP/ZP58jm3MSFsvm66Ucq5DwvqiLvldOGb4Ushinbei5PCaPmf
 Z0SD0mv8ePrrN8QGIEu/0zcWKEh+AvYKHfhh1hytqUwaSEv31NqGVqNqK/gcAQcUPkBP
 it7bp1OtR3af+UsVyfi/94CVZEGo2L8+pu+ywTGqpoM61lO7fBVmMdcX8qRM3i698USo
 NLFISAUznlp6fWzbZkANQCBOz6DmtqQLLT59e9l6p+ygBeB2IszmHRiHYlwgvh4yp1Ya
 mJzfODDBX7wLDbVLo/SFyNEkVjEijkKbb0oj7Y5d72MLoR6brMlewyFBRUtlE2HKGCAT
 +T9Q==
X-Gm-Message-State: AC+VfDwFGeHovCorN5EybXviWEtjO1/tg5Gd+Cj4O5qP8fPKO2Sg5Iz/
 ZxvhTG6AuymE4pcwIlPSEMyQqBx9C98Z0RP0+3HPFkMu
X-Google-Smtp-Source: ACHHUZ5pQxmA4WgBd/NCYWPaCU2GSB8nFxtW1Xk2qvcNgIl+omyqQUSAi8KORW1LZ8gMApUrzaexSw==
X-Received: by 2002:a05:600c:3799:b0:3f9:b540:862d with SMTP id
 o25-20020a05600c379900b003f9b540862dmr278293wmr.28.1687184621344; 
 Mon, 19 Jun 2023 07:23:41 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] tcg: Elide memory barriers implied by the host memory
 model
Date: Mon, 19 Jun 2023 16:23:31 +0200
Message-Id: <20230619142333.429028-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Reduce the set of required barriers to those needed by
the host right from the beginning.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..574001c221 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -115,7 +115,11 @@ void tcg_gen_mb(TCGBar mb_type)
 #endif
 
     if (parallel) {
-        tcg_gen_op1(INDEX_op_mb, mb_type);
+        /* We can elide anything which the host provides for free. */
+        mb_type &= ~TCG_TARGET_DEFAULT_MO;
+        if (mb_type & TCG_MO_ALL) {
+            tcg_gen_op1(INDEX_op_mb, mb_type);
+        }
     }
 }
 
-- 
2.34.1


