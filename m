Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3C82C146
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI79-00040R-MT; Fri, 12 Jan 2024 09:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOI75-0003y4-BP
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:02:23 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rOI73-0005pu-GZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:02:22 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d54b763d15so32977405ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 06:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705068139; x=1705672939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AxxIze3Hqx7PnD8MMH/lnxGiGJCFGHgXBnisoTkwaY=;
 b=WaTt3ESVQ+2GyQslhDBXd2S5PGWNAjZZuC5WeoU42rkdPgkjwaOKRe6t0gwJR05gQp
 5NGcyIVQ+WBRjRnVWzigP8jqL0CxLwfgYGCiOkpBlk2zRloXmzLRrq+fMVA3bNqQr1cO
 sPgvRb00cn9mtcW+A6iCtVFJMqBuur97MAI6vchsNL/84+E1E6XkL2XjgxrN9FGbBcCf
 i6gvjKNwCyCb/bJVZfMWSrg9F4Gt/VjhQfHSe5ljj0PFCjUeTWlkk+Bsdaf0H6spkcHw
 8eKIUP8CBtB6HCd3T1OAWVioIV/pHzrKgigPuSqSJLrCWJEno8dD4p7R4GNUbtun9m0u
 thcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705068139; x=1705672939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AxxIze3Hqx7PnD8MMH/lnxGiGJCFGHgXBnisoTkwaY=;
 b=LsbwZfb0s814w2A3HHHN66yUc/VgZQYg7c353Y2lznBUSyuLLqYI6HTXPXgCCnSQiZ
 QnpH4Oa6QrOEX4vFFGAvmuAiLGomhVdhA70ogNNcpWqyHvsrlOUgjJ7CowJPcWRnvSIr
 cT3iSFeVavYPyErNEYd4JrS0X+iU+8W964TNm54eCSCh0J/8o+hXJbBDZr9LtzxIwSNt
 LI2j7W93HUPmapjGTFapZjJ32vmT/z20dVrOrdhlPzObjFslwMiQAbNSgzSFiuZfBLc5
 cOYQfv7YzO7sXctjbMobzPhLqdvFvBpn4P98zoIX2WX0VW+5hmqBf0Fxs+5xO59B41SN
 CmWw==
X-Gm-Message-State: AOJu0Yzqtt+e94ROu8aZYw7FsVlLabmiXsNioDlgutm1HguUciXXDbzt
 Pc0oEX8OIPxm3qjsS+XqhT40xzSFHpGCEq6l+nDtyQwmVC/zFg==
X-Google-Smtp-Source: AGHT+IGG8C+T/3NcTdNFKgJ6s9LABnsFHEXewcnBuLMQUfdf2gVniQ+Midip4jbE/kPeOWn1xdFUgw==
X-Received: by 2002:a17:903:260e:b0:1d5:9b12:fd52 with SMTP id
 jd14-20020a170903260e00b001d59b12fd52mr905120plb.83.1705068139559; 
 Fri, 12 Jan 2024 06:02:19 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a1709028c8500b001cf6453b237sm3116927plo.236.2024.01.12.06.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 06:02:19 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PATCH v5 3/8] target/riscv: move 'cbop_blocksize' to
 riscv_cpu_properties[]
Date: Fri, 12 Jan 2024 11:01:56 -0300
Message-ID: <20240112140201.127083-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140201.127083-1-dbarboza@ventanamicro.com>
References: <20240112140201.127083-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Do the same we did with 'cbom_blocksize' in the previous patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 target/riscv/cpu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0391f16e28..8976dc26a3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1322,6 +1322,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.vlen = 128;
     cpu->cfg.elen = 64;
     cpu->cfg.cbom_blocksize = 64;
+    cpu->cfg.cbop_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
 }
 
@@ -1908,8 +1909,42 @@ static const PropertyInfo prop_cbom_blksize = {
     .set = prop_cbom_blksize_set,
 };
 
+static void prop_cbop_blksize_set(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint16_t value;
+
+    if (!visit_type_uint16(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value != cpu->cfg.cbop_blocksize && riscv_cpu_is_vendor(obj)) {
+        cpu_set_prop_err(cpu, name, errp);
+        error_append_hint(errp, "Current '%s' val: %u\n",
+                          name, cpu->cfg.cbop_blocksize);
+        return;
+    }
+
+    cpu_option_add_user_setting(name, value);
+    cpu->cfg.cbop_blocksize = value;
+}
+
+static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    uint16_t value = RISCV_CPU(obj)->cfg.cbop_blocksize;
+
+    visit_type_uint16(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_cbop_blksize = {
+    .name = "cbop_blocksize",
+    .get = prop_cbop_blksize_get,
+    .set = prop_cbop_blksize_set,
+};
+
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
@@ -1998,6 +2033,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "elen", .info = &prop_elen},
 
     {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
+    {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
-- 
2.43.0


