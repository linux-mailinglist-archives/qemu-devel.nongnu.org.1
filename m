Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5B7C576B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaYF-0000F7-0r; Wed, 11 Oct 2023 10:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaYC-0000BI-1c
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaYA-0000W7-G9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:51:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40535597f01so64914255e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697035861; x=1697640661;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lx/x91sRzUvZz+5aArqcD6OQqzMIzULutjZzsozWjG8=;
 b=a0smqIGJmlzIJdYs9OHog+CEiAsMpy8oaS2MfAtUnfuraI9iq3oroYqy8DqOblxYpG
 LdAO7r0D4JceMLGWQG2AbDEazfLVXm3xvFCLWgj1kObvQlLWxgmPsdRpgenZOfInvf5Q
 fdkHArtmtnuy5+EcOP5xNiVSfY6onRvK0Lae4YYRa+TbmebOF+qwLfOrInmCEMNO6aVm
 aZiDj/n6FHCPB7CYsyqryp4yEzERzvWE8sJ+R2IBia3XmzavOCF5xJSnlxfxTNbuvaw+
 Hledd15EKA2wEFjSJx/m2KI5cUcfqoAC6F1bWi8qVfim8jKYnD5+PZdG1WzPcFBrAp0w
 5ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035861; x=1697640661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lx/x91sRzUvZz+5aArqcD6OQqzMIzULutjZzsozWjG8=;
 b=cA0TOx4BDxbcyLppP2UYVqoHRlNVax+W56ACP93uZYCjqnGxkgKz422mBQRc4BQ2M1
 4zH1Y+wZkzs3hG6dJJIAaVbSDPqZvg6DBGhjq++Cs34992sRFoVMGqoHDYrb2Y/oCpFp
 eZ8J/Fo6q2Le96uT6YD78AyYj/K0KbRWMucTr9QRwjpP6cKqJNNgFf4/J06J00HyMW1V
 1tYYUCrKsKzgbTGSBGChJ87+d0bu0EejwO83V9d3YQCoJ842eutnTmi34Zcn3h2xEff5
 +odUmw/cekFrH7+0FaGLv8EOtwPHVAXydr2qQpP0ZfmjC4ieU8hzG3NjF+e7VIzPe60P
 +OZQ==
X-Gm-Message-State: AOJu0Yx5He0wdhrQdFexWinF3pMUP9fwicSkHDWRIL4qtu21iMdn6wV/
 w74VECJvcZnLIXj4flsidaUT5IeI8MmC4FQbKh3hBA==
X-Google-Smtp-Source: AGHT+IGH54psDQadBV1THULpIkoBzZmojiLnPhijO8DUAyD1vEiiL0t1beJj/ygttXzB9QV7ZBhTJg==
X-Received: by 2002:a1c:6a18:0:b0:401:eb0:a974 with SMTP id
 f24-20020a1c6a18000000b004010eb0a974mr18308115wmc.3.1697035860731; 
 Wed, 11 Oct 2023 07:51:00 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm19709208wms.24.2023.10.11.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:51:00 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v2 4/6] qemu/bitops.h: Add MAKE_32BIT_MASK macro
Date: Wed, 11 Oct 2023 15:45:52 +0100
Message-ID: <20231011145032.81509-5-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011145032.81509-1-rbradford@rivosinc.com>
References: <20231011145032.81509-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add 32-bit version of mask generating macro and use it in the RISC-V PMU
code.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 include/qemu/bitops.h | 3 +++
 target/riscv/pmu.c    | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index cb3526d1f4..9b25b2d5e4 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -25,6 +25,9 @@
 #define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 
+#define MAKE_32BIT_MASK(shift, length) \
+    (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
+
 #define MAKE_64BIT_MASK(shift, length) \
     (((~0ULL) >> (64 - (length))) << (shift))
 
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 7ddf4977b1..360c76f63e 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -24,8 +24,6 @@
 #include "sysemu/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
-#define MAKE_32BIT_MASK(shift, length) \
-        (((uint32_t)(~0UL) >> (32 - (length))) << (shift))
 
 /*
  * To keep it simple, any event can be mapped to any programmable counters in
-- 
2.41.0


