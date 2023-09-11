Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2179A3D8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfafE-0000nc-Kj; Mon, 11 Sep 2023 02:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafC-0000nM-AG
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:50 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaf9-0004cb-9q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:44:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a81154c570so2514722b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414685; x=1695019485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTs5EAXQCNv7xKSmVs3cJPCQuWtkfKVB1HbSg6LBKOk=;
 b=irWl4UKNVWPu/jL4Es4dgV/uhDU6yji9lrXd1zfFM61n+0huMpmtIXOpCl2LzAzq8P
 muFOwtnMBI0PfsQ6FvNsAOBBBp0rLAT/x8X4Kc6I3XWe59dgjiFHlP0dZ3kKeYk3NPX2
 eILhKUX3PzDuFl6DSm33SWxBHpU+fkd2NwNDeV313KCDNAp1TCEKWWxr0qwKHF5ElfdQ
 JDHhiXwdkkeP7GguK1qGCHhaNbcnA+j3c5X1eSTn2aiiuMSStbeOh6LKfQcN6jybwqDs
 4c0UE1G2OgZqrjHw9Iuq24bKJkNh+4W/aC5mnOSf+tBvQkNVMqrJ2yzDl8jWMxVTeSnI
 DeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414685; x=1695019485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTs5EAXQCNv7xKSmVs3cJPCQuWtkfKVB1HbSg6LBKOk=;
 b=fJ9w94m5ciu+7FUNmsRB6DcYBP7cFRLfCUhXvY74D5EONigjcddw5/5mKvydTeQpyD
 7Sw/S7Nnudfh0SdpHK2xURUjhaTiVdCwgXFnox6G+DCTfZRIE/QbOL5sON2d8JxBVbqg
 kvZFHZhU/T2oxOLGbKdF/v5+C7hI57aU2JKb5iJJuar0tTygnseWcr4PqpalVXc2hdOD
 7t+jLW2vHVqjhE52AoPEQaeLhMGVvaIiG2jk/R12cIE1rIN/eo88pmIiVOA0XEDJ8R6l
 sBA3oUhw5+asNGHCdgmg7GUqZdmbMSnI3zShonprB7uWCHxSiQYyXe8aYSbnRav4jNHB
 4JKg==
X-Gm-Message-State: AOJu0YwyrTJVvvwuAk8iLc/MH8yYOOMcQDt35KZ90ILUvJv9NhdV6cVK
 i9lqXeaZILghEtGdoMAzaBesiAAanwqtOg==
X-Google-Smtp-Source: AGHT+IF+wcGVGLLGBJCFdVpPA2JXYTBb/R9CMYH00kmJUc9R7lo47Hc1pMAQPDP0n2ZH6BejU+Znfg==
X-Received: by 2002:a54:4011:0:b0:3a7:316e:9886 with SMTP id
 x17-20020a544011000000b003a7316e9886mr7657266oie.8.1694414685462; 
 Sun, 10 Sep 2023 23:44:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:44:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/45] target/riscv: Add Zvknh ISA extension support
Date: Mon, 11 Sep 2023 16:42:52 +1000
Message-ID: <20230911064320.939791-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
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

From: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>

This commit adds support for the Zvknh vector-crypto extension, which
consists of the following instructions:

* vsha2ms.vv
* vsha2c[hl].vv

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Co-authored-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Co-authored-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
[max.chou@sifive.com: Replaced vstart checking by TCG op]
Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Signed-off-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Signed-off-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
[max.chou@sifive.com: Exposed x-zvknha & x-zvknhb properties]
[max.chou@sifive.com: Replaced SEW selection to happened during
translation]
Message-ID: <20230711165917.2629866-11-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h                   |   2 +
 target/riscv/helper.h                    |   6 +
 target/riscv/insn32.decode               |   5 +
 target/riscv/cpu.c                       |  13 +-
 target/riscv/vcrypto_helper.c            | 238 +++++++++++++++++++++++
 target/riscv/insn_trans/trans_rvvk.c.inc | 129 ++++++++++++
 6 files changed, 390 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index c7eafe27c0..800b8783c1 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -88,6 +88,8 @@ struct RISCVCPUConfig {
     bool ext_zvbb;
     bool ext_zvbc;
     bool ext_zvkned;
+    bool ext_zvknha;
+    bool ext_zvknhb;
     bool ext_zmmul;
     bool ext_zvfbfmin;
     bool ext_zvfbfwma;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 02e5dbe6ee..34329b52fe 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1264,3 +1264,9 @@ DEF_HELPER_4(vaesdm_vs, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vaesz_vs, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vaeskf1_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_5(vaeskf2_vi, void, ptr, ptr, i32, env, i32)
+
+DEF_HELPER_5(vsha2ms_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsha2ch32_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsha2ch64_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsha2cl32_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsha2cl64_vv, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4f3c50f10f..e2b83186dc 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -986,3 +986,8 @@ vaesdm_vs   101001 1 ..... 00000 010 ..... 1110111 @r2_vm_1
 vaesz_vs    101001 1 ..... 00111 010 ..... 1110111 @r2_vm_1
 vaeskf1_vi  100010 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vaeskf2_vi  101010 1 ..... ..... 010 ..... 1110111 @r_vm_1
+
+# *** Zvknh vector crypto extension ***
+vsha2ms_vv  101101 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vsha2ch_vv  101110 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vsha2cl_vv  101111 1 ..... ..... 010 ..... 1110111 @r_vm_1
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e3ae4d7e0..f103f536fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -130,6 +130,8 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
+    ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
+    ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
@@ -1278,14 +1280,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
      */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned) && !cpu->cfg.ext_zve32f) {
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha) &&
+        !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
     }
 
