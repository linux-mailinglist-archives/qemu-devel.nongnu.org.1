Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C02723143
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcf-0001tK-Ln; Mon, 05 Jun 2023 16:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcc-0001s2-3h
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcX-0003qB-F2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so2567672b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996164; x=1688588164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsSQnoabB8P2vFjJIJJqaM8+MtwtaRqODWT37hxDvOk=;
 b=BxvpNATc2Uga40umd7ZZRKUSLa0+8FOeWTcNrqpq2IO7pjRmICT3xxU84Ch66Ram5Q
 SduQQ4pmvuwxqn0CMCMxUgxLQRa5dKQ+5XrhEnCrhOWzRFFnNGoa409eABo7y6YSeEa/
 xZjCsueifYcTqTckmJcYYBXQRRglXSypgJmCEOzdahT0zEGZkxQjOVfe3HmEi1evY/vE
 zOs5BeKQu1CZ+UxWPXhxjYkpP0bkqaN/5A28/t6Vt9FtHeboF8qH+X/0EIUFOazZOJx4
 LgOHhZ8jRcbqeuzhaW6cHBSiXW+4yRqOsGuugsREFtfjeW957J/5Y74eXTerfwis1+pC
 J8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996164; x=1688588164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsSQnoabB8P2vFjJIJJqaM8+MtwtaRqODWT37hxDvOk=;
 b=QsyHk9MmjxEYfT1G5QBSgfAcMN8pIltBZs3Yogxe2gtEpF3XzA73zxE8QYE2eWZkCy
 fZQ2ZLuzz0fq7qo9AY5PVDj0QDKaTAVvO38zAq89owGwhq2oWEV8erejBZh31zTqfNs/
 o0CKzBlbqcW/I/6ZAEl+kXCbZ7aett4IKwV/HHODK2AGukki813REIMlgj3ZlgSgSOGo
 mOg5g734zFvLp9DbDrqgrrbkIIXrpNVqxZ34BXvW/S+Jusi5/sjdZ4kPOcxDv0Hzpr8R
 BUeYhQRY9g5FWNIBN8oSCT3dJJsZF5eTs/PEmJFJIgk4rNQp2kjpUdpngsDMGnPbz+P7
 WkbQ==
X-Gm-Message-State: AC+VfDwmgvK4n73abjSs4aubaCrDCOrIHmHD5AHvtTpNIciPFHNrtWjC
 Nke7cNY7EC4tmeRFEqccCLZcDeskG1yn/Zl+fNU=
X-Google-Smtp-Source: ACHHUZ7Us0b/syoxjSA7coEjnKJQwBmYkJHYmXjOR/JHutPXJJ7o6aQt4czfA6oMyjhOik6c18LALA==
X-Received: by 2002:a05:6a00:2d04:b0:64d:b0d8:a396 with SMTP id
 fa4-20020a056a002d0400b0064db0d8a396mr1013185pfb.7.1685996164678; 
 Mon, 05 Jun 2023 13:16:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/52] target/arm: Include helper-gen.h in translator.h
Date: Mon,  5 Jun 2023 13:15:12 -0700
Message-Id: <20230605201548.1596865-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This had been included via tcg-op-common.h via tcg-op.h,
but that is going away.

It is needed for inlines within translator.h, so we might as well
do it there and not individually in each translator c file.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 1 +
 target/arm/tcg/translate-a64.c | 2 --
 target/arm/tcg/translate-sme.c | 1 -
 target/arm/tcg/translate-sve.c | 2 --
 target/arm/tcg/translate.c     | 2 --
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a9d1f4adc2..868a3abd0d 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,6 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "exec/translator.h"
+#include "exec/helper-gen.h"
 #include "internals.h"
 
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 741a608739..bc0cb98955 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -29,8 +29,6 @@
 #include "qemu/host-utils.h"
 #include "semihosting/semihost.h"
 #include "exec/gen-icount.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e3adba314e..b0812d9dd6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,7 +23,6 @@
 #include "tcg/tcg-op-gvec.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "translate.h"
-#include "exec/helper-gen.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 92ab290106..106baf311f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -27,8 +27,6 @@
 #include "arm_ldst.h"
 #include "translate.h"
 #include "internals.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7468476724..c89825ad6a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -30,8 +30,6 @@
 #include "qemu/bitops.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-#include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
 #include "exec/log.h"
 #include "cpregs.h"
 
-- 
2.34.1


