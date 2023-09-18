Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A64C7A4A94
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEJZ-0003z0-NI; Mon, 18 Sep 2023 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJX-0003yS-Hx; Mon, 18 Sep 2023 09:29:23 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qiEJV-0003V8-TO; Mon, 18 Sep 2023 09:29:23 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3aca1543608so3318587b6e.0; 
 Mon, 18 Sep 2023 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695043760; x=1695648560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mOQAvNiQG8Ml+1ZXb4+0M50r5KI29TDR1tQM8Q+fwmE=;
 b=MrcW5y0Jf3SAeFn5vowwTXs/T2eGAyxbOgZX8J76wvt23ikYZ14YvH8kfP90qeDzOm
 ZVO+zeJ8ZKlUxx3mRH01oG5cl8fDUcYvjGUgMSw5rPEQVL9chW4BpekzD9z1FyEeVNLB
 A9RXThAeZmGAzI90drJyU3dIYNoshImg87X5CBbUQfNp1NMo0Kz/MBTxylTwZph4kJ/C
 l0zxN1JghG87w/uessXVXis+XbsS2odPxUSKmXzrAdH/A+O42TwGThichYHOoxLbryQY
 WHYpAheHzSs2xi5qVSlKkfg4gdYX+ixAbajZrUokZHI8ImzpmiaiYjGMBSy4VOWoNUqM
 Pvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695043760; x=1695648560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOQAvNiQG8Ml+1ZXb4+0M50r5KI29TDR1tQM8Q+fwmE=;
 b=KKZ6U8wvb0A+8lyxXHJip9VHr/vyOK/aBHGPFRwE42D2pKmbInyb1fsI0vj0G54hU1
 Jb6QnToz/kedNPjPZBX2QJ6KzKIokmXSuVoYeqKdur7amaPSYkuhBNDf0AkULAYerc+E
 qG6ki63Raj9XhWvGRNJenJ08rDVvJpsVm5Fu5StaK1ccr9tOEF6rS0UifYRiJA1haxJz
 TR0fFFWkEbGLAIqBQEI7VnYEONerfu0oVxgTRTyl4hBR/vYaBj5VJWqBIFjQ47XnBbM0
 x463+6Fn+Lv0jl/bTPtihkUCahpw3mUpGXJm8GQvY4wvvHmsfW5Y/Oha22lI729/u9cX
 LS8Q==
X-Gm-Message-State: AOJu0YzgyqK2aVgoQ8Tt2CoM4JBwX31GoPX0MOK9lAxiMoD9nNlFRcmL
 PRoqCLYDcBPnZDycI8D9hLnMaxyz7ec=
X-Google-Smtp-Source: AGHT+IHY2QB7il6dj8RYgY7Zz3q+JeveDR4juVXmlrZYoimjiXut6/IlhEqYa1oH21qXRknX3Pz/DQ==
X-Received: by 2002:a05:6870:24a7:b0:1be:fcb8:6a48 with SMTP id
 s39-20020a05687024a700b001befcb86a48mr11002703oaq.58.1695043759802; 
 Mon, 18 Sep 2023 06:29:19 -0700 (PDT)
Received: from grind.. ([152.234.127.211]) by smtp.gmail.com with ESMTPSA id
 y1-20020a056870a34100b001c8f250820esm4927161oak.48.2023.09.18.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 06:29:19 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 clg@kaod.org
Subject: [PULL 0/3] ppc queue
Date: Mon, 18 Sep 2023 10:29:09 -0300
Message-ID: <20230918132912.291204-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230918

for you to fetch changes up to 44fa20c92811a9b88b41b4882a7e948c2fe6bd08:

  spapr: Remove support for NVIDIA V100 GPU with NVLink2 (2023-09-18 07:25:28 -0300)

----------------------------------------------------------------
ppc patch queue for 2023-09-18:

In this short queue we're making two important changes:

- Nicholas Piggin is now the qemu-ppc maintainer. Cédric Le Goater and
Daniel Barboza will act as backup during Nick's transition to this new
role.

- Support for NVIDIA V100 GPU with NVLink2 is dropped from qemu-ppc.
Linux removed the same support back in 5.13, we're following suit now.

A xive Coverity fix is also included.

----------------------------------------------------------------
Cédric Le Goater (2):
      ppc/xive: Fix uint32_t overflow
      spapr: Remove support for NVIDIA V100 GPU with NVLink2

Daniel Henrique Barboza (1):
      MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes

 MAINTAINERS                 |  20 +-
 hw/intc/pnv_xive.c          |   2 +-
 hw/ppc/meson.build          |   1 -
 hw/ppc/spapr.c              |  22 +--
 hw/ppc/spapr_numa.c         |  49 +----
 hw/ppc/spapr_pci.c          |  19 --
 hw/ppc/spapr_pci_nvlink2.c  | 442 --------------------------------------------
 hw/vfio/pci-quirks.c        | 115 ------------
 hw/vfio/pci.c               |  14 --
 hw/vfio/pci.h               |   2 -
 hw/vfio/trace-events        |   4 -
 include/hw/pci-host/spapr.h |  45 -----
 include/hw/ppc/spapr.h      |   9 +-
 13 files changed, 22 insertions(+), 722 deletions(-)
 delete mode 100644 hw/ppc/spapr_pci_nvlink2.c

