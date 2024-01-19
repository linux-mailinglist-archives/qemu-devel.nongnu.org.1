Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132F832A5C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoru-0005KC-PI; Fri, 19 Jan 2024 08:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorm-00059n-BO
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:25:02 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQork-0006qg-Ei
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:25:01 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55a685e6299so517434a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 05:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705670699; x=1706275499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfuQXxmvX9JAP4TN/xfu2dZ/IwBEFTowVO1pKbfDK8M=;
 b=yzzI4nCzIs4Rr4cYLVOBM0tnAg9NNDDz0H+KczySnQGfdMrFlRYuECaJkxUjMxziMy
 AoCtw+9rdJ84FLcuSqzM3aPV0uSNB20RDi0Do7v5S58nwkuCs9ya9UFcMMOLq/2auDue
 QAvwIZmaMXfNGWrHn262DJDMWvBAEshfp919AG4jHz95Gj+L4IffaH8bh9m+/Qz2OkxL
 AUjf/VBqpQqBwxaA71brBofg2pG4rrgSS9/VXKGV8jN/n5wyXOyUewbPujAV3HKnDK4e
 eUrDshCSKS5drpTndaZtriJsgkGsznAmTB6Z+8MYjHwUjnTmhBP6eQqmPFpTgRFGeu0q
 Cygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705670699; x=1706275499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfuQXxmvX9JAP4TN/xfu2dZ/IwBEFTowVO1pKbfDK8M=;
 b=IhkH5PvutmL9Ie+3JrL+TQI2UMCIxFKj7MqP1lZBMLQSfB5Gbd34mfytOb4gow3RUF
 DuNdPpr0ury+qCUAEw2hSue1gSmOjn/u2Y5BeEiLdbjYs4+opecD5uJsJTmpnW+5j4/j
 wkyev5aDILhUlZpkUG6tiDwQk8zLKt7N8eALK4FYd2p64u4fn7nuzguc6FHXkqBMmY+e
 doHpUi9B1d+3ZeCcjRDOpsZsclTkyGoVvEgFhlmEzjCj9WUoKGF2AzNA3C3N0q5UeN6t
 gGG9sUOVj/9SdD8SXf3gw65La0AOjuuX+8KTIA6N7OULNihP0DXbek0A9Dzmw4HxzlfO
 kPQA==
X-Gm-Message-State: AOJu0YzLSW8oeaQOgPhPtyA0+9UnJqKoke4csYuJfusTZDl7SQsi8Sdc
 16Nc+24ltGVDoJL27v6O2FfBNO+uoxkPBIDgk8B00KQPMOjElhmP22kXsoMDf7CxIVe9mYQMCRj
 XKhY=
X-Google-Smtp-Source: AGHT+IGSoNv5INVnSqko5OrH7zTf+jb7pBx9jX4flwfLWo+bpMWVQxBgd75egqiSm83wZgZZW9SGQA==
X-Received: by 2002:a05:6402:c16:b0:55a:6086:7e1e with SMTP id
 co22-20020a0564020c1600b0055a60867e1emr457236edb.75.1705670698789; 
 Fri, 19 Jan 2024 05:24:58 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 b11-20020aa7dc0b000000b00558fc426affsm8568310edu.88.2024.01.19.05.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 05:24:58 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 5/5] hw/xen: convert stderr prints to error/warn reports
Date: Fri, 19 Jan 2024 15:24:47 +0200
Message-Id: <bf5504369023dc115f0d7a756c4c5254fa9cd10d.1705670342.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

According to the QEMU Coding Style document:

> Do not use printf(), fprintf() or monitor_printf(). Instead, use
> error_report() or error_vreport() from error-report.h. This ensures the
> error is reported in the right place (current monitor or stderr), and in
> a uniform format.
> Use error_printf() & friends to print additional information.

This commit changes fprintfs that report warnings and errors to the
appropriate report functions.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/xen/xen-hvm-common.c | 12 ++++++------
 hw/xen/xen-mapcache.c   |  5 ++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 05a29c6f11..baa1adb9f2 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -20,8 +20,8 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         /* RAM already populated in Xen */
-        fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
-                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRATE\n",
+        warn_report("%s: do not alloc "RAM_ADDR_FMT
+                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRATE",
                 __func__, size, ram_addr);
         return;
     }
@@ -552,9 +552,9 @@ static void cpu_handle_ioreq(void *opaque)
         req->data = copy.data;
 
         if (req->state != STATE_IOREQ_INPROCESS) {
-            fprintf(stderr, "Badness in I/O request ... not in service?!: "
+            warn_report("Badness in I/O request ... not in service?!: "
                     "%x, ptr: %x, port: %"PRIx64", "
-                    "data: %"PRIx64", count: %u, size: %u, type: %u\n",
+                    "data: %"PRIx64", count: %u, size: %u, type: %u",
                     req->state, req->data_is_ptr, req->addr,
                     req->data, req->count, req->size, req->type);
             destroy_hvm_domain(false);
@@ -758,9 +758,9 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
+    error_vreport(fmt, ap);
     va_end(ap);
-    fprintf(stderr, "Will destroy the domain.\n");
+    error_report("Will destroy the domain.");
     /* destroy the domain */
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
 }
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 336c212376..4f956d048e 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -347,9 +347,8 @@ tryagain:
         MapCacheRev *reventry = g_new0(MapCacheRev, 1);
         entry->lock++;
         if (entry->lock == 0) {
-            fprintf(stderr,
-                    "mapcache entry lock overflow: "HWADDR_FMT_plx" -> %p\n",
-                    entry->paddr_index, entry->vaddr_base);
+            error_report("mapcache entry lock overflow: "HWADDR_FMT_plx" -> %p",
+                         entry->paddr_index, entry->vaddr_base);
             abort();
         }
         reventry->dma = dma;
-- 
γαῖα πυρί μιχθήτω


