Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A27510E1
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJf6V-0000om-0S; Wed, 12 Jul 2023 15:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf6E-0000ns-GD
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:06 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf6B-0006WV-OI
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:05 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a3c78ede4bso5564056b6e.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689188522; x=1691780522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nS2W9UaH9gghVm/aiRhSGBwZOy7l91Ih/qPzigWpPY=;
 b=N7KgC3eHa/+VWtqsCO5AUr2wiVm9nb0vdrf9cleqru81Oat2KH+oJl8dUopTe5ijZT
 CaDhHgkSF1rOH+BYba/D1DQiJSoPcDzJMDEQZUuWL3y4CIq9ooUPqnSatVx5SFbujLjh
 3VOg8X55OWM+8A95AaI7OsgJDT+nDrgU6d+MKeCkNzwiqtgHOPeKMTRUWLRU1igPRlVt
 jOTWtblgHEiEGwICJCzpxm/B4iNmgsuE8nuacrbbN9cgJ5bkZP8DpuUF5dl53RsEWoXc
 pmaGaDg5Mphs9QeeOeHZNuMwPl8RfMK5IN5bocDElowSnmsp+/aPdtyl5fV7EHH2pnzu
 /37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689188522; x=1691780522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nS2W9UaH9gghVm/aiRhSGBwZOy7l91Ih/qPzigWpPY=;
 b=PLHOJATqaxhNzLgf1837in09LmYgoQNvgwV1frbMdZXhYn1MTAHJdhTVJwLa/YfiyL
 4q/BDtniUsRu+2g9N2yp0YEz9HSY67JZcMtW5oQl3PfNWZ5Bf9FJQuBJZwTztZtXIUDy
 Yuq0TUxv7bcXx0Ii5ruMEKlg9eqiF8NEztUHtk6eJ86pIqkQd8SXx5HAmY7mNkaZ5qJG
 tU0+rNzgwZwm5xianSIbbvkGFaCdtUw5K8qMvfCL2IKcHZx5CBlajuLp5PsCoVFEFTsC
 xpo5T23fHG+FtBswI8/RSH5pi4tZSJk1r0VevtBmaJFdmhUHbVPSCgLN+6iXxj846GaX
 KaGA==
X-Gm-Message-State: ABy/qLZQ0KsWdsy0gMXeSq1Ay+fpkpMaqvCk6KjSC1Q7BjCVvRV+qEvu
 05tvQHicW7evKuuFL/UvvaJHlOKXBCHxAlXhu4w=
X-Google-Smtp-Source: APBJJlFGyx3mVUuTtdguj/90gB+dMBEPYDsqnfUTgRQBAjqaARl74rDY4W23WrwqS8a7FFIxGCLytg==
X-Received: by 2002:a05:6808:1395:b0:3a4:1f76:bdfb with SMTP id
 c21-20020a056808139500b003a41f76bdfbmr5559154oiw.14.1689188522469; 
 Wed, 12 Jul 2023 12:02:02 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a05680802c900b003a020d24d7dsm2174435oid.56.2023.07.12.12.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 12:02:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 2/7] target/riscv/cpu.c: skip 'bool' check when
 filtering KVM props
Date: Wed, 12 Jul 2023 16:01:44 -0300
Message-ID: <20230712190149.424675-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712190149.424675-1-dbarboza@ventanamicro.com>
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
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

After the introduction of riscv_cpu_options[] all properties in
riscv_cpu_extensions[] are booleans. This check is now obsolete.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cdf9eeeb6b..735e0ed793 100644
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


