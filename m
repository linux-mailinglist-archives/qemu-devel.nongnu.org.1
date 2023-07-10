Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3762074D5D1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5i-0003Gz-69; Mon, 10 Jul 2023 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5Q-0002rs-EG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:54 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5M-0004kN-AC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:50 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3461163c0b6so23376425ab.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992426; x=1691584426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSx+g1rH7bCVKRE3cbJPyyNa8L9V4ae/gM9wV3yimZE=;
 b=PNKidNWjDc54F/qRDg3m3RKPc3yfI2w3pxw6NVI0xyC3pGBF2gsUtbkSuMc2jA/NYA
 7Qi74Qc43p4+Ysbt/KCB9GpZaGbaI//CMpmmzurs7/Xfw8Un/KJeZJQWqmxzWt/ssD6+
 P1mjLZdxS41n8Udpn7TkdIKAbS1G5AWiw+Swgk6G4B+3qaVbHsd7VzKnVoVa9IxjtPtg
 BE43y55ykzNtEJN8GDI/3XkzsYWpHs/aCWndWcnOUotAjj+33z7+8kNkTcTbriRseG7I
 n91ds2LYTeGq2K5/fFWeSMWT8pvszRnlX4K+2CoqzOymtE9EFL7U/f6UTMQ/pDjVshpq
 zzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992426; x=1691584426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSx+g1rH7bCVKRE3cbJPyyNa8L9V4ae/gM9wV3yimZE=;
 b=IApI9HG3ZCKw7e7luwEkKKXa7VhveV2bWizi5WzyN2Mjy14RTYVbnL7jlsS1l5rzSx
 SbL47emCb177KN+740POR0AtTZy+jCSVx2Tcxq/aWPVBjUQI4loxNRW02KGU6R7/qw41
 DgES2j9O+pFXOQeLeVPjtyHe9JodZzc0OvU3GhN3o34IYeyHYMxUk0+lHtBxeRB5BQNW
 0SW3Y7WcVz4CGzXYpD82+O35NGS9Bxhz9DqVmKmi+PQiXvVyy3cptrW0Q0q2tP4xxFPr
 lInllKaQV7yU7L9TFOMlpDuGkNsMg9rFRrn/oHF9N4S8//YUvBylWbW1sCZTp1ODpbhe
 iDUw==
X-Gm-Message-State: ABy/qLYYw4xy6R+nT24g6xcCjUrO1IBPJL/kC+TiG1bu6I53vn+K7P4K
 LuQLiYSIzC5/O3+dm+XZBzw3mVyBl+++sA==
X-Google-Smtp-Source: APBJJlGQhhCHZyQMIYIR5Z0ceRt5GCDKyd91NkjcruTWY0Dzi+VVpVlUpN15WN3wE9B+9eiv9xrpLA==
X-Received: by 2002:a92:4b08:0:b0:33b:dcbf:e711 with SMTP id
 m8-20020a924b08000000b0033bdcbfe711mr14303976ilg.8.1688992426360; 
 Mon, 10 Jul 2023 05:33:46 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/54] target/riscv: Add properties for BF16 extensions
Date: Mon, 10 Jul 2023 22:31:36 +1000
Message-Id: <20230710123205.2441106-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Add ext_zfbfmin/zvfbfmin/zvfbfwma properties.
Add require check for BF16 extensions.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230615063302.102409-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h |  3 +++
 target/riscv/cpu.c     | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 6b7e736bc2..e9ee39d7de 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -75,6 +75,7 @@ struct RISCVCPUConfig {
     bool ext_svpbmt;
     bool ext_zdinx;
     bool ext_zawrs;
+    bool ext_zfbfmin;
     bool ext_zfh;
     bool ext_zfhmin;
     bool ext_zfinx;
@@ -84,6 +85,8 @@ struct RISCVCPUConfig {
     bool ext_zve64f;
     bool ext_zve64d;
     bool ext_zmmul;
+    bool ext_zvfbfmin;
+    bool ext_zvfbfwma;
     bool ext_zvfh;
     bool ext_zvfhmin;
     bool ext_smaia;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0c9faf4633..0272b1d071 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1118,6 +1118,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zfbfmin && !riscv_has_ext(env, RVF)) {
+        error_setg(errp, "Zfbfmin extension depends on F extension");
+        return;
+    }
+
     if (riscv_has_ext(env, RVD) && !riscv_has_ext(env, RVF)) {
         error_setg(errp, "D extension requires F extension");
         return;
@@ -1168,6 +1173,21 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
+        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfbfmin extension depends on Zve32f extension");
+        return;
+    }
+
+    if (cpu->cfg.ext_zvfbfwma && !cpu->cfg.ext_zvfbfmin) {
+        error_setg(errp, "Zvfbfwma extension depends on Zvfbfmin extension");
+        return;
+    }
+
     /* Set the ISA extensions, checks should have happened above */
     if (cpu->cfg.ext_zhinx) {
         cpu->cfg.ext_zhinxmin = true;
-- 
2.40.1


