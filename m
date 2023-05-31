Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E67174E9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7I-0003Zo-Ml; Wed, 31 May 2023 00:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D79-000398-4y
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D76-0006vY-9j
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so6123696b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506027; x=1688098027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9NLGFkJgE9FrhdZMJ/Ft9ko/YgwN2oBNWIu/qZT+vhY=;
 b=Er4Qby4XQUgXUyjTQG/plcgQZddMgU2wmsuBcpsGWuZ97mPjcPzKpVY+N+szqL0Gs/
 68YT7fWEUns6J8fTXkR0ud+wFV04eMEGcDItbYaGPL8XaMSxf6jTamVuX9yJnWkH49lW
 wSA0Ve4EPUmPXnNNQAGxcLsbNC4lXq33P8DYDsMQfZJ+6EhsY+vUYxguEQzYrcFPz7Ig
 a8K9SZS4pjbAl9Rvj7TxpUKxECTvNZIcGJnakcIisK2MfzsTuM6BAVaLADtSdy7twOw0
 0KhiUEqAVR3yKYwyDhuFtU3filB9Qm1GYnwUIoyTtrC/LbkjuuC2M0qjoqmBYPTggBIY
 iRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506027; x=1688098027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NLGFkJgE9FrhdZMJ/Ft9ko/YgwN2oBNWIu/qZT+vhY=;
 b=Tm5DIYQvxCRkxtZKoJ2LV1NURgBpSE1m7laT4QtH3IAKIpYbAstazjdQfd3yAjB9LM
 mQ5mfAKO/1pMweURkIvr4940Xg6asRo4WVV/U8F3kr/gxEnLYWQmPKEEJ8tw+x4RamB6
 MbbJqZ2Qhy7jHu6zKBFM/cpscSDT49dQCtX9QbrUoEbBpSA2v024ASWgh36cMWZk9nf2
 dsHA5p3XBldQ3yxpLfbMpFaPYqcFs4oM2UN7hLBtfKakLsjc2DPRRamY2MIoNf3vdhkP
 ZmK4DITDnoAbTO/kDWcqXdOUIk/9hI4gtoHjCIlOk/ulXd25DVUeLqOIUJ5uHvPMcEzf
 69ig==
X-Gm-Message-State: AC+VfDzt0bHIDyUV4J2UbXToYnm5o155XbTtJ4XmP2RxojxGBjFa5d12
 MhJSDl2buo90FeyQ0EQuZ3dKLtzChle8dD0QBkY=
X-Google-Smtp-Source: ACHHUZ7i3Zjrd6K/1RqUr55dnYfElUpXDcaLNUZT3h5L0WqzG5ZNP5Jv+GZ0bgREXP015oaimHDSKw==
X-Received: by 2002:a05:6a20:549a:b0:10f:fea:1997 with SMTP id
 i26-20020a056a20549a00b0010f0fea1997mr5531048pzk.5.1685506026753; 
 Tue, 30 May 2023 21:07:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 44/48] tcg: Remove target-specific headers from tcg.[ch]
Date: Tue, 30 May 2023 21:03:26 -0700
Message-Id: <20230531040330.8950-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
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

This finally paves the way for tcg/ to be built once per mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h      | 1 -
 accel/tcg/plugin-gen.c | 1 +
 tcg/region.c           | 2 +-
 tcg/tcg-op.c           | 2 +-
 tcg/tcg.c              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 635fa53fdb..a498f31967 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -25,7 +25,6 @@
 #ifndef TCG_H
 #define TCG_H
 
-#include "cpu.h"
 #include "exec/memop.h"
 #include "exec/memopidx.h"
 #include "qemu/bitops.h"
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 3e528f191d..5c13615112 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -43,6 +43,7 @@
  * CPU's index into a TCG temp, since the first callback did it already.
  */
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op.h"
diff --git a/tcg/region.c b/tcg/region.c
index f8410ba5db..2b28ed3556 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -30,8 +30,8 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/qtree.h"
 #include "qapi/error.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
+#include "exec/translation-block.h"
 #include "tcg-internal.h"
 
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c1ad49c4e..c07de5d9f8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -23,10 +23,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
+#include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 41186f540f..3fcd0d9f32 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -34,7 +34,7 @@
 #include "qemu/cacheflush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "exec/tlb-common.h"
 #include "tcg/tcg-op-common.h"
 
-- 
2.34.1


