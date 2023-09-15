Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385A7A23C0
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtu-0004QA-2A; Fri, 15 Sep 2023 12:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBts-0004Iq-75
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtq-0004sh-F3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fdd6011f2so1946208b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796153; x=1695400953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WvshgsM5HCbzos1/2tQ3Q09/zhrQ3ymu2EsWiCZ5Ulk=;
 b=E+NVLJRRLuxPiKiJzEHKLfOyxSg51FSagRVEF+iM4F4GtgliJ56l4FTvOLTBSrYSPB
 tt50kv6QOLP3L0jCCusn9Z1+RwTG5dtfW4oBKhHiJwboZa8sMfpH5NNmEBkFXkRg2/dJ
 fMRXc/kR2I6k313feOFI2ByIvqCIenlUgw2zH/FtQ2Ou8Ga8McO9OS+aC18ccImrW0ml
 JbbWbTiKMLGwMZgHLet/lrHTkD4RF7fs8bzfM4UeGYEhoLe6s0kjP9tBWTusxh3ndSQA
 7RQCVFGEAJr54s0sBNX+pOjzt3AG5LiJ2DQTW/rrrXCgROcPtto9nL4s8IZJrXiincrP
 AeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796153; x=1695400953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WvshgsM5HCbzos1/2tQ3Q09/zhrQ3ymu2EsWiCZ5Ulk=;
 b=rFRv4bckzGBzDgje8evPdoQPPANbg+5b8dDXkJKV/GSNqPYXqBho+43OGA3cnqmUSY
 lTidkAKj9TGIRtPclZV5JTVrekdjolBakGjOjO9MH6kxgRJXZ4gmqpqXF98QYUCnfmhp
 Mw8CtjALlA8EzVOGMcpnNZYDkvDMDj7DdiOXvq+FLXiiYmwHdPsuxWLxfPHjFZc1PUlG
 2WUS1nke4WapQom/0p6I/mGWLb1nbzmVMGhz76QhUv4TNG6F4Pfq3OPmmJCnNawrqRtN
 5l9tdGqE0f8OL68/IOKcf5hf49dmqYvkg9TEbAmfdz+x3mFlOplpkI9SLP+pSAnGQosC
 UG9w==
X-Gm-Message-State: AOJu0Yzd+JuEzDF5VDl1v8MP6keKJOZGARhNBq5qsiBdxi/0mhvFJ+/o
 vNY5mhZRaxU5MOz4pr1YmVyqhUfotZAJb+Fhl0Q=
X-Google-Smtp-Source: AGHT+IFnKe7ZtJ4wreWHhaIAE+v5nve5OGN5xP+uZsTff33RNHJiW6SL6YoiQMV144ZBTTsvh9YT9A==
X-Received: by 2002:a05:6a20:549f:b0:135:4df7:f165 with SMTP id
 i31-20020a056a20549f00b001354df7f165mr2553534pzk.21.1694796152771; 
 Fri, 15 Sep 2023 09:42:32 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] crypto: Provide clmul.h and host accel
Date: Fri, 15 Sep 2023 09:42:12 -0700
Message-Id: <20230915164231.123580-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-crypto-20230915

for you to fetch changes up to 055c99015a4ec3c608d0260592368adc604429ea:

  host/include/aarch64: Implement clmul.h (2023-09-15 13:57:00 +0000)

----------------------------------------------------------------
Unify implementation of carry-less multiply.
Accelerate carry-less multiply for 64x64->128.

----------------------------------------------------------------
Richard Henderson (19):
      crypto: Add generic 8-bit carry-less multiply routines
      target/arm: Use clmul_8* routines
      target/s390x: Use clmul_8* routines
      target/ppc: Use clmul_8* routines
      crypto: Add generic 16-bit carry-less multiply routines
      target/arm: Use clmul_16* routines
      target/s390x: Use clmul_16* routines
      target/ppc: Use clmul_16* routines
      crypto: Add generic 32-bit carry-less multiply routines
      target/arm: Use clmul_32* routines
      target/s390x: Use clmul_32* routines
      target/ppc: Use clmul_32* routines
      crypto: Add generic 64-bit carry-less multiply routine
      target/arm: Use clmul_64
      target/i386: Use clmul_64
      target/s390x: Use clmul_64
      target/ppc: Use clmul_64
      host/include/i386: Implement clmul.h
      host/include/aarch64: Implement clmul.h

 host/include/aarch64/host/cpuinfo.h      |   1 +
 host/include/aarch64/host/crypto/clmul.h |  41 +++++++
 host/include/generic/host/crypto/clmul.h |  15 +++
 host/include/i386/host/cpuinfo.h         |   1 +
 host/include/i386/host/crypto/clmul.h    |  29 +++++
 host/include/x86_64/host/crypto/clmul.h  |   1 +
 include/crypto/clmul.h                   |  83 ++++++++++++++
 include/qemu/cpuid.h                     |   3 +
 target/arm/tcg/vec_internal.h            |  11 --
 target/i386/ops_sse.h                    |  40 ++-----
 crypto/clmul.c                           | 111 ++++++++++++++++++
 target/arm/tcg/mve_helper.c              |  16 +--
 target/arm/tcg/vec_helper.c              | 102 ++---------------
 target/ppc/int_helper.c                  |  64 +++++------
 target/s390x/tcg/vec_int_helper.c        | 186 ++++++++++++++-----------------
 util/cpuinfo-aarch64.c                   |   4 +-
 util/cpuinfo-i386.c                      |   1 +
 crypto/meson.build                       |   9 +-
 18 files changed, 433 insertions(+), 285 deletions(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h
 create mode 100644 host/include/generic/host/crypto/clmul.h
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

