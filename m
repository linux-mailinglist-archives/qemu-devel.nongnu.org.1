Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC96761C82
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJUk-0002Gu-GY; Tue, 25 Jul 2023 10:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUh-0002GX-G0
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJUf-00011Q-UF
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso45474805e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297112; x=1690901912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l+BR/jbkTKe2pDMg9nSjsVEdOB9Wch7yZWm0GM5IB44=;
 b=rgjr04S4+2vx+ZHko+tfrpdxzFrF511UJ6uQotUixCcWnwm+gvPetqM7410MRrXBw2
 RL0DIsDMluvsFAuVWcdW0CncaoBACUzGcA5QxB/ZPsmi7VhW2PJ0H2w7B/tS3zn/JH3E
 qwxeh0auLpNzF0nNZzu7kDjsNTm9aFaSpekvH5nMwA0cz/GDoctnlBMxpuJZ/GsfVmKh
 EFRaU1wSb9LH/rClSbU4HiENVZnr1NAAlaXVvtv+/dthM1tceUrHIufZMLip+Or5ZuR8
 yxPB16Y/LEUTE8Kw/SzmMoBPyVC3r+2MAL6pNXNt0VTBYFuGV9o7gPnNPxNl/SD6vfoS
 sMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297112; x=1690901912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+BR/jbkTKe2pDMg9nSjsVEdOB9Wch7yZWm0GM5IB44=;
 b=cHzLP595t9EVeI/DEhIBTQSVOVz08/501dvi2oUjGzCB70uPQLyp1dYL9OGetfRvmH
 TxGWOLRucnXtR91HzJLW+AhnAnkEFolCMdyAbIBg0Ba0IFtsN64VzdZpU8sZOIMVjtWO
 SwokDsmoOAxf2oCVzVd7JJtez+7IKO63SpkQ5TNh8bHiZpvoI/GK6xWDhEht5kWmcXet
 HKowlgXGq8VWfKVwFConoh5xuVSMbP2Zx/Gmm6Rx2zn0Mw2+Za2F6fojVQKpItr6Wo/R
 Cc/CpJxpBHBtQTIEZLKI0dkDelWs8rvtl0GJyWqAfFFxR1V3ayoLekHcMFRbus+ezvCg
 K05g==
X-Gm-Message-State: ABy/qLakaOOLSAzHc+krtY++szFnMNT0QKOGKbRZhy8hmNaVuiNwVWZZ
 /BYIg+aPswqT3cMq7rh0WjKcF/5NRHptBmQpdE4=
X-Google-Smtp-Source: APBJJlGqlDxwk9Fsfu+a6orObioBheeZ788owzJF1ysX/MKWty9WMJeYV5pWF36AAqcIE2fJTsQ/fw==
X-Received: by 2002:a7b:c7c5:0:b0:3fc:500:db7c with SMTP id
 z5-20020a7bc7c5000000b003fc0500db7cmr8474854wmk.21.1690297112225; 
 Tue, 25 Jul 2023 07:58:32 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b003fd2d33f972sm9189085wmm.38.2023.07.25.07.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/10] Misc fixes for 2023-07-25
Date: Tue, 25 Jul 2023 16:58:19 +0200
Message-Id: <20230725145829.37782-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 3ee44ec72753ec0ff05ad1569dfa609203d722b2:

  Merge tag 'pull-request-2023-07-24' of https://gitlab.com/thuth/qemu into staging (2023-07-24 18:06:36 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-fixes-20230725

for you to fetch changes up to f8cfdd2038c1823301e6df753242e465b1dc8539:

  target/tricore: Rename tricore_feature (2023-07-25 14:42:00 +0200)

----------------------------------------------------------------
Misc patches queue

hw/sd/sdhci: Default I/O ops to little endian
hw/mips/loongson3-virt: Only use default USB if available
hw/char/escc: Implement loopback mode to allow self-testing
target/mips: Avoid overruns and shifts by negative number
target/sparc: Handle FPRS correctly on big-endian hosts
target/tricore: Rename tricore_feature to avoid clash with libcapstone

----------------------------------------------------------------

Bastian Koppelmann (1):
  target/tricore: Rename tricore_feature

Bernhard Beschow (1):
  hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD controllers

Peter Maydell (2):
  target/mips: Avoid shift by negative number in
    page_table_walk_refill()
  target/sparc: Handle FPRS correctly on big-endian hosts

Philippe Mathieu-Daudé (4):
  target/mips/mxu: Replace magic array size by its definition
  target/mips/mxu: Avoid overrun in gen_mxu_S32SLT()
  target/mips/mxu: Avoid overrun in gen_mxu_q8adde()
  target/mips: Pass directory/leaf shift values to walk_directory()

Thomas Huth (2):
  hw/mips: Improve the default USB settings in the loongson3-virt
    machine
  hw/char/escc: Implement loopback mode

 target/sparc/cpu.h                  |  2 +-
 target/tricore/cpu.h                |  2 +-
 hw/char/escc.c                      |  4 ++-
 hw/mips/loongson3_virt.c            |  2 +-
 hw/sd/sdhci.c                       |  8 ++++-
 target/mips/tcg/mxu_translate.c     | 36 +++++++++++++++-------
 target/mips/tcg/sysemu/tlb_helper.c | 48 ++++++++++++++---------------
 target/sparc/cpu.c                  |  4 +--
 target/sparc/machine.c              |  3 +-
 target/sparc/monitor.c              |  2 +-
 target/tricore/cpu.c                |  8 ++---
 target/tricore/helper.c             |  4 +--
 target/tricore/op_helper.c          |  4 +--
 13 files changed, 75 insertions(+), 52 deletions(-)

-- 
2.38.1


