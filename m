Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04779D21D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OM-0002ve-OQ; Tue, 12 Sep 2023 09:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3OL-0002vI-HB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:21 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3OI-0003qr-7w
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:21 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6c0a42a469dso3711888a34.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525116; x=1695129916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdz30WeRHHLw9r9EfvkoHnunIdK+QjVwadXG8AHnbfI=;
 b=fawHyoke/98vjhMvZ2E9XwM8dD2fHqUTPtUAqKGblchhPNCv3E6wGsea5QUPFUUi96
 ZHmU7rrPNuFmmf9StmH+tuZDIY9qBybacyb6MlUHU5qGrmTQOSMPEoGxHE/FKBIhEXf6
 pL6yjsES2EdHc0m968wBCMn1RCysqUee6YpIWsmdxsjhLmb1dVkOuLsZuC1hI/ME1GxE
 DClQlVxfydx5kSS277IlLRc6GLVRVU8QdL+Go+wpxibtvybln72zCoou/g4vAf2UEh5Z
 DOhuhFbsYr3OM0V0cwf28H+3iLhSuClLqZV6bG2FwOJgWtPFghhxcWvbJaaQrhyYmC9B
 ZJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525116; x=1695129916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdz30WeRHHLw9r9EfvkoHnunIdK+QjVwadXG8AHnbfI=;
 b=VdwykM6wwbGvyoigyZuWpb6vtHgPMJPiTAmm4gQUkqSSr4aqw6NqKbwQwb+4sXHKSx
 1Xho/w717y9pPa7EuB0u0HHquzPP0OSOWp4bro6v1V7ikcE7LMywORG6y/rLTgxa+laN
 +GEICIUPdmD2ox0gQwXeCFjmmMh4MgJ5Z+v753C37k7BmHScCITDFCYEfGWNmmzOCSBq
 FxW7QM3M7yn3StAsDpEhgNLizoq82eBYnD/2IE2wnHuBQvPFHl7DLIN7+J1zTF1NxgjH
 CXOexpZB/F4Y8T3oFeL9AgtTbwSJkPwLhJtZg64FYV1DPw5m3tljtlpGMc6xQ5eBI+g1
 GJ5Q==
X-Gm-Message-State: AOJu0Yxnwfi1NKoC9LudNK/yKhz8ElvOelOfOEKaHurV2Ku2WPwjSnpR
 ZYtL1TYvux4+p5HwUPuXrP8UudOkbr70R25xSxI=
X-Google-Smtp-Source: AGHT+IEpZis1EDx0mR3ggGYQAt5vs2QNT4nZNHTc4sIugcuoxq8DkafV4prtwKNQ3ChDnu5cpWezmg==
X-Received: by 2002:a05:6830:18f4:b0:6bd:d1fc:2f2f with SMTP id
 d20-20020a05683018f400b006bdd1fc2f2fmr14877005otf.21.1694525116776; 
 Tue, 12 Sep 2023 06:25:16 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:25:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 13/20] target/riscv/cpu.c: use offset in
 isa_ext_is_enabled/update_enabled
Date: Tue, 12 Sep 2023 10:24:16 -0300
Message-ID: <20230912132423.268494-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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

We'll have future usage for a function where, given an offset of the
struct RISCVCPUConfig, the flag is updated to a certain val.

Change all existing callers to use edata->ext_enable_offset instead of
'edata'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 447913636c..032fad8e03 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -162,18 +162,17 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaCondOps),
 };
 
-static bool isa_ext_is_enabled(RISCVCPU *cpu,
-                               const struct isa_ext_data *edata)
+static bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset)
 {
-    bool *ext_enabled = (void *)&cpu->cfg + edata->ext_enable_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     return *ext_enabled;
 }
 
-static void isa_ext_update_enabled(RISCVCPU *cpu,
-                                   const struct isa_ext_data *edata, bool en)
+static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
+                                   bool en)
 {
-    bool *ext_enabled = (void *)&cpu->cfg + edata->ext_enable_offset;
+    bool *ext_enabled = (void *)&cpu->cfg + ext_offset;
 
     *ext_enabled = en;
 }
@@ -1045,9 +1044,10 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
     /* Force disable extensions if priv spec version does not match */
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i]) &&
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset) &&
             (env->priv_ver < isa_edata_arr[i].min_version)) {
-            isa_ext_update_enabled(cpu, &isa_edata_arr[i], false);
+            isa_ext_update_enabled(cpu, isa_edata_arr[i].ext_enable_offset,
+                                   false);
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -2344,7 +2344,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset)) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.41.0


