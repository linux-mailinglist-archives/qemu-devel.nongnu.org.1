Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90C792FC0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRe-0004sk-6O; Tue, 05 Sep 2023 16:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRc-0004sI-M4; Tue, 05 Sep 2023 16:14:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRa-00037N-C5; Tue, 05 Sep 2023 16:14:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5007c8308c3so4688279e87.0; 
 Tue, 05 Sep 2023 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944875; x=1694549675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8y2tTveHgptTrcnfgnWm3x/FwZdnV+E+gcbaUOc76YU=;
 b=R0fqOLrrMcpCTielUURch/Gq4aj+ZEAjDgzg6KaNilo2oydE87F2yNLBk4QP1M9yfj
 XqLMnV0OdScp+NcNnr7cvqw6mz9hyLISJzg/bW0OJqW2FbTm2zjC7eP2wRFCGvpZS3WW
 kyhc6PQojkcltUwR/5x1IBU+pik0bYkZy1cHCrWSlor9f/YWyuwLw+S+Tw9ezLw/Buau
 y9/fByG6k38WHChd23dDf7xsUnptbUCnUZDT4+wBOshL/SPOaBx3p+rs4zefHORyLuLD
 ia7FBg+NR5hXaFPb4NMYkjU82lmsepyFbgfx23QdAlZ9ZPK+lMY+/Vozf9ZI942/nbRV
 t8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944875; x=1694549675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8y2tTveHgptTrcnfgnWm3x/FwZdnV+E+gcbaUOc76YU=;
 b=Wptp+dfCqDyS+lF/3Z7J9ZiZwsnSJqRYAdBT5ON3XxpncAhEg/K7GqVQ1tRz7Tm0EK
 VSvKLpGDl9nd05sym21YpGR1DyLBF4wUbKCoS14gOm2gjRN4dXbMvvnUH1NyRbkZThWD
 j8h4NNA+yKtFXsbIRXGuByQvSLr0/f0Ul8X04VfLtcOQXpVbr3Gal4aIq/yzNVeD1mwz
 dZT6+oh+LLD9szPdCP06Ws7s50maF2jFGyryG+N3Z1g5yIHsiUp2IOgNU+xjn2RBD+IE
 o/+0txTPIbcNed3xeaph3JrWWWkNDEmbu2zqL34P5oyAnjXvrsS5fu+pMH1mlpTQGiS4
 lWJA==
X-Gm-Message-State: AOJu0YwV6RmiexckkkNmhgSurcIXpqpVnaPTjfIEvHDfViHIELjuYIcH
 n8qbweAPTIOc0WzBkl6tmSwjF22wd/5wPA==
X-Google-Smtp-Source: AGHT+IFDttP+bobjvqr7HwVs1eHgP1BFUrb2lsH77Ro0oo8YMuJKSKCzq9VtoXI9RJskK1s16FAtzg==
X-Received: by 2002:a05:6512:2212:b0:4fa:5e76:7ad4 with SMTP id
 h18-20020a056512221200b004fa5e767ad4mr934608lfu.10.1693944875061; 
 Tue, 05 Sep 2023 13:14:35 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:34 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 0/5] Allwinner A10 input/output peripherals
Date: Tue,  5 Sep 2023 22:14:20 +0200
Message-Id: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch set adds minimal support for PS2 input and HDMI output for
Allwinner A10 and Cubieboard.

For the display part, minimal emulation of HDMI, MALI GPU, Display
Engine Backend and LCD controller is added.

For the PS2 both keyboard and mouse support is added and attached to the
two PS2 contollers present in Allwinner A10.

Functionality has been tested with custom Yocto image.

This is sent as RFC for now, since there might be some use cases which
have not been tested.


Strahinja Jankovic (5):
  hw/display: Allwinner A10 HDMI controller emulation
  hw/display: Allwinner basic MALI GPU emulation
  hw/display: Allwinner A10 Display Engine Backend emulation
  hw/display: Allwinner A10 LCDC emulation
  hw/input: Add Allwinner-A10 PS2 emulation

 hw/arm/allwinner-a10.c                  |  51 ++++
 hw/display/allwinner-a10-debe.c         | 229 ++++++++++++++++
 hw/display/allwinner-a10-hdmi.c         | 214 +++++++++++++++
 hw/display/allwinner-a10-lcdc.c         | 275 +++++++++++++++++++
 hw/display/allwinner-gpu.c              | 212 +++++++++++++++
 hw/display/meson.build                  |   5 +
 hw/display/trace-events                 |  17 ++
 hw/input/allwinner-a10-ps2.c            | 345 ++++++++++++++++++++++++
 hw/input/meson.build                    |   2 +
 include/hw/arm/allwinner-a10.h          |  11 +
 include/hw/display/allwinner-a10-debe.h |  71 +++++
 include/hw/display/allwinner-a10-hdmi.h |  69 +++++
 include/hw/display/allwinner-a10-lcdc.h |  77 ++++++
 include/hw/display/allwinner-gpu.h      |  64 +++++
 include/hw/input/allwinner-a10-ps2.h    |  96 +++++++
 15 files changed, 1738 insertions(+)
 create mode 100644 hw/display/allwinner-a10-debe.c
 create mode 100644 hw/display/allwinner-a10-hdmi.c
 create mode 100644 hw/display/allwinner-a10-lcdc.c
 create mode 100644 hw/display/allwinner-gpu.c
 create mode 100644 hw/input/allwinner-a10-ps2.c
 create mode 100644 include/hw/display/allwinner-a10-debe.h
 create mode 100644 include/hw/display/allwinner-a10-hdmi.h
 create mode 100644 include/hw/display/allwinner-a10-lcdc.h
 create mode 100644 include/hw/display/allwinner-gpu.h
 create mode 100644 include/hw/input/allwinner-a10-ps2.h

-- 
2.34.1


