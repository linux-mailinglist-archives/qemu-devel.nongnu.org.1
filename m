Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6973A279
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:00:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKos-0007kO-Oo; Thu, 22 Jun 2023 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoj-0007b9-8m
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:49 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoe-0001JH-8l
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:45 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-560c957ca46so604758eaf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442250; x=1690034250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=G0Bth+z9y35XZW404Kr1D4A/PEmkcrnBSka2zmHD2vUJY10sw5Y+3KgvHSw3/rAUvp
 DEo5xKWL+1IQpbkr2Q2YUJ/aDDLqvNvnB6z3atumK0zPXal0agTJQW9vkW1Evc6ri6uS
 SxkSsy4W194+NHCzz6Ubvh9aH2vcRfVeNMAThNPVcytfga6NLj6QngbUWlOwnSRLbL+k
 RJR3rOWAkL9GluPIluZXBFVZYGd/jsTTMaed/EbPkVzO3SL9ANODJri/8G8ukr4Bchg1
 FavgCQmFhNG+XoZYUpd4Sup4L85gzC4yDR3mqlQ2ldBPeCSX0UiqWWHKN2FyH87VHHk+
 Xijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442250; x=1690034250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=b5BfZxYGiQk7IwKw/IlYVGBwDnLb+NlstQKBik624p149hzxGAng1d7ClWjM8zQqQ7
 /u0cZgd0RuvUrAivfsFVrFnDaHvPfNm1CJ07Yqr2iZ1iiO6CZ9I8Tdxa+h75GkhLfUKz
 aJYkDCmKf3r27nrmcRQE94WCFCojsw6KGFtTXYlO9TtDaKqfxVDI0kMpgzwEW2Nzis7x
 0vZVDVCvatGaD3U6pFmxEpPQ00Sr1oGs/XbHG0MXbTqBIRVlKboJPwhliyHts8NoIf98
 guDgMmyJSA/WRXb/UocFQ1mW6Iij4NNjtma7IwkmR6+3M+1pZuk9O94eLS4JpbC3+0Zy
 WnmA==
X-Gm-Message-State: AC+VfDwxtFVWxdSHwuHrhNnZhhO2m+nOjxYk6MTRA1RkWMhOU7KreLFB
 exYQiFyHgJxQ0tyJWeE9hBJ7pY9xLkVx4esPC44=
X-Google-Smtp-Source: ACHHUZ69W4RiukDAvbXFKNQndL1lH8sTvA5n0XR+bMb0+xjqec3Ae5hwigQm2VIGVDtU5D4s89OWpw==
X-Received: by 2002:a4a:bb96:0:b0:558:a990:3ab0 with SMTP id
 h22-20020a4abb96000000b00558a9903ab0mr13311275oop.7.1687442249882; 
 Thu, 22 Jun 2023 06:57:29 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:57:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 07/19] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Thu, 22 Jun 2023 10:56:48 -0300
Message-ID: <20230622135700.105383-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
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

Allow 'marchid' and 'mimpid' to also be initialized in
kvm_riscv_init_machine_ids().

After this change, the handling of mvendorid/marchid/mimpid for the
'host' CPU type will be equal to what we already have for TCG named
CPUs, i.e. the user is not able to set these values to a different val
than the one that is already preset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 37f0f70794..cd2974c663 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -378,6 +378,22 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.addr = (uint64_t)&cpu->cfg.marchid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve marchid from host, error %d", ret);
+    }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.addr = (uint64_t)&cpu->cfg.mimpid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve mimpid from host, error %d", ret);
+    }
 }
 
 void kvm_riscv_init_user_properties(Object *cpu_obj)
-- 
2.41.0


