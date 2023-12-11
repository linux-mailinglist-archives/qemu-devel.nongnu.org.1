Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE180C447
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcML-0001Nk-7Q; Mon, 11 Dec 2023 04:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMJ-0001NE-9T
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMH-0004KK-5f
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c3f68b69aso17391845e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286027; x=1702890827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i1/Dp2Wa4oci+EhSWdiqYLZ0NCdvccY/wB+yXSQ90+Q=;
 b=vhT5Ig2JjKnA7JQjwVNt0vsfxEYnpq60D3MeHAcZMvPtNzFySGAo2yMsu5U2wvDFPH
 NtEFgF6S6hz0nsYjtArmZoqRl3hG+EG+RMNz/u6S/R1JDN33jDxRR57iAJNazGitOVAD
 ZOrPL1hQz1HKW4F/HK2xGIKWe6HSfT+DWCmmIhKc2Dtqxziqlxl6YYYsrG6ws/vYRY+R
 bw2w6qh/EenoFUNz6NeYY/7YofW2/ita3vJvW3v06d4sv9zrRSroBnGLgTQ8OhdKVX81
 MyCv4vQXcZO17KHlkLy3bzh9GT4x1e1BrvPuiqBQD3vt4oQzirEHV/ioJByC12D8TagE
 9SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286027; x=1702890827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i1/Dp2Wa4oci+EhSWdiqYLZ0NCdvccY/wB+yXSQ90+Q=;
 b=Qhhq8lCyDHurGjGjgtzUcz1xLiy1EzMrMuXHcH7kwkzKSJP49KxS4F10E7FvKJL/DS
 bYZnbxV8N9/IM5bl3VBo84KJF+8nnUIskZJ2Kzg1tFg49NBC1bjVTjnfV+/Cdvsevm5k
 02zx1iXvwsLq4hlzB0UL7euGqzCg3trYxHKYeNNnbnqvi9oEORnlWcAbE+C5sRkgoFfP
 yB3L1O9Pckci3WYHc9YmANfJWtDA3UuqN6BgLlzp/ADycfO3GT0eueHdPkxTXbSh2LoQ
 BFurkG64Xc+nl6KGnZqvL2UR9iQhiFMJFsF8BCFHgPT8FztuWZG/ZLisqCkcV3EdJTEO
 NxHg==
X-Gm-Message-State: AOJu0YzGhVTir62hOGE1Sx+GstIf4zy9DCFpOg7EMx77rab11w7+PKlA
 uBVL33QCYpp7gX8zBy59MVUNqg==
X-Google-Smtp-Source: AGHT+IEBy899S3CbylaZe9E0Nn35hIfdxH5ZQjRxk6bu6uN6TS4QcnWVoIgo6DZzHCNfT/XAIA19DQ==
X-Received: by 2002:a05:600c:450e:b0:40c:2b4c:ea8 with SMTP id
 t14-20020a05600c450e00b0040c2b4c0ea8mr2221428wmo.113.1702286026864; 
 Mon, 11 Dec 2023 01:13:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e12-20020a05600c4e4c00b0040b398f0585sm12484403wmq.9.2023.12.11.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A74D5FBC6;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/16] record/replay fixes: attempting to get avocado green
Date: Mon, 11 Dec 2023 09:13:29 +0000
Message-Id: <20231211091346.14616-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

As I'm a glutton for punishment I thought I'd have a go at fixing the
slowly growing number of record/replay bugs. The two fixes are:

 replay: stop us hanging in rr_wait_io_event
 chardev: force write all when recording replay logs

I think we are beyond 8.2 material but it would be nice to get this
functionality stable again. We have a growing number of bugs under the
icount label on gitlab:

  https://gitlab.com/qemu-project/qemu/-/issues/?label_name%5B%5D=icount

Changes
-------

v2

Apart from addressing tidy ups and tags I've been investigating the
failures in replay_linux.py which are the more exhaustive tests which
boot the kernel and user-space. The "fix":

  replay: report sync error when no exception in log (!DEBUG INVESTIGATION)

