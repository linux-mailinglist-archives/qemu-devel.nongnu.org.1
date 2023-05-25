Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9A711360
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQD-0008LE-4F; Thu, 25 May 2023 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQA-0008L2-Ug
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQ9-0005rF-D6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53033a0b473so1364170a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038240; x=1687630240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GEPJWGV9qjZFqAWTKDf53jYOVNIumZGIjC2oht8GWBQ=;
 b=MDwVezQKJS3JEjoHU9ug+4DozLugbY3dI7gO7RC3TBiAFtopjKRgqfZX3oJN5zo8Fe
 uVnnhlnGib8vNpSiED6ISoDRgGzMqUANI1xccjBPbBiCLK20dxOYaD0I9QxeQTF8K63h
 yOughAh/ZUoopgO6Lpol+Gr1lhNgOTKuePbjqLzTIa+/9YTYwiVrv6Cb85GFan/mmqx1
 zdG8ST6YGNpD4vQsan3rseyLdb1KVD92BPq+SbjHFc2qu5RNdHxphPwjKBsK0DzCUieA
 UwNW1zD9QJZg0jyfZn9Vt9fO13WYTEnekLvJrVW5TPSXSk7tjUKO831ltjo261tWq9Zn
 Ib8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038240; x=1687630240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GEPJWGV9qjZFqAWTKDf53jYOVNIumZGIjC2oht8GWBQ=;
 b=iVpQlPqOYJCmsRbk+POqwb20EFpFd5IMx41ttdTcvI2PRnUQSlVzY3d+KXW7vpatvG
 fn9b7JCBpISQgrsiFoExRgkXXO9i0IZ805WQWban6cIeTXwXL/0THbD9Tlxrwptei4L4
 /im2dVzO5Z53NaGrJIqXPMZZre5pUFEqNmppopdBAwB2sjKEQIKheWcFHIp2q5SHjgnn
 4ITpMhyiewj3/jWKBuoqa5F5jULob60jD/1WDIJH6tduV60Kifj037whtgmP8BxdAwe5
 L9zB+yUKRvcQEGyePmXj0GYqPxpS62B2sr09jtgFhwyxYAtPze3rfY1oBp5b32vbmLLW
 88ng==
X-Gm-Message-State: AC+VfDzE2jRNua9RrI3wIYmeGc8iyXEg6YoW34LioLczkZKm5zysjcCJ
 frs/5vOCO58lPDGrkVIYlj9wM+UnFC3w7denyKU=
X-Google-Smtp-Source: ACHHUZ6OW4QTf8tP26bv7OAJvQtKpXCHob8M6d67fkS0GfCsPDMd+GKdL0gezleQ/zleBHPMpsAmOw==
X-Received: by 2002:a17:903:41ca:b0:1a6:abac:9cc with SMTP id
 u10-20020a17090341ca00b001a6abac09ccmr2709438ple.66.1685038240135; 
 Thu, 25 May 2023 11:10:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] tcg/mips: Unify TCG_GUEST_BASE_REG tests
Date: Thu, 25 May 2023 11:10:16 -0700
Message-Id: <20230525181036.1559435-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

In tcg_out_qemu_ld/st, we already check for guest_base matching int16_t.
Mirror that when setting up TCG_GUEST_BASE_REG in the prologue.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index f322891797..ccb3a1cd9a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2312,7 +2312,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
 
 #ifndef CONFIG_SOFTMMU
-    if (guest_base) {
+    if (guest_base != (int16_t)guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-- 
2.34.1