-    if (cpu->cfg.ext_zvbc && !cpu->cfg.ext_zve64f) {
-        error_setg(errp, "Zvbc extension requires V or Zve64{f,d} extensions");
+    if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64f) {
+        error_setg(
+            errp,
+            "Zvbc and Zvknhb extensions require V or Zve64{f,d} extensions");
         return;
     }
 
@@ -1875,6 +1880,8 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
     DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
     DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
+    DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
+    DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index cca78184e9..2f2099b6fb 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -397,3 +397,241 @@ void HELPER(vaeskf2_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
     /* set tail elements to 1s */
     vext_set_elems_1s(vd, vta, vl * 4, total_elems * 4);
 }
+
+static inline uint32_t sig0_sha256(uint32_t x)
+{
+    return ror32(x, 7) ^ ror32(x, 18) ^ (x >> 3);
+}
+
+static inline uint32_t sig1_sha256(uint32_t x)
+{
+    return ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10);
+}
+
+static inline uint64_t sig0_sha512(uint64_t x)
+{
+    return ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7);
+}
+
+static inline uint64_t sig1_sha512(uint64_t x)
+{
+    return ror64(x, 19) ^ ror64(x, 61) ^ (x >> 6);
+}
+
+static inline void vsha2ms_e32(uint32_t *vd, uint32_t *vs1, uint32_t *vs2)
+{
+    uint32_t res[4];
+    res[0] = sig1_sha256(vs1[H4(2)]) + vs2[H4(1)] + sig0_sha256(vd[H4(1)]) +
+             vd[H4(0)];
+    res[1] = sig1_sha256(vs1[H4(3)]) + vs2[H4(2)] + sig0_sha256(vd[H4(2)]) +
+             vd[H4(1)];
+    res[2] =
+        sig1_sha256(res[0]) + vs2[H4(3)] + sig0_sha256(vd[H4(3)]) + vd[H4(2)];
+    res[3] =
+        sig1_sha256(res[1]) + vs1[H4(0)] + sig0_sha256(vs2[H4(0)]) + vd[H4(3)];
+    vd[H4(3)] = res[3];
+    vd[H4(2)] = res[2];
+    vd[H4(1)] = res[1];
+    vd[H4(0)] = res[0];
+}
+
+static inline void vsha2ms_e64(uint64_t *vd, uint64_t *vs1, uint64_t *vs2)
+{
+    uint64_t res[4];
+    res[0] = sig1_sha512(vs1[2]) + vs2[1] + sig0_sha512(vd[1]) + vd[0];
+    res[1] = sig1_sha512(vs1[3]) + vs2[2] + sig0_sha512(vd[2]) + vd[1];
+    res[2] = sig1_sha512(res[0]) + vs2[3] + sig0_sha512(vd[3]) + vd[2];
+    res[3] = sig1_sha512(res[1]) + vs1[0] + sig0_sha512(vs2[0]) + vd[3];
+    vd[3] = res[3];
+    vd[2] = res[2];
+    vd[1] = res[1];
+    vd[0] = res[0];
+}
+
+void HELPER(vsha2ms_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
+                        uint32_t desc)
+{
+    uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
+    uint32_t esz = sew == MO_32 ? 4 : 8;
+    uint32_t total_elems;
+    uint32_t vta = vext_vta(desc);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        if (sew == MO_32) {
+            vsha2ms_e32(((uint32_t *)vd) + i * 4, ((uint32_t *)vs1) + i * 4,
+                        ((uint32_t *)vs2) + i * 4);
+        } else {
+            /* If not 32 then SEW should be 64 */
+            vsha2ms_e64(((uint64_t *)vd) + i * 4, ((uint64_t *)vs1) + i * 4,
+                        ((uint64_t *)vs2) + i * 4);
+        }
+    }
+    /* set tail elements to 1s */
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
+
+static inline uint64_t sum0_64(uint64_t x)
+{
+    return ror64(x, 28) ^ ror64(x, 34) ^ ror64(x, 39);
+}
+
+static inline uint32_t sum0_32(uint32_t x)
+{
+    return ror32(x, 2) ^ ror32(x, 13) ^ ror32(x, 22);
+}
+
+static inline uint64_t sum1_64(uint64_t x)
+{
+    return ror64(x, 14) ^ ror64(x, 18) ^ ror64(x, 41);
+}
+
+static inline uint32_t sum1_32(uint32_t x)
+{
+    return ror32(x, 6) ^ ror32(x, 11) ^ ror32(x, 25);
+}
+
+#define ch(x, y, z) ((x & y) ^ ((~x) & z))
+
+#define maj(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
+
+static void vsha2c_64(uint64_t *vs2, uint64_t *vd, uint64_t *vs1)
+{
+    uint64_t a = vs2[3], b = vs2[2], e = vs2[1], f = vs2[0];
+    uint64_t c = vd[3], d = vd[2], g = vd[1], h = vd[0];
+    uint64_t W0 = vs1[0], W1 = vs1[1];
+    uint64_t T1 = h + sum1_64(e) + ch(e, f, g) + W0;
+    uint64_t T2 = sum0_64(a) + maj(a, b, c);
+
+    h = g;
+    g = f;
+    f = e;
+    e = d + T1;
+    d = c;
+    c = b;
+    b = a;
+    a = T1 + T2;
+
+    T1 = h + sum1_64(e) + ch(e, f, g) + W1;
+    T2 = sum0_64(a) + maj(a, b, c);
+    h = g;
+    g = f;
+    f = e;
+    e = d + T1;
+    d = c;
+    c = b;
+    b = a;
+    a = T1 + T2;
+
+    vd[0] = f;
+    vd[1] = e;
+    vd[2] = b;
+    vd[3] = a;
+}
+
+static void vsha2c_32(uint32_t *vs2, uint32_t *vd, uint32_t *vs1)
+{
+    uint32_t a = vs2[H4(3)], b = vs2[H4(2)], e = vs2[H4(1)], f = vs2[H4(0)];
+    uint32_t c = vd[H4(3)], d = vd[H4(2)], g = vd[H4(1)], h = vd[H4(0)];
+    uint32_t W0 = vs1[H4(0)], W1 = vs1[H4(1)];
+    uint32_t T1 = h + sum1_32(e) + ch(e, f, g) + W0;
+    uint32_t T2 = sum0_32(a) + maj(a, b, c);
+
+    h = g;
+    g = f;
+    f = e;
+    e = d + T1;
+    d = c;
+    c = b;
+    b = a;
+    a = T1 + T2;
+
+    T1 = h + sum1_32(e) + ch(e, f, g) + W1;
+    T2 = sum0_32(a) + maj(a, b, c);
+    h = g;
+    g = f;
+    f = e;
+    e = d + T1;
+    d = c;
+    c = b;
+    b = a;
+    a = T1 + T2;
+
+    vd[H4(0)] = f;
+    vd[H4(1)] = e;
+    vd[H4(2)] = b;
+    vd[H4(3)] = a;
+}
+
+void HELPER(vsha2ch32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
+                          uint32_t desc)
+{
+    const uint32_t esz = 4;
+    uint32_t total_elems;
+    uint32_t vta = vext_vta(desc);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
+                  ((uint32_t *)vs1) + 4 * i + 2);
+    }
+
+    /* set tail elements to 1s */
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
+
+void HELPER(vsha2ch64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
+                          uint32_t desc)
+{
+    const uint32_t esz = 8;
+    uint32_t total_elems;
+    uint32_t vta = vext_vta(desc);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
+                  ((uint64_t *)vs1) + 4 * i + 2);
+    }
+
+    /* set tail elements to 1s */
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
+
+void HELPER(vsha2cl32_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
+                          uint32_t desc)
+{
+    const uint32_t esz = 4;
+    uint32_t total_elems;
+    uint32_t vta = vext_vta(desc);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
+                  (((uint32_t *)vs1) + 4 * i));
+    }
+
+    /* set tail elements to 1s */
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
+
+void HELPER(vsha2cl64_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
+                          uint32_t desc)
+{
+    uint32_t esz = 8;
+    uint32_t total_elems;
+    uint32_t vta = vext_vta(desc);
+
+    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
+        vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
+                  (((uint64_t *)vs1) + 4 * i));
+    }
+
+    /* set tail elements to 1s */
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 817353f4d3..a35be11b95 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -371,3 +371,132 @@ static bool vaeskf2_check(DisasContext *s, arg_vaeskf2_vi *a)
 
 GEN_VI_UNMASKED_TRANS(vaeskf1_vi, vaeskf1_check, ZVKNED_EGS)
 GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
