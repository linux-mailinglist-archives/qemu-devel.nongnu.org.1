Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B607981FF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdW-0001OA-8D; Fri, 08 Sep 2023 02:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdE-00013N-KB
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdA-0005pJ-Di
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c336f3f449so14693465ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153170; x=1694757970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG534oqdKvZg93XhHJTveosyzNAkM7GvLcEv8iTROyU=;
 b=sAzMDNjCifc1m3K+4iqZZflMerUo8s5p1SyvoPLjiVL+Pzg7dQc5VlbvXGCkB8HQt2
 pIYdklv8JTmEINE/1qrsTbApvxnIgwUeZRK+hhAtLmAo3w7MwbqNJzLrY7W/GVQGYhrX
 WfOhn/JaV5HqxmmivQFvloxVJp4/hlp9lPL7gshxCZBrBr6ztHWRsWN38Xk6ua9qNRE5
 dxQuPBDu7UB7Wubb5wBhSkdWN+xSi0tvYUBVQGKab/o6JUPGIXh1O8ieko2jh1Xz8Sdz
 lSEkrQnOMksGd4uerA0rtq0ZX1+tzxsKDdpFmR7nXmTnFp1u9gkh+di2nUnkXJiExfDh
 0PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153170; x=1694757970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG534oqdKvZg93XhHJTveosyzNAkM7GvLcEv8iTROyU=;
 b=PSaPEpRBHE7HabryASWKkCrNcPqPgVFltP0x2sJwlc7UbTKV2sw8B5D2T/PD4kSpNe
 8spRLCdtrcYCP6P/GCvbgUmr7xOOxJFKPUHz3HCELXy6Tz5t92xaWA3qi1RMgm6K8aHQ
 LcWotgA4Vk4O+pQVttCrtoYmKinc1ukowR7U/5fcHna626osRG9QZoGbsLr2zKfHr+l7
 k+/q5IDoGNSK45snXrBfq3T0gjCzJLnaWekZXEAQtmDYpeb9cQnzyg8kYyNQoga6/eSO
 bYnldFjtUzlu99z8IhHZBRW1EN2+nDXP04NYDJgDIBZz8ZBiBo89is/i+mH7JHkWFnqs
 fRUg==
X-Gm-Message-State: AOJu0YycnUKq2qAGP+25oSyC0gTFVJNCcOimg8Nko+npZb2+cHfkA2CT
 rW3C99JwXrgVTZzHG9OdmigvNSU9xxr+QLhY
X-Google-Smtp-Source: AGHT+IFvDqjm1rHPRh3CjDN+3ppUb0T6ftkI1aYjB7JTJxY6oD/M1tNMvNhqm0pHGc0vmChleH4QWQ==
X-Received: by 2002:a17:902:a5c7:b0:1c0:6dcd:453d with SMTP id
 t7-20020a170902a5c700b001c06dcd453dmr1541767plq.20.1694153170098; 
 Thu, 07 Sep 2023 23:06:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/65] target/riscv: Add Zvkg ISA extension support
Date: Fri,  8 Sep 2023 16:03:45 +1000
Message-ID: <20230908060431.1903919-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

This commit adds support for the Zvkg vector-crypto extension, which
consists of the following instructions:

