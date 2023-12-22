Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03681C9E1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGeYG-0001We-J3; Fri, 22 Dec 2023 07:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYE-0001Vh-6q
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:50 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rGeYC-0005nB-EB
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:22:49 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5cd68a0de49so1308340a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703247767; x=1703852567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHLPmiheEOnodk4jIREyWq0iPo/tsfjG5BHc9yunH9g=;
 b=Hx5PtxsxUduIwSvTHPZZC1+WKziOVjbg8YxLL8CeOzV6Ni8FG+GakKpPKvt6dvsGF7
 snYSQo/IMz9k7M1iBep+Bw15VeyiC05935a6gSYF4rhTHM1gMVPrJMnEak7QHbGR7T1w
 wvUvCTpoCmMPclTxyHHxQjTYN0B1daK36JvvFeFZcoj7UF4b6zo4WLLpotdXMlveihUR
 U8/qmqM5XkJhymKn37gctFfMLA6AeG8sB5c09EiiygfEsRSibdZ4VMLyQo6d+TkZdAg0
 UAubV89OnXnNcfOeSK5dJuGGed1aEPfNKofRsgIVeTwXfJlJWS07R0H16zRjm9S4ZP2E
 aAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703247767; x=1703852567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHLPmiheEOnodk4jIREyWq0iPo/tsfjG5BHc9yunH9g=;
 b=YlgON8tnrKInG+43F7PyW0i+5mIxqg2iOaasQbYlu1RzFUObDXyxvrN+h9RZDPXdOd
 KSFktxsFzgUJzjtJ7TkR7yhq0hnlSCA0b5rs4Cok3k/NbQXPsreNBsN0N4NfLaaIt4ay
 F+rFhFoMlzM/sx2LeHzBC5zyJpZpLhgOVMBBtlcxCjZXrKq16lIwxlBfLQAUpyh4JpkY
 /ZwfW7N4M6cJf1gUkjnqBBpEnm8jeJ/bIwbEz/u8dSUD5RpyRJ3J2SkVc7VQi9Aah51G
 W/YiVEqSD5kPz87Kr8W60EedVrpc7B8mBgAv8hO93dIPc20h3AnuSGg4jwIukeJGtPhA
 zGbg==
X-Gm-Message-State: AOJu0Yx4exiWOdgfq3WlzNB+gDynytkLYnb1Lv4GeWbNkCzStx/DxuhX
 GGiotsa9+MlKEsH0NIwYIoMSATbGfFmhyl8kv3o/bKDUYLfx4g==
X-Google-Smtp-Source: AGHT+IH/2maknFZ9G6JVhIXRR0d0X5WENMCJMhAuteI0XYsk+pGRXCGfkfXcLZ/8Y2XLnBrw1GETbA==
X-Received: by 2002:a05:6a20:430e:b0:191:60f5:2a9 with SMTP id
 h14-20020a056a20430e00b0019160f502a9mr1363508pzk.80.1703247766821; 
 Fri, 22 Dec 2023 04:22:46 -0800 (PST)
Received: from grind.dc1.ventanamicro.com (201-69-66-51.dial-up.telesp.net.br.
 [201.69.66.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020aa7874e000000b006ce7ad8c14esm3274901pfo.164.2023.12.22.04.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:22:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 02/16] target/riscv: move 'pmu-mask' and 'pmu-num' to
 riscv_cpu_properties[]
Date: Fri, 22 Dec 2023 09:22:21 -0300
Message-ID: <20231222122235.545235-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222122235.545235-1-dbarboza@ventanamicro.com>
References: <20231222122235.545235-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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

Every property in riscv_cpu_options[] will be migrated to
riscv_cpu_properties[]. This will make their default values init
earlier, allowing cpu_init() functions to overwrite them. We'll also
implement common getters and setters that both accelerators will use,
allowing them to share validations that TCG is doing.

For pmu-mask and pmu-num it's just a matter of migrating the properties
from one array to the other. While we're at it, add a 'static' modifier
to 'prop_pmu_num' since we're not exporting it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 70bf10aa7c..34f7616258 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1457,16 +1457,13 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint8(v, name, &pmu_num, errp);
 }
 
-const PropertyInfo prop_pmu_num = {
+static const PropertyInfo prop_pmu_num = {
     .name = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
 };
 
 Property riscv_cpu_options[] = {
-    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask, MAKE_64BIT_MASK(3, 16)),
-    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
-
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
 
@@ -1485,6 +1482,10 @@ Property riscv_cpu_options[] = {
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
+    DEFINE_PROP_UINT32("pmu-mask", RISCVCPU, cfg.pmu_mask,
+                       MAKE_64BIT_MASK(3, 16)),
+    {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
+
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
 #endif
-- 
2.43.0