+
+/*
+ * Zvknh
+ */
+
+#define ZVKNH_EGS 4
+
+#define GEN_VV_UNMASKED_TRANS(NAME, CHECK, EGS)                               \
+    static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
+    {                                                                         \
+        if (CHECK(s, a)) {                                                    \
+            uint32_t data = 0;                                                \
+            TCGLabel *over = gen_new_label();                                 \
+            TCGv_i32 egs;                                                     \
+                                                                              \
+            if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
+                /* save opcode for unwinding in case we throw an exception */ \
+                decode_save_opc(s);                                           \
+                egs = tcg_constant_i32(EGS);                                  \
+                gen_helper_egs_check(egs, cpu_env);                           \
+                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
+            }                                                                 \
+                                                                              \
+            data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
+            data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                    \
+            data = FIELD_DP32(data, VDATA, VTA, s->vta);                      \
+            data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);    \
+            data = FIELD_DP32(data, VDATA, VMA, s->vma);                      \
+                                                                              \
+            tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),       \
+                               vreg_ofs(s, a->rs2), cpu_env,                  \
+                               s->cfg_ptr->vlen / 8, s->cfg_ptr->vlen / 8,    \
+                               data, gen_helper_##NAME);                      \
+                                                                              \
+            mark_vs_dirty(s);                                                 \
+            gen_set_label(over);                                              \
+            return true;                                                      \
+        }                                                                     \
+        return false;                                                         \
+    }
+
+static bool vsha_check_sew(DisasContext *s)
+{
+    return (s->cfg_ptr->ext_zvknha == true && s->sew == MO_32) ||
+           (s->cfg_ptr->ext_zvknhb == true &&
+            (s->sew == MO_32 || s->sew == MO_64));
+}
+
+static bool vsha_check(DisasContext *s, arg_rmrr *a)
+{
+    int egw_bytes = ZVKNH_EGS << s->sew;
+    int mult = 1 << MAX(s->lmul, 0);
+    return opivv_check(s, a) &&
+           vsha_check_sew(s) &&
+           MAXSZ(s) >= egw_bytes &&
+           !is_overlapped(a->rd, mult, a->rs1, mult) &&
+           !is_overlapped(a->rd, mult, a->rs2, mult) &&
+           s->lmul >= 0;
+}
+
+GEN_VV_UNMASKED_TRANS(vsha2ms_vv, vsha_check, ZVKNH_EGS)
+
+static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
+{
+    if (vsha_check(s, a)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+        TCGv_i32 egs;
+
+        if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
+            /* save opcode for unwinding in case we throw an exception */
+            decode_save_opc(s);
+            egs = tcg_constant_i32(ZVKNH_EGS);
+            gen_helper_egs_check(egs, cpu_env);
+            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        }
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+            vreg_ofs(s, a->rs2), cpu_env, s->cfg_ptr->vlen / 8,
+            s->cfg_ptr->vlen / 8, data,
+            s->sew == MO_32 ?
+                gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
+
+        mark_vs_dirty(s);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
+
+static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
+{
+    if (vsha_check(s, a)) {
+        uint32_t data = 0;
+        TCGLabel *over = gen_new_label();
+        TCGv_i32 egs;
+
+        if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
+            /* save opcode for unwinding in case we throw an exception */
+            decode_save_opc(s);
+            egs = tcg_constant_i32(ZVKNH_EGS);
+            gen_helper_egs_check(egs, cpu_env);
+            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+        }
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
+            vreg_ofs(s, a->rs2), cpu_env, s->cfg_ptr->vlen / 8,
+            s->cfg_ptr->vlen / 8, data,
+            s->sew == MO_32 ?
+                gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
+
+        mark_vs_dirty(s);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
-- 
2.41.0


