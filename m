Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 494FB7CCFE6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:13:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssJ2-0001f9-Fo; Tue, 17 Oct 2023 18:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssJ0-0001eA-2G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssIy-0002Xe-6Y
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so2794368b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697580766; x=1698185566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mz7t1eTY2QIkrHe4fc0zNZ5iKeKzZ2HJQpX/CMXgkQk=;
 b=XvRvS+eCHbNYaXxpYJ6HZNp2tKSBVjqbYSTDd0NJc+I8BjuAtSNHpujP3H3arwOC8c
 JalXo9mipCATeKGv7Q+ZC/QwVFLHjXxi8HvX/UWvKmhBZjpVBrc27FFEcmNBOvNeCAR0
 zuHgz6Wo2EvvN2JkSBOLpWc3KA3dR9P+NH9RTT4H3vJlcJdZdovyD+Aih2bWXxAqXR4l
 3uHhkCPykIt5FFqWyu0KbXtW9HYUouk+N1tfSyB3DCx/wJCLzVK0Rm3pa1Zc+sdpRrWu
 HISHON9k6xfSrE3iGjAtypRHnWk9AdyS6QVj8VDoUx7KVBTSDnVur3P82jLhryyJsi7E
 uMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697580766; x=1698185566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mz7t1eTY2QIkrHe4fc0zNZ5iKeKzZ2HJQpX/CMXgkQk=;
 b=KNrYDr1TKs+VsIaHicsaB5BHw2AxBk0f/Whpqi6sBn8wJ9V7hAMyu/yj6U49oe+Y8Y
 uw91/QE7PLa36p6udINLXGuomularkdSBmWaKV4RviH17m/Arl/v2838PcwSTHob3YvD
 MOpNkope7mRnjunh2FszMwWyDdeL2xo2alVn3WgKtyZYzNtxxsS9kJDSbvUjKaKq7Ojh
 DCxviatpLBcBTlIDbuQC/QY13/dh9aAx1zCoMssd1/EZtUm8zFEqVYbibyQ1KNeZlOCT
 y407JMXgFhNQjIY1SEkFX8MwpSbcJCb4OXuB8PSJQz23dGiR30iRzAFtUChHKKrj1fW+
 s14g==
X-Gm-Message-State: AOJu0YwLQJn6P4tmH1TCtpw1PWTopTCFnyJ/XPuOir/E8rGsAlYiwFLw
 QlI7uOekFJNVHBKyPj+h19Gj6U+4pop1Em0ptXg=
X-Google-Smtp-Source: AGHT+IEN53qaHlNU7pExZudWY85UGLBSioCvEDSs+hXFIb/i6+Gub0uAwNz8ZLCheXhZ986YVhMEeQ==
X-Received: by 2002:a05:6a00:98a:b0:6b5:608d:64e1 with SMTP id
 u10-20020a056a00098a00b006b5608d64e1mr3781575pfg.33.1697580766273; 
 Tue, 17 Oct 2023 15:12:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62d14d000000b006be077531aesm2011023pfl.220.2023.10.17.15.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 15:12:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 5/6] target/riscv/tcg: add ext_zihpm disable support
Date: Tue, 17 Oct 2023 19:12:25 -0300
Message-ID: <20231017221226.136764-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017221226.136764-1-dbarboza@ventanamicro.com>
References: <20231017221226.136764-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Disabling ext_zihpm does nothing at this moment. Add support to disable
the hpmcounter3-hpmcounter31 counters if the user disables zihpm.

There is already code in place in target/riscv/csr.c in all predicates
for these counters (ctr() and mctr()) that disables them if
cpu->cfg.pmu_num is zero. Thus, setting cpu->cfg.pmu_num to zero if
'zihpm=false' is enough to disable the extension.

Set cpu->pmu_avail_ctrs mask to zero as well since this is also checked
to verify if the counters exist.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a01b876621..7a4400e2ba 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -549,6 +549,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_zicntr = false;
     }
 
+    if (cpu->cfg.ext_zihpm && !cpu->cfg.ext_zicsr) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zihpm))) {
+            error_setg(errp, "zihpm requires zicsr");
+            return;
+        }
+        cpu->cfg.ext_zihpm = false;
+    }
+
+    if (!cpu->cfg.ext_zihpm) {
+        cpu->cfg.pmu_num = 0;
+        cpu->pmu_avail_ctrs = 0;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.41.0


