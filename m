Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFABB74C703
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAQ-0008GQ-CA; Sun, 09 Jul 2023 14:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAK-0008ET-T8
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAI-0000EO-8I
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso41758125e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927385; x=1691519385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO73AWeIHAR2oL9a8MGDntKx1EKSzMSEdZSpHf3WsVU=;
 b=UuwapAyzwGqXFa/V/y7gjb+mDezUyPb+DxGQAC/ul/nQ4yScL4ekJv8YsBNoDWa5JX
 e4GdfpJqsh0HUaIBCcTzkpPA0WYcn89SvbDPPHCLcXtSqvpjRUDiDqFc8wFf0ETRXo9I
 yVTvW1BHkg0BdG9VHcdWhh/UTWG8k5c5qSLE/Rg+TJQ+pO2fMovHxh/eedjTATHghMrG
 wkydZoexNNwrOdPukNTQMuIYveOeJMFqNo9BLL1arHylnxykrwmUOmyXtqj8j9ibmGFu
 GmwN3v1l5PpCVIlbuZF1d7TD5T4RO77fc3RYO7hU3DeY9dre08E1P755c/QUiaONFMmT
 P2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927385; x=1691519385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO73AWeIHAR2oL9a8MGDntKx1EKSzMSEdZSpHf3WsVU=;
 b=TeXuEGmtDPRh9oIPIM+5eqp4LqIZxli42YXu5sq8CAF+Uncsir5+JcbteIATpP1Esi
 3btSjNJWWtHKfXevkQYYA1cKthlxfiua++cEVs8paNYFZLTt67Kir8vO1AURbvXNWf7U
 UFQyQnGmD+UXxZJUqMihR0M7q3rJfPyi5xHSIgOkcPczmqQWvr7tnAe7ctsX9W9WvNvI
 acRdNdgDMEsjpQ/2fbbUCjtr2QK152pYTN0xNsljNo3IzKTFwtTOJKi5F5B9nhk9HX/m
 HDYGZtH3hIvLVscHMlZg/vi3Eeer4ROo813/snoFYtCRnVuCOIYd/92eTenphrOjJMX8
 UmPg==
X-Gm-Message-State: ABy/qLZqTcoMwot6ewE/1CUf7z78HZke5gkkC9RG7USRdOxbWCFlw+tn
 w2Ah0E8xyWMdHQBMLO2g7MOOKb2JyArIXrvr0oHUfg==
X-Google-Smtp-Source: APBJJlH95ByHo8DO2+hE4VPg5DLTIfz0N99B9J3QYduOfpcyrajoiM386R6Iw+1v6WhSvEuxt45tCA==
X-Received: by 2002:a05:600c:3785:b0:3fb:a0fc:1ba1 with SMTP id
 o5-20020a05600c378500b003fba0fc1ba1mr11048130wmr.35.1688927385044; 
 Sun, 09 Jul 2023 11:29:45 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/45] linux-user: Use abi_ullong not uint64_t in
 syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:22 +0100
Message-Id: <20230709182934.309468-11-richard.henderson@linaro.org>
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

