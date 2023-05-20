Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB770A5C3
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 07:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0FPN-0007Hn-3G; Sat, 20 May 2023 01:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPC-0007Du-Tz
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0FPB-0007cT-FE
 for qemu-devel@nongnu.org; Sat, 20 May 2023 01:45:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f41d087b24so27222745e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 22:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684561524; x=1687153524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTAW6cK3XhyHe2DSiXzz9dWc3zDAXzPHwYcm030hYyk=;
 b=pW+WiwCo5lSt4d/R7h1EzOwqgt2veIicK34eOeQmtyBV/1P7xSikI7OYscaUpCoHlO
 8UPHOQcdYfgJcRwDMxr+E8obGdG8RrJ3PiT8z4DR43Mu4FTKUvoiwkrQMIXy2pRtQ8iH
 B14/qJK4CH7ZbogzWfqK+s6+LSe0Y6okbyKt5h2fGNq2+2ESGiW9Vi2uqK8snox/x3vD
 yZeiOdXw22QXPH4tqE9iF7p5R718nxExJ7QNwvYkF0MThY7ro6xgQkywlgb/XccZTGbi
 YdZoBOvH2WdGqmZ5G3U27LDGvReQc5mOid5NzZBFpf5Li50x08c0vMgpAB79GzZm7RF/
 FANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684561524; x=1687153524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTAW6cK3XhyHe2DSiXzz9dWc3zDAXzPHwYcm030hYyk=;
 b=ISBIGJQYOcQ9y3k+Z8ybSioTiOh9NQU4hbgzIHhE4+53TSJ8WdewgvEf2WZqGOR6Tq
 uhHYneUPoR7Q+1NareatwlF9ihAZr/0l2wIuOpsAPZrOOPGZb5yw+WWcpgIHEorIjPrA
 vTHrhB1B3Mag9+tXaAkU5goxWy568lVk/DMqRqoMxdueJzrVJUzHIu44Dp74V7rlvHJ6
 bjtPAna9x4KlRZ65E4VJ+xiV01ruyXy3G44d71kz4ZKObCzHSRvT3q8IYhksIN/QqzH9
 rIJTbLLjiVBG4ONV4TVhTVZ/Ti9p8VyBKyT/rGbmSEgEcLUKxPCRkijezSm/JDDS8gdN
 zjVw==
X-Gm-Message-State: AC+VfDxXrp0waoT/0ZiSJFzVvI08eqBi9LPuQKUqj+1/DedPuYk9F7vJ
 q/OGuwYMWyK1hKyJ24Zi4gRZkxmqK0NsHadQx5Q=
X-Google-Smtp-Source: ACHHUZ4FC3MChAhppSmAQjd0r86vrx342dJt6bw0lmbKUiXRki7lTY3HDSZKRDvlIFvx9fusHmNKUQ==
X-Received: by 2002:adf:ee91:0:b0:309:509f:a7f0 with SMTP id
 b17-20020adfee91000000b00309509fa7f0mr3056463wro.44.1684561523946; 
 Fri, 19 May 2023 22:45:23 -0700 (PDT)
Received: from localhost.localdomain
 (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d640c000000b00307c8d6b4a0sm905259wru.26.2023.05.19.22.45.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 May 2023 22:45:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/riscv/opentitan: Declare QOM types using
 DEFINE_TYPES() macro
Date: Sat, 20 May 2023 07:45:07 +0200
Message-Id: <20230520054510.68822-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230520054510.68822-1-philmd@linaro.org>
References: <20230520054510.68822-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination. This
is in preparation of adding the OpenTitan machine type to
this array in a pair of commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/opentitan.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 2d21ee39c5..294955eeea 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -320,17 +320,14 @@ static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo lowrisc_ibex_soc_type_info = {
-    .name = TYPE_RISCV_IBEX_SOC,
-    .parent = TYPE_DEVICE,
-    .instance_size = sizeof(LowRISCIbexSoCState),
-    .instance_init = lowrisc_ibex_soc_init,
-    .class_init = lowrisc_ibex_soc_class_init,
+static const TypeInfo open_titan_types[] = {
+    {
+        .name           = TYPE_RISCV_IBEX_SOC,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(LowRISCIbexSoCState),
+        .instance_init  = lowrisc_ibex_soc_init,
+        .class_init     = lowrisc_ibex_soc_class_init,
+    }
 };
 
-static void lowrisc_ibex_soc_register_types(void)
-{
-    type_register_static(&lowrisc_ibex_soc_type_info);
-}
-
-type_init(lowrisc_ibex_soc_register_types)
+DEFINE_TYPES(open_titan_types)
-- 
2.38.1


