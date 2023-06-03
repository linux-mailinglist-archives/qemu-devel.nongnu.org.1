Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83E7213AD
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfL-00071W-QA; Sat, 03 Jun 2023 18:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfK-000716-Er
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:06 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfI-0004wq-QC
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:06 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-38e04d1b2b4so2837664b6e.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831043; x=1688423043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXEGqfyF3BLk2EgElqGI5x7E8mb+jDp+meUQfbgNqRM=;
 b=SQMgmxMyZZYs4GV+XLGOLMktUAP9pUzhEOXjQgikEIK3y7B8zUQ1AtJL90CnnJ462O
 FGPAch2UQi0t+7EZaJXbHI2oKyHx4ArTIBZgh4FAy/ZLi51OPqd7XJoNm8Ud9vnA2j7H
 kU263BZhExTZn8kxVKRr9qypInGir8rYpIuMeSlx57Vyvki4FY82FzI15vbTJUMutjJm
 w2Eu2kufON84xtpN6m2jOikMqDPijEkEaDcXeRV6cWAeYlVoLJ20F1Rza868BONWHMKG
 4kMXRuxfVZQYJv4cWiQ9aZwORrNPNuY+wPxt/RPpp2RKFahPWwF+wavFwe5HjTfCN3Gc
 sDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831043; x=1688423043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXEGqfyF3BLk2EgElqGI5x7E8mb+jDp+meUQfbgNqRM=;
 b=ibLW5ITp962hxFGJgYq/43GAUBQ8XzSUagHyoeC6K3J0eOP3EO+MXTtBr8MMG8M4B3
 TsY86r8Ip4e+hLdWIrpqyduR/5ATUBWbFSJSGA1wAwDUn0WexIfyNQAlYYnp+2vLqY4n
 KnLw/dXBBzs6VspIzonVYYjtXuNWravsJ/Go+/aALCXoE2guDh6twU6UW+oOSv7EGkKy
 tS0b7fOduwijcMm3eKIo2Co0Q5Fa4PcHdpgGoei1s3eKpBhF7TDJ2S6cmh9QcAXn+/so
 7omKQO5u7ws7LBk5kQQQNTI/5vKv62cmlZhvvcslfeBAckwtAaTdZmgyqo9WNLG+JuSX
 FLgw==
X-Gm-Message-State: AC+VfDxtv+xIQkq4bSBE2DZKlJb2OvaaYTRJUVcFvM3TP1ZLZzFpvJ3j
 fu5TpCzcPGuwgz3tbqliDWuiSks7BEz9ZgLyRsI=
X-Google-Smtp-Source: ACHHUZ4mDQcb0Z3HP2ff2Ytw9suaE5v5WDBnVcgaWKwjFVoolRMSe3F9XWzMWjZf7v2iV780nLk5Eg==
X-Received: by 2002:a05:6808:96:b0:39a:e8e:67be with SMTP id
 s22-20020a056808009600b0039a0e8e67bemr3806168oic.39.1685831043714; 
 Sat, 03 Jun 2023 15:24:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 08/15] linux-user: Use abi_ullong not unsigned long long in
 syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:48 -0700
Message-Id: <20230603222355.1379711-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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


