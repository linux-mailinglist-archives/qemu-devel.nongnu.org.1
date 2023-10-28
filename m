Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0C7DA6F1
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:25:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiMr-0006Q7-1D; Sat, 28 Oct 2023 08:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMo-0006OT-Rq; Sat, 28 Oct 2023 08:24:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMj-0006m0-Jo; Sat, 28 Oct 2023 08:24:38 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso130853866b.3; 
 Sat, 28 Oct 2023 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698495871; x=1699100671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p98LzR4A98wQ5ZfYaKYuefbwebJ7vVfonZaSMKgh8fI=;
 b=Ltxrwo8fo+ppBxo9soWE1pFE66G33G1uPSN7E0VdVwWEIdwUMfDg7tmcVr4UNf0Wjw
 zcCM+BqCjcz6vDU1IAOK3ago39QHmbxys+eiHqbDIdBxQTothuVVX9yL7cU2wd2KHmbc
 MMKkfQWDklaBPkh5JP2Tp4TEecDos78nP7QOJIgTh7lxPlab0iQMFiEbqEraCeLbZaJ8
 5Jah9VuuK08WVe2BHdyHbV/WjO1uR0prJMoz5J1MDL1QGjU23sB/oUSCDfnOxKCMxA5H
 kjVrbPUPbkzufi8CYQGuLxi9S3MH1zWqdpKa1ULrLtWw9WvSzdwJRGvRCsGasHJsPG3v
 fsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698495871; x=1699100671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p98LzR4A98wQ5ZfYaKYuefbwebJ7vVfonZaSMKgh8fI=;
 b=rKgMTWjAnGr2lakIhdOq0G+zPGcQnoNnbAQwBRQhhjEf9KcjYWDPvfvv82Y07qu1aA
 uZeLVsKVXiJ/0dIAvOO25aXjfIyoI3K8zO+j7UBQeGrdfM2mTfKluL5aknAGUK86NLih
 OH7SGHeM0k0rU6hgkHbT8pWpWbx6OCmdHzgB5U+JsOtwq61iGjx8+V0JqI8Ly3WH0Ds2
 3qPSPTpLAZjS4ByOIbaqvJ34hrn0CPHp62aBVvx3po7spRiPlvd/mNKUimeNKWp8Mu+S
 Ft4NXAb71i2BRLFODYXnpjZpTuRW5nFySA3QqWZmKWpThw3QGSu8qCMpVPGFDHTsyGd1
 LKNg==
X-Gm-Message-State: AOJu0YxPZRQSngoXkXSLNvejUWDhRA09/p9LLnofqYvFExWNA892xUEC
 JB9oekUq5sRSzHeKhm4uoHwibFNF9Qc=
X-Google-Smtp-Source: AGHT+IE9lMcNenzXtmCdyFljehhaORXwfWkm/tchOl2CQVJyxQEDCoTdkbHWTRhAw91FZLlC9MDfxA==
X-Received: by 2002:a17:907:3f1f:b0:9ae:4878:1172 with SMTP id
 hq31-20020a1709073f1f00b009ae48781172mr4123125ejc.7.1698495870679; 
 Sat, 28 Oct 2023 05:24:30 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906190d00b009ae3d711fd9sm2706687eje.69.2023.10.28.05.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 05:24:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/6] hw/misc/imx7_snvs: Trace MMIO access
Date: Sat, 28 Oct 2023 14:24:12 +0200
Message-ID: <20231028122415.14869-4-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028122415.14869-1-shentey@gmail.com>
References: <20231028122415.14869-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx7_snvs.c  | 5 +++++
 hw/misc/trace-events | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index ee7698bd9c..a245f96cd4 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -16,9 +16,12 @@
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
+#include "trace.h"
 
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
 {
+    trace_imx7_snvs_read(offset, 0);
+
     return 0;
 }
 
@@ -28,6 +31,8 @@ static void imx7_snvs_write(void *opaque, hwaddr offset,
     const uint32_t value = v;
     const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
 
+    trace_imx7_snvs_write(offset, value);
+
     if (offset == SNVS_LPCR && ((value & mask) == mask)) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 24ba7cc4d0..426a8472b6 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -115,6 +115,10 @@ msf2_sysreg_write_pll_status(void) "Invalid write to read only PLL status regist
 imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
 imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx64
 
+# imx7_snvs.c
+imx7_snvs_read(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
+imx7_snvs_write(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
+
 # mos6522.c
 mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
 mos6522_get_next_irq_time(uint16_t latch, int64_t d, int64_t delta) "latch=%d counter=0x%"PRIx64 " delta_next=0x%"PRIx64
-- 
2.42.0