* vgmul.vv
* vghsh.vv

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Co-authored-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
[max.chou@sifive.com: Replaced vstart checking by TCG op]
Signed-off-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
[max.chou@sifive.com: Exposed x-zvkg property]
[max.chou@sifive.com: Replaced uint by int for cross win32 build]
Message-ID: <20230711165917.2629866-13-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                   |  1 +
 target/riscv/helper.h                    |  3 +
 target/riscv/insn32.decode               |  4 ++
 target/riscv/cpu.c                       |  6 +-
 target/riscv/vcrypto_helper.c            | 72 ++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvvk.c.inc | 30 ++++++++++
 6 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ab2d9294db..b754ec2344 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -87,6 +87,7 @@ struct RISCVCPUConfig {
     bool ext_zve64d;
     bool ext_zvbb;
     bool ext_zvbc;
+    bool ext_zvkg;
     bool ext_zvkned;
     bool ext_zvknha;
     bool ext_zvknhb;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6d21347c39..ceec97e165 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1273,3 +1273,6 @@ DEF_HELPER_5(vsha2cl64_vv, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_5(vsm3me_vv, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
+
+DEF_HELPER_5(vghsh_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4050e843f7..0fae01c6bb 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -995,3 +995,7 @@ vsha2cl_vv  101111 1 ..... ..... 010 ..... 1110111 @r_vm_1
 # *** Zvksh vector crypto extension ***
 vsm3me_vv   100000 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
+
+# *** Zvkg vector crypto extension ***
+vghsh_vv    101100 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vgmul_vv    101000 1 ..... 10001 010 ..... 1110111 @r2_vm_1
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce0d32eef3..981907c033 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -129,6 +129,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
@@ -1281,8 +1282,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
      */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha ||
-         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkg || cpu->cfg.ext_zvkned ||
+         cpu->cfg.ext_zvknha || cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
@@ -1880,6 +1881,7 @@ static Property riscv_cpu_extensions[] = {
     /* Vector cryptography extensions */
     DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
     DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
+    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
     DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
     DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
     DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index e8bbb698c1..a5e2f7fbb0 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -769,3 +769,75 @@ void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
     env->vstart = 0;
 }
+
+void HELPER(vghsh_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
+                      CPURISCVState *env, uint32_t desc)
+{
+    uint64_t *vd = vd_vptr;
+    uint64_t *vs1 = vs1_vptr;
+    uint64_t *vs2 = vs2_vptr;
+    uint32_t vta = vext_vta(desc);
+    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        uint64_t Y[2] = {vd[i * 2 + 0], vd[i * 2 + 1]};
+        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
+        uint64_t X[2] = {vs1[i * 2 + 0], vs1[i * 2 + 1]};
+        uint64_t Z[2] = {0, 0};
+
+        uint64_t S[2] = {brev8(Y[0] ^ X[0]), brev8(Y[1] ^ X[1])};
+
+        for (int j = 0; j < 128; j++) {
+            if ((S[j / 64] >> (j % 64)) & 1) {
+                Z[0] ^= H[0];
+                Z[1] ^= H[1];
+            }
+            bool reduce = ((H[1] >> 63) & 1);
+            H[1] = H[1] << 1 | H[0] >> 63;
+            H[0] = H[0] << 1;
+            if (reduce) {
+                H[0] ^= 0x87;
+            }
+        }
+
+        vd[i * 2 + 0] = brev8(Z[0]);
+        vd[i * 2 + 1] = brev8(Z[1]);
+    }
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
+    env->vstart = 0;
+}
+
+void HELPER(vgmul_vv)(void *vd_vptr, void *vs2_vptr, CPURISCVState *env,
+                      uint32_t desc)
+{
+    uint64_t *vd = vd_vptr;
+    uint64_t *vs2 = vs2_vptr;
+    uint32_t vta = vext_vta(desc);
+    uint32_t total_elems = vext_get_total_elems(env, desc, 4);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        uint64_t Y[2] = {brev8(vd[i * 2 + 0]), brev8(vd[i * 2 + 1])};
+        uint64_t H[2] = {brev8(vs2[i * 2 + 0]), brev8(vs2[i * 2 + 1])};
+        uint64_t Z[2] = {0, 0};
+
+        for (int j = 0; j < 128; j++) {
+            if ((Y[j / 64] >> (j % 64)) & 1) {
+                Z[0] ^= H[0];
+                Z[1] ^= H[1];
+            }
+            bool reduce = ((H[1] >> 63) & 1);
+            H[1] = H[1] << 1 | H[0] >> 63;
+            H[0] = H[0] << 1;
+            if (reduce) {
+                H[0] ^= 0x87;
+            }
+        }
+
+        vd[i * 2 + 0] = brev8(Z[0]);
+        vd[i * 2 + 1] = brev8(Z[1]);
+    }
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, env->vl * 4, total_elems * 4);
+    env->vstart = 0;
+}
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 6469dd2f02..af7cd62e7d 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -531,3 +531,33 @@ static inline bool vsm3c_check(DisasContext *s, arg_rmrr *a)
 
 GEN_VV_UNMASKED_TRANS(vsm3me_vv, vsm3me_check, ZVKSH_EGS)
 GEN_VI_UNMASKED_TRANS(vsm3c_vi, vsm3c_check, ZVKSH_EGS)
+
+/*
+ * Zvkg
+ */
+
+#define ZVKG_EGS 4
+
+static bool vgmul_check(DisasContext *s, arg_rmr *a)
+{
+    int egw_bytes = ZVKG_EGS << s->sew;
+    return s->cfg_ptr->ext_zvkg == true &&
+           vext_check_isa_ill(s) &&
+           require_rvv(s) &&
+           MAXSZ(s) >= egw_bytes &&
+           vext_check_ss(s, a->rd, a->rs2, a->vm) &&
+           s->sew == MO_32;
+}
+
+GEN_V_UNMASKED_TRANS(vgmul_vv, vgmul_check, ZVKG_EGS)
+
+static bool vghsh_check(DisasContext *s, arg_rmrr *a)
+{
+    int egw_bytes = ZVKG_EGS << s->sew;
+    return s->cfg_ptr->ext_zvkg == true &&
+           opivv_check(s, a) &&
+           MAXSZ(s) >= egw_bytes &&
+           s->sew == MO_32;
+}
+
+GEN_VV_UNMASKED_TRANS(vghsh_vv, vghsh_check, ZVKG_EGS)
-- 
2.41.0


