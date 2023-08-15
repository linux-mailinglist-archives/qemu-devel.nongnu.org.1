Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F013777D661
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2pY-0006kf-BT; Tue, 15 Aug 2023 18:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2pX-0006k9-4F
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:03 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW2pU-0008FU-Sy
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:48:02 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bd0425ad4fso4951883a34.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692139671; x=1692744471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wt4H+c9A1AA7nxzTApReJL6p9dR9+sJsdIunenyUh08=;
 b=X2/xRLj/8OsT8vZDXL4YUyjQouDzUNBv3BQUoGNN9UGvpf1jvPXD0nF2hxIDvO7k0I
 /IgQ2IoHVr0pw3kk0Z5h/Bdg2WuRHn/Xqa1RBSZsZZQuV0jinS9mqO6DEXxNDYb8Nlrx
 ++HAVRi6YkyiapSwoWfDW/XcqK9Vj9MdRVm6SindtFb+OuGLqdcq+PGkpRKOQnFGLFVL
 iJuZ4I5GbAG8r36p8qeDmfvypRT+5KvKGaZ7VUNNOn6Ca9HAxG3pNIsm23BLyqNZwAod
 LAOi4KjjEh/Ls2dxWxgrSLd8An1UPXWURyialu0bx9RreZAIf9vlCWRBTKbBseOHUkCP
 +qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692139671; x=1692744471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wt4H+c9A1AA7nxzTApReJL6p9dR9+sJsdIunenyUh08=;
 b=doyTlfSkI1Ag652+MSE1FgCmY8VnsAIzABhspFEDuYr2VoX+yETx+mLbAStUusTYqC
 0Ld2b+Szt6pTVQU3XE+Up7tW5d7TgsOQV/9a+hSVS4ZKQVxo6tSxqt4FEM1vJIswP3l7
 0G8fyA/biHgAQX6WG7Y2NzafSMiqPaDGHO73TKBJfETIQhgJ0cp4UKZBIrjj3aGkoVsu
 /5dgUH6EXhO6SbZnP+xb5KkJT2oyOoG3rUlJ5rO2PxWJzAMBpjAGUl3SWxH4ZfWxiI0W
 ql6aHfAAT4Oz43I/ZB2mwGGAv3z+cXwogSkNehnf7pvY6vrilmPYZ3U8iVwmB7mZhIsD
 yT+g==
X-Gm-Message-State: AOJu0YxseqVhMaKaIY6Aeg4G7toZwEqef6qvvDvXNHxFpByMjsPr6GZ7
 C/f9hqPm7e+zqqdtHpE1NLPowPCCD8lhBbjy+vI=
X-Google-Smtp-Source: AGHT+IHTf7+33tmFLa7FypQHZVc8gXSRRL+gX2YMTwt1l3xFUfeWpx1xSs8MSXL3l1K2MeIvCMcUhQ==
X-Received: by 2002:a9d:7dcb:0:b0:6b2:ac44:bf8e with SMTP id
 k11-20020a9d7dcb000000b006b2ac44bf8emr83758otn.8.1692139671680; 
 Tue, 15 Aug 2023 15:47:51 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a9d4b09000000b006b9f26b9b94sm5655668otf.28.2023.08.15.15.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:47:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/8] target/riscv/cpu.c: use offset in
 isa_ext_is_enabled/update_enabled
Date: Tue, 15 Aug 2023 19:47:26 -0300
Message-ID: <20230815224733.434682-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815224733.434682-1-dbarboza@ventanamicro.com>
References: <20230815224733.434682-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 59bd37e033..26d1acdf04 100644
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


