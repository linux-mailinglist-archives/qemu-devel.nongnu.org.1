Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF286756F2B
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLWBE-0004vC-6s; Mon, 17 Jul 2023 17:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAp-0004pl-2J
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:31 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAm-00041T-Vh
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:30 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b9c57c4d12so1894679a34.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689630867; x=1692222867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5SaD2PTMYSPCHIXcw0EhBnuOJRrw/MP6RH7vYO28R0=;
 b=NPzv5VSNSpUObmAJMySjxUxL3DZ9AjPT9Se4q/hFJzaOBoo3C4IsiawsK7s9aVy4ss
 F+smNWPPC/j9U6m5xK8Isz+TM6AE3Ce9rV9SYEz5TvZs5YSqbixJ/HyuTdRa81fArV+q
 P5roabAJJmLVhqwyFpDEh+RNzS/igoKk0OaxLkHfQAiD15GwcpFOdGMUTDelgkprrvpK
 slLrCc+q9tOeFPArssQDRQiUiFq/9uOs4RDclJLpu67U3/Uh4cSHKJUEPYvBD6qiMEEk
 SY21vhZTxYfw7/HuEIfHOpA81+DOiQhhuSfa3TWPxHaLITztMIirD0rhxK2oaQvIAmq+
 8MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689630867; x=1692222867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5SaD2PTMYSPCHIXcw0EhBnuOJRrw/MP6RH7vYO28R0=;
 b=N9/h1U4cek6hRmXwN5Zj5+u29qEpD2+WxR7PwQ2xg6mejcloZZKGv+BckTYrzyb1du
 7lKhU/lHAjtXbjl2n44VHnawBRKOdjyjO8tHtm8AYcORJZ5wbBwe9sPbYn+b3U9EJ4mB
 z/stLMPbWosCUXM0f0KWVTGiD4OcMfgznnPXkoReTp3NODDjwUkbL0SWYTgXRuLPt1EC
 4ujOmbzdleYEZVwh4jEbQ6wswIVTfpCUMH+ICMgyv5x93VTNCdb0/ad252q5k9KMEsYw
 csAtW9bKBkO5ImTCtd9yszu85x6drNGkQu3WQXY3THm9oKw6buJAlTiawYmFwzTmeb8x
 YNBg==
X-Gm-Message-State: ABy/qLZwMp8EKBqkvwAzOr5c5vtCyNaHEaZYMDPiPLIpEfKlmjpl2K4o
 X91s7KGEPsnyNZacuAwFHbn+5L2giYWFz41O/sS4KQ==
X-Google-Smtp-Source: APBJJlHFAKeXAj168DkRkJnJqHSoYNa3Y5ynSHVqFKmSavj75xX5PqZ4oo566nGnnG5AEw+77iaiQA==
X-Received: by 2002:a05:6871:79f:b0:1b7:7439:c584 with SMTP id
 o31-20020a056871079f00b001b77439c584mr14136361oap.59.1689630866875; 
 Mon, 17 Jul 2023 14:54:26 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a056830008100b006b9848f8aa7sm322958oto.45.2023.07.17.14.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 14:54:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 1/2] target/riscv/cpu.c: add zicntr extension flag
Date: Mon, 17 Jul 2023 18:54:18 -0300
Message-ID: <20230717215419.124258-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717215419.124258-1-dbarboza@ventanamicro.com>
References: <20230717215419.124258-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
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

zicntr is the Base Counters and Timers extension described in chapter 12
of the unprivileged spec. It describes support for RDCYCLE, RDTIME and
RDINSTRET.

QEMU already implements it way before it was a discrete extension.
zicntr is part of the RVA22 profile, so let's add it to QEMU to make the
future profile implementation flag complete.

Given than it represents an already existing feature, default it to
'true'. Change the realize() time validation to disable it in case its
dependency (icsr) isn't present.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 11 +++++++++++
 target/riscv/cpu_cfg.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..7ec88659be 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -85,6 +85,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_icbom),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_icboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
+    ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_icntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
@@ -1291,6 +1292,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zksh = true;
     }
 
+    if (cpu->cfg.ext_icntr && !cpu->cfg.ext_icsr) {
+        cpu->cfg.ext_icntr = false;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
@@ -1778,6 +1783,12 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("svnapot", RISCVCPU, cfg.ext_svnapot, false),
     DEFINE_PROP_BOOL("svpbmt", RISCVCPU, cfg.ext_svpbmt, false),
 
+    /*
+     * Always default true - we'll disable it during
+     * realize() if needed.
+     */
+    DEFINE_PROP_BOOL("zicntr", RISCVCPU, cfg.ext_icntr, true),
+
     DEFINE_PROP_BOOL("zba", RISCVCPU, cfg.ext_zba, true),
     DEFINE_PROP_BOOL("zbb", RISCVCPU, cfg.ext_zbb, true),
     DEFINE_PROP_BOOL("zbc", RISCVCPU, cfg.ext_zbc, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2bd9510ba3..d36dc12b92 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -62,6 +62,7 @@ struct RISCVCPUConfig {
     bool ext_zksh;
     bool ext_zkt;
     bool ext_ifencei;
+    bool ext_icntr;
     bool ext_icsr;
     bool ext_icbom;
     bool ext_icboz;
-- 
2.41.0


