Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398CB7C5775
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaYB-0008T6-3C; Wed, 11 Oct 2023 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaY1-0008Ns-He
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:50:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qqaXz-0000U8-QI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:50:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so64107725e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697035848; x=1697640648;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lr8ovQuhly75IySJclMFTas85gUVfIJkDjnDAWV9RSc=;
 b=A2VTa7RR70nh3zLR60+Xnx2sdLpCVfennSSwwvQgcbp9CzgqAzHcZ5VJUQ92yL0IMD
 ZlJxgRrpI8MGeTeMnKsqZwhw/xoirSu5fK3Ou3pe0vjLdizqdPXKRamjRIZsIApYJzB3
 gvgXN6Q4xA0HGwP4eh3k4MU2ZXY/z/2xuMcYzbWaVepdyEz4R6MRD23fjB2vVEDlY+Vk
 af/i28DtuUaiKBLpxQtKIt/yWrOCzEsfhBud9BoChXJXa11CUVUDD7F+1L9WAu4Kfzbz
 gBseOhX3Puqa3lF8rDjoYck832NYE8eTem98AFhF7d7o4Clvoe6T9cAId1PaWm4rjWvO
 Gq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035848; x=1697640648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lr8ovQuhly75IySJclMFTas85gUVfIJkDjnDAWV9RSc=;
 b=w74L65VFfR/gRDhI1ukzMxFQ2Mt1iB0KBR0UdCqXBHixjhFbe2GMdJoe1lN4Wtf5ic
 iQXsgD76VLwHVtXMj1SPAoztiLVJxMrNlWKLzqewgq+t5Lt3iXunbJf0LW9HmHhOVISz
 +9DGthMDEK2PK5H+Kh6jYV9np2W5AfyMElRSxXfpxq0qwdy9Yv+4SMbiLF/m3l7hHhre
 WLNjKLFcfupQRNnMxaxFlHPvnQicwxYmN2iaKykPgpDx59OXccv2M44Cn1i/0bUAN1Yw
 XptPI1fEWF1IasqE+g7qpOx1+5JM5tzBwWqE1XnMSfVrFXV2cxVDc7VYWnvoEIWi+gpx
 aj7A==
X-Gm-Message-State: AOJu0Yw6Q30gu3WMnPU2EF8+5L72GAHNlvPbWQYvHorDkf1nbk0DuMDZ
 OKWp2VAdzFcoiRDdGScRxKcxAFW7UYBLtPoe3UOa3Q==
X-Google-Smtp-Source: AGHT+IFjbzf2NODsVPW8hLe3KzkAPQeRjEJasnTy3zwZiIiqkOgdMDzcGrQV/CMhkS0fvwmTG22+cA==
X-Received: by 2002:a05:600c:b41:b0:405:499a:7fc1 with SMTP id
 k1-20020a05600c0b4100b00405499a7fc1mr18965871wmr.40.1697035848642; 
 Wed, 11 Oct 2023 07:50:48 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0040684abb623sm19709208wms.24.2023.10.11.07.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:50:48 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v2 0/6] Support discontinuous PMU counters
Date: Wed, 11 Oct 2023 15:45:48 +0100
Message-ID: <20231011145032.81509-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently the available PMU counters start at HPM3 and run through to
the number specified by the "pmu-num" property. There is no
requirement in the specification that the available counters be
continously numbered. This series add suppport for specifying a
discountinuous range of counters though a "pmu-mask" property.

v2:

* Use cfg.pmu_mask wherever cfg.pmu_num was used previously
* Deprecate pmu_num property (warning, comment & updated documentation)
* Override default pmu_mask value iff pmu_num changed from default

Rob Bradford (6):
  target/riscv: Propagate error from PMU setup
  target/riscv: Don't assume PMU counters are continuous
  target/riscv: Use existing PMU counter mask in FDT generation
  qemu/bitops.h: Add MAKE_32BIT_MASK macro
  target/riscv: Add "pmu-mask" property to replace "pmu-num"
  docs/about/deprecated: Document RISC-V "pmu-num" deprecation

 docs/about/deprecated.rst | 10 ++++++++++
 hw/riscv/virt.c           |  2 +-
 include/qemu/bitops.h     |  3 +++
 target/riscv/cpu.c        | 13 ++++++++++---
 target/riscv/cpu_cfg.h    |  3 ++-
 target/riscv/csr.c        |  5 +++--
 target/riscv/machine.c    |  2 +-
 target/riscv/pmu.c        | 35 +++++++++++++++++------------------
 target/riscv/pmu.h        |  5 +++--
 9 files changed, 50 insertions(+), 28 deletions(-)

-- 
2.41.0


