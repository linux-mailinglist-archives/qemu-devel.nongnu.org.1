Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3C7CFAA6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSqt-0008DW-SW; Thu, 19 Oct 2023 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqU-0007pT-6F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:52 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSqS-0002Z8-7z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so2235741fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721225; x=1698326025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvrIYZ1SHVtY4jy7jskbyHF3SwQhysiF+69uIEKUTD0=;
 b=j1IZgfB0cbnIrIT4fOqb20s9nnxwsH2A6l8DkzY1txv6/lP8uuY7rLGaJnhcxPWh4z
 gwPZbb0KgCVRFAPqgVipcGW6NDxRMbhyFWa5o14+B4JLyldSgnsqILblsi1mi3GgKJ7O
 Rz3mOOQF3uckjhwgcLZCUmtXk1sz0qL/XwGQl+Gh2j9jNbhL7aW3yl+Noy4Ql8FxhhiH
 NpgewVDg6xJd0IWj6upseLThJY72CzbU8JRkw/SSGRUh9aROCodWnGa9dndtXENbW32O
 6EBhWNr7klbaUonjsBAbd0IvxWFWgIkJdmHWuVGJfoPpcj11/H66Rc2sDwGk29lAwmPu
 jmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721225; x=1698326025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvrIYZ1SHVtY4jy7jskbyHF3SwQhysiF+69uIEKUTD0=;
 b=N8ISWRTYEwMOOfa6NKULwwD57GrSyw4j9xxLGcaBCn36grVCeLuHSbE3xi58PkqbIj
 btrUVus0lYayH1iwYV1glgR2z5Hb81CY9p4RBSOqVz/5fkU6VPMUOXAJubyQ0N7f4BZg
 nTsx5+TVJHOoj76b3fuRgLPvIPrmFMVj2AkSwYCfpRpiZLf7xSrlwkR42p6GM8CJDOmO
 B6+S2EAbae0Xj8kQORxLRl0SgwpiyxNp1I+edVFz0nQRpBJ/t79QurJE8v+5l6Ql3bU4
 ydKCRoCRT0EG3qIE7geutMqzNRaVqX5NPvbOHjCCLA13M76BFkpEyd50+Ds1NJjlFx+V
 DZ5g==
X-Gm-Message-State: AOJu0YyFGoCTRuHp94SCmyI4yNAfKcI+J6y53ngIw8N9enwuHobr+o24
 QN9FJYBlMBVfDZU2eN43cByQ738yrjUubXOzuzydqA==
X-Google-Smtp-Source: AGHT+IGh521xT62aOCRYydIsAR1LVelmUqVQtokkq5wdwus576n16xHQv5E7EmOKSnupqiyAtlI4rA==
X-Received: by 2002:a2e:b601:0:b0:2c5:1a89:41c0 with SMTP id
 r1-20020a2eb601000000b002c51a8941c0mr1337177ljn.23.1697721225070; 
 Thu, 19 Oct 2023 06:13:45 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b00403b63e87f2sm4506590wmq.32.2023.10.19.06.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] hw/intc/spapr_xive: Move sysbus_init_mmio() calls
 around
Date: Thu, 19 Oct 2023 15:13:04 +0200
Message-ID: <20231019131305.19157-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In order to make the next commit trivial, move sysbus_init_mmio()
calls just before the corresponding sysbus_mmio_map() calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 hw/intc/spapr_xive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 7f701d414b..12057ffe5b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -316,7 +316,6 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
 
     /*
      * Initialize the END ESB source
@@ -328,7 +327,6 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
 
     /* Set the mapping address of the END ESB pages after the source ESBs */
     xive->end_base = xive->vc_base + xive_source_esb_len(xsrc);
@@ -347,14 +345,16 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_ops,
                           xive, "xive.tima", 4ull << TM_SHIFT);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
 
     /*
      * Map all regions. These will be enabled or disabled at reset and
      * can also be overridden by KVM memory regions if active
      */
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
 
-- 
2.41.0


