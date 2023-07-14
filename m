Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41D7540BA
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMpS-0004cC-CD; Fri, 14 Jul 2023 13:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpQ-0004bl-Ij
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:40 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qKMpO-0003zU-RS
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:43:40 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1b730eb017bso1724487fac.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689356617; x=1691948617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=l5WEBtepgqLWSUjxOIfZclSb3bvflwddezGGRGoTaSq8NoZ95olAEAg+/wQyNKimX1
 dYMR+R0Xr9DcGVD6kEWiEdSd360DmKelFMEeA2r4fz1WBrQ3YfwlAkAl7M8ZFGcZTDTH
 ADsWDthh6nPXkBl0ceq405ZBLkmhS7XJaIT5T+0sdNm0y888yQdeB2YfyJxgfe1rRNKE
 ibhQou0+kykeaUKKY80uB55Mk7JMGulNtDn4T8ye3fiP9AbHUfxY++wbQyOktcR3vRhl
 gw27re4Uf72so3lIlPrG6p0q9NyJhzVjU+HRj0m7e7RpMcPc7nxzeV5Voleji7advWE1
 VrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689356617; x=1691948617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=eWWxwk4Ur5awdKXjps+HRzIrygzFdfky17BHMn3fNbLYqGSLennUfwyijUylLTEp8z
 txTnaHanUaBjE6PrTigSizBo37gwBx531xGTeF7anGRwqYqF7DtmFr/zt5l9Uustgtg/
 7c1PgAofiQWFZ7w6EtH0yYEyziqTeErp7ILPveFL6ewkt+FfmhBcabP13h/z8R4dYzTj
 TRxSwl180pgfkMO18bhhivmI4BH5+W4rCouy0qmppwEAoi1SsclsEmdPDpCqSGZ8IOXn
 q4VlWtA5H7ARTWS9kiSZeymSMbTIWK2GfiT1K0nOqNla7UZAiAI1ogdLp4rD7ujgKZjh
 +gqw==
X-Gm-Message-State: ABy/qLYpHTuNlomaf1zQizkIzK347bAcWPa1SCA2jahSICiwTwBesmo3
 otqTK6S9PRhs7+SUdqqXm8NfbrdcReiEgb0yYFE=
X-Google-Smtp-Source: APBJJlGOK2ztInEpvKxNLBOcGqdvL419suNQyYbfr7CUkQjVPO5xAXR0Uo6WiWuyYlMbLJLgYy/0Yw==
X-Received: by 2002:a05:6870:418c:b0:1ba:53ed:18c9 with SMTP id
 y12-20020a056870418c00b001ba53ed18c9mr1201921oac.37.1689356617628; 
 Fri, 14 Jul 2023 10:43:37 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 dw18-20020a056870771200b001b05c4b3b3dsm4240968oab.31.2023.07.14.10.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 10:43:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v3 7/8] avocado,
 risc-v: add opensbi tests for 'max' CPU
Date: Fri, 14 Jul 2023 14:43:10 -0300
Message-ID: <20230714174311.672359-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714174311.672359-1-dbarboza@ventanamicro.com>
References: <20230714174311.672359-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x33.google.com
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


