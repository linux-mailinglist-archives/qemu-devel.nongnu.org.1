Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458472F1CD
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FDP-0000AS-8R; Tue, 13 Jun 2023 21:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDM-0008Lt-Gw
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:24 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDK-0004kX-Mm
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:24 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-75d4dd6f012so152624785a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705741; x=1689297741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4v3yawg0uOjmzzDcZNfQbha9k+Ps1ceIjWHX0t+xz98=;
 b=a3ImHG+JWK2MUgp7u5wSkq8l2rPaEG8K9GzBFo5ZC5NXe8qgK5fkLBiyTvI2B+0R1m
 3TB89aVn9mfFqJH1G/7fop7S1+KT5oNFoDVmmsBz6MBpRdnKAFbilKepsF6FmAXxOBOU
 aM/wRnKKzTOIXmJ+MvXU2CpnNNICfYCzjJp96/4NlVObrE8mMVQDJOWwwTkO4EP9zFMg
 vRa+CChLKO98ckhJPDg4aHU6/a4iurnH0U3FsIriyWZGaEKZlDTnJjaFutxCfjvcx8fF
 nx1vo2E0ZmjPS1gNVC5Zg3JCELQnh7sWTp+QmRr9D3BJJXrVIHzq4X4GzlZV/tCZ8ixd
 9Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705741; x=1689297741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4v3yawg0uOjmzzDcZNfQbha9k+Ps1ceIjWHX0t+xz98=;
 b=dKj9B7TeAWGNw9pL9a1MjICaPaMjtLk65KKcR3yFYbmz9p7kYjIC6Ow42ooDcGt+3L
 WnTfl3Iygxeor9zmZFCWTH681QxoRz7gz5ZdwVYniG0J8/J0pFdcg5lBTV3oZu5rytxa
 /xMpylG6O3McyuHy+MzZ7sktLl81VP++cbDaHWQbgPnOON0v138EegeulN8bAWnhCL3D
 jQr9s0Rw+UxDOiGgAls9pe6V+BYcmwDT4wSa/n0J/SVhbkvkIbKESGFvRngHmALp2N8z
 bcSS1VjHYrdtsLJLoCTzZTIyET0iuBGOUKidAEd3gaGT80bh2arGBp8E1o+T5QKdkBg5
 VP3g==
X-Gm-Message-State: AC+VfDzS6MnAKv3g8PgSlvBwnSLnNT32S/tebUwbqQaQrsmr1SvNj5j+
 f8eQc60aqMsuttj2Iyf/mwtoacDmXA24Pw==
X-Google-Smtp-Source: ACHHUZ4V/970bbfu3/dNsUBiTWmSa2z8E/zWxJ0Jrs11QFQPts1asI10LFNl253bFBaDis1Ju/zPmw==
X-Received: by 2002:a05:620a:278d:b0:75e:c496:dea1 with SMTP id
 g13-20020a05620a278d00b0075ec496dea1mr15313312qkp.78.1686705741554; 
 Tue, 13 Jun 2023 18:22:21 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:21 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 27/60] hw/riscv/opentitan: Declare QOM types using
 DEFINE_TYPES() macro
Date: Wed, 14 Jun 2023 11:19:44 +1000
Message-Id: <20230614012017.3100663-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination. This
is in preparation of adding the OpenTitan machine type to
this array in a pair of commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230520054510.68822-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.40.1


