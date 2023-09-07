Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5B797192
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCae-0008VI-Ft; Thu, 07 Sep 2023 06:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaa-0008Sa-Vo
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaR-0004jm-La
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so283391f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083807; x=1694688607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JsXy4DJuJMdC3sQBNqm1zFrFicc2ZiZkrzJhRbUD0fY=;
 b=cYTYry9/4A9vqkxVXQPmdd2kR4s15YG/X3m4G+qPP/TO91cY0BHJuXHApxzWmEvNgt
 Jo6YEV+pSlWWvAGxcVHy+bmdUzEKdg+6FvHnY28+FJCO1nFs5yIZrVYyU3e8ch3m4RaA
 aLwwdaxayxkdeS1KCrLGYSxfCoA9pta2xcFcZnLlwyikH5lETAgKWiyB3nVqUsSKKos9
 V42Z+jMVMIIrehHBZwsmIL112wwxyT7HYt+8PrQSL3izTcvIN0lN/yFSaXWkTA1unmy1
 h7sSSXZ+kZl+X6CkhLk+2TrHYC0vJ/mPct39P4AvLKMVNEubC7NObK2wSFaC1V9pGznM
 FMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083807; x=1694688607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JsXy4DJuJMdC3sQBNqm1zFrFicc2ZiZkrzJhRbUD0fY=;
 b=cdX26OiIOJ9gT72YeS6B1ZR1pLRi3dKh30Px2A3MMKyb/W91FAgE+dy/Qi7b/jFZ9T
 itcRAfdEU4upOcNUCpyZt5F1vhe13rfPFTQHdkDio/m6d9uMNqPqsZOt9rSLC7yAwzpz
 7rdPpHzfb2LyBtOqun9Hoc9tLQwo5e0tzYDUCWg+4tmEsVGmijd7UDHtOVG72sPcP0et
 kHYY3g3nSZE640lhQCI6ETSjeJSe/leFdG2P8CPNyjzCNCjBwxc8kWEfhciZnxpIuTX5
 9nD5FxLOGf+xUj4VONYR4lO0TvxoyX66gno5YQH6mHTWzjqOcottN0id5iZ6Tul8TPPi
 coeQ==
X-Gm-Message-State: AOJu0YzE8pEPcFDip03CU/UZSRrjYyjcoVa5gRN04UXptgHAR519lDm6
 PWNUmXdce7ogY36bNUoOcHT+oya24U1LAQ+lgg4=
X-Google-Smtp-Source: AGHT+IHhiinlD9DWDwmaqff+of9LaWVyE/BDt5SRUMfTsukzNp7J0ugCRbfHV8wk0M18DwQl9/bdjg==
X-Received: by 2002:a05:6000:1106:b0:315:a043:5e0a with SMTP id
 z6-20020a056000110600b00315a0435e0amr4405806wrw.56.1694083807585; 
 Thu, 07 Sep 2023 03:50:07 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm2144205wma.31.2023.09.07.03.50.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] contrib/plugins: Build fixes for Darwin
Date: Thu,  7 Sep 2023 12:49:59 +0200
Message-ID: <20230907105004.88600-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Trivial:
- Fix string formats
- Link with GLib

Alex, Thomas: FWIW, plugins aren't build on CI.

Based-on: <20230907101811.469236-1-pbonzini@redhat.com>

Philippe Mathieu-Daudé (5):
  contrib/plugins/cache: Fix string format
  contrib/plugins/drcov: Fix string format
  contrib/plugins/howvec: Fix string format
  contrib/plugins/lockstep: Fix string format
  contrib/plugins: Link with GLib

 contrib/plugins/cache.c    | 19 ++++++++++---------
 contrib/plugins/drcov.c    |  2 +-
 contrib/plugins/howvec.c   |  6 ++++--
 contrib/plugins/lockstep.c | 11 ++++++++---
 contrib/plugins/Makefile   |  1 +
 5 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.41.0


