Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E0D82BA57
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 05:23:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO93F-0006GG-PS; Thu, 11 Jan 2024 23:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93D-0006FQ-5V
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:21:47 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO939-0004bS-9x
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:21:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d4a980fdedso53402695ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 20:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705033300; x=1705638100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3U7uOXE86lZw8NgiaOrGz3Y7C9a8cxa1Ptj8COzN6Rw=;
 b=NhPFkmvdG54QAEQfYf2ulSg+z/B67+cVFAraR19+KGcUJk58rEd61IZJEa/OXtUnAD
 Bl0Utcft6jkuXNSd7KhLxIxG0T2hiriUAabR7fNenqSNLpQq829B3nbHa0zxlh+OS1fg
 dnjdvAbNRqreNPgOLyq3ytpWOEVdvUXQ9gH0Fu2HSm5VP47bT4RBKncT+rYIP8eWbhzE
 rZhh7vyMbdOalzEUa1Lt65Xo6EMr8odXoQcyS/I7VAdJB25pUnlX9DdPwO04qB8ejX0c
 OVYLYjxB9BDWpHjpEsgKPcrPsf48wOmamG6zAwkH3mDZ9eT33Xw0c6E1cIShwspqtA3l
 0KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705033300; x=1705638100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3U7uOXE86lZw8NgiaOrGz3Y7C9a8cxa1Ptj8COzN6Rw=;
 b=UeYABJ/Rj1I+FqlktFsHrfcMXXrXPAE9UVrtfGS49tooUbsM/6azKyidwrn9882D3D
 pj9TcPfOpGxqJSGqlPskS0a05156c01NywiAXm9rIPQkTfOieXgiqiEJ8ur6jKxD7lge
 A1ubb+4KcStCR6RozOH9ZP70EEKY9+77r4GN2I8aUbVBgA/ihkeDjxgSOPaAJMUBxoBs
 9pv0XJOSqMCVjys6k9O9zRAkQHu+xn3PDhUkfTssYLB0I9H5xMHSMrHMd2hFgxaEbSeI
 d3xc1wGb1BsVS6VCSsYqy+iRnrcDTOO+1eZQLefwzQ4F+xGlkKlsIiadYhV+Hlqtqxgu
 jecA==
X-Gm-Message-State: AOJu0YzfhGDS4qlYSdxQvh4GEeAo/7YdIB5vXXH2oNgp0wU0gLS2qv1O
 T3gPCDCOt334LKYtz6K/LVOGm66tTqE=
X-Google-Smtp-Source: AGHT+IGbLBuq/Higax61p6oXjw2vHDyT5Sl6hoJaSr4zrLJ90Fz3LCFDYK67ZEp0ZK9rUdasa259mg==
X-Received: by 2002:a17:902:e9d5:b0:1d5:8d34:1369 with SMTP id
 21-20020a170902e9d500b001d58d341369mr419889plk.135.1705033300473; 
 Thu, 11 Jan 2024 20:21:40 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a170902d4d100b001d4c98c7439sm2018576plg.276.2024.01.11.20.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 20:21:40 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/4] target/xtensa: provide configuration with MPU
Date: Thu, 11 Jan 2024 20:21:24 -0800
Message-Id: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

this series adds xtensa core 'sample_controller32' with 32 foreground
entry MPU, adds missing translation for the 'wsr.mpucfg' opcode and
makes xtensa/tcg/tests work with the new core.

Max Filippov (4):
  target/xtensa: add translation for wsr.mpucfg
  target/xtensa: import sample_controller32 core
  tests/tcg/xtensa: tidy test linker script
  tests/tcg/xtensa: fix SR test for configs with MPU

 target/xtensa/core-sample_controller32.c      |    52 +
 .../core-sample_controller32/core-isa.h       |   739 +
 .../core-sample_controller32/core-matmap.h    |   106 +
 .../core-sample_controller32/gdb-config.c.inc |   144 +
 .../xtensa-modules.c.inc                      | 11845 ++++++++++++++++
 target/xtensa/cores.list                      |     1 +
 target/xtensa/translate.c                     |     9 +
 tests/tcg/xtensa/linker.ld.S                  |    34 +-
 tests/tcg/xtensa/test_sr.S                    |    16 +-
 9 files changed, 12921 insertions(+), 25 deletions(-)
 create mode 100644 target/xtensa/core-sample_controller32.c
 create mode 100644 target/xtensa/core-sample_controller32/core-isa.h
 create mode 100644 target/xtensa/core-sample_controller32/core-matmap.h
 create mode 100644 target/xtensa/core-sample_controller32/gdb-config.c.inc
 create mode 100644 target/xtensa/core-sample_controller32/xtensa-modules.c.inc

-- 
2.39.2


