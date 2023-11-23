Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5457F56AC
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 04:00:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5zvq-0001QR-8n; Wed, 22 Nov 2023 21:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5zvo-0001Ox-IG; Wed, 22 Nov 2023 21:59:08 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5zvn-0000QT-6P; Wed, 22 Nov 2023 21:59:08 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-282fcf7eef9so343297a91.1; 
 Wed, 22 Nov 2023 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700708345; x=1701313145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIQzh+3gCVOtxJ46zfLPVv885EzLo4sOUWMLMpKf7c4=;
 b=L3tgWFpHY1r0lYyHAXhvKDK/CRFntl55NXameGrr8g7Yfog8FFoh73UHKaHZ1xRuQE
 gK8K194H6dcswNVwPZmtiaC5slDh/U8t84oYI2MHeYvMxBfgsonQqhZDQmY+LCH89SiZ
 sUOdAB8e6XYHYZH7htxZltRuN5CH9EeV7hySlSWm4RSr0afmHeYl/XWYHIUoePcxX4UH
 +1FUwrJqXAu0VabwdRgn30aFqjxoUp0qMTr3Me4WmWe7Ojj1h1OrWd7YKZ1iDO+BWtM0
 eTMQR+WpJzX2YZ9K7pHyQxN6JtNBuiBjvubYeF6FjET/z0TBfZCjpJzPZP3d2eqtY5oV
 CDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700708345; x=1701313145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIQzh+3gCVOtxJ46zfLPVv885EzLo4sOUWMLMpKf7c4=;
 b=gsnP8su8hlYhU/iX9WhtPH37+O0oIUXMqS1Gtq3FyMh5wDp+HEXaPDgoaFFMpfdQXq
 7pTZfM/PkW5tuP9FcbUlcMnTJzL3FR4q8afPqrdWZKnVAt8ztGCWwDMEhMps0HmbOoUz
 Ii0GpSQTfdwjPXxsgS57YgyHe6aBVcQU7VuOjAnMZ/jBmScnGDPH4LS50FAG5XimkDIX
 l25NRXuPFSESJWwA8JP22M8Rmq6cNey6PaFeM555GEPQwHnCuUYwRASq2q7YBhIBWYix
 eIWvpcE7s/w4tnwuozjGA66shnoHxtW9ZRx4toCKF+pw/+auPhQrsn6vi9Ozgdj4Pe/s
 tf/g==
X-Gm-Message-State: AOJu0YyLOZpOYdtOmLYyRz0pkxpq7d+dD1t3jm3udhSspCTWlN7IJJgQ
 /v2UDutH9Tuu+PikT3hPFQI=
X-Google-Smtp-Source: AGHT+IGpvz6Fcs7RKjE0cyg89kUdIMLPL1dbiDpKoCPyna/OJu99UQqaRIArpFkStNOoHima6RO/Jg==
X-Received: by 2002:a17:90b:38d1:b0:280:a6a6:9b1b with SMTP id
 nn17-20020a17090b38d100b00280a6a69b1bmr4239439pjb.19.1700708344981; 
 Wed, 22 Nov 2023 18:59:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 br17-20020a17090b0f1100b0027909a8994fsm476743pjb.13.2023.11.22.18.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 18:59:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: marcel.apfelbaum@gmail.com, cbrowy@avery-design.com, its@irrelevant.dk,
 jiewen.yao@intel.com, wilfred.mallawa@wdc.com, Jonathan.Cameron@Huawei.com,
 lukas@wunner.de, hchkuo@avery-design.com.tw, kbusch@kernel.org,
 qemu-devel@nongnu.org, mst@redhat.com
Cc: qemu-block@nongnu.org, alistair23@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Thu, 23 Nov 2023 12:58:45 +1000
Message-ID: <20231123025847.2538863-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123025847.2538863-1-alistair.francis@wdc.com>
References: <20231123025847.2538863-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
2.42.0


