Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E757548EA
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfim-00045P-Pe; Sat, 15 Jul 2023 09:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiC-00040v-CG
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiA-0001DN-7g
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3142970df44so2813896f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429205; x=1692021205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDhKHcH/mNT2yQDdOveHYCYG5DGoM6IQc0ARd1bSGIA=;
 b=a2mLXyWvNFNCzB/3H4pTulMciSxBrCVsWNnsUTXNvZjja1l15Pr0LPw4JNM4TDjdTl
 X7SvQ2fUqVt1e42Zk3IfP1HWV7cxy2UqMjzv+aj2cXuKRNmCp8AQvT1d4TdXCMXH8dIW
 jjzdCRelL2w51XFoCte+uJs/LNoTY9M5xS/z2+kfEyWihO5y22GNZ3fmXu04N6K3EYFs
 2t0KR8iXkGvBbkb/TaH5gHpvhdTCYiQD24x3KqVfAahlxUV3cLX6wK1kt4VApARQgguQ
 bN1y9QfjvCpGjrR7msjamSLhjKVsjwpUoQoFnZn/JHETgGBPMZwfpaZSFojnQGWjsona
 qAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429205; x=1692021205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDhKHcH/mNT2yQDdOveHYCYG5DGoM6IQc0ARd1bSGIA=;
 b=KmD1Pr8xtTarR2HIqb4xW6Ce+VNAkH6RA9jlVjB4KL/TxF8NXoO5Q30J6PzBfeAbqf
 bxE77yUST/U1LTUAmssxohiOiyMsOHU8gZ+25OUoYTWdXJv5pnrTZ6YHHcGD2vKza4CP
 Yl0QSMCSDf+rEQ7wgyQGQtEgg8dJbZ3kn88CtnJHvyZoLFV1GbndAjv3TB1ViL7dWxA/
 QTKO20fad4l0VmcAGWeDPFEBoPTijHikSviEusTaSrTJ0CD8WnbPVyN0JrY/dyRrcFjO
 ZFzqH1CehrEVVa0i4zfHSZmjPJdUeueVpwURBHp+oUHa85aZ0z41LbW7AE2yGh5IK1ID
 1x0A==
X-Gm-Message-State: ABy/qLZXKLqyGPSNBpho7X0oTItG8Z8yV01lw/eQS+NN/kJVHGQ8DEWv
 +YOBpu227AhYJCyQszAqecKwZYJm64LITEIP2bXDtg==
X-Google-Smtp-Source: APBJJlEpVR8XDxlFGWnKRv0afGXQ0/Sw9+52Hpw0hIbsNuFr/QATu0SlQMIQ/J7DQV5K3IhczAbt+g==
X-Received: by 2002:a5d:6110:0:b0:315:a6a5:fe95 with SMTP id
 v16-20020a5d6110000000b00315a6a5fe95mr6189396wrt.52.1689429204895; 
 Sat, 15 Jul 2023 06:53:24 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/47] linux-user: Use abi_llong not int64_t in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:36 +0100
Message-Id: <20230715135317.7219-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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