triggers around the time of the hang in the logs and despite the
rather hairy EXCP->INT transitions around cpu_exec_loop() I think
points to a genuine problem. I added the tracing to cputlb to verify
the page tables are the same and started detecting divergence between
record and replay a lot earlier on that when the replay_sync_error()
catches things. I see patterns like this:

   1878 tlb_fill 0x4770c000/1 1 2                                       tlb_fill 0x4770c000/1 1 2
   1879 tlb_fill 0x4770d000/1 1 2                                       tlb_fill 0x4770d000/1 1 2
   1880 tlb_fill 0x59000/1 0 2                                          tlb_fill 0x59000/1 0 2
   1881                                                               > tlb_fill 0x476dd116/1 0 2
   1882 tlb_fill 0x4770e000/1 1 2                                       tlb_fill 0x4770e000/1 1 2
   1883 tlb_fill 0x476dd527/1 0 2                                     | tlb_fill 0x476dfb17/1 0 2
   1884                                                               > tlb_fill 0x476de0fd/1 0 2
   1885                                                               > tlb_fill 0x476dce2e/1 0 2
   1886 tlb_fill 0x4770f000/1 1 2                                       tlb_fill 0x4770f000/1 1 2
   1887 tlb_fill 0x476df939/1 0 2                                     <
   1888 tlb_fill 0x47710000/1 1 2                                       tlb_fill 0x47710000/1 1 2
   1889 tlb_fill 0x47711000/1 1 2                                       tlb_fill 0x47711000/1 1 2

These don't seem to affect the overall program flow but are concerning
because the memory access patterns should be the same. My
investigations with rr seem to indicate the difference is due to
behaviour of the victim_tlb_cache which again AFAICT should be
deterministic.

Anyway I can't spend any time debugging it this week so I thought I'd
post the current state in case anyone is curious enough to want to go
diving into record/replay.

The following need review:

  replay: report sync error when no exception in log (!DEBUG INVESTIGATION)
  accel/tcg: add trace_tlb_resize trace point
  accel/tcg: define tlb_fill as a trace point
  tests/avocado: remove skips from replay_kernel (1 acks, 1 sobs, 0 tbs)
  replay: stop us hanging in rr_wait_io_event
  replay/replay-char: use report_sync_error
  tests/avocado: modernise the drive args for replay_linux
  tests/avocado: add a simple i386 replay kernel test (2 acks, 1 sobs, 0 tbs)

Alex Bennée (16):
  tests/avocado: add a simple i386 replay kernel test
  tests/avocado: fix typo in replay_linux
  tests/avocado: modernise the drive args for replay_linux
  scripts/replay-dump: update to latest format
  scripts/replay_dump: track total number of instructions
  replay: remove host_clock_last
  replay: add proper kdoc for ReplayState
  replay: make has_unread_data a bool
  replay: introduce a central report point for sync errors
  replay/replay-char: use report_sync_error
  replay: stop us hanging in rr_wait_io_event
  chardev: force write all when recording replay logs
  tests/avocado: remove skips from replay_kernel
  accel/tcg: define tlb_fill as a trace point
  accel/tcg: add trace_tlb_resize trace point
  replay: report sync error when no exception in log (!DEBUG
    INVESTIGATION)

 include/sysemu/replay.h        |   5 ++
 replay/replay-internal.h       |  50 ++++++++----
 accel/tcg/cputlb.c             |   4 +
 accel/tcg/tcg-accel-ops-rr.c   |   2 +-
 chardev/char.c                 |  12 +++
 replay/replay-char.c           |   6 +-
 replay/replay-internal.c       |   5 +-
 replay/replay-snapshot.c       |   7 +-
 replay/replay.c                | 141 ++++++++++++++++++++++++++++++++-
 accel/tcg/trace-events         |   2 +
 scripts/replay-dump.py         |  95 +++++++++++++++++++---
 tests/avocado/replay_kernel.py |  27 ++++---
 tests/avocado/replay_linux.py  |   9 ++-
 13 files changed, 314 insertions(+), 51 deletions(-)

-- 
2.39.2


