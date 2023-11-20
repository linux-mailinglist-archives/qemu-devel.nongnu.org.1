Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4F7F147A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:32:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54NL-0002M2-HH; Mon, 20 Nov 2023 08:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54Mz-0002Au-AO
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:31:27 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54Mx-0002Dl-Kq
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:31:21 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a00191363c1so63737566b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700487076; x=1701091876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfC3l79DWpuZ90eQhFhTtFylDgZoM5JZUYr7UxSsrVs=;
 b=sO6zfui6dwJ6djVRAPJuB7SGOK1vmYUmSa+RF7HXmWbuqvoQAH70CALaMYqkzcuMMK
 loxV4malG4EIJg/AMn81g5ddChJnnp8GH0Zt5VHmppxHsnUmovRiwtliJZ0g5t/v4zn0
 E2ocRqIJlFoyz0q+FsTNRV8xAUAq3UtswXgsXMjJil4TtejC1fYAjd5VekwnpFcLS+rB
 wpiWYDB3iCU/55JePRpr0ir0OS/ghFxUFn+IdJfNXLce7X6trRd+xRtxaJX0OF2Tc1lg
 ltJ/FxuBJnFViMzr4NJLVVIR936+XEU6br4217Q38+zn8NwUSAJFpl2omUm91nXbein1
 e7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700487076; x=1701091876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfC3l79DWpuZ90eQhFhTtFylDgZoM5JZUYr7UxSsrVs=;
 b=HqXJxjLIpgVn0LlRLVU9CSgDBprtKKE94D/ylTCc/mUjgLyB+mymb+2Zw8oIBmlchm
 2s8xUM+zw7CecYFoA1THOc+Rr+cfWflfRwCh/CtKuq3NYcaLaEGXFchASmKngtCtfFN6
 db8W8Z2felzwgUZIxHwjNwUCNQKAvO8hLytcwXF0XQk9Pk2Q6lqQw6uxCV/XkyTL69iM
 hk/DYckTHvsOTAOq2jaxWeFrYbmNry0++Vo3GZjrFNDjZ8bu/aGKo5UjaApT2SsrTzBT
 vucrev0uLwGrrZZ9wNQ5aR0OlE15WA3TwNh+9NNLbTT/9RF5qSEIjLT/iKrujiSFB61U
 OhRQ==
X-Gm-Message-State: AOJu0YyEdACzcRATcyN2O827r51mvRpcjFQHUdc4nE0xtHwkA6++qRUc
 92hD7dP2ddzf1Nt6861sRE4i9MtCZDFhdRBPhEc=
X-Google-Smtp-Source: AGHT+IGDJO1pHsPU1hxcgLfrpgQ1N1NW+jSbv2/n7+BaKcLXxFKhqCTc9ewjR8kxQtRpDsTTbu0vYQ==
X-Received: by 2002:a17:906:3986:b0:9d5:ecf9:e6b5 with SMTP id
 h6-20020a170906398600b009d5ecf9e6b5mr5056721eje.59.1700487075801; 
 Mon, 20 Nov 2023 05:31:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 sd22-20020a170906ce3600b009fbf15cee7fsm2087892ejb.69.2023.11.20.05.31.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 05:31:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH] system: Use &error_abort in
 memory_region_init_ram_[device_]ptr()
Date: Mon, 20 Nov 2023 14:31:11 +0100
Message-ID: <20231120133112.82447-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

If an unexpected error condition happens, we have to abort
(&fatal_error is meant for expected errors).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 304fa843ea..4d9cb0a7ff 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1692,7 +1692,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
+    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
 }
 
 void memory_region_init_ram_device_ptr(MemoryRegion *mr,
@@ -1711,7 +1711,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
+    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
-- 
2.41.0


