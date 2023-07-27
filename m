Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC4765F3E
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9B1-0001GY-4H; Thu, 27 Jul 2023 18:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9Ay-0001G7-Kt
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:40 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9Ax-0004sK-73
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:09:40 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b9b835d302so1060510a34.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495777; x=1691100577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjV/lXMlLL0s1HNGB7Ip1ecl2fc6UaDsgtjj2kLtd2c=;
 b=D8EPvMY9Z9I9fsHQfb6Me8zf2VMKWsTNcxSmtFTQFBL5qIIpwsLXjzxl1VPF+AOyTJ
 9YYaxf+kdTfgKQbGdeF7f+9PD3UnNNs8kOjohjzWqsy7VSvptsB8cGCmsvvvjjgfVm7u
 K3wn3raVdjHT8vF9UClsr7ogyTZxbdCUg5nvgzu4fVxcY5+YXYIXIvMvY7EVr6YEkfOZ
 UYorTQEzwIYRsQ+zVufnDq2eKshZviORmqR9G9q5H3wky08pBSN6+7kd6k4B5NsyjI/G
 Y/FIXqdG80FpskzPm1LT09J1e2qXNnWv77Fw87QC3f1bXn6Q1F5J6Vk/7YGe07TzPN+M
 TEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495777; x=1691100577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjV/lXMlLL0s1HNGB7Ip1ecl2fc6UaDsgtjj2kLtd2c=;
 b=WBkFKKSLnnN0J6XuiyJvcfXCbCIOsGzqutnp90AW4fZp8pmrHhsTBYwVSlS3JL+CUz
 0BOekF7f4HjIozl19zl1PHYViC2kJeVZStdmZJfab+LXN+SdPmhbnEo0KXeRJwrmd2zd
 WxtGGhNQLULTNEQ0M6fe+KuDfjqgNArrjy/QCMYpvsayJxWmE+12CbwmLYMU6WMQ0gcO
 xnM0jchFkA4Sjq7CRYOK7LkdayP7i0i6TSpWZzuIXk72NmD5lTEsv9NlCfbkn1eFOwJM
 iMWCeq+TEfwM4hw3wkZUEkmmpv1ZLz5F3Q6pEGXF/0FFJTzr4q/CcSi32jbCijrV/L8L
 i3WA==
X-Gm-Message-State: ABy/qLbjRSmDMInRUQM4DhrK/qvFMIMTWuTdmA4WlWbTejGehtxDEQgm
 286MMIktrXy3tO15/yp206U+dnXg+hsdM0TpfirpGw==
X-Google-Smtp-Source: APBJJlG+Djdd6jTImfIbfrWMimL2VxPXPiVm6lwz8NyxW2JLSoxgzIAcfXD0EYQ6RyjQvDU/uhP1Vg==
X-Received: by 2002:a05:6870:d59a:b0:1b5:688b:5c24 with SMTP id
 u26-20020a056870d59a00b001b5688b5c24mr835657oao.32.1690495777654; 
 Thu, 27 Jul 2023 15:09:37 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:09:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 02/12] target/riscv/cpu.c: skip 'bool' check when filtering
 KVM props
Date: Thu, 27 Jul 2023 19:09:17 -0300
Message-ID: <20230727220927.62950-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
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
index 61bce2dc55..2fa2581742 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1914,17 +1914,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


