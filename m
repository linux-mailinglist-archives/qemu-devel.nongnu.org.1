Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87477D663
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:49:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2pe-0006o2-5s; Tue, 15 Aug 2023 18:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2pc-0006nB-AZ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:08 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2pZ-0008HC-CJ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:08 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b9c9944da8so5122050a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139684; x=1692744484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdFYdE+8zG859zrBVZP+oPpVrC/pGqESV66SjeP3UlA=;
 b=SyXduwt0dfE0Onj648dV2pvwwc5V2Ei59JNOAGGHX1hCqfQIhGeN07cdpwJgAdzITO
 HZPJ5xfywEfBIw+iwtzjl7owXWgX0igiNBiSa+DJJaIbNfrM6MDrZpzXSztpVr9VI9Kv
 H5AUlKC7R2wXQSE4fpFyARLnqfiDgg9nH6Z2dgma9gphjTsCrrATgNqN0QtQ+3gsgek/
 DSF6RlDJ7sjS+Jxi/XixEuLiqFWD/F646Qi9xQU2IwUeVd6J+P0ozcz5uLyyneKKpdFQ
 qjeEvSA4Zn49TXHMGyGgCtkeHNG2Kk1xTIW0tsZm96Uat+qxQ7BvTmHGscDq1PahfWI0
 IHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139684; x=1692744484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdFYdE+8zG859zrBVZP+oPpVrC/pGqESV66SjeP3UlA=;
 b=as2Hvk+z3f+FieFBghj08yQT/dOK09pZOPQYpUV8fjH4Icn4ph+HKVPoyLX2z07/oy
 G0MJZg1ilaRQoW6NCRQjZ/4HLh07subPFwL3IJpVg6p/OMvGNAWbRLtT4SCmij+kd4nx
 jUbjlPi+Ae0k2w1MIx1CPFFZ+tLSm6w3MxiHCsvMPrb6hI1x8jwyjyOZ6rSzW4tvVedn
 M+aFrtpQ43IZZ67Whh+2rS3QwXvfsyz6Jq/FCNtRlsv9c0WhovoWgePleyy0EyMkZkmN
 Py2SzVWvlVcvSHXmGZQEXWSBqkN1oNBCdzxxP8MG38BDlJO+flpy3DolkqOzFrsN3+tc
 UOlg==
X-Gm-Message-State: AOJu0YwJlQW+Oxobq2ciOmQ8ZBlkhhDryERMAJ44y3SbVq2RaAESxWDC
 z3H60ggk9z+3pQC63tbv2w8ZkHLURFbJI9PEBr4=
X-Google-Smtp-Source: AGHT+IFqZOV9rYp/yFeNgvY0zfWN3bTerow1gL7k6v9NO8cC2KOc3yMmQ8JfBGzGIFXq3KHCHYsR4Q==
X-Received: by 2002:a05:6830:13c6:b0:6b9:b665:7f with SMTP id
 e6-20020a05683013c600b006b9b665007fmr85375otq.17.1692139683746; 
 Tue, 15 Aug 2023 15:48:03 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a9d4b09000000b006b9f26b9b94sm5655668otf.28.2023.08.15.15.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:48:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 5/8] target/riscv/cpu.c: introduce RISCVCPUMultiExtConfig
Date: Tue, 15 Aug 2023 19:47:30 -0300
Message-ID: <20230815224733.434682-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815224733.434682-1-dbarboza@ventanamicro.com>
References: <20230815224733.434682-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If we want to make better decisions when auto-enabling extensions during
realize() we need a way to tell if an user set an extension manually.
The RISC-V KVM driver has its own solution via a KVMCPUConfig struct
that has an 'user_set' flag that is set during the Property set()
callback. The set() callback also does init() time validations based on
the current KVM driver capabilities.

For TCG we would want a 'user_set' mechanic too, but we would look
ad-hoc via cpu_cfg_ext_auto_update() if a certain extension was user set
or not. If we copy what was made in the KVM side we would look for
'user_set' for one into 60+ extension structs spreaded in 3 arrays
(riscv_cpu_extensions, riscv_cpu_experimental_exts,
riscv_cpu_vendor_exts).

We'll still need an extension struct but we won't be using the
'user_set' flag:

