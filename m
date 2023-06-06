Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F7A72501E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 00:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fRW-0005EV-LL; Tue, 06 Jun 2023 18:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRU-0005Cc-BK
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRP-0001Fm-VT
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:20 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53fdae76f3aso6088539a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686091572; x=1688683572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3S1R0mxbsbr5r4sN0R70oDeXEHFKtv8G6mrXyAWo4hU=;
 b=deVpfxIw8Ci62xyukJLFSW++zEDhCtLJvycFV7mhBs7u1wCdS+s3RKpelkb/O02erV
 1mfCNaahumobc6S4fS7Zb+4agHThtBfz+xOkYNWuwUOwCtukBBxs69bb0ycTF5/sEtTR
 2RVr8ZCIOWWouWfnsZBI3PQMd1b68K5pvyJeyCelt0B62tE+IkoK1vh4fEhKV6b8xoyl
 J1nt7uhiBfPUK24lhC2dCNV2hP/tgxBEJdjBDWLhye0970AsvxBeozlJilCfTHn7jFKN
 oSiCYXA3gDoNUiN/qW+ssOwGkOVMOlkYYqJ7cLDsGk2GX1ZuXvIsRF58Meuh3GehbVfO
 DUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686091572; x=1688683572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3S1R0mxbsbr5r4sN0R70oDeXEHFKtv8G6mrXyAWo4hU=;
 b=TAX4aKuYQrTumDAo+tkJ9+so8shLyScYBYbPig5DLyvyRFh3YCNN/g14sDM5lAAAPD
 5U5189LKzYjgPn3N0TNwC7dltbhRIbtC+Dxc7cuLUevAoq3fzC90PkAxxYotspOBY78X
 JbOnp2j5ZgKMJ8KRvshMz+Mdb8L0qkyvFrJvs3uHa5LUXOkEVuE/oiLg6z+zjBQGbpci
 9wHS0w8yEVJ7Xf9peSYv9JOFZc+CJgNWODmbbvVckSR43hcc4UQTA3TNvkMQXrOWJ4nT
 WozsHUkEECqCViYJdwqkqPxBNLqzpKSr3Oy/LQC8PLLzLAQS6nJnW9P4bHiV258S6Gdn
 y7+w==
X-Gm-Message-State: AC+VfDy6Svyq6UUQNoZ53qB4E+GQOn5UXbNG4XyNLlTtsvzBCorwOBJI
 3Vz224az9Vhlpdgv8jJPxH0Dbdy9sm3bG9Zc7bo=
X-Google-Smtp-Source: ACHHUZ6v1MHLFim+KTus0DyDdWePRLDne7Fv9lUeGzYoSzMCHctqICvS89vz2Z72j4Bfd9tI7Y3ksw==
X-Received: by 2002:a05:6a20:2d26:b0:10c:1047:68b9 with SMTP id
 g38-20020a056a202d2600b0010c104768b9mr972795pzl.50.1686091571835; 
 Tue, 06 Jun 2023 15:46:11 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 t8-20020aa79388000000b0065cfd5cbef3sm3346969pfe.15.2023.06.06.15.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 15:46:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Subject: [PATCH 1/2] target/arm: Only include tcg/oversized-guest.h if
 CONFIG_TCG
Date: Tue,  6 Jun 2023 15:46:08 -0700
Message-Id: <20230606224609.208550-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606224609.208550-1-richard.henderson@linaro.org>
References: <20230606224609.208550-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Fixes the build for --disable-tcg.

This header is only needed for cross-hosting.  Without CONFIG_TCG,
we know this is an AArch64 host, CONFIG_ATOMIC64 will be set, and
the TCG_OVERSIZED_GUEST block will never be compiled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index b2dc223525..37bcb17a9e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -14,8 +14,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "idau.h"
-#include "tcg/oversized-guest.h"
-
+#ifdef CONFIG_TCG
+# include "tcg/oversized-guest.h"
+#endif
 
 typedef struct S1Translate {
     ARMMMUIdx in_mmu_idx;
-- 
2.34.1


