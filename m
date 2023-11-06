Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A577E28D0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:35:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b4-0007zp-Ok; Mon, 06 Nov 2023 10:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0007pk-WB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:45 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aj-0004NJ-PX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:44 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507975d34e8so6588444e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284759; x=1699889559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJa4gYfgZcl5h2N0LrVJZTikFP2bZrpmPlNhrITaOPE=;
 b=LPz7fG/BkPliXpBngaM1tH/I0uLM3t26dzu1ejOnpLDl2UPAhw8oIBO7uB1vcurkFJ
 POtd4gjiREK+M8wUThcUXaWaSUHpKopnGrpDnzJCUxWIPRz7a9V2DVDH2CCit25mvqSP
 gz8RkL5PpjvVol80QQjn2xL1qfPXXjY/54tTDcxxpP0dMXu+zhkr/VB8yJCZQuht1onj
 Q0W0A639hivgBJSIel3LhJMKNT2GujQD5n373zP7GEI9eiLLV8KMeKMcWk8oIFJDdRJ4
 U/w7DWMa9TFo0Z3RhFYCGjQxDFEO9fteyIh/aCF5vzkXa2LVx0/7KV+gqYV2PqwdBY4M
 Tb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284759; x=1699889559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJa4gYfgZcl5h2N0LrVJZTikFP2bZrpmPlNhrITaOPE=;
 b=lq6zuLWRw0RN8uNCksZs4hSbdWNUdHld4fmgm38/rVPEES9ojUMY+Orquvf4//ye9/
 kITJAMyVehdcAkORfXYCMRRORvLwchrLWjg+5jdSo9VpJZa4gLVfn90nVcjzYZBXOMyV
 AS8GuQME7OKGAGo73ooaag3RO3z76Q4SjvMts5JLY1P6HyowgoqIMP/+fvtrzK1KyKmr
 xYZcRxjqjaBFmVVQLKJ9mZ69Ylyhax1owAjAC9vYSgAgw0/yqNuMACrIABln+omnnWdf
 xaIAIxMD9QIAu41YromlXVAlRYfVyEgx3jG4Q+cjN6vOR1qQMzeW8U6LkRLApKglE31W
 zzNQ==
X-Gm-Message-State: AOJu0Yze5fZJgyElIMV5qip6YPonmcNduo+M8ptsjT9GOsheRY+cyQvM
 UrDhmySac+Dtxlkyw1E9O/IiWJsQT0KMUCt4j5Q=
X-Google-Smtp-Source: AGHT+IE4ExqjChKiH4hNk/KNd4zEvpdm6FA7wDkmkRsUmiGZS8V4PJCQWqQaYEisDnE8dA99S9HjWA==
X-Received: by 2002:a05:6512:312f:b0:507:9ae3:6ba7 with SMTP id
 p15-20020a056512312f00b005079ae36ba7mr21689239lfd.67.1699284759284; 
 Mon, 06 Nov 2023 07:32:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Mon,  6 Nov 2023 15:32:26 +0000
Message-Id: <20231106153238.1426649-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

Hi; here's another arm pullreq. These changes are all bug fixes
(including some Coverity issue fixes), so are OK for applying
either before or after softfreeze.

thanks
-- PMM

The following changes since commit 3e01f1147a16ca566694b97eafc941d62fa1e8d8:

  Merge tag 'pull-sp-20231105' of https://gitlab.com/rth7680/qemu into staging (2023-11-06 09:34:22 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231106

for you to fetch changes up to 5722fc471296d5f042df4b005a851cc8008df0c9:

  target/arm: Fix A64 LDRA immediate decode (2023-11-06 15:00:29 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/virt: fix PMU IRQ registration
 * hw/arm/virt: Report correct register sizes in ACPI DBG2/SPCR tables
 * hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no overflow
 * util/filemonitor-inotify: qemu_file_monitor_watch(): assert no overflow
 * mc146818rtc: rtc_set_time(): initialize tm to zeroes
 * block/nvme: nvme_process_completion() fix bound for cid
 * hw/core/loader: gunzip(): initialize z_stream
 * io/channel-socket: qio_channel_socket_flush(): improve msg validation
 * hw/arm/vexpress-a9: Remove useless mapping of RAM at address 0
 * target/arm: Fix A64 LDRA immediate decode

----------------------------------------------------------------
Peter Maydell (4):
      tests/qtest/bios-tables-test: Allow changes to virt SPCR and DBG2
      tests/qtest/bios-tables-test: Update virt SPCR and DBG2 golden references
      hw/arm/vexpress-a9: Remove useless mapping of RAM at address 0
      target/arm: Fix A64 LDRA immediate decode

Sebastian Ott (1):
      hw/arm/virt: fix PMU IRQ registration

Udo Steinberg (1):
      hw/arm/virt: Report correct register sizes in ACPI DBG2/SPCR tables.

Vladimir Sementsov-Ogievskiy (6):
      hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no overflow
      util/filemonitor-inotify: qemu_file_monitor_watch(): assert no overflow
      mc146818rtc: rtc_set_time(): initialize tm to zeroes
      block/nvme: nvme_process_completion() fix bound for cid
      hw/core/loader: gunzip(): initialize z_stream
      io/channel-socket: qio_channel_socket_flush(): improve msg validation

 docs/system/arm/vexpress.rst |   3 +++
 target/arm/tcg/translate.h   |   5 +++++
 target/arm/tcg/a64.decode    |   2 +-
 block/nvme.c                 |   7 ++++---
 hw/arm/vexpress.c            |  14 +++-----------
 hw/arm/virt-acpi-build.c     |   4 ++--
 hw/arm/virt.c                |   3 ++-
 hw/core/loader.c             |   2 +-
 hw/i386/intel_iommu.c        |  23 ++++++++++++++++++++---
 hw/rtc/mc146818rtc.c         |   2 +-
 io/channel-socket.c          |   5 +++++
 util/filemonitor-inotify.c   |  25 +++++++++++++++++--------
 tests/data/acpi/virt/DBG2    | Bin 87 -> 87 bytes
 tests/data/acpi/virt/SPCR    | Bin 80 -> 80 bytes
 14 files changed, 64 insertions(+), 31 deletions(-)

