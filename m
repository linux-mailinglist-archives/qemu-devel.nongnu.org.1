Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A67C555A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCi-0006tK-G9; Wed, 11 Oct 2023 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCc-0006nl-2X
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:42 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCY-0004V1-HI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53636f98538so11822986a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030676; x=1697635476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYx0Hphe/DTtWkWE81vkY5dy8KmxuvKg06l16M+SgVo=;
 b=JgRCqX8daaRUvqQllr0VMMsacy8Yc7cggnOr/+2yBZ9ODn6efv4mfgExQ8lGCTFKFR
 tr513h/oEBYHDZDvsxYyEXqygBGAAgnr2ecGXam1Edc6pIREQOtW3bITQ33ZRLqSpY4F
 xFyq7aCs8h+otIrvHKHI+ppDXA2V95nC+wvW7YjiqlakGGkVB7N/knkLrlH3jltfT9v5
 IKmtd/nMJut9Lv+VRAOBXVbYFqQKwxbqUK7WhZWd9BRyzXpC6KibMMKU+WAn7aV9rnT9
 Z3kVYQQ/wKn+4sTdq8BySuvExxXKhsvEiO1USTXPf/tM2z+s9HZhrjeSsaZMBInBlasW
 E4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030676; x=1697635476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYx0Hphe/DTtWkWE81vkY5dy8KmxuvKg06l16M+SgVo=;
 b=T1DIqMA/HDPaqd792dpZKx+6flotF/TI0p/G5sQqWkbDJ2N7uiHaxzB0oGxgqq7OAo
 8wKEJ9oPFSCBCyKw0Iz2ZDqv8dQdZRt8NYb53FkLLMsLW9v8d4wBdUDwB4TCKZGxUL9U
 zhNVhZAX+o6ZkLsjgVQqSP0b1Su2ohhDB6cvM9WRe+EQXYTdktuNhC0wBQ3Ode2gwdYI
 UB/uJP03xiHts3wylTaiHCe6DlP760TaZbsnC0awwfF3JQS07mMZNfrIX+81JkZm28zh
 txRc5iNuEYGH19n9CATN5aFHesCsJeQ84KRRqCrSBmyPUEeN5hCKVeK70QZhuIbV09mw
 DFgg==
X-Gm-Message-State: AOJu0YwovgIt3goXTli3pSJowVt/jJNLzfNI2yPQ+1SoEHkmu9eybtHv
 64y5mhHvUJ7uWnl//wIgqbooLpUiGksA6WpsyJA=
X-Google-Smtp-Source: AGHT+IGozyy06RcUFTTlugoU5ak6CXhogLb7TulqxQ3yCMlL2sphqIuVL3dhXt3M7i0g8l+TLFTyHg==
X-Received: by 2002:a05:6402:134f:b0:532:bb18:7986 with SMTP id
 y15-20020a056402134f00b00532bb187986mr18227347edw.39.1697030675756; 
 Wed, 11 Oct 2023 06:24:35 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 i22-20020a50d756000000b0053dda7926fcsm753109edj.60.2023.10.11.06.24.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
Date: Wed, 11 Oct 2023 15:24:23 +0200
Message-ID: <20231011132427.65001-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011132427.65001-1-philmd@linaro.org>
References: <20231011132427.65001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440_pcix.c | 1 -
 hw/ppc/ppc4xx_pci.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 672090de94..e4dadbc84d 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 6652119008..51c265f0ba 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0


