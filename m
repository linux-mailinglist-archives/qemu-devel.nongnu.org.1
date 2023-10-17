Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E787CB9F0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscXD-00010v-1n; Tue, 17 Oct 2023 01:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscX3-00010X-HQ; Tue, 17 Oct 2023 01:22:18 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qscX0-0000Hu-RG; Tue, 17 Oct 2023 01:22:16 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57de6e502fcso3120806eaf.3; 
 Mon, 16 Oct 2023 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697520133; x=1698124933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5tOZzQG3BKRdfOxtKfroabQlxdHfKGXI76E2bvGhHI=;
 b=CiM3W2FYkaaWZ85MunSQclD3MCBBZHmYONadfFuwSudmmiYWC699crn3+0+w9+eYax
 pOoWdvEoiPnl6Vg61y61l6n+ieIWmIe2BR4bGO1qOu9IWXdXcuTXGk+FiIl3Kek7J9Rz
 LhnLFOPtICqIKOItQyk2CWeLWIISKgsEU2iuq0Ba9hj1zBcYLJQcmdTwDYbT1+KObC1n
 /9KAVFHK62708f7U8CAyRdIauQ+4E5IAdpm5EbIYNzfZDMTaV+4vVYxzOT4gA0eyK9IZ
 yl3jhNJAEqccb3s23yrr3u6zMWJx1qMNzlg8ReFSOxwAaxF5sDEpkINsLh+9GDm2D4I1
 LlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697520133; x=1698124933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5tOZzQG3BKRdfOxtKfroabQlxdHfKGXI76E2bvGhHI=;
 b=OFt0B+MIx5Br5bnyWNK3DjqVnL5TZe8na2Mm8aUoaiZZFj8bh8GxCB8fR/ikFDG+TC
 co9xpHGigFUBwcXs2CxsUPzUzBTHXDv7DTJ1B7CczGwEQVjvmspdpIgIsaQolmisYmS6
 vIV15LSf9joD6A9NTl5AH3X7hmta5KgGF28dngEbowzd+Zhcg3UMzayIjhV6G0zpyVKp
 ZA6f+VzX4P0phzylb59wJRNQro5mRDfWlA/f0KJGtIh/ryYMm5mHoVhUfZbmWPrveURV
 u8M4MGTnZCPy5kXHzcQmlxt98FhM+y/PSiDVi39VHyiJyn7rNaBRvsWzZbp5E+3LH2oU
 x6NQ==
X-Gm-Message-State: AOJu0Yz1rb00ttGK7MX4V8Ai+PjeYByQBTxReMzMk+VxfkQQNujdz7kS
 j1q6M7E9uab6NfMQG+4qPbI=
X-Google-Smtp-Source: AGHT+IHPt3AxdMZlbY0fPrsYLpiGx78PEiBvl4WS9VwcqA2h8qPiDvYgpGDk5K5VkSsg8dQPZowqnw==
X-Received: by 2002:a05:6358:7e16:b0:142:d0dc:a3ce with SMTP id
 o22-20020a0563587e1600b00142d0dca3cemr1549509rwm.2.1697520133010; 
 Mon, 16 Oct 2023 22:22:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t26-20020aa7947a000000b006933e71956dsm477222pfq.9.2023.10.16.22.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 22:22:12 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: cbrowy@avery-design.com, wilfred.mallawa@wdc.com, mst@redhat.com,
 lukas@wunner.de, kbusch@kernel.org, hchkuo@avery-design.com.tw,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, jiewen.yao@intel.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Tue, 17 Oct 2023 15:21:53 +1000
Message-ID: <20231017052155.173577-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017052155.173577-1-alistair.francis@wdc.com>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2f.google.com
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

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.41.0


