Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4B8251E4
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:26:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNV-0007jd-3z; Fri, 05 Jan 2024 05:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNR-0007jC-Oh
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhNQ-0004Kk-1w
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e36e29685so7224775e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450269; x=1705055069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oH069RZTJa1YClK7MWQRB9iAj8pdAu6oir5e+vwxYJE=;
 b=KMlXf1qcumhsVPxv2H9YtoRHsCOo9cWxxISRTsA/jNyk//t1z0kKUy9wrBj2aAVdLH
 /XZ/9e6Qq9WtXbl5XagiSNCbY61gEPnEOcaJE6/0b8XmL6nEzYtIjEcT32ZZh8l9XiTK
 VdodgFu6BlhihriLfC/J3Kud6hBkIAK6Qufutck7ysql7XZfxI3QpnnrKf6k9gYbtlyK
 1AcfYVnYePQGnuSKNN+T0duiOMBszA0kGLFfXgAY7qeRZtAc4RScUb4J0Ml9DE0s/W9I
 ErCCsghjz920o+vf88GWZl7QhIXPFTLkOEr+gm4bOef7Xn6k0QS8BNUV0PhbWFnRztkT
 fe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450269; x=1705055069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oH069RZTJa1YClK7MWQRB9iAj8pdAu6oir5e+vwxYJE=;
 b=aMgYZsIqTikIdzNSp+lm7n3uqa2XiCNUdqkgQzo3V5/Y1xv+m70wJQazPCFieTumiL
 2juCQS67UN1KoqNbmgm/eB66/GpJxLLinCDsf5pU4nKdp+5eGp8U+0aJKIi/G0uCA+y+
 E4Fu10cGxkADYFC3040u6VQ09/QEKrLLnfbWHT8UyPuk7rWxbgTB4ekKJa/Y+tQeaa+S
 MuEazCbHOftMJLm89BNzbtSknRF4uBP62/l1XFfVlPzn0/zJvOK/vefGwN9CvCDQ8czR
 UPFHKRCSCTrfMNzo1zRz6Hyy8fgd2W2Jzgcy7Syt3tSuH+FXzmCyHa8CnEMwj8VGYzMr
 7zfg==
X-Gm-Message-State: AOJu0YwDPlUmmtPxB+BvIo2EJV9Cp1QIu7dsvukc+DAZBCiXk2Xa5/K1
 7L0bzuTfniU18cQUMsrtsxpdRvjJmITdY0g0ifTIlDPOJQ==
X-Google-Smtp-Source: AGHT+IHdMugwJFZCg9uUW0Hdj4n6Rlxm+wCFfosLnxXxrxj3plHuMddCKKJ9Ox0/PntDeLvfY4Kbpw==
X-Received: by 2002:a05:600c:4451:b0:40d:ecd9:bde6 with SMTP id
 v17-20020a05600c445100b0040decd9bde6mr1101144wmn.34.1704450269325; 
 Fri, 05 Jan 2024 02:24:29 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:323e:281a:689:2b09])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b0040d934f48d3sm1117548wmn.32.2024.01.05.02.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 02:24:28 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 0/9] sparc/leon3: Add support for -smp
Date: Fri,  5 Jan 2024 11:24:12 +0100
Message-Id: <20240105102421.163554-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32b.google.com
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

This series allows leon3 emulations to record up 4 CPUs.

It requires some enhancements in the grlib_irqmp device and adding the
cpu_index field in the asr17 instruction.

It has been tested locally with various bareboard runtimes and through
the Gitlab CI: https://gitlab.com/Helflym/qemu/-/pipelines/1127834623.

Clément Chigot (9):
  sparc/grlib: split out the headers for each peripherals
  intc/grlib_irqmp: add ncpus property
  intc/grlib_irqmp: implements the multiprocessor status register
  intc/grlib_irqmp: implements multicore irq
  target/sparc: implement asr17 feature for smp
  target/sparc: simplify qemu_irq_ack
  leon3: implement multiprocessor
  leon3: check cpu_id in the tiny bootloader
  MAINTAINERS: replace Fabien by myself as Leon3 maintainer

 MAINTAINERS                                   |   2 +-
 hw/char/grlib_apbuart.c                       |   4 +-
 hw/intc/grlib_irqmp.c                         |  97 ++++++++----
 hw/sparc/leon3.c                              | 145 +++++++++++++-----
 hw/timer/grlib_gptimer.c                      |   4 +-
 include/hw/char/grlib_uart.h                  |  30 ++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  |  16 +-
 include/hw/timer/grlib_gptimer.h              |  30 ++++
 target/sparc/cpu.h                            |   2 +-
 target/sparc/helper.c                         |  16 ++
 target/sparc/helper.h                         |   1 +
 target/sparc/int32_helper.c                   |   2 +-
 target/sparc/translate.c                      |  13 +-
 13 files changed, 258 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (83%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

-- 
2.25.1


