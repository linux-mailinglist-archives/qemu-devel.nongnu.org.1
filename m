Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CE765F85
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 00:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9BO-0001Pf-4J; Thu, 27 Jul 2023 18:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BL-0001PO-QS
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:03 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP9BK-0004xb-9G
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 18:10:03 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55e1a9ff9d4so1574154eaf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690495801; x=1691100601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=Lwdha/gIYdC4/GM+l6EjL7fY5LOJkczjSyGS+G6LUdiRD0V/km1u4bmOP+oe474DRQ
 KAeaSFSHCd2uwmOfrV3X4emFyfvbzRg53Ktu1NwTzJO3P3FwbnMF2LZlbw8Y827T3pbV
 ygW5D/7RRlfVbxkksdg2G/yGf+b3B8IMpSycmX+KVP2xe/NVPca1etq67+CS049sZMfz
 AO2wIcLMKvp2slIIRXkefzOQffQ396MWa1LsWiMbuhC3Lt49OFZ3gAS2BWjBY+dSQ1nP
 lnFRwnDy7TlIxAqGhZgVP+fofiZf9h+uQqOzg4HBzkLxxwDoTsJw5ijJbbiURtd8kz5M
 37HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690495801; x=1691100601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=QHv9qckHf/eCQt/mjbnnhKBtZCCsAoGY2Kgbj/cJ+a8VUeVAkTYHmQt7xdvFn/Y5me
 +G/GMw1amnZdVvwVN0+7dMTng7+FDPf2X0ThK+7QICn6MyoGxxZRbadsVo5+Tfi7O4YR
 SVSbVAzP5BjRxS51X2be/43Q0saOVXs1iHbxHmjMk9i9GvNA5TVYWkvDVPauRMLb1FU0
 UavtuDizFTTdfxcTSkmYkHSDHVcmxwnFKtIU8sHi/locg5PV+ve+j2fIjyLDJTuISLQE
 Ont/d/OVm8m1SDVN9aOTMZ4XsOlYjUU7batujaaPcinYb4DDQYcqp0IgBggh6thI+zbX
 N2Qw==
X-Gm-Message-State: ABy/qLZphA/DnHIK8/81/2H4cHG+bcbwCPOoplTtGYvOhF6fCYDDkFQk
 woxi87RiZJT2CoGknWWQGEHnVQbKe2Pmbi6f3SzycA==
X-Google-Smtp-Source: APBJJlHG7i18R7Hn5NvUd7U1TneQT0lhYxBJykJ42kr0UIQsWHrBrT+XFxIZE6U18TdaTW4Nl9CkEQ==
X-Received: by 2002:a05:6808:3081:b0:3a3:9b4a:3959 with SMTP id
 bl1-20020a056808308100b003a39b4a3959mr3520970oib.17.1690495801112; 
 Thu, 27 Jul 2023 15:10:01 -0700 (PDT)
Received: from grind.. (201-69-66-36.dial-up.telesp.net.br. [201.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 y136-20020a4a458e000000b0051134f333d3sm1070471ooa.16.2023.07.27.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 15:10:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 11/12] avocado, risc-v: add opensbi tests for 'max' CPU
Date: Thu, 27 Jul 2023 19:09:26 -0300
Message-ID: <20230727220927.62950-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727220927.62950-1-dbarboza@ventanamicro.com>
References: <20230727220927.62950-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2f.google.com
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

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new ratified extensions to be enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/avocado/riscv_opensbi.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
index bfff9cc3c3..15fd57fe51 100644
--- a/tests/avocado/riscv_opensbi.py
+++ b/tests/avocado/riscv_opensbi.py
@@ -61,3 +61,19 @@ def test_riscv64_virt(self):
         :avocado: tags=machine:virt
         """
         self.boot_opensbi()
+
+    def test_riscv32_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv32
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
+
+    def test_riscv64_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
-- 
2.41.0


