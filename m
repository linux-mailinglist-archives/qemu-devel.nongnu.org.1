Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A09833732
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLa9-0002U8-71; Sat, 20 Jan 2024 19:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLa6-0002T3-9x
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:20:58 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLa4-0007Mj-0s
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:20:57 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cf87cdc4c5so1662677a12.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796454; x=1706401254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mw2fgI9qJ8IDsVWudbb1v03azBKGvd+V1nZIP3sncp4=;
 b=l/S4F72y8jjtYn3xsBevqstYj1LLX/SbCGlyOJi6ZuXavBkGRsEIhTWWa8Y38qBFpG
 lFk32PhoToc6mW9TPwwLC0tvRBJbj38TPsWzA/3cGDDSy2Nw8Flz9XPIGSL3gr5Ft7yR
 gtF+lwumZ1TN0V0czhtx+8K5qVG+hdHQeKtW4Ax/j0lqU23igsbFzRSt1DNiBDLjHeT0
 celqNYIWfOYpfvJrp71qal37VIGkrKIrlAqNv0/QxV54PhoyuM4MYAm38UcWZA/1uAHd
 mz7gWqujk0nPr2L3LnaXF4tP5lq8PO/RMKrq5Qa8tjiaSqhH6jD3Z9ePgBmR74ITVmKX
 xlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796454; x=1706401254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mw2fgI9qJ8IDsVWudbb1v03azBKGvd+V1nZIP3sncp4=;
 b=B9EakTa5a/k+bp9rT4iPVcTVg99CWh8h7opRwGGhCs3TwKw4q4ICO27RfBqk6l/htL
 0kDQvLM3/yvMshIVzhgpSu3xpbnBl2cCpNR3AeB+/JQyT2LY30Jghtcpx2FWFNjPXe2X
 RBKSNqLM6WUY+xyOKrutdNOPpnh1k6uDzQfHNex6894bo48GHfR4Paac9U+2nJYEZCP4
 BdRUMnHBVqRNwelTf3bSGLJnZgQ1EXi0us9EqyZBWhCEZU1sSuIEjVcOM5+cTWPvo1hD
 XqEUzODKzYdrrFYSbhBjAy6CLZ4f4WqHQr6C97TQyFOk9qVOjM+/JOPRrIV1xC6UODvY
 +f3g==
X-Gm-Message-State: AOJu0Yxg7aM5YlGvl9scOfrWQE0r4fg7Ioss4GVSYWgtMYP1ZhsExwqn
 rglxBqXmlcIJ5VYZbKA5KzjP7pPJ1Ej6UwTfVTB4IOKNIX6HAJmIL90AwyKmkA/8a5rksis7Opv
 uQBc=
X-Google-Smtp-Source: AGHT+IElEpXaku9ZT/4SwgiF1svaD+U61ZZHNBylnbMZVTsGw4fVGVHgihMieuhS9wgVWKV2hPPdyQ==
X-Received: by 2002:a17:902:7d88:b0:1d7:1948:6f2e with SMTP id
 a8-20020a1709027d8800b001d719486f2emr2042772plm.80.1705796453979; 
 Sat, 20 Jan 2024 16:20:53 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.20.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:20:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] tcg + linux-user patch queue
Date: Sun, 21 Jan 2024 11:20:39 +1100
Message-Id: <20240121002047.89234-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:

  Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240121

for you to fetch changes up to 1d5e32e3198d2d8fd2342c8f7f8e0875aeff49c5:

  linux-user/elfload: check PR_GET_DUMPABLE before creating coredump (2024-01-21 10:25:07 +1100)

----------------------------------------------------------------
tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
tcg: Clean up error paths in alloc_code_gen_buffer_splitwx_memfd
linux-user/riscv: Adjust vdso signal frame cfa offsets
linux-user: Fixed cpu restore with pc 0 on SIGBUS

----------------------------------------------------------------
Richard Henderson (3):
      tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
      tests/tcg/s390x: Import linux tools/testing/crypto/chacha20-s390
      linux-user/riscv: Adjust vdso signal frame cfa offsets

Robbin Ehn (1):
      linux-user: Fixed cpu restore with pc 0 on SIGBUS

Samuel Tardieu (2):
      tcg: Remove unreachable code
      tcg: Make the cleanup-on-error path unique

Thomas Weißschuh (2):
      linux-user/elfload: test return value of getrlimit
      linux-user/elfload: check PR_GET_DUMPABLE before creating coredump

 linux-user/elfload.c            |  10 +-
 linux-user/signal.c             |   5 +-
 tcg/region.c                    |  10 +-
 tests/tcg/s390x/chacha.c        | 341 +++++++++++++++
 tcg/s390x/tcg-target.c.inc      |   6 +-
 linux-user/riscv/vdso-32.so     | Bin 2900 -> 2980 bytes
 linux-user/riscv/vdso-64.so     | Bin 3856 -> 3944 bytes
 linux-user/riscv/vdso.S         |   8 +-
 tests/tcg/s390x/Makefile.target |   4 +
 tests/tcg/s390x/chacha-vx.S     | 914 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1281 insertions(+), 17 deletions(-)
 create mode 100644 tests/tcg/s390x/chacha.c
 create mode 100644 tests/tcg/s390x/chacha-vx.S

