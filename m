Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0650B74C76D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:45:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAR-0008H5-MT; Sun, 09 Jul 2023 14:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAP-0008G2-Dy
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAN-0000Gj-LN
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so43505445e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927390; x=1691519390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bny+QrSk9kOHXY9n7JH/neknIRvMmyCuxL4ghWqdlbg=;
 b=qxSjdrwC5/G+wEy90Vp9NXusAs7GBg4+7qoI850nT3+Kx/2b5Hb7HsFe/f6TJO/CA+
 zVMc4bKBvYWK+e907D9H9NDEu+R7gZs3D5KMQELmgMwyIC8Z0rMW4ksnj7tj1WkCVsTw
 0aNG72nriNhH6irds/WsjnoNFEqo+av/duxaGUvh1iWOAk3cm3AjqcKbHFj5NynOqkp+
 8DhY0HdTO7M3hE4/rLdKBt8V1bNdfjx/DduBkX10ZFAu31y6xqMEGej1GzTwTj203Dig
 7o9sm3AGXDHFBb+DT7YlLPhZWdsPVocH9W44uPYNxWGoB6/IITPioO+Y6VTf5XgQ8QWQ
 onLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927390; x=1691519390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bny+QrSk9kOHXY9n7JH/neknIRvMmyCuxL4ghWqdlbg=;
 b=AlSJWqSwPM7OixssIat8hxfilZckL76ToZQj9XQgXUr9z0k6S9eZrLUe7wS4jy0Q9u
 wFWZL0Z+xNPkj5BTyHGsv70hFxbM3uWLIynv4yJn6aLaLDTj69XoWgNoWRXnPi7x4EGQ
 oHiZ74wyVhkEar5s9hQfbHKMM9+/IDaxuiq67Cn/Ni1NcCXtOpNcgesJ3zLOLJ1u1MDI
 tXszNvb/ijsKPjxUqTsFeYwXfIJbJWzfsVmh4CUL6aYDVyhfVUwefvlL+h6mMsSwNekM
 pJjRdHj/629ZTrNQGAHWFAHwgh2wzoF2PR7H3hwSYhQTW5FLWgtev1XsGJmT2bppva4V
 iYXQ==
X-Gm-Message-State: ABy/qLY2c8p2QbGUVgxoJY2Se8o32WmyvA5GMw24fS55JK8N1irWfqKD
 5cRggFrUhTOK4Ju9j7koPFRGDNZNbobmTbF9yGngeA==
X-Google-Smtp-Source: APBJJlGP2+JeATZqUaiWrSWm28TxDRdQKBv6zIurH2rAhYbKUxrPJj9EyDTNnwWRVSqkQ+/Uurzi1Q==
X-Received: by 2002:a1c:7404:0:b0:3fb:424b:ef6e with SMTP id
 p4-20020a1c7404000000b003fb424bef6emr11928434wmc.23.1688927390379; 
 Sun, 09 Jul 2023 11:29:50 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/45] linux-user: Use abi_ullong not unsigned long long in
 syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:28 +0100
Message-Id: <20230709182934.309468-17-richard.henderson@linaro.org>
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


