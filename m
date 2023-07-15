Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4E754903
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfir-0004EV-N9; Sat, 15 Jul 2023 09:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiA-0003zu-Ub
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi8-0001D0-M3
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so25911915e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429203; x=1692021203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5HDzepAQyRVnixawY50vCjdQyLm/QL5xJqPsc4X3Xg=;
 b=ol9sDhyEwuUyxufDH6oB6cYMleayRudr6C7++rgSNtsflIjy7XUGxnvBtZhJM5/HiM
 ZC7kPBRCLc75qKuOHbqlceLp66rb6aklR4J39S0Ne8WpjdMEGrrsni9+SJgqeneDCORU
 HJPJ+sJweTOb+qU5+NXumvB5w+GXF+O2+dVnFf3/dALPf++TujzH2gmBFNbuh+O6xl1t
 g1BBHuftspGir1BqgZagO/hO3rn6pC8oW/s2yEoA7ex6fD/mNLreVmwh+vN0lRYi9iHJ
 kKNRtyvYMoLAcmDS+zXFyvJo3HLOGvval8e5/jxwi5kdA8VXldxnCjhhGHT0kpJdsdBH
 WD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429203; x=1692021203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5HDzepAQyRVnixawY50vCjdQyLm/QL5xJqPsc4X3Xg=;
 b=L2PPbbi3af7xa744bCAzIcoKlz5KYM61zUPz2c/9qyjmkcEnAIUiLfreUSPjuuhd8L
 PHA3ObPkGfzU6RwS9IDyjtfBCZj31i//AJDmnU6pdlOqaBAEKfx5kWodxazdXRqGf4os
 HaB7PYVuGcvZyG8Cj755ucmFadk9YbNw/PWxGpdojrQSgWLavAmX1DX/IrXesIH29p04
 r1r9GyYHn8Rx9BST6wvd1s25stHu2KwR4kCxWeP/UeVozYZOJFLF2krKfEN8G4M/hir3
 doKll48jVd3555oE9mX5Do5NOkUmktVJD0xV/kyJRBPu2SVX5CW2ZEodyO9YiA5tMx8h
 v96g==
X-Gm-Message-State: ABy/qLZWLJiGxU1Bb4zSTTkLfSyeJepZv1SKMgSPWzC/WEwSsBXH3Ie0
 xIde87x5sLFwmiwqTO8F/AVxAP14k9Et+9n8MuMLKQ==
X-Google-Smtp-Source: APBJJlEKt5b5JIZQ0FMnk07zlyKPGmd+xt9M7+4cvuVYAztfnFTWQs7iW063SWmM4y2CGHWzv3Kt+w==
X-Received: by 2002:a05:6000:c9:b0:314:1230:29b0 with SMTP id
 q9-20020a05600000c900b00314123029b0mr6265028wrx.52.1689429202761; 
 Sat, 15 Jul 2023 06:53:22 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/47] linux-user: Use abi_uint not uint32_t in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:33 +0100
Message-Id: <20230715135317.7219-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
 linux-user/syscall_defs.h | 108 +++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a4e4df8d3e..414d88a9ec 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -67,7 +67,7 @@
 #define USE_UID16
 #define target_id uint16_t
 #else
