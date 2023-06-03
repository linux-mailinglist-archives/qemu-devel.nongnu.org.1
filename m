Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87C7213A8
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfL-00071H-5W; Sat, 03 Jun 2023 18:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfI-00070N-TH
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:04 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfH-0004wO-4Y
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:04 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-33bbb78248fso16881235ab.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831042; x=1688423042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGxhu0qSKW5xeL5uBQ/S2N1h+2rfXo32mMIMPPfHrsQ=;
 b=R6pS0yzuZOaFpFmnxU89AJM2bsf31iQqQoqSi9lhjyZrEIEGuDKjoLdsPW43URO6bA
 lFASGqXxjM9A08DohwE5F6QThkLt4oNhQ+OORWu+Ia/1tLDGQoJjUzn7gZeEML1eRqpF
 h4rHWc26DETw9d6ZuBx1veKkXzSx7/SYolCviDjY+/rTltuqlpIpQGcxovu0Vp7X68o5
 apYAXORTtGLshEpJ2qulPTft//ChpkmlvkpgC+kV+dEOtCjjk3Rg6xpgZvOHG6hX9pEP
 WF7euWTM3WLmVpcpsMoCt9eTH1ad0Z7jMhoOz36ajyZgR4RkphESwOLg6FQKWRjZAruO
 jTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831042; x=1688423042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGxhu0qSKW5xeL5uBQ/S2N1h+2rfXo32mMIMPPfHrsQ=;
 b=W9hyLfU6v22Tvszbt7xUKYGRo10zZQr9w8dvYbZflrsDQ8dFXnxJvFjYmQce2tblJR
 nVLfsRQR8mqDu6kvp8zC+luIA0g93r90w/xp3BR9ZwaRTtuhIJx/xuzjGX2WHs3oCrzL
 EQLWsTGs1PSj6Z2Nh6ie/igIy2QI5s45xopOtSQKDjttQdRGNVn+UxmBStR8J8sYjQGQ
 HGCQEVu/RunvC42YYS72yi1k17YW8hGoqMTSKLPTDM5lSGqBcLJHSXvchmP62+ODZiAb
 rXp/HHjno3B6av1wylYzne0sB/7V+PYRaLdfOYMf3eLW6gnjvEn//wgvvuG0Kcxr6NNt
 XTgg==
X-Gm-Message-State: AC+VfDxDa2rXdmeEFyJIgVgw3AsXQuXCiSguadeHjl1gbkbkZndo3mGp
 bDdBUjzzHumWO+W0GzFdTj9DqDfZbv685DUdMfE=
X-Google-Smtp-Source: ACHHUZ7A8YDIRlXFyY5X0vqgzMhe2293oVlFPgocJdpeMS9pObOBOzECF8PFaChEQpHO2AM1quDb4g==
X-Received: by 2002:a92:db51:0:b0:330:f7b3:ead with SMTP id
 w17-20020a92db51000000b00330f7b30eadmr14164370ilq.12.1685831041849; 
 Sat, 03 Jun 2023 15:24:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 06/15] linux-user: Use abi_llong not int64_t in syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:46 -0700
Message-Id: <20230603222355.1379711-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
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

Be careful not to change linux_dirent64, which is a host structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0af7249330..2846a8cfa5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1455,8 +1455,8 @@ struct target_stat64 {
     unsigned char   __pad2[6];
     unsigned short  st_rdev;
 
-    int64_t         st_size;
-    int64_t         st_blksize;
+    abi_llong       st_size;
+    abi_llong       st_blksize;
 
     unsigned char   __pad4[4];
     unsigned int    st_blocks;
@@ -1514,7 +1514,7 @@ struct target_stat64 {
 
     unsigned char   __pad3[8];
 
-    int64_t st_size;
+    abi_llong       st_size;
     unsigned int    st_blksize;
 
     unsigned char   __pad4[8];
@@ -1630,10 +1630,10 @@ struct QEMU_PACKED target_stat64 {
     abi_ullong st_rdev;
     abi_ullong __pad1;
 
-    int64_t  st_size;
+    abi_llong st_size;
     abi_int  st_blksize;
     abi_uint __pad2;
-    int64_t st_blocks;      /* Number 512-byte blocks allocated. */
+    abi_llong st_blocks;
 
     int            target_st_atime;
     unsigned int   target_st_atime_nsec;
@@ -1760,7 +1760,7 @@ struct target_stat {
     int          st_gid;
     abi_ulong    st_rdev;
     abi_ulong    st_pad1[3]; /* Reserved for st_rdev expansion */
-    int64_t      st_size;
+    abi_llong    st_size;
     abi_long     target_st_atime;
     abi_ulong    target_st_atime_nsec; /* Reserved for st_atime expansion */
     abi_long     target_st_mtime;
@@ -1769,7 +1769,7 @@ struct target_stat {
     abi_ulong    target_st_ctime_nsec; /* Reserved for st_ctime expansion */
     abi_ulong    st_blksize;
     abi_ulong    st_pad2;
-    int64_t      st_blocks;
+    abi_llong    st_blocks;
 };
 
 #elif defined(TARGET_ABI_MIPSO32)
@@ -1824,7 +1824,7 @@ struct target_stat64 {
     abi_ulong       st_rdev;
     abi_ulong       st_pad1[3];     /* Reserved for st_rdev expansion  */
 
-    int64_t         st_size;
+    abi_llong       st_size;
 
     /*
      * Actually this should be timestruc_t st_atime, st_mtime and st_ctime
@@ -1842,7 +1842,7 @@ struct target_stat64 {
     abi_ulong       st_blksize;
     abi_ulong       st_pad2;
 
-    int64_t         st_blocks;
+    abi_llong       st_blocks;
 };
 
 #elif defined(TARGET_ALPHA)
@@ -2051,7 +2051,7 @@ struct target_stat64  {
     unsigned int  st_uid;       /* User ID of the file's owner. */
     unsigned int  st_gid;       /* Group ID of the file's group. */
     abi_ullong st_rdev;         /* Device number, if device. */
-    int64_t st_size;            /* Size of file, in bytes. */
+    abi_llong st_size;          /* Size of file, in bytes. */
     abi_ulong st_blksize;       /* Optimal block size for I/O. */
     abi_ulong __unused2;
     abi_ullong st_blocks;       /* Number 512-byte blocks allocated. */
@@ -2105,10 +2105,10 @@ struct target_stat64 {
     unsigned int st_gid;
     abi_ullong st_rdev;
     abi_ullong __pad1;
-    int64_t st_size;
+    abi_llong st_size;
     int st_blksize;
     int __pad2;
-    int64_t st_blocks;
+    abi_llong st_blocks;
     int target_st_atime;
     unsigned int target_st_atime_nsec;
     int target_st_mtime;
@@ -2165,9 +2165,9 @@ struct target_stat64 {
     abi_uint   st_gid;
     abi_ullong st_rdev;
     abi_uint   _pad2;
-    int64_t    st_size;
+    abi_llong  st_size;
     abi_int    st_blksize;
-    int64_t    st_blocks;
+    abi_llong  st_blocks;
     abi_int    target_st_atime;
     abi_uint   target_st_atime_nsec;
     abi_int    target_st_mtime;
@@ -2790,7 +2790,7 @@ struct target_user_cap_data {
 #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
 
 struct target_statx_timestamp {
-    int64_t tv_sec;
+    abi_llong tv_sec;
     abi_uint tv_nsec;
     abi_int __reserved;
 };
-- 
2.34.1


