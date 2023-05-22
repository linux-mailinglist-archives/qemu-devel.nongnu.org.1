Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFA70C277
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wa-0007NY-FU; Mon, 22 May 2023 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vp-0007MH-Ay
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:31:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Vn-0001JK-Lv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:31:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f605d8a8a9so10478895e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769507; x=1687361507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/wKkfjSufx3DW+zYa0E7GEJz1aH+QHJBoM2dYSQDuDM=;
 b=Ls+YTqEiXNT1nvjLPQxPfMv9S5eAVqJSNAlaIst4auvrLVJ+PGfJ9b8XWD+DU7/sIR
 wVw7kmV24VNxMAVUsIaW7JwVDAoK7DfCvNCYJrIfW0l6ceb/e0TK9ijR5b1O1DuP1B6l
 GDbc7ZhQhPpW1/HeKKqmmnOk7VaAAD3ToNZl1tN+lPsPCr4NKLSQICo/FmgcwLn4rSn4
 9QTb9vaxZkY40Su9eEVhdXCXSPBoxlGdHbB0aYOgqNX9WnTVYmHjQK5EcDQlTOiPwKDl
 a3BFxYZSuTzvql9VkStkSMRnC4OAcTuKzXJm1DRhyuj9sKI0czdm+gThjC18tQNKjNLz
 +4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769507; x=1687361507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wKkfjSufx3DW+zYa0E7GEJz1aH+QHJBoM2dYSQDuDM=;
 b=Ek+5PbWjIU9eGDQqCPRDnMPNXcxBsB0btV6Jrd0P6H/nalc043EIdnjj7pQlYhjRFH
 gtEMXTNSp5whWN8s6nsnR4lRW0ccRPlsrS89ByVlL7UqD/uDSbU4JJidPzbrduPM27GK
 cV+7qCQcW0GuCcDPg4f7O+YziO6xh837aReO5o8vfe5ZlWamOVyvPDFXBSzO6lvwOc4E
 XEi0anSGQ7TwTL5E/GxCMY1sdh4sSOIWq9pLItMPsRGwY4TqQV91ZJ/3Ky5ucybdCiwc
 YinkL15iR/iDTqSV0jWlR2zYVV8z26VvnU/w7tORdy/OfCD7FL2otT4Y0Buo0TSeGkts
 ei1g==
X-Gm-Message-State: AC+VfDwE9W/22h5bG34nITSSa3xAio89XnCSzDywiTpNsjWPaNyKv701
 SKsyOFwDYFHnVnSWIEynwn59Z2X+Rbl6ibPJHLY=
X-Google-Smtp-Source: ACHHUZ40xk9g4Wq4zxmi/h1i1cAfDWib/ppaY5zlVyrnf6jwRFrWXtLjAk/JCe/7rmNUQ2oeqp1S9w==
X-Received: by 2002:a1c:f710:0:b0:3f5:146a:c79d with SMTP id
 v16-20020a1cf710000000b003f5146ac79dmr7210395wmh.15.1684769507111; 
 Mon, 22 May 2023 08:31:47 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a5d464f000000b00307d58b3da9sm8056538wrs.25.2023.05.22.08.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:31:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH 00/12] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
Date: Mon, 22 May 2023 17:31:32 +0200
Message-Id: <20230522153144.30610-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi,

This series add support for (async) FIFO on the transmit path
of the PL011 UART.

- First we add fifo8_peek_buf() to the fifo8 API (patches 1-3),
- Then we massage a bit the pl011 model to ease development
  (patches 4-11),
- Finally we add the TX FIFO implementation using a chardev
  front-end 'watch' callback.

The last patch is RFC mostly because I don't know what is the
best way to resolve adding a new migratable field without
breaking the migration stream.

Tested with qtest/avocado/TRS test suites:

 trs-workspace$ make test
 Startup finished in 6min 40.596s (kernel) + 38.786s (userspace) = 7min 19.382s.
 RESULTS - date.DateTest.test_date: PASSED (46.90s)
 RESULTS - df.DfTest.test_df: PASSED (2.29s)
 RESULTS - parselogs.ParseLogsTest.test_parselogs: PASSED (23.45s)
 RESULTS - ping.PingTest.test_ping: PASSED (0.05s)
 RESULTS - python.PythonTest.test_python3: PASSED (2.72s)
 RESULTS - rtc.RTCTest.test_rtc: PASSED (51.84s)
 RESULTS - ssh.SSHTest.test_ssh: PASSED (4.56s)
 RESULTS - systemd.SystemdBasicTests.test_systemd_basic: PASSED (2.33s)
 RESULTS - systemd.SystemdBasicTests.test_systemd_failed: PASSED (4.41s)
 RESULTS - systemd.SystemdBasicTests.test_systemd_list: PASSED (30.07s)
 RESULTS - systemd.SystemdJournalTests.test_systemd_boot_time: PASSED (2.42s)
 RESULTS - systemd.SystemdJournalTests.test_systemd_journal: PASSED (2.62s)
 RESULTS - systemd.SystemdServiceTests.test_systemd_disable_enable: PASSED (40.34s)
 RESULTS - systemd.SystemdServiceTests.test_systemd_status: PASSED (2.43s)
 RESULTS - systemd.SystemdServiceTests.test_systemd_stop_start: PASSED (9.23s)
 RESULTS - opteetest.OpteeTestSuite.test_opteetest_xtest: PASSED (329.89s)
 RESULTS - soafeetestsuite.SoafeeTestSuite.test_soafee: PASSED (272.07s)
 RESULTS - tpm.TpmTestSuite.test_tpm: PASSED (53.61s)
 RESULTS - ptest.PtestRunnerTest.test_ptestrunner_expectfail: SKIPPED (0.00s)
 RESULTS - ptest.PtestRunnerTest.test_ptestrunner_expectsuccess: SKIPPED (0.00s)
 RESULTS - systemd.SystemdServiceTests.test_systemd_disable_enable_ro: SKIPPED (0.00s)
 SUMMARY:
 trs-image () - Ran 21 tests in 883.291s
 trs-image - OK - All required tests passed (successes=18, skipped=3, failures=0, errors=0)

Philippe Mathieu-Daudé (12):
  util/fifo8: Fix typo in fifo8_push_all() description
  util/fifo8: Allow fifo8_pop_buf() to not populate popped length
  util/fifo8: Introduce fifo8_peek_buf()
  hw/char/pl011: Display register name in trace events
  hw/char/pl011: Remove duplicated PL011_INT_[RT]X definitions
  hw/char/pl011: Replace magic values by register field definitions
  hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
  hw/char/pl011: Extract pl011_write_tx() from pl011_write()
  hw/char/pl011: Check if transmitter is enabled
  hw/char/pl011: Check if receiver is enabled
  hw/char/pl011: Rename RX FIFO methods
  hw/char/pl011: Implement TX FIFO

 include/hw/char/pl011.h |   2 +
 include/qemu/fifo8.h    |  38 ++++++--
 hw/char/pl011.c         | 209 +++++++++++++++++++++++++++++++++-------
 util/fifo8.c            |  28 +++++-
 hw/char/trace-events    |  12 ++-
 5 files changed, 239 insertions(+), 50 deletions(-)

-- 
2.38.1


