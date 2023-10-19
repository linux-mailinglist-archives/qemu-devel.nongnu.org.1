Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678407CFAB7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtStV-0008Nn-PQ; Thu, 19 Oct 2023 09:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStT-0008K9-9W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:16:55 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStR-0003jW-LC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:16:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso1282770066b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721411; x=1698326211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xmqRe1DsnbyzHbWXs4yRpTSMSbCbrBRxEfRulLBf67k=;
 b=XR7dJMZqSybe/lJRDCbCD6MxLmZuQn35Z6uo2i/U5SRwdU/V4N3oDgshZGmL48LEHs
 iFdPkC5YG8zdsaqK3eExf9kA4FVH21Bfi3xd8oY9QyolYNJnx4EJHOSyqGDGn73L9IlF
 3Cl+DbgJT5ZcOQKzBxGgKTzFpldaEEwfHeSglqO9yml0WsFfxo25UTQTeFbht4EHEObz
 IHc3l7g1ADh4phZWidt/aHDNwA05S6F6hTJ1MlI43w3DaP/XuV+RNX5HpOsOG541jfyf
 9A4yKgaw9bm/Xq3fqtkie3NGf59n9lr1Y+4ifohsUAFN/+aHpqtGtSBRT0718tslB+eN
 HOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721411; x=1698326211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmqRe1DsnbyzHbWXs4yRpTSMSbCbrBRxEfRulLBf67k=;
 b=PAZw4GsghqyH+ZIiZ+CCtIrxZro03t1x8TRSVVk/Ts53qtk6rNjUff8PJ7/BmtdDmz
 ANhNgHZEtm/UPtExcz/r7J5YNWx7stvPODWJrO1upakUz4CEdaUs0G9x7i7In7wfgj5J
 E2UUtvPPJzbQREcH+6QmSOphL0FVG+BAeBjeRI1unrVnH5SEKKPIuhxVodkMvrbcyIf8
 9tobgxIFOloXCeeuC2+rgKG1pz7xPz2L7eBIVOfVm2A+KSvWs8IFomFOG/hnwmSf2uii
 UPxtHbA5k0ND8K3SrH3QJZFRAC3z1YV7lZlvDndclw60py0Sd+7AgYnARPYa7xMtok/M
 LcZg==
X-Gm-Message-State: AOJu0Yxx69n4X09RrfMgaM4B4jg6YKjiLVCiEdyhoiB8MyBMeaJrLb/n
 MsO89XMX2/Jb3/VeKjI4DSQ6zHm/WPU8x6jVz8nraQ==
X-Google-Smtp-Source: AGHT+IGTz3jwvciO5wEsqRZzzYzHi5dyPhZctakh69vh0mRtcUEQwf4hhXMC0fvv5mBRtQ5qpQiH9w==
X-Received: by 2002:a17:907:60d2:b0:9b7:37de:6009 with SMTP id
 hv18-20020a17090760d200b009b737de6009mr1728189ejc.3.1697721411415; 
 Thu, 19 Oct 2023 06:16:51 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a1709061d5000b009b2f2451381sm3519296ejh.182.2023.10.19.06.16.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:16:50 -0700 (PDT)
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
Subject: [PATCH v3 0/7] hw/ppc: SysBus simplifications
Date: Thu, 19 Oct 2023 15:16:40 +0200
Message-ID: <20231019131647.19690-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi,

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

This series replaces a sequence of:
- sysbus_init_mmio()
- sysbus_mmio_map()
by a single call to memory_region_add_subregion().

Since v2:
- Mention coccinelle script in patch descriptions

Since v1:
- New "Realize SPAPR_VIO_BRIDGE device before accessing it" patch
- Added R-b tags

Philippe Mathieu-Daudé (7):
  hw/ppc/spapr_vio: Realize SPAPR_VIO_BRIDGE device before accessing it
  hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
    pnv_xscom_init()
  hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within pnv_xscom_init()
  hw/ppc/pnv_xscom: Do not use SysBus API to map local MMIO region
  hw/ppc/pnv: Do not use SysBus API to map local MMIO region
  hw/intc/spapr_xive: Move sysbus_init_mmio() calls around
  hw/intc/spapr_xive: Do not use SysBus API to map local MMIO region

 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/intc/spapr_xive.c       | 12 ++++++------
 hw/ppc/pnv.c               | 26 +++++---------------------
 hw/ppc/pnv_xscom.c         |  5 ++---
 hw/ppc/spapr_vio.c         |  3 ++-
 5 files changed, 16 insertions(+), 32 deletions(-)

-- 
2.41.0


