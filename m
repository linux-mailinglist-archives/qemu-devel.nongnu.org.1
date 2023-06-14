Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6B72F1BF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:25:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFz-0006Ga-0W; Tue, 13 Jun 2023 21:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFQ-0005jI-CA
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:32 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FFM-00051i-9F
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:29 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39aa8256db7so2859509b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705866; x=1689297866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zg0oY0/z+XRd1Ia6EFmpNFinq5qxvZY9johtFaxpY8=;
 b=Ug/5L9B2GiD5ht39ca+lA/+jlsLkES7RM73hAUU8v5jEbz6DNwMIgTIS/E9pCERIDH
 WEngHVgYF2Xm0Y9uiHGQqvz62jPA2UyhJBtjg4kE4ZK+tbu3qVbnz7x6b2JqRSwJ0Nrj
 HYAXBeJLqfSXqdB2rSHVS+rcfmAGw5RsbfDzWz9/BO3UR5qVlgoTDk+2PDB8eeeZ6cQu
 oBFl/tU6thqKZ/YPhRfCoC/PhJqvVbCPHmcj2lRerdNieQ0aZt9bzo/u7iL5wZh471oj
 Ew9S3gZky30XsK202+3iskHlT04LQuussbF4BkEFJTSZtjlHsP6JySpea1++uhFXxOAb
 dIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705866; x=1689297866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zg0oY0/z+XRd1Ia6EFmpNFinq5qxvZY9johtFaxpY8=;
 b=cU1v6gStdUatjiFmLHCPPnW+Ccz8tG8rmsDOk4xSCugKKOkby1UiVtuKBvHD353nrW
 gGw/7O5v13hYNt6xUcZM87EgroLi+vrRbHQ2V1pHsQiRA/c3as2du1fAgVTjywb6roxk
 B+Rtu7mfrpxQeTUAJRXJrA6C4T5s+0bkmt3Z2NHHjdhtrtT9vcsVWK+bVAY9kUkyP3KC
 LE+maYoviUpTSPzuONrYYVwMPhF00eJE/kCEvsNJ0u6ub59JqNSWN2M/f4SydyA+xOX8
 gLpaTwpnY9WUfQWxqBZaCifcs1DSJCml45pyMZgDx+8hNZv9yMKi8QSp0joSysh1Fj3u
 qdjA==
X-Gm-Message-State: AC+VfDxUhsa7y+uEll5xuOqA1ZrOMsq5RryZkDq0CfMEfITaKOMD5ycD
 rqsZA736O8N0JcfxAlMl1cDLVOlYl7UINw==
X-Google-Smtp-Source: ACHHUZ6YnFGk9jdgKz15tAln1BC1KdqGLi+Vr7zy0r2qx37UrMLXMbFmH7HF15jtTMvfFFv3BQl+7g==
X-Received: by 2002:a05:6808:2010:b0:396:9fe5:1a65 with SMTP id
 q16-20020a056808201000b003969fe51a65mr10233056oiw.16.1686705865722; 
 Tue, 13 Jun 2023 18:24:25 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Xiao Wang <xiao.w.wang@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 58/60] target/riscv/vector_helper.c: Remove the check for extra
 tail elements
Date: Wed, 14 Jun 2023 11:20:15 +1000
Message-Id: <20230614012017.3100663-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22c.google.com
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

From: Xiao Wang <xiao.w.wang@intel.com>

Commit 752614cab8e6 ("target/riscv: rvv: Add tail agnostic for vector
load / store instructions") added an extra check for LMUL fragmentation,
intended for setting the "rest tail elements" in the last register for a
segment load insn.

Actually, the max_elements derived in vext_ld*() won't be a fraction of
vector register size, since the lmul encoded in desc is emul, which has
already been adjusted to 1 for LMUL fragmentation case by vext_get_emul()
in trans_rvv.c.inc, for ld_stride(), ld_us(), ld_index() and ldff().

Besides, vext_get_emul() has also taken EEW/SEW into consideration, so no
need to call vext_get_total_elems() which would base on the emul to derive
another emul, the second emul would be incorrect when esz differs from sew.

Thus this patch removes the check for extra tail elements.

Fixes: 752614cab8e6 ("target/riscv: rvv: Add tail agnostic for vector load / store instructions")

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230607091646.4049428-1-xiao.w.wang@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index e8af64e626..1e06e7447c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -264,11 +264,10 @@ GEN_VEXT_ST_ELEM(ste_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(ste_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, int64_t, H8, stq)
 
-static void vext_set_tail_elems_1s(CPURISCVState *env, target_ulong vl,
-                                   void *vd, uint32_t desc, uint32_t nf,
+static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
+                                   uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
-    uint32_t total_elems, vlenb, registers_used;
     uint32_t vta = vext_vta(desc);
     int k;
 
@@ -276,19 +275,10 @@ static void vext_set_tail_elems_1s(CPURISCVState *env, target_ulong vl,
         return;
     }
 
-    total_elems = vext_get_total_elems(env, desc, esz);
-    vlenb = riscv_cpu_cfg(env)->vlen >> 3;
-
     for (k = 0; k < nf; ++k) {
         vext_set_elems_1s(vd, vta, (k * max_elems + vl) * esz,
                           (k * max_elems + max_elems) * esz);
     }
-
-    if (nf * max_elems % total_elems != 0) {
-        registers_used = ((nf * max_elems) * esz + (vlenb - 1)) / vlenb;
-        vext_set_elems_1s(vd, vta, (nf * max_elems) * esz,
-                          registers_used * vlenb);
-    }
 }
 
 /*
@@ -324,7 +314,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     }
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env, env->vl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)                        \
@@ -383,7 +373,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     }
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env, evl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
 }
 
 /*
@@ -504,7 +494,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env, env->vl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN, LOAD_FN)                  \
@@ -634,7 +624,7 @@ ProbeSuccess:
     }
     env->vstart = 0;
 
-    vext_set_tail_elems_1s(env, env->vl, vd, desc, nf, esz, max_elems);
+    vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
 
 #define GEN_VEXT_LDFF(NAME, ETYPE, LOAD_FN)               \
-- 
2.40.1


