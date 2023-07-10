Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C474D5B1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq63-0004Zb-BR; Mon, 10 Jul 2023 08:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5m-0003wG-1I
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5k-0004q6-Cl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so2206951b3a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992451; x=1691584451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJrzog4DRDfBytRlBHQNkwkXryFnPbhrx8SsbgPyQw0=;
 b=jvvbsT4a4xJvF4V6EuA+loUkzl5h+Jg4vP2/2I8yfXqWMRhtRQii73FKUQcz+pqUIt
 aQnIasW0xE0dAqAe5V7h8Rgg794FOQk+OM6D2u1e12Qq1InopG3kEbgrWntCUPiUDTwn
 cclP/68T24dRrwkKdr8kV+ChsuePEt8cIzlgs6ahClZTFw1dm6mvhM5sgbQO41Katc7J
 KkgnsHk7B5AqkRHSRiJ9LzB/Ys809ZtPkClB5CeRJFJZ3Eo4jA3VfKJCNIej84HVEvER
 1k4whys4LCfxhG32wcbr7bMaCZTUAiNwgzsOfKA+6jeYEFs69qWVvlvN0jjFH3YQa5Ca
 QBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992451; x=1691584451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJrzog4DRDfBytRlBHQNkwkXryFnPbhrx8SsbgPyQw0=;
 b=esEkMPdZvpP5c+FguPB4dbr6SHdUQRlJJteSXrG5J1GqD9ivp76KyPysjEyi8Oghgw
 8NfIEqzW8QR2C0vnRaDHWY0ydm0XrguxUAmW+vwyHySmghFovuu2R12d8Zr+AouiC5Kg
 +N/9luixDZ0pUqE3dmWO8lveFfBrlUvboE7WhRkGYjblNGGaGfsz1GQptby9HYrMnJX8
 xlu9mnBwnWeGiJhfMqx/uwWnbw88fI10hc6qJh9+fp+/73T7Pa/2mfamtee6dR8/JPz2
 vR73pkfgYibFPBdfvX1Co0RuZ1OdvSjw9K/MUid52ATkXUT/1xenaC5TKwn4YCbVTLmg
 aHyQ==
X-Gm-Message-State: ABy/qLacdGVxxGnwwdGbEw48BSy+eZH0ENRHZKC8jvdm1pA5hNb2TQYZ
 zvIDxVcslSzJBs6GISb5clnM0xVzCjKUAg==
X-Google-Smtp-Source: APBJJlEtZcmNS12xiLT+qzcSU/BlpgtP8DgY4RvjR6w95kjFKNjFW0mx0SAshSg9MpmMfpIh4QQB7w==
X-Received: by 2002:a05:6a20:6a0f:b0:12e:5fd0:f4af with SMTP id
 p15-20020a056a206a0f00b0012e5fd0f4afmr11944435pzk.28.1688992450719; 
 Mon, 10 Jul 2023 05:34:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "yang.zhang" <yang.zhang@hexintek.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 32/54] target/riscv KVM_RISCV_SET_TIMER macro is not configured
 correctly
Date: Mon, 10 Jul 2023 22:31:43 +1000
Message-Id: <20230710123205.2441106-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: "yang.zhang" <yang.zhang@hexintek.com>

Should set/get riscv all reg timer,i.e, time/compare/frequency/state.

Signed-off-by: Yang Zhang <yang.zhang@hexintek.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1688
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230707032306.4606-1-gaoshanliukou@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f932a5b96..c3976a588d 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -99,7 +99,7 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 
 #define KVM_RISCV_SET_TIMER(cs, env, name, reg) \
     do { \
-        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, time), &reg); \
+        int ret = kvm_set_one_reg(cs, RISCV_TIMER_REG(env, name), &reg); \
         if (ret) { \
             abort(); \
         } \
-- 
2.40.1


