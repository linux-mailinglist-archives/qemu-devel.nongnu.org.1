Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA11798209
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdX-0001Wj-3U; Fri, 08 Sep 2023 02:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdN-00016r-6Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdK-0005x9-Cw
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso14703055ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153181; x=1694757981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fh5NRbb/cu0m756EGY6sy0BB/1IMqMKi0hjfM6Xip7Q=;
 b=EO2HvySado53YzoBqcpGDa8RxiM2roLlYTFObThnsch0nt5gd+VvBlqxZJGT6KQBGm
 rBMs2n7TeOjWxEyWSRGsJCqqmdVRTKupjIo4bdH8ZlBFUE1yAmIjxBleFknqjOjBRA6I
 E6rSazlL3bwB5rAwUjmGWX+MhLdSBv2DFGT6/idZ1r1pB+BI26jSfRXBia/ZivGwy7ck
 H4OTGzuMX9H0F8c18qs65aQLltqYnTQNzNIsWPCwFFtl8GL5LEXCEuoXndxr1PL+wQFA
 4N3wIwnMyvRsf+Ur+Ssvk2yuYHeiu9bj0O2Ul0jvQ5ylNIBK+8rpv9ZShMyEBDlDylLS
 mUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153181; x=1694757981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fh5NRbb/cu0m756EGY6sy0BB/1IMqMKi0hjfM6Xip7Q=;
 b=BkflbsrU00yrcY6rWHsSco+DzLL9CkiowFPWG5vW3Wq+b2Km+2qZJWfMUeVJSnvxvk
 71K663e27xG1X7XtsbzlaQQXkirKUzRLAavd7Vo//T1JZ3YQ9FLko2mu8Qi9ZsjqSCr+
 ywun/+g8SFAE1wGpTKmLy1ZWpfP33xLEcNtwyorxX6A1BF3oezuxm4LzUtoDHUfPSTrf
 9/dAilXkHemV/HN+KA4V/aUG/M2lrYS240YpjDv/1uxrgFPJ0BPppViTbpHVEgFLnTwl
 JmD//jnnhaDn3C8eVgWxDH9xZGgbljGCeBrVYf/WzSWlkOGxMOmzcTovHQ5PfzFJyg90
 DhTg==
X-Gm-Message-State: AOJu0YzVqceocgZ561wxcizW2UjfYMK6nEQZHxSk6zAWR96Z5iX/Y8AV
 gZi3Tqd23OEp7sOxfI1Jqd8Hh0qgh66a09yJ
X-Google-Smtp-Source: AGHT+IFvKRQkpxKxpTtN0iIcJNkZfu6Ydv3+wzaqJX1+ryyjBy1mTYwNLg6jJ7/hdL+4th/Rm7BEIg==
X-Received: by 2002:a17:903:124f:b0:1bc:6861:d746 with SMTP id
 u15-20020a170903124f00b001bc6861d746mr1959860plh.58.1694153180654; 
 Thu, 07 Sep 2023 23:06:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:19 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/65] target/riscv: Add Zvksed ISA extension support
Date: Fri,  8 Sep 2023 16:03:48 +1000
Message-ID: <20230908060431.1903919-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

This commit adds support for the Zvksed vector-crypto extension, which
consists of the following instructions:

* vsm4k.vi
* vsm4r.[vv,vs]

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
[lawrence.hunter@codethink.co.uk: Moved SM4 functions from
crypto_helper.c to vcrypto_helper.c]
[nazar.kazakov@codethink.co.uk: Added alignment checks, refactored code to
use macros, and minor style changes]
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20230711165917.2629866-16-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                   |   1 +
 target/riscv/helper.h                    |   4 +
 target/riscv/insn32.decode               |   5 +
 target/riscv/cpu.c                       |   5 +-
 target/riscv/vcrypto_helper.c            | 127 +++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvvk.c.inc |  43 ++++++++
 6 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index b754ec2344..61f6238756 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -91,6 +91,7 @@ struct RISCVCPUConfig {
     bool ext_zvkned;
     bool ext_zvknha;
     bool ext_zvknhb;
+    bool ext_zvksed;
     bool ext_zvksh;
     bool ext_zmmul;
     bool ext_zvfbfmin;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ceec97e165..8a63523851 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1276,3 +1276,7 @@ DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
 
 DEF_HELPER_5(vghsh_vv, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
+DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
+DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0fae01c6bb..33597fe2bb 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -999,3 +999,8 @@ vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
 # *** Zvkg vector crypto extension ***
 vghsh_vv    101100 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
+
+# *** Zvksed vector crypto extension ***
+vsm4k_vi    100001 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vsm4r_vv    101000 1 ..... 10000 010 ..... 1110111 @r2_vm_1
+vsm4r_vs    101001 1 ..... 10000 010 ..... 1110111 @r2_vm_1
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 981907c033..dc4b88e625 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,6 +133,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
+    ISA_EXT_DATA_ENTRY(zvksed, PRIV_VERSION_1_12_0, ext_zvksed),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
@@ -1283,7 +1284,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * in qemu
      */
     if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
-         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
+         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksed || cpu->cfg.ext_zvksh) &&
+        !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
@@ -1885,6 +1887,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
     DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
     DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
+    DEFINE_PROP_BOOL("x-zvksed", RISCVCPU, cfg.ext_zvksed, false),
     DEFINE_PROP_BOOL("x-zvksh", RISCVCPU, cfg.ext_zvksh, false),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index a5e2f7fbb0..e2d719b13b 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/sm4.h"
 #include "exec/memop.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -841,3 +842,129 @@ void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
     vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
     env->vstart = 0;
 }
