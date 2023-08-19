Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241B781632
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMG-0008Pb-AP; Fri, 18 Aug 2023 21:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMD-0008PG-7G
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMA-0007KV-Cl
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso11100265ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406940; x=1693011740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=StsXV2oQjsYMrk/IfkhJGMnUJ1DUHAkNVFqVcXqK7oM=;
 b=nb93tbUCyaPlVvSpiwSVa3sVqKDFF0hZur+BBqELcyGjGaJixyh03/4jjvA4Yzvv5B
 nfla+1cK2UPTwzwJLRkynxXb9zfUXVEVZ3y5AfESkYMf3M0PtnaxiuFQREbwi9ILSqI+
 UwSY75xk6+N9p+kTjgQZS5h2k0y2oXxEsIzs1uLB/Lp7v0kTJU/DMb9ArQhoTRyM2AQR
 SRr+AYnKfUz3hCE1MEdJ0iLcEgK11RCcojCaFEVksXktA1OgzyVcF1QHcuIm3yAldRHI
 r53xuMVz78B1WSDkKnyWII7p61nZPJjOq2lg1CqGwUPQaBAWPjwri4jt6GIbQfeF3AiK
 wsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406940; x=1693011740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StsXV2oQjsYMrk/IfkhJGMnUJ1DUHAkNVFqVcXqK7oM=;
 b=exR9YeNFVz4OJWIDMQd6BGLK45omCAN+uLLiwbtF8doc//Ly9rm3mNcpbhgRiINKG0
 OEhh7LEu3BusXOsDKASzLFzdsqHrQMCeZVoc6wICXUhJZIDjN+l6W4Mg3a6Ez5hqthqL
 oGY5LPin9kkhEQ77PkCrMxCuji99+dJJSnpHKuPxGYK9xRZG93tJA9KKQ5/zY4S7UC78
 H++eTL9nuThmAY/2kH8vH1vE9bkZipDFXaGeskiN6aPfvVGPSKipuO0MLmLpCx5RKR/h
 TH/10BOHcqQheSoDbN+7A3myqCvHGgic8YWRsYF47IQeiZMfjihS23cPg+cZI+0Ukt4e
 WuhQ==
X-Gm-Message-State: AOJu0YzOB1a+NOnLzU4ksQVw4ik/ZoqhTSEoFrXu4ZHTUzpkyDoikkg9
 9T+i3kI1pm3MDzBdpMqqNIttHkkDiu5eTovWq6k=
X-Google-Smtp-Source: AGHT+IHdVues/NA2SswKTK87qdX3DYKmR1xQmMjwMqemkTnt5qlX3zikPVjLbTE/hO5mtkbuwJbj/w==
X-Received: by 2002:a17:903:44f:b0:1bc:682a:b130 with SMTP id
 iw15-20020a170903044f00b001bc682ab130mr732711plb.27.1692406940314; 
 Fri, 18 Aug 2023 18:02:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 00/18] crypto: Provide clmul.h and host accel
Date: Fri, 18 Aug 2023 18:02:00 -0700
Message-Id: <20230819010218.192706-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Changes for v2:
  * Only accelerate clmul_64; keep generic helpers for other sizes.
  * Drop most of the Int128 interfaces, except for clmul_64.
  * Use the same acceleration format as aes-round.h.


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
 host/include/aarch64/host/crypto/clmul.h |  41 +++++
 host/include/generic/host/crypto/clmul.h |  15 ++
 host/include/i386/host/cpuinfo.h         |   1 +
 host/include/i386/host/crypto/clmul.h    |  29 ++++
 host/include/x86_64/host/crypto/clmul.h  |   1 +
 include/crypto/clmul.h                   |  83 ++++++++++
 include/qemu/cpuid.h                     |   3 +
 target/arm/tcg/vec_internal.h            |  11 --
 crypto/clmul.c                           | 112 ++++++++++++++
 target/arm/tcg/mve_helper.c              |  16 +-
 target/arm/tcg/vec_helper.c              | 102 ++-----------
 target/ppc/int_helper.c                  |  64 ++++----
 target/s390x/tcg/vec_int_helper.c        | 186 ++++++++++-------------
 util/cpuinfo-aarch64.c                   |   4 +-
 util/cpuinfo-i386.c                      |   1 +
 crypto/meson.build                       |   9 +-
 17 files changed, 425 insertions(+), 254 deletions(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h
 create mode 100644 host/include/generic/host/crypto/clmul.h
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h
 create mode 100644 include/crypto/clmul.h
 create mode 100644 crypto/clmul.c

-- 
2.34.1


