Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A175B576
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMXK7-0007iZ-8v; Thu, 20 Jul 2023 13:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJd-0007hQ-SR
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:51 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qMXJc-0004YQ-Dz
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:19:49 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9f47214a3so874857a34.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689873586; x=1690478386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9lSDeBryekDaWv/Vc78YEkpFPDXZkfJPoxtpTCKUds=;
 b=X5qPg5Plsg4//wi6oqpcxILsdWPAtGEfgcTcZQprPppRHuCd6tZqcbt0CagV4f2amT
 1csEmCoMC1qPxw73o7KX045+hn9MnFkhO5c/s7Sr8l0NsfQQXz2qffo2CXojhAGB/5IW
 PUN6KkRl8l0nWulnw+ISfKC0QkfDHUOff6mxIjCjataQ0QB0ZbvXzH7LCXLZ0+lcv58q
 8/VEhRuBVhvf4ZKHOizkcuCYD3oNqOax0XQPDXt5SeYDI1Lu2xkyLErJ51TA8qVnupEB
 ejU+AC/yBh4Q7XHPzc/0SWzPItx0LM993FY/DyJHGgx+xDZvgMiyCs1LtrKaYmzhSCPB
 erKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689873586; x=1690478386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9lSDeBryekDaWv/Vc78YEkpFPDXZkfJPoxtpTCKUds=;
 b=gx63PAQCDJ3P7WpOf2bi6pw2LBDo5GeSzS3HfmqMZ0CTS1+DowwsNCBSttdAiYEdrB
 RuaPj8WpOc86w4TOUnfkli6Hixwust8ogtyn1fovPTqTjQNem71EEOIy/HCmvX8t+s9i
 GIBxHJ4Q212IwknNllWs4vaGacdL583h09h8MtsPFdgxW5WJYuT36YolMtR4YgAv2nXW
 JUmT76Yw3jnAkv96qCCO+qbI0iLW8VLT3LVS92IkmTw7/kCOGYB99Zm3HWdH+znGsMNx
 ooiSWAl+ymBTa8ZSX1KNp0XNpfbimWYhhVoB1RXOXV/dGAiS8n0zkfQ6snOdrxhFImaM
 /i9g==
X-Gm-Message-State: ABy/qLZdvWErE3yXbDx+qPXAoS/LL5pp/Y+RhTrxCNkxdOjsx2soneiw
 ULL5c2dc2jkfMmVx2V6WYetaBCLYlFnWTt41PaGcpQ==
X-Google-Smtp-Source: APBJJlE9q5kTOkqA+oT1x+Vdn/T0ylKiX0hiljbWqLOrEKvO7eAbeuF+y6JP8JQ1G5VKMjbgAESqlQ==
X-Received: by 2002:a05:6871:829:b0:1a5:4e57:e5d1 with SMTP id
 q41-20020a056871082900b001a54e57e5d1mr105362oap.49.1689873586545; 
 Thu, 20 Jul 2023 10:19:46 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a4aab02000000b0055975f57993sm582564oon.42.2023.07.20.10.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 10:19:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v5 02/11] target/riscv/cpu.c: skip 'bool' check when
 filtering KVM props
Date: Thu, 20 Jul 2023 14:19:24 -0300
Message-ID: <20230720171933.404398-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720171933.404398-1-dbarboza@ventanamicro.com>
References: <20230720171933.404398-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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

After the introduction of riscv_cpu_options[] all properties in
riscv_cpu_extensions[] are booleans. This check is now obsolete.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9a3afc0482..f10d40733a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1907,17 +1907,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
              * Set the default to disabled for every extension
              * unknown to KVM and error out if the user attempts
              * to enable any of them.
-             *
-             * We're giving a pass for non-bool properties since they're
-             * not related to the availability of extensions and can be
-             * safely ignored as is.
              */
-            if (prop->info == &qdev_prop_bool) {
-                object_property_add(obj, prop->name, "bool",
-                                    NULL, cpu_set_cfg_unavailable,
-                                    NULL, (void *)prop->name);
-                continue;
-            }
+            object_property_add(obj, prop->name, "bool",
+                                NULL, cpu_set_cfg_unavailable,
+                                NULL, (void *)prop->name);
+            continue;
         }
 #endif
         qdev_property_add_static(dev, prop);
-- 
2.41.0


