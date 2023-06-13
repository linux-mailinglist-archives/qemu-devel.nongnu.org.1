Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB46372ED87
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B7p-0002Uq-Hm; Tue, 13 Jun 2023 17:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B7Z-0002Jk-Pw
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 17:00:10 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B7X-00071i-IO
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 17:00:09 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-39c7f7a66abso3317319b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686690006; x=1689282006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0U/9VUYOqkOwDSfCUTSeHKJW94lpdunrJEDcr8kuBY=;
 b=KfnerICI1kpskFBIbjEji0xNAFXe2nZBoAamvQtwxZAGMnfxMYa7aCRT3nTCR/J/dA
 5qklBjYYfQfVzvw1jRrJAoSypz/BSldMCnJqtrPxRviyX7zTBJY9SO5za3kGhtWMizdN
 lAhqPsmc8XTrL5qRBX8lUVrhFcWPiEDN3vuT7by7gF+riH5LR2A2D/nJV6sipZk1X7Za
 QNeU8MWb+CsYO7LtIYLcuLgus66/653VMMj1rQ9mf8gVSvChSbrA2inZ9u5lu+RfMISk
 JE6blGYH2uCm9KRq++CqFmP5TSQhyFlQ7O0VD+RkQ/5z1LyGW86s2ucXFgSqP2oxjv0j
 ZlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686690006; x=1689282006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0U/9VUYOqkOwDSfCUTSeHKJW94lpdunrJEDcr8kuBY=;
 b=Mb9NlIRz3+6qfQzAAlj+7d0ODUVAhA0A2p4lNkgG0t3DqwGFucY2cR9PMLbewocUKw
 yqUfX30KLw9oDwMxaK6ckncKaUdbgcT/EyZ0c3qo8rotzbno3sFxa7SauNejca9y7Gv4
 mLj/Sc1ZyhPXkMd8F4+HhtArTazHXCbd5x10vVPJTFpMAy75hslegXmmhEyJeHKurGxB
 CTsgBG/nfhWplg4C9UoffvsHRwA5JPy43aZms0t6VAAiHqIrwP3R9x2wWeeLjH3r1TyJ
 J4ylY7BwpiE8V8TnC93YKPSKXrqEGp6wCPLFE92nALuw4HY6BK44UHRXzMzk04tfHv7h
 lJKw==
X-Gm-Message-State: AC+VfDw2pXwBCQV2HwHnG5SG5lJZFLON4tZ0i3hDW7SkUyCDiIy6p11h
 xS8Z7My3ss/19s5Ono2gf3k9R/rB1h+rjUQSVIk=
X-Google-Smtp-Source: ACHHUZ6AszZlRuAody4/NGFueRXKjrmTb3VdUxGyYFDFoMonfbsn6EHMAn6ci5Ts1MsAKkwPnObcPQ==
X-Received: by 2002:a05:6808:220c:b0:39a:98bc:10e8 with SMTP id
 bd12-20020a056808220c00b0039a98bc10e8mr5322684oib.28.1686690006320; 
 Tue, 13 Jun 2023 14:00:06 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.14.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 14:00:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 17/18] target/riscv/kvm.c: add kvmconfig_get_cfg_addr()
 helper
Date: Tue, 13 Jun 2023 17:58:56 -0300
Message-Id: <20230613205857.495165-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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

There are 2 places in which we need to get a pointer to a certain
property of the cpu->cfg struct based on property offset. Next patch
will add a couple more.

Create a helper to avoid repeating this code over and over.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0b6dff70de..3a9f7b0722 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -222,11 +222,15 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
 };
 
+static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
+{
+    return (void *)&cpu->cfg + kvmcfg->offset;
+}
+
 static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
                             uint32_t val)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     *ext_enabled = val;
 }
@@ -234,8 +238,7 @@ static void kvm_cpu_cfg_set(RISCVCPU *cpu, KVMCPUConfig *multi_ext,
 static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
                                 KVMCPUConfig *multi_ext)
 {
-    int cpu_cfg_offset = multi_ext->offset;
-    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
+    bool *ext_enabled = kvmconfig_get_cfg_addr(cpu, multi_ext);
 
     return *ext_enabled;
 }
-- 
2.40.1


