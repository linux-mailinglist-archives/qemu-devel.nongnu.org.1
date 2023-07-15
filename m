Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7257548F9
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfip-000493-Bx; Sat, 15 Jul 2023 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiE-00041U-NP
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiD-0001EH-2k
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so26406615e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429207; x=1692021207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtm9LlPfPfRyjkKrgBvN2xo7wsnPpDSqZNVUjufgcPA=;
 b=DFt53Ulxvd6K4euDdopprRMIFdeqqC5PGkDk0o+Do6USXwTk+mlpzvgqV+erSITt7J
 cZ9PsRtNzVJCksQJE6Ph0TnM20Dl/w6nznHsO9QalVym0jaKKjB3P7KCmmnmxKzVvVhf
 qJ+lLBgp+cjJfHn5R7f0/aNI8WrGMJuvMPmLfJ5XgnpQe/P0UeAiGW6AjPtTdDYb+Dgv
 zTzxFbS86bdj8DHxLuJkvMJHNT3JgAPzmNVNy3CAWPv40EgUbAC3n2RYWLuWrtkj5Stn
 I4HfyK+y5acbS7G9pkF5B/GNGjYSl/3gdi9PbZ3wlpDAgPWusKVEJL8eFgIXHHUf9uqR
 8D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429207; x=1692021207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtm9LlPfPfRyjkKrgBvN2xo7wsnPpDSqZNVUjufgcPA=;
 b=S1C1C8cGKKK/p/Cr3Ja6nkyBvRSAVr7t0y2GKI1/+IsegUVPgK2vqXrpSTp+nHi2I+
 C9rfGswL59xsgQ6X4MuW8X3PNLEm5j5oXq2L8acA3KT8vukJHxWgyRFzbgRefzxAv2w4
 UgWlKe/Hd3U5x8kA2suyF9TpreEooFj4wC1u1oEnlLg/XwpQLEy+0+KrIjpzX24v/fW1
 ickcWODdT+C5bVi94BCS+5u33/mBSzZ8bHXVi4mIYRB8DZI9hBhIZx8Q65a6U5sA+jzB
 LEtMVEYNQCcp23bnFPWtDth/PxUgJri4f1Dsf6rFwAanzCbKLtrdqPnFg0TCQyFjZwcY
 TPBQ==
X-Gm-Message-State: ABy/qLYI9H9/AA1bTlSnT8hO/FW4cc8Qs2VBIPdx/l/VnSNpG3ynEK6X
 0Hv7LsTEFpIoJWmA5NJ1tGU9ishVLB8DZTMGQZdKjw==
X-Google-Smtp-Source: APBJJlEGio/N24RxDZKsxK6RB8wzeEJB0WLwh1wmJ+hRAZtwFqhoJC/sPJD0jGyP4uzb3fNX5Juv3g==
X-Received: by 2002:a05:600c:22c9:b0:3fa:96ad:5d2e with SMTP id
 9-20020a05600c22c900b003fa96ad5d2emr6665845wmg.19.1689429207272; 
 Sat, 15 Jul 2023 06:53:27 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/47] linux-user: Use abi_llong not long long in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:39 +0100
Message-Id: <20230715135317.7219-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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


