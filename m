Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E52EF7C63C2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3J-0001ET-Dj; Thu, 12 Oct 2023 00:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn35-0000yr-91
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn33-0002Gn-Q7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso4608975ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083904; x=1697688704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7BuIb9EJ21EUgeX86Kwp2vBql8jige8PXQT/rB4wCs=;
 b=AIJpRzzZ0o16Vnvo34No+Lzso736+25Wj9Nvsei9rqVC5JLA3bCrpZSgIHuxe9pf2N
 tDNcBdnbRmbd/gZY54nOrKRzzH/ZWXM4kq1v0oFL/gwENJJO0Kjpu3hWkKUpjyN2j7nL
 oy39H5hmDiG8lx+Q5Xjx46EuQyXKdA85fFf46hEloyt5gkHz42pVLwSn1l4LTfO/afKh
 wyiIZ6AEopfPPSj/GREeWlC5SsxjMtAjMwyYdREIe6md5M7JaXLgI3fFELuyCj/QTlSf
 2EEQ386zE+QZSjsQ8Q8sypphrJ5H1yfzjSYkhs+lwBGQSBRuCcL3NHVL7jfsiWROQWkr
 GtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083904; x=1697688704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7BuIb9EJ21EUgeX86Kwp2vBql8jige8PXQT/rB4wCs=;
 b=F1RhnFP9Jwar0sdFu2dXuUocWx7negWR26VuihzKdQbH/Mcgb9qmFYZ2mzm7H1/SUL
 21aWOJ7j2AGjnsGiyVEESDhSQoml7EFpfeOMip28h+Ld1axJ7hn9O8tGPqb3Or02bqGn
 g1xDyYMHsgaJzMcXBIUvzrhlRZUEuHPomLYeWA8YAPGeyME0pCJ2842mxrng4dPI38B8
 w2o+KS64H9KTnWZI9ul5dEjCa+lUyt9cFooyWwFSGz0JkLmvqrs4cUPIphfWykXaZJhC
 kdTmPF/jWFwtRQ5t0XJ8RSu8EbcczrX+O2hiDF9q2kkQLvM/1R3Hh3VWZ6FHShTLJkj4
 9ipg==
X-Gm-Message-State: AOJu0YzHQKTBwEgc9BWGYzF3BHztoqyqWh6e8qMZZjcczb+ShUuzX+48
 /2h96FE2EzyO70Co0k0TI818m+uPO8danQ==
X-Google-Smtp-Source: AGHT+IFpgB9esFC0bbhkaaVbneEXO7WP9ZWTHlaGDyUhDrnk/vD7p0ZApheCm5KIEcXUCBV+0TxRlA==
X-Received: by 2002:a17:902:f691:b0:1c6:1bf9:d88d with SMTP id
 l17-20020a170902f69100b001c61bf9d88dmr29806523plg.44.1697083903802; 
 Wed, 11 Oct 2023 21:11:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/54] avocado, risc-v: add tuxboot tests for 'max' CPU
Date: Thu, 12 Oct 2023 14:10:08 +1000
Message-ID: <20231012041051.2572507-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new frozen/ratified RISC-V extensions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230912132423.268494-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/tuxrun_baselines.py | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index e12250eabb..c99bea6c0b 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -501,6 +501,38 @@ def test_riscv64(self):
 
         self.common_tuxrun(csums=sums)
 
+    def test_riscv32_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv32
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        :avocado: tags=tuxboot:riscv32
+        """
+        sums = { "Image" :
+                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
+                 "fw_jump.elf" :
+                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
+                 "rootfs.ext4.zst" :
+                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
+
+        self.common_tuxrun(csums=sums)
+
+    def test_riscv64_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        :avocado: tags=tuxboot:riscv64
+        """
+        sums = { "Image" :
+                 "cd634badc65e52fb63465ec99e309c0de0369f0841b7d9486f9729e119bac25e",
+                 "fw_jump.elf" :
+                 "6e3373abcab4305fe151b564a4c71110d833c21f2c0a1753b7935459e36aedcf",
+                 "rootfs.ext4.zst" :
+                 "b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb" }
+
+        self.common_tuxrun(csums=sums)
+
     def test_s390(self):
         """
         :avocado: tags=arch:s390x
-- 
2.41.0


