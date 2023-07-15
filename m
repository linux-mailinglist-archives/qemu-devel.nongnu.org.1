Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED77548F3
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjc-0005z9-0Q; Sat, 15 Jul 2023 09:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiE-00041T-Di
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiB-0001Dp-OY
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:30 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so3057711f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429206; x=1692021206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bny+QrSk9kOHXY9n7JH/neknIRvMmyCuxL4ghWqdlbg=;
 b=kvoQjYfsluMHe2RntKm3FJztPFWJbkOJq1VTmqq50O3uXwxHvbJSgj2s7flRMA/iEh
 Tikwy2maOG8k27PVFfxD+itCPHzou2arVQ7mun64qZtnkiibOt4nAh4Sjswgb5XnUv9P
 cIyEaSsGD85E6+LU/UvglSJ+F4GM37X+eBVlbkJCllHhtn/I962eBN8ZkwoWQYdserPL
 hdxEj53b5ekpzTXLHDUj20InJfwGKqSPApW3ykyabBbAizE/mirJp0pwMI8iBodcrBiX
 Q9/2lxf6R8DURKEMu4NcLwE4BJxRBMZTy/o8zybeT7gJbUH58qwqRdxQhfQc7r70LC0F
 RlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429206; x=1692021206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bny+QrSk9kOHXY9n7JH/neknIRvMmyCuxL4ghWqdlbg=;
 b=agYVQc+BSWcF4gGDkVrAi0o6M64iz3Vkbob0dw0SKSL6416p2ShT8dvprszMd6uvkV
 9r+Egb1a3vqjCIhULaWN8RdM0cBAW5SD7u3S81qM5XK345OMZf0uFwHwH59wuaUfZc5r
 wTlEGaDOXJJc4Pdk7CYrdA48bFSHoByn99dW7iTH9aYPV3Z9TE0H9ZDOEYUDwKxXcnnR
 AR5TbawBUyLngd78fN5NHFFvqgHi1VDeCkrXUmrCb5XjS1VMtWtyaiOas4vMNbM+CpjE
 WxfH6W0c7NNBT0Iyw+3aCEpepmXwq33RuQOJBZAvn66bjBwPE8ygP4H9JmEJhOFmjGuE
 3hCg==
X-Gm-Message-State: ABy/qLYMalLJPa444rP6Vh4jb2NXtdfV65uj3+FzJG9Yb2ScILnT4p2l
 ejvCZXJQKj3j0SV0fW8Y7N4rLsvAsnu3MPc2SRH2jQ==
X-Google-Smtp-Source: APBJJlG6zCMFJLNgy8eU0dfa5sz/MSU/NFG3f7SJz703zKZ8j+yHNr2OwOcyFc1f5rY8r1RVihh/aw==
X-Received: by 2002:adf:ff84:0:b0:314:dc0:2fca with SMTP id
 j4-20020adfff84000000b003140dc02fcamr7173400wrr.29.1689429206385; 
 Sat, 15 Jul 2023 06:53:26 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/47] linux-user: Use abi_ullong not unsigned long long in
 syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:38 +0100
Message-Id: <20230715135317.7219-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
 linux-user/syscall_defs.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 20986bd1d3..45ebacd4b4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1385,13 +1385,13 @@ struct target_stat64 {
     abi_ulong       target_st_ctime;
     abi_ulong       target_st_ctime_nsec;
 
-    unsigned long long      st_ino;
+    abi_ullong      st_ino;
 } QEMU_PACKED;
 
 #ifdef TARGET_ARM
 #define TARGET_HAS_STRUCT_STAT64
 struct target_eabi_stat64 {
-    unsigned long long st_dev;
+    abi_ullong   st_dev;
     abi_uint     __pad1;
     abi_ulong    __st_ino;
     abi_uint     st_mode;
@@ -1400,13 +1400,13 @@ struct target_eabi_stat64 {
     abi_ulong    st_uid;
     abi_ulong    st_gid;
 
-    unsigned long long st_rdev;
+    abi_ullong   st_rdev;
     abi_uint     __pad2[2];
 
     long long       st_size;
     abi_ulong    st_blksize;
     abi_uint     __pad3;
-    unsigned long long st_blocks;
+    abi_ullong   st_blocks;
 
     abi_ulong    target_st_atime;
     abi_ulong    target_st_atime_nsec;
@@ -1417,7 +1417,7 @@ struct target_eabi_stat64 {
     abi_ulong    target_st_ctime;
     abi_ulong    target_st_ctime_nsec;
 
-    unsigned long long st_ino;
+    abi_ullong   st_ino;
 } QEMU_PACKED;
 #endif
 
@@ -1568,14 +1568,14 @@ struct target_stat {
 #if !defined(TARGET_PPC64)
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-    unsigned long long st_dev;
-    unsigned long long st_ino;
+    abi_ullong st_dev;
+    abi_ullong st_ino;
     abi_uint st_mode;
     abi_uint st_nlink;
     abi_uint st_uid;
     abi_uint st_gid;
-    unsigned long long st_rdev;
-    unsigned long long __pad0;
+    abi_ullong st_rdev;
+    abi_ullong __pad0;
     long long      st_size;
     int            st_blksize;
     abi_uint       __pad1;
@@ -1674,7 +1674,7 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-    unsigned long long      st_dev;
+    abi_ullong      st_dev;
     unsigned char   __pad1[2];
 
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
@@ -1686,7 +1686,7 @@ struct target_stat64 {
     abi_ulong       st_uid;
     abi_ulong       st_gid;
 
-    unsigned long long      st_rdev;
+    abi_ullong      st_rdev;
     unsigned char   __pad3[2];
 
     long long       st_size;
@@ -1704,7 +1704,7 @@ struct target_stat64 {
     abi_ulong       target_st_ctime;
     abi_ulong       target_st_ctime_nsec;
 
-    unsigned long long      st_ino;
+    abi_ullong      st_ino;
 } QEMU_PACKED;
 
 #elif defined(TARGET_ABI_MIPSN64)
@@ -1918,7 +1918,7 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-    unsigned long long      st_dev;
+    abi_ullong      st_dev;
     unsigned char   __pad0[4];
 
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
@@ -1930,13 +1930,13 @@ struct QEMU_PACKED target_stat64 {
     abi_ulong       st_uid;
     abi_ulong       st_gid;
 
-    unsigned long long      st_rdev;
+    abi_ullong      st_rdev;
     unsigned char   __pad3[4];
 
     long long       st_size;
     abi_ulong       st_blksize;
 
-    unsigned long long      st_blocks;      /* Number 512-byte blocks allocated. */
+    abi_ullong      st_blocks;      /* Number 512-byte blocks allocated. */
 
     abi_ulong       target_st_atime;
     abi_ulong       target_st_atime_nsec;
@@ -1947,7 +1947,7 @@ struct QEMU_PACKED target_stat64 {
     abi_ulong       target_st_ctime;
     abi_ulong       target_st_ctime_nsec;
 
-    unsigned long long      st_ino;
+    abi_ullong      st_ino;
 };
 
 #elif defined(TARGET_I386) && !defined(TARGET_ABI32)
-- 
2.34.1


