Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31C27EB2B3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:44:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ub6-0006g8-Oo; Tue, 14 Nov 2023 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaN-0005TH-Rp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:20 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaH-0008HN-V8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:12 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso855681866b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972808; x=1700577608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAcrCtDRFE27SgAEHRwd23jK5KSLpjZ+znXdyGAiZas=;
 b=pw4rr5y5YglSRcKSHE5jDik+jl4PM6PNbDi+mule542cInNX2HTpV+fc8yjZDzGp3Y
 4nnNPI51CyG9sbjzbyaeDyunyqG6McZRMtzsjT6oQUxAhg82mNCeTGwsGeHWnRN4fmZo
 YpNiPjq5EI3OWmofH8/gd9tGFR6Kc8mi+h/ikzC3Cgg50/jyBUwgA44Hi/EG41Gi/ENB
 SSTle2jsyQVzWNrFHXk62KJlgZJYRPM2FnEO0CC/x76V9NMPqD+ActaZoLTTQLhTt2j2
 kKN5Cp/g3jLO9L7Nw5pC88246QCjpcZjpSJPhT2sZHYJ1fBx19ulecrCYt+VlmARaJ6B
 qDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972808; x=1700577608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAcrCtDRFE27SgAEHRwd23jK5KSLpjZ+znXdyGAiZas=;
 b=qib3eDEYqd7gpXD5Lu7Bp6DtThDsrXRTFUQl1y0pEDzXmnokTf2xvrOpLwCIMGg6tv
 mgOBAhsxzVSTwhttar6Yix+WvD5+eSC6Qs9Th5A6UXTMjl0ttY42jk1Wj3ZLSZaJonFk
 lCo0OrXhQYAkiMlkOiy0CAfvHz2jUS+DvGJnGgsNW6GF4aQXgAv1/gkgq0hm8h6QAIk1
 ntFQhQKK5YDQke3qAqu8wUy7dKXzTPM+qrh8hxsitZPhcwzkrvc4W616XTs8JcE8hAKg
 lRUlz9vB33eHfdG4b85D53BPsLeisOiY5BlXQWfQAutWy4m0c+L3xlQ5L3ROMua1mA6T
 dNiA==
X-Gm-Message-State: AOJu0Yxu8+8wkWvBIq9fX5IEw0vyQGc/oqDVg6rZdYiwMTbfhCYCu+o7
 zJuxcCZ8slARX7biRYOi35Mk/Q==
X-Google-Smtp-Source: AGHT+IFRbdN3aM58BgezwVky3EFK69MoaorjbUe4txfqvi/Mr07fntHT95KnMqBlE8Dz9TGy0ZX5tw==
X-Received: by 2002:a17:907:9848:b0:9dd:5adc:b1d2 with SMTP id
 jj8-20020a170907984800b009dd5adcb1d2mr6678484ejc.38.1699972808614; 
 Tue, 14 Nov 2023 06:40:08 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 y10-20020a1709064b0a00b009dd7bc622fbsm5606206eju.113.2023.11.14.06.40.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:40:08 -0800 (PST)
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
Subject: [PATCH-for-9.0 v2 16/19] hw/xen/xen_pt: Add missing license
Date: Tue, 14 Nov 2023 15:38:12 +0100
Message-ID: <20231114143816.71079-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Commit eaab4d60d3 ("Introduce Xen PCI Passthrough, qdevice")
introduced both xen_pt.[ch], but only added the license to
xen_pt.c. Use the same license for xen_pt.h.

Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen_pt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 31bcfdf705..d3180bb134 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -1,3 +1,13 @@
+/*
+ * Copyright (c) 2007, Neocleus Corporation.
+ * Copyright (c) 2007, Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Alex Novik <alex@neocleus.com>
+ * Allen Kay <allen.m.kay@intel.com>
+ * Guy Zana <guy@neocleus.com>
+ */
 #ifndef XEN_PT_H
 #define XEN_PT_H
 
-- 
2.41.0


