Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916574C72E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAW-0008Km-Oh; Sun, 09 Jul 2023 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAL-0008EV-MH
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAK-0000Ey-4E
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso37951225e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927386; x=1691519386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDhKHcH/mNT2yQDdOveHYCYG5DGoM6IQc0ARd1bSGIA=;
 b=TnEVosVyugd9dHHVAysxpaDfm1vWsUP8Z4gQzRDB9aTTEJnBEN+8vrGJEvk5W7x2TE
 QAcJ8TGT9pPxPYQv4Ly0u51XZL/OsTlgZJ3HNgm/RpfTEwDZ6pCkws6Mspcy9xZxiZGt
 /44g5Uoe1bB8NUmI8ZDQtQsTzIj4LbhGELyJuCnJ1hjViRIfAMQDHz37+0tEYVycBMn/
 NQR9wt584vyue4CAvajnUL3qch9+c9eb9rz+S0VLamGq4KtRDi1nQa+LbuTy2iTBhAUt
 YI82y94HB/EadW1kbBlaDbytEC+SBEWhzwGqE+a9fP8O+qbB+VdkZgV7gTXtUCB9o3aJ
 St8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927386; x=1691519386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDhKHcH/mNT2yQDdOveHYCYG5DGoM6IQc0ARd1bSGIA=;
 b=JIYBOOkx2bhlwNQFmgCwPGcf6YC+Dl0n9FI+LKG+2y3oFJg3uB+cYeBzq+ErZssCtB
 1utG3UFfiw5uQGgm2/HL2HSFACvbdqlp9Kc78XCqpmct6yTJBUg6qn01r2jNb4m/iN7i
 aIH6O0XNpXq69syqYreg+QriGJR103qnfzIExyYRncZ2Kv0FZ+1V5cBbB+0GIGd7sZ/q
 8y/s0KlHBqSd622V01ZZ0+ViCiwVnqtyQjocj20tP9HAmU0Vc/nN+CV6FxaLhjDLkKno
 mrXOcwnFUp5KRsBEfKpFCnKJ60MKGwni1cmd3dz0+9l/d3N0GkkiTyWLeBcjSpcuD8UY
 Jrtw==
X-Gm-Message-State: ABy/qLYXTprrsRJopc+LeWCvifx6ZShc1iBhq4vghXtO3311K28oBwca
 YVw7txjB8igec00Dyr/WAeZmEvAj9uzhxn/2J3gnqQ==
X-Google-Smtp-Source: APBJJlHoAPhOPur0KQuoOhA+1plcWTdJHo7d0DxV2ATiDlg38cMsaSRm0o4R6bqX+K9jCEC8ld7pFw==
X-Received: by 2002:a1c:f211:0:b0:3fc:5d2:9286 with SMTP id
 s17-20020a1cf211000000b003fc05d29286mr3368016wmc.2.1688927386707; 
 Sun, 09 Jul 2023 11:29:46 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/45] linux-user: Use abi_llong not int64_t in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:24 +0100
Message-Id: <20230709182934.309468-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


