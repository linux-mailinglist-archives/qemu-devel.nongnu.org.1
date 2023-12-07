Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E29808C24
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGZu-0000db-LL; Thu, 07 Dec 2023 10:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZa-0000cH-49
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:45:58 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZX-000288-82
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:45:57 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a1db6c63028so117604666b.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701963953; x=1702568753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qIgSJSXHt73pYKp369uQ7oGZDAJNmZg50+PsPECtSzM=;
 b=yPmOcxmtk1uZRWr5zPeO3h132lPrZLZeOyb/rsCEz5o1FWpMqjIG5sSbC4BQgjv8Uf
 M00QUCIxBUZElgBEiDgoJOxlJLvnsTeltLPYQ6117WFYn0b1PccxkUMwWlgXKrSgQ/VV
 lQC0ReU0jn0C+5vuS75V9Mk0leu7Fear5HPRmEf4oteeIzDTBnFDa4csdu7MckFIWKyS
 nMABy5MDbI5GVVX1sHk8ITg4DbNxyb0ceBOTYCO4dNhiR5Q9DDtWal2/xwacAupZ8E/M
 tPhvklDURjArcv7/2tZKVXgWt8YHTiCgvTAkvo6u5NcISB3gsm3igAgqKSawX76SQLDy
 UtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963953; x=1702568753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIgSJSXHt73pYKp369uQ7oGZDAJNmZg50+PsPECtSzM=;
 b=MP6wzZMMdc9uUoYKfAhfVdsapSCzbXipk573wAP3BRflnEOvzwc3oJv79/VkH4a8tJ
 j2pHabAAeOqIYCXsyGyvIsUUPIUrAkEL/hEFtEs52cRpuxDyLrxvwMGLJ+Ph+gVinNVd
 wXzNEuOjxbaM8r5ZX9OUewp3wV7OjGnP/5gx2FeRYzF6nuL9QmVO9cf1FZsnJZcXKxyP
 t6+y3CxL/9iJODXYjxyv75EyV/jQ3lQEMouztOp6JhrCh5a57jUzO+ENshRm/1BkmfLW
 cXnEVoHbDDTYqHnccLwv9ACyUbevIIok6WZNeKNYd9yLFk9RyHnEGB8VOLaVxjTpYEwn
 4L4Q==
X-Gm-Message-State: AOJu0YxdVozc13T5UgwXQVDdvIOz45wnCXTaMViVMNssaYccOzQ13jMr
 atkBmAtPFDzZjlJFySRaOWnrT/mkMUV81Az3mKQ=
X-Google-Smtp-Source: AGHT+IFH83Qy/3ghBdcE9KWPQ0IKRxxwi5YYmOQ56WyzoWuqUy8pJGx+OImy8G1SwgmXbftLfOnWeA==
X-Received: by 2002:a17:907:ca1d:b0:9be:7b67:1674 with SMTP id
 uk29-20020a170907ca1d00b009be7b671674mr1542810ejc.3.1701963953651; 
 Thu, 07 Dec 2023 07:45:53 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1709066bcf00b00a1b65249053sm969126ejs.128.2023.12.07.07.45.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 07:45:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] sysemu/replay: Restrict icount to TCG system emulation
Date: Thu,  7 Dec 2023 16:45:45 +0100
Message-ID: <20231207154550.65087-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Slightly simplify non-TCG and user emulation code.

Since v1:
- Introduce enum of icount modes
- Fix ARM INST_RETIRED event

Philippe Mathieu-Daudé (5):
  sysemu/cpu-timers: Introduce ICountMode enumerator
  target/arm: Ensure icount is enabled when emulating INST_RETIRED
  util/async: Only call icount_notify_exit() if icount is enabled
  system/vl: Restrict icount to TCG emulation
  sysemu/replay: Restrict icount to system emulation

 include/sysemu/cpu-timers.h | 22 ++++++++++++++--------
 include/sysemu/replay.h     | 11 ++++++++---
 accel/tcg/icount-common.c   | 16 +++++++---------
 stubs/icount.c              | 29 ++---------------------------
 system/cpu-timers.c         |  2 +-
 system/vl.c                 |  6 +++++-
 target/arm/helper.c         |  5 ++++-
 util/async.c                | 16 +++++++++-------
 8 files changed, 50 insertions(+), 57 deletions(-)

-- 
2.41.0


