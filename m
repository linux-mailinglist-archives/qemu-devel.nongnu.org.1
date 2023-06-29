Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 645EB74256B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqUY-0005pu-Ko; Thu, 29 Jun 2023 08:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqUX-0005pW-98
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:11:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqUU-0000Ai-OO
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:11:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f3cd6bb4so561173f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688040673; x=1690632673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6YYX1dWztzELlCI3XT5PMGW/yG6v7BZW/N8+vfbi8Y=;
 b=dgqw1EbKpIXDe+Ln7FcLJoUI4Bx6KvOQi9fMMl4LkwWNvPlz4uc5mH+LQTGRWVGmMV
 stNfmAH5KXMEOkMkQyhRYl6SVmvcJJPK/4x0W+gKru5SX+L4pwa5TpRdSokrMivH/2Og
 JfZldQ1dKoS1THLmBl5RNTHTD3bwoK1BREdLRKGi+fXDBmAkGbvhzEXp6qWT9YFyMXEh
 JkW4Cl5GrG1tHo69jKf2LO/RNIuTNVOm8j3iakF9IzEtcGJoizgCBxYphNqC02lP93Po
 6BFp270OK95FCjbBIH0yJH4xUFQZIwg63HS1FmSWxWJqqS+kiv0RfYeniWJboX990EtU
 ooXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688040673; x=1690632673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6YYX1dWztzELlCI3XT5PMGW/yG6v7BZW/N8+vfbi8Y=;
 b=k4LbBYOIpnXRzhp/jIbPADLN0G0oOaYCM6Tv1cj3sgMh5HP/vf/DWjkkrxEN0pvV8c
 xPLV9GxIF7nWonAYTzEFGTBFVYyzy4NSknUjUuWX9PNqzJuXMU/NBuuHGLrTkolQW+ka
 p92yi0U7MTfIbxWJffVsWVdEkr+BHgnuo8h+Z/H2xmeM5Jg2hRbf/SMniBPizUvmxsx6
 RtDWWqxFp/y+x1xLx6IQHi1meiPwJ6hWP3OzIRmqPlECzbPMHRbM6YTOIsitvfFJNnaH
 71LJv7a+BRa27ZoZ0bERo6Ma3Y09/8mwXUhFKRVg7rURn5+yRp0TMB+THgsJJeaOHdBH
 LyHg==
X-Gm-Message-State: ABy/qLZyTS6zo5JorF0z5zpKjls1i9Uwl+xHZWcGUL035AM/8u3MQ0HS
 9lnTsUL3lu+p5SiTMxBsgizqHNvSdt1R2m4GReA=
X-Google-Smtp-Source: APBJJlETgFANpG9InpSSMwhYBjwsU7sbZa/lV1Mt3gGIr+w7KDJqxP9A+bHwS6hq5RHi/SwcqBdEwg==
X-Received: by 2002:adf:fa4b:0:b0:314:1bb7:8a19 with SMTP id
 y11-20020adffa4b000000b003141bb78a19mr774490wrr.35.1688040673142; 
 Thu, 29 Jun 2023 05:11:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adffc06000000b00313e421c620sm14872185wrr.54.2023.06.29.05.11.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jun 2023 05:11:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/riscv/virt: Fix 'controller' typo
Date: Thu, 29 Jun 2023 14:11:02 +0200
Message-Id: <20230629121103.87733-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230629121103.87733-1-philmd@linaro.org>
References: <20230629121103.87733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ed4c27487e..68ccd0bde1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1692,7 +1692,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
                                           "Set type of AIA interrupt "
-                                          "conttoller. Valid values are "
+                                          "controller. Valid values are "
                                           "none, aplic, and aplic-imsic.");
 
     object_class_property_add_str(oc, "aia-guests",
-- 
2.38.1


