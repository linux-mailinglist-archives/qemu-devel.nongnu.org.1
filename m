Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DF766DF0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNKA-0006eb-Rq; Fri, 28 Jul 2023 09:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJu-0006Qd-4E
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:51 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qPNJo-0003Kl-7P
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:15:49 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bb7297c505so1656313fac.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690550128; x=1691154928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cl7FFi0tdXS+CwJDAdsPTGNt99E7saecu9cxqSEj+54=;
 b=RB70xI2Y5NGJY1C28FKCXn8FCvjdcmvTsoTzoBwul4WbJbeWmyznUnkcS3N3Xi9ev/
 CDwh/UPFc8ph2inDoAE1OQcTnFOiMSxKQlvMZVq2cnANQUmYbN5FsPzuvrN6NaPtEuXV
 +5542FYdyAVnOlum2UF4l70nrLXnxzkIGuxzbVde4Js+QkJEvjNf3lnNLHvHJBcnl/ez
 6IjRtxUMOw5dockg/sB53oUrdAZ+jP6fPdPUUK1AAc40GeZoUEYU8DZO2mqxmD7KTYho
 R2y5lZepgWS42Lf8wUmATbgQ2dtA+rbi2bWFPSaHZtH5dezlOETndZrHr0gFZ16rUgo1
 LE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550128; x=1691154928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cl7FFi0tdXS+CwJDAdsPTGNt99E7saecu9cxqSEj+54=;
 b=XLzy3joPIMyNr+viKwU4yOkld9zQxZGGIMrOnCZCp2VmTcaAaq97XHXRDBIk23oz4r
 MBEuLY8zOZ5mMMHTQCt6iLrC6vZcz5r+DAZPZmXI6At1DsTaeeeCrhiGkCF35awoAIIT
 hQv4+na8aEeGe+KFtVcqjxJWdr4Hr1vl87x77/7JN2+z23nTeDaCY8xnbS6AGXKFPBVC
 NQCS0PwDNrQWlaIBwFi6AknHe0OIhwuwKPmDVUiInZdlYEgZWnXr+ccf4iWmqoWSYhBQ
 VDft75Y0TyfNUT19LGfbgk5Ca+OH27XCUr2Ip14Migp2oe5/rYW61DIpnP7dVo5x03p3
 Qf+Q==
X-Gm-Message-State: ABy/qLYjgzeRQEYt3pIvtqfPmwQ97Zwoc3pEqyb6AYI2r+FrACboWXFN
 nOSg/ycVumiKgCngkgE/Us5N1bgxQn7BCk8IgCFrPQ==
X-Google-Smtp-Source: APBJJlG2LVeqsdT9eDX3p3j2zxNQvFrHxS7Zx+Gd4Uj1wsiy0sWHs2IKYjRMSeWFAK+NsOLH0EAqrQ==
X-Received: by 2002:a05:6870:c69d:b0:1bc:3f6:579b with SMTP id
 cv29-20020a056870c69d00b001bc03f6579bmr1663605oab.22.1690550128732; 
 Fri, 28 Jul 2023 06:15:28 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 hv6-20020a056871cc0600b001b3d93884fdsm1699371oac.57.2023.07.28.06.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:15:28 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/8] target/riscv/cpu.c: use offset in
 isa_ext_is_enabled/update_enabled
Date: Fri, 28 Jul 2023 10:15:13 -0300
Message-ID: <20230728131520.110394-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728131520.110394-1-dbarboza@ventanamicro.com>
References: <20230728131520.110394-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2c.google.com
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

We'll have future usage for a function where, given an offset of the
struct RISCVCPUConfig, the flag is updated to a certain val.

Change all existing callers to use edata->ext_enable_offset instead of
'edata'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b5a2266eef..644ce7a018 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,18 +153,17 @@ static const struct isa_ext_data isa_edata_arr[] = {
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
@@ -1025,9 +1024,10 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 
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
@@ -2271,7 +2271,7 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
-        if (isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
+        if (isa_ext_is_enabled(cpu, isa_edata_arr[i].ext_enable_offset)) {
             new = g_strconcat(old, "_", isa_edata_arr[i].name, NULL);
             g_free(old);
             old = new;
-- 
2.41.0


