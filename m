Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D907E707939
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVRu-00067J-Hl; Thu, 18 May 2023 00:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRr-00066I-Kx
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:07 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRm-00076t-Aw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:06 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5304d0d1eddso818015a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384860; x=1686976860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2j+KG0vywAY0xpdoWRt7odhQMaLxqAskBd42QfUyDtE=;
 b=Bh7a0/iyJMzfanu0qAfhaOO1vAed7hJLxhij/aEZU+dMEbCQIKPP8Cfb9VT7vzRNyQ
 YG3+6MrV3v+sAc4CUn8bq3ShxTHwuEegQhnUJ+MRHgYXjfzZaOOoNu5j3yLp5NK9JVw/
 LTt3RtMsEtlN/DV6EF1s/L3xfFhHvEmBJT5hR3oa2UoPqvHrqkBgB9208hUn2bRdr2Ax
 PxA+iNOlsat+FjWwDOH/H1n7VKyjhpY58xhSfuxYm6h16QHAbH/DerhbcUvQga1I81IW
 kP7W+IB2EuIwitojpIqsZFQddQ4uEIRZUOBaUiXPE99cNARoI615XzNT8K4WiAD/AW80
 YOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384860; x=1686976860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2j+KG0vywAY0xpdoWRt7odhQMaLxqAskBd42QfUyDtE=;
 b=Bz1eBMc/gWDo3NzMSB/GIXdbx9Er4rkQ3aceE2MCP++0jdIs5P1dDk2w6P/ZQ4saQG
 DSFtu6uf+15Kz/JcnevDXuCegNV6tFVRz+Wb8tiEmFzj5vUCPCFjrZK1daP9gysY6ase
 EI11ZKlA7e1R9iDuo/FEJaLBSjIo/7JQMbieK+NF1CeV3VYMPoMZ3/AeQeF+laRcb046
 2CNgJapVl0Ml8QpZekRzURSZQ5tCvtRdoQ7tp6EMwds/GQHjyoYrFxSHJmwAjMpA/lPW
 3u58ibjMmULsIrEFxU5ZXhwxwv6wnzmMdk5uz55KvQG2I8ODbPNjhlrXH6ZF6g76KYFs
 8Vmg==
X-Gm-Message-State: AC+VfDwD825yztuWlS3HeU2cHSKEz8l0QAQECDjaekzCwsqUB6pvqAK+
 GfCbkykjBXOxlevTFsY4jM13OGj6oE+Y7dUO6FQ=
X-Google-Smtp-Source: ACHHUZ7sxmE1l2Yyn1wMVtXffNkG7GepVtLJDHpzjjDTpFIofWPGivik8NwGcVrpBDbb/MIZoPmjuw==
X-Received: by 2002:a17:903:1c7:b0:1ae:1237:8754 with SMTP id
 e7-20020a17090301c700b001ae12378754mr1494885plh.68.1684384860392; 
 Wed, 17 May 2023 21:41:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/9] Host-specific includes, begin cpuinfo.h
Date: Wed, 17 May 2023 21:40:49 -0700
Message-Id: <20230518044058.2777467-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Hiya.

This is looking toward cleaning up a couple of things:

(1) There are 5 bits of x86 host detection, 3 of them for xbzrle.
    Unify this down to one, with additional cleanups for xbzrle.

(2) Provides a host-specific include path for splitting atomic128.h
    and probably other stuff so as to avoid host-specific ifdefs.
    Actually splitting atomic128.h is so far left for further work.


r~


Richard Henderson (9):
  util: Introduce host-specific cpuinfo.h
  util: Add cpuinfo-i386.c
  util: Add i386 CPUINFO_ATOMIC_VMOVDQU
  tcg/i386: Use cpuinfo.h
  util/bufferiszero: Use i386 cpuinfo.h
  migration/xbzrle: Shuffle function order
  migration/xbzrle: Use i386 cacheinfo.h
  migration: Build migration_files once
  util: Add cpuinfo-aarch64.c

 include/host/aarch64/cpuinfo.h |  22 ++
 include/host/generic/cpuinfo.h |   4 +
 include/host/i386/cpuinfo.h    |  39 +++
 include/host/x86_64/cpuinfo.h  |   1 +
 migration/xbzrle.h             |   5 +-
 tcg/aarch64/tcg-target.h       |   4 +-
 tcg/i386/tcg-target.h          |  28 +-
 migration/ram.c                |  34 +--
 migration/xbzrle.c             | 268 ++++++++++---------
 tests/bench/xbzrle-bench.c     | 469 ---------------------------------
 tests/unit/test-xbzrle.c       |  49 +---
 util/bufferiszero.c            | 126 ++++-----
 util/cpuinfo-aarch64.c         |  67 +++++
 util/cpuinfo-i386.c            |  99 +++++++
 meson.build                    |   8 +
 migration/meson.build          |   1 -
 tcg/aarch64/tcg-target.c.inc   |  41 +--
 tcg/i386/tcg-target.c.inc      | 123 +--------
 tests/bench/meson.build        |   6 -
 util/meson.build               |   6 +
 20 files changed, 476 insertions(+), 924 deletions(-)
 create mode 100644 include/host/aarch64/cpuinfo.h
 create mode 100644 include/host/generic/cpuinfo.h
 create mode 100644 include/host/i386/cpuinfo.h
 create mode 100644 include/host/x86_64/cpuinfo.h
 delete mode 100644 tests/bench/xbzrle-bench.c
 create mode 100644 util/cpuinfo-aarch64.c
 create mode 100644 util/cpuinfo-i386.c

-- 
2.34.1


