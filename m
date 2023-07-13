Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A1C752BE7
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eC-0000H0-1C; Thu, 13 Jul 2023 17:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eA-0000Go-B8
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3e8-00015j-DR
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-315adee6ac8so1320124f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282882; x=1691874882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d+9R5NyTIFI6KqlmcxMZxFnF7d0GQBj40E/YXtuiUsM=;
 b=Q3+N6eTPU0sbzDAT8CwABIMU8zq+USkeQhxnHUe4WMVd9YzJmoExPWZ+ZDda8QxBra
 aNdXSiEB6ew3ilYnuYi1YBtte9S+tlFi4vknh4zjI2Pyg28k1OzYCmxyx0q2ovnnLf6V
 GAL1CUMrammiXqEGk9AAZ/Imu5ldIu0itLHK9f2J6P8XcKb9bQ87uFDWyccXPcXuSemS
 1iv6QhJwtB6O2GJbizFgBw/Z3IgNVtQ8auRVfzHiryA0peh1fopGWv6yPCNgV1Z04Pkf
 DF5RceSqwUoJ6hVeVlxLqgkxJgDjh602zyKGPnQYkxop9Iwnks357NRj8/gHqoASqKua
 UfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282882; x=1691874882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+9R5NyTIFI6KqlmcxMZxFnF7d0GQBj40E/YXtuiUsM=;
 b=DfeK/aCdgLQ4DA/Ms1ROBO6s7/AGah/5nVz1Z80oUWIxYSrNYQhhd71HhJ18UyBH1o
 Ib58Xq5Iz6RjoIE1HztDHNBL5Emfc/26uPLCNJJVLCObI8S9OVYu3Gt+VG9xF+pZWXqy
 fpLblZX/xlL7YBYurJ81+uc7cVdzMS8HRvoq3xXx7mdu2EcITGm/Ggl32hVokvo1HZV4
 1433wrJrY3lxsGzxTmA8ezDoBlSK1zYXrd3/j+gF4CVzvO2JSpWnynB8I/rBjSnb7c3J
 wq36MAfmLutLtCXB+iCFQVMOyrD8piG8kfOruanluGhDIwmYEs5cahKJSwbvfJIu9Sb3
 YQ3Q==
X-Gm-Message-State: ABy/qLbnHU55VwPX0zDT9nQ5/1CxhbEsxcG+uTJ+zUWhds9N8BXov/Ai
 pI7BzQC7uJKHDTG57NTVmIxLlvfhgNz4IV9mePuGb6CW
X-Google-Smtp-Source: APBJJlHb5et0L9wVfG8B8KVUr/QKPTnzZQ2l9fd0hBUHobpgp0FhCHzWYGqx1YC/P5q+6c/pmTXsqw==
X-Received: by 2002:a5d:5304:0:b0:314:de6:3200 with SMTP id
 e4-20020a5d5304000000b003140de63200mr2577210wrv.41.1689282882101; 
 Thu, 13 Jul 2023 14:14:42 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [RFC PATCH for-8.2 00/18] crypto: Provide clmul.h and host accel
Date: Thu, 13 Jul 2023 22:14:17 +0100
Message-Id: <20230713211435.13505-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

Inspired by Ard Biesheuvel's RFC patches [1] for accelerating
carry-less multiply under emulation.

This is less polished than the AES patch set:

(1) Should I split HAVE_CLMUL_ACCEL into per-width HAVE_CLMUL{N}_ACCEL?
    The "_generic" and "_accel" split is different from aes-round.h
    because of the difference in support for different widths, and it
    means that each host accel has more boilerplate.

(2) Should I bother trying to accelerate anything other than 64x64->128?
    That seems to be the one that GSM really wants anyway.  I'd keep all
    of the sizes implemented generically, since that centralizes the 3
    target implementations.

(3) The use of Int128 isn't fantastic -- better would be a vector type,
    though that has its own special problems for ppc64le (see the
    endianness hoops within aes-round.h).  Perhaps leave things in
    env memory, like I was mostly able to do with AES?

(4) No guest test case(s).


r~


[1] https://patchew.org/QEMU/20230601123332.3297404-1-ardb@kernel.org/

Richard Henderson (18):
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
  target/s390x: Use clmul_64
  target/ppc: Use clmul_64
  host/include/i386: Implement clmul.h
  host/include/aarch64: Implement clmul.h

 host/include/aarch64/host/cpuinfo.h      |   1 +
 host/include/aarch64/host/crypto/clmul.h | 230 +++++++++++++++++++++++
 host/include/generic/host/crypto/clmul.h |  28 +++
 host/include/i386/host/cpuinfo.h         |   1 +
 host/include/i386/host/crypto/clmul.h    | 187 ++++++++++++++++++
 host/include/x86_64/host/crypto/clmul.h  |   1 +
 include/crypto/clmul.h                   | 123 ++++++++++++
 target/arm/tcg/vec_internal.h            |  11 --
 crypto/clmul.c                           | 163 ++++++++++++++++
 target/arm/tcg/mve_helper.c              |  16 +-
 target/arm/tcg/vec_helper.c              | 112 ++---------
 target/ppc/int_helper.c                  |  63 +++----
 target/s390x/tcg/vec_int_helper.c        | 175 +++++++----------
 util/cpuinfo-aarch64.c                   |   4 +-
 util/cpuinfo-i386.c                      |   1 +
 crypto/meson.build                       |   9 +-
 16 files changed, 865 insertions(+), 260 deletions(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h
 create mode 100644 host/include/generic/host/crypto/clmul.h
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

-- 
2.34.1


