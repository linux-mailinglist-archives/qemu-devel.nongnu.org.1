Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E63437999A6
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 18:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf0ks-0006SM-Qe; Sat, 09 Sep 2023 12:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qf0kr-0006S7-PV
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:24:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qf0kp-0008TF-Ax
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:24:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c39a4f14bcso3870155ad.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694276653; x=1694881453;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zkebMQRumeFLdwtK0AMLRKP+R2TVkhDXpdruazqZgcA=;
 b=QKdF+jN9WMvUVCh0pwTk67OvEOoYRLJYgBoMKgYxp/Nxxmf/x5sUsJlN6KOBu6TEnj
 qvsWamVu71soYqCpWUWWEYdPc1Km3NwdpMKKoJJMea6gEDzZtlz7Grj5VNXxavQj1qHg
 QbahXm4M8Kr86IQWaARk6u40X7XboL+TPQVQDtCoJ6uyclUU8ffzzR+4m0OHMxUuh+kL
 t9xYhW3kMaDAg4JTEMYytfvI9/IHqX19nHeG+T+03MSQtD5zONfVlbxrYPWB/9/oPTcp
 uPQUyic0HF66aBJRoy6HBhHl0f22MzlNJbWFdHnqSnO5q/mdYqAfr294l92HiyYYCxJn
 xMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694276653; x=1694881453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkebMQRumeFLdwtK0AMLRKP+R2TVkhDXpdruazqZgcA=;
 b=EI4x2pqCqZFSescN+mcZoV/qJ96UEFF/imo1LtgswNQ286AbVnQWsQyXHStElbRjtl
 BUSXJdYDoudvgD0cd+C4QAR4qpy73+cw7kPBmnkRd7TfCJDhOWZ7f0TvsXqe5AcI8R3M
 4Ca24UANEsyNZ5aTjj6UwQUCntDS0lVvD/t2Ku80ZlStv2rQCNJ27dHh4Gy5zmmFOjZj
 kL0Xwm6xWylr4C921sxKN7VDZDqDLGxi21wbhhCJb01YPa1Co+WxcDTlrazzZzvXGUge
 NckLAqtgTy+Q71IJGhP/22WDVfuyygXuiNpa2DZq3v78iCLj/0cepymQRoNehLvg8co3
 NPkQ==
X-Gm-Message-State: AOJu0Yw/Wf3BWmVOsNRSstJhzrgY1PduMirWusO0gaS2g/+jN+nGIa8j
 hDNzz78QNKc8nYFcwPDqHbeLtY3t+gn1X6y0luc=
X-Google-Smtp-Source: AGHT+IGD9QKloaF6g4VMk8CEGUQSNzb4CN/Uvj0fUGeFMtbkFB/RxrDrxpFfaP5p7Oyi6zhw25/clA==
X-Received: by 2002:a17:902:f54b:b0:1bc:28a8:f856 with SMTP id
 h11-20020a170902f54b00b001bc28a8f856mr7219646plf.47.1694276653429; 
 Sat, 09 Sep 2023 09:24:13 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 jd2-20020a170903260200b001bb99e188fcsm3437804plb.194.2023.09.09.09.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 09:24:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] amd_iommu: Fix APIC address check
Date: Sun, 10 Sep 2023 01:23:53 +0900
Message-ID: <20230909162355.384982-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
Check only the 12 bits that are known to be fixed for I/O APIC-generated
MSIs.

Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4655cd801f..3ac0d0098d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1268,7 +1268,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
 
-    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
+    if ((origin->address & 0xfff00000) != APIC_DEFAULT_ADDRESS) {
         trace_amdvi_err("MSI is not from IOAPIC.");
         return -AMDVI_IR_ERR;
     }
-- 
2.41.0


