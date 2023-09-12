Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E079D209
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OH-0002tI-6E; Tue, 12 Sep 2023 09:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3OE-0002sf-Kj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:14 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3OB-0003p6-BE
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:25:14 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ab2436b57dso3863283b6e.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525110; x=1695129910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7qpf/JkqOOyGkufcoz/cV+noVL88MwgaLJx1Pp2JNY=;
 b=hoz/YelyVcZJEG9hTa7dyfU7boawWted+16ywn7DKTeAFTXiULWPquLvP6iTuMwKXV
 9CfV/2w4e+OwRj+KzeAudWQYIv/nKSPX292b5qIzYqWWbHBgKseuay/qpEqBCK2LT+Ko
 wEtVTocWbfkdZVGKc0+YY3jYf8iiHlXWW/5Pyn+wNCkDdmUDbAPu0TAiGOsdwsKEWW1C
 AeEiIQE9ubn5Z8zOpAtIyfpuxCaRwZgXFi43j2M0dYUg5DrSqRKj7Awmz1MLFOR8OMwP
 XBktSueXL4QGsRptZJEemg85C5Teg/P2caa5UREV7DgZJY14KAtdgCuB1Zf503Y8afH0
 wVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525110; x=1695129910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7qpf/JkqOOyGkufcoz/cV+noVL88MwgaLJx1Pp2JNY=;
 b=Nj84O2BFkgTs0LkOEj7MWds4yQ8a299QierW9EVUGC0GqwsclQu+2FDN9WlwPWAhM+
 rq2IjLEXGUczXwIk9pFN3xpPr+bjN5lekT7VZ71gTBgPBiARutlQUB7c99kw/CAJwqF2
 47+Sg5hJjPhuZ7XkmmW+4vWCDzz9ttmnmLojHdO+mSx77NbC0+1l+hhnyCd6jnuKmCV0
 AO85aeJi0vk3ElHOKjfyS8AajmAcm5h1dWnHPnT/8ALA58cwFXH3xMvXjXgPHyKWAt/Z
 4BALgmarvOno8yom664HKdTTT3AakwpGIaa49EIZkhEkD92PpMmbAOjTeClmjDpxbi8f
 tA+Q==
X-Gm-Message-State: AOJu0Yz+4wMciWctf3gpzRY9f6qxt8Yb5abLBjhjsqvDmll2NPda/AyH
 ar42uJdDjIRowRnWHd32A7DZ/EENsRxmGoJNRzA=
X-Google-Smtp-Source: AGHT+IHOhMg9uJl2DWoPge+uHoGmT8PuQMSWAe3c5YuIMWp6xEhRm/8Q50V6UzYXBqIFFELwAY/Z7g==
X-Received: by 2002:a9d:7501:0:b0:6bf:1f5f:ed18 with SMTP id
 r1-20020a9d7501000000b006bf1f5fed18mr13882966otk.1.1694525109943; 
 Tue, 12 Sep 2023 06:25:09 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:25:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 11/20] avocado, risc-v: add tuxboot tests for 'max' CPU
Date: Tue, 12 Sep 2023 10:24:14 -0300
Message-ID: <20230912132423.268494-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new frozen/ratified RISC-V extensions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


