Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1B78881A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWZ9-0001gO-Qo; Fri, 25 Aug 2023 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWZ2-0001dO-Q3
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:25 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZWYx-0006wZ-GP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:09:22 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bd066b0fd4so643242a34.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692968957; x=1693573757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbN4siE2H2yrfE3iooAE8wv0gBJLwPSaFaB4bOfc9S4=;
 b=RWyH3AnF/8van0M0KlHiMQi+OX2ttKIfDyyvNzRvyz5TXMyzmfPv+3ipIctn3pNpzW
 UKUJB6iaYnsNbYY+AcSHfxngkuXv2aVDxkNbM6TXX3hX3AXZXWdMicIWh8St/wAl1i2U
 i8bwL3O75sk6vM2Aw1Ui5k1nkD7kdMsc87e3i41hNxfX42lECyrxOZcquR06yJs59Y4d
 E7Cnhlyt3naYrVvul2OY2ZxQHb9mNUn3MBuwt+2ha+Iv2NR+sGU1XZR9MEq3+tVVld4n
 bFSCr1r2ILAzaEQvvlxbcVnUuTDT+b6N/3+soy6uKpDCJ/hIIalv8LXsoK4k/ioLW3kQ
 9XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968957; x=1693573757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbN4siE2H2yrfE3iooAE8wv0gBJLwPSaFaB4bOfc9S4=;
 b=dxN6kayEXXM7am7nFTdh5RF2e8JLrLLYxYVNDVsA/C/+3u2RpOyOW5HY3cAP9F9RPx
 EN/UzIujJDw8OvMs3QCeWfbcmLkbW7yXDYpY+ivnjCIAnviuDSz5uQw6gtsbkkH3H7vX
 VIg9beQ0F+csMKZj9jCRSf9JAvUI7oUgMb695OpIqKBtaQ4cSi4HOnp7Pchz3TrhWAyw
 l0OaK6Y8rlkGeDZL0333pcTVRzSvOiUxZynVzLJvwVGSa1saslXWFHMO785+RJz8Yfpo
 ODwTMYKlcMG9xWEwo6+TbOPbgqKtTxkUyzGtSnxDSFTBA0s4FYoobBWIVlgazkDE6mCi
 bx6A==
X-Gm-Message-State: AOJu0YwRLX7nd7P13E9ZSPnpEdGEjjSIr66oITVqyew0j2KxxkfX4NEK
 iIV52+FpQe8S04wu3UrpIyNkJo6S/oloR1QdNx4=
X-Google-Smtp-Source: AGHT+IHf2L8YZV0pZk0lOa90K8sOYBZB5XDbyY52npfN5DNgKhMCBC+qoEn7KgkQQIHvlzG9Y+NLvA==
X-Received: by 2002:a05:6870:211:b0:1bf:11f1:4729 with SMTP id
 j17-20020a056870021100b001bf11f14729mr2802494oad.56.1692968957693; 
 Fri, 25 Aug 2023 06:09:17 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 ds23-20020a0568705b1700b001c50fb56845sm966189oab.16.2023.08.25.06.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 06:09:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 06/20] target/riscv: add 'max_features' CPU flag
Date: Fri, 25 Aug 2023 10:08:39 -0300
Message-ID: <20230825130853.511782-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825130853.511782-1-dbarboza@ventanamicro.com>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32d.google.com
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

The 'max' CPU type is being configured during init() time by enabling
all relevant extensions.

Instead of checking for 'max' CPU to enable all extensions, add a new
CPU cfg flag 'max_features' that can be used by any CPU during its
cpu_init() function. We'll check for it during post_init() time to
decide whether we should enable the maximum amount of features in the
current CPU instance.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e2e8724dc2..c35d58c64b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -424,6 +424,8 @@ static void riscv_max_cpu_init(Object *obj)
     CPURISCVState *env = &cpu->env;
     RISCVMXL mlx = MXL_RV64;
 
+    cpu->cfg.max_features = true;
+
 #ifdef TARGET_RISCV32
     mlx = MXL_RV32;
 #endif
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 0e6a0f245c..df723e697b 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -137,6 +137,7 @@ struct RISCVCPUConfig {
     bool epmp;
     bool debug;
     bool misa_w;
+    bool max_features;
 
     bool short_isa_string;
 
-- 
2.41.0


