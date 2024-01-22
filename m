Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BD8369DA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:13:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwtm-0006Yx-GJ; Mon, 22 Jan 2024 11:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtk-0006YB-JV
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:44 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rRwtj-0005Lb-2m
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:11:44 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2907748497dso1256281a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705939901; x=1706544701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76Mph1VWeHU8OoA0oT8y2Nr6g3kTredg0P9ZzqK98FE=;
 b=OGD0eRSmVKp1FS8JRHEJzBVWB+HYh1ScHnUNtVRrvUnsS9AJGd5mSUAFMDkQAlYWc4
 bz95TXp4p0/L9UBQaj/9x8PiZQGAO/VZcZjkZomsH1mzidLnGTkBn7BkoSfYnJu0hEnw
 Mj6Uu0GoDPYPWGR7ZOqRBd6wsFMmR85g7AnL1NV340LbUXdwBuoO0+UN6Q4ugy/DaUBM
 mK8H1A5JbNjD9XwWJI75RCfEBL62mdz48zFXxIXRuAButJxWnoOYoSy33tJR//UpD3G7
 bK+b/mIP+9qJJVaEED4lvOVHJCbtRA7tUSkYT7wYO9wyAroXo9j0cQa3zdEUJRVYxOfW
 BeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939901; x=1706544701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76Mph1VWeHU8OoA0oT8y2Nr6g3kTredg0P9ZzqK98FE=;
 b=c369CDVrjBttIDTsIickM8x5Os/hQp+tCdStHOsKOQ0fIqY/4Y6oFpgkA98XPE79V0
 J5dIXW/3fq/YUcHhSae17vI2QzrA2wuN8/qeU5rHZNLLPABp2jYeJ5i1dlVIKJ6oqgJV
 VOJ/YY8Szxp3zN+Z+Aw2sWZKRgubuGzvpC6aaLs4fANsvbrVyPvHXOB4BUenFpj6h54W
 UkerfstTfHQBleePkX8yMAxSNcMZxQ7jaKiNCdq93BoXWYYc9H6Ra9NcMk9QOs0ugglM
 A0SSziGA/U8gXvKn1V8PSh7RczXruWY+iOlWSBbjKZrU0OnDUZ8xcjbZIsyjUginKWaZ
 nUUg==
X-Gm-Message-State: AOJu0YweflOOPF8Vbi9n9Fqw0oHM4oSzDS/e2KF8ReWBynof8W/4iCYZ
 kjCbe2t2oHXhcusfZPJ20ex+UAku9PP3aL8frvcFc9PBWmJcWEsjv4JlMWuKBxzvlZoqDGBZDuN
 J
X-Google-Smtp-Source: AGHT+IHnrwTjQgQqSRt5BPo2CQ5bqoJUyDLqVv4/HGnM/qvzZUqWN04j/RvOC0OxNkjOpb0bo/csug==
X-Received: by 2002:a17:90a:898c:b0:290:1481:f13b with SMTP id
 v12-20020a17090a898c00b002901481f13bmr2115348pjn.29.1705939900920; 
 Mon, 22 Jan 2024 08:11:40 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 db3-20020a17090ad64300b0028e245501e7sm9866446pjb.4.2024.01.22.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:11:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 08/13] target/riscv/vector_helper.c: use vlenb in
 HELPER(vsetvl)
Date: Mon, 22 Jan 2024 13:11:02 -0300
Message-ID: <20240122161107.26737-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122161107.26737-1-dbarboza@ventanamicro.com>
References: <20240122161107.26737-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use the new 'vlenb' CPU config to validate fractional LMUL. The original
comparison is done with 'vlen' and 'sew', both in bits. Adjust the shift
to use vlenb.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cb944229b0..b13be1541a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -45,9 +45,16 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
 
     if (lmul & 4) {
-        /* Fractional LMUL - check LMUL * VLEN >= SEW */
+        /*
+         * Fractional LMUL, check:
+         *
+         * VLEN * LMUL >= SEW
+         * VLEN >> (8 - lmul) >= sew
+         * (vlenb << 3) >> (8 - lmul) >= sew
+         * vlenb >> (8 - 3 - lmul) >= sew
+         */
         if (lmul == 4 ||
-            cpu->cfg.vlen >> (8 - lmul) < sew) {
+            cpu->cfg.vlenb >> (8 - 3 - lmul) < sew) {
             vill = true;
         }
     }
-- 
2.43.0


