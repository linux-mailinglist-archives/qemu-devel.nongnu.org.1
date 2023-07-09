Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CB74C712
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAZ-0008Lx-DB; Sun, 09 Jul 2023 14:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAU-0008JH-H1
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAS-0000Hw-Mz
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so39208555e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927395; x=1691519395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0axJfNA+Z363BLcyj9VA5KZ1tFbJa96aH9vwiYFI9Ic=;
 b=xRRB06FtD4dX9UYW61/EiF+x3XZccrB4nR0mUY4/GTc2Em1uhXoMEafud47lIltII2
 mgKIvJDGnyDRd7RjT6AJDGpvnSmd4/wDAevPuyQ8LnZ8jOGnH/1RLZsoh3D4Hj76aqqb
 4SKIA9Ez/Ui34dCedvDVNOWndGHERTfqyk4aJmpFFudMcexACYyx8vLXLyBPiDCAyCXg
 D4Mu9mPyHzhRSINSlGBLojQMFZi1FkLdlI4nifluhukHRj9m03FRcXcSAC8i/hLNTvT0
 2Z1ERamLjyw4Y0XQTIGBS708gMuw4V/k1MFNfMrYa5wmgLo6KhRhK+TC7bbQRfcy+Smv
 1x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927395; x=1691519395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0axJfNA+Z363BLcyj9VA5KZ1tFbJa96aH9vwiYFI9Ic=;
 b=hZkU7/yVuv7iN3silGcGkGaccvlVb9SHcSr0NqrpSH4tRfuJ9UdGZ/PIuBnShwxj96
 5QC8lgyhZxwgNFUsAPnS8W0gFJUciX8Y8TTJJsB4NRzuFQHJQyszHTCxQ45ObR5KUEyd
 VLovaTV7Xj6qcs3bj/27crU81mNCGkNGCSBVrM/yHDQuESnTLjgkeIgnCwTfOhc3P/xE
 UMFaBEKrRFPXmE6jIED3elc6iY+hMEYltBFtSal61gyfN9+rkurf5+Aa/+1KniiX+PlZ
 k3HwdCcsvSkEhdniJpfAtTGv2lTMbH0OLzplzsL4LkzzUVHCbgfz345+XaZ2ZeduWzYK
 IGog==
X-Gm-Message-State: ABy/qLZPD3+UndPg/+XzPmfom6vDia6S77B1dou1EvmGJr1XoWG2S0bN
 HRfgUwuSfuhIZbTqtrwgvU1HTa0PV4QaRRY0K0ZmuA==
X-Google-Smtp-Source: APBJJlHDeXQgcEDF+VnKE9YNqRpbsLdr8qjLoppbX9UN99tjrZCXa6bMhcmDLIjVZ+x3hYUN6E3/kA==
X-Received: by 2002:a7b:c8c9:0:b0:3fc:80a:9948 with SMTP id
 f9-20020a7bc8c9000000b003fc080a9948mr4513052wml.19.1688927395442; 
 Sun, 09 Jul 2023 11:29:55 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/45] linux-user: Use abi_ushort not unsigned short in
 syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:34 +0100
