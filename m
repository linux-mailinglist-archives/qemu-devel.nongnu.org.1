Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB4C7C63ED
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4g-00062S-VP; Thu, 12 Oct 2023 00:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4c-0005gw-9B
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4a-0002gB-GB
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c8a6aa0cd1so4962425ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083998; x=1697688798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Jsho1zyiwy9Dx5ZmvWavw3y5DQqxKD6wruKXBKxiGA=;
 b=NK99geQecAPsPvx/ajMarr2T74Zd7tncD4RXj1V4HtdxE3w3KG6ZLApW9LsgomBCuK
 mmVuA1pSJky7cuv4zJfoFdHGaNceV+pZda36mOCoCrk1+R4exIKiBy4lIPMXLX0QJ/mD
 7/9CX5aQl7nIRXGukyGhk03kosnxZLeb9maoeVhtBBguguS0p7KBcQM5bwUoDPuxOPDq
 ylVjdhOnnIixv6I/ehcQ7hWlL2yZN754QbAhVh1I71YiiRfqsfXrs0mDlWbgx6+mFJFK
 jaE6jHhy1qoC4v988acyF5HfVJY+TGrq9hwc5Pnx87bNGAegMUCedCo7UrgpZB2IV7NH
 /SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083998; x=1697688798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Jsho1zyiwy9Dx5ZmvWavw3y5DQqxKD6wruKXBKxiGA=;
 b=d3BtR02vDTjK6SZANaPviWTjftjRgEk4hmcyXmtVQ7GeSuFPvIw5vchngSwoez4Oy9
 X2Ue1aOaVllnJjpXRbEy0430mNP43dotKcl4iZ9IlCfYZSIj7SvutZ5TgCepb9iAIa05
 oEh9rZDy1dNkwXveghHuFTX8Ym4s1eYECwIb7dX0wiYXFZk06imTiwkwGtetmgjFsjWT
 Ix0qMxo2nAJfnPrMieG33QxIBvYUC3xudrPv/qSV8IUuwiNBj//FuMRGtdEgbam9wU7Q
 4J1uhvWeed9WTa+ePG6RPCY3ebG9m/Jnhnkmunzga3wD585RMYyuH02IfCr2WbHCFhJ+
 BAWw==
X-Gm-Message-State: AOJu0Yx/5rWXnYV4Vs3fnOS+1576GXw1ouGu13+611LZ6gX0J5DMdtiH
 t3amp7xcu6EosEYKdvk3+c3sdqd5Umdd3Q==
X-Google-Smtp-Source: AGHT+IHMARPMPoaWMjYEVjGVpKkcdMkItvkOddao2TeHUAj7L7luoerW2rI2DT0CNuEhr0406A4Y4Q==
X-Received: by 2002:a17:902:d214:b0:1c7:8445:9d53 with SMTP id
 t20-20020a170902d21400b001c784459d53mr17583048ply.63.1697083997867; 
 Wed, 11 Oct 2023 21:13:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/54] target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
Date: Thu, 12 Oct 2023 14:10:35 +1000
Message-ID: <20231012041051.2572507-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-17-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 40f9ad84f6..1c42e2590e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1208,8 +1208,6 @@ static void riscv_cpu_init(Object *obj)
 }
 
 typedef struct RISCVCPUMisaExtConfig {
-    const char *name;
-    const char *description;
     target_ulong misa_bit;
     bool enabled;
 } RISCVCPUMisaExtConfig;
@@ -1313,7 +1311,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 #define MISA_CFG(_bit, _enabled) \
     {.misa_bit = _bit, .enabled = _enabled}
 
-static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
+static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVA, true),
     MISA_CFG(RVC, true),
     MISA_CFG(RVD, true),
@@ -1340,25 +1338,22 @@ void riscv_cpu_add_misa_properties(Object *cpu_obj)
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


