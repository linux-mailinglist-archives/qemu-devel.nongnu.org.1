Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167C7213AB
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfI-0006zm-Rz; Sat, 03 Jun 2023 18:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfH-0006ze-HT
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:03 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfF-0004vv-RP
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:03 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1a26f26ebb8so2518369fac.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831040; x=1688423040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgo+Ng3v7arrdUy09g80WefJ7XRN/HnbdioLfJzQH3E=;
 b=e4vBPIOzJg0s3v8oFrGBQE7lSWtwVCQm2FyF+uRKw9Oxf7oY/CF/H92GiclftIz3qs
 +XWXaKv2cO1p0pOkeIxC8Ic6GMmDaE85uSXuPwrASkxsn9nokEwWRTcc4A0gTOn39Tqj
 bLeqVSzIioFn90qQQO7gccJ3YTixBfacpbVEIv9KEn7RCaQ8NGw1MrOQxQZoUI5ZACEy
 OIVZ8j7mscTNY5c8ebqaKgS8AFZGtG0XD6Uk3oDeEwutGWK4c8ZVHrs4V1V4tPlKhV32
 lsg5mXlvDyIRtwX1ZA5a4teBQH8adY/gnnMTaGUp/W+N6a0ISg8jPvncujNn1VzfOYLR
 H7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831040; x=1688423040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgo+Ng3v7arrdUy09g80WefJ7XRN/HnbdioLfJzQH3E=;
 b=Gt2AJRapFK6MDcrJNuwmc/fOYWfW6iX5qcfa1kkPh53O2j0ofh3sFgRhNiarM16Qqr
 pTcUrBlelysBH2eV74qYkSUXinEe2r+wjHdsfMasxQ+2UokUQZ73RxPDxuShaSxRusmf
 mf7LVFwC1L6tlznf3vXPy3hyJ6Qv5i+RcBlzBB+gVCRM7l4uqp3AfXDisAcxdeIcMpvb
 weQOFxYvOecwiEC45IFVwTpv5V4haFTC689wqtT2JE+VO+qnEpSQDC+EYm5oGRuu/VZV
 ZM3hnr5BYaiHGQpByPCoKFjR4h3GEy0r9JbeeoY6v/7pHFclqS8cM5Fn1fKdOQwUGfnk
 Yuaw==
X-Gm-Message-State: AC+VfDxzSfJLjNxzpmsaw3EVBAXh1fHA7T16z7zE0/yYNLcR4aGsVSca
 S6AnupgfgY1iaa/RKoNKB3BuWWapbvGPU6cKFnA=
X-Google-Smtp-Source: ACHHUZ5zxKTE7Lx9FXQoQYtZ8pI7l04qO12uQVxQS9K8mtjedf1IZBMPg3/qQWEn4BFo3l5AcutLZw==
X-Received: by 2002:a05:6358:52d3:b0:127:b79b:c08c with SMTP id
 z19-20020a05635852d300b00127b79bc08cmr10963579rwz.8.1685831040279; 
 Sat, 03 Jun 2023 15:24:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:23:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 04/15] linux-user: Use abi_int not int32_t in syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:44 -0700
Message-Id: <20230603222355.1379711-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


