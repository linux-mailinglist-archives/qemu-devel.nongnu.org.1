Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E97937FB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdogY-0005tO-62; Wed, 06 Sep 2023 05:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofh-0004CE-IV
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:18:02 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofW-0005qb-KO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:18:00 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6c09d760cb9so707868a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991867; x=1694596667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYPq6qx4s6ZZjgcoC1MZVsiyv8qTGFaIklxyrZMhrc0=;
 b=AS6E5weLSuASRrm5nA21qSRNEurmhLL93PKZlSTW+DQq+Hzfh6sU40MZliOMeGWXJM
 yjrgKG9WzwDtRrkHGHFQNCgY1W1Og7ychTIZmk6T1f5UQ3z4SVu8cxjVvLRrHotpeDPJ
 ar7MXS80/B9j34MNU9Vr/H3Avvb7PXP/BU49NRbMcbmDwD6AZcg7rcCw2OLAh2AuTrBX
 RdQIGh8iAsGjj2gbIGkALnfhrgKXxijWZV3k2MgyN8+6PCNMFE3kwapaRKiYGfkDJIfy
 d1z0vV0VqVt0eU914EA9FgBSWP+7OJsEyBpcm3V6MflokyAwxtDb0g7TWbvm/ffcRWXX
 yncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991867; x=1694596667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYPq6qx4s6ZZjgcoC1MZVsiyv8qTGFaIklxyrZMhrc0=;
 b=Yxo4jGanaU7PlThxEHnA7bLrmXTDyECbd6qBTeuc5Kfn3gCRpgHdNPtIID8Dj4jlGz
 /+slueUGPMjN9DYYIBSZ/mOPX91uBhr5rZlCwJEC06SoAB2vzgGLiUfX0Gv9jrUftWft
 6Yyd/o56dYeB/oriLzfXJcXyKJ+h8CckKSLWvTi+WgioSCN0/4Yz8YVxakbhT9UYH/4k
 J942IPwqr7BjDgxaxJ2u6bTTLFUNkKR5mbfcrAPMwrAJiVbRISAfK2KrNE+u215KYAQw
 47HNtnHk43gD7ROTuEGuAeNmYXoHTt5eVtJJJ53atSC6dLgjtLlYoficdcPerISAVWsJ
 7E1Q==
X-Gm-Message-State: AOJu0YzIaB7wYE6/dylpw1FRZFMJm7Z5NpQISqh6y4Jz1YEJ4HzsdlP1
 FL/yZ9CEX+NIAIJfsEah0BTVKQHPZzyGKfFhfY8=
X-Google-Smtp-Source: AGHT+IFZ0sGQG1die8gLsXN5BAHh3LA0SYSQa2CWTs8T0O+JktlLCdGtoHHuv9pQmHazuw6I+teLCA==
X-Received: by 2002:a05:6830:1147:b0:6b0:c67c:96f3 with SMTP id
 x7-20020a056830114700b006b0c67c96f3mr14623549otq.18.1693991867380; 
 Wed, 06 Sep 2023 02:17:47 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 16/19] target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
Date: Wed,  6 Sep 2023 06:16:43 -0300
Message-ID: <20230906091647.1667171-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x336.google.com
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


