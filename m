Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 297AA82EF55
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:03:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPj5N-0007Dq-KR; Tue, 16 Jan 2024 08:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5K-0007DI-Nm
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:30 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rPj5J-0006d5-4R
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:02:30 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50eaabc36bcso12099076e87.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 05:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1705410146; x=1706014946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cDvjPb/9ihwKNAhCBMMgBZb+JUdI37Wr9x2t5mG3KxI=;
 b=YlQjw3KbWgZkhdOoPSoJ9ndWRVwUcaOto6TyEZmbc9TJd9PqspQNhu5XrMrhGPApfH
 wTDOJoF/EJFARWfwsb1P7FT31y8yPeKHK2Gdkgv6DKFfWzq0DxWuG169kwTK2r4RJZes
 1BPBeNBetVsdnjyJgvvpR/jL0bUyr9D9fk6SubNaoyFWpz7REWnkeYLQZkYLuYNrcrW1
 v5Y7/xW+/h6jwhgFHP31sHbjn9/kxiUB88B/nEiDdptI9XnJNrtVHabIEkJhjeYFAu93
 siGB2AQoRNkiXEU96Z283fU8mXkWEX45lTk5Ad1k6at0xiOvMZ4anjVkwibs/1fdNrlt
 x79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705410146; x=1706014946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDvjPb/9ihwKNAhCBMMgBZb+JUdI37Wr9x2t5mG3KxI=;
 b=Y/jL36Q7M9DxF/oHvRxHu+UdmJV57v3U9SWUeiiXXFP/GKC6IIWopy+StsqbM9MVhA
 WNh6Siw+L/QQufCHHhyu/g5eSqFqFBnPGDf/QrXCezayJPvKuu2c2QQb1Na2YuEZh6pl
 4T6MDiLMUJkZvbPU3g0k0zKCsLfqWgYZen4QzJfGi6cEpjvzo4tm3Btwn2Dpx5olpVCt
 Uk+aNiWYiq8SgWPYS5rqwPA6qSgzibiw6E+zunVWmcDbU+YdWLptBx+OrMrMJ5ZSGGFF
 jQC/7DyTMIpSJq7fnPi9Wnm1OS79CkIn1XCtpgP2hYpByR/+tjNTGJ0IhZKqwo/tnZhD
 AXgA==
X-Gm-Message-State: AOJu0YzRHUahd5rfDXleq0V+VhD8XSZBHwlvG9ZJestyrhAMFGBtDE/z
 G1Ja7866v6Rz+36lifzfo+LKD+kOQrfS7+EXY4Zy+EfwyQ==
X-Google-Smtp-Source: AGHT+IFLM0+3ofI9upx/mcd8E+mSqSE7BY0VwfG/cunpLNQ7wbc8l4GeROgg5VxY+UnVysbZCav6cQ==
X-Received: by 2002:a05:6512:33c3:b0:50e:73b7:b551 with SMTP id
 d3-20020a05651233c300b0050e73b7b551mr4259148lfg.84.1705410145999; 
 Tue, 16 Jan 2024 05:02:25 -0800 (PST)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b0040e83867d62sm2495316wmq.34.2024.01.16.05.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 05:02:25 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 0/8] sparc/leon3: Add support for -smp
Date: Tue, 16 Jan 2024 14:02:05 +0100
Message-Id: <20240116130213.172358-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=chigot@adacore.com; helo=mail-lf1-x136.google.com
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

V2 modifications
 - Patch1: Add SPDX copyright tags.
 - Patch3: Add defines for MP_STATUS fields. Improve comments.
 - Patch4: Improve a comment.
 - Patch6: Dropped as already merged.

---

This series allows leon3 emulations to record up 4 CPUs.

It requires some enhancements in the grlib_irqmp device and adding the
cpu_index field in the asr17 instruction.

It has been tested locally with various bareboard runtimes.


Clément Chigot (8):
  sparc/grlib: split out the headers for each peripherals
  intc/grlib_irqmp: add ncpus property
  intc/grlib_irqmp: implements the multiprocessor status register
  intc/grlib_irqmp: implements multicore irq
  target/sparc: implement asr17 feature for smp
  leon3: implement multiprocessor
  leon3: check cpu_id in the tiny bootloader
  MAINTAINERS: replace Fabien by myself as Leon3 maintainer

 MAINTAINERS                                   |   2 +-
 hw/char/grlib_apbuart.c                       |   6 +-
 hw/intc/grlib_irqmp.c                         | 112 ++++++++++-----
 hw/sparc/leon3.c                              | 135 +++++++++++++-----
 hw/timer/grlib_gptimer.c                      |   6 +-
 include/hw/char/grlib_uart.h                  |  32 +++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  |  18 +--
 include/hw/timer/grlib_gptimer.h              |  32 +++++
 target/sparc/helper.c                         |  16 +++
 target/sparc/helper.h                         |   1 +
 target/sparc/translate.c                      |  13 +-
 11 files changed, 278 insertions(+), 95 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (83%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

-- 
2.25.1


