Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442976A261
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:04:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa29-0000tT-2W; Mon, 31 Jul 2023 17:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa23-0000sf-Hp
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa21-0006Pc-Dh
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bbbbb77b38so29007525ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837339; x=1691442139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyEq/ubSCgSD+ft15Usf/3AynvuxUvcxwUVoiqZ43kc=;
 b=ToR4rD1dxnuU8AeOWh4/Rwnj8qj8+GYsy6kTkAG8gjufqOBCncVyYXhtNJ5Kp8W2LX
 cGqjldi7bdBlRdskC6II5xUHuJUyDMLO+Kaa0ENyGAIDxkWJAtgd/PH75erNQW2LhQD2
 0a9JmSxTcRbddBao2ke1IV7/c2auVIldQBR5uwPLbK5um7hQLnt4C3XHgxV9HOzQPv9Z
 ApnMFJZuo2i4fJBqSkDKKEt2WdEMJ1eDFM4CcpJpNa6s3SUM1EVww/UCMlRxjfaNFSXT
 yFTWLI3wQ1R3hpA5apmd9JouHGV0jWtbZ3O/mMLB2NlxSHuaHdNBch+w+qki0/ETRXfQ
 F75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837339; x=1691442139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyEq/ubSCgSD+ft15Usf/3AynvuxUvcxwUVoiqZ43kc=;
 b=YUPWw+RYgjFfFI48s8xtQevJYEyTNkOAQlrfJeCiJiqQiM3IWX9CcH81Rshy4WlD75
 U8zek5tGjtM9ne9xwdvuU18iv12c/PSTnnrnQVpDqV/Mfbwy9uW0bfS4+sntC0lc5IGR
 qOJK1qhyDAEI7PT1jgobwpgSM+Lmc3EXTcPSYfFmhal9jSaZ8HQd4CXAsHqBLP6nqkjP
 NGbE3xBmpVoT1q9e4RKgpS5ozy/xFCQuMkPpmjc0nIJ/xZlbN8xaiwathPmJalbjM/1m
 3ap8oMduWUJE2sigIjIMg2w8niRtKldCTVS9VW2CPyskopvsjulD2IL9lJJOuZ5B1wis
 opNA==
X-Gm-Message-State: ABy/qLbiOKJZOEMmS67Owh8FPz4FXCbiyTZz5O1/Cxe8iw4tB0PlFsPS
 /ET433+y3v69kY7ELZ0xAleqnanK2O6PC/x7wy8=
X-Google-Smtp-Source: APBJJlGcPG2lul3g3oneKpXYvC0eqgcQmv41SowrbgDh8GNQ+35DFo8+LArrY5hSfPL+kuPTLGVX+g==
X-Received: by 2002:a17:902:988e:b0:1b9:cc6b:408c with SMTP id
 s14-20020a170902988e00b001b9cc6b408cmr9995735plp.38.1690837339148; 
 Mon, 31 Jul 2023 14:02:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: [PULL 07/10] bsd-user: Specify host page alignment if none specified
Date: Mon, 31 Jul 2023 14:02:08 -0700
Message-Id: <20230731210211.137353-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Warner Losh <imp@bsdimp.com>

We're hitting an assert when we pass in alignment == 0 since that's not
a power of two. so pass in the ideal page size.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230728162927.5009-1-imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 74ed00b9fe..b62a69bd07 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -260,7 +260,8 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size,
-            (alignment != 0 ? 1 << alignment : 0));
+            (alignment != 0 ? 1 << alignment :
+             MAX(qemu_host_page_size, TARGET_PAGE_SIZE)));
     }
 
     addr = start;
-- 
2.34.1