-#define target_id uint32_t
+#define target_id abi_uint
 #endif
 
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4)  \
@@ -215,9 +215,9 @@ struct target_ip_mreqn {
 
 struct target_ip_mreq_source {
     /* big endian */
-    uint32_t imr_multiaddr;
-    uint32_t imr_interface;
-    uint32_t imr_sourceaddr;
+    abi_uint imr_multiaddr;
+    abi_uint imr_interface;
+    abi_uint imr_sourceaddr;
 };
 
 struct target_linger {
@@ -508,9 +508,9 @@ typedef abi_ulong target_old_sa_flags;
 
 #if defined(TARGET_MIPS)
 struct target_sigaction {
-    uint32_t        sa_flags;
+    abi_uint        sa_flags;
 #if defined(TARGET_ABI_MIPSN32)
-    uint32_t        _sa_handler;
+    abi_uint        _sa_handler;
 #else
     abi_ulong       _sa_handler;
 #endif
@@ -1620,19 +1620,19 @@ struct target_stat {
 struct QEMU_PACKED target_stat64 {
     uint64_t st_dev;
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
-    uint32_t pad0;
-    uint32_t __st_ino;
+    abi_uint pad0;
+    abi_uint __st_ino;
 
-    uint32_t st_mode;
-    uint32_t st_nlink;
-    uint32_t st_uid;
-    uint32_t st_gid;
+    abi_uint st_mode;
+    abi_uint st_nlink;
+    abi_uint st_uid;
+    abi_uint st_gid;
     uint64_t st_rdev;
     uint64_t __pad1;
 
     int64_t  st_size;
     int32_t  st_blksize;
-    uint32_t __pad2;
+    abi_uint __pad2;
     int64_t st_blocks;      /* Number 512-byte blocks allocated. */
 
     int            target_st_atime;
@@ -2227,19 +2227,19 @@ struct target_statfs {
 #endif
 
 struct target_statfs64 {
-    uint32_t        f_type;
-    uint32_t        f_bsize;
-    uint32_t        f_frsize;       /* Fragment size - unsupported */
-    uint32_t        __pad;
+    abi_uint        f_type;
+    abi_uint        f_bsize;
+    abi_uint        f_frsize;       /* Fragment size - unsupported */
+    abi_uint        __pad;
     uint64_t        f_blocks;
     uint64_t        f_bfree;
     uint64_t        f_files;
     uint64_t        f_ffree;
     uint64_t        f_bavail;
     target_fsid_t   f_fsid;
-    uint32_t        f_namelen;
-    uint32_t        f_flags;
-    uint32_t        f_spare[5];
+    abi_uint        f_namelen;
+    abi_uint        f_flags;
+    abi_uint        f_spare[5];
 };
 #elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) ||       \
        defined(TARGET_SPARC64) || defined(TARGET_AARCH64) ||    \
@@ -2307,33 +2307,33 @@ struct target_statfs64 {
 };
 #else
 struct target_statfs {
-    uint32_t f_type;
-    uint32_t f_bsize;
-    uint32_t f_blocks;
-    uint32_t f_bfree;
-    uint32_t f_bavail;
-    uint32_t f_files;
-    uint32_t f_ffree;
+    abi_uint f_type;
+    abi_uint f_bsize;
+    abi_uint f_blocks;
+    abi_uint f_bfree;
+    abi_uint f_bavail;
+    abi_uint f_files;
+    abi_uint f_ffree;
     target_fsid_t f_fsid;
-    uint32_t f_namelen;
-    uint32_t f_frsize;
-    uint32_t f_flags;
-    uint32_t f_spare[4];
+    abi_uint f_namelen;
+    abi_uint f_frsize;
+    abi_uint f_flags;
+    abi_uint f_spare[4];
 };
 
 struct target_statfs64 {
-    uint32_t f_type;
-    uint32_t f_bsize;
+    abi_uint f_type;
+    abi_uint f_bsize;
     uint64_t f_blocks;
     uint64_t f_bfree;
     uint64_t f_bavail;
     uint64_t f_files;
     uint64_t f_ffree;
     target_fsid_t f_fsid;
-    uint32_t f_namelen;
-    uint32_t f_frsize;
-    uint32_t f_flags;
-    uint32_t f_spare[4];
+    abi_uint f_namelen;
+    abi_uint f_frsize;
+    abi_uint f_flags;
+    abi_uint f_spare[4];
 };
 #endif
 
@@ -2713,9 +2713,9 @@ struct target_epoll_event {
 #endif
 
 struct target_ucred {
-    uint32_t pid;
-    uint32_t uid;
-    uint32_t gid;
+    abi_uint pid;
+    abi_uint uid;
+    abi_uint gid;
 };
 
 typedef int32_t target_timer_t;
@@ -2754,14 +2754,14 @@ struct target_sigevent {
 };
 
 struct target_user_cap_header {
-    uint32_t version;
+    abi_uint version;
     int pid;
 };
 
 struct target_user_cap_data {
-    uint32_t effective;
-    uint32_t permitted;
-    uint32_t inheritable;
+    abi_uint effective;
+    abi_uint permitted;
+    abi_uint inheritable;
 };
 
 /* from kernel's include/linux/syslog.h */
@@ -2791,19 +2791,19 @@ struct target_user_cap_data {
 
 struct target_statx_timestamp {
     int64_t tv_sec;
-    uint32_t tv_nsec;
+    abi_uint tv_nsec;
     int32_t __reserved;
 };
 
 struct target_statx {
     /* 0x00 */
-    uint32_t stx_mask;       /* What results were written [uncond] */
-    uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
+    abi_uint stx_mask;       /* What results were written [uncond] */
+    abi_uint stx_blksize;    /* Preferred general I/O size [uncond] */
     uint64_t stx_attributes; /* Flags conveying information about the file */
     /* 0x10 */
-    uint32_t stx_nlink;      /* Number of hard links */
-    uint32_t stx_uid;        /* User ID of owner */
-    uint32_t stx_gid;        /* Group ID of owner */
+    abi_uint stx_nlink;      /* Number of hard links */
+    abi_uint stx_uid;        /* User ID of owner */
+    abi_uint stx_gid;        /* Group ID of owner */
     uint16_t stx_mode;       /* File mode */
     uint16_t __spare0[1];
     /* 0x20 */
@@ -2817,10 +2817,10 @@ struct target_statx {
     struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
     struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
     /* 0x80 */
-    uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
-    uint32_t stx_rdev_minor;
-    uint32_t stx_dev_major; /* ID of device containing file [uncond] */
-    uint32_t stx_dev_minor;
+    abi_uint stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
+    abi_uint stx_rdev_minor;
+    abi_uint stx_dev_major; /* ID of device containing file [uncond] */
+    abi_uint stx_dev_minor;
     /* 0x90 */
     uint64_t __spare2[14];  /* Spare space for future expansion */
     /* 0x100 */
-- 
2.34.1


