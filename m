Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A6782E3C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cM-0001Sn-9q; Mon, 21 Aug 2023 12:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cJ-0001SQ-L8
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:18:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cG-0005b2-UC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:18:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so21515775ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634735; x=1693239535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHMiMwBHsslwu2UbA08PFYRV0Sj70L/ui0QUiOTJCFY=;
 b=qgCrXprWvLh8adPiHHIlcFHUJIWONDqKL/mPesdkxqYFFj1TPWQJlZmpKJLrvfDHmH
 WBrDat8NSLhNekJxvcphIa9ToqLWcTjMlju8GnNq+6chUHX7ewei+1SeL6dPMCarICMU
 q6gVoX9kcqeTgURTzuS/PhDlaM01GczfYzcz/Qxm6rRHaiic8sRw6wdciB14QdEm8bvb
 AvvwQgGloiwY6VxuUAi38OCHsKafStatk1DuZnovxihQeuA0zUWYUbxA8oZP9wfaIzxQ
 tqbJggl0h+/Ah9uNc3RNmUlVx7cMyKmCFXISGqBme8tdKPcDsyOjjjYMEJvqRxPdPFmk
 ypug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634735; x=1693239535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHMiMwBHsslwu2UbA08PFYRV0Sj70L/ui0QUiOTJCFY=;
 b=VkVSlNggRJspxBqbZ+713fetg2js4CNszd3/UiytOY7H2oj7FyxNA6AScC3IhXqsLc
 B0QURQRePdkp/fD3e2v4Lt3Up2fkOvxcXVMSDiPVjgyvyZCipimX2lUN+OKN9mY3G1S9
 UVfHqTRzv+mYUzD1Ht/QaGB9d02nvBir9CqXkiSn/guLTGOiRsMf5Vq3zP20VGAgBHn7
 hrqWc9ewAR6V/Q4TirrJC4FLblgNXbmcEQNybBxVGE7KUYV7JlMbkXnH2RIJQpU+VcOO
 imntWp2RUr3WET8UTE9gz67PMNiOgr9TfAT27KD2IyxvP82MKSW/Ag0u7CJ7ZTPmuOlV
 0Mig==
X-Gm-Message-State: AOJu0YwnJjBKovSHH5HcT1TzhbiDTu9ynlUEgnEVFMe+5153ke/SPm2/
 rBzlM3vur/pGO8sY/sINMCbd6P5GxZCPlFteJwU=
X-Google-Smtp-Source: AGHT+IFKJm9teIsf7FzDnw0y9VNqeNS5merQYar3EhRpmxXjoHQeWA/x7K+xm+erhRJZmpwA9ydLJw==
X-Received: by 2002:a17:903:22c8:b0:1bd:f1a7:8285 with SMTP id
 y8-20020a17090322c800b001bdf1a78285mr6327673plg.1.1692634735401; 
 Mon, 21 Aug 2023 09:18:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:18:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 00/19] crypto: Provide clmul.h and host accel
Date: Mon, 21 Aug 2023 09:18:34 -0700
Message-Id: <20230821161854.419893-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
carry-less multiply under emulation.

Changes for v3:
  * Update target/i386 ops_sse.h.
  * Apply r-b.

Changes for v2:
  * Only accelerate clmul_64; keep generic helpers for other sizes.
  * Drop most of the Int128 interfaces, except for clmul_64.
  * Use the same acceleration format as aes-round.h.


r~


[1] https://patchew.org/QEMU/20230601123332.3297404-1-ardb@kernel.org/


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
 host/include/aarch64/host/crypto/clmul.h |  41 +++++
 host/include/generic/host/crypto/clmul.h |  15 ++
 host/include/i386/host/cpuinfo.h         |   1 +
 host/include/i386/host/crypto/clmul.h    |  29 ++++
 host/include/x86_64/host/crypto/clmul.h  |   1 +
 include/crypto/clmul.h                   |  83 ++++++++++
 include/qemu/cpuid.h                     |   3 +
 target/arm/tcg/vec_internal.h            |  11 --
 target/i386/ops_sse.h                    |  40 ++---
 crypto/clmul.c                           | 112 ++++++++++++++
 target/arm/tcg/mve_helper.c              |  16 +-
 target/arm/tcg/vec_helper.c              | 102 ++-----------
 target/ppc/int_helper.c                  |  64 ++++----
 target/s390x/tcg/vec_int_helper.c        | 186 ++++++++++-------------
 util/cpuinfo-aarch64.c                   |   4 +-
 util/cpuinfo-i386.c                      |   1 +
 crypto/meson.build                       |   9 +-
 18 files changed, 434 insertions(+), 285 deletions(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h
 create mode 100644 host/include/generic/host/crypto/clmul.h
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

-- 
2.34.1