Be careful not to change linux_dirent64, which is a host structure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 72 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index caaa895bec..0af7249330 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1444,8 +1444,8 @@ struct target_stat64 {
     unsigned char   __pad0[6];
     unsigned short  st_dev;
 
-    uint64_t        st_ino;
-    uint64_t        st_nlink;
+    abi_ullong      st_ino;
+    abi_ullong      st_nlink;
 
     unsigned int    st_mode;
 
@@ -1501,7 +1501,7 @@ struct target_stat64 {
     unsigned char   __pad0[6];
     unsigned short  st_dev;
 
-    uint64_t st_ino;
+    abi_ullong      st_ino;
 
     unsigned int    st_mode;
     unsigned int    st_nlink;
@@ -1618,7 +1618,7 @@ struct target_stat {
 /* FIXME: Microblaze no-mmu user-space has a difference stat64 layout...  */
 #define TARGET_HAS_STRUCT_STAT64
 struct QEMU_PACKED target_stat64 {
-    uint64_t st_dev;
+    abi_ullong st_dev;
 #define TARGET_STAT64_HAS_BROKEN_ST_INO 1
     abi_uint pad0;
     abi_uint __st_ino;
@@ -1627,8 +1627,8 @@ struct QEMU_PACKED target_stat64 {
     abi_uint st_nlink;
     abi_uint st_uid;
     abi_uint st_gid;
-    uint64_t st_rdev;
-    uint64_t __pad1;
+    abi_ullong st_rdev;
+    abi_ullong __pad1;
 
     int64_t  st_size;
     abi_int  st_blksize;
@@ -1641,7 +1641,7 @@ struct QEMU_PACKED target_stat64 {
     unsigned int   target_st_mtime_nsec;
     int            target_st_ctime;
     unsigned int   target_st_ctime_nsec;
-    uint64_t st_ino;
+    abi_ullong st_ino;
 };
 
 #elif defined(TARGET_M68K)
@@ -1753,7 +1753,7 @@ struct target_stat {
 struct target_stat {
     abi_ulong    st_dev;
     abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
-    uint64_t     st_ino;
+    abi_ullong   st_ino;
     unsigned int st_mode;
     unsigned int st_nlink;
     int          st_uid;
@@ -1813,7 +1813,7 @@ struct target_stat64 {
     abi_ulong       st_dev;
     abi_ulong       st_pad0[3];     /* Reserved for st_dev expansion  */
 
-    uint64_t        st_ino;
+    abi_ullong      st_ino;
 
     unsigned int    st_mode;
     unsigned int    st_nlink;
@@ -2044,17 +2044,17 @@ struct target_stat {
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64  {
-    uint64_t st_dev;            /* Device */
-    uint64_t st_ino;            /* File serial number */
+    abi_ullong st_dev;          /* Device */
+    abi_ullong st_ino;          /* File serial number */
     unsigned int  st_mode;      /* File mode. */
     unsigned int  st_nlink;     /* Link count. */
     unsigned int  st_uid;       /* User ID of the file's owner. */
     unsigned int  st_gid;       /* Group ID of the file's group. */
-    uint64_t st_rdev;           /* Device number, if device. */
+    abi_ullong st_rdev;         /* Device number, if device. */
     int64_t st_size;            /* Size of file, in bytes. */
     abi_ulong st_blksize;       /* Optimal block size for I/O. */
     abi_ulong __unused2;
-    uint64_t st_blocks;         /* Number 512-byte blocks allocated. */
+    abi_ullong st_blocks;       /* Number 512-byte blocks allocated. */
     abi_ulong target_st_atime;  /* Time of last access. */
     abi_ulong target_st_atime_nsec;
     abi_ulong target_st_mtime;  /* Time of last modification. */
@@ -2097,14 +2097,14 @@ struct target_stat {
 #if !defined(TARGET_RISCV64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-    uint64_t st_dev;
-    uint64_t st_ino;
+    abi_ullong st_dev;
+    abi_ullong st_ino;
     unsigned int st_mode;
     unsigned int st_nlink;
     unsigned int st_uid;
     unsigned int st_gid;
-    uint64_t st_rdev;
-    uint64_t __pad1;
+    abi_ullong st_rdev;
+    abi_ullong __pad1;
     int64_t st_size;
     int st_blksize;
     int __pad2;
@@ -2156,14 +2156,14 @@ struct target_stat {
 
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
-    uint64_t   st_dev;
+    abi_ullong st_dev;
     abi_uint   _pad1;
     abi_uint   _res1;
     abi_uint   st_mode;
     abi_uint   st_nlink;
     abi_uint   st_uid;
     abi_uint   st_gid;
-    uint64_t   st_rdev;
+    abi_ullong st_rdev;
     abi_uint   _pad2;
     int64_t    st_size;
     abi_int    st_blksize;
@@ -2174,7 +2174,7 @@ struct target_stat64 {
     abi_uint   target_st_mtime_nsec;
     abi_int    target_st_ctime;
     abi_uint   target_st_ctime_nsec;
-    uint64_t   st_ino;
+    abi_ullong st_ino;
 };
 
 #elif defined(TARGET_LOONGARCH64)
@@ -2231,11 +2231,11 @@ struct target_statfs64 {
     abi_uint        f_bsize;
     abi_uint        f_frsize;       /* Fragment size - unsupported */
     abi_uint        __pad;
-    uint64_t        f_blocks;
-    uint64_t        f_bfree;
-    uint64_t        f_files;
-    uint64_t        f_ffree;
-    uint64_t        f_bavail;
+    abi_ullong      f_blocks;
+    abi_ullong      f_bfree;
+    abi_ullong      f_files;
+    abi_ullong      f_ffree;
+    abi_ullong      f_bavail;
     target_fsid_t   f_fsid;
     abi_uint        f_namelen;
     abi_uint        f_flags;
@@ -2324,11 +2324,11 @@ struct target_statfs {
 struct target_statfs64 {
     abi_uint f_type;
     abi_uint f_bsize;
-    uint64_t f_blocks;
-    uint64_t f_bfree;
-    uint64_t f_bavail;
-    uint64_t f_files;
-    uint64_t f_ffree;
+    abi_ullong f_blocks;
+    abi_ullong f_bfree;
+    abi_ullong f_bavail;
+    abi_ullong f_files;
+    abi_ullong f_ffree;
     target_fsid_t f_fsid;
     abi_uint f_namelen;
     abi_uint f_frsize;
@@ -2799,7 +2799,7 @@ struct target_statx {
     /* 0x00 */
     abi_uint stx_mask;       /* What results were written [uncond] */
     abi_uint stx_blksize;    /* Preferred general I/O size [uncond] */
-    uint64_t stx_attributes; /* Flags conveying information about the file */
+    abi_ullong stx_attributes; /* Flags conveying information about the file */
     /* 0x10 */
     abi_uint stx_nlink;      /* Number of hard links */
     abi_uint stx_uid;        /* User ID of owner */
@@ -2807,10 +2807,10 @@ struct target_statx {
     uint16_t stx_mode;       /* File mode */
     uint16_t __spare0[1];
     /* 0x20 */
-    uint64_t stx_ino;        /* Inode number */
-    uint64_t stx_size;       /* File size */
-    uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
-    uint64_t stx_attributes_mask; /* Mask to show what is supported */
+    abi_ullong stx_ino;      /* Inode number */
+    abi_ullong stx_size;     /* File size */
+    abi_ullong stx_blocks;   /* Number of 512-byte blocks allocated */
+    abi_ullong stx_attributes_mask; /* Mask to show what is supported */
     /* 0x40 */
     struct target_statx_timestamp  stx_atime;  /* Last access time */
     struct target_statx_timestamp  stx_btime;  /* File creation time */
@@ -2822,7 +2822,7 @@ struct target_statx {
     abi_uint stx_dev_major; /* ID of device containing file [uncond] */
     abi_uint stx_dev_minor;
     /* 0x90 */
-    uint64_t __spare2[14];  /* Spare space for future expansion */
+    abi_ullong __spare2[14]; /* Spare space for future expansion */
     /* 0x100 */
 };
 
-- 
2.34.1


