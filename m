Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D102F7EB4E4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:32:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKN-0002zc-DN; Tue, 14 Nov 2023 11:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKL-0002y5-HH
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:49 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wK8-0006RD-CE
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:47 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso854648366b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979493; x=1700584293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6R5SODDqvfe3Gp9I1X7nXyO5kwGwphXiKxDLZtl7/E=;
 b=Jq8HK6cnlnCiO7p56D6R7j/KACLKRoIkSITc1vEoeIf4vDuY/tjkzx7jyJGxqVVWpP
 GYJvrutO1bef8/WYW2uOfJU3jAYTKvasvyhm5fEXvkKzV9FBvTEtRpU9i5zvQlwmkzX9
 4f6q/AniHIwus7ZFKs+X4kcf19XGaFZmhAjhLfnMM2j3UfD0h/OQxs5IfynJ/KedChUn
 Ldvkl5DWpUR0MeaB8a+i0zfzQlf+hpZiQJSKaO32q6wDA76VTXkKtcaoQQsVgxwSxLmx
 q/FWLOlsnEQdgYJKkQBh4vuf+19S2LJ8Exzwj68NNV7aSbSYsboaJV4eTe50skWsRx+w
 Vc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979493; x=1700584293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6R5SODDqvfe3Gp9I1X7nXyO5kwGwphXiKxDLZtl7/E=;
 b=l7qy2AihjjNJRQcgqdx/4OxD7LTcI+3/zuIN+WI0SFmTDmKhI3Z8bsg+VwrWSZq6qP
 Z3RGfyKFVXXk2EY3Uiva8h9Ep9TQ1uWdstLDzEs7I/vSx+KzZu7vJFwVUf0icZuaOIK9
 d/yL9KQhhkQaQUgs5o0m4TDrfkGiKC8TX50dplIK08E0v9drrTfNTMpRPaxIA6abOY3y
 mL4fteTSnZgWQiwzXhNiUQcm8V19H+Ny+Jrg3Vkp13kFw7v3u3UKeil5Muo2gktCcD8W
 9iirgpVrilACu03PGGnIdHvuFPomTa69arXPK1ipo067dVl3TVkQQxDYNJJvKoqmVE1B
 ReQg==
X-Gm-Message-State: AOJu0YzYNWjobx+LU+IkRCqbtNfSQlBEIn2vWhhon//oK/yIlEkaxNwC
 aIFKMP9c+HgDBWSS6duvpA9GgbLZNWXYtWv/etY=
X-Google-Smtp-Source: AGHT+IGutQxHrTQ0PDT/rm4Hi1BwUJSaiBc/cWKJ03y/patFhv44C9aSztIA1kKfAa9MrKB6HwgJAQ==
X-Received: by 2002:a17:907:1c9b:b0:9e7:c9e3:d63d with SMTP id
 nb27-20020a1709071c9b00b009e7c9e3d63dmr8902204ejc.7.1699979493603; 
 Tue, 14 Nov 2023 08:31:33 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 dt10-20020a170906b78a00b009a5f1d15644sm5694182ejb.119.2023.11.14.08.31.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:31:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.0 1/9] hw/xen/hvm: Inline TARGET_PAGE_ALIGN() macro
Date: Tue, 14 Nov 2023 17:31:15 +0100
Message-ID: <20231114163123.74888-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use TARGET_PAGE_SIZE to calculate TARGET_PAGE_ALIGN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/xen/xen-hvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f1c30d1384..8aa6a1ec3b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -678,7 +678,7 @@ void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
     trace_xen_client_set_memory(start_addr, size, log_dirty);
 
     start_addr &= TARGET_PAGE_MASK;
-    size = TARGET_PAGE_ALIGN(size);
+    size = ROUND_UP(size, TARGET_PAGE_SIZE);
 
     if (add) {
         if (!memory_region_is_rom(section->mr)) {
-- 
2.41.0


