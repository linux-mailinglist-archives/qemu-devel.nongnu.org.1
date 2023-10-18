Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253E7CEC15
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0r-0003TL-8v; Wed, 18 Oct 2023 19:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0p-0003Q4-Oe
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0n-0000E4-V0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso4900255b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671896; x=1698276696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2V/cEN3iEL8v2gcE5+4KzPjOUIg628qXNKEjFRL6lo=;
 b=dcNeTyyinl42UfQoEVVCbVrnDGDH+Knl4ZKKqku8o+ZDniias41HH/Fs3iXxesEUkJ
 yuGLTZbDIhXySMlSt4NI2Aod2IFtsJGSRlEIRV/Ijhd6PgRLRde1Z910eohTyYfEIlX9
 yuNxGyBDOzebcGY9Qkerx/fLpJVFzYaoLugeqttkrkKoggudkpj1En6PfcZ1TNfaFanU
 7wa/3QwfhBvDZHD3LNu39t6r4aJMskNC7PkQJsiWkZRcOnXzn+dFXErjiczx5vq3XsVR
 MKLHJ70R+VpR8A+7hBVuW0AyvmDLkmFjTC4rm+S1Hd2ZRfiiZZ7yOm/D6k8NwE9lI61z
 yEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671896; x=1698276696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2V/cEN3iEL8v2gcE5+4KzPjOUIg628qXNKEjFRL6lo=;
 b=D5P1BNyLdVNiqR1HoVfhWLP8ONYxKlDcpLJJWjjhrp7tt/v2zgt4z32F9Ebghlvw6A
 wo69mRmiRpJUWLqnxDKLUXTIDZjq98snqaz5mx70kY1mj3jBof2i9Rw80aRl0/I+xci3
 8DhEX10vYwUn1iucatqYqPjRa4nGzvZNKPEpyfb+Ls1CvUj+ZXUCQ7YcTSmtljcPv/0F
 Ifm3GxBvzNBjBnA6s+LWE/aiYJWrdeb4W/f+w70YWdw9lHPYOTlQxz5tsyVyVLyLHt2E
 iufVLBxL/Hs0QiRPsCsaVZcynn8weLaoHfTN17MAxukNuQVVqED67KPJDLwgV7DhOJYG
 XjUA==
X-Gm-Message-State: AOJu0YyhNgUIkHTCVV2drdSODo9RVyIvpAfXUKtvZGlR3rwTEW2a+qEc
 yuteQs5pcFOAz/42TGvkwiebnXWjCvsNAE1ZHtE=
X-Google-Smtp-Source: AGHT+IEU9VS32Powc1zbqXpm7afPdJsr1kPconkZxtG11CDassQRLNCoTAV4ZsP0GRRGb3oB4bn9tQ==
X-Received: by 2002:aa7:8883:0:b0:6b1:bf32:4fb5 with SMTP id
 z3-20020aa78883000000b006b1bf324fb5mr514645pfe.28.1697671895531; 
 Wed, 18 Oct 2023 16:31:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] linux-user patch queue
Date: Wed, 18 Oct 2023 16:31:20 -0700
Message-Id: <20231018233134.1594292-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20231018

for you to fetch changes up to 38ee0a7dfb4b15407678df26448e4a18fd9a51d4:

  linux-user: Remap guest SIGABRT (2023-10-18 16:25:06 -0700)

----------------------------------------------------------------
linux-user/mips: fix abort on integer overflow
linux-user/sh4: Fix crashes on signal delivery
linux-user/loongarch: Enable LSX/LASX in HWCAP
linux-user: Fixes for zero_bss
linux-user: Propagate failure in mmap_reserve_or_unmap back to target_munmap
linux-user: Detect and report host crashes
linux-user: Remap guest SIGABRT

----------------------------------------------------------------
Helge Deller (1):
      linux-user: Detect and report host crashes

Jiajie Chen (1):
      linux-user/elfload: Enable LSX/LASX in HWCAP for LoongArch

Mikulas Patocka (2):
      linux-user/mips: fix abort on integer overflow
      linux-user/sh4: Fix crashes on signal delivery

Richard Henderson (10):
      linux-user: Fixes for zero_bss
      linux-user: Propagate failure in mmap_reserve_or_unmap back to target_munmap
      linux-user: Split out die_with_signal
      linux-user: Exit not abort in die_with_backtrace
      linux-user: Only register handlers for core_dump_signal by default
      linux-user: Map unsupported signals to an out-of-bounds value
      linux-user: Simplify signal_init
      linux-user: Split out host_sig{segv,bus}_handler
      linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP
      linux-user: Remap guest SIGABRT

 linux-user/elfload.c       |  61 ++++--
 linux-user/mips/cpu_loop.c |   4 +-
 linux-user/mmap.c          |  30 +--
 linux-user/sh4/signal.c    |   8 +
 linux-user/signal.c        | 459 ++++++++++++++++++++++++++++++---------------
 5 files changed, 379 insertions(+), 183 deletions(-)

