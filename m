Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09F7213A3
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfO-00072i-3I; Sat, 03 Jun 2023 18:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfL-00071O-2Y
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:07 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfJ-0004xB-IZ
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:06 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6af6f5fc42aso3403316a34.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831044; x=1688423044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDVzoJc/xiN76N7bNFB6PF9ZAgv1sIfOb/zMUUnOs+Y=;
 b=BYcvPB63xZYINUgp+7XE5PEx1yTdb3ZccT0xK01TbT/SLiQ4qDe+AH14kJMEQgFwMw
 h+5yyLbJ5JiWNaHV/BY0bOD40HnZZgKNkCBlPFlKq2bzOo2Xvv6cF82QDr2ljcoHTjMN
 rDTBEaX4KLPGf6iOTU73R8IGrkizCjffRIWbY4g7TIOtYQtDtzujN/6y4k9Y/h9RJCCz
 NoHjOoBPJA233Kp8PnEp13hfBsrZ3U6QwwDc9OHxBT2r4hp2Eup2DwTuCco9+UcCV1dc
 0ruG9llBZlpP1y4AKxoaVhAGgLRuDDUQYMC4FP80yKI4AkSDOjk3epzLY6qwpNRU4+ZT
 4jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831044; x=1688423044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDVzoJc/xiN76N7bNFB6PF9ZAgv1sIfOb/zMUUnOs+Y=;
 b=PTvPjna7FRR+P5Rux/MDdC7qmrM+MwpzUWMYuSqwFQ7fVPbUrAz3JZWAxZ1JTOCjHX
 RgFJsyS9KLiS8M9pp+qYSG7u9/1iynvo1KFSLR6yyXkomM0iCKlLai518u9Q3ZFpr3x3
 wOAGRh+Omlfyo11/ndS2JtkXkIojJd9y+CoBCwDkhkDtv01avHRk5em+aGlAlmCR9reU
 ihRPOOoFnjGr3OxNjtmSovx+v5u/ztXx03vauM5fCh2+2YIU/Fc9URcudyXOuh5Tfo7p
 r8pkXx3zXaK7L+GQ6wtCWtwE4HCjhhgynmLsXQhO1oM3QdM1XE57F1jnwem00pGCTVxG
 5QDA==
X-Gm-Message-State: AC+VfDwT8Oh/ubkmfM1VSNVwj/05mxbOFQmi7cdm2hijX0Ao0WUMGTwz
 kw69q1BWcuZc8DUfSubdIQyP/fSR6oVcpsuq6X8=
X-Google-Smtp-Source: ACHHUZ6uHksjKqFKIMt2+M2wGhuRC4QXkhhFEu9Q+eMRt6fS9oGZ1eW/xya8oJEusD+5aWIZr9rzxA==
X-Received: by 2002:a05:6358:8a5:b0:125:8fac:399f with SMTP id
 m37-20020a05635808a500b001258fac399fmr19039500rwj.17.1685831044487; 
 Sat, 03 Jun 2023 15:24:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 09/15] linux-user: Use abi_llong not long long in
 syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:49 -0700
Message-Id: <20230603222355.1379711-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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


