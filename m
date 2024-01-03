Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C38233C6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:49:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Ex-0005Xi-Bn; Wed, 03 Jan 2024 12:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5Ep-0005EF-3d
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:41:07 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rL5Ej-0001kS-Lu
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:41:06 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6da16ec9be4so4201901b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704303659; x=1704908459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcJgCanuDO16+bp0jo2nfKBsMMHLb9tW9PJJIRWNfao=;
 b=ojBkH9gQWg7UKoyhTNyPsmsmsiRe5ue/MZimE8RQTPfViag4D7klUk36FlQb7Ln9G8
 ksqp5NZ8WEZUYowwij0GEvEAGI3NBZQylkKNeDrGTPWNSVwHqzDx2TbxbjNFl5qv1r7V
 IX7KVsLGX70OsPxi4i32qydcY2V9IPG/Fkl0DzPUGkzRfiKrr2wlWJFeVcVLwlNl9GYI
 hG4p3ux1eJM0NVxAHFgwm6iSA6ZvhIOJsDcHurUL3l4W+Sg3NQdAqNRPXvshbzr+Im1E
 lZ7R0mZhHHry0VA/DJ1cx1DPUpu9743RR9wos0kDfRnI7Faf6YzOPUKoArlxbocUDCBu
 MAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303659; x=1704908459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcJgCanuDO16+bp0jo2nfKBsMMHLb9tW9PJJIRWNfao=;
 b=Zi3wAsR59YW948jhn6g5/cQAbu3/vCb5QId1prbJedV1XJEZITM0Gly3X51KX/NNkh
 Lxm6y6qkM7EKYmktwRJwuUtwhAfw+IpLZnsTUpeHyQjjmKL95AiRE1JiH4h8kzGpmuSu
 BaW2VzeFEs3dM0Y0ZZQuWTdXKuvqg13iNbPqYDLvVid/8JUtJBHwOzytofo1P7Ppgu0b
 PuaifqV6W/MrF2HH8s5JSIPRJ69bXszFyQa7ENNc/Ap5r53pmLbr+0EljNe3gozaOUr0
 pU7PmYvW/MgcZ86TXO72ARcEwLKtr0Gp8UAkTS6Wk31b1ZhRjE1I2JJwgKlX/6XUvHOO
 aw4A==
X-Gm-Message-State: AOJu0Yyg0dyzbcHQ2nw5c4hGpY4s2N/L1pxK6rBnPxV3sWYPv6BLaQVD
 RqjC4jCsNCmNY+lGqiRU8JUE4O5qso0cK4G8DZaCDIdKMgfpTw==
X-Google-Smtp-Source: AGHT+IHxG4/01DVaNa+Fx0kHWOV0SLYGHuFvCYtsPrI55qmALpoyvk1c+Ui1JGIUwsBpZM2Y7PZt/A==
X-Received: by 2002:a05:6a21:7989:b0:195:2f17:9884 with SMTP id
 bh9-20020a056a21798900b001952f179884mr25496031pzc.20.1704303659610; 
 Wed, 03 Jan 2024 09:40:59 -0800 (PST)
Received: from grind.. ([189.79.21.107]) by smtp.gmail.com with ESMTPSA id
 v3-20020aa78503000000b006d7f1ae421csm24042050pfn.145.2024.01.03.09.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:40:59 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, vladimir.isaev@syntacore.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 11/16] target/riscv: move 'cbom_blocksize' to
 riscv_cpu_properties[]
Date: Wed,  3 Jan 2024 14:40:08 -0300
Message-ID: <20240103174013.147279-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103174013.147279-1-dbarboza@ventanamicro.com>
References: <20240103174013.147279-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

After adding a KVM finalize() implementation, turn cbom_blocksize into a
class property. Follow the same design we used with 'vlen' and 'elen'.

The duplicated 'cbom_blocksize' KVM property can be removed from
kvm_riscv_add_cpu_user_properties().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  4 ----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 92b4881e9c..b510cb94fc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1276,6 +1276,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
     cpu->cfg.vlen = 128;
     cpu->cfg.elen = 64;
+    cpu->cfg.cbom_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1822,8 +1823,42 @@ static const PropertyInfo prop_elen = {
     .set = prop_elen_set,
 };
 
+static void prop_cbom_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cbom_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cbom_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cbom_blocksize = value;
+}
+
+static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cbom_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cbom_blksize = {
+    .name = "cbom_blocksize",
+    .get = prop_cbom_blksize_get,
+    .set = prop_cbom_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
@@ -1844,6 +1879,8 @@ static Property riscv_cpu_properties[] = {
     {.name = "vlen", .info = &prop_vlen},
     {.name = "elen", .info = &prop_elen},
 
+    {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 70fb075846..1866b56913 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -484,10 +484,6 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
                             NULL, multi_cfg);
     }
 
-    object_property_add(cpu_obj, "cbom_blocksize", "uint16",
-                        NULL, kvm_cpu_set_cbomz_blksize,
-                        NULL, &kvm_cbom_blocksize);
-
     object_property_add(cpu_obj, "cboz_blocksize", "uint16",
                         NULL, kvm_cpu_set_cbomz_blksize,
                         NULL, &kvm_cboz_blocksize);
-- 
2.43.0


