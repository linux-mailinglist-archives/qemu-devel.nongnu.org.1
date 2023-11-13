Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678E7EA2B0
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:18:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVQ-0007Uw-KE; Mon, 13 Nov 2023 13:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVO-0007UL-VQ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:17:50 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVN-0000Ri-DM
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:17:50 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d10972e63eso699102666b.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899467; x=1700504267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f+1KBRO0+9/dV2cXPBXDfIDZ7AUDEqHTniy8whQ5hc8=;
 b=idcH4q0JEBFCblPVHckyf9x+QUNlR8SHCjgKu/ogXXtgKOEP9qZNvlCysNpSBoqV7F
 NzT7HZPdypmUpe/JnJFwMJ8zt93ZGwsXjpR+Nipw4M9cxo/CMuhDc9XF4jQM9yEI6T3E
 N9BJhRsr/XkhnNB5VodyI80dMyIhC8qRHjVurl9roy5u+84sPVnvWdHFDchTX/pB1MZr
 rljxWwGfv2gMNvEHwDRc2oRTwChC7zXYAc0HW24VZi7uQOTty8CjF4E08PnhwZ/M7fMG
 9PvMjkd4ybXrqqceumuj6A76EgXCRLmI0xQ5UnvWYxVCrjENztfWTWqFdZfnAMRyTj6Z
 9ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899467; x=1700504267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+1KBRO0+9/dV2cXPBXDfIDZ7AUDEqHTniy8whQ5hc8=;
 b=BNnAx2Nh6dxcRlaQhimv3Elo+uOTrsTPCgkEvrTY0O5Mkxnvs6cVb3z7AgFAH89PnU
 7S0vDVP4ALOH0UEUsD2AHCeWcMUMGg5SciX4pskJ3zGXoamEzt3+R9G5wxgWptJiDGpV
 6lblf7TOI027AstSNGEONHz4HiQO2zEssjszdjNKJ2qGW0R05QzSCbFhDhxWt8EjpdgY
 qrEiINHs8W/3KAavUi/CLjXOVA42QKoOF+d43VNwn7QOAnRmIjHD8oq5ZGlFwLEYbwoC
 +sI22fxXViHPHlQ7OdcuCAVXQaVN8vL1OBLBDNvRgrA8ecrOqXAfRcRNgbJiQ7LPUjiB
 ITLg==
X-Gm-Message-State: AOJu0Yyn6DLjkPjNCHMgNWDZ2YMfvM6P43zIV//ZPtRm1a9NTScFqE68
 uuSTpnRi1aktM3zlu/KeGGsAVgJxciwjk2g9lXE=
X-Google-Smtp-Source: AGHT+IEFnZeyeDLUezx0h5ofyAa3Gohc4BKAKAyCeIgIzCwvOL27JUBofIXCb3iRsfNYjULUapsMZA==
X-Received: by 2002:a17:906:268b:b0:9e6:59d5:820d with SMTP id
 t11-20020a170906268b00b009e659d5820dmr5254680ejc.2.1699899467097; 
 Mon, 13 Nov 2023 10:17:47 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 ko14-20020a170907986e00b009dd701bb916sm4345396ejc.213.2023.11.13.10.17.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:17:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/5] Misc fixes for 2023-11-13
Date: Mon, 13 Nov 2023 19:17:39 +0100
Message-ID: <20231113181744.49537-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-fixes-20231113

for you to fetch changes up to 04c0a003dd33c7f1dea989319085984822c768e6:

  MAINTAINERS: update virtio-fs mailing list address (2023-11-13 19:06:06 +0100)

----------------------------------------------------------------
Misc fixes for 8.2

- Missing Kconfig dependency in hw/mips (Marc-André)
- Typo in VMWare model (Alexandra)
- New avocado test for x86 processors addressing (Ani)
- Fix SyntaxWarnings in avocado (Thomas)
- Update virtio-fs mailing list address in MAINTAINERS (Stefan)

----------------------------------------------------------------

Alexandra Diupina (1):
  hw/display/vmware_vga: fix probably typo

Ani Sinha (1):
  tests/avocado: add test to exercise processor address space memory
    bound checks

Marc-André Lureau (1):
  hw/mips: LOONGSON3V depends on UNIMP device

Stefan Hajnoczi (1):
  MAINTAINERS: update virtio-fs mailing list address

Thomas Huth (1):
  tests/avocado/machine_s390_ccw_virtio.py: Fix SyntaxWarnings from
    python 3.12

 MAINTAINERS                              |   2 +-
 hw/display/vmware_vga.c                  |   4 +-
 hw/mips/Kconfig                          |   1 +
 tests/avocado/machine_s390_ccw_virtio.py |  18 +-
 tests/avocado/mem-addr-space-check.py    | 356 +++++++++++++++++++++++
 5 files changed, 369 insertions(+), 12 deletions(-)
 create mode 100644 tests/avocado/mem-addr-space-check.py

-- 
2.41.0


