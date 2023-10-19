Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C87CFABC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSuM-0000lW-Px; Thu, 19 Oct 2023 09:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSuB-0000Nk-4l
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSu6-0003pV-VF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:38 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-504a7f9204eso10651483e87.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721452; x=1698326252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvrIYZ1SHVtY4jy7jskbyHF3SwQhysiF+69uIEKUTD0=;
 b=XpjDc0mcnutTh+jA7QGjo+csB14uTgnW2FpOTyWMRnA2xuGlbZfhnb9GaNeEc5G6+Y
 pCz0/WtyuHxQDQz0SFJvZTo+oBAVH0bCayuWqEGmdH1LeZMLV2OaHQGcpFeMeIB0fls4
 RF6e0P47JOLrxQ6ZmLxkMYrMhc9U+RSDtdFhtXN/kDpuQiVnCT14rHdTGPD6eU7eu0xk
 cc9xKzHuRGosPwY1fxF6WqpGrlikJRT1SQP0C4tbelPWIEY97865jp2yZT54/FH92t1N
 Y5ZBwEYj/elT+TzhdJoZ1+zh5RrioEWboV+OcXoOkuyVK7e7uOqtM6CuoqRH9XxxApcn
 ZfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721452; x=1698326252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvrIYZ1SHVtY4jy7jskbyHF3SwQhysiF+69uIEKUTD0=;
 b=GmSzIVq31pplNB9mVn049tKzPZEUWm+int3f06iBKyA4nIHOMLBzi7UvRySRy9ILIF
 +iWeTMIusNWh5cOam6K8GzxXFhYC22K5avW3oXNm1e2gAFHJIT22011bBISiweT0/lSe
 vuHcj5KmpK5O1W5mkIl7K+q5Ylp4GJqZPi6Fw6FKSvd38A7kiH26nVKXw0+Pdhn/7Jx6
 i2yOtkDSy263RAGUc6FLI0un+jWKPqfDnOYg5tc5BAMuewCBv4b3cv9oAwuuNRl7ogIk
 Ko0Ukrb2SIAaTfuHNiIjaK1BprgFXWuD8q1C+xrrNKc2e0MU0UfZzJTXZltALlNvFos9
 C65A==
X-Gm-Message-State: AOJu0YxxrgPYdNN0MNvGuxvpMPqIhj8+/e8M9sttkQDsdhtMdd0VtUdB
 ZRhfp1cg3wnHR5iaB0EMSLkjXzuwCMLkegsS3UNRWQ==
X-Google-Smtp-Source: AGHT+IGOsdnA7Ew/2fjx5ZlDmAqAzc0hBWvmX1qTKThHijrKohIJwepl7gLr7Sq6nSP6QHo6LwfZKg==
X-Received: by 2002:a05:6512:32ac:b0:502:f2a8:d391 with SMTP id
 q12-20020a05651232ac00b00502f2a8d391mr1450014lfe.45.1697721452136; 
 Thu, 19 Oct 2023 06:17:32 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 bt6-20020a0564020a4600b0053e3839fc79sm4359878edb.96.2023.10.19.06.17.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:17:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/7] hw/intc/spapr_xive: Move sysbus_init_mmio() calls
 around
Date: Thu, 19 Oct 2023 15:16:46 +0200
Message-ID: <20231019131647.19690-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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


