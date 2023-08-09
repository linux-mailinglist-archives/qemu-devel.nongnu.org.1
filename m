Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6CD7766B1
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK1-0000Nk-MS; Wed, 09 Aug 2023 13:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJz-0000NC-Pm
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:11 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJx-0005e2-Jr
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2685bcd046eso23732a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603408; x=1692208208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nx56vo8B3spmDy3FJz3Z8PV3F+4nxtGDyfUoO7XDjLg=;
 b=iEtVxAG+4IbgNLDC0bdA5Cm1X1jqZUBDalgIhZiie6ae8ksLhlrq6EOqv2w2RCP+uA
 ZuabV/dehbglBwnGyj+UbOXuNHYNwuG07mZgMpOVbPpeFkZoaUt1UxqFHK+uAROfIMEl
 6qjqSgRXNPWEogPAo8q7LhZYGEprNQLFqA/69ufLIOCgZP72b5N9XiY1B97EXV53c/d0
 b/uxDhzzarQKihAmkEPmZFyGmoYHqPZ5D93prZGtINy5bX2r3/LZV89dvSSjaH3Q7dRl
 bCVrnMPwX8aTqm1qSPVroZCQu1JhAPz+hN+d+yKax0ZkC1o7WFnhjOG9LmPyJuAkxu6c
 wjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603408; x=1692208208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nx56vo8B3spmDy3FJz3Z8PV3F+4nxtGDyfUoO7XDjLg=;
 b=TGRdZOhFg5PLVpq/3w/wVSc3yLGRWTjCHFlstldnbCGNy/VT7E4EqjAwEjbSN7sul7
 HX01UB7v8iklYvpB8VSyNFkDrcVtec45Hpav2wAcQ/wHdhZOIZu6nIUZXwWyxLKDTk1A
 IM36ZS/zGaS6u4PEMteeKN49LOBWtVqRGk2iDmCFmu4kbS7DKhCERFlw3AO1UkeNSS30
 UVgj2/+1F/ZOBwqBrRydFOK+RdIgvoN8FgUUdbhViQrAigcHdDYdatCtAMJCffmdaRaR
 LN1IBUNNyz2OT2TNCn4xksbAf4fx7BYmgzyjXbJvSUri7Qvi8sCvZ6hLX+p7wwcA3eD+
 zeFw==
X-Gm-Message-State: AOJu0YxaBPX5qiopdTNtO+SNKwGKFt1eXCpNWFbw7/2CHmcm7D6hZQfH
 +t6jJpFvtEAzLA3SD3aXV4EziD3B2LQ9UzW8VIM=
X-Google-Smtp-Source: AGHT+IFQg/XpHGMA3U2r5rSrFalM47WzaEL4u8Ax6g1Na8oNWrNDAOn/YPUvZAxRmS37p0DLH0zdWw==
X-Received: by 2002:a17:90a:d515:b0:268:325e:ee1a with SMTP id
 t21-20020a17090ad51500b00268325eee1amr4784pju.27.1691603407664; 
 Wed, 09 Aug 2023 10:50:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] linux-user late fixes
Date: Wed,  9 Aug 2023 10:50:00 -0700
Message-Id: <20230809175006.242479-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 32e07fddc6d989dc5fdff4f9c9e47cb1f3911904:

  Merge tag 'pull-lu-20230808' of https://gitlab.com/rth7680/qemu into staging (2023-08-08 14:10:07 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230809

for you to fetch changes up to b8002058c45a50d893c51cf62ec96c70128fc1eb:

  linux-user: Fix openat() emulation to correctly detect accesses to /proc (2023-08-09 09:31:30 -0700)

----------------------------------------------------------------
linux-user: Fixes for mmap syscall emulation
linux-user: Correctly detect access to /proc in openat
util/interval-tree: Check root for null in interval_tree_iter_first
tests/tcg: Disable filename test for info proc mappings

----------------------------------------------------------------
Helge Deller (2):
      util/interval-tree: Check root for null in interval_tree_iter_first
      linux-user: Fix openat() emulation to correctly detect accesses to /proc

Richard Henderson (4):
      qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
      linux-user: Split out do_mmap
      linux-user: Use ARRAY_SIZE with bitmask_transtbl
      tests/tcg: Disable filename test for info proc mappings

 bsd-user/syscall_defs.h                           |   2 +
 include/exec/user/thunk.h                         |  15 ++-
 include/qemu/osdep.h                              |   3 -
 linux-user/syscall.c                              | 109 +++++++++++++++++-----
 linux-user/thunk.c                                |  24 ++---
 util/interval-tree.c                              |   2 +-
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py |   3 +-
 7 files changed, 113 insertions(+), 45 deletions(-)

