Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC47E9FDA
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Yl9-0001rQ-Ez; Mon, 13 Nov 2023 10:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yl6-0001pf-R6
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yl5-0003Gi-8U
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:52 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso7030538a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888909; x=1700493709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC1GyuSTm1pIOLAiq1jl6VtM1wTJGGJIerTVB/FTO70=;
 b=ONNMMf5ShKOTAZfEB0QNL8A4KLsvbk34jIt6rmPSjIm1fYSMX1S+tCLT0zGbTZcviE
 OJyLqNoj5eEz7ACTykRKJEXO3hQCR1uXTEvZbMPx31TUfYRXlpqWhX9JgiWUunjGmKYp
 zQmLSQufzXMH0MiJexx2hTGidpkVXOjfuhShf0Tdugp5tEJyCvELN/Ns2zzt9BuCmWNv
 BTzG/1Lsn77/9WTtHUO55kXQ0xq3GBWXTiPg2PzXXMbPagtSYhmb8aPC/aEEJQJY3aPU
 G98J7MFlLMb9AvgJ98Oe1XDvmaTACxhDlVs+JeT7A4LkNOZokw0KeLfR74L4zfLTyhHx
 S8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888909; x=1700493709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC1GyuSTm1pIOLAiq1jl6VtM1wTJGGJIerTVB/FTO70=;
 b=m44vI0BTH+U2tRPwADUrf8BIZzmAHNV2dUqzXrns28r8uuDVmLLhwhGqGwCyLpkqHr
 wytRzVhfhzzZ5qtBHyGW3wL978DI5iEBaguj5hyrhgFmS2lnlCHJ6ZozOTdWp0TBjCSn
 Sg/t1KTi/uz22xcpk5/TNS7mq5RQ2+s0jhM9MMgjVJNks6ynSQrt9d9FR3dHTTuBvHbG
 9tW5ALjiDHd2cPuNaXytWuMKNKvAHvRJ1qrSOeLX0XoHXHMdiR8UkxSnRM47U1D7Ljd8
 q2yEcHXMYjsI6ryVtsJVScp22tRv+CAtT5zVVIOtSrY7b1sFl6SeuZAoJAmLsSM8TKH5
 TfpQ==
X-Gm-Message-State: AOJu0YzhjfkKyWmmFjLh81iC1fYR3PDnnctmn/3aHK/vlh4kwff/9nqZ
 +58Y8cx/ltz3nU7cXJ4BaExfEg==
X-Google-Smtp-Source: AGHT+IGbtAixMPiQVaiouSIFTb1IQKmmFA1AcOCrzXhQQ2Afk2FYf+XnPnB9Zgf0YAtZ7aK4/lySbw==
X-Received: by 2002:a50:ab12:0:b0:540:2ece:79 with SMTP id
 s18-20020a50ab12000000b005402ece0079mr5690457edc.10.1699888908890; 
 Mon, 13 Nov 2023 07:21:48 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a50a6d3000000b0054026e95beesm3942482edc.76.2023.11.13.07.21.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 05/10] hw/xen: Use target-agnostic
 qemu_target_page_bits()
Date: Mon, 13 Nov 2023 16:21:08 +0100
Message-ID: <20231113152114.47916-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Instead of the target-specific TARGET_PAGE_BITS definition,
use qemu_target_page_bits() which is target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 03f9417e7e..35b3b5407d 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 #include "hw/pci/pci_host.h"
@@ -13,6 +14,7 @@ MemoryRegion ram_memory;
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
     unsigned long nr_pfn;
     xen_pfn_t *pfn_list;
     int i;
@@ -31,11 +33,11 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
 
     trace_xen_ram_alloc(ram_addr, size);
 
-    nr_pfn = size >> TARGET_PAGE_BITS;
+    nr_pfn = size >> target_page_bits;
     pfn_list = g_new(xen_pfn_t, nr_pfn);
 
     for (i = 0; i < nr_pfn; i++) {
-        pfn_list[i] = (ram_addr >> TARGET_PAGE_BITS) + i;
+        pfn_list[i] = (ram_addr >> target_page_bits) + i;
     }
 
     if (xc_domain_populate_physmap_exact(xen_xc, xen_domid, nr_pfn, 0, 0, pfn_list)) {
-- 
2.41.0


