Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352D74DCD1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:54:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv2w-0000zs-5A; Mon, 10 Jul 2023 13:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2f-0000yB-Us
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2U-000061-H7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so44809875e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011466; x=1691603466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bjBDCpoiteMk+vtT+Bu6RMs4u3VYv7NZmre5rEgpQbA=;
 b=ViobvUEX6bOMS1RO+aPZwqMQkpL/2e7jipZSa7zLtDkAzVH3ZGU6wC+MGFoa+bfRxJ
 5W2GqW2uUeUI7Ak6PeYrtThqXwEYWuW0DCoZDCUp/vxLaAVRUsv0oxgfFhKN5iBfP3HV
 q9gDxBtxz6QBw2d1lPZUuNyRT7NijR1WB778FBhEn4n+KGLjr37KC/FvyBuAOKwiIaM5
 yqC7TWtnnvJYRA+dwd3/hhy7XOEpTFkWP6FCi3WkYJNaYt2QoEO7V9pQolUtX3ll6e29
 KRbtWhuv4/Zelz2mpwqJVfF5skYVjFaNKHMp0GwkcVI5IaGBve5mf5VZ3Y4CaCBNI8mS
 wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011466; x=1691603466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjBDCpoiteMk+vtT+Bu6RMs4u3VYv7NZmre5rEgpQbA=;
 b=Vz9nbRDnQ7e+QVMak7q5yjc6CApZY+oak7+nq8ZbTni89MY5EVGRK8yE4tTSSO0iLo
 YUdryHVZ4lVZ676w+Ebcb0GWGmfAsuehFjHQtNm6kRaHrx1IVy9gFWvxlEb3wpsUTWXj
 Xy2onaZx+Sb2proO/+QQvjarQ9JGDvCQ+2p0IqeYHofHaWfLi505d6bSPHnc84Vsl6td
 /CMffExM/lIcZ+N6N17H5O6mSVYi3Xgs/TdRVFQnJS0K17vPns27aZ58Il77C0+VfBLX
 4esM9b1nNBebgrIaLcxvd/tpNkRYx/+onREODYBzE0FHPGlLkR661nKjapBEWfiFv3t3
 yaqw==
X-Gm-Message-State: ABy/qLZcIrZVuGNPHYjWA03XKN4vMAUUTv+Zd9YAiuagA8zYgh/U5G1n
 95+vtrI0ldPSeBznaqqP2tztJkKpiWM+0QvlLP1oDw==
X-Google-Smtp-Source: APBJJlEPPn9CeAza1fV5XWc0RZiDdDkPxsLhgs4DFt4pMWmSe5G7IjDvgATDBiQ1rAZ99zGXqAI3Aw==
X-Received: by 2002:a7b:c3c1:0:b0:3f7:a20a:561d with SMTP id
 t1-20020a7bc3c1000000b003f7a20a561dmr12728469wmj.8.1689011466022; 
 Mon, 10 Jul 2023 10:51:06 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fc17e8a1efsm723789wmd.45.2023.07.10.10.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/11] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Mon, 10 Jul 2023 19:50:51 +0200
Message-Id: <20230710175102.32429-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi,

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

Since v1:
- Restrict pl011_ops[] impl access_size,
- Do not check transmitter is enabled (Peter),
- Addressed Alex's review comments,
- Simplified migration trying to care about backward compat,
  but still unsure...

Philippe Mathieu-Daudé (11):
  hw/char/pl011: Restrict MemoryRegionOps implementation access sizes
  hw/char/pl011: Display register name in trace events
  hw/char/pl011: Remove duplicated PL011_INT_[RT]X definitions
  hw/char/pl011: Replace magic values by register field definitions
  hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
  hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
  hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
  hw/char/pl011: Warn when using disabled transmitter
  hw/char/pl011: Check if receiver is enabled
  hw/char/pl011: Rename RX FIFO methods
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h |   2 +
 hw/char/pl011.c         | 255 ++++++++++++++++++++++++++++++++--------
 hw/char/trace-events    |  12 +-
 3 files changed, 215 insertions(+), 54 deletions(-)

-- 
2.38.1


