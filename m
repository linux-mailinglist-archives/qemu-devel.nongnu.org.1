Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840417213AE
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfQ-000746-Kv; Sat, 03 Jun 2023 18:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfN-00072M-5U
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:09 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfL-0004xU-DZ
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:08 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6af6f83fc49so3258941a34.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831046; x=1688423046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDbGa5k/kCLRzj+Bz7KFEZFTndPeLToGaiXLvVFGG7w=;
 b=ACJOdCuZJ742i8QUAkojy/ao7ogefAd5lB6tWE1fiBbTJN9jmJqmbn51hKFfil/PJy
 NfOUO6nEQvNOGt4OYocMm1uvSncHX2U+B/RPgyIzWJKTnr4EwwlKfgmymX+MVUJxQ89F
 Emb66ETbLThGIIRZ86nfe+xhCWE2vhb3OXc9bwIULNeTS10FfkOm4A3qP0jhB4ZbZmZ9
 bXjnQ7oW02gURKpTf6HWKBEPTkqJhy94PPHVrJ3d3GY4VW6GYZdeX2SmiDdHnd72p+47
 fWA+08ZsZFlQPRxVMrgdoFUZ63oCDrNVRyNrCEKNs7lET30lO1w/VvSVeBSno0MrmlZO
 Pw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831046; x=1688423046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDbGa5k/kCLRzj+Bz7KFEZFTndPeLToGaiXLvVFGG7w=;
 b=gb/lHCoN2cfF50le3twC1Cymtif6+8DwhLx1HRVdIurA0i137idXbD0q6lFEhMG3sa
 uTxd5Sw1F2DJNhy+NCHf2pBK9Xk14HAwKhtJnfkkwqf12TCbDHFVF+end8a8af4XIlWU
 hYrAcDZREXtpegryDYp8vSMRZsDGDcqPlW5E+u7+O76AZeuzv2orF38n++Ge9kcBS6Cf
 jl5USizZGvrxGTD0p4k7NGUYb24KKlL25ZOG0e1MbHdt1om8uMDSySbOygXZyFf5nIty
 TAkA0TIQNYxZjCxmFDsJvHu9atlfjQ7bCYq8Av5+TLhZO24hlGDyX7F08VDF2qfNN9Ge
 KfQA==
X-Gm-Message-State: AC+VfDxgjjZEOSW+sDTUWWFowQPF32TBCx+YZ1twacm+5hvI1OzRs/G7
 Dl2/BOCaqdjgTyww/0TF56dpf2qDnEopgDOqdOQ=
X-Google-Smtp-Source: ACHHUZ4paydiAQhCPcJCUc2UTF50qb8lEbmNPpXhlMLqturRKsh1B1sWfgHunonHJDtXZjHZ8NXJXQ==
X-Received: by 2002:a05:6358:7188:b0:123:390b:178f with SMTP id
 t8-20020a056358718800b00123390b178fmr17664891rwt.5.1685831046065; 
 Sat, 03 Jun 2023 15:24:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 11/15] linux-user: Use abi_ushort not unsigned short in
 syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:51 -0700
Message-Id: <20230603222355.1379711-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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


