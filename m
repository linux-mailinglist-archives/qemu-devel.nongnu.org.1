Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1ED751210
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:59:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgv7-0000Ln-EE; Wed, 12 Jul 2023 16:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgup-0000Kv-Cp
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:27 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgun-0005WW-UB
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:27 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1b00b0ab0daso5922437fac.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689195504; x=1691787504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=dv+KQL0XUJQo80ID0u72tJkpAn25dst0wkyS54sIRWKtrZ0tIZ0FxxjoxCuNS6HxhL
 6shG4Vs3us0LcGafhbAy2qeL/07cZuxaUKUZooNmcEOMnW7U5A5Exk8BM8bcvCGyMqtL
 b6RzKxrJ6zm+GCfTYBDAvHHzdYhV3hJSN5dhVxT69SFMHlHsjbisknplfVa2QRfpkeiQ
 nIlrRe3eQYnrBg810PHhhLe8T6VY2Hrx25b4BKGUcuSmc0TN9xekLs3mjcYG/hws2zdy
 jBma32cy/iK1rThNJLIuzH9uOrgTjO9q0WuuMM5SXEua7mI/PrjTtxynbj8g/AbTcNrc
 55cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689195504; x=1691787504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mkt2khv3HlTYD2I5HX8C8vkoqmlMW0ZXesjrMFYxT0=;
 b=B10AlxXwfp6au7DtJx9FGHw2KZcedwnyr9rqV5vQoim/kmmR3Kz/ZHu3A12uTalgeh
 Bl3WFsoR2JZgjg8WZHna8+ycfR4jEK12gNxhtG1fl92bCC1LYH580vuOXTLOiWX5PGGu
 XqyiQ6a3Z9C4iCqUiCPhTqbN5BLlq93w6DyQUTyZUtZwllfP7KBFAZCi/qJLfC/vPSF5
 a3jNuvgp4ee+/sKEFqZlTLYY6j4SNz1HcvjsFc3forahrOz+B+Wrn/07ud5d5fIrtdG2
 ZoI95cxZanWU0GTHjPPSUHXQl8lEkbV7X2SnDd6rCHaPXKR2dC0yRckOVaGJyyT3UKni
 6urA==
X-Gm-Message-State: ABy/qLbGtwEkuIRa31OIQ84v53/gxhz/fL0g5kPcfCKnNzVYPfeU3hrx
 nNQNRb7ftEThLkrnCjQDqNf2GwZ+8HojTWLxREA=
X-Google-Smtp-Source: APBJJlEWaCVDggVkiEwU37G+2srhNvj+lHucIXiseQwj83LSd3ooSTowCRQzm5fmxJYEAT6846h0Cw==
X-Received: by 2002:a05:6870:1f91:b0:1b7:6158:621a with SMTP id
 go17-20020a0568701f9100b001b76158621amr5216803oac.47.1689195504025; 
 Wed, 12 Jul 2023 13:58:24 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a056870344200b001a9911765efsm2359904oah.40.2023.07.12.13.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 13:58:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v2 7/7] avocado,
 risc-v: add opensbi tests for 'max' CPU
Date: Wed, 12 Jul 2023 17:57:48 -0300
Message-ID: <20230712205748.446931-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712205748.446931-1-dbarboza@ventanamicro.com>
References: <20230712205748.446931-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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


