Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D3816C60
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:37:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsY-0007ED-Jz; Mon, 18 Dec 2023 06:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsM-00077t-4P
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs5-0003Lj-Vi
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:33 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3365f09de18so1649466f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899196; x=1703503996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XBGAau5xQawMv1TIkYCOIFZhD76YOOoYpu6Y5VQfn/w=;
 b=p1nx/xizLrpkfy5i/rxVvJxdN22v/GAJQne56MBnSRuBZvZOtlKlgmp4NT0TKUnBQn
 JuqdXo/XhaL82QhWyrStx4rIZkv9SdNo/90lEM2lkluZqhglRLK+25rg1f0vknL8ci6X
 x68X9dXwgkUNgiRINGOmYrqMI/e3AwRt9J44UnhJoSW+GgP4CcfJHvueR8pTAY13IsJ7
 MatwDNAI0Yy/16z6BNtzBSoraupwFANvxKXXszfYMdF3Zf2jzFBb07zFxx9XMklNq9fu
 z03IJFoPm2LRruqhJRXfiqFyrp8KoPZUz1B+SMGhe/rvFDEJ5PqYbmPYq98nlJa0Tz3T
 GUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899196; x=1703503996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBGAau5xQawMv1TIkYCOIFZhD76YOOoYpu6Y5VQfn/w=;
 b=CFEXyo6/hPNxPjNPaQNthVsvqLr0NQ73h5rmS3Utk/85aTmeKsxwu8sviz4sK/Z+yj
 fxnXrVOZR3lEvypze+8YhJzjXrqf+aH9IsUhWDOo586IuIKtLES01wcnYcvOLsvtlFIf
 vnmQHUi39smPOBND8ktJQ3zWFtElAqA+8kNsZGomuA3aLr1yeAEPdDjfYhNEV+4hvIYx
 5y5qwken+KUDgWd7LPwM0kVkJeUvjErOWoRdUqy9LXJajVjyiz+9BO36/14u3NQ+y1qC
 ho1+sFvKMGMO+jAjfoyFrTgHbON0+1uT2PyDd2AYgqBqmxPXeT1587BhSBBvO/MIo7x4
 Zf9w==
X-Gm-Message-State: AOJu0YxvLVfSrIDtorkD1Mp4RrUaWU8y5c+rfbmJzQwyHdaW+uael1QW
 ZJfEpjbkZf1wZfoOLYHNt92yhA==
X-Google-Smtp-Source: AGHT+IH6YyUH3goIYwZEZhFPpr5OuSYWhdhC+56tdjrA7IBU0mK4BCTamQ0oeWeeBBG3PmIOnBaHjg==
X-Received: by 2002:adf:e2c2:0:b0:332:eaa7:56b0 with SMTP id
 d2-20020adfe2c2000000b00332eaa756b0mr7873228wrj.14.1702899196728; 
 Mon, 18 Dec 2023 03:33:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/35] target/arm: Add FEAT_NV to max, neoverse-n2,
 neoverse-v1 CPUs
Date: Mon, 18 Dec 2023 11:32:51 +0000
Message-Id: <20231218113305.2511480-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Enable FEAT_NV on the 'max' CPU, and stop filtering it out for the
Neoverse N2 and Neoverse V1 CPUs.  We continue to downgrade FEAT_NV2
support to FEAT_NV for the latter two CPU types.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/cpu.c              | 8 +++++---
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 0b604f90059..d827b42de79 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -63,6 +63,7 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_NV (Nested Virtualization)
 - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
 - FEAT_PACQARMA3 (Pointer authentication - QARMA3 algorithm)
 - FEAT_PACQARMA5 (Pointer authentication - QARMA5 algorithm)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index efb22a87f9e..da0c02f850b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2238,9 +2238,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
         cpu->isar.id_aa64pfr0 =
             FIELD_DP64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, MPAM, 0);
-        /* FEAT_NV (Nested Virtualization) */
-        cpu->isar.id_aa64mmfr2 =
-            FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 0);
+        /* FEAT_NV2 (Enhanced Nested Virtualization support) */
+        if (FIELD_EX64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV) > 1) {
+            cpu->isar.id_aa64mmfr2 =
+                FIELD_DP64(cpu->isar.id_aa64mmfr2, ID_AA64MMFR2, NV, 1);
+        }
     }
 
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 40e7a45166f..93f040e6e96 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1204,6 +1204,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
     t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
     t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
+    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 1);       /* FEAT_NV */
     t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
     t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
     t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
-- 
2.34.1


