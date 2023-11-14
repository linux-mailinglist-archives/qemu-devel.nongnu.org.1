Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0677EB2BC
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:46:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ub9-00077V-3S; Tue, 14 Nov 2023 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaA-0004wC-Hw
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:06 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ua6-00080J-PZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:00 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9df8d0c2505so1150163566b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972795; x=1700577595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1LXi3GoLl/gkTzQsgGS9qqbGm09JIagG9772ckn2qA=;
 b=AFgZGs6uIysXgV7jNRW18nEhKb5Im0/Il71/XSCuveVXhO1LeL1/PE8nL8gnIh9oTK
 dmzBzzKeXT7q3LO2EYdRd8xd+u/kDAdgX3WZuAGbkqPAZqbXC0p3/lr56WC5VRE82OV+
 KxzrMPhXFcmO8eYNxhKqGYfhDOuPUV5a+Ry04KyiaD1vC891NiQTfXDc4RexL00Mpv7e
 Z+aZy5hLJFXD/snUSRIWOiO0mfyTw/ZDJn7ZFCsDFOxQ0JKuDPq23IbIzT8qyS6djYYs
 ndcBN3XfpwAknDKdHTAB3V8YmKX/abnol0ut1ihi36syN3fyTqDrGjF/wv2bX/kq+5rV
 hSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972795; x=1700577595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1LXi3GoLl/gkTzQsgGS9qqbGm09JIagG9772ckn2qA=;
 b=N6SUzkj5bObkidqd+6f51Cq+AJrEfJ/baNjqsVJL/SpBPWSaj7rVNvki6k9whmkXG2
 goQUzhZanI6tk6M4DmKTQkIE+9ZM7txLkI7t/BkDlydixLacT71G75sauW1CM+c5mD0X
 /FcKdjAPF1wM5YXjRu7ahScYayNkaEkPs6bMUTB+lNX8aiGr1iziB3XpDTflYyiMPvNq
 xDvL49XdEPcAPGMZtKwznYwdc7FC7VwQxZ/9m9nUqceIdCbhFwlR75c4MXKOR7pXL8Dk
 3uVdzAaqIipKF9Y5965VlPAcfIf5UJXbXWXyCL1R5pM4l8C0e/bPFbxuuqm4A0Vw040T
 ISLg==
X-Gm-Message-State: AOJu0YyoDmGzWwpRTr2V4FQu5BUigCGBpiPJCibwF5QQz9gEX9nj3rPP
 1BFvKkAtlY0fLqem44ge9CwpAg==
X-Google-Smtp-Source: AGHT+IFO0v0Kbx5mK0/IVC1YCc6AdDt4TudkiuPrPaddeZvjZPoy7Sp5UUV1A0HKtR5wjcSegxv9ZQ==
X-Received: by 2002:a17:906:e51:b0:9ba:b5:cba6 with SMTP id
 q17-20020a1709060e5100b009ba00b5cba6mr2289558eji.14.1699972795126; 
 Tue, 14 Nov 2023 06:39:55 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 e10-20020a170906080a00b009a193a5acffsm5624675ejd.121.2023.11.14.06.39.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 14/19] hw/xen: Use target-agnostic
 qemu_target_page_bits()
Date: Tue, 14 Nov 2023 15:38:10 +0100
Message-ID: <20231114143816.71079-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/xen-hvm-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index fb81bd8fbc..73fa2c414d 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -2,6 +2,7 @@
 #include "qemu/units.h"
 #include "qemu/bitops.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 #include "hw/pci/pci_host.h"
@@ -14,6 +15,7 @@ MemoryRegion xen_memory;
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
                    Error **errp)
 {
+    unsigned target_page_bits = qemu_target_page_bits();
     unsigned long nr_pfn;
     xen_pfn_t *pfn_list;
     int i;
@@ -32,11 +34,11 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
 
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


