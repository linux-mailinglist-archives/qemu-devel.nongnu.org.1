Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9F7ADAD3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:00:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkn3P-0000Jm-Pf; Mon, 25 Sep 2023 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn3A-0008T5-4f
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:59:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkn2u-0002HR-AW
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:59:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405361bb93bso63072685e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695653927; x=1696258727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWYhOQMznQlDFerIuEfFly6GjEqfzxxsRGSOgMHMHjQ=;
 b=EITU6Bmk/KZ7EoeEAKgC8FW47z8Lk6tBvcmCwDACzlytgXN1f2clNAjxjDPIXlvcsv
 VFPDmRPzUqiwu7EXLI03AO1O88rNBz55edM0LGrUvS3T2nk6/46ypVOrVf/TQCjQhf7t
 rLt17akKd64eyun7cd7uoFdu8KsiBhxsov2VcsabNbmPGE/Sjnzx8VSZ1ghZzeCI0UEI
 DObmxeF8DLYC2A9doV0lH8vcZb7tU8mfvyrBiS4Ca7SrmxaCITGf4315t2TgiYA3p3/x
 UAELhyPpm7M+ewSutfSxbcDqBC2z7eoTyzqaGt3B7tdjqsQIpxadA8+Xuzo1XBfGRaLC
 PPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653927; x=1696258727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWYhOQMznQlDFerIuEfFly6GjEqfzxxsRGSOgMHMHjQ=;
 b=uTDR+hqbLyCZOglW6VNWGvB1nimfElqBMwwQrMM+OIHLkKwgHn9oKR/YMZEsmrLtwh
 U9j6uoiYRHXaIy5Fo2Qmd442o/zaiN8T8teyPhaf+k1lsvKMkxn/P16E0UVHTu3jYZxB
 ARyNyEC6OEoHFH+GXWMAVi0NOzqyhNpkhGavR5K6EAVZ++sZKrNW+UAVgTxwBK4XIPHc
 HKNmoQHDpB9Ra19WItYaRwJ/+KzIXRcxir3d5pO56H7P7Vsd8EhG47DsR1epLKy0VoYA
 /ka0LGGblzsq1mEd7mr0lZbLHPFnoLEDFY1vaFLKoEMbrl9O1XmYCVVxHrnAgP0VNK7S
 45wQ==
X-Gm-Message-State: AOJu0Yx6TW7E5nvIfoysaTGKFOZmuCmhBMUvMMgn60x1mqfa+9N57yM5
 EvH+GhmlwImuJZ0g6Bqi9g0fVA==
X-Google-Smtp-Source: AGHT+IGHhcyszvNWqg8cEs9rJ+gdnn6azFdoW2Twyip98CgdpKdtGrCIPGnliDpBidqk815HgNQJgw==
X-Received: by 2002:a05:600c:4a9a:b0:405:9657:9ab4 with SMTP id
 b26-20020a05600c4a9a00b0040596579ab4mr919003wmp.6.1695653926893; 
 Mon, 25 Sep 2023 07:58:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a1c7712000000b00405959469afsm1657004wmi.3.2023.09.25.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:58:45 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2129D1FFC9;
 Mon, 25 Sep 2023 15:48:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 17/31] target/arm: Remove references to gdb_has_xml
Date: Mon, 25 Sep 2023 15:48:40 +0100
Message-Id: <20230925144854.1872513-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925144854.1872513-1-alex.bennee@linaro.org>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

GDB has XML support since 6.7 which was released in 2007.
It's time to remove support for old GDB versions without XML support.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230912224107.29669-10-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/gdbstub.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8fc8351df7..b7ace24bfc 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -46,21 +46,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         /* Core integer register.  */
         return gdb_get_reg32(mem_buf, env->regs[n]);
     }
-    if (n < 24) {
-        /* FPA registers.  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return gdb_get_zeroes(mem_buf, 12);
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register.  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return gdb_get_reg32(mem_buf, 0);
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             return gdb_get_reg32(mem_buf, xpsr_read(env));
@@ -100,21 +86,7 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->regs[n] = tmp;
         return 4;
     }
-    if (n < 24) { /* 16-23 */
-        /* FPA registers (ignored).  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 12;
-    }
-    switch (n) {
-    case 24:
-        /* FPA status register (ignored).  */
-        if (gdb_has_xml()) {
-            return 0;
-        }
-        return 4;
-    case 25:
+    if (n == 25) {
         /* CPSR, or XPSR for M-profile */
         if (arm_feature(env, ARM_FEATURE_M)) {
             /*
-- 
2.39.2


