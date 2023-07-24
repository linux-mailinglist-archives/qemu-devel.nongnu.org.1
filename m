Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1512A75EE63
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrJw-000209-FM; Mon, 24 Jul 2023 04:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJt-0001zZ-Ui
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNrJr-0000dU-QR
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:53:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fd190065a7so31491585e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690188810; x=1690793610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=79YWJhCKHyVzf+dNYi7ZM53X3zwepJXz+lAsXkNZRCI=;
 b=AvNKEyazA8d+Ai9X9sY9ZS3MeZGKcV+ts9V0e7+eCt8MP2nZl94ZBo2epjJbl887JA
 gjjZ4zPBF+h1Pv9sfRrNJbB33/6LI3ES3do2EXtXdJdnCb+Eq5+5dRLK/qMQNKDUa/cL
 B17epFQVeV3Y/KNUtfWce1TXHRv/+ABapmnLFwXtmvIt+9KdY7X2ztZ8teWJqCiUWL6r
 z5IZXqftUS1mNruRd3QaqNQMW+V8I2PwiWn23KuI+SWitzdvF+XtPiHKjdXFqEGFqNCv
 D8tdD87xeiFIe13XwAhvv3FnwmMxtDYMGSSEZDrs8vJ9MuBjTViGthXE77MHHmLF2U5e
 Ychg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690188810; x=1690793610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79YWJhCKHyVzf+dNYi7ZM53X3zwepJXz+lAsXkNZRCI=;
 b=esrp4wXCJWO34Xushe1rTTyn7OLuuoxyYGx+/1WP4BwrebO8JD6/Y4+aG1K8D82F4t
 Rmm6pMYTPalkgx4n9UEub/4m5hjk+RnPULqZ4Ng6GeJEiQA9J6gZbc6RbkuVb/2f/MDX
 rjBGfYcd7k8ZIjGWEOq+PLf3VUmJ9wZIaY2mgT1F2KvJC7zC4x146uR4lIxkv+L0VX+k
 o8oOPqvSom9d6Clt7P6lyNeUdrdAVUq0+6eyzcSzheCPYAXiAY8lS5Zi76462zQB9Pa6
 /bJj730iRDUC9wNIpWhKIu8Oyh+RbOGRZdUNTK1HBcIqeX9XKCcsGXcTVwRtebXNQiww
 aEJg==
X-Gm-Message-State: ABy/qLbsKTFJFTZvaxkpTPhs6bkZxavWthw3916mESPZU5JrUOTKL9Ui
 DXStnPSL9/IaBRncW5H0v5XjFx+90gzNCvcy7+eHBQ==
X-Google-Smtp-Source: APBJJlE+0BBQnVhXpaQuHR7Tdpak0LwN8LbnVoFAr+L9k5CjF5hXkhHYWUXE8OAvYvhc4ZuEFWXN1A==
X-Received: by 2002:a7b:c459:0:b0:3fd:2e59:b84c with SMTP id
 l25-20020a7bc459000000b003fd2e59b84cmr4365017wmi.37.1690188809841; 
 Mon, 24 Jul 2023 01:53:29 -0700 (PDT)
Received: from stoup.. ([62.252.144.58]) by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm9570994wmi.26.2023.07.24.01.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 01:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL for-8.1-rc1 0/7] tcg patch queue
Date: Mon, 24 Jul 2023 09:53:21 +0100
Message-Id: <20230724085328.4936-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:

  Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230724

for you to fetch changes up to 32b120394c578bc824f1db4835b3bffbeca88fae:

  accel/tcg: Fix type of 'last' for pageflags_{find,next} (2023-07-24 09:48:49 +0100)

----------------------------------------------------------------
accel/tcg: Zero-pad vaddr in tlb debug output
accel/tcg: Fix type of 'last' for pageflags_{find,next}
accel/tcg: Fix sense of read-only probes in ldst_atomicity
accel/tcg: Take mmap_lock in load_atomic*_or_exit
tcg: Add earlyclobber to op_add2 for x86 and s390x
tcg/ppc: Fix race in goto_tb implementation

----------------------------------------------------------------
Anton Johansson (1):
      accel/tcg: Zero-pad vaddr in tlb_debug output

Ilya Leoshkevich (1):
      tcg/{i386, s390x}: Add earlyclobber to the op_add2's first output

Jordan Niethe (1):
      tcg/ppc: Fix race in goto_tb implementation

Luca Bonissi (1):
      accel/tcg: Fix type of 'last' for pageflags_{find,next}

Richard Henderson (3):
      include/exec: Add WITH_MMAP_LOCK_GUARD
      accel/tcg: Fix sense of read-only probes in ldst_atomicity
      accel/tcg: Take mmap_lock in load_atomic*_or_exit

 include/exec/exec-all.h        | 10 ++++++++++
 tcg/i386/tcg-target-con-set.h  |  5 ++++-
 tcg/s390x/tcg-target-con-set.h |  8 +++++---
 accel/tcg/cputlb.c             | 20 ++++++++++----------
 accel/tcg/user-exec.c          |  4 ++--
 bsd-user/mmap.c                |  1 +
 linux-user/mmap.c              |  1 +
 tcg/tcg.c                      |  8 +++++++-
 accel/tcg/ldst_atomicity.c.inc | 32 ++++++++++++++++++--------------
 tcg/i386/tcg-target.c.inc      |  2 +-
 tcg/ppc/tcg-target.c.inc       |  9 +++++----
 tcg/s390x/tcg-target.c.inc     |  4 ++--
 12 files changed, 66 insertions(+), 38 deletions(-)

