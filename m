Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 976747E9FDE
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ylc-0002Rv-9q; Mon, 13 Nov 2023 10:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlZ-0002G9-LY
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:21 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlN-0003Kl-4n
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:21 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so6294104e87.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888927; x=1700493727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3IanRET4oRDB/554uZaBMmk8ZcCL79rxTcGgU2jVuI=;
 b=Zmg2Z92S+ZAynF5iomHSrDgJJtlXQgUrtUCYMJ0vjXah747IeUFFrnG+m80K6MmTTB
 GDMmNOj3C+pY/A3RGXvVjzMnqRjdPN099Ast/TTi/arPfr5ChcBEHGOoz+LaR2U5tWPy
 nQoGRlBsStg0xmpz5WlMN9zzxJ1YoAhTGOiZWq7wCMs0yd3cic+ztoDBzWUXIQYZiuHy
 EDktE/j0TJ4veZ81zjr0bR5XbJZG6vt1+RQtQ4daf7ujYb9/jah9OZoA+/hVurT89QVT
 65Vnb8axpOZ4e3GDZy2aWCl8bnvAwXHDo8ZxxaSVUMFDQhAtKOBA2YgfwqfCsqFCNruu
 cPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888927; x=1700493727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3IanRET4oRDB/554uZaBMmk8ZcCL79rxTcGgU2jVuI=;
 b=iJNZwnf0+giQTCm0HmkpkG7nohQir6fT9TVxKzNSNPFmEd9aUwMFBjhBY+A2MBvttv
 jXO1mhGJzcJCml7aaOR/Pb+e5BVRYh1spqQbiQPDwsK6ZW4zDRbZc5z5KzfuGyKsp3sN
 BsxzipEH2nsWGxHqV2lddG7zp+AdRjaPcT7WXJesKpyX3ewdhMkJXp9hl01bbmhH2mGR
 lAi5PHtV3xeZrIW/hqfmgqNNyWTwLN723KMgMVbEbDAP+IF9yfuQNJz/RHtxy28yUuMq
 EQCBAd/dxItQ2GGHewk6fX6vY276WGh0ssu+YChy4qhkBhQI8yMjGCzylNS/LlRGi9Zu
 0KqQ==
X-Gm-Message-State: AOJu0YzjAOCGLfWsV9ujqCBVVOza2p2HcT3Z0YRHMPg5GIFNR41ibWw2
 aBX7RPp7+PRVG03FmrEYFI1kVA==
X-Google-Smtp-Source: AGHT+IGrSDy3wD9q51MX9RzmoZqMhawPjp2jB+lPSAfi/Dv8LmkQCpZSU6Ww+isXzJecNCmpib4vPw==
X-Received: by 2002:ac2:5e6f:0:b0:502:a4f4:ced9 with SMTP id
 a15-20020ac25e6f000000b00502a4f4ced9mr4406770lfr.62.1699888927362; 
 Mon, 13 Nov 2023 07:22:07 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a17090640c900b009e5ce1acb01sm4126763ejk.103.2023.11.13.07.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:22:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH-for-9.0 08/10] system/physmem: Only include 'hw/xen/xen.h'
 when Xen is available
Date: Mon, 13 Nov 2023 16:21:11 +0100
Message-ID: <20231113152114.47916-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

"hw/xen/xen.h" contains declarations for Xen hardware. There is
no point including it when Xen is not available. When Xen is not
available, we have enough with declarations of "sysemu/xen.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee01..fa667437da 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -35,9 +35,9 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
+#include "sysemu/xen.h"
 #include "sysemu/qtest.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
@@ -51,6 +51,9 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
+#ifdef CONFIG_XEN
+#include "hw/xen/xen.h"
+#endif
 #include "trace/trace-root.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
-- 
2.41.0


