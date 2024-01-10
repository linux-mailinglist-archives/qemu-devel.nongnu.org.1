Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2B82A398
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:53:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgUj-0003WM-QP; Wed, 10 Jan 2024 16:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUi-0003Vn-1E
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:16 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNgUg-0005bN-6K
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:52:15 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78333ad3a17so147135685a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704923532; x=1705528332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4p8c+vfJoRRyQj9v97EkFmXpw6AYGkJaKiPXa9IouCI=;
 b=MReBrWZm1ii3auM5syUWjAESwQwwhOSAG+SdB+HHklxkbD0Q6nsB5gg5Ql/KQt9asQ
 oRAbSnmzEAEC9XpPhiB5Ar6Fu+yNMl1H3hTGMf5CRYe1AK6kB0pe4JTzywQoJha/5mci
 HJgwcI7AdVrJNNL9CG+O89B2+4uc3wDDYhpkbfwA2Wel7RvgYsP3qNq91Y7tZzwufhn5
 zaz7lvf0I/1GinWZCsskwdiW7s7ItrGE81bQR8uVkwODeDXOIvSzymMuTVFocM1IkdZl
 kn7eFuvd2JrdL+n24Q0Kp/xhPJQ/U1UabKo3wCyiq3ccJGXDnmOPbflr1jdxE0qUgk6B
 uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704923532; x=1705528332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4p8c+vfJoRRyQj9v97EkFmXpw6AYGkJaKiPXa9IouCI=;
 b=t2f6SQoyAJK/s+sERbVRtJ+zSziYTvMYe4wbO6JVLMS26PaiMaTIcXT2TjkBP/DLHr
 0SgFKmPsucIvFwdxr+sEQbDvTGj7VH7Sb8wRCfCX6vLa27AjEmmOR2/G0xWNb3SUuP9D
 qn0sHiIFhXtTcQq8wkVtlhbBqfAN3H+hdVgMumUtCoca6SRUpB9vJel000ltjqYs44nU
 PwveKU2LLoPXmwKSJURlm4RTI8/cOHPkyxeI7h1ahnBUl1yPTFRcY3SxQNSSgP2gd0yZ
 jOjb/Z9lAbGSYyN+MtWTI60N9FPXRoRrKAWRKONP1+tbdifb1Mn7CuSjFXu10e3PTUHg
 EUHw==
X-Gm-Message-State: AOJu0Yz8pMoyYk08GQ7cxX2KgH3iDf1bk2+vznhmBCN7ko8bBheD+WPh
 64SQ4NTdgLidbbq6i2RP45ApNnNovA47U8Nb9g8idhLjTie+1m0f
X-Google-Smtp-Source: AGHT+IGgAk6BWXI8HBFQ0bPWSrIsdUDvY5Nh2ckcB54Ma8euJ/u3yY2KvmipG59kKzA2AmpIEBx7mw==
X-Received: by 2002:a05:620a:22cd:b0:783:14b5:6569 with SMTP id
 o13-20020a05620a22cd00b0078314b56569mr283672qki.19.1704923532522; 
 Wed, 10 Jan 2024 13:52:12 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 z8-20020ae9c108000000b0078313c87609sm1888387qki.100.2024.01.10.13.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 13:52:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg patch queue
Date: Thu, 11 Jan 2024 08:52:00 +1100
Message-Id: <20240110215204.9353-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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

The following changes since commit 34eac35f893664eb8545b98142e23d9954722766:

  Merge tag 'pull-riscv-to-apply-20240110' of https://github.com/alistair23/qemu into staging (2024-01-10 11:41:56 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240111

for you to fetch changes up to 1d513e06d96697f44de4a1b85c6ff627c443e306:

  util: fix build with musl libc on ppc64le (2024-01-11 08:48:16 +1100)

----------------------------------------------------------------
tcg/i386: Use more 8-bit immediate forms for add, sub, or, xor
tcg/ppc: Use new registers for LQ destination
util: fix build with musl libc on ppc64le

----------------------------------------------------------------
Natanael Copa (1):
      util: fix build with musl libc on ppc64le

Paolo Bonzini (2):
      tcg/i386: convert add/sub of 128 to sub/add of -128
      tcg/i386: use 8-bit OR or XOR for unsigned 8-bit immediates

Richard Henderson (1):
      tcg/ppc: Use new registers for LQ destination

 tcg/ppc/tcg-target-con-set.h |  2 +-
 tcg/tcg.c                    | 21 ++++++++++++----
 util/cpuinfo-ppc.c           |  6 ++---
 tcg/i386/tcg-target.c.inc    | 60 +++++++++++++++++++++++++++++++++-----------
 tcg/ppc/tcg-target.c.inc     |  3 ++-
 5 files changed, 67 insertions(+), 25 deletions(-)

