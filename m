Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C193A749946
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHM4Y-0006Aq-UY; Thu, 06 Jul 2023 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM4Q-0005nY-GV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:42 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHM4O-0007BP-U3
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:18:42 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b72329b63eso497379a34.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688638719; x=1691230719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtERhF/xfYQMjn+bEX8PIQ4lMIfhPOCNLObYIRjwmfo=;
 b=Xvo9Z7sLLXjXiA3kW5RQam6YOAB0d5csEgcqRTXEF+yeNNspLbneLWFqb8wabwY79d
 BnalB3nJ4a6kS+niZTCUrbEy554DHNFgN+b9hNUGVHIQ6Yy5zW3KpMrJGsUxK7tIHD+V
 UKb46EXlS0NKv0GJL9zRjkD6G4vhSkm7g1rgaUeLXH+SA23vG0rXqbIiOP8HCuiZyfL8
 9zML0bGdT6akYL0NyX+Y4VA1k10gbG1+tZwwlAH6fXaKwEGoa2KU3+XGbRedPhcJLwiE
 sKUB0p2lXquLHnxRrGiiAwC2JZNNYdBCa0iux36MoXgiK8V88GBa1nQga9hfTjOKAMLz
 jTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688638719; x=1691230719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtERhF/xfYQMjn+bEX8PIQ4lMIfhPOCNLObYIRjwmfo=;
 b=jkcLORIr47lksJMWYWxtLvcNqpbxoPzn4OcrFMdksBOADpUTNVVol1fJG7iOS7eqxe
 y4fLlhNZ0N/D7RC46D/w7Ryu9vL7YvBF2/GOEDpSwCAzdfbrMgvX3bqxtanjUtBw3dI7
 SMt+H32jiJdYB9/sDxcoDJLOJXz2TWPauhDud65WGA3k2O0A4rUmZyl9HJ2F4FYrIBW6
 iR6dOwSoTcXW9e+exVtbLojuNbJtsgAxAfdp3NjryO00VDsdZ93OhJqadonL8GXNN8/P
 c0K+4y1VhEwSDh+3QBxUyVM0duZH4sk+axfKomtvc2s5HtmKc/uqQBNp6u1bjAoYdff4
 0GZA==
X-Gm-Message-State: ABy/qLYDlLYdQlKXmNPvuFBEVrsIGZxJRBnsPoNt7Uoq0B88A1Q968Cz
 Sqz/S6/9gGDCG7mWPbpqA1aIdz2S+62AggJzmC4=
X-Google-Smtp-Source: APBJJlG2bme4Byg+0/yVDn7wiDlKyii+6s8ju1zO0zJqJg0KVZfe4Ipoci+ykRUv+aS21WwDRmk6yA==
X-Received: by 2002:a05:6870:e392:b0:1ad:34f5:559e with SMTP id
 x18-20020a056870e39200b001ad34f5559emr1909172oad.25.1688638719726; 
 Thu, 06 Jul 2023 03:18:39 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6a59000000b006b8850ad193sm511382otn.56.2023.07.06.03.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 03:18:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 15/20] target/riscv/cpu.c: add satp_mode properties earlier
Date: Thu,  6 Jul 2023 07:17:33 -0300
Message-ID: <20230706101738.460804-16-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706101738.460804-1-dbarboza@ventanamicro.com>
References: <20230706101738.460804-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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

riscv_cpu_add_user_properties() ended up with an excess of "#ifndef
CONFIG_USER_ONLY" blocks after changes that added KVM properties
handling.

KVM specific properties are required to be created earlier than their
TCG counterparts, but the remaining props can be created at any order.
Move riscv_add_satp_mode_properties() to the start of the function,
inside the !CONFIG_USER_ONLY block already present there, to remove the
last ifndef block.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 31e591a938..deb3c0f035 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1852,6 +1852,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
+    riscv_add_satp_mode_properties(obj);
+
     if (kvm_enabled()) {
         kvm_riscv_init_user_properties(obj);
     }
@@ -1870,10 +1872,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
 #endif
         qdev_property_add_static(dev, prop);
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_add_satp_mode_properties(obj);
-#endif
 }
 
 static Property riscv_cpu_properties[] = {
-- 
2.41.0


