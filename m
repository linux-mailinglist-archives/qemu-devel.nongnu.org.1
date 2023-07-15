Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143F7548E7
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfic-00043P-AS; Sat, 15 Jul 2023 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiB-000402-8X
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi9-0001D8-ED
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3142970df44so2813875f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429203; x=1692021203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aow7z7inlkO3pr/eTAXJ2bbplOH1xZ+KdEP0VBoCQXI=;
 b=RTjwWOYm4eKzKUjiWS3cqDlE2GjnEiWDG3uy9B1VtH7qvBRPlQrkc5R8QX6ScjRVTB
 CBTFnSIBbbEMg3x98gKw8veaJ2rAQdfgYDEzWOrI1QyVmmY0/Vrnp/XJLkoVHGBdY6cm
 lTgQfv0L1MUs6DTH36RJ+i0PScYHyzSeYd/75YQ5jyVS7+bI8rJU7xz3sv90k0mE75vu
 3kWqG6YNssgbjC0/Hag9RRJzIdXuGtiXNyNyfyBTWYtgYIliXZEm4X16aYHSApG7IK2y
 NZ7FF5gEI+AVAmNzdl2alQBXmQQxZoDfo2dWzS6DsO7DM5QGGiV2UQUB3fMhUDlFuOyF
 wHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429203; x=1692021203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aow7z7inlkO3pr/eTAXJ2bbplOH1xZ+KdEP0VBoCQXI=;
 b=Ra1nYnhHPwwEl2DMRUizCpv4eby5hV9s8xbLYu6Ugo49j0Byt4cMAcrrvnByLJsCAP
 bVeVlnTXdT3v1cBc+xcLQLmIZ8I4XgMypM+QiLtluZaJyl7smmIlY5dHZMw97BxIO12I
 mQ9gi/y8E8YB1I5MuWAtRwtYP/n0UiopLx5uGXElsgOUsi9Qdnpdx9m+WUavtM7cLOL5
 +i8JdqCPEifV7QrosXNfhvcnUiA4KOS4bR+ZZ5f15jWXj0OBTjO97flUboUSl0gTxAeo
 CtybMvu5TA2okm7xhhwJixpeSsoI/IdendDvTDlC8gQtz417wlamROehf52NpG6GHhWH
 uD3Q==
X-Gm-Message-State: ABy/qLYw8vA/Pot+JUgRYaSxGbr+O96C4/LJBt6Jq5M3kh+LFrlmZLcb
 nMYbJOStu37b1DX5OScbJKuQnEpBq7PlW2oasuUKVA==
X-Google-Smtp-Source: APBJJlHPJhKX/KpxZl0JkbTJJcwjZnycX3rzHUi1IHAlBSMOQTJWNRtkwFhvVEhkeLpLTmz+N0MtYA==
X-Received: by 2002:adf:cf0d:0:b0:314:121d:8cbf with SMTP id
 o13-20020adfcf0d000000b00314121d8cbfmr6538926wrj.25.1689429203496; 
 Sat, 15 Jul 2023 06:53:23 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/47] linux-user: Use abi_int not int32_t in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:34 +0100
Message-Id: <20230715135317.7219-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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


