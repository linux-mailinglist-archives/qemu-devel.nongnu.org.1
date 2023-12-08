Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F063E80A261
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:37:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ9D-00041i-ML; Fri, 08 Dec 2023 06:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ97-0003wr-2T
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:35:54 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ8o-0003NX-UM
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:35:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332c46d5988so2074734f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702035332; x=1702640132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0bGgQr6byLDy4jY9fxc2ABAiH5gCgejb87jGCILL1Kk=;
 b=ugonQN7TvEdtddE34ujJPoiukY1xjft7seRajcC9W4ccT8ljOqcKDvGV1hIEup+iWV
 jQnAcHPVYmAHtzkP8A7gtKCbkOU+Mo12v3yLKNr3FlEq0/tTBssKIVKpvtN1f/RU6Nao
 J6l3dEkHaHo9mqEs09FkDe+ENRtIwmyxoRh/D5PKXrGI1yaa0BivlurGPEkzpXZXo3nl
 xca5L/WKrdPsbivYH9OmqjWfFz275eHnQXW5zY230hJ9jNT/sAymh3XlVdYfykvivZqF
 1D5/KBQk5y2Obq3LLwsK8kgSDuMRS6kCDkaBuCDofe8Y/+n+g3TRog3ehrkG7GsO8kVh
 IZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702035332; x=1702640132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bGgQr6byLDy4jY9fxc2ABAiH5gCgejb87jGCILL1Kk=;
 b=fAhdPkneAOy6xYgbb5RfiUnazyKporhd0VO46BWK5RVJkmCVbQUJSBxBF4JXahyyEz
 oe3+KK80zIAluZtMoLnmdLgfSazpFm4ZMzHERnWMqeZpX02QT1HmFNI41Dgh5iD/TwWu
 DJ+DPqQ5Zn5zOPh/YBU9JxlxRdg7REqa0YFeJ6ksRwWgASnnept7ahi6MWgK/Bp2ULoo
 EBm5fZ8QKUWykreGsFAzTA+gaV9nuUvpK8jWsUrFfQtbRpAis6mwI2w1IfxxYX+1RIK2
 PQ3lU0F37udXKK08RNcmEuiZWd70qXN5v78CWmxrUTHh8mbgGcjRgvo5zG1gZuIt6Q48
 pDuw==
X-Gm-Message-State: AOJu0YyCbQueuuP8N9oALiMgUq0XyP9bER0H28+d200H2HTePtjbgeUL
 JCGTx2LBR604gUuhh9IEXMVIEndxiaEM+XGIXas=
X-Google-Smtp-Source: AGHT+IFqwC7Iu5IEcPpgQMc3P3EoveoD8+7iL1/OJPPJ2Z5etkYdrUNsGSsaLW1s+sh6Qj5aIxZbfA==
X-Received: by 2002:a5d:448a:0:b0:31a:ed75:75df with SMTP id
 j10-20020a5d448a000000b0031aed7575dfmr2319997wrq.15.1702035331963; 
 Fri, 08 Dec 2023 03:35:31 -0800 (PST)
Received: from m1x-phil.lan ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a5d4644000000b003333bd63792sm1821183wrs.117.2023.12.08.03.35.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Dec 2023 03:35:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/6] sysemu/replay: Restrict icount to TCG system emulation
Date: Fri,  8 Dec 2023 12:35:22 +0100
Message-ID: <20231208113529.74067-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

This series still adds assertions in ARM INST_RETIRED
PMU events, in order to bypass a linking failure. Better
would be to restrict ARM PMU events to TCG. Left for
another series.

Since v2:
- Have icount_configure() return bool
- Addressed rth's review comments

Since v1:
- Introduce enum of icount modes
- Fix ARM INST_RETIRED event

Philippe Mathieu-Daudé (6):
  sysemu/cpu-timers: Have icount_configure() return a boolean
  system/vl: Evaluate icount after accelerator options are parsed
  sysemu/cpu-timers: Introduce ICountMode enumerator
  target/arm: Ensure icount is enabled when emulating INST_RETIRED
  util/async: Only call icount_notify_exit() if icount is enabled
  sysemu/replay: Restrict icount to system emulation

 include/sysemu/cpu-timers.h | 32 ++++++++++++++++++++++----------
 include/sysemu/replay.h     | 11 ++++++++---
 accel/tcg/icount-common.c   | 36 +++++++++++++++++++-----------------
 stubs/icount.c              | 29 ++---------------------------
 system/cpu-timers.c         |  2 +-
 system/vl.c                 | 19 ++++++++++---------
 target/arm/helper.c         |  5 ++++-
 util/async.c                | 16 +++++++++-------
 8 files changed, 75 insertions(+), 75 deletions(-)

-- 
2.41.0


