Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAC758CC7
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz59-0001t6-67; Wed, 19 Jul 2023 00:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4i-0001pA-Kj
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4g-0005NS-Lf
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:46:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so40112265ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741965; x=1692333965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5XiVFjyXxETrPBjAjB3APtPMrDa1dtW81Eiy+GFBRc=;
 b=VYxBccMb4Z4fy+QmPTUmB/B9c42tQejLtm+ZS5bzJ9c8SK2USP1Lz8ZAeUsiSrraxy
 p3d2CJm9GuFX61OmlXNz+0l4QsBsbj0v58zjGRyQIFkRGYsJsrJbhBSapZOa0xGDr76H
 JJaEf1HVzU7pEgkCnGm0jcB3WpTGX92BkfybDd4zZVYg0/HrZY8Yig/rqRd0RLc/F2J9
 yzy2WvgBlTuUEUaOu6OqkLaYNtIgKRoiuhEl8dZOt05m9kQ2Ev43afykJfThxRlXoDR1
 lqLIWsco6nh3NEQWOVwrA8weN1V/BL1544CIzvS1BS4gmgVVErIMpHLct3iiwZlPbvD6
 eeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741965; x=1692333965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5XiVFjyXxETrPBjAjB3APtPMrDa1dtW81Eiy+GFBRc=;
 b=JitnadF+wx810dcwaTBwvgmV+0/Eg7esP6IeYMwPDywGoaim1ld6Thgh1qbYP0seP4
 W4jrtSVI9ab0e2ogJRSbDfNphjCTvaFnHcU/wXUpoMePQedi5jhbHnDOQKPbjPTN8dny
 pFzT3EtErj4+ldt2llFbXLgWo0k4Bnhi8HYiPvfm+vSkaBUL6vHqMe7yYgE705OscUe/
 2Z+390w8KaLWBdsHrwjwYZ/uChGAfNsq5inmn1oIrh1Lb5ohkcOTdmCJ7aliiowetpts
 h1JJpliY1N9scI8bv6cASapeJqDkHLrxvyZrJ5gxz6rLVRVTQjYu6z8oGPaXRgxJ3pvN
 K0tQ==
X-Gm-Message-State: ABy/qLbDoZQWJ6PhsVMLYSCzQzFICFwttN1cVavdwsWyAStew1K34w1y
 QeL+yIUirTbSqudXQ/Wx2cg/Hu5YTJM4JK+d
X-Google-Smtp-Source: APBJJlF/trm9Zv4eq1vW6wvRKxoIYcoCV4o6t8+0cJyz6DAGFxvXWxYikOoByM6NgNBZCOXMwFj70A==
X-Received: by 2002:a17:903:2309:b0:1b8:9ba6:b221 with SMTP id
 d9-20020a170903230900b001b89ba6b221mr1775628plh.21.1689741965116; 
 Tue, 18 Jul 2023 21:46:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:46:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rob Bradford <rbradford@rivosinc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 5/5] target/riscv: Fix LMUL check to use VLEN
Date: Wed, 19 Jul 2023 14:45:38 +1000
Message-Id: <20230719044538.2013401-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rob Bradford <rbradford@rivosinc.com>

The previous check was failing with:

VLEN=128 ELEN = 64 SEW = 16 and LMUL = 1/8 which is a
valid combination.

Fix the check to allow valid combinations when VLEN is a multiple of
ELEN.

From the specification:

"In general, the requirement is to support LMUL ≥ SEWMIN/ELEN, where
SEWMIN is the narrowest supported SEW value and ELEN is the widest
supported SEW value. In the standard extensions, SEWMIN=8. For standard
vector extensions with ELEN=32, fractional LMULs of 1/2 and 1/4 must be
supported. For standard vector extensions with ELEN=64, fractional LMULs
of 1/2, 1/4, and 1/8 must be supported." Elsewhere in the specification
it makes clear that VLEN>=ELEN.

From inspection this new check allows:

VLEN=ELEN=64 1/2, 1/4, 1/8 for SEW >=8
VLEN=ELEN=32 1/2, 1/4 for SEW >=8

Fixes: d9b7609a1fb2 ("target/riscv: rvv-1.0: configure instructions")
Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230718131316.12283-2-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cfacf2ebba..4d06754826 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -43,9 +43,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
 
     if (lmul & 4) {
-        /* Fractional LMUL. */
+        /* Fractional LMUL - check LMUL * VLEN >= SEW */
         if (lmul == 4 ||
-            cpu->cfg.elen >> (8 - lmul) < sew) {
+            cpu->cfg.vlen >> (8 - lmul) < sew) {
             vill = true;
         }
     }
-- 
2.40.1


