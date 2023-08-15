Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029C77D43A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0mX-0006NZ-27; Tue, 15 Aug 2023 16:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mV-0006Ms-4k
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:47 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0mS-0000zB-UW
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:36:46 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b9cf1997c4so4870006a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692131803; x=1692736603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0dU/wef67XGoB0gAFv8TUXnVp8TlOWHmFk+0Sr/Zmg=;
 b=Cr7hx77/wBXlh15wIOHXOVdO8psf/5VOzxKC5ljS0bnmqSowc+PM7UwcG4gD4SkgYX
 E9AA38rJ7lx288YQgtSSqjwCVBO5qkBc1RcwxGiZiBndRHOk96Ni3W9l9qBNTzMFQSIb
 f9q2YhW61chzwB45BddCrOlVNBSNjlqage3x3eUK4LyL892cD9FjWI/urRhqj7Rs/fQM
 729YbdRifbIl5C3Wg2IZUFwsmRb2CrrHHRHkEkIAyMCM+2AcpAKFnA7mxx9BIdNci8Ai
 YQh+8oNz/XGK+DVLERrIAJrFUtotmSrZTTnqNToBL9gPcTzB9lGcXGBBwpSmhRNUiKnU
 extw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131803; x=1692736603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0dU/wef67XGoB0gAFv8TUXnVp8TlOWHmFk+0Sr/Zmg=;
 b=AE7E4/MJSpkcN3HQNKzZWDtC/g/NaxdVmv5odX8wSOCdwCZb8Nkz6s8qark2Y/5IxZ
 5LSxpPNJqdOrXODZryM9GVZHvAZY4iO4bF6EUVAiWfBk1ed8nzcbLIgv1Ogy4AMdZNqN
 l+dHTlZtM/MV8Lzsk6j3saUxSWXQhD90Q+wbdjhvoJqDpYkC79OSNeQUu2B6DvmKx37g
 supXrEGFBJ7fYoJ873u+/PWpe7HBGrILr2f/J1F0DgwfFZSOWtq0P7ELNzuJOQGrLa3J
 4ChNxuAgT5QU4wsi8vDdj9Sl00B/u+ZMn8dbIjvezXd9hL92peZgh1nDbsbzxtQ6yl4l
 jDIQ==
X-Gm-Message-State: AOJu0YxlETLrrY/VWMLWJjgnrocq4zjxgFwVZQkCRl0eT8h+dWOT+kmZ
 KfZvSKaADxDG18/lpLh31BOs+4MyXSRhD0RqUYI=
X-Google-Smtp-Source: AGHT+IEC3Ma9pkFBQ1vGIDxJxdOGkyUpUYRYH4YAQEM1q509Tpd5dUI8aa2sfCiGF75VzVVP6hn2hQ==
X-Received: by 2002:a9d:7e91:0:b0:6bc:b80c:bd53 with SMTP id
 m17-20020a9d7e91000000b006bcb80cbd53mr12222675otp.38.1692131803630; 
 Tue, 15 Aug 2023 13:36:43 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a0568301bcf00b006b94fb2762asm5526849ota.23.2023.08.15.13.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:36:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/8] target/riscv/cpu.c: use offset in
 isa_ext_is_enabled/update_enabled
Date: Tue, 15 Aug 2023 17:36:28 -0300
Message-ID: <20230815203635.400179-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815203635.400179-1-dbarboza@ventanamicro.com>
References: <20230815203635.400179-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
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
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3930c85341..d78afe99f1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -151,18 +151,17 @@ static const struct isa_ext_data isa_edata_arr[] = {
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
@@ -1023,9 +1022,10 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
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
@@ -2274,7 +2274,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset)) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.41.0


