Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3677C878A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItK-0007OH-Ij; Fri, 13 Oct 2023 10:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIt9-0006vm-1O
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:40 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIt7-0004MF-D4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:11:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so356988766b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206294; x=1697811094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s90efDO1BIm1Rx3O8v37p3cF+pWbPvUZT6DeInS4MHU=;
 b=yjHglFsgYYm5gUoM4C6kiM28r//T/euR+0lySw53dLJeX6q3DGorYwsU55ATibDVqS
 n4MvkKMtGWGp2mrhauzWdZRPeecUFJ/neBTV2fpZTOIVPLzdy3Qa4Zf49qKPSpK1amsi
 ww18ozzWlVZ9R27uqBfqIZeTLsazhuL/OSJuwtzhLeQSjnCN/hXlx9REaFgD3i6SKL3B
 ylJVd+s4iYdskWBU6RNrJwoiSI9NH6MdcWwCfcNqtZ1Dl/IPssxUqPsvQUEhQMJTdcwo
 HZa3LvYSCTJeH8l/MVysdnoQXOqEUBvb0jboX3A1E5fGMbuesxxIg3uHkuoqzs/jtfWw
 1png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206294; x=1697811094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s90efDO1BIm1Rx3O8v37p3cF+pWbPvUZT6DeInS4MHU=;
 b=vwkxOaJ86z0vyLIfmT0t/S+h8JVH9hKUFdC4/gXMf9cLFa/e2ltRelzRSsyaJB/azj
 5usEgI4Hd0vwa0Ch9kTI+KkM9KFdQ4v1aOg9ZW5xMNjm4P+stVyCcydjYBY1seEPMruR
 nxJ9MlUuIWjRcCmfg06Xeh68SdBE+U2cFuXb+CTsqGqJXtBxhccpS9JHRGFa6INqNcCV
 3c0uMcSEESgMIKc1eiZn1aT9+dD4pWB/yhwtRmMM5cSUvYFT1Xq1OmEFs3ur+Anil9Cs
 CRYhDO2MMbqydTDKbKIP5Ndgs9hTsL1iY/fYQWlDcENsCOhXuDQokQ7C6/4/qrJNeJ63
 HBJg==
X-Gm-Message-State: AOJu0YzFMEYrIFhzBB9dfO6qPy2n65rhVsMA1YXvU4WURmC155KpNsxt
 3eNyDJAeogF6vlfuTHptSIoz0UwAupyp+v2DWYk=
X-Google-Smtp-Source: AGHT+IGIZNhFaQDEX8RRp3UYG3CNLSEfyasGA1+3fleyRZrdHksc7qpV6DoVphx8jT1ebeVDB3nyzg==
X-Received: by 2002:a17:906:2929:b0:9b8:df8e:cbde with SMTP id
 v9-20020a170906292900b009b8df8ecbdemr21574346ejd.51.1697206294263; 
 Fri, 13 Oct 2023 07:11:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906354a00b0099bd1ce18fesm12674983eja.10.2023.10.13.07.11.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:11:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/10] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Fri, 13 Oct 2023 16:11:21 +0200
Message-ID: <20231013141131.1531-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

Since v2:
- Added R-b tags
- Addressed Richard comments on migration

Since v1:
- Restrict pl011_ops[] impl access_size,
- Do not check transmitter is enabled (Peter),
- Addressed Alex's review comments,
- Simplified migration trying to care about backward compat,
  but still unsure...

Philippe Mathieu-Daudé (9):
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
 include/qemu/fifo8.h    |  37 +++++++++--
 hw/char/pl011.c         | 140 +++++++++++++++++++++++++++++-----------
 util/fifo8.c            |  28 ++++++--
 hw/char/trace-events    |   4 +-
 5 files changed, 161 insertions(+), 50 deletions(-)

-- 
2.41.0


