Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DA8038C0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:27:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAApb-0003uk-ES; Mon, 04 Dec 2023 10:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAApX-0003rk-O4
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:25:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAApR-0005Nc-Bv
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:25:52 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40bd5ea84d6so12558805e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701703547; x=1702308347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O+Y9xjSg4IuHGgwxwgKXYHb/P7EXEsinI+WrmX30V8Y=;
 b=T5Aos29TnzewqONy2qAx/3xHtEJJjjgN6B0B6hrzm03a38QxTmATBIpLyefpUaxXN0
 +AT5VyogEo+QCFx1+bbckVnKWHBhnUwVpJtt5Se9ag1fVlFc+B3K8HkMprHmOmtWEhdf
 deWEYOsByD8ajBzfdSIvkXeATgE7klJGhzDeAju/L9AcO96m1AbplU/2vOd4RSdItnpr
 C71mlxLv0RPID/9xCOk9xg86ydb+REgwy88lYSv4v2kAOwZhiMW4THVlxGBIOSWeCCeO
 TWgxPXRp/MJ7eyj/63ZS5IwG/vOG53Q2xCtotXCzJeZq3SbOkjsoY+GB5XjxPlhVmtHs
 Njhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701703547; x=1702308347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+Y9xjSg4IuHGgwxwgKXYHb/P7EXEsinI+WrmX30V8Y=;
 b=fcIpnz0rpuVSq3YrGRMPRgU36UeZZhEXDsS0atqd/ghnJnGBJnxnQwBIzStaYd0O5c
 MIrC6PAAMEEy89yBLkA/Mtm8i6nX3LmY9tmGi2zOfSqBTQKXWyIBt/16EyF79f1XGYAf
 nueHowjR9K3qlxvPeKIv5h5twZYcNY6wfr68zec9gHEFBh1pLx2aTRZGpZG/GNr6af+9
 XBnWCPyv3LdoWagoNLwzV4nOoIxX8vHKuE5wnzf5l01rb1hpyBjujnV1k9v3M8jifFJ6
 a0qGUq5TpUZlOrv0r6IkhOzmWQ0KQWv4gn6EbT9EJ1WYKxBJnwclS8uuDibUIrijoXBM
 JbVw==
X-Gm-Message-State: AOJu0Yw35l1wTV17UknFCypjfuD9wdnXR7X+JQ/jKZlYD5ZD7mxYeYlk
 P45JBkOn6xleCfuSF8Z/904p1Pn26AdD1YI9CIU=
X-Google-Smtp-Source: AGHT+IHmDr0yTZEs3HYdvrwB3CDIP3XAr63BtD9/L9mDHqk5Y7r1/Tjsa5TeSTA1VrZTF5M9+YLxbw==
X-Received: by 2002:a1c:7204:0:b0:40b:5e4a:235c with SMTP id
 n4-20020a1c7204000000b0040b5e4a235cmr798678wmc.94.1701703547058; 
 Mon, 04 Dec 2023 07:25:47 -0800 (PST)
Received: from m1x-phil.lan ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c155200b004094d4292aesm15445704wmg.18.2023.12.04.07.25.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Dec 2023 07:25:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/4] Misc fixes for 2023-12-04
Date: Mon,  4 Dec 2023 16:25:20 +0100
Message-ID: <20231204152524.37803-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 17dacf7ac9e2f076c15f32a290203f8f571a8800:

  Merge tag 'pull-more-8.2-fixes-011223-2' of https://gitlab.com/stsquad/qemu into staging (2023-12-04 08:03:18 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-fixes-20231204

for you to fetch changes up to 2e8ed6a970e1842528f34aeb36b387834205c53a:

  tests/avocado: mark ReplayKernelNormal.test_mips64el_malta as flaky (2023-12-04 16:21:00 +0100)

----------------------------------------------------------------
Misc fixes for 8.2

- memory: Avoid unaligned accesses (Patrick)
- target/riscv: Fix variable shadowing (Daniel)
- tests/avocado: Update URL, skip flaky test (Alex, Phil)

----------------------------------------------------------------

Alex Bennée (1):
  tests/avocado: mark ReplayKernelNormal.test_mips64el_malta as flaky

Daniel Henrique Barboza (1):
  target/riscv/kvm: fix shadowing in kvm_riscv_(get|put)_regs_csr

Patrick Venture (1):
  system/memory: use ldn_he_p/stn_he_p

Philippe Mathieu-Daudé (1):
  tests/avocado: Update yamon-bin-02.22.zip URL

 system/memory.c                     | 32 ++---------------------------
 target/riscv/kvm/kvm-cpu.c          | 19 ++++++++---------
 tests/avocado/machine_mips_malta.py |  5 +++--
 tests/avocado/replay_kernel.py      |  3 +++
 4 files changed, 17 insertions(+), 42 deletions(-)

-- 
2.41.0


