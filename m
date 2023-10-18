Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E247CEA7F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESA-0000rL-UJ; Wed, 18 Oct 2023 17:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES5-0000it-Tb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:42 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtES3-0004Mi-Lq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:41 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b5f0d658dso4275582eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665897; x=1698270697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=C0pxWsAMx0xMZpriRBPtpt6F2xoLOTokrT6GVDvIDnBJcoURHZ7yAUnTBBX79trORM
 Bk1g/ipdxpGsHABeH7Dof5Mmh9kBKngf+kTNrm9rQoMVL8yHOuUpyNpGsxdO2qaNHrdv
 96l1bE8MFoRfoh888c+I5xp36hQ/heASfihyWapdsaW/z6oBkqoaMfdcFLGjHgbqOrlA
 D3PHGszWTYnBtaBO/axCBpD5xjhr8lAZJKQO3kNXoFo9PtNwlq5Zqgelj6Y9uyIMGbzM
 r8WAVC3+aYtQj3SnoXr4FqOc5w0BkSQLg/wdoo289cnZJ/uTXQ6C2Sj5zWG49xqOo/0B
 A4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665897; x=1698270697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkIbB3zmI08zQqo8JvI15EoPXprMPyQ2OgXzm/sTzaE=;
 b=FPsJE6SDDObhVToiaCRA6erm4A0zl13Rf+yhtACRt4lvMW+FVcg8+MezFHDxxGPhiU
 ggdGc1zsay1eD2o0PA6cBkZf5dZ4oxbqq0SqVJ16kypqzwMtICyKZVVc2e2tzzazZhSn
 lIr8e18LBMjOx1Ycsgf23jVc/vJP7noPzEBLOx2kRbpGU16h8PavrjhfvOh09O8EZTuK
 x49Hdd0I5UeIPYqVFYgm8xnfR9sUi8kx4hFX22u+97I8U+FWNPAyIEoF4UaxjEeW9t+Z
 JBrB9EQw5WQF9kBZvqJ3W6CCoeKHTaA6Oz6C0gLO2kuxaJxBFUkKK4OVi4TsiSJ9fLYk
 6Bhg==
X-Gm-Message-State: AOJu0YwVLQFn1BPvPjKsxTfOMKkbAOIsGvuHHgf3knfnEWUcyLMuY5JI
 8kF9fuCJQcBMOMZScRvR+zxZMEc5fIb+itSOiio=
X-Google-Smtp-Source: AGHT+IEM4bpcAkiUdoZgnOSLxLBYZkIDTw8zSjc3U1qbDkNHfHuf5QP4yazFqw2hCByosjlk4beojQ==
X-Received: by 2002:a05:6359:d14:b0:14a:ddb8:9a12 with SMTP id
 gp20-20020a0563590d1400b0014addb89a12mr276183rwb.6.1697665897576; 
 Wed, 18 Oct 2023 14:51:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 01/61] include/hw/elf: Remove truncating signed casts
Date: Wed, 18 Oct 2023 14:50:35 -0700
Message-Id: <20231018215135.1561375-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