- 'RISCVCPUMultiExtConfig' will be our specialized structure, similar to what
we're already doing with the MISA extensions in 'RISCVCPUMisaExtConfig'.
DEFINE_PROP_BOOL() for all 3 extensions arrays were replaced by
MULTI_EXT_CFG_BOOL(), a macro that will init our specialized struct;

- the 'multi_ext_user_opts' hash will be used to store the offset of each
extension that the user set via the set() callback, cpu_set_multi_ext_cfg().
For now we're just initializing and populating it - next patch will use
it to determine if a certain extension was user set;

- cpu_add_multi_ext_prop() is a new helper that will replace the
qdev_property_add_static() calls that our macros are doing to populate
user properties. The macro was renamed to ADD_CPU_MULTIEXT_PROPS_ARRAY()
for clarity. Note that the non-extension properties in
riscv_cpu_options[] still need to be declared via qdev().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 240 ++++++++++++++++++++++++++++-----------------
 1 file changed, 150 insertions(+), 90 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8f0b8f2c9..f8be03a536 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -151,6 +151,9 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 };
 
+/* Hash that stores user set extensions */
+static GHashTable *multi_ext_user_opts;
+
 static bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
 {
     bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
@@ -1661,6 +1664,8 @@ static void riscv_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
+
+    multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
 }
 
 typedef struct RISCVCPUMisaExtConfig {
@@ -1812,98 +1817,108 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
-static Property riscv_cpu_extensions[] = {
+typedef struct RISCVCPUMultiExtConfig {
+    const char *name;
+    uint32_t offset;
+    bool enabled;
+} RISCVCPUMultiExtConfig;
+
+#define MULTI_EXT_CFG_BOOL(_name, _prop, _defval) \
+    {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
+     .enabled = _defval}
+
+static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
-    DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
-    DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
-    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
-    DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
-    DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
-    DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
-    DEFINE_PROP_BOOL("Zfh", RISCVCPU, cfg.ext_zfh, false),
-    DEFINE_PROP_BOOL("Zfhmin", RISCVCPU, cfg.ext_zfhmin, false),
-    DEFINE_PROP_BOOL("Zve32f", RISCVCPU, cfg.ext_zve32f, false),
-    DEFINE_PROP_BOOL("Zve64f", RISCVCPU, cfg.ext_zve64f, false),
-    DEFINE_PROP_BOOL("Zve64d", RISCVCPU, cfg.ext_zve64d, false),
-    DEFINE_PROP_BOOL("sstc", RISCVCPU, cfg.ext_sstc, true),
-
-    DEFINE_PROP_BOOL("smstateen", RISCVCPU, cfg.ext_smstateen, false),
-    DEFINE_PROP_BOOL("svadu", RISCVCPU, cfg.ext_svadu, true),
-    DEFINE_PROP_BOOL("svinval", RISCVCPU, cfg.ext_svinval, false),
-    DEFINE_PROP_BOOL("svnapot", RISCVCPU, cfg.ext_svnapot, false),
-    DEFINE_PROP_BOOL("svpbmt", RISCVCPU, cfg.ext_svpbmt, false),
-
-    DEFINE_PROP_BOOL("zba", RISCVCPU, cfg.ext_zba, true),
-    DEFINE_PROP_BOOL("zbb", RISCVCPU, cfg.ext_zbb, true),
-    DEFINE_PROP_BOOL("zbc", RISCVCPU, cfg.ext_zbc, true),
-    DEFINE_PROP_BOOL("zbkb", RISCVCPU, cfg.ext_zbkb, false),
-    DEFINE_PROP_BOOL("zbkc", RISCVCPU, cfg.ext_zbkc, false),
-    DEFINE_PROP_BOOL("zbkx", RISCVCPU, cfg.ext_zbkx, false),
-    DEFINE_PROP_BOOL("zbs", RISCVCPU, cfg.ext_zbs, true),
-    DEFINE_PROP_BOOL("zk", RISCVCPU, cfg.ext_zk, false),
-    DEFINE_PROP_BOOL("zkn", RISCVCPU, cfg.ext_zkn, false),
-    DEFINE_PROP_BOOL("zknd", RISCVCPU, cfg.ext_zknd, false),
-    DEFINE_PROP_BOOL("zkne", RISCVCPU, cfg.ext_zkne, false),
-    DEFINE_PROP_BOOL("zknh", RISCVCPU, cfg.ext_zknh, false),
-    DEFINE_PROP_BOOL("zkr", RISCVCPU, cfg.ext_zkr, false),
-    DEFINE_PROP_BOOL("zks", RISCVCPU, cfg.ext_zks, false),
-    DEFINE_PROP_BOOL("zksed", RISCVCPU, cfg.ext_zksed, false),
-    DEFINE_PROP_BOOL("zksh", RISCVCPU, cfg.ext_zksh, false),
-    DEFINE_PROP_BOOL("zkt", RISCVCPU, cfg.ext_zkt, false),
-
-    DEFINE_PROP_BOOL("zdinx", RISCVCPU, cfg.ext_zdinx, false),
-    DEFINE_PROP_BOOL("zfinx", RISCVCPU, cfg.ext_zfinx, false),
-    DEFINE_PROP_BOOL("zhinx", RISCVCPU, cfg.ext_zhinx, false),
-    DEFINE_PROP_BOOL("zhinxmin", RISCVCPU, cfg.ext_zhinxmin, false),
-
-    DEFINE_PROP_BOOL("zicbom", RISCVCPU, cfg.ext_icbom, true),
-    DEFINE_PROP_BOOL("zicboz", RISCVCPU, cfg.ext_icboz, true),
-
-    DEFINE_PROP_BOOL("zmmul", RISCVCPU, cfg.ext_zmmul, false),
-
-    DEFINE_PROP_BOOL("zca", RISCVCPU, cfg.ext_zca, false),
-    DEFINE_PROP_BOOL("zcb", RISCVCPU, cfg.ext_zcb, false),
-    DEFINE_PROP_BOOL("zcd", RISCVCPU, cfg.ext_zcd, false),
-    DEFINE_PROP_BOOL("zce", RISCVCPU, cfg.ext_zce, false),
-    DEFINE_PROP_BOOL("zcf", RISCVCPU, cfg.ext_zcf, false),
-    DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
-    DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
+    MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
+    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
+    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
+    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
+    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
+    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
+    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
+    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
+    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
+
+    MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
+    MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
+    MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
+    MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
+
+    MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
+    MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
+    MULTI_EXT_CFG_BOOL("zbc", ext_zbc, true),
+    MULTI_EXT_CFG_BOOL("zbkb", ext_zbkb, false),
+    MULTI_EXT_CFG_BOOL("zbkc", ext_zbkc, false),
+    MULTI_EXT_CFG_BOOL("zbkx", ext_zbkx, false),
+    MULTI_EXT_CFG_BOOL("zbs", ext_zbs, true),
+    MULTI_EXT_CFG_BOOL("zk", ext_zk, false),
+    MULTI_EXT_CFG_BOOL("zkn", ext_zkn, false),
+    MULTI_EXT_CFG_BOOL("zknd", ext_zknd, false),
+    MULTI_EXT_CFG_BOOL("zkne", ext_zkne, false),
+    MULTI_EXT_CFG_BOOL("zknh", ext_zknh, false),
+    MULTI_EXT_CFG_BOOL("zkr", ext_zkr, false),
+    MULTI_EXT_CFG_BOOL("zks", ext_zks, false),
+    MULTI_EXT_CFG_BOOL("zksed", ext_zksed, false),
+    MULTI_EXT_CFG_BOOL("zksh", ext_zksh, false),
+    MULTI_EXT_CFG_BOOL("zkt", ext_zkt, false),
+
+    MULTI_EXT_CFG_BOOL("zdinx", ext_zdinx, false),
+    MULTI_EXT_CFG_BOOL("zfinx", ext_zfinx, false),
+    MULTI_EXT_CFG_BOOL("zhinx", ext_zhinx, false),
+    MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
+
+    MULTI_EXT_CFG_BOOL("zicbom", ext_icbom, true),
+    MULTI_EXT_CFG_BOOL("zicboz", ext_icboz, true),
+
+    MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
+
+    MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
+    MULTI_EXT_CFG_BOOL("zcb", ext_zcb, false),
+    MULTI_EXT_CFG_BOOL("zcd", ext_zcd, false),
+    MULTI_EXT_CFG_BOOL("zce", ext_zce, false),
+    MULTI_EXT_CFG_BOOL("zcf", ext_zcf, false),
+    MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
+    MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property riscv_cpu_vendor_exts[] = {
-    DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
-    DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
-    DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
-    DEFINE_PROP_BOOL("xtheadcmo", RISCVCPU, cfg.ext_xtheadcmo, false),
-    DEFINE_PROP_BOOL("xtheadcondmov", RISCVCPU, cfg.ext_xtheadcondmov, false),
-    DEFINE_PROP_BOOL("xtheadfmemidx", RISCVCPU, cfg.ext_xtheadfmemidx, false),
-    DEFINE_PROP_BOOL("xtheadfmv", RISCVCPU, cfg.ext_xtheadfmv, false),
-    DEFINE_PROP_BOOL("xtheadmac", RISCVCPU, cfg.ext_xtheadmac, false),
-    DEFINE_PROP_BOOL("xtheadmemidx", RISCVCPU, cfg.ext_xtheadmemidx, false),
-    DEFINE_PROP_BOOL("xtheadmempair", RISCVCPU, cfg.ext_xtheadmempair, false),
-    DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
-    DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
+static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
+    MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
+    MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
+    MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
+    MULTI_EXT_CFG_BOOL("xtheadcmo", ext_xtheadcmo, false),
+    MULTI_EXT_CFG_BOOL("xtheadcondmov", ext_xtheadcondmov, false),
+    MULTI_EXT_CFG_BOOL("xtheadfmemidx", ext_xtheadfmemidx, false),
+    MULTI_EXT_CFG_BOOL("xtheadfmv", ext_xtheadfmv, false),
+    MULTI_EXT_CFG_BOOL("xtheadmac", ext_xtheadmac, false),
+    MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
+    MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
+    MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
+    MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
 
 /* These are experimental so mark with 'x-' */
-static Property riscv_cpu_experimental_exts[] = {
-    DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
+static RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-zicond", ext_zicond, false),
 
     /* ePMP 0.9.3 */
-    DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
-    DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
-    DEFINE_PROP_BOOL("x-ssaia", RISCVCPU, cfg.ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
+    MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
 
-    DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
-    DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
+    MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
+    MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
 
-    DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
-    DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
-    DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
+    MULTI_EXT_CFG_BOOL("x-zfbfmin", ext_zfbfmin, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
 
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1926,6 +1941,49 @@ static Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    isa_ext_update_enabled(RISCV_CPU(obj), multi_ext_cfg->offset, value);
+
+    g_hash_table_insert(multi_ext_user_opts,
+                        GUINT_TO_POINTER(multi_ext_cfg->offset),
+                        (gpointer)value);
+}
+
+static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
+    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void cpu_add_multi_ext_prop(Object *cpu_obj,
+                                   RISCVCPUMultiExtConfig *multi_cfg)
+{
+    object_property_add(cpu_obj, multi_cfg->name, "bool",
+                        cpu_get_multi_ext_cfg,
+                        cpu_set_multi_ext_cfg,
+                        NULL, (void *)multi_cfg);
+
+    /*
+     * Set def val directly instead of using
+     * object_property_set_bool() to save the set()
+     * callback hash for user inputs.
+     */
+    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
+                           multi_cfg->enabled);
+}
+
 #ifndef CONFIG_USER_ONLY
 static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
                                     const char *name,
@@ -1945,10 +2003,11 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
 }
 #endif
 
-static void riscv_cpu_add_qdev_prop_array(DeviceState *dev, Property *array)
+static void riscv_cpu_add_multiext_prop_array(Object *obj,
+                                              RISCVCPUMultiExtConfig *array)
 {
-    for (Property *prop = array; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
+    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
+        cpu_add_multi_ext_prop(obj, prop);
     }
 }
 
@@ -1971,9 +2030,9 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 }
 
 static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                                 Property *array)
+                                                 RISCVCPUMultiExtConfig *array)
 {
-    for (Property *prop = array; prop && prop->name; prop++) {
+    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 }
@@ -2008,8 +2067,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
-    DeviceState *dev = DEVICE(obj);
-
 #ifndef CONFIG_USER_ONLY
     riscv_add_satp_mode_properties(obj);
 
@@ -2021,10 +2078,13 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_misa_properties(obj);
 
-    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_extensions);
-    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_options);
-    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_vendor_exts);
-    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_experimental_exts);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+
+    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
+        qdev_property_add_static(DEVICE(obj), prop);
+    }
 }
 
 /*
@@ -2035,7 +2095,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    Property *prop;
+    RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
     set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
-- 
2.41.0


