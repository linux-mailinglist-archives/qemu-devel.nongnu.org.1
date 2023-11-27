Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142F7F9E0D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:00:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZKK-0003mK-2U; Mon, 27 Nov 2023 05:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZKG-0003lV-59
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:52 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZKB-00066m-Ty
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:50 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2857670af8cso2774588a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701082726; x=1701687526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0aTzAq6W7EbYaE2S8Vh4ITPH2FgfVuM24WZURH+ztM=;
 b=SbIYukhwNAVd3odgbKuurNHcG8jHna+Q/0Bse2TTjZrYY2/Xjmh+uUpjAjB6XcpViR
 ZM4/ZFoNLfnCwBMjizZHnyrV/ZFyhxF5a11RL9iN2SZ/OOnZPwRuNQ4vqGrCL13J09d5
 +6kLk9HGQaQGKkdcRtwQ7TJ0/wTdEb281PTf0+67d23uG0pUPpwkdHV0WT+s4A11QpU+
 bv1yFByZCanYkWlz4wMgUtdI5LaO97tID+AZhGSrbO5uHMgWwf+Nn1JjMJ0dqbTc2UpP
 wWCKPzPOm6wC6AbrIXhpcqisYBmtlMUEDPWJFP86WYyTcuHRwI1O6hBLCFr59vkh/B//
 z/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701082726; x=1701687526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0aTzAq6W7EbYaE2S8Vh4ITPH2FgfVuM24WZURH+ztM=;
 b=DWGMvN4dBWTkOkvnHmubGTm75ksuLTI4JM8dn0TkSkgXCdOdhVhw5wSbq3BO+/+qc1
 iIjBqGbNwsbi3YnxIod9W3CZrGo7j/WdLx1LWaDjGhtLXlqHyoEbSZE3GG14gRChLwrO
 rSyQTQRq0jx61YQepmxuGPIU82LkLc6BAz2mgRF2ANCRAbj4csBLODc/40h2COMpkY9U
 86mK1sZ7w6Egbw4msvrIe4jKzpMXkxVJYvncH3biPZ/w1YYVA6kuC8dJLClfQhjMZ7ee
 pVJC8B2G4LTn2kRL0oTxKtlpq6SOSD2xrefjkZjcczdrPvYoLYrDoqrPRInVQrjrGA4V
 hqyQ==
X-Gm-Message-State: AOJu0YzHiomkvYbR7OclO8oPAEA4+oFmxDFtrp2HG2mwJQldnH6t6rC4
 w2pD7AL0PnTVKuPPzzDwgcQ=
X-Google-Smtp-Source: AGHT+IEskGqLC84KWDvFjyr7AKZEfqK0cO/j244GUmecCVGnRDrFCgipFW1MBBPfT7zBALrOei1xlg==
X-Received: by 2002:a17:90b:4a84:b0:285:b6a6:c411 with SMTP id
 lp4-20020a17090b4a8400b00285b6a6c411mr4026667pjb.4.1701082726429; 
 Mon, 27 Nov 2023 02:58:46 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 mp21-20020a17090b191500b002801ca4fad2sm7508351pjb.10.2023.11.27.02.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 02:58:45 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-cxl@lore.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v1 2/2] hw/mem/cxl_type3: allocate more vectors for MSI-X
Date: Mon, 27 Nov 2023 19:58:30 +0900
Message-Id: <20231127105830.2104954-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=1, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

commit 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background
completion") enables notifying background command completion via MSI-X
interrupt (vector number 9).

However, the commit uses vector number 9 but the maximum number of
entries is less thus resulting in error below. Fix it by passing
nentries = 10 when calling msix_init_exclusive_bar().

 # echo 1 > sanitize
 Background command 4400h finished: success
 qemu-system-x86_64: ../hw/pci/msix.c:529: msix_notify: Assertion `vector < dev->msix_entries_nr' failed.

Fixes: 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background completion")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52647b4ac7..72d9371347 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -685,7 +685,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 6;
+    unsigned short msix_num = 10;
     int i, rc;
 
     QTAILQ_INIT(&ct3d->error_list);
-- 
2.39.1


