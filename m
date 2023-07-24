Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE475FE21
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzb6-0007DS-S0; Mon, 24 Jul 2023 13:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzb0-0007AU-QO
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNzau-0004GF-Rv
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:43:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso45436915e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690220618; x=1690825418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W4NwnUf4SI8mBVhJCSH2xbrR6TDw+jR/eh++l2wUuT0=;
 b=mIVJnjdHFs84OEDee/w7lcjvfp42bPY2nyiZ+8GxO0pxNX/uvG1zQL1+o0wHEZkPyD
 0n7WlGuoAYTE3PkBeDp9mcVH+4v70SAbH+SODKuMDIRktGGJYmS+uQjGlc+JkfcUL/5K
 gX+N+vLKUaWSV+iIfpj/ztX0yI3+MEFR8qNVYi+Ky5ohiNbmGxCVQ8tjvUTtABzm0LLR
 MsATk+7LoZjooOxez8jIsyPqA7vW9kHvEqutVW45CsHWLEfY/bPK5TWRmbOqcqBupWGT
 55pH1FZxZB7dpTcejbnwzHXGqyLzTLpO7ukf4hiogJS44d4/JoZBQuy1ltGpB2o/VdES
 DGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690220618; x=1690825418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4NwnUf4SI8mBVhJCSH2xbrR6TDw+jR/eh++l2wUuT0=;
 b=h1Hn6vco9xMpVmpLcA1Ji8fg6x6gL3kWyYtyNAlI4DPJ4d01PrMu/GtwPHXarnhX2I
 +L4NgValTo19A889XSNREwYbjOoihqwMG96aHtKql9rdPEGNv0tkqPczuJMu6MrS1mKg
 +hDKCvpzHQl+iXFrP7CSFMl3YsaUvFSTLZWt3UFD/e46mXIvjJZt/3a1CcxEZ36/c/KH
 nQz5OBkTiEczzUCzk8uztgv0PsW+3UFvP9B922ON7EIz47NuvoFnCH9xdKQrGfjPGcuB
 ndZuiPOT7Bnbgg16Zm/KaG/Ag+Pkh5jYwT43dzzkRBViNzQ1rHVDvLWGd2kuhD8JtpMw
 t2hA==
X-Gm-Message-State: ABy/qLbI5UPlZVybofx2rDz7h6xTdwz8Vt7q00SrUp1y5/V8tuhQpJqV
 OB5QkblsfFYhKjhd7ImBGsRhZLgl02HNAcYGhJk=
X-Google-Smtp-Source: APBJJlEn1UM1EAf9t1FtRZW7XCgho8I7qCOFRc37ttXAXDAtmHit6il9YFdU0b41oRA3gg5v3HQSJw==
X-Received: by 2002:adf:e0cc:0:b0:314:4db:e0bd with SMTP id
 m12-20020adfe0cc000000b0031404dbe0bdmr8670859wri.11.1690220617793; 
 Mon, 24 Jul 2023 10:43:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a0560001b0300b0030e52d4c1bcsm13687423wrz.71.2023.07.24.10.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:43:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 0/3] arm: Use correct number of MPU regions on mps2-tz
 boards
Date: Mon, 24 Jul 2023 18:43:32 +0100
Message-Id: <20230724174335.2150499-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This patchseries resolves issue
https://gitlab.com/qemu-project/qemu/-/issues/1772
which is a report that we don't implement the correct number of MPU
regions on our MPS2/MPS3 boards.  Ideally guest software ought not to
care since (a) it can find out the number of regions by looking at
the MPU_TYPE register and (b) if it wanted 8 MPU regions it can just
ignore the 8 extra ones.  However, Zephyr at least seems both to
hardcode this and to care.

Patch 1 cleans up a bug in target/arm code that meant that we
were accidentally not exposing the pmsav7-dregion on v8M CPUs.

Patches 2 and 3 then define properties on the armv7m object
and the ARMSSE SoC object, and have the mps2-tz.c board code
set the properties appropriately to match the config as
described for those FPGA images.

I have not looked at whether we also get this wrong for the
older (M3, M4, M7) boards in hw/arm/mps2.c.

I suspect we will want to allow users to reenable the old wrong
behaviour if they had guest images built to run on QEMU and not
tested on the real hardware.  There are some notes in patch 3's
commit message about that: with this series you can do that
using the -global option, but this might not be the best way.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Do all "ARM_FEATURE_X implies Y" checks in post_init
  hw/arm/armv7m: Add mpu-ns-regions and mpu-s-regions properties
  hw/arm: Set number of MPU regions correctly for an505, an521, an524

 include/hw/arm/armsse.h |   5 ++
 include/hw/arm/armv7m.h |   8 ++
 hw/arm/armsse.c         |  16 ++++
 hw/arm/armv7m.c         |  21 +++++
 hw/arm/mps2-tz.c        |  29 +++++++
 target/arm/cpu.c        | 176 +++++++++++++++++++++-------------------
 6 files changed, 173 insertions(+), 82 deletions(-)

-- 
2.34.1


