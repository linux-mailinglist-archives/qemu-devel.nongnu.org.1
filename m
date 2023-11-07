Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16F7E3410
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CS1-000638-4f; Mon, 06 Nov 2023 22:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRk-0005D4-5E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:08 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRf-0001R8-4T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:07 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28094a3b760so4878564a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326481; x=1699931281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=DksP0mcfQsUYXsgGeeutxIzWqaX/hKyu3gd2KEE5JNzUYHXiO61DUtXp9YU2pbcnye
 bXvPgMHQS9P2JmlKMHxi5DlFntZ4rprCeLUJi/CLl/5WqIsftLEvYayDX8Wwbjv3tgrP
 onhnLlNLTILn//ou3WV8ES9T+tAEFObkX98vkNij9TdtQE2zUMxp3LtVxX1CTFZb0dln
 lU3IZnjyJfKPqE1VW2wDG5uFFDuhA8+/tD7SPklLswOs/X0rPnIHsov84oV2uAUuwfmG
 CMb5kDGg87hC0e1hlUZSNhbacC4Z178zx0JtQlRWdf8xnE/WXUDWhkAeMXr6QouQxbvi
 QvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326481; x=1699931281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=UE8U7axmaY+uuKgxDsefdcUjVMVzBkXQMxgvJoBseg5RSYKUSfffb5BMdM0REsDddO
 Wy1WJzWJL81sAk8nkfkOXxLfFCHavdu4aKefz4Vxh0xAS3LbPZ5ThQ6KQ/86h4ueAcwu
 rgC4bP/mQBXTJbmp3Q+cGhoHPnCKApTDdwHopIWZ0Ra1E1XVJYyrjacdtFQTkIrXoSSm
 Q1r08ASatxnSMBNO57frVye6Pr5KXTC0sl8gHXl9GpQHJp3m726nlb4wYk+nLesXhYs+
 gH5Ta0S8SZ2WEc/0itrQwXCG+llIuTjHmhvz2Y2qSpSfr6KbkXkBGUoH1aKL5kZ1fls9
 BVEw==
X-Gm-Message-State: AOJu0YxPtUyhhNiu3Fb7bm6F76awqXxkKyZUG47Nk4vebLEVkIJiylMD
 3HlZAB1McMp5yBS1HIKbj/9cW5h155Ulyi/HC50=
X-Google-Smtp-Source: AGHT+IHAbpW/zZIzVe6y4TEUoxW0S1Nc3P21t7+KD+DOW6xqsFcHbGbFK2fyZyyTRovUbrXsbWtOQA==
X-Received: by 2002:a17:90b:814:b0:27d:7666:9596 with SMTP id
 bk20-20020a17090b081400b0027d76669596mr24024321pjb.11.1699326481506; 
 Mon, 06 Nov 2023 19:08:01 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/85] include/hw/elf: Remove truncating signed casts
Date: Mon,  6 Nov 2023 19:03:53 -0800
Message-Id: <20231107030407.8979-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

There's nothing about elf that specifically requires signed vs unsigned.
This is very much a target-specific preference.

In the meantime, casting low and high from uint64_t back to Elf_SWord
to uint64_t discards high bits that might have been set by translate_fn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/elf_ops.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index dffb0e73d2..0a5c258fe6 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -385,10 +385,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
     }
 
     if (pflags) {
-        *pflags = (elf_word)ehdr.e_flags;
+        *pflags = ehdr.e_flags;
+    }
+    if (pentry) {
+        *pentry = ehdr.e_entry;
     }
-    if (pentry)
-        *pentry = (uint64_t)(elf_sword)ehdr.e_entry;
 
     glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
 
@@ -610,10 +611,12 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
-    if (lowaddr)
-        *lowaddr = (uint64_t)(elf_sword)low;
-    if (highaddr)
-        *highaddr = (uint64_t)(elf_sword)high;
+    if (lowaddr) {
+        *lowaddr = low;
+    }
+    if (highaddr) {
+        *highaddr = high;
+    }
     ret = total_size;
  fail:
     if (mapped_file) {
-- 
2.34.1


