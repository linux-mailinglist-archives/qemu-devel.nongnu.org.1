Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C644673A5F5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCN2D-0005by-C8; Thu, 22 Jun 2023 12:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN1S-0004l3-2I
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:19:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qCN1Q-0006TN-9k
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:19:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b4f9583404so56134645ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687450738; x=1690042738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A56Uh5klqcLSjmwqI1z/yzrdLspAC6ino+I1HQHPTUY=;
 b=T3rAQsLnkfmPboqtzj3fbQAqjKWl5Q+hhlWKmbuUrsvOXdXL/JVwHQdcDWB5WsAWKI
 e4XYjZAfnyloOPewa5uaB0uhGoXT9NtTP7Rw8upjQzBu+OACZQdBAqNq+y2ZHLWd410C
 AlBkiKyh59+h6vNA4GlotwRj3tLl6fnyvGi+5yR5OwUUGHh2e2RjAl717wKXXeUSpORP
 mBpQjP3DUU8F242axU6gHj5GUCvikuiXQESKwFzhJVhP0EOKNtujbj3PZjhxAbH8eU1q
 q/RCNE3FFf5ln8nkoU0JAzLDykA7vZZRo+ugFQpWAfF9I7/le/w8rkJ+ucMoVM3gndAj
 EXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450738; x=1690042738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A56Uh5klqcLSjmwqI1z/yzrdLspAC6ino+I1HQHPTUY=;
 b=GVzEveBDLSssjo09R8BGA8a+0T/UO2EUMQfubFgvzx17EufAgHbQ+L6gwtEktUGF1q
 OHwedVAVHOw5yj6wsM/UMy3LPgZ3hJqfw35+gZgXmCoFY8eOD6NEZW/7/moX0b5RHZQo
 fb/Gb08FqvXPsURDJXp1nl6QwSXpPJ5ii7JAVkt944PeKy4Or02MZxhOd2fppu6b9LRo
 /GO+A7gIvicseYaTQEJZVbBuuiJEy/K+PIfKLcvmNqJG7bjUAp6rjZ6OfUySpqS2scCo
 eW1c25y504zVRtyGIljXk+B+M38b4wjwNA4tv2etndLoqS36NUZPpWj+lRFp1UQpMPl0
 HMvA==
X-Gm-Message-State: AC+VfDx23Hc5uOQaHIAIqTvshtnBDsxLzblvc3QmM2t6kbaFizzDfqwk
 ZgiBktu/DJQuhQVyfXWd43VEE2PNbZbQm/Iib/gJZjcCiXkDUwVPnoKtFmhoTPssIirltdja1lD
 YmZ+9gaxVXUz1oBzN/x+LD6ikYuDkFu6O49LThILp0VP/3Q16JaHn1zRGxSHE7AxnISU4ZxdGG4
 hL
X-Google-Smtp-Source: ACHHUZ6FzYI/qWsdvdQVa52Y/bqvhPcL5wujgDwmOTz5j/OwnDo00cn6iB70ysSt0y2W28n1Ug3diQ==
X-Received: by 2002:a17:902:bb8b:b0:1b5:30ed:e2b9 with SMTP id
 m11-20020a170902bb8b00b001b530ede2b9mr15724833pls.17.1687450737842; 
 Thu, 22 Jun 2023 09:18:57 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 c1-20020a170902d48100b001b3f039f8a8sm5609683plg.61.2023.06.22.09.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:18:57 -0700 (PDT)
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v4 17/17] target/riscv: Expose Zvk* and Zvb[b,
 c] cpu properties
Date: Fri, 23 Jun 2023 00:16:33 +0800
Message-Id: <20230622161646.32005-18-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230622161646.32005-1-max.chou@sifive.com>
References: <20230622161646.32005-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x633.google.com
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
Reply-to:  Max Chou <max.chou@sifive.com>
From:  Max Chou via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

Exposes earlier CPU flags allowing the use of the vector cryptography extensions.

Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c1956dc29b..48d584ab0d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1714,6 +1714,16 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zvfh", RISCVCPU, cfg.ext_zvfh, false),
     DEFINE_PROP_BOOL("x-zvfhmin", RISCVCPU, cfg.ext_zvfhmin, false),
 
+    /* Vector cryptography extensions */
+    DEFINE_PROP_BOOL("x-zvbb", RISCVCPU, cfg.ext_zvbb, false),
+    DEFINE_PROP_BOOL("x-zvbc", RISCVCPU, cfg.ext_zvbc, false),
+    DEFINE_PROP_BOOL("x-zvkg", RISCVCPU, cfg.ext_zvkg, false),
+    DEFINE_PROP_BOOL("x-zvkned", RISCVCPU, cfg.ext_zvkned, false),
+    DEFINE_PROP_BOOL("x-zvknha", RISCVCPU, cfg.ext_zvknha, false),
+    DEFINE_PROP_BOOL("x-zvknhb", RISCVCPU, cfg.ext_zvknhb, false),
+    DEFINE_PROP_BOOL("x-zvksed", RISCVCPU, cfg.ext_zvksed, false),
+    DEFINE_PROP_BOOL("x-zvksh", RISCVCPU, cfg.ext_zvksh, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.31.1


