Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B977E38C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSg-0003xp-Jt; Wed, 16 Aug 2023 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSd-0003uu-UC
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSb-0003k6-Bv
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68878ca7ca0so935353b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692195920; x=1692800720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WfUiBV4R48StsRGeWaef0j9aTh/ONctxiuXo83IRGs=;
 b=er27MzP+gSmorkX/8Xc1MNooYKFHycdKoxgHrnnJF93qmqML5QCzqsT7SceFsZFKfS
 oxcQVeiCiUqX9ElvbhaZIT9ek6KorYpZR3nR6Gu0WdsSRpQY0XTIVTUfCXd/9iUYb9/w
 pRKqt2JiKNyE59Udx2iX4FKaBKMtbWXEazkts+pAREml7sIf7J2qGrJPnuwqzakh2KFi
 Kbh2doJIItF4RxAtbcjXvIplFryYOPg70l8bDpNniCmAnAWLNWzGF3LEb/PogAnSAmwG
 mW55LJ8kjUmthwNTXWx3O2J4tejT5lgCRV9mPvwCBRVpbMR5IhEhCMOOB2lzXEVjUX6g
 CO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692195920; x=1692800720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WfUiBV4R48StsRGeWaef0j9aTh/ONctxiuXo83IRGs=;
 b=FF6b90jYbDQ+t6nNatrm6CiNyt2o57fAipkFnTgqDYjM+qwtxqBC21+hmlBASS62kz
 nqVbUqWW8rM7ZHtAEOtvEA8ywDxWIYYQFPUhJOFLgTIl3nZQmgSyiLEvxwgPVZW2I+Jy
 esmjE+4ybPZKi/fHQ/xqLHyAaHupROldWypx59xCLWAwLoFAHy64ogdKjlsUTCJmAddN
 egAhnuuiB3Ep3Sy1O4fqdbirHfV4JNP01H7tIOWmJjpFobk87TIEtaJAnhVVOqgvg6Mf
 tP96mQx+hjC5ShzeBXLu7qrcuBNHSp1ieK+OX1Xauidu9ZxOAswb6/0cFmvroNJEijlU
 so+w==
X-Gm-Message-State: AOJu0Yz3guLqC7gIfvsEuhRpekKtuUzpmEn/IEzGXRzBbQEMrxp2Eu12
 t86myg6XXfBW9YS/7+XSfzP5YMl9olquADgP4JA=
X-Google-Smtp-Source: AGHT+IFvVH2S7rBDxEe+E7G52QrwkCWlixCrt2P4auE0w8+WNDRAGjHLuD16Js16GUOuL4tAUFwEuQ==
X-Received: by 2002:a05:6a00:2444:b0:687:3f06:5939 with SMTP id
 d4-20020a056a00244400b006873f065939mr1818513pfj.32.1692195919804; 
 Wed, 16 Aug 2023 07:25:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 i12-20020aa78b4c000000b00678cb337353sm11156019pfd.208.2023.08.16.07.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/4] util/cpuinfo-aarch64: Add CPUINFO_BTI
Date: Wed, 16 Aug 2023 07:25:14 -0700
Message-Id: <20230816142516.469743-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816142516.469743-1-richard.henderson@linaro.org>
References: <20230816142516.469743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h | 1 +
 util/cpuinfo-aarch64.c              | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 769626b098..a59c8418d2 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
 #define CPUINFO_AES             (1u << 3)
+#define CPUINFO_BTI             (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index ababc39550..97f5548a95 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -57,11 +57,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
     info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
+
+    unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+    info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
 #endif
 
     cpuinfo = info;
-- 
2.34.1


