Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0373A5EF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCN1H-0003Qw-K7; Thu, 22 Jun 2023 12:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN14-0002Pv-92
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN11-0005oB-7Z
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:18:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b54f5aac48so34316045ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687450713; x=1690042713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++iGz8W47Fl8VDZS9ZjlhnPiF8AUo0crt86BWGKHZn8=;
 b=kuecoTZ7lcRTVBT5sZ4It/KXlPX1ntdkk35NNaPJIImHuc8lwDl46K0mO5Iuv6Vzqc
 +gUaA8/6Ss1OrkXjsxfY2O5Bw1kI+mrpGtn25CGp4INK6QdcrZ/ZCKtQdCTvIHOGpCpM
 R1QVNlbyEAM0Ff+/xB6fsPO4Mi1zcsoX7hRnWhaONGat5NjaaOBpVgYAtZGon+vrpJ7G
 4ZQu2hem+jUYZGS9cyildlN5MGQo+sujUDPk16MQnKX5o6AglbbDld1kzTRNakQNSStO
 bSgAq/95Zc+B8aY3WPoVlYryRmpkHIq4XsaeTJHgfi2JhRrL9vuLN6BIG0MmbASFWhsb
 HPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450713; x=1690042713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++iGz8W47Fl8VDZS9ZjlhnPiF8AUo0crt86BWGKHZn8=;
 b=jwwyHZ/9ENN9tbaJjsbISeLx3NjJTYsTNwuhbzrComEZeXDLXae3FkJ9OPvfFByVUk
 cTjXWLKpEKzwsMeCUr2TEkwslOI2htteSWve1sYDvNCjMD8MjHLYvC9vvtBFeF05Ummk
 hPc3WBVcQiaLhykEgUn5yvGy+4uE+j7S1cxldZsGOJfPoLEdXWzFZygyCkOchIEOCMtn
 gbwbm/FVM1OWevWkmr9fJ8eASdM8SpU/EApdY9tOAghEiMlYugy7+IpUerJUs7vpPExJ
 +ChK5GB5h14QiPY62HIxSNTgEpivCkECJfUOnrnjgFRyBoOqXmX297pbVQ1TVmjZSL44
 oA9A==
X-Gm-Message-State: AC+VfDx14vjOzUbcMM+kB+dha2RqXbTmi9M0FjNCLC/GffnXoD/2ci5g
 xS/4fH58HpFsqHa6pzuB0ApTxyiTD4BFRZQkQoXeTQIMDrSn39EpTphBKE5+Pphc152r+DMX8YW
 coeaQZohmpOSap10GDOPInc8ncjdIb08yAIvnK5oNW6m7EgZAgaZjd8l4gszmp7jJ96ucz3tQ/m
 Pm
X-Google-Smtp-Source: ACHHUZ7IzHgIDvv1lDGa4adUt67EIS+2ir57y4MWcWkeUz4Tc/2M7XpbtWJiVaipzPw4fEERZLoiHA==
X-Received: by 2002:a17:902:e74e:b0:1b3:8865:aaae with SMTP id
 p14-20020a170902e74e00b001b38865aaaemr19278703plf.53.1687450712938; 
 Thu, 22 Jun 2023 09:18:32 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001b3f039f8a8sm5609683plg.61.2023.06.22.09.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:18:32 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 William Salmon <will.salmon@codethink.co.uk>
Subject: [PATCH v4 12/17] target/riscv: Add Zvksh ISA extension support
Date: Fri, 23 Jun 2023 00:16:28 +0800
Message-Id: <20230622161646.32005-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230622161646.32005-1-max.chou@sifive.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x630.google.com
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

From: Lawrence Hunter <lawrence.hunter@codethink.co.uk>

This commit adds support for the Zvksh vector-crypto extension, which
consists of the following instructions:

* vsm3me.vv
* vsm3c.vi

Translation functions are defined in
`target/riscv/insn_trans/trans_rvvk.c.inc` and helpers are defined in
`target/riscv/vcrypto_helper.c`.

Co-authored-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
[max.chou@sifive.com: Replaced vstart checking by TCG op]
Signed-off-by: Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>
Signed-off-by: Lawrence Hunter <lawrence.hunter@codethink.co.uk>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                       |   5 +-
 target/riscv/cpu_cfg.h                   |   1 +
 target/riscv/helper.h                    |   3 +
 target/riscv/insn32.decode               |   4 +
 target/riscv/insn_trans/trans_rvvk.c.inc |  31 ++++++
 target/riscv/vcrypto_helper.c            | 134 +++++++++++++++++++++++
 6 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6bba8ba8c9..c9a9ff80cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -121,6 +121,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkned, PRIV_VERSION_1_12_0, ext_zvkned),
     ISA_EXT_DATA_ENTRY(zvknha, PRIV_VERSION_1_12_0, ext_zvknha),
     ISA_EXT_DATA_ENTRY(zvknhb, PRIV_VERSION_1_12_0, ext_zvknhb),
