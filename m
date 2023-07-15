Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C44BF75490F
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjs-0007Tn-Bt; Sat, 15 Jul 2023 09:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiP-00045f-NE
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiN-0001IK-Ng
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso26405225e9.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429218; x=1692021218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XT7/zvTpZMeqxSdbndcDLpIQTRXhkVJ5EOXRYsTIYQ=;
 b=NyIynGRLVEIxm4F71XBmV5pvQENJWVTW2QcJzM09t5UXFh6qKICwnZYog5Da+805Ck
 aMqQNvZwFF81KTadpVm292RkvMgAUJR6BQAIUW9XdNM1G38UlFjNBDDq42OMisAZZSL2
 +zZ5JeQpLE2PxjubncDORU6wtVgxuv5rZ9JDMb/XLcwgJgOmzq2H4iEnk6pbQGRurD22
 BfGou+Mp0Gr2ZLrF515Vr2KX0JBc9YxAZy7WYtXPVdlfzfgjlJ2lAy+hyar7qIv4d9/G
 ST91pAxjEa2p99iC/hQeLew1vs2erHNiK3kY9NvT1W6XYwQDXa0/64iD/gHvfcTrdOjb
 lobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429218; x=1692021218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XT7/zvTpZMeqxSdbndcDLpIQTRXhkVJ5EOXRYsTIYQ=;
 b=DtWfm+nMdePiDcrRwiPfZxxOjsJM/vSsrRp2EOwHlmIQcg37wWA/ygIhF1/tTjNezb
 Twcb/x0RtRoKfDpRIe25JyXsasrJydr2YM+T3Uhw6UllrTTR6bBaNgILHMbxsXTnWe65
 KDDmEIRYnD2PUTKZgAcLahqikpvkK8pHUOr6QccF+5HdbdDAPLB0pGQsCTG/scNWG7LW
 BWPxCYn4WYY4UHNDk5t9vlEyFPV1zZetL/Laem6J9m23U78lXTsgElGHUsFK/rtG60uT
 ZrfexQcl5iL5sGU+Bo8wVjCMuOgxk2kwvRbmLzXRZ9wl6O8Ao9lgG0UvcY2aT3Z4GWXh
 zjcA==
X-Gm-Message-State: ABy/qLZRtD55gC/27l2zIOmv8vW38nuog2GIn2z06GA4IodLBn3pHpQD
 YgwyTQrUDXWKpUAj3LvXXOCvufXLU7WGxV9XGBqB8g==
X-Google-Smtp-Source: APBJJlEh+YAcgXCDrtePIrcwq7d0MMRvOO5OUiRbtunUuXiG39r9YqeadZIE9l2EJhEBn1ZsJQLb4Q==
X-Received: by 2002:a7b:c04b:0:b0:3fa:97ad:2ba5 with SMTP id
 u11-20020a7bc04b000000b003fa97ad2ba5mr5818794wmc.31.1689429218529; 
 Sat, 15 Jul 2023 06:53:38 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/47] linux-user: Split TARGET_PROT_* out of syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:54 +0100
Message-Id: <20230715135317.7219-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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


