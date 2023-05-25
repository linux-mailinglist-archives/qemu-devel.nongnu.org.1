Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D4711AE6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Kjo-0006Gy-Qw; Thu, 25 May 2023 19:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Kjl-0006GU-UT
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:51:17 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Kjj-0003Ns-PU
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:51:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-52cbd7d0c37so85475a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685058674; x=1687650674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=grxtGqzdDW3pij35DCIXzbwm/3Rbmj2aBugCYZSOGiE=;
 b=kFyu/NBMrE0qXF+yPkuk3RXNDVN1ecK5QimHPjG3DjuRssf0GEcIYFRJCYC8oCwtS2
 RKKcxE0qmurOSLnNbDRgRPr83N7YiJKx4Zf2hxDNdr+ZpdIvRmvBYOqDIrVuZSexJkp5
 cuuT+gRL9CakkG7ReMZjh4pBPr+JdobdLqkeH+hcswLBAvi2bcP5XHMOHjxMFITVKRQ1
 3EjtFNpCvpif43iD/szDLTy6au0LWah9S6tM1yMbT81XsAaJeEK/hXpAQVhwEJ+rg77z
 dzZrH89PGaCcBV6PXN9HQc/XNZmUkjYdIklcpd+m+eFSkqO5PB6OlPu36SSzJ9viF7RT
 HXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685058674; x=1687650674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grxtGqzdDW3pij35DCIXzbwm/3Rbmj2aBugCYZSOGiE=;
 b=LMEHozOUxqum2L0hZhXUosJX8rmClri+L/zSjuafxYyoD7jmQ2bj5l5wwKqIBQDQ0I
 e64LxI//WOfPGH9NB5XyH4xwngnHK3mtblz5h40e0fiJ3U2sCuR8+HHSGIKmhKIw5JAJ
 b0gWGwPiza7k9S4q862z2m0bqkqK7MENclZ3gHq/ztYxnFrFOJ0Uv0rAThvQSSMPSSIA
 IWVRVn4ANvziXR9EQNhKXUEQsaRgtemh7nnDSBRmhla3jKvh/5WrfXpd5v32fwuazUD+
 7cgtnc+7zwGMIWnwSeuBQGGB75xGHWyxz7yNaGR/y0+p5CY28HxTgPfLNyp5OMuh9xry
 RKcg==
X-Gm-Message-State: AC+VfDytLOQtzvI2lII1tBINgexHiQVjBVxxVRmd0Gdd9JHw4NA1j12m
 4ZSRKuLijK8tQbNpMbFqsFa6SZSwSCCqFrqQiek=
X-Google-Smtp-Source: ACHHUZ5slsW/RD9dPnDO/y+NKbhbPjqhuL4t0ZPzVRyQcp1imu0TlvXTqpXBC+D11TG238MqmqpVeg==
X-Received: by 2002:a05:6a20:3d1c:b0:10f:bb1:ca50 with SMTP id
 y28-20020a056a203d1c00b0010f0bb1ca50mr5086601pzi.10.1685058673885; 
 Thu, 25 May 2023 16:51:13 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a639313000000b0051b0e564963sm1653141pge.49.2023.05.25.16.51.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:51:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Date: Thu, 25 May 2023 16:51:12 -0700
Message-Id: <20230525235112.1759488-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

PAGE_WRITE is current writability, as modified by TB protection;
PAGE_WRITE_ORG is the original page writability.

Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 0f6b3f8ab6..57163f5ca2 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
+    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


