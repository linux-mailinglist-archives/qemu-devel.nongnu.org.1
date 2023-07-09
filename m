Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7874C73B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAP-0008Fy-KE; Sun, 09 Jul 2023 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAJ-0008EQ-Qu
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAG-0000E7-PL
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82de7so27946985e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927383; x=1691519383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aow7z7inlkO3pr/eTAXJ2bbplOH1xZ+KdEP0VBoCQXI=;
 b=jeFjwKcjjLrlgUlqcVFFT5VdgStte53SosdndOt4tIjZNCNBCq4r5ZCsPz+/droFnY
 RtoWL1rlIF03MQQi8LCZILp8rwTRCr1ls5VeIFnJTGnVomsj8KhAua4As9DPvgDjXT6y
 7JJ46fs8jbtvkjZ8ftYU9RPOHFgRMwqfy7aC3tDEPJuYm7sG1QLWpIrqPKJ0l1paoOJ3
 +0kb5KiFOs4bKRY37V8NigfmJjObySFfmzCvMpKn09veOiufjqHJ8vd25WgN4EaQbZRV
 iirGvtJJvektQsjv3VO7dt7J1eHNnVQK9Lz9BvYp9jesXAEIJbCsliMLdh2lOS4p2JLr
 wKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927383; x=1691519383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aow7z7inlkO3pr/eTAXJ2bbplOH1xZ+KdEP0VBoCQXI=;
 b=HwwhTowYxmB1oKvDXCwErYF2tELUQYT1nJIwgJ55JoDhNV4bHYNX/pkQcYZr8jtuGT
 4K/aLJsx7MdY9x0UO03dM9s9JIS0MYz4ACG5J+jdGksE03BQLc7QEG2c05vTe8mCy7J+
 c7VTHhkjLnjL1O5TR7MMgIp69Brp+tlvmRrkHGglr7zn53gv+mo/gPYQxLQwuPzFEeiO
 FDAq33weZePp05vXABinzoXzgd14A7K7w7hUtRde6hCQjC3kGjERXyVUhu7JC4wEfepo
 pF0GTpmrYNvxPvYKxhNlwp2oa8SzHlDjNoOvj92Ta/xdejkyoqmF8chxksXL2DtHqoRD
 t8UQ==
X-Gm-Message-State: ABy/qLY6TcQQxGVyBUK2Dl8+CeLpYYdo+k34vbL6eBoexOUFJVLNjsTe
 6afCwvGJqcu8fuNAkIQdOOBBedN1ei64ixh8Oh9nEw==
X-Google-Smtp-Source: APBJJlG5ijU1R3I8FKq1QA1xQdNcnGoOPoW/i6qUcOBU6izHLa9UmYT2mKYV51Pm/TMlxi5y+uEAdw==
X-Received: by 2002:a1c:cc02:0:b0:3fb:4064:7e22 with SMTP id
 h2-20020a1ccc02000000b003fb40647e22mr3597986wmb.19.1688927383364; 
 Sun, 09 Jul 2023 11:29:43 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/45] linux-user: Use abi_int not int32_t in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:20 +0100
Message-Id: <20230709182934.309468-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 414d88a9ec..caaa895bec 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -501,7 +501,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #endif
 
 #if defined(TARGET_ALPHA)
-typedef int32_t target_old_sa_flags;
+typedef abi_int target_old_sa_flags;
 #else
 typedef abi_ulong target_old_sa_flags;
 #endif
@@ -1631,7 +1631,7 @@ struct QEMU_PACKED target_stat64 {
     uint64_t __pad1;
 
     int64_t  st_size;
-    int32_t  st_blksize;
+    abi_int  st_blksize;
     abi_uint __pad2;
     int64_t st_blocks;      /* Number 512-byte blocks allocated. */
 
@@ -2192,20 +2192,20 @@ typedef struct {
 #ifdef TARGET_MIPS
 #ifdef TARGET_ABI_MIPSN32
 struct target_statfs {
-    int32_t                 f_type;
-    int32_t                 f_bsize;
-    int32_t                 f_frsize;       /* Fragment size - unsupported */
-    int32_t                 f_blocks;
-    int32_t                 f_bfree;
-    int32_t                 f_files;
-    int32_t                 f_ffree;
-    int32_t                 f_bavail;
+    abi_int                 f_type;
+    abi_int                 f_bsize;
+    abi_int                 f_frsize;       /* Fragment size - unsupported */
+    abi_int                 f_blocks;
+    abi_int                 f_bfree;
+    abi_int                 f_files;
+    abi_int                 f_ffree;
+    abi_int                 f_bavail;
 
     /* Linux specials */
     target_fsid_t           f_fsid;
-    int32_t                 f_namelen;
-    int32_t                 f_flags;
-    int32_t                 f_spare[5];
+    abi_int                 f_namelen;
+    abi_int                 f_flags;
+    abi_int                 f_spare[5];
 };
 #else
 struct target_statfs {
@@ -2276,34 +2276,34 @@ struct target_statfs64 {
 };
 #elif defined(TARGET_S390X)
 struct target_statfs {
-    int32_t  f_type;
-    int32_t  f_bsize;
+    abi_int  f_type;
+    abi_int  f_bsize;
     abi_long f_blocks;
     abi_long f_bfree;
     abi_long f_bavail;
     abi_long f_files;
     abi_long f_ffree;
     kernel_fsid_t f_fsid;
-    int32_t  f_namelen;
-    int32_t  f_frsize;
-    int32_t  f_flags;
-    int32_t  f_spare[4];
+    abi_int  f_namelen;
+    abi_int  f_frsize;
+    abi_int  f_flags;
+    abi_int  f_spare[4];
 
 };
 
 struct target_statfs64 {
-    int32_t  f_type;
-    int32_t  f_bsize;
+    abi_int  f_type;
+    abi_int  f_bsize;
     abi_long f_blocks;
     abi_long f_bfree;
     abi_long f_bavail;
     abi_long f_files;
     abi_long f_ffree;
     kernel_fsid_t f_fsid;
-    int32_t  f_namelen;
-    int32_t  f_frsize;
-    int32_t  f_flags;
-    int32_t  f_spare[4];
+    abi_int  f_namelen;
+    abi_int  f_frsize;
+    abi_int  f_flags;
+    abi_int  f_spare[4];
 };
 #else
 struct target_statfs {
@@ -2718,21 +2718,21 @@ struct target_ucred {
     abi_uint gid;
 };
 
-typedef int32_t target_timer_t;
+typedef abi_int target_timer_t;
 
 #define TARGET_SIGEV_MAX_SIZE 64
 
 /* This is architecture-specific but most architectures use the default */
 #ifdef TARGET_MIPS
-#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(int32_t) * 2 + sizeof(abi_long))
+#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(abi_int) * 2 + sizeof(abi_long))
 #else
-#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(int32_t) * 2         \
+#define TARGET_SIGEV_PREAMBLE_SIZE (sizeof(abi_int) * 2         \
                                     + sizeof(target_sigval_t))
 #endif
 
 #define TARGET_SIGEV_PAD_SIZE ((TARGET_SIGEV_MAX_SIZE           \
                                 - TARGET_SIGEV_PREAMBLE_SIZE)   \
-                               / sizeof(int32_t))
+                               / sizeof(abi_int))
 
 struct target_sigevent {
     target_sigval_t sigev_value;
@@ -2792,7 +2792,7 @@ struct target_user_cap_data {
 struct target_statx_timestamp {
     int64_t tv_sec;
     abi_uint tv_nsec;
-    int32_t __reserved;
+    abi_int __reserved;
 };
 
 struct target_statx {
-- 
2.34.1


