Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC37EB2A4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:42:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uYx-0002jl-Ds; Tue, 14 Nov 2023 09:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYt-0002iq-F1
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:43 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYr-0007la-RS
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:43 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso850689766b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972720; x=1700577520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBdIXHGvx5/0R2xC8Q+GilhuZtCQOtnJ9hpGFyppJEE=;
 b=nLbhtWd/5YntwaQpvKwUwyCvNs0qO/LLh+3Gk2jDk2CfPIlLhdAo2c5p+QDPHzBUS2
 YFHOb4WKis6+ToDiPYMdNFaqf+H0GYqI/KIOuUIamF97SQl/QOhvPasMWn213vsBUwgM
 JeBKnBt4PNL+ctKRIAXPb4+LllTpzU0OKjWYc54IAO9yCaf/xN2IGuc6NEl9fSUXGsW8
 piZd+GzsjbzhAg2hC5wC/NPox4Cm3OZHci9ug2Gb8bLA7DuFQxuV9IxLI4hNR2WW0ZUa
 5NvkZJnWqGsaHpXA7k5hAIIGNPkTcQL5mOlv+OmOM/vwyBxOwyKqcAfKY844H1LHUlqK
 o6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972720; x=1700577520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBdIXHGvx5/0R2xC8Q+GilhuZtCQOtnJ9hpGFyppJEE=;
 b=OXTNWKYQNiNwxGPLAXSHa7Lb4kZcHsfVwf0T4aOJhZohpHETMJIRoAY6YDEhkeyOgx
 nnmXhGqeg4ecZFXEaO7LKxhuiRnIVAzs5V3Ra4cN28tEIDWrhgRS6v0gUajnBn4Jeipc
 MEGLgMGhjjqN9dm8wYTbFawXaiOBLEGFI3YSoNpJkbQeMzeKE1o4nTqHJmwh22sEDtQh
 RUUjCPrlfTojtmL6mRXMjKU0uEQu12B97Uh6dSiVuQgUHhVq1t+iiNNXdm5i1UlBsnZ8
 h2a28xj+tPGNyeWmnGjv3AsU4V5zLWa4i1q4y4UfyifCQzV01Jc+VGWuqhPBiUM8trYa
 Vr/g==
X-Gm-Message-State: AOJu0YxwFqaz0/lHCicUZ41B7/LTNGCDLUdLxCPTmNColGWjfZysHABZ
 uTPGo8Fu0A6x9DYGbQCvfYriBw==
X-Google-Smtp-Source: AGHT+IFii/vTCRNAFXoxhgp7tKdZ5NzaA4D0hMTO7kCC4hnZ5p3PauJ+Zda1OHH5OQndb4HCu48Kbw==
X-Received: by 2002:a17:906:6b97:b0:9d2:e2f6:45b2 with SMTP id
 l23-20020a1709066b9700b009d2e2f645b2mr7411114ejr.71.1699972720502; 
 Tue, 14 Nov 2023 06:38:40 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170906094200b009ad7fc17b2asm5613097ejd.224.2023.11.14.06.38.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:40 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 03/19] sysemu/xen-mapcache: Check Xen availability
 with CONFIG_XEN_IS_POSSIBLE
Date: Tue, 14 Nov 2023 15:37:59 +0100
Message-ID: <20231114143816.71079-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

"sysemu/xen.h" defines CONFIG_XEN_IS_POSSIBLE as a target-agnostic
version of CONFIG_XEN accelerator.
Use it in order to use "sysemu/xen-mapcache.h" in target-agnostic files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/sysemu/xen-mapcache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..10c2e3082a 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -10,10 +10,11 @@
 #define XEN_MAPCACHE_H
 
 #include "exec/cpu-common.h"
+#include "sysemu/xen.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_IS_POSSIBLE
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-- 
2.41.0


