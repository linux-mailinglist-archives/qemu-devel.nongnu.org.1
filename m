Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D97CF4CF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPzZ-0005oE-Jb; Thu, 19 Oct 2023 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzS-0005ll-Ge
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:55 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzQ-0007uX-Eg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:54 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-58e119bb28eso459848a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697710250; x=1698315050;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVW58tyZ2tLjevyOdJr7NfNjanDDydhO/lJcVmLZzKs=;
 b=vQeaWBri3OSDbY/ZDzeyX5NaCGOE+spCBlohR8T+axy7UeeYE80p2xPujhnYEodisx
 q/p0kyylH8e5lv4ihQy42hZFaQeOo7C9eO7vvcTLZjvnfaa+A0NGBmoPM8xU2TW9Wx5A
 tMmoXtWImaXpVOBZttBBq8ZBnl+xZKUDVbKyRmDJRgBkzNGFGILPtibWK2Em8I8GNVLe
 +OiBgRouUTxVD/Ho0gbM18cQ64Ox6I2u64n9R/kw5aCw3vzJ8h7Ps5tiJErGCejrRuoS
 9DJ7+apvCHYz8f7fCL83QbGc1pgETh7MJIqVH/W8WXwQWhyYEBkIAtZ3huApJXauMeLc
 dHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710250; x=1698315050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVW58tyZ2tLjevyOdJr7NfNjanDDydhO/lJcVmLZzKs=;
 b=VPKnOII4PxbzZ6K7br37rNq3/lVuEHO/VgJXQOAbQ+JIE3b37xlwh2xVCdsOHUBdZa
 uWZD7LXg1wh7pPWYlSzueh3+4tV515JSYiEfGtu1cCe/K45K3JYEuytdpXKUOYFRNDDv
 HnCSK/izgWdyiAOddoVLtESCF0joJH3wgLuPcUTynwHpl2YWyMUxE6o16MJe3WDTaX0N
 G5uzlWuvbDTpBvZS+MuUxCXQ/ZUhy6lh9AgRyEiGZq1J0DmXkPUm6qts3qqyTexnwMUd
 MFwJGeuFKH2PxQ1eKrniYXYIVF4Y7asvQmMYHwJ2vjeLUhxaREHYXMDcF4ZNlFe/joww
 v/sA==
X-Gm-Message-State: AOJu0YxE/HhJ+x0kkJwyvSdVofYYxRvtmV/RErUK1fM1HtYnAFsQqXNB
 qboVOeDtP/5+GY4dp6vIVNzTVQ==
X-Google-Smtp-Source: AGHT+IFb6p+8GcORGqX/okkwBUW3uRFzuDGFjz8mPdogaiWAycD5zw1wMuxgIQwNkqpxS7+LsbQwxg==
X-Received: by 2002:a17:90b:3ec7:b0:27d:5568:e867 with SMTP id
 rm7-20020a17090b3ec700b0027d5568e867mr2290710pjb.9.1697710250636; 
 Thu, 19 Oct 2023 03:10:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 15-20020a17090a018f00b0027782f611d1sm1407198pjc.36.2023.10.19.03.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:10:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 3/6] target/riscv: Remove misa_mxl validation
Date: Thu, 19 Oct 2023 19:10:25 +0900
Message-ID: <20231019101030.128431-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019101030.128431-1-akihiko.odaki@daynix.com>
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
---
 target/riscv/tcg/tcg-cpu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a28918ab30..7f45e42000 100644
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
@@ -573,11 +568,7 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return false;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
     riscv_cpu_validate_priv_spec(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.42.0


