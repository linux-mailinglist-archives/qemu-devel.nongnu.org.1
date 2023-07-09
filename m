Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D974C768
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEQ-0005sa-7M; Sun, 09 Jul 2023 14:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDm-0003IU-MB
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:22 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDk-0004Ap-Qc
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so4500852f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927597; x=1691519597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XT7/zvTpZMeqxSdbndcDLpIQTRXhkVJ5EOXRYsTIYQ=;
 b=Y3jTRAGhWNlLnjxFvFMZObU7LDmyk1EIlyWJzFIdgT3RszI4UvO45dVU+4BHS2zJmy
 yFG6Xu4v2b3JXPdYsIvG8+5tT0g5dC744DDnbo9uBz5q5B1nV2xacBL7AKODFSNTu86c
 p4Zq7Vud8zWagOUY4h3fPSTFSsb/Awh29YXWE0YHXXyN9MufQ64j0bPmAjWQYVtdfgLp
 u2Pi+uvU1t4inDzcebn8g6QXH2YNXi/NgarIX3p/HaXzThT1d00cyAw9SQo0DGABWGGa
 lI6F+EscYc91tqODeDQfz02g/jPt/LVEbQ0q0LOrh4OwO7QAgn+hV4d2z7uTvoQGbfGY
 wSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927597; x=1691519597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XT7/zvTpZMeqxSdbndcDLpIQTRXhkVJ5EOXRYsTIYQ=;
 b=U2tIt4WpGhwuAuWn7sKRIEMvAwgBPo0k3qOwY/jDPgWCt56YtL0uyXuTJD1TxtpYa9
 3YBCf/+/9G+Wbx3Z9jceyJZm4bpoh2KIw6/jwVbDzIQhEaV3RHzOKk1oc16ELqPSIjPb
 nyiwt9JKc6pLFj764CXYcjDW6wnmLYfszcUBacLl7qlBjSj9vQwsfsc0YEOU7iFtq+zf
 u7+uip2qTNDYMqogQHhKpDu8Tgsfqg6CAOhZCD/irXSWL8eK7+chmHfytxVnHzBnXC/m
 o6gfbIh9B+Y9nCkdKekTj9sxBHCZT/1wVtUj7tQEs1Jgl6/cRO/HzDY6muDiNvxsAKn1
 iWGg==
X-Gm-Message-State: ABy/qLaflYDH9GsL7bny2tTFf7OXSCW+i3yjCQTuJdsH1zODQqmg2a2I
 X8m3mKJlv+PhvSkr9+gUTf6XxknsSeW4SW0H/EcrlA==
X-Google-Smtp-Source: APBJJlFZdq50X/wsOxXKVyYIeK4mCDGzndwoghOQ6SmqQBw+jR6r2W+ybBn/j51Olwj8dnsAiRLWNQ==
X-Received: by 2002:adf:ee8c:0:b0:314:748:d59d with SMTP id
 b12-20020adfee8c000000b003140748d59dmr11590079wro.27.1688927597527; 
 Sun, 09 Jul 2023 11:33:17 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/45] linux-user: Split TARGET_PROT_* out of syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:59 +0100
Message-Id: <20230709182934.309468-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Move the values into the per-target target_mman.h headers

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-8-richard.henderson@linaro.org>
---
 linux-user/aarch64/target_mman.h |  8 ++++++++
 linux-user/generic/target_mman.h |  6 +++++-
 linux-user/mips/target_mman.h    |  2 ++
 linux-user/syscall_defs.h        | 11 -----------
 linux-user/xtensa/target_mman.h  |  2 ++
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index e7ba6070fe..f721295fe1 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -1 +1,9 @@
+#ifndef AARCH64_TARGET_MMAN_H
+#define AARCH64_TARGET_MMAN_H
+
+#define TARGET_PROT_BTI         0x10
+#define TARGET_PROT_MTE         0x20
+
 #include "../generic/target_mman.h"
+
+#endif
diff --git a/linux-user/generic/target_mman.h b/linux-user/generic/target_mman.h
index 7b888fb7f8..ec76a91b46 100644
--- a/linux-user/generic/target_mman.h
+++ b/linux-user/generic/target_mman.h
@@ -23,7 +23,11 @@
 #define TARGET_MAP_NORESERVE            0x4000
 #endif
 
-/* Other MAP flags are defined in asm-generic/mman-common.h */
+/* Defined in asm-generic/mman-common.h */
+#ifndef TARGET_PROT_SEM
+#define TARGET_PROT_SEM                 0x08
+#endif
+
 #ifndef TARGET_MAP_TYPE
 #define TARGET_MAP_TYPE                 0x0f
 #endif
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index cd566c24b6..e97694aa4e 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -1,6 +1,8 @@
 #ifndef MIPS_TARGET_MMAN_H
 #define MIPS_TARGET_MMAN_H
 
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 041105b7a7..77ba343c85 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1227,17 +1227,6 @@ struct target_winsize {
 
 #include "termbits.h"
 
-#if defined(TARGET_MIPS) || defined(TARGET_XTENSA)
-#define TARGET_PROT_SEM         0x10
-#else
-#define TARGET_PROT_SEM         0x08
-#endif
-
-#ifdef TARGET_AARCH64
-#define TARGET_PROT_BTI         0x10
-#define TARGET_PROT_MTE         0x20
-#endif
-
 #include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32))     \
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index 3891bb5e07..3933771b5b 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -1,6 +1,8 @@
 #ifndef XTENSA_TARGET_MMAN_H
 #define XTENSA_TARGET_MMAN_H
 
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
-- 
2.34.1


