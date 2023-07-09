Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242A74C71D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAW-0008Kz-Vd; Sun, 09 Jul 2023 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAR-0008HP-U0
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAQ-0000HM-Bq
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so38081695e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927392; x=1691519392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtm9LlPfPfRyjkKrgBvN2xo7wsnPpDSqZNVUjufgcPA=;
 b=l4rfDr3MjK4RE7wEClaQrlzP3TCQBQ6giKIlb7sWPZqLf6eV16xw59LsNjb2kWDGCQ
 3Jd2IiF0f9OiyxhKSrixBPTetc7RwTqZsDhTCBnP87w/YE0XcjZRphfspoB8yGT2kboc
 8RBHfH5LAxJhqjzAQF6QUUsfUXW7oL0n+P2pVmqhjWakUmyUoHehrb3lNFgIBbggZru7
 amduiybTpfQM4lQ4OcMBktvG9RIaenBaggj3da6FX8ilPJhUQR4P50nooGv5qs0wSoOk
 qkTJv4xVbU/6xSAy6KJ3T7NPfS5VFJuQYAqd45khSXGs66AzoOEC14HF+MIy5AW3X6DH
 oFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927392; x=1691519392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtm9LlPfPfRyjkKrgBvN2xo7wsnPpDSqZNVUjufgcPA=;
 b=ZkKRKMm82Wk065NjsfSRc7WPM6jnqFhU2xFwUQRqZ+JyMyEgyh1FBjMDNN3W7ZzGhu
 EpGXYlvD+z4/uh/akY7gEdtS2c9PWy9BTwUgbFqGsorRSG8Qz+wHK02i3OSxKQoSzW5+
 GYFuYDQkLed6Q+RBFxnHjyLmHEI6855jwseVV/k/tTq0ImOneEuigp+jdM17yjJTLcxV
 L/9F+l/JigAMvo67V1YPCMhrIqTf4RawAfx/UfXy68gMbjUpfjjXNSn8/MCCZevJlT6c
 9CEJoTShVP7PVgxeNqfLyvCQzXBJbt4Ov4SHog8ZXhJPIZs1M5H9oswfTl3bonvA6iUT
 E08w==
X-Gm-Message-State: ABy/qLb8uJTGJ1MDDoirL1Nig3U6lIEd9pabtcKXZdkd6maKSEAhkwSu
 z2s8IFvM/TBMm7/qMOwnRP4BA8sQNCczZBxb9U7Mpg==
X-Google-Smtp-Source: APBJJlHOrE2LXwgu/8eWbryzPDQvQd101IfAH1wpA1E7EdoucS+WqZjEPgyfXyy7F4TyA2/CSYfq2g==
X-Received: by 2002:a05:600c:452:b0:3fc:7d2:e0c0 with SMTP id
 s18-20020a05600c045200b003fc07d2e0c0mr3359044wmb.27.1688927392099; 
 Sun, 09 Jul 2023 11:29:52 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/45] linux-user: Use abi_llong not long long in
 syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:30 +0100
Message-Id: <20230709182934.309468-19-richard.henderson@linaro.org>
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
 linux-user/syscall_defs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 45ebacd4b4..e4fcbd16d2 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1370,7 +1370,7 @@ struct target_stat64 {
     unsigned short  st_rdev;
     unsigned char   __pad3[10];
 
-    long long       st_size;
+    abi_llong       st_size;
     abi_ulong       st_blksize;
 
     abi_ulong       st_blocks;      /* Number 512-byte blocks allocated. */
@@ -1403,7 +1403,7 @@ struct target_eabi_stat64 {
     abi_ullong   st_rdev;
     abi_uint     __pad2[2];
 
-    long long       st_size;
+    abi_llong       st_size;
     abi_ulong    st_blksize;
     abi_uint     __pad3;
     abi_ullong   st_blocks;
@@ -1576,10 +1576,10 @@ struct QEMU_PACKED target_stat64 {
     abi_uint st_gid;
     abi_ullong st_rdev;
     abi_ullong __pad0;
-    long long      st_size;
+    abi_llong      st_size;
     int            st_blksize;
     abi_uint       __pad1;
-    long long      st_blocks;       /* Number 512-byte blocks allocated. */
+    abi_llong      st_blocks;       /* Number 512-byte blocks allocated. */
     int            target_st_atime;
     abi_uint       target_st_atime_nsec;
     int            target_st_mtime;
@@ -1689,7 +1689,7 @@ struct target_stat64 {
     abi_ullong      st_rdev;
     unsigned char   __pad3[2];
 
-    long long       st_size;
+    abi_llong       st_size;
     abi_ulong       st_blksize;
 
     abi_ulong       __pad4;         /* future possible st_blocks high bits */
@@ -1933,7 +1933,7 @@ struct QEMU_PACKED target_stat64 {
     abi_ullong      st_rdev;
     unsigned char   __pad3[4];
 
-    long long       st_size;
+    abi_llong       st_size;
     abi_ulong       st_blksize;
 
     abi_ullong      st_blocks;      /* Number 512-byte blocks allocated. */
-- 
2.34.1


