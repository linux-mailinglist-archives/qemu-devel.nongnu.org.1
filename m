Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66157A082C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnmN-000169-9h; Thu, 14 Sep 2023 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmL-00014u-5v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnmI-0004Nr-15
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:57:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so11575005e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694703428; x=1695308228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtcIs6yYyidH4zQz1/k8o++mH4DJxC9RFer7VuPtpiY=;
 b=sERzTfYpdeEe7628bgCNoc8PTUMrtZhaTW1dBmjcFxt91byI0i60Fs9PEJ/wjMjWjf
 TFcHgPmKs0RQoj3e/QlMJxpya9UKwbErm+bd2Evkg0U+yyRF/MigRbwGBm2TyB5rmgbt
 RoAS/R0kl4/2QHrAD62XMjaPK7zE/4nbozIFyyLP6NvDDkKpx0Ayy8Rl2SAWp2hhnZsA
 Vy1hyabEK/I3Cx7u++ixrW+vB7qkGix7BfTzB8zt/SUZ4N4vYZSuAJ70HbeF+5xWkAwA
 O9DrjR+HDMujT2e5G4LjjgvOeVSwkTpzczaBygPoGM6K/I75iTdwF1wHRMZ5mmLuxPyG
 BPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694703428; x=1695308228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtcIs6yYyidH4zQz1/k8o++mH4DJxC9RFer7VuPtpiY=;
 b=RJcTLTR9wi63sNvtqfdFAxNzIlkAgaYgXFA8GDx4CYH5VfQUj0Qll2ZeGoRB81uEPo
 Hu5vMkPzLDyYqtuTdUktbztcqlGMbU6J8lYbRupOjSHDGbPqGHH8+rRrU8cYt9WrbxWr
 W99VcfrQDkzzoICs433CDUfZSvu2wJCEYQgOsxs8EEPlhoYGRmvljDALv1h3ixDOpr0V
 RhG1e7XI7LvnYqEm0gkAM3Z2y+9CTWJuRLgCKR3wvlw/nKD4Vk7MiIYmqtm7fTOxl4YF
 onXhGzoVIPKvdJBgbEBW9CXIU2bhCEJolXWdG1VSggG6RX29PIUOycI0G1NfsSeWBxAf
 bsmw==
X-Gm-Message-State: AOJu0YzCh7KPb5p5Gwe9quq1SV976ZQ9yi1q8PNpy8jBetoQiTcmKAAd
 VXlBv6+PCi94x+GRGpREy6T9ZA==
X-Google-Smtp-Source: AGHT+IFy3xW7iyfpKRXim5v8kQ1bgoPu9FaoWzwd+PYuJtqH8afsU+1k8vtMu/6C0fman+M6Dle14g==
X-Received: by 2002:adf:f981:0:b0:317:5182:7b55 with SMTP id
 f1-20020adff981000000b0031751827b55mr4594639wrr.42.1694703428669; 
 Thu, 14 Sep 2023 07:57:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a5d470f000000b0031981c500aasm1978483wrq.25.2023.09.14.07.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:57:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH 1/3] hw/arm/smmuv3: Update ID register bit field definitions
Date: Thu, 14 Sep 2023 15:57:03 +0100
Message-Id: <20230914145705.1648377-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914145705.1648377-1-peter.maydell@linaro.org>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Update the SMMUv3 ID register bit field definitions to the
set in the most recent specification (IHI0700 F.a).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 6d1c1edab7b..25abf117095 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -38,33 +38,71 @@ REG32(IDR0,                0x0)
     FIELD(IDR0, S1P,         1 , 1)
     FIELD(IDR0, TTF,         2 , 2)
     FIELD(IDR0, COHACC,      4 , 1)
+    FIELD(IDR0, BTM,         5 , 1)
+    FIELD(IDR0, HTTU,        6 , 2)
+    FIELD(IDR0, DORMHINT,    8 , 1)
+    FIELD(IDR0, HYP,         9 , 1)
+    FIELD(IDR0, ATS,         10, 1)
+    FIELD(IDR0, NS1ATS,      11, 1)
     FIELD(IDR0, ASID16,      12, 1)
+    FIELD(IDR0, MSI,         13, 1)
+    FIELD(IDR0, SEV,         14, 1)
+    FIELD(IDR0, ATOS,        15, 1)
+    FIELD(IDR0, PRI,         16, 1)
+    FIELD(IDR0, VMW,         17, 1)
     FIELD(IDR0, VMID16,      18, 1)
+    FIELD(IDR0, CD2L,        19, 1)
+    FIELD(IDR0, VATOS,       20, 1)
     FIELD(IDR0, TTENDIAN,    21, 2)
+    FIELD(IDR0, ATSRECERR,   23, 1)
     FIELD(IDR0, STALL_MODEL, 24, 2)
     FIELD(IDR0, TERM_MODEL,  26, 1)
     FIELD(IDR0, STLEVEL,     27, 2)
+    FIELD(IDR0, RME_IMPL,    30, 1)
 
 REG32(IDR1,                0x4)
     FIELD(IDR1, SIDSIZE,      0 , 6)
+    FIELD(IDR1, SSIDSIZE,     6 , 5)
+    FIELD(IDR1, PRIQS,        11, 5)
     FIELD(IDR1, EVENTQS,      16, 5)
     FIELD(IDR1, CMDQS,        21, 5)
+    FIELD(IDR1, ATTR_PERMS_OVR, 26, 1)
+    FIELD(IDR1, ATTR_TYPES_OVR, 27, 1)
+    FIELD(IDR1, REL,          28, 1)
+    FIELD(IDR1, QUEUES_PRESET, 29, 1)
+    FIELD(IDR1, TABLES_PRESET, 30, 1)
+    FIELD(IDR1, ECMDQ,        31, 1)
 
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
 
 REG32(IDR2,                0x8)
+     FIELD(IDR2, BA_VATOS, 0, 10)
+
 REG32(IDR3,                0xc)
      FIELD(IDR3, HAD,         2, 1);
+     FIELD(IDR3, PBHA,        3, 1);
+     FIELD(IDR3, XNX,         4, 1);
+     FIELD(IDR3, PPS,         5, 1);
+     FIELD(IDR3, MPAM,        7, 1);
+     FIELD(IDR3, FWB,         8, 1);
+     FIELD(IDR3, STT,         9, 1);
      FIELD(IDR3, RIL,        10, 1);
      FIELD(IDR3, BBML,       11, 2);
+     FIELD(IDR3, E0PD,       13, 1);
+     FIELD(IDR3, PTWNNC,     14, 1);
+     FIELD(IDR3, DPT,        15, 1);
+
 REG32(IDR4,                0x10)
+
 REG32(IDR5,                0x14)
      FIELD(IDR5, OAS,         0, 3);
      FIELD(IDR5, GRAN4K,      4, 1);
      FIELD(IDR5, GRAN16K,     5, 1);
      FIELD(IDR5, GRAN64K,     6, 1);
+     FIELD(IDR5, VAX,        10, 2);
+     FIELD(IDR5, STALL_MAX,  16, 16);
 
 #define SMMU_IDR5_OAS 4
 
-- 
2.34.1


