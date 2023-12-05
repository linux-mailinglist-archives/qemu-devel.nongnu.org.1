Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD82805FA1
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEC-0007Ng-CH; Tue, 05 Dec 2023 15:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEA-0007NJ-8T
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcE8-0002E2-90
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40bd5ea84d6so1023285e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808867; x=1702413667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uxeo8Z7o/ldYsO4WlAapqmXrOCHgg6w7w0JO1hikjKk=;
 b=s+2AT+XCVaVbcjmFB8HLuLg37CSrWIFw+y19zcbpbMmuUm0Mt3EQ0/+U4Q+01FUUIN
 RtdKMmCEhN1bQneHlx9J195UAEyvgqqei4kxXWDiAiuoSfikcWSRflKkaRm9YNefLt9t
 qQTG6SCbii/6ZK0H3JSeE9xWIdDFhWMSv53cyJIXkP9yMpyYKVi4nbpqfgdiuDDMN2NA
 zNzTuaSED13rQ+skNB4S21ROZBOr9DLIP1mZdae6Xh7fBZ2EVDz1IRCNttBwhi+y980B
 DM9Oms/tOLtwSYxQsf/aXY8KuBzQg33ZIcLzlJ90k7j25ibf6Kbu3e0gbPFKG6X3AUB1
 igcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808867; x=1702413667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxeo8Z7o/ldYsO4WlAapqmXrOCHgg6w7w0JO1hikjKk=;
 b=ETUBbCGyjS2NbvFVgFyLnQi5YllvbWHte/CKDE0a53LHKHSW/8d4eVmCa+J2nOFxiL
 KCStz4js7SiX4aNg4AoT9N+ECB1fzq8DwVDBiRwMuw9MwF7TVoIrjguEYtFmCgyl9nD4
 jIhERYtMCb/tCaKN5L1F6k5mUtpZCAW8YLlgZAv7XPNjMvdlQ54S1LSOiwQSthLs4wM4
 prQKHptqFVH0wuiilWR2S+N81lBoTJS3JgsqLC/gHYBqS4RGvMho4zwHFIueci/cTAMT
 0a8Kv25W7X4lz/Lp/IlUtrkxCcKxSYAXFDGGCElyA/BI13vdk5WOLmXPZmY3G2UwRwGH
 vCbQ==
X-Gm-Message-State: AOJu0YxhneluyjYiRSIVogjvl6v82F2XL/X0uVuRz4UoNOIxlmTQf1T0
 71W6ueGCl3O+78oeDxf7tj081g==
X-Google-Smtp-Source: AGHT+IGIlhPKVd7DXk3G1bT03igALKsXAOEbGpd8bmsTB84XG/sF0QREWZlYjOiGsqwZKKy359dfYw==
X-Received: by 2002:a05:600c:5117:b0:40b:50bf:e6df with SMTP id
 o23-20020a05600c511700b0040b50bfe6dfmr996269wms.10.1701808866665; 
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k13-20020adfe8cd000000b003333c2c313bsm9568258wrn.100.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 150C45FBB6;
 Tue,  5 Dec 2023 20:41:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/11] record/replay fixes,
 maybe for 8.2 or for post release stable?
Date: Tue,  5 Dec 2023 20:40:55 +0000
Message-Id: <20231205204106.95531-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

And the rest is various clean-ups and debugging aids. I don't know if
its worth pushing for 8.2 but it would certainly be nice to get some
review/testing to see if it solves issues for anyone else.

Alex.

Alex Bennée (11):
  tests/avocado: add a simple i386 replay kernel test
  tests/avocado: fix typo in replay_linux
  scripts/replay-dump: update to latest format
  scripts/replay_dump: track total number of instructions
  replay: remove host_clock_last
  replay: add proper kdoc for ReplayState
  replay: make has_unread_data a bool
  replay: introduce a central report point for sync errors
  replay: stop us hanging in rr_wait_io_event
  chardev: force write all when recording replay logs
  tests/avocado: remove skips from replay_kernel

 include/sysemu/replay.h                |  5 ++
 replay/replay-internal.h               | 43 ++++++++++-----
 accel/tcg/tcg-accel-ops-rr.c           |  2 +-
 chardev/char.c                         |  3 +-
 replay/replay-char.c                   |  6 +--
 replay/replay-internal.c               |  5 +-
 replay/replay-snapshot.c               |  6 +--
 replay/replay.c                        | 35 +++++++++++-
 roms/SLOF                              |  2 +-
 scripts/replay-dump.py                 | 75 +++++++++++++++++++++++---
 tests/avocado/replay_kernel.py         | 25 +++++----
 tests/avocado/replay_linux.py          |  2 +-
 tests/tcg/i386/Makefile.softmmu-target | 19 +++++++
 13 files changed, 185 insertions(+), 43 deletions(-)

-- 
2.39.2


