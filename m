Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E67C63E1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3Z-0001vX-QU; Thu, 12 Oct 2023 00:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3W-0001s6-EQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3U-0002Od-N9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-690ce3c55f1so444692b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083931; x=1697688731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z47sWAtpGCBtyowL2ewdhCX8WCdqMsD9Ujvrjykd7zc=;
 b=Lbjh07gT48Uurq2QeJVUyA1c6eKF8IaoL1wTPuorSj1V2nOVgvfM4w4kLs0XQNo/pO
 cPelX0Irk/lNRAFLcM/4hJ5EUC8nVh2gdFIfRAOV99LNInRjOmm1zK93Ahu462NEQntJ
 f+A7SFcuIkWQIDzWJAhuCxwxnLOSqT1X3A3fgYCDqsQStpiHZfbrmnh/L2WKrHMoO0Q8
 hxZ4PznpQNVTwNf6yzFizbyWxDX+mI+oWu01thESMh3u4NaLWM91Bh3/rY0Vq1lWWD9H
 NF5Z8NjT+TwnavnBppiKGQ8B4zAarBEruIaA8OWtcvtuwWXnm61/fz+SdGaVWh7ZJxvg
 kwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083931; x=1697688731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z47sWAtpGCBtyowL2ewdhCX8WCdqMsD9Ujvrjykd7zc=;
 b=HtlmNZ+luS+arfypGNjK1PCn4jSh6PN/tYCZO+fJlA5rw5X/NoJ9mjhWVN8/5mOJRP
 VmcFMFyke9jIa0lNXjouXEjNoamdqo3v2Caiq+xnjXlSvcGvw41DHWXViSnw5hzMJtJt
 s2FyT1d+P2Bd/6R+77UWeP34y9cphvPFVnQi4J4o4UaaNTmZ+h6YJ6qOPic4wOa34cbV
 TNLlWAPX+GeLRF7eH2oLJaBpldDSDOHvNugb6AzXG829X77BM+7sJfwmYXQ7e8E+uJ0z
 aA9J9MTjzXlj9iVvra2+2Df2dMKUG+aBhLBliCQSWZJHQ032hHsUtqnmkZ1W/SL+vENm
 w3Cg==
X-Gm-Message-State: AOJu0YwzHqzpoeXxwPPPx6+bfbzBGDOf1xRBZUlmwQ8M1NoHwFGY0TzL
 zJqtiFI1MrKD4imrpOWt3iqNbeIlTSjVgw==
X-Google-Smtp-Source: AGHT+IHDrfAG6HL5j3yaURa9nWJPVdUzbTgnjP0D6FEh4v1sIJs1ZofF1M+LfxoLYWTLo1PiIpmaUg==
X-Received: by 2002:a05:6a21:181:b0:165:186:1560 with SMTP id
 le1-20020a056a21018100b0016501861560mr26617923pzb.53.1697083930936; 
 Wed, 11 Oct 2023 21:12:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 19/54] target/riscv/cpu.c: honor user choice in
 cpu_cfg_ext_auto_update()
Date: Thu, 12 Oct 2023 14:10:16 +1000
Message-ID: <20231012041051.2572507-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

Add a new cpu_cfg_ext_is_user_set() helper to check if an extension was
set by the user in the command line. Use it inside
cpu_cfg_ext_auto_update() to verify if the user set a certain extension
and, if that's the case, do not change its value.

This will make us honor user choice instead of overwriting the values.
Users will then be informed whether they're using an incompatible set of
extensions instead of QEMU setting a magic value that works.

The reason why we're not implementing user choice for MISA extensions
right now is because, today, we do not silently change any MISA bit
during realize() time (we do warn when enabling bits if RVG is enabled).
We do that - a lot - with multi-letter extensions though, so we're
handling the most immediate concern first.

After this patch, we'll now error out if the user explicitly set 'zce' to true
and 'zca' to false:

$ ./build/qemu-system-riscv64 -M virt -cpu rv64,zce=true,zca=false -nographic
qemu-system-riscv64: Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca extension

This didn't happen before because we were enabling 'zca' if 'zce' was enabled
regardless if the user set 'zca' to false.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-20-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 821006f42a..d1a3ddadd0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -195,6 +195,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
     g_assert_not_reached();
 }
 
+static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
+{
+    return g_hash_table_contains(multi_ext_user_opts,
+                                 GUINT_TO_POINTER(ext_offset));
+}
+
 static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
                                     bool value)
 {
@@ -206,6 +212,10 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
         return;
     }
 
+    if (cpu_cfg_ext_is_user_set(ext_offset)) {
+        return;
+    }
+
     if (value && env->priv_ver != PRIV_VERSION_LATEST) {
         /* Do not enable it if priv_ver is older than min_version */
         min_version = cpu_cfg_ext_get_min_version(ext_offset);
@@ -1843,6 +1853,12 @@ static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
     MISA_CFG(RVG, false),
 };
 
+/*
+ * We do not support user choice tracking for MISA
+ * extensions yet because, so far, we do not silently
+ * change MISA bits during realize() (RVG enables MISA
+ * bits but the user is warned about it).
+ */
 static void riscv_cpu_add_misa_properties(Object *cpu_obj)
 {
     int i;
-- 
2.41.0


