Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC987CDD58
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6dk-0007en-M5; Wed, 18 Oct 2023 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dg-0007eB-TS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dd-0004gS-9g
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso3287228f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635863; x=1698240663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y0+7hkc8r0bhom9dqxmO4lbR5mjdciNCOpFCqrOZhFo=;
 b=Est7AZs68dQAIL1hGoQRx8trBpU5Zlxuy9UA78+6VSCGTij5RhXQOfSPvH7JYVBKkN
 VZCtd9Kgu+rFR0d0jPxlSJ/cda/61zswvCLB+cfBQlblNM78CGZMC0XyNS+eHKIYeps0
 Y4SO52TICXKrTP/X5UocS+4z4OPaSPu9WYMJvV2N5mCdsIpF+YKA8UBQmkg9STC2k5Ei
 G96eCO8fmJdqZEcqDBqM9SN5b7biEQWACCZNeBWrPJ8XlDNp5KIu9bxSXziWbWGYzz7K
 wO/8/3DrpnuI42uXDr4XMKVTztp4mYBxQ10cR/LJMtLYZeNF3vB0CQUg3VZni02T/ycQ
 QTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635863; x=1698240663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y0+7hkc8r0bhom9dqxmO4lbR5mjdciNCOpFCqrOZhFo=;
 b=pzgWflYZLonX0RlhKJw5cl/ulq9S6RC3Zisf/Xlu9p2o0dAWasz4FBuSc6lP30dwpj
 GXW/sieE1O4ZtnuHHqAO/3zwgE5IEsO9ojOvMLq+c360td2ui2tXmFhVVbDaQFKUgUkg
 IMVsVy7lSn7d7Jm8seg7gT+UkxZ85MP9agDKXt5h0XVwqiYtVpaUXoan3bSOKlT/DQCc
 gChAldPMIF5JoGaMdVB9JAteFnNVOCkEtyvuRHVROUrOc3AwiKmMKQ6sEF1xcRCs10d4
 yo3GLKsiz9I8SvPuvheCWG5Q3OM9gXTb/wHVrWnkybv6FEr1lzV/eRbg1w3/BjLlmX8m
 vXLw==
X-Gm-Message-State: AOJu0YxD+ndw6isQ48AB2DfGvBw7kRCNgfh0tgzUzmgyB7w03Izftw51
 tbYNOtKp1iL5Svgy/gJdwN+gn9dBpbqYqvlwlN0=
X-Google-Smtp-Source: AGHT+IG2umFftAOy3IKeTJuNP/qUqljkWYFWUfDgGMiUtX3yusBvy53xrKPidT+RxDUm4NOPujEGnQ==
X-Received: by 2002:a5d:4a04:0:b0:320:bae:2dfd with SMTP id
 m4-20020a5d4a04000000b003200bae2dfdmr4400153wrq.5.1697635863253; 
 Wed, 18 Oct 2023 06:31:03 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 d8-20020a5d5388000000b0032da8fb0d05sm2096419wrv.110.2023.10.18.06.31.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw/ppc: SysBus simplifications
Date: Wed, 18 Oct 2023 15:30:53 +0200
Message-ID: <20231018133059.85765-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi,

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

This series replaces a sequence of:
- sysbus_init_mmio()
- sysbus_mmio_map()
by a single call to memory_region_add_subregion().

Philippe Mathieu-Daudé (6):
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
 4 files changed, 14 insertions(+), 31 deletions(-)

-- 
2.41.0


