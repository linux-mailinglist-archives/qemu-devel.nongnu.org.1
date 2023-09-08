Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4092E7981F3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfS-0004uS-8E; Fri, 08 Sep 2023 02:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfQ-0004jA-2w
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfN-0008Dx-Jc
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so12855665ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153307; x=1694758107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ/WFteKBHkLnA786Y2XQH8ZP/LZ81hhOddg+nv0wCs=;
 b=JhK/N0yreCV7tNb4bdAMZh6QGuRPNSaIpxMMBN4hR6fT1sZdXLO1M3WBElA0+wn+cq
 SbXvV6wCLpOyXqu44RTItQlWrQpN/3d59hSZ+dge78lnuFT5A2UDX9HfVaVJPcf69f/E
 LV/gEK1SdBpvhotnDbHlvjOfKRuMEfIwDdSil2lQHPX17weHw0GdXwHVZ54Qlz3Td4PH
 FKL9FI58JTxh/XE1PP1MP4Uk1a6NyueA4It6gVW6ZWa+NNON0Zlg7sBl+HtqH+9uGOVd
 mpwvhypeZUHGzLmaYyaYOfLvddhBr3w8L1uTlH92I+AJUOA07r5cIFCPEdTTVGVPt7Tl
 Jucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153307; x=1694758107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ/WFteKBHkLnA786Y2XQH8ZP/LZ81hhOddg+nv0wCs=;
 b=ZcK9FOx5Acp1O5W+zALGCTUDtw3iENcq05a7ACz5IWiEAhMpXlMj50MCXYHpNb9/N3
 IdgkEpI10QkmGtnYO9xe/4m9FRruh4By0YjiYkt9rQeSnjotXrDyAR6r/KBalkhfD8NA
 /1UfweqM1STFIrpquE9gOtvcQJ4wLeFWuhfFYRCgV82Qy0lHPV+eEUaCO3d9kG/fpwyV
 Xs1W2J0EkHFKDMAI25yhCmYIsvx1/Kz/2aB9+dAjK57u54uSe/bw7y0Br/4GQkThzwBC
 IS7Z7mGqCVBE/NosTUQmbNHWDyk1Ky0XSsdObpJsQp+Xhud3QepR5+lCchhDstBiCtqn
 G6KQ==
X-Gm-Message-State: AOJu0YzR3kFWiGrkkkC8qElb3YE6R4w7KL0xYmI9VKDC8VT28LBtMiVI
 Zm5gdCS9j6h+QD8DOMqT9tZ5bP2545vX6G15
X-Google-Smtp-Source: AGHT+IGsHd9I9MfpMUwd4AM8F4v/bt/SmdGfGDiKoZOwesfHoiPyq3AINiz+yNOzRAcZfByyciONzQ==
X-Received: by 2002:a17:902:8c8d:b0:1b6:649b:92cc with SMTP id
 t13-20020a1709028c8d00b001b6649b92ccmr1402596plo.69.1694153307621; 
 Thu, 07 Sep 2023 23:08:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/65] avocado, risc-v: add tuxboot tests for 'max' CPU
Date: Fri,  8 Sep 2023 16:04:22 +1000
Message-ID: <20230908060431.1903919-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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
Message-ID: <20230901194627.1214811-12-dbarboza@ventanamicro.com>
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