+
+void HELPER(vsm4k_vi)(void *vd, void *vs2, uint32_t uimm5, CPURISCVState *env,
+                      uint32_t desc)
+{
+    const uint32_t egs = 4;
+    uint32_t rnd = uimm5 & 0x7;
+    uint32_t group_start = env->vstart / egs;
+    uint32_t group_end = env->vl / egs;
+    uint32_t esz = sizeof(uint32_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+
+    for (uint32_t i = group_start; i < group_end; ++i) {
+        uint32_t vstart = i * egs;
+        uint32_t vend = (i + 1) * egs;
+        uint32_t rk[4] = {0};
+        uint32_t tmp[8] = {0};
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            rk[j - vstart] = *((uint32_t *)vs2 + H4(j));
+        }
+
+        for (uint32_t j = 0; j < egs; ++j) {
+            tmp[j] = rk[j];
+        }
+
+        for (uint32_t j = 0; j < egs; ++j) {
+            uint32_t b, s;
+            b = tmp[j + 1] ^ tmp[j + 2] ^ tmp[j + 3] ^ sm4_ck[rnd * 4 + j];
+
+            s = sm4_subword(b);
+
+            tmp[j + 4] = tmp[j] ^ (s ^ rol32(s, 13) ^ rol32(s, 23));
+        }
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            *((uint32_t *)vd + H4(j)) = tmp[egs + (j - vstart)];
+        }
+    }
+
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+}
+
+static void do_sm4_round(uint32_t *rk, uint32_t *buf)
+{
+    const uint32_t egs = 4;
+    uint32_t s, b;
+
+    for (uint32_t j = egs; j < egs * 2; ++j) {
+        b = buf[j - 3] ^ buf[j - 2] ^ buf[j - 1] ^ rk[j - 4];
+
+        s = sm4_subword(b);
+
+        buf[j] = buf[j - 4] ^ (s ^ rol32(s, 2) ^ rol32(s, 10) ^ rol32(s, 18) ^
+                               rol32(s, 24));
+    }
+}
+
+void HELPER(vsm4r_vv)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    const uint32_t egs = 4;
+    uint32_t group_start = env->vstart / egs;
+    uint32_t group_end = env->vl / egs;
+    uint32_t esz = sizeof(uint32_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+
+    for (uint32_t i = group_start; i < group_end; ++i) {
+        uint32_t vstart = i * egs;
+        uint32_t vend = (i + 1) * egs;
+        uint32_t rk[4] = {0};
+        uint32_t tmp[8] = {0};
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            rk[j - vstart] = *((uint32_t *)vs2 + H4(j));
+        }
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            tmp[j - vstart] = *((uint32_t *)vd + H4(j));
+        }
+
+        do_sm4_round(rk, tmp);
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            *((uint32_t *)vd + H4(j)) = tmp[egs + (j - vstart)];
+        }
+    }
+
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+}
+
+void HELPER(vsm4r_vs)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
+{
+    const uint32_t egs = 4;
+    uint32_t group_start = env->vstart / egs;
+    uint32_t group_end = env->vl / egs;
+    uint32_t esz = sizeof(uint32_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+
+    for (uint32_t i = group_start; i < group_end; ++i) {
+        uint32_t vstart = i * egs;
+        uint32_t vend = (i + 1) * egs;
+        uint32_t rk[4] = {0};
+        uint32_t tmp[8] = {0};
+
+        for (uint32_t j = 0; j < egs; ++j) {
+            rk[j] = *((uint32_t *)vs2 + H4(j));
+        }
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            tmp[j - vstart] = *((uint32_t *)vd + H4(j));
+        }
+
+        do_sm4_round(rk, tmp);
+
+        for (uint32_t j = vstart; j < vend; ++j) {
+            *((uint32_t *)vd + H4(j)) = tmp[egs + (j - vstart)];
+        }
+    }
+
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vext_vta(desc), env->vl * esz, total_elems * esz);
+}
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index af7cd62e7d..c00c70dfc6 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -561,3 +561,46 @@ static bool vghsh_check(DisasContext *s, arg_rmrr *a)
 }
 
 GEN_VV_UNMASKED_TRANS(vghsh_vv, vghsh_check, ZVKG_EGS)
+
+/*
+ * Zvksed
+ */
+
+#define ZVKSED_EGS 4
+
+static bool zvksed_check(DisasContext *s)
+{
+    int egw_bytes = ZVKSED_EGS << s->sew;
+    return s->cfg_ptr->ext_zvksed == true &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           MAXSZ(s) >= egw_bytes &&
+           s->sew == MO_32;
+}
+
+static bool vsm4k_vi_check(DisasContext *s, arg_rmrr *a)
+{
+    return zvksed_check(s) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul);
+}
+
+GEN_VI_UNMASKED_TRANS(vsm4k_vi, vsm4k_vi_check, ZVKSED_EGS)
+
+static bool vsm4r_vv_check(DisasContext *s, arg_rmr *a)
+{
+    return zvksed_check(s) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul);
+}
+
+GEN_V_UNMASKED_TRANS(vsm4r_vv, vsm4r_vv_check, ZVKSED_EGS)
+
+static bool vsm4r_vs_check(DisasContext *s, arg_rmr *a)
+{
+    return zvksed_check(s) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul, 0), a->rs2, 1) &&
+           require_align(a->rd, s->lmul);
+}
+
+GEN_V_UNMASKED_TRANS(vsm4r_vs, vsm4r_vs_check, ZVKSED_EGS)
-- 
2.41.0


