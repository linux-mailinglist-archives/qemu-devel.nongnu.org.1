Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE407A7A4C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivHS-0006t9-5T; Wed, 20 Sep 2023 07:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGy-0006nT-TI
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:37 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGi-0002Gp-T5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:21:35 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bdcbde9676so4377880a34.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208879; x=1695813679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqRIPHqWNZqBqf0cRIFbikY5Mcx8YHmevSxy1+cC3Ns=;
 b=NSnegTBO2y+/tAxXJmv1nUr6Eq5tj3zqUZMpf3qFXivIK49F7VipMesdAbqatF0AQp
 rBTPiB7vP4sYhzKNaQGMR3v0ZUB4/HbhtjwAmQCOvG2QmPsz09nObvxRpwNdE5Y/0uL0
 0B/GlAJdDEUdfLIoCYUcURtpO2TMMksqoFXxd1QXXHviKivjMkIUbbvDkjmOdtz4RQN5
 0S4s42PLdqON5OJkiJqAvrgX+icHMjP/CFh3u05v8MIp27eIN3d9gvPatkFbcAcLfoe7
 7ZHZtsXZ4u57gFbrlSS0uEINfhedZSNyUR2rRjBjK/7+caZXRQrK7O8S5fL7i0RULJeG
 m4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208879; x=1695813679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqRIPHqWNZqBqf0cRIFbikY5Mcx8YHmevSxy1+cC3Ns=;
 b=HEx8rsDH6pOVH9eNdoVuM/FFeJHYvaw+FUgcxi40Gtr+6Lq/eF0g0tbFO4uaL5+gFO
 5+SHjT679bl0R63gglIjvaH7PJyUUVYfLkMN1ucq/WiGFAGunY2mny6UowopwfVIdguL
 TRlfRyBAJDTpU3f+t48pbD4OK4Nq6SoEJPBD9xWmKVdUHa/+F/l0PIaUe9jW64f+cSO1
 Zu1SDE3fMe9gY+PEK1OMhFCRA0KSHMRvyHbWLKhg7XYrUghA0OFu4TydimevlSulQ5VG
 Da/JVlrwIq1h20MoM+/VyxcysEbb1pbvDKZw1yKKp71JyPe2zHYIdfV39awaiz6jbBwe
 rGIw==
X-Gm-Message-State: AOJu0Yw9Tqb4prNKroqXFuB7vROVf/QBtrfmSY8iJsbf7hYHTBmgvnTf
 Dknt1p6GcHce0bhSV0DZRBGnTT8GNmvDMs3Wz2k=
X-Google-Smtp-Source: AGHT+IGzprlPuLIgkPvCLvfjs/MwgzuuL1qNTbtriAS5JAWkZuyB1UrHQ5IG8lkKWFYrrXjT27Wg+Q==
X-Received: by 2002:a9d:6b98:0:b0:6b8:73df:da64 with SMTP id
 b24-20020a9d6b98000000b006b873dfda64mr2303995otq.7.1695208879454; 
 Wed, 20 Sep 2023 04:21:19 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:21:19 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 16/19] target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
Date: Wed, 20 Sep 2023 08:20:17 -0300
Message-ID: <20230920112020.651006-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The array isn't marked as 'const' because we're initializing their
elements in riscv_cpu_add_misa_properties(), 'name' and 'description'
fields.

In a closer look we can see that we're not using these 2 fields after
creating the MISA properties. And we can create the properties by using
riscv_get_misa_ext_name() and riscv_get_misa_ext_description()
directly.

Remove the 'name' and 'description' fields from RISCVCPUMisaExtConfig
and make misa_ext_cfgs[] a const array.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8616c9e2f5..4875feded7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1212,8 +1212,6 @@ static void riscv_cpu_init(Object *obj)
 }
 
 typedef struct RISCVCPUMisaExtConfig {
-    const char *name;
-    const char *description;
     target_ulong misa_bit;
     bool enabled;
 } RISCVCPUMisaExtConfig;
@@ -1317,7 +1315,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 #define MISA_CFG(_bit, _enabled) \
     {.misa_bit = _bit, .enabled = _enabled}
 
-static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
+static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVA, true),
     MISA_CFG(RVC, true),
     MISA_CFG(RVD, true),
@@ -1344,25 +1342,22 @@ void riscv_cpu_add_misa_properties(Object *cpu_obj)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
-        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
+        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
         int bit = misa_cfg->misa_bit;
-
-        misa_cfg->name = riscv_get_misa_ext_name(bit);
-        misa_cfg->description = riscv_get_misa_ext_description(bit);
+        const char *name = riscv_get_misa_ext_name(bit);
+        const char *desc = riscv_get_misa_ext_description(bit);
 
         /* Check if KVM already created the property */
-        if (object_property_find(cpu_obj, misa_cfg->name)) {
+        if (object_property_find(cpu_obj, name)) {
             continue;
         }
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool",
+        object_property_add(cpu_obj, name, "bool",
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
-        object_property_set_description(cpu_obj, misa_cfg->name,
-                                        misa_cfg->description);
-        object_property_set_bool(cpu_obj, misa_cfg->name,
-                                 misa_cfg->enabled, NULL);
+        object_property_set_description(cpu_obj, name, desc);
+        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
     }
 }
 
-- 
2.41.0


