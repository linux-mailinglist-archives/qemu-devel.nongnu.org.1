Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFA83289E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmpk-0007bg-6F; Fri, 19 Jan 2024 06:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpd-0007XE-5M
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:41 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpa-0007L5-HN
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:40 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so438008a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662875; x=1706267675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfuQXxmvX9JAP4TN/xfu2dZ/IwBEFTowVO1pKbfDK8M=;
 b=j1nNlSSLcERYw9DYo2XNheUZh05Q6rrQ68bCB2+bN/iREWZ+/FB8rXKOFxvbLA8Hhy
 Nlvm0BdT+9w9rhAPZPVfsDRkaxe2CXN91RwZweZ3nGP5Ru3Rot+z3TQ70mdeXwBf1WkE
 WmaF23kAiLPoE55X6hkrlonF/KIfpBkFhhYM4lZ+FqOMwBKJQ1XuhWOkGYcj+ptT/c8i
 YcbWnWAFVFP5/3K8rrC59AATJaBiUbZ9oH4rgJwCY9qEZSKCsywlV2DMmqS90eUpnqVM
 A46tR6P4k5NmyrDyj+qHwT0AunzzXLQ+w+6BUMjHfAwUJfnpX9UkZ6FYO5zlBtcDGXVX
 OdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662875; x=1706267675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfuQXxmvX9JAP4TN/xfu2dZ/IwBEFTowVO1pKbfDK8M=;
 b=jDfeFgbgPMeXK223VEzpQrLxr383Gt+1ItndaSjjcx3wq25BQ7swiB0BYCQYgN1Rlb
 +nRl+YYaF6lkxeVo1AXYYYIMPPPQIvo5D2FxwmLgJvCOYi2+ErfV8nUIBUhitbV2GI0y
 ol9rS4r4m1BHSu0EArVJzIjXdPyANdpFjtH1BZbN1iQwkHfzUSUyfWAyLMerh+6VKLwv
 iFnE84L0pbPtA/hZAVJCowHG3jdBj1PhAGRxWA0CaugVufn3l0tf14FkwCIt4S/BV4Id
 GqKWk4FRynzIHb8T1BnRZBdsIDcadfstuOsouQuWiwNv8e0kI8PteS4KLGeaffytTArJ
 o6GQ==
X-Gm-Message-State: AOJu0YwF28sKdBPNybd9XvC4Bgh9VNaxN44+QEzfJffAQgimeKl0PxCY
 1o/U2FzKEjqMTq6JWUiUq7OnFiyhReEhQx/e4WB99QuO9PijAHM2CXI+A9mZqFwrEVeDiCSviZN
 dn2g=
X-Google-Smtp-Source: AGHT+IF4AKB3i0EE93JVm2SSXHrrPDR51ugIZukdaXM3CyfR1H0BSql7r9j8TEJPqMkdOzhg3JEZ+A==
X-Received: by 2002:a17:906:5592:b0:a2c:2185:6dfe with SMTP id
 y18-20020a170906559200b00a2c21856dfemr1442314ejp.105.1705662875311; 
 Fri, 19 Jan 2024 03:14:35 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:35 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 6/6] hw/xen: convert stderr prints to error/warn reports
Date: Fri, 19 Jan 2024 13:14:24 +0200
Message-Id: <a741c525845c8df4088e358b1c255828a8d3d956.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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