+    ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
@@ -1197,8 +1198,8 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
      * In principle Zve*x would also suffice here, were they supported
      * in qemu
      */
-    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha) &&
-        !cpu->cfg.ext_zve32f) {
+    if ((cpu->cfg.ext_zvbb || cpu->cfg.ext_zvkned || cpu->cfg.ext_zvknha ||
+         cpu->cfg.ext_zvksh) && !cpu->cfg.ext_zve32f) {
         error_setg(errp,
                    "Vector crypto extensions require V or Zve* extensions");
         return;
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 41cce87ffc..f859d9e2f5 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -88,6 +88,7 @@ struct RISCVCPUConfig {
     bool ext_zvkned;
     bool ext_zvknha;
     bool ext_zvknhb;
+    bool ext_zvksh;
     bool ext_zmmul;
     bool ext_zvfh;
     bool ext_zvfhmin;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 19f5a8a28d..9220af18e6 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1238,3 +1238,6 @@ DEF_HELPER_5(vaeskf2_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_5(vsha2ms_vv, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vsha2ch_vv, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vsha2cl_vv, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vsm3me_vv, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsm3c_vi, void, ptr, ptr, i32, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d2cfb2729c..5ca83e8462 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -953,3 +953,7 @@ vaeskf2_vi  101010 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vsha2ms_vv  101101 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vsha2ch_vv  101110 1 ..... ..... 010 ..... 1110111 @r_vm_1
 vsha2cl_vv  101111 1 ..... ..... 010 ..... 1110111 @r_vm_1
+
+# *** Zvksh vector crypto extension ***
+vsm3me_vv   100000 1 ..... ..... 010 ..... 1110111 @r_vm_1
+vsm3c_vi    101011 1 ..... ..... 010 ..... 1110111 @r_vm_1
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index 528a0d3b32..af1fb74c38 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -479,3 +479,34 @@ static bool vsha_check(DisasContext *s, arg_rmrr *a)
 GEN_VV_UNMASKED_TRANS(vsha2ms_vv, vsha_check, ZVKNH_EGS)
 GEN_VV_UNMASKED_TRANS(vsha2cl_vv, vsha_check, ZVKNH_EGS)
 GEN_VV_UNMASKED_TRANS(vsha2ch_vv, vsha_check, ZVKNH_EGS)
+
+/*
+ * Zvksh
+ */
+
+#define ZVKSH_EGS 8
+
+static inline bool vsm3_check(DisasContext *s, arg_rmrr *a)
+{
+    int egw_bytes = ZVKSH_EGS << s->sew;
+    int mult = 1 << MAX(s->lmul, 0);
+    return s->cfg_ptr->ext_zvksh == true &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           !is_overlapped(a->rd, mult, a->rs2, mult) &&
+           MAXSZ(s) >= egw_bytes &&
+           s->sew == MO_32;
+}
+
+static inline bool vsm3me_check(DisasContext *s, arg_rmrr *a)
+{
+    return vsm3_check(s, a) && vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm);
+}
+
+static inline bool vsm3c_check(DisasContext *s, arg_rmrr *a)
+{
+    return vsm3_check(s, a) && vext_check_ss(s, a->rd, a->rs2, a->vm);
+}
+
+GEN_VV_UNMASKED_TRANS(vsm3me_vv, vsm3me_check, ZVKSH_EGS)
+GEN_VI_UNMASKED_TRANS(vsm3c_vi, vsm3c_check, ZVKSH_EGS)
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
index ca09062c6c..06c8f4adc7 100644
--- a/target/riscv/vcrypto_helper.c
+++ b/target/riscv/vcrypto_helper.c
@@ -717,3 +717,137 @@ void HELPER(vsha2cl_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
     vext_set_elems_1s(vd, vta, env->vl * esz, total_elems * esz);
     env->vstart = 0;
 }
+
+static inline uint32_t p1(uint32_t x)
+{
+    return x ^ rol32(x, 15) ^ rol32(x, 23);
+}
+
+static inline uint32_t zvksh_w(uint32_t m16, uint32_t m9, uint32_t m3,
+                               uint32_t m13, uint32_t m6)
+{
+    return p1(m16 ^ m9 ^ rol32(m3, 15)) ^ rol32(m13, 7) ^ m6;
+}
+
+void HELPER(vsm3me_vv)(void *vd_vptr, void *vs1_vptr, void *vs2_vptr,
+                       CPURISCVState *env, uint32_t desc)
+{
+    uint32_t esz = memop_size(FIELD_EX64(env->vtype, VTYPE, VSEW));
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t *vd = vd_vptr;
+    uint32_t *vs1 = vs1_vptr;
+    uint32_t *vs2 = vs2_vptr;
+
+    for (int i = env->vstart / 8; i < env->vl / 8; i++) {
+        uint32_t w[24];
+        for (int j = 0; j < 8; j++) {
+            w[j] = bswap32(vs1[H4((i * 8) + j)]);
+            w[j + 8] = bswap32(vs2[H4((i * 8) + j)]);
+        }
+        for (int j = 0; j < 8; j++) {
+            w[j + 16] =
+                zvksh_w(w[j], w[j + 7], w[j + 13], w[j + 3], w[j + 10]);
+        }
+        for (int j = 0; j < 8; j++) {
+            vd[(i * 8) + j] = bswap32(w[H4(j + 16)]);
+        }
+    }
+    vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
+
+static inline uint32_t ff1(uint32_t x, uint32_t y, uint32_t z)
+{
+    return x ^ y ^ z;
+}
+
+static inline uint32_t ff2(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) | (x & z) | (y & z);
+}
+
+static inline uint32_t ff_j(uint32_t x, uint32_t y, uint32_t z, uint32_t j)
+{
+    return (j <= 15) ? ff1(x, y, z) : ff2(x, y, z);
+}
+
+static inline uint32_t gg1(uint32_t x, uint32_t y, uint32_t z)
+{
+    return x ^ y ^ z;
+}
+
+static inline uint32_t gg2(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) | (~x & z);
+}
+
+static inline uint32_t gg_j(uint32_t x, uint32_t y, uint32_t z, uint32_t j)
+{
+    return (j <= 15) ? gg1(x, y, z) : gg2(x, y, z);
+}
+
+static inline uint32_t t_j(uint32_t j)
+{
+    return (j <= 15) ? 0x79cc4519 : 0x7a879d8a;
+}
+
+static inline uint32_t p_0(uint32_t x)
+{
+    return x ^ rol32(x, 9) ^ rol32(x, 17);
+}
+
+static void sm3c(uint32_t *vd, uint32_t *vs1, uint32_t *vs2, uint32_t uimm)
+{
+    uint32_t x0, x1;
+    uint32_t j;
+    uint32_t ss1, ss2, tt1, tt2;
+    x0 = vs2[0] ^ vs2[4];
+    x1 = vs2[1] ^ vs2[5];
+    j = 2 * uimm;
+    ss1 = rol32(rol32(vs1[0], 12) + vs1[4] + rol32(t_j(j), j % 32), 7);
+    ss2 = ss1 ^ rol32(vs1[0], 12);
+    tt1 = ff_j(vs1[0], vs1[1], vs1[2], j) + vs1[3] + ss2 + x0;
+    tt2 = gg_j(vs1[4], vs1[5], vs1[6], j) + vs1[7] + ss1 + vs2[0];
+    vs1[3] = vs1[2];
+    vd[3] = rol32(vs1[1], 9);
+    vs1[1] = vs1[0];
+    vd[1] = tt1;
+    vs1[7] = vs1[6];
+    vd[7] = rol32(vs1[5], 19);
+    vs1[5] = vs1[4];
+    vd[5] = p_0(tt2);
+    j = 2 * uimm + 1;
+    ss1 = rol32(rol32(vd[1], 12) + vd[5] + rol32(t_j(j), j % 32), 7);
+    ss2 = ss1 ^ rol32(vd[1], 12);
+    tt1 = ff_j(vd[1], vs1[1], vd[3], j) + vs1[3] + ss2 + x1;
+    tt2 = gg_j(vd[5], vs1[5], vd[7], j) + vs1[7] + ss1 + vs2[1];
+    vd[2] = rol32(vs1[1], 9);
+    vd[0] = tt1;
+    vd[6] = rol32(vs1[5], 19);
+    vd[4] = p_0(tt2);
+}
+
+void HELPER(vsm3c_vi)(void *vd_vptr, void *vs2_vptr, uint32_t uimm,
+                      CPURISCVState *env, uint32_t desc)
+{
+    uint32_t esz = memop_size(FIELD_EX64(env->vtype, VTYPE, VSEW));
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t *vd = vd_vptr;
+    uint32_t *vs2 = vs2_vptr;
+    uint32_t v1[8], v2[8], v3[8];
+
+    for (int i = env->vstart / 8; i < env->vl / 8; i++) {
+        for (int k = 0; k < 8; k++) {
+            v2[k] = bswap32(vd[H4(i * 8 + k)]);
+            v3[k] = bswap32(vs2[H4(i * 8 + k)]);
+        }
+        sm3c(v1, v2, v3, uimm);
+        for (int k = 0; k < 8; k++) {
+            vd[i * 8 + k] = bswap32(v1[H4(k)]);
+        }
+    }
+    vext_set_elems_1s(vd_vptr, vta, env->vl * esz, total_elems * esz);
+    env->vstart = 0;
+}
-- 
2.31.1