Message-Id: <20230709182934.309468-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
 linux-user/syscall_defs.h | 90 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 442a8aefe3..21ca03b0f4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -432,7 +432,7 @@ typedef struct {
 struct target_dirent {
     abi_long        d_ino;
     abi_long        d_off;
-    unsigned short  d_reclen;
+    abi_ushort      d_reclen;
     char            d_name[];
 };
 
@@ -1210,19 +1210,19 @@ struct target_rtc_pll_info {
 
 #define TARGET_NCC 8
 struct target_termio {
-    unsigned short c_iflag;         /* input mode flags */
-    unsigned short c_oflag;         /* output mode flags */
-    unsigned short c_cflag;         /* control mode flags */
-    unsigned short c_lflag;         /* local mode flags */
+    abi_ushort c_iflag;             /* input mode flags */
+    abi_ushort c_oflag;             /* output mode flags */
+    abi_ushort c_cflag;             /* control mode flags */
+    abi_ushort c_lflag;             /* local mode flags */
     unsigned char c_line;           /* line discipline */
     unsigned char c_cc[TARGET_NCC]; /* control characters */
 };
 
 struct target_winsize {
-    unsigned short ws_row;
-    unsigned short ws_col;
-    unsigned short ws_xpixel;
-    unsigned short ws_ypixel;
+    abi_ushort ws_row;
+    abi_ushort ws_col;
+    abi_ushort ws_xpixel;
+    abi_ushort ws_ypixel;
 };
 
 #include "termbits.h"
@@ -1328,15 +1328,15 @@ struct target_winsize {
     || defined(TARGET_CRIS)
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-    unsigned short st_dev;
-    unsigned short __pad1;
+    abi_ushort st_dev;
+    abi_ushort __pad1;
     abi_ulong st_ino;
-    unsigned short st_mode;
-    unsigned short st_nlink;
-    unsigned short st_uid;
-    unsigned short st_gid;
-    unsigned short st_rdev;
-    unsigned short __pad2;
+    abi_ushort st_mode;
+    abi_ushort st_nlink;
+    abi_ushort st_uid;
+    abi_ushort st_gid;
+    abi_ushort st_rdev;
+    abi_ushort __pad2;
     abi_ulong  st_size;
     abi_ulong  st_blksize;
     abi_ulong  st_blocks;
@@ -1355,7 +1355,7 @@ struct target_stat {
  */
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-    unsigned short  st_dev;
+    abi_ushort      st_dev;
     unsigned char   __pad0[10];
 
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
@@ -1367,7 +1367,7 @@ struct target_stat64 {
     abi_ulong       st_uid;
     abi_ulong       st_gid;
 
-    unsigned short  st_rdev;
+    abi_ushort      st_rdev;
     unsigned char   __pad3[10];
 
     abi_llong       st_size;
@@ -1442,7 +1442,7 @@ struct target_stat {
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     unsigned char   __pad0[6];
-    unsigned short  st_dev;
+    abi_ushort      st_dev;
 
     abi_ullong      st_ino;
     abi_ullong      st_nlink;
@@ -1453,7 +1453,7 @@ struct target_stat64 {
     abi_uint        st_gid;
 
     unsigned char   __pad2[6];
-    unsigned short  st_rdev;
+    abi_ushort      st_rdev;
 
     abi_llong       st_size;
     abi_llong       st_blksize;
@@ -1477,13 +1477,13 @@ struct target_stat64 {
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-    unsigned short  st_dev;
+    abi_ushort      st_dev;
     abi_ulong       st_ino;
-    unsigned short  st_mode;
+    abi_ushort      st_mode;
     short           st_nlink;
-    unsigned short  st_uid;
-    unsigned short  st_gid;
-    unsigned short  st_rdev;
+    abi_ushort      st_uid;
+    abi_ushort      st_gid;
+    abi_ushort      st_rdev;
     abi_long        st_size;
     abi_long        target_st_atime;
     abi_ulong       target_st_atime_nsec;
@@ -1499,7 +1499,7 @@ struct target_stat {
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     unsigned char   __pad0[6];
-    unsigned short  st_dev;
+    abi_ushort      st_dev;
 
     abi_ullong      st_ino;
 
@@ -1510,7 +1510,7 @@ struct target_stat64 {
     abi_uint        st_gid;
 
     unsigned char   __pad2[6];
-    unsigned short  st_rdev;
+    abi_ushort      st_rdev;
 
     unsigned char   __pad3[8];
 
@@ -1544,7 +1544,7 @@ struct target_stat {
     abi_uint  st_mode;
 #else
     abi_uint  st_mode;
-    unsigned short st_nlink;
+    abi_ushort st_nlink;
 #endif
     abi_uint   st_uid;
     abi_uint   st_gid;
@@ -1598,7 +1598,7 @@ struct target_stat {
     abi_ulong st_dev;
     abi_ulong st_ino;
     abi_uint st_mode;
-    unsigned short st_nlink;
+    abi_ushort st_nlink;
     abi_uint st_uid;
     abi_uint st_gid;
     abi_ulong  st_rdev;
@@ -1647,15 +1647,15 @@ struct QEMU_PACKED target_stat64 {
 #elif defined(TARGET_M68K)
 
 struct target_stat {
-    unsigned short st_dev;
-    unsigned short __pad1;
-    abi_ulong st_ino;
-    unsigned short st_mode;
-    unsigned short st_nlink;
-    unsigned short st_uid;
-    unsigned short st_gid;
-    unsigned short st_rdev;
-    unsigned short __pad2;
+    abi_ushort st_dev;
+    abi_ushort __pad1;
+    abi_ulong  st_ino;
+    abi_ushort st_mode;
+    abi_ushort st_nlink;
+    abi_ushort st_uid;
+    abi_ushort st_gid;
+    abi_ushort st_rdev;
+    abi_ushort __pad2;
     abi_ulong  st_size;
     abi_ulong  st_blksize;
     abi_ulong  st_blocks;
@@ -1895,10 +1895,10 @@ struct target_stat64 {
 struct target_stat {
     abi_ulong  st_dev;
     abi_ulong  st_ino;
-    unsigned short st_mode;
-    unsigned short st_nlink;
-    unsigned short st_uid;
-    unsigned short st_gid;
+    abi_ushort st_mode;
+    abi_ushort st_nlink;
+    abi_ushort st_uid;
+    abi_ushort st_gid;
     abi_ulong  st_rdev;
     abi_ulong  st_size;
     abi_ulong  st_blksize;
@@ -2619,8 +2619,8 @@ struct target_sysinfo {
     abi_ulong bufferram;            /* Memory used by buffers */
     abi_ulong totalswap;            /* Total swap space size */
     abi_ulong freeswap;             /* swap space still available */
-    unsigned short procs;           /* Number of current processes */
-    unsigned short pad;             /* explicit padding for m68k */
+    abi_ushort procs;               /* Number of current processes */
+    abi_ushort pad;                 /* explicit padding for m68k */
     abi_ulong totalhigh;            /* Total high memory size */
     abi_ulong freehigh;             /* Available high memory size */
     abi_uint mem_unit;              /* Memory unit size in bytes */
-- 
2.34.1


