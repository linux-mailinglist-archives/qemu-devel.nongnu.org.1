Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905270E9DC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btm-0004Jm-Uc; Tue, 23 May 2023 19:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btk-0004Ht-PK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btY-0001mr-Gk
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso155913b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886303; x=1687478303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkYVlK3RdF9zN2MHNE1wKJqPl/6YEBFQeP4y1IxzryQ=;
 b=nxH9gEvwVvyxoYY/FlgEK3fpcLjMZpTQC941OjnUA1vqd34eZ/OiDqSgxGcpmNM//L
 OHVB+xQlIOoRb+ONVZOA/jHoIrvxYEdZE6T92qCFeJ/Su+YelZoxTKARHVsCkJV5R560
 QrMBCk+E/MOrUcmvgV4jscD6qNwKPunda2b2ZBUZ6F0rdFRKSoCxspIapNv0SQ9zgaHY
 TprSSGW7VR089HVtICUGNXiQMf940bFa5hAMYQ8l0+bq0JDTEWVqsiF3QYFyC6CZHIie
 u6Zrtve0D/3yuwAqnZOOmiWTx5/LyUK8tw0F58SGIfqV5RmBmaEdjA+HuJ9q6QsIexn5
 wCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886304; x=1687478304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkYVlK3RdF9zN2MHNE1wKJqPl/6YEBFQeP4y1IxzryQ=;
 b=cgNMFT9SbhH//7KRdTbSC8Cu/N6Sj+shZrVOczWj+MuvFn3DmjMXq6Q/ymMzqsVVf2
 bgw0Jv1nsYWzjaqOzeXl9D7ykJICpG7YONkd6s/jpZ/Uyn2GmG1zi9PgSMme5Ry8ABG5
 o9LZ9T7TQoFn5BxwGNvQDCExs8EmTGTWIfdST8oRUz9P/JhsokHeOGvM4PFkscdp4wdV
 ddmvXt8GPre1b27bhu9ZoLqBFkiphTh/7Hp6+iok3fHId50yRmZStTftHVE8mXY8BDtf
 eMc/dvK31XyWY0GnA+eHz7srBymnW1Z7g2295bgrUbpU3OOPTxYMtr8T10UgA4ddZ9Cf
 zPWw==
X-Gm-Message-State: AC+VfDwdv66pmOLZjMQVb/M5+OWB/VdsPBwZ+NdOJSYqows3BIhlhPKw
 vlC+BBqRuc/aTxIggyqtCkodNLd0UzrbpwvL2CU=
X-Google-Smtp-Source: ACHHUZ7NlEFsRl7LliMEjLf/Oj8MwHWXx2k140sgPOEYD5DwBiLYClyHbITFEsxkb7LnME8UgRSCBA==
X-Received: by 2002:a05:6a00:15c8:b0:63f:18ae:1d5f with SMTP id
 o8-20020a056a0015c800b0063f18ae1d5fmr863500pfu.29.1684886303674; 
 Tue, 23 May 2023 16:58:23 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 21/28] accel/tcg: Eliminate #if on HAVE_ATOMIC128 and
 HAVE_CMPXCHG128
Date: Tue, 23 May 2023 16:57:57 -0700
Message-Id: <20230523235804.747803-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
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

These symbols will shortly become dynamic runtime tests and
therefore not appropriate for the preprocessor.  Use the
matching CONFIG_* symbols for that purpose.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h  | 2 ++
 host/include/generic/host/atomic128-ldst.h | 2 +-
 accel/tcg/cputlb.c                         | 2 +-
 accel/tcg/user-exec.c                      | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
index 80de58e06d..58630107bc 100644
--- a/host/include/aarch64/host/atomic128-cas.h
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -37,6 +37,8 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 
     return int128_make128(oldl, oldh);
 }
+
+# define CONFIG_CMPXCHG128 1
 # define HAVE_CMPXCHG128 1
 #endif
 
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 46911dfb61..06a62e9dd0 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -33,7 +33,7 @@ atomic16_set(Int128 *ptr, Int128 val)
 }
 
 # define HAVE_ATOMIC128 1
-#elif !defined(CONFIG_USER_ONLY) && HAVE_CMPXCHG128
+#elif defined(CONFIG_CMPXCHG128) && !defined(CONFIG_USER_ONLY)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_read(Int128 *ptr)
 {
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9cb0b697d1..0bd06bf894 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -3038,7 +3038,7 @@ void cpu_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 #include "atomic_template.h"
 #endif
 
-#if HAVE_CMPXCHG128 || HAVE_ATOMIC128
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1e085b1210..dc8d6b5d40 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1371,7 +1371,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #include "atomic_template.h"
 #endif
 
-#if HAVE_ATOMIC128 || HAVE_CMPXCHG128
+#if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
-- 
2.34.1


