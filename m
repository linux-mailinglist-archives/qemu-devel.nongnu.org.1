Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D78165F9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 06:17:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF5zS-0007ML-4A; Mon, 18 Dec 2023 00:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5zD-0007IZ-GE
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:15 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5zB-0003Ok-EK
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:15 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cd68a0de49so1972200a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 21:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702876570; x=1703481370;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SzIUgJAyJY5dDdCff8SpfRi3ccAVPKM0UnEn1OD8uzo=;
 b=yV0SVFGsB0/L3R4aV82EF5umEHGzHuuhlF+f7EDxE2zzI7a7jfpGmSuLFkdtKGrpr4
 RogTvho6RUzuOaQGQ78tkii4mKufenoRcvV1MAFaFMP4WF9VkS/DpslHT8NXWhGR2Jhj
 UgohCt267tQtSCrn9bNyHXBhABPvFpZfL2s/IRvOBurhaEaMOn7PsIoeCfvKLp20eN9Z
 8VCn93z/lbdEd2MovtSSl2u0OM4f8pEVYTcwhkivaG0SyT73g0zsHEZIiBACRUn9yjRk
 l4Q34+CA2QjFMFi6mfy+MxH9Gmjp2FOth36xQcVCHjDOd+/y+gMWfkd/rEg7/fMgGgJ9
 IcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702876570; x=1703481370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzIUgJAyJY5dDdCff8SpfRi3ccAVPKM0UnEn1OD8uzo=;
 b=uQIlu0apG/fFrC6JVFQxD/BFWVy2uphXajNUKLteUiaQfzb5GYh7SUaN3ca7jJeMpa
 pLvysKjOclT8je3uhKnY6Wz32NH02JuwZPK2Wu20L/2kI79kkJxUCicwIAXL3aSTXTx1
 VWUehrET6YhpE8JwQx2p6NVODmofH2mQnMtUx9R3du2K1jH/Su9oGTqlwedNyC0xCbzX
 8jvr+IBeyLp1DciKGt8+teV+rfRLp01ePtUN6w2Q9YT65COdij6IHj2adZcL9LFVhH9P
 XQj2d0wNqr8PU9zJFao4/Z7DYA4DxW+uhI+2LOBFHTHIq+yJcV3E5+uHQGdkd4jd+TbM
 goDw==
X-Gm-Message-State: AOJu0YymgbpXV6DXz9VE7ohsy3HlYM1D//g3ImkzPAWFWrx6QwvY7Tev
 yVXjfWb7vNejLx3Oifjcy47OEg==
X-Google-Smtp-Source: AGHT+IFPNgx1+KMCrnIrNmV8Bt04zNivjl9jm4bfAwzepEaIFKkUA1581a5ywZIJC842//0SbCTVrA==
X-Received: by 2002:a05:6a20:12c9:b0:187:df72:48ef with SMTP id
 v9-20020a056a2012c900b00187df7248efmr19860609pzg.0.1702876570252; 
 Sun, 17 Dec 2023 21:16:10 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q19-20020a056a0002b300b006ce91d27c72sm1082145pfs.175.2023.12.17.21.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 21:16:09 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Dec 2023 14:15:48 +0900
Subject: [PATCH v8 2/4] target/riscv: Remove misa_mxl validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-riscv-v8-2-c9bf2b1582d7@daynix.com>
References: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
In-Reply-To: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8a35683a345d..ee17f65afb60 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -148,7 +148,7 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
@@ -168,11 +168,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (env->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 static void riscv_cpu_validate_priv_spec(RISCVCPU *cpu, Error **errp)
@@ -673,7 +668,6 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    Error *local_err = NULL;
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -682,14 +676,11 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
+    Error *local_err = NULL;
 
     CPU(cs)->tcg_cflags |= CF_PCREL;
 

-- 
2.43.0


