Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292437DF90B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:44:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfW-0003vI-BF; Thu, 02 Nov 2023 13:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0003Cx-6p
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeY-0002jQ-PR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so9545565e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946725; x=1699551525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqJpZDE/iTKqMgJkXz9zHkvEVRtZ8ol0kkFTVeB0qSA=;
 b=Jf7gvPzJkiaCUGfhwAEfYBT6RGPd8n+SqNTS9k8PVJUisYVunVAnTFsi9UY16OgDsv
 hlzOiw7JowZlGn0U2EFFYR/TYoYcoZGUmfxWD3eiwGqWGYJBdwHg4ldHZ9Fah3MJn20C
 JD+2unIXRmPmeH8HOr72MczWzyv3wc3RlT3FYsfsTtDzZa3by5cXgYhiAIifp+SmiDBF
 eFeqgmF98pN8FMIzyFkeaTnTy2H1PxRmgl+AQbZr9FL9sLiSEHaptyN0i0CRQz4M/yJ2
 QIAdStJ6+sfddWqELQywRDTzu3zlHnb+A42TxHENR5uBn9OcVxZT0GzCEig9EzXrthTI
 5jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946725; x=1699551525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqJpZDE/iTKqMgJkXz9zHkvEVRtZ8ol0kkFTVeB0qSA=;
 b=Cax4o8jKKwDYw+77QTyBi3uLoMhInhh1pfsqQGiYUHrDRd0lVV2/OigP26ENtcK/g6
 Es3Q6vOhslgHes/GWWWmY1IClHDNn0P5f6sAgOeufIRtAReeuCjQLgUIb224HZsNTTFm
 9aRJT2mXtZjpHfRWSX6Hn0+tRPe882CkYtV5jnPq1K2+u8kib3unMyiVr+CaEdQzdbKw
 MLzlpR8pxWtERBvUgAeOZu8ceKQcaUeG5YspC7HDwSof2pgOzEd5BxtbhRLq2Fzjqndx
 yvqQU4wQWwLm0SgcDampHKsOs4L66OMOGagIJpIv4KYx+eyq3se01+gNQy12DbwSvVnr
 /7tw==
X-Gm-Message-State: AOJu0YwVUw3xNuLpFoWecEZ1hxlRqM+7gyMRIYBnmzDKTmj0pA1ZNZlD
 KMTxMMeeGEtiGtGnd0Ftw0qxlfUGqhLAo2TLKXQ=
X-Google-Smtp-Source: AGHT+IGMjbZhMWm0i66xMiKPYJsnkzVsWpZcmjHOih9+wbs7qvaORgFZDGQz9xHuD2A9U7BbnD51uw==
X-Received: by 2002:a05:6000:1445:b0:32f:7a07:be07 with SMTP id
 v5-20020a056000144500b0032f7a07be07mr15668891wrx.17.1698946724884; 
 Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/33] docs/specs/virt-ctlr: Convert to rST
Date: Thu,  2 Nov 2023 17:38:15 +0000
Message-Id: <20231102173835.609985-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Convert docs/specs/virt-ctlr.txt to rST format.

I added the name of the device to give readers a bit more idea
of which device we're actually documenting here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-7-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                 |  1 +
 docs/specs/index.rst                        |  1 +
 docs/specs/{virt-ctlr.txt => virt-ctlr.rst} | 12 +++++-------
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5e1765d7a6..11f3bdbfa78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1283,6 +1283,7 @@ F: include/hw/char/goldfish_tty.h
 F: include/hw/intc/goldfish_pic.h
 F: include/hw/intc/m68k_irqc.h
 F: include/hw/misc/virt_ctrl.h
+F: docs/specs/virt-ctlr.rst
 
 MicroBlaze Machines
 -------------------
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index ee84b8109d6..8d30968650b 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -29,3 +29,4 @@ guest hardware that is specific to QEMU.
    ivshmem-spec
    pvpanic
    standard-vga
+   virt-ctlr
diff --git a/docs/specs/virt-ctlr.txt b/docs/specs/virt-ctlr.rst
similarity index 70%
rename from docs/specs/virt-ctlr.txt
rename to docs/specs/virt-ctlr.rst
index 24d38084f7f..ad3edde82d2 100644
--- a/docs/specs/virt-ctlr.txt
+++ b/docs/specs/virt-ctlr.rst
@@ -1,9 +1,9 @@
 Virtual System Controller
 =========================
 
-This device is a simple interface defined for the pure virtual machine with no
-hardware reference implementation to allow the guest kernel to send command
-to the host hypervisor.
+The ``virt-ctrl`` device is a simple interface defined for the pure
+virtual machine with no hardware reference implementation to allow the
+guest kernel to send command to the host hypervisor.
 
 The specification can evolve, the current state is defined as below.
 
@@ -11,14 +11,12 @@ This is a MMIO mapped device using 256 bytes.
 
 Two 32bit registers are defined:
 
-1- the features register (read-only, address 0x00)
-
+the features register (read-only, address 0x00)
    This register allows the device to report features supported by the
    controller.
    The only feature supported for the moment is power control (0x01).
 
-2- the command register (write-only, address 0x04)
-
+the command register (write-only, address 0x04)
    This register allows the kernel to send the commands to the hypervisor.
    The implemented commands are part of the power control feature and
    are reset (1), halt (2) and panic (3).
-- 
2.34.1


