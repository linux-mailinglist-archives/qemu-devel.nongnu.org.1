Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F07E7253
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:29:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AhU-0004kn-8i; Thu, 09 Nov 2023 14:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AhS-0004kP-5t
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:22 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AhP-0005D5-Jt
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:21 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso1969770a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558097; x=1700162897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5b+3846yd1OEZUDu5Pn1q6hKrxR7/QT62gd89N3lm8=;
 b=qc7R//tZUMXW+34fWzHHpY8rQTW5k1jbRY9Ep4HVRVgmurSxVLkv2NWq7q5p7OfW1Y
 5NZ5lxg69TVyHBHKCDZ7WysGlSE5/d3R1AmIFZCw9hMkOWvRzYZpsyG5u+/QWRy1/rtS
 sHeP5V6AYuh+Wcvh8QiZrK1IOSfpMhA5mMWJeuEqxG9Gh5rH/ZLi5qWbA1mN7SvGcvK5
 nQHvf7KkhUXM7PxYw668k45pXfSf6dXEyPSoJzJbueeRbPtGL8oNc1FeHOXgk6ROjVbx
 TfjgxjJduWvakqOv4A28TIY0dtyzBcKCVJlUZ7hhyP9jg6GpaO282FJw6cDm75v4l3Q5
 i2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558097; x=1700162897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5b+3846yd1OEZUDu5Pn1q6hKrxR7/QT62gd89N3lm8=;
 b=HXk3EimxHQ/3vLaNULsaFoMdyTMQr+yCFmDiLxZECnHD9DHBTPElzisZAtkQ/It+SS
 7DB/Z7eC8CA9r8TaPeddeeXVN8DoFjLQnaqMRyjBVPpphK138yevFrvSz0u9oAhXMtDx
 +YpwvhjDuGrll86yBXpYz+LwJRtWHiC9tCMap6PJPvjhNuXU9CKy1IimTjjzcMIeA2Bz
 jweNwjYDWovZ8BJ2iudV1agPCPQl/GrkOiB88JSJVxc6IOfh+sctfRlb9AZ/ZfN3yPs/
 cg3D0x+XRAubxlVXBDN3sRuWbAvXRVLNwfWJIybm6mfCI+ZAFW9k1WvPaqXcDxYFat+8
 uPfw==
X-Gm-Message-State: AOJu0YwzzWwJh1I0s/3sDdCkwHgPFTGk3fPU+VQWg/OjL9zu36x0q6qX
 +od7Zw6SNisJQGxbm8Sk6XBvUWUjh6+t/oSDdou62Q==
X-Google-Smtp-Source: AGHT+IGrlKcfj5xzrZDhzt+RJuMCRpLZlDP0DX6DujHBSZ6U10TjsTODrCjC5TiNNWG6PDtdnUJ6mA==
X-Received: by 2002:a50:d098:0:b0:544:92f1:83d0 with SMTP id
 v24-20020a50d098000000b0054492f183d0mr5291281edd.0.1699558097729; 
 Thu, 09 Nov 2023 11:28:17 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a50cc92000000b0052ff9bae873sm190257edi.5.2023.11.09.11.28.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIFO to
 avoid blocking the main loop
Date: Thu,  9 Nov 2023 20:28:04 +0100
Message-ID: <20231109192814.95977-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

Missing review: #10

Hi,

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

Since v3:
- Document migration bits (Alex, Richard)
- Just check FIFO is not empty in pl011_xmit_fifo_state_needed (rth)
- In pl011_xmit check TX enabled first, and ignore < 8-bit TX (rth)

Since v2:
- Added R-b tags
- Addressed Richard comments on migration

Since v1:
- Restrict pl011_ops[] impl access_size,
- Do not check transmitter is enabled (Peter),
- Addressed Alex's review comments,
- Simplified migration trying to care about backward compat,
  but still unsure...

Philippe Mathieu-Daudé (10):
  util/fifo8: Allow fifo8_pop_buf() to not populate popped length
  util/fifo8: Introduce fifo8_peek_buf()
  hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
  hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
  hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
  hw/char/pl011: Warn when using disabled transmitter
  hw/char/pl011: Check if receiver is enabled
  hw/char/pl011: Rename RX FIFO methods
  hw/char/pl011: Add transmit FIFO to PL011State
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h |   2 +
 include/qemu/fifo8.h    |  37 ++++++-
 hw/char/pl011.c         | 239 +++++++++++++++++++++++++++++++++-------
 util/fifo8.c            |  28 ++++-
 hw/char/trace-events    |   8 +-
 5 files changed, 263 insertions(+), 51 deletions(-)

-- 
2.41.0


