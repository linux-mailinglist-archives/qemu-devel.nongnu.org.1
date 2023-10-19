Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6007D03E1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:23:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaSP-0001KI-6T; Thu, 19 Oct 2023 17:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSK-0001GH-Kz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSH-0006Ar-Dm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40651a72807so1001255e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750470; x=1698355270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJumrC/z6YrHaNHaQARwXLPWcCx3YWs2e2GnN7n/Vjw=;
 b=cxYeWkNg8mcEiY1IOAJWxhilVYwleTVqXh0pSa0mnoJQNxdxcOBC9mEBHG/7CV/QB9
 i01eDEYlGnmcf6+nK2P1fRBu+96W2TVpR2ht+nzOm+rzyqqkYDvrXXDouI6pRCMS1rJ+
 Cf9MHOGg67nGrFLV7cOGSKovyGKQpQoPlZE7qdMff+yBbtWta1AVIjZ7sklSz8cLCbjX
 iMcCo1wprt3ra0OHk457ECUHe6HtVlYftqbTgRLSBYZt+VMRWkxDWmfoaIjO7lwx2XgI
 1UO13MOjXwq++MqSyU9N6UxIU43eFpYj3yDG0qpAle56nZNuzoK1fHNqPjdIq01MO530
 VSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750470; x=1698355270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJumrC/z6YrHaNHaQARwXLPWcCx3YWs2e2GnN7n/Vjw=;
 b=Em3MRE6K6ksKFhLGIh2BDIbyXdmZ5GdKRw/bASNjr1EjtFW2zqVl2fz6Uidr0cMner
 MIEewIYz4qLSSc9d7aAQJKgqjr1Nu99cOOwbQ6WiojOSqQcm6TLeM3cUGtt3Z9p9CU6Y
 n32nvwBOtxT5XQ42u+CryZCSt+2KxWV3cSqEOlefkoX92xafvicJqw/s9K4cNa7LHq75
 fMOouPeY99VG8AGBql+goU6T+HjLmmFpeivzgxG6fHJWRVnwzX2vRehaVjDisPZgrAwu
 nM1geCYi4g7SIYqZUeZ67dlWIMdZlPm3f4U3OIT2u8Hf04ch/Kajk9tIlNSAG96vbEdJ
 /Wfg==
X-Gm-Message-State: AOJu0YwKEtEjo1F7UZRYi/N0lLo55G2KClaU+MyWYmeSJBXMj/wh6z8S
 3bmr3Pzq6W5ShRYDZVVxMtuo/gWDDlgF7waWHSb8lQ==
X-Google-Smtp-Source: AGHT+IHH03lNbcJ5UH/MzDTxlaJLA26yiLUCqqmrEqpQaDSP/UkFedVbag4fDbrVyYnUmxz/b5UN1w==
X-Received: by 2002:a05:600c:3c8d:b0:408:434c:dae7 with SMTP id
 bg13-20020a05600c3c8d00b00408434cdae7mr94068wmb.2.1697750469858; 
 Thu, 19 Oct 2023 14:21:09 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040841e79715sm521538wmq.27.2023.10.19.14.21.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:21:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 26/46] hw/ppc/pnv_xscom: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 23:17:51 +0200
Message-ID: <20231019211814.30576-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20231019131647.19690-5-philmd@linaro.org>
---
 hw/ppc/pnv_xscom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cf892c9fe8..805b1d0c87 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -223,14 +223,12 @@ const MemoryRegionOps pnv_xscom_ops = {
 
 void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr)
 {
-    SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
     char *name;
 
     name = g_strdup_printf("xscom-%x", chip->chip_id);
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_ops,
                           chip, name, size);
-    sysbus_init_mmio(sbd, &chip->xscom_mmio);
-    sysbus_mmio_map(sbd, 0, addr);
+    memory_region_add_subregion(get_system_memory(), addr, &chip->xscom_mmio);
 
     memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
-- 
2.41.0


